Return-Path: <linux-kernel+bounces-96616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A432875EF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC481C2138B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECCA5026F;
	Fri,  8 Mar 2024 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6HfT87B"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609142C0B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884866; cv=none; b=eEv30MyJ6coauheLWzZ+Xn5NqWf1wYepK3boogCYhBayVLSEPIQxv+ZK9sANjLv6sDTUifPxoYTEVTO/SHsz9FaHAFln3tt5YpBsElydcBko8z6ZFDuEhMVN7RvOOC170FyFZe9ClDkV3RSHk7ceTgkJz4Y6NYpWam1HMnzuMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884866; c=relaxed/simple;
	bh=9/E1gW/SWS68aIKtjqsfQSsNgTvf9eEGWH8xjEhS73E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyetJTDo28s992gBnDiyclcb9Hw4v0dqaEus4iH16GUdYA/hfCvdAP2ml5eE4N36k+rmeyccbyTYPq2RluHlzBHQ1ll4njGLscJUAS5eWWLDUEv3iroZtuy/CAGrZjffcDAFmzPi5LgACYVJf3P4w2Bp3oqsiJLPh5nPGnc6Mug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z6HfT87B; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28a6cef709so81302566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 00:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709884863; x=1710489663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rd6ySLdCnQAD/erbhy9b4z1gT//LzMF/P+/70cDzp2w=;
        b=z6HfT87BbotWVC5dJ90cTDG/OAnqR4488M4cmshBXQnEFpSIospgjW5BkkOnms9qL0
         Ve+/tMxvwz8LPcHGQFJhCKaZqkj0dD3RY2+LTAZzBhnY4ud8F8uW84lRbyoBrbHL85bZ
         bouzIQ1M7tIieUhkRCBvS5w4+nZeJ8HHw5cWGwodSGrHzeO+yz5X1ztU6FZmTXO/3CnW
         skA4zBCLpr+GUuK7nXvv9R3oWZoFabu1Mr4lni5XQoi00jkL8vQfEj6h6AA56dotL+1O
         HY9lU1QEs6TzkvlksGXqzY3X/+/+sMaqJY2MNI7fRObGag85xB18UdZlTRJSsVP478HI
         jSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709884863; x=1710489663;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rd6ySLdCnQAD/erbhy9b4z1gT//LzMF/P+/70cDzp2w=;
        b=XCzaFdpOEBNasWqvCQ0xi2eNhn+LX28txEtdlcdp0l4P+MtoOO4WF/k/mA47iNYrGN
         SbkIGcjns/7ba+bbkPwbkseVrI5whXCUqd0dWiJVhaDg4uP+GC+Y/vx3M5trhmvsJ0KR
         KHI9Q4PZzIMIKDuqCpI54xtCBKdfsdKc6rZxLo6KsbL1tpXIS4Mnm3/eMcoXwcY6JVTq
         j1kdlOpg9S4I7w0bwQsxcBupBFFs3LUvJh+FgowLY8BUJ1cU7kc1Zc8y7SEcEgb5xlH4
         B2Vo5VtZa7C3TMJtiSPt2nVdx5C4ud2yGa/9W1LeS/y13xBa/KL+klQZOIdGUFNwm58C
         VUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ5/xGzakvPAEeeh4rhC8QHXqfdvbCdIKLT5IOq50tbaEVDXVYlxPx9wvQGYs3RnAiZ4ptWvgEGVs/QDwrMuT6U1Dvx6O1TG/Bz344
X-Gm-Message-State: AOJu0YxDgNyjhXz3CbJWnHxoq3gWHJWkZR5gUcEfwUoEtmeTUVTXy2YU
	JH38CCjiUTwzu8YtT7IgTXaL1ShJHcVw+1zDOyTtXZcB6D0PM9Q0Dqre9Tmeho0=
X-Google-Smtp-Source: AGHT+IGQZvweC858vxwv32AOnkVgO7gX4S/BV/xaF72fZarb61+hc3hUifS5PpU3y06tEtTxcnWOLQ==
X-Received: by 2002:a17:906:f8d6:b0:a45:2e21:c779 with SMTP id lh22-20020a170906f8d600b00a452e21c779mr10297783ejb.4.1709884863166;
        Fri, 08 Mar 2024 00:01:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id g7-20020a17090670c700b00a45ad52d510sm3354833ejk.139.2024.03.08.00.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 00:01:02 -0800 (PST)
Message-ID: <272fcc64-a22c-4f19-8172-d1959276547e@linaro.org>
Date: Fri, 8 Mar 2024 09:01:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 6/9] dt-bindings: net: hisi-femac: add binding
 for Hi3798MV200 FEMAC core
Content-Language: en-US
To: forbidden405@outlook.com, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
 <20240307-net-v9-6-6e0cf3e6584d@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240307-net-v9-6-6e0cf3e6584d@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 12:34, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> HiSilicon FEMAC core is also found on Hi3798MV200 SoC. Document it in
> binding.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> 
> # Conflicts:
> #	Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml

Drop

> ---
>  Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> index 5cd2331668bc..4f8a07864eb4 100644
> --- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> +++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      enum:
>        - hisilicon,hi3516cv300-femac
> +      - hisilicon,hi3798mv200-femac

As I asked two or three or four times: please express compatibility
(oneOf, items). Your driver suggests that they are compatible. If they
are not compatible, mention it in commit msg, but so far it suggests
they are compatible.

Best regards,
Krzysztof


