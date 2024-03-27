Return-Path: <linux-kernel+bounces-120564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E688D966
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209192959A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867D336AEE;
	Wed, 27 Mar 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fiBW8ccN"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393E2D059
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529067; cv=none; b=BxzQmarlxXrtiIbqaQeE8qMg01mRPk1YlQtxrzKKfu4tH7uytpn6e5ug+cd+6F+OFll8YPCBXmXZLwjOGEkKlimiwYrOc9NE1HN2ZaMnUULvKiugjBhv4CTq1X4v5HI+V1KxsRYOgiD+Diu3KjHN+4udC8h3niGJmw1ZGBlLcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529067; c=relaxed/simple;
	bh=5jgLagnXQ6xhAkEIJNUbHLhU7RMCem4VEiLbv9YJlRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+fBk09KTa6mcXelwCfigSdQ0spim3kdOUDN2k9idjSGdhCpi7b2xfF9JVKjiZ/eF9utgBHb6pPJWj20LQNGKiA0mF0DWa3iD8ejFp+20Itv8EoIfPbOLif8k/ACor0gUUu+OOhw4ZFPNBTOaswkLu2wTb2w5E73/O18ln++O9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fiBW8ccN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e0a65f37bso21434066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711529064; x=1712133864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rFw5oadwcyNPA68+IoBOiw7o2WmetNa9KlFx7gAlFDI=;
        b=fiBW8ccNTHG4mf/VZ6LuIhIF1ytsAXzaK9vh1+FZZYs3iek4jRIJ3Zsz+OrEee3/3d
         Oh26ZMp79eEMTn1FBIGSm3R0GnpN3Xu8z05CImFqjjzVAJ0JshA8hkvExgI/GDVR3DlQ
         HxHfZ0KKciw9FrRpADs/JcvznE9uuu7n3UzES5pQgydkMYkYcqMBSVJ9VCy0vWSBnmWc
         19+0dYerF1788VcWf++thzeMN6XXx1TtiUlW6habOsPcxhGsNTU5ryFztitFo7v1Q1NQ
         UFDhCujoF3Iq5ObXku/eQlYEwQ8hT1vF/6jRzZNGLihcLh6Yqfpi8osR1SOtwSxF4jU6
         ESlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529064; x=1712133864;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFw5oadwcyNPA68+IoBOiw7o2WmetNa9KlFx7gAlFDI=;
        b=qpjl28aV6XIM329lRCtQt9yFHmeMZQHgjcyMGLXraI5y0eNXh7E1mKYRXlKSOk2wSd
         0YcsadYyQoBx4ChtL0rHdQm2/KXcsX/gjWq/teAPEv0Y34kzzMqx265gpOfy57yTa9g0
         hL4zm8fGo4IJdSt+fA2h/sx9mYBhITr3pipTNLDJgEZcfHS52wTgPJLJwglc/cDTp5zY
         tpIlsU/eZqVR92khljEXN/9cZtemD6q68uE66Q7XAUexD3t2b6f3ZCxI9hxR5xJCcvzd
         fYWj6vYhEtdHqdoIxhwYvs1Q+kzhlHEbj1EeKt955+TvcqesehE8bgyIP0EaPL9573Kl
         fz2A==
X-Forwarded-Encrypted: i=1; AJvYcCVl2axT8yVSvgqvF/sVVCT8sgb8GspNRWo6t/+a8zlo9lTFKDQbrFMd4aszZY9lxG38fIlrM6OCOR+4iiCTszb9pa32XW0KIh5WZdOc
X-Gm-Message-State: AOJu0Ywvud1IEldmTB5wDFXtZkr4f6aSpCqe79Mmny3ZVeCz7s9ldqbM
	yAhkR4AL52OrN+iEAfFkbcKZh8dA5OB9LM7B0S38Cc80Fk65fmFqJYKARH1/zmA=
X-Google-Smtp-Source: AGHT+IGCW+el7emQ1/+oO1zg6ptwcHdw8/EJLjhWGE+dnvBCHkRrn/RhO1OxEXI/8C2Qt3RPc5EAZA==
X-Received: by 2002:a17:906:798:b0:a4a:3441:2e2a with SMTP id l24-20020a170906079800b00a4a34412e2amr440215ejc.55.1711529064259;
        Wed, 27 Mar 2024 01:44:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906119300b00a4660b63502sm5196946eja.12.2024.03.27.01.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:44:23 -0700 (PDT)
Message-ID: <73e5a697-2eb4-45d3-84eb-60401ea10cc1@linaro.org>
Date: Wed, 27 Mar 2024 09:44:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Odelu Kukatla <quic_okukatla@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-2-quic_okukatla@quicinc.com>
 <d59896bb-a559-4013-a615-37bb43278b2e@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d59896bb-a559-4013-a615-37bb43278b2e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 21:56, Konrad Dybcio wrote:
> On 25.03.2024 7:16 PM, Odelu Kukatla wrote:
>> It adds QoS support for QNOC device and includes support for
>> configuring priority, priority forward disable, urgency forwarding.
>> This helps in priortizing the traffic originating from different
>> interconnect masters at NoC(Network On Chip).
>>
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
> 
> [...]
> 
>>  
>> +	if (desc->config) {
>> +		struct resource *res;
>> +		void __iomem *base;
>> +
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +		if (!res)
>> +			goto skip_qos_config;
>> +
>> +		base = devm_ioremap_resource(dev, res);
> 
> You were asked to substitute this call like 3 times already..
> 
> devm_platform_get_and_ioremap_resource
> 
> or even better, devm_platform_ioremap_resource

Yeah, I wonder what else from my feedback got ignored :(


Best regards,
Krzysztof


