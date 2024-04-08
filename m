Return-Path: <linux-kernel+bounces-135439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1489C2B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444111C21A09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C752B81AC9;
	Mon,  8 Apr 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPGJN5Tg"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182A481A6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582979; cv=none; b=euJJOFJQdjzJqRalAsGVDfmjmJBBMHWW9FsoZbF9jml2e1FqP1IhePjhmzA4T9YCg4wuL0Ns+vV1LCfKjG06tiX4hxw35CRiB84K4tTCCI32Yyv8rUAUkbk749jGcxTd450EANDrghIJmsEeQ8lwwoLvWz6jZ5QEobo/Kcs2+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582979; c=relaxed/simple;
	bh=nLwkBY0IJdp7WkhBU1xBNDsEWrWcIRH6GKAATVBg19Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oH80l1vAvAvpBj0462VOjsdycqO/Nrj/hohRGK7JFxbtXsFCkLDydzGiwSMmU4exmJxcLfEG5UV5SOxblF/s8YwwSG0ni76HqxfKDdo1n73dIt9v1DCYrCt8DhvyVn1o1+Y7+0jWJWBe8fdY5ryEDD72UznspHWJ5cZrfVYkyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPGJN5Tg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a450bedffdfso626992566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712582975; x=1713187775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4YPJ3fd+qPCCn4IIp6HubRp71Poa96GQ8D6SPvhLItM=;
        b=XPGJN5TgqGc/a3s3BU1xLe91YvBpcXXM5fX1/0/MLf2koXbatzo7WugPxmvUhmiJui
         6t50OgTIUWqzl9O/qi+3muOYSOkOd1GzmkqtsE+PjwJtPMk1IDRAYE0GpztQHdizgITZ
         NyfT7PR835kvC3z3dGEOVg693rZdvWggD2QBJgJf8Mf9VDVyi/MbJHaTl5jNsSBFc6zv
         JsGPe+7qhe6UINgZQdHG6+bg04ioT7fZDQ0pwTJby1m66ZEiue4OGxgdCYno/q/CQJcX
         /DkRLoPLAtkqqTxSnRIcfEt78ydgc1pI3yHyWU3Y2YNeOYf9OF3gj0ig5pvb1s1kc4M7
         +bRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712582975; x=1713187775;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YPJ3fd+qPCCn4IIp6HubRp71Poa96GQ8D6SPvhLItM=;
        b=GGgDZI2DaGMHpPIUUJg3aoT7j6GMikfJ/ObPeIQ3CsrnS76FYkFs8gIlgiu/yc2vCc
         lkyBUrOETH6iO6d39AsYGmLoSILmVBj2dmlHt/a4AUA7+wTMlbN69518/kRNF+j3ECmE
         IgjlAhjv84zqN2811jCkHuHpkOr8Wk0E6TIahgJUnELlks4RWzdwUa2hhp15IEp7Bog/
         uN2/Kh6QkZOiGTOrhdvw16Ka5FmgfdOLGgViq9e/ncvsTDZaNxuONgLXio4irHY/5gVU
         UWCsBeoiukI0QKbKHoZxG5rYQRKLMeIkkurywZFDyjAu8n0aCQjSrloHhHMY+172zckm
         Ui+g==
X-Forwarded-Encrypted: i=1; AJvYcCWdwT7y0YhXJRgere+kuniSXqlpVyoRjghXRcJeJqWSYiGY8hR0n31HT+4icZWGilLKXJJZd1e4CR7YC/Pd4Sq0MIa2tzeXMVn1K3aQ
X-Gm-Message-State: AOJu0Yy8/A+gcs70NtKAFF8/u3kBIINaKRQ6T50CMEIFusRS2U9XS60r
	VXubxdsKV6ttG0O5ODiLCkxM7IqJr25P6x92/fk88MX1lxnxckac5S5+OjsBPG8=
X-Google-Smtp-Source: AGHT+IE2D86+FJty6CUm61puzTNbI8iTEjNlZL2b2nSLyfWkOLFTEQ+P/TySdQeQ+ByDSLq8GhnEbw==
X-Received: by 2002:a17:907:2d91:b0:a51:b008:dc66 with SMTP id gt17-20020a1709072d9100b00a51b008dc66mr6768484ejc.0.1712582975487;
        Mon, 08 Apr 2024 06:29:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id dm14-20020a170907948e00b00a4e24d259edsm4389646ejc.167.2024.04.08.06.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 06:29:34 -0700 (PDT)
Message-ID: <e9cef5dd-c4fc-43c0-839b-d311d87a28ca@linaro.org>
Date: Mon, 8 Apr 2024 15:29:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: btnxpuart: Add
 firmware-name property
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
 luiz.dentz@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com
References: <20240408132241.750792-1-neeraj.sanjaykale@nxp.com>
 <20240408132241.750792-2-neeraj.sanjaykale@nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240408132241.750792-2-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 15:22, Neeraj Sanjay Kale wrote:
> This adds a new optional device tree property called firware-name.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

BTW, there is no such device as btnxpuart. Bindings are for hardware.
With corrected subject:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> ---
> v2: Add maxItems, simplify description, remove "nxp/". (Krzysztof)
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> index f01a3988538c..6774cc4d6a9e 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> @@ -31,6 +31,11 @@ properties:
>        This property depends on the module vendor's
>        configuration.
>  
> +  firmware-name:
> +    maxItems: 1
> +    description:
> +      Specify firmware file name.

Drop description, redundant. You did not say anything different than
property is saying already.


Best regards,
Krzysztof


