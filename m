Return-Path: <linux-kernel+bounces-64788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB658542D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708771F270B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4F11198;
	Wed, 14 Feb 2024 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvn9rzcJ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551F8C06;
	Wed, 14 Feb 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892488; cv=none; b=FccsKJyeIn3A4Ys1nttgfghxh3b7/uTCV9GsB32LCBQDwhNdPt2OR+BDQfGgyZ5p0YUnz2Pm2/37aRJcF7Z3mtIpALrCKMq1k1U1rpRE74b8ZMi8fgc+Vrto868MTGAdTLZgdSy7H/7oqXXOCZpOxjRkp5x6doSxMUdkLEBbR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892488; c=relaxed/simple;
	bh=eEHPUbvHfD27bana0BRRHxvfB5Gt0cYRP8x1lbtuhM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGBD6wmXRIxCvAWMYjtu9pvD+iiJt3vBx3e2gNX33aARwwhBAl6A01gQJurYjO5912fpOJDFG1muTXGK9XUzLxKKgjkEhkP5Ep3GrY1rCi8hV2DggAk0w3v2HvfPCT5VDvf4A/Rj9kgI+9turjyLTz88UOJ1+pXx1oDyTB3/V88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvn9rzcJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-561f78f1ba1so1535828a12.0;
        Tue, 13 Feb 2024 22:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707892485; x=1708497285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvuFwE9JH8AL4WuwyCUWF595QEwuv9nlPeFYbel5Slw=;
        b=Cvn9rzcJIsoV4fGNTNgMbB1CUyG8+9v6ym28P/LP8AngLpcGOCw5tdM+GvWnJNfxdC
         Su5Ma0InYnH0ahXEbsGMxdkkqz6oQL8+0w2Mncozo/PDqVXr/rFRMxAD8LDpJlr6WPKu
         290V2e+96N8SCH+yf7DDjfV23cuQa4A6Y3FVk5DD8Nx7vrJeGlvzzvSMfgxiZ60jpko8
         1j2YuNB/FHuLGZ6ZU+ZygI5LxhdRn5KxJBb6iOCS2OyYaOyFiFeUzqDPCK+AHGukVUEa
         KKYIDAin9EhdSDgvAuk3KkDQKe++N9uOStR0IMpjW6UCPlfnxwdWfObsh2WpJFelOTrw
         UvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892485; x=1708497285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvuFwE9JH8AL4WuwyCUWF595QEwuv9nlPeFYbel5Slw=;
        b=GHhn0FZzukxmU8GLQNeUV9tM2BwnWAt/LzyIIjAq4PPFFZd6EUutQ2qNLbLOO9+CQ3
         djLTVULQQwRD9jD0+UAQJWaoielvXHF6+P2dS9C06srtySB4G7/P7nTxpNksGapY0MCI
         VaNSHcHGB90Larw/eEqF3GRssdXUMSILFJg8V3Tpb5/etDmjz4wGEtDBcVE26GQX95Uo
         5eDKjKFOB1tR9A2YbAKVPW1tD6J5K89dU0kJJjy9SvfplJWY14uMRj8eFcVhTs4RbMNR
         jcQA6pFu9Ym7rUkAM5y3cQQiOCnGyfnDgDDCHFxEdDuOAhRTqpApF2pyym0Ojd3CdwIf
         XPhg==
X-Forwarded-Encrypted: i=1; AJvYcCX4EgB2eXhQqsp03/NrH5/WXOWmTG6CeXnABRYvXSegQTXwwIRiqkJo1gN45OJegiws0lJaU2j/NSNcj8mTfjk0yOMEutqLwTs+vZJxu7t/8i6WOIQ74gcBq5LLsNfiPRq08XNXs4RGmOIgmmpKx8fZ+ZswA8+qC8Y1sLaYypTziqBjwQ==
X-Gm-Message-State: AOJu0YyFGcDjLcMNAayQl09TwPxIVeDGlXhS/1v7BgqdW/ORIwaS4fcV
	d32sYIoKLi95CUyF8ATjdLdv8zJXzcOMbWNIFMb6YS6ob+llyT8R
X-Google-Smtp-Source: AGHT+IHv+h8nilZZuuQrNuz2sPa7nTzeb5gGsJU/RCpp62Djtg8Tx7IBmD08B8kU0Zzb0q6Sou+1qg==
X-Received: by 2002:aa7:c54b:0:b0:560:c6a8:e7c8 with SMTP id s11-20020aa7c54b000000b00560c6a8e7c8mr1318865edr.10.1707892482532;
        Tue, 13 Feb 2024 22:34:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYZNO4JHkvDYTwsSttpiPIZ3L8seVIgzLVDNEi6Zky1po9/QSq3tFucI4ZDAcKsdb2s08oFBX9nr9gVXyygAgkdFhXGmu+bpBNO9iIOT/jceybNOvG36LbmiAgu7DPUb29/gh+3aunjo99O/DIxNvImO+H+qTtXRmkz0JxT9JCXP7827qqsbgr2pqEb7MZSBu6rFAe6ue+Lf9IpMNosN6WPbJWTQ4OrJUOlrr63vUVE0WsVsfDrrOhcqfv8KBoml2jGwJ0NS5rmjPi44u2ngb7Bqs+ixptzf6Jbbap3azFppHRMq/J63gCNyt+v4yscVk2z4HysH7KxyfFQLCKBDERK4iXKUE63sSnjiiAGgAw76THJ+xPDWGkN4ZY3k8BR/ysKil0eqM+8D0WT7N1nakLiiT28kSjIe0AR1aRUJa/Y7RRmmkxX2g3lAvlnLU8bSIZRgXWICT8CBCxTZubUCM+uGl5Etj7+1oYLkmBk38=
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id dh12-20020a0564021d2c00b00561970655bbsm3290214edb.4.2024.02.13.22.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 22:34:41 -0800 (PST)
Message-ID: <d4391868-ddcd-4f66-b539-28d245fa83df@gmail.com>
Date: Wed, 14 Feb 2024 07:34:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible for
 MT7988
To: Conor Dooley <conor@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <20240213-resource-evaluator-0754cfd5882d@spud>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240213-resource-evaluator-0754cfd5882d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.02.2024 19:18, Conor Dooley wrote:
> On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> MT7988 has on-SoC controller that can control up to 8 PWMs.
> 
> I see a binding and a dts patch, but no driver patch, how come?

I believe that to avoid cross-trees patchsets (which are sometimes
tricky for maintainers) there are two ways of submiting such changes:
1. dt-binding + driver; then (separately) DTS
2. dt-binding + DTS; then (separately) driver

I chose later in this case as my personal priority right now is to deal
with all MediaTek DTS files.

Is that wrong or unacceptable?


> Also, what makes this incompatibly different with the other devices in
> the binding, like the 8183?

It can control 8 PWMs unlike any other SoC block except for MT2712.
It uses different registers than MT2712 thought.


> Cheers,
> Conor.
> 
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
>> index 0fbe8a6469eb..a5c308801619 100644
>> --- a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
>> @@ -24,6 +24,7 @@ properties:
>>             - mediatek,mt7629-pwm
>>             - mediatek,mt7981-pwm
>>             - mediatek,mt7986-pwm
>> +          - mediatek,mt7988-pwm
>>             - mediatek,mt8183-pwm
>>             - mediatek,mt8365-pwm
>>             - mediatek,mt8516-pwm
>> -- 
>> 2.35.3
>>


