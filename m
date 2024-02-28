Return-Path: <linux-kernel+bounces-84623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09B86A91E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9441C216D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDCE25620;
	Wed, 28 Feb 2024 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSy/1zlo"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9525605
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106045; cv=none; b=tGIiFpArwyd/GJRxoqn1YaEdhMtzjvcE8Q7rNqOnUBlQWRgpNZPbo2yF0N/xemLzFTUT/gaW/ubvyZC0RlQuANKVROlJEk//osEdP1tCZKSqwRRhsISTB1xZ+OD0/cFLcE4LwRe81jrXXmWf8alzIfvajzvpAhOzjN9QZrPxiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106045; c=relaxed/simple;
	bh=Ow0R+FxYoFMnm3YxzVonOfsUL2Ysf3DvLdurSDOiEtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kx/uT6KhaKHPNfig5PI2zUDl4uaArXGZh59nz3YT5Gl5F8SbBfX+haI4LNy++vxE4endqrLepOQ+POpYghrGmDutmytQNNjWz9zsrKe/0muWBdrOalOpbkTxtnf5Yald3IUmlwik3Hp+sqYOYQZ+j4qksoWvTnHRQgOPpkIprVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eSy/1zlo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a26fa294e56so861309366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709106042; x=1709710842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BY3KNQvzdAETd1/Rth7U0NCFxv48x2qleoh4Hm/NO98=;
        b=eSy/1zloS4RLHYIVT2dXv/2NSnQmqs7V5cnqQhL446SXmznq45nJ8nvbI4UFB2o6B8
         jG17rKfI2DQ+8dmW/B9eVn2YqcUFX4Xrt82JmWhNchXJ0UWPdcpw5adP1awHcnlPV5vm
         QPPMi4inE07M1jtG1xOE+QXXs84656xBVHUiL1tAIeiSUE+5Inv2MqTAHnegaO/5ObOb
         O70r+tSdPXXVlp7FQNdS9+Wiz2ktO6jF63xQvrxcGAa8p87aLfjzmscusMaqwEVtRjln
         PEZqgwK9vPRkz+/PNPU+WKwG93EkRmG/V/U3M6FnUPZ55mQrDIYlCQlk8hnz0dZtycxs
         RuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106042; x=1709710842;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BY3KNQvzdAETd1/Rth7U0NCFxv48x2qleoh4Hm/NO98=;
        b=lHHX44Bw1oyO0mzCq8lrf7sV1/c5+OhdDYkK+v1RFZZS983JYaJ+ljDgbcCqgMdAEh
         JOcnH+/J+ss6nACgn6D4TfEzKPYxuDPCyUS4Q1xFAdHcXtcbbpiGLF47LrJyPe62sVZL
         a6rknK96Oa08tSEKbI3LPyH33EP5vLsjR2ytGyW8E6xHrmEeawB2ZgOMe389ZKa54RKy
         3SZvnalqfVCLOL0wFYNIx+k359bO/sLcfbDlC6JeFjsbqx567kNUHKzcBwlLaCYWJikH
         dY+7cLYhG54hSg/03CBDD+1+T/3wEYEm7MDQdgLV7sEwEK7eUgBVJSYcLXI2l9trBCJO
         KpwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcpMasH9jC/pb4opuo3bkMQaLWgNJUyMAyaDJsLLsb8Eusa310i4j0V1nZB4WaTTtvgndf2xALkPDVu9eeo6F6Gd9yjtDAJ06X3Dg0
X-Gm-Message-State: AOJu0Yy3DCAVPRfY8wpyp9YER9Csbxl0TwZkviiuS6d++O2z2dOCBL2x
	vkSbhlJdV4A+8KQXmT5nAS+/LFDng0g6WUXZtRpfkukAPzAQb9/mlleMjjaYmbU=
X-Google-Smtp-Source: AGHT+IHzpshRmwdSa4JhXNqcWsVlGERtlIhNejiFCqCU3gdDcUKYSaij0hlZij6CD7s02EUdyKuuSw==
X-Received: by 2002:a17:906:260d:b0:a3e:d2ea:ff5e with SMTP id h13-20020a170906260d00b00a3ed2eaff5emr9034970ejc.58.1709106041898;
        Tue, 27 Feb 2024 23:40:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id bx11-20020a170906a1cb00b00a3cfe376116sm1546860ejb.57.2024.02.27.23.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 23:40:41 -0800 (PST)
Message-ID: <7107d732-6bee-4c28-b317-c7a3adb909bd@linaro.org>
Date: Wed, 28 Feb 2024 08:40:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: dt-bindings: img,spdif-in: Convert to dtschema
Content-Language: en-US
To: Daniel Baluta <daniel.baluta@gmail.com>,
 =?UTF-8?Q?Javier_Garc=C3=ADa?= <javier.garcia.ta@udima.es>
Cc: daniel.baluta@nxp.com, broonie@kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Damien.Horsley" <Damien.Horsley@imgtec.com>
References: <20240227123602.258190-1-javier.garcia.ta@udima.es>
 <20240227160952.615291-1-javier.garcia.ta@udima.es>
 <CAEnQRZDY5Jfj6d008goccsWwwUuUuryw1s8xJH6EyGXEiqnovw@mail.gmail.com>
 <CAEnQRZAvqHfNYu+dYObJA=T7S_KfQMxB8TJGmdjK9Ea_FPrLOA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAEnQRZAvqHfNYu+dYObJA=T7S_KfQMxB8TJGmdjK9Ea_FPrLOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2024 17:29, Daniel Baluta wrote:
> On Tue, Feb 27, 2024 at 6:27 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>>
>> This looks much better than v1. Make sure you have addressed all
>> comments from the previous version
>> and add a short log under the scissor line explaining what you have changed.
>>
>> Few comments inline:
>>
>>
>> On Tue, Feb 27, 2024 at 6:13 PM Javier García <javier.garcia.ta@udima.es> wrote:
>>>
>>> Convert the Imagination Technologies SPDIF Input Controllerto DT schema.
>>>
>>> Signed-off-by: Javier García <javier.garcia.ta@udima.es>
>>> ---
>> ^ this is the scissor line. Here you add the change log.
>>
>> Changes since v1:
>> - re-written the subject inline to include relevant prefix
>> - removed header file as it is not used
>> - ....etc
>>
>>
>>> +$id: http://devicetree.org/schemas/sound/img,spdif-in.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Imagination Technologies SPDIF Input Controller
>>> +
>>> +maintainers:
>>> +  - Liam Girdwood <lgirdwood@gmail.com>
>>> +  - Mark Brown <broonie@kernel.org>
>>
>> Please do not blindly add people here. The most proper candidate for this
>> is the people who wrote the original file.
>>
>> Using git log we can find Damien.Horsley <Damien.Horsley@imgtec.com>
> 
> Looks like this address bounced back.
> 
> @Krzysztof Kozlowski @Mark Brown is it OK to add a mailing list as
> maintainer for a yml file?

Yeah, works as a last resort, when we cannot find any responsible person.

Best regards,
Krzysztof


