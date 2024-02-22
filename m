Return-Path: <linux-kernel+bounces-76914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6BE85FE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF13A1F21BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39971154C0A;
	Thu, 22 Feb 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAJqVGEp"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDAE153BC9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620978; cv=none; b=kc+7gGXQJLW1XxgDRpAaoTWV1+8atOGJpzMp7W2av5vBsas/0HgZY+JBvLWh5/k6qlST0GfTV1W/9c75KyITdsiFVpHpdTigxUUXE4e0OHpfmrNZs6LXqerPNq2Gwjh2nyrib2qaxbm/c2p+443Rt7akSdgeOIJdquSr8iXcoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620978; c=relaxed/simple;
	bh=6U8FqSStYOT271wkS485Zv6xwQyu21sm+mXhN1q6qsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHpdrEZS9frqQVbiFMSvx/IMXqgkJGxlbn9N68+IsCDjhw3gidu20VTGT1naUgYf71eRM/GwbQPYlTQBYT7G9KByjIk2cScjGYXTCKBxoUSOFSqJVFb0WLDX5ckIxCN3595wiunM7AqlzonBaZTc32OaR49cdz1yOGUpXQDEeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NAJqVGEp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso8355911a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708620975; x=1709225775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbGLEGj2VKNYhB6nINNs2mbku43zUpKeqKkEauZl/Ug=;
        b=NAJqVGEpwD7ipUarennQunNk/f/myivGQV3wl6MlgMi8jRXZIFBBbcSRVuFF+Wby/r
         3a10YVRfdZo2SuWma72ppWGIjXCZb3AMqXnqyG6i3odPzZlbeaL/lZ4Z0yioNui2mA+T
         fUSbW6LwFf/Q1n82i4sgZvf2Y3rr1VEtVTUkcm7gqgJQR9L4tMU70dywzh7H5OkH+W3s
         MfivyV8+8bOcGixTT7Yu7lDx2PLUaSgZhlopa2PagCcBVZvfC/AiVd6BUAGm3BLYG0EU
         6o+DU+Sh94bEAJNsHrTT4/7wzBcIp9mmO/bsCufcr45Iqud6y7mbYmO6Dlp0kas1XTYd
         xKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620975; x=1709225775;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbGLEGj2VKNYhB6nINNs2mbku43zUpKeqKkEauZl/Ug=;
        b=mtSEfTmWlauttVg+mO7RzFhqjDvej0chi/KAP1kHx5xtpLKcLQAN0Du6ZU3Jh61qAl
         vL/3bSxyqc3q6j/DOJMqs2fQSAZL9EdpNViqAJEfQeBdk+IQCemx2eMaGofopH/BZHfy
         01+Oj0wHw35KU2nljrqdfea396pK0lYXt76L0SdCfWdnVSXOkoEPXeHMfTZRB2vI28kf
         J0uFKpfzpHXtmVOSbnBmB4MXLVRWnQIri2ahBPAm8fGrRO8kbn11sUHbkEGy5AH0Bxf3
         sYPj4lA91Eev5/9KxstpbTlMXYiaz+bkAMJi7aOez45e8+IuIcPmHCnBhMsu8BCVCe+h
         lEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9EFo8LwY1TL6/7MzsxyFaM42nJgkD5UYzyn+e8+PRHD2ONLHXERkGOPlpk0YD4zzkZ1mQzrBjueCBLGx27itAXnR9YS2BG6vPeG78
X-Gm-Message-State: AOJu0Yw5FjbZlauSsPdxgL6F7rvXYX5aL0kne8/e7LPrsqazrkEhu0tY
	GIOlHB2W3dY8v0fQdxsoJr7MIg1k/Gmw2veNJkriv9JZcT9ecaoKfjltuBljKTw=
X-Google-Smtp-Source: AGHT+IEOQmypuUZMeFnuW3n73xNV08zfVTDxnusdbGbhxlS9yk1AakJwIzoPoOqH07uohT8/2CJJgw==
X-Received: by 2002:aa7:ca45:0:b0:565:35a9:ca03 with SMTP id j5-20020aa7ca45000000b0056535a9ca03mr1751168edt.17.1708620974914;
        Thu, 22 Feb 2024 08:56:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id h14-20020a056402094e00b005644221a3desm4779979edz.3.2024.02.22.08.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:56:14 -0800 (PST)
Message-ID: <838ed10f-7f0a-48e8-a195-a155e4766f49@linaro.org>
Date: Thu, 22 Feb 2024 17:56:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: analogix,anx7411: drop redundant
 connector properties
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20240222082819.10321-1-krzysztof.kozlowski@linaro.org>
 <20240222-election-doorstop-8c179803c47e@spud>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240222-election-doorstop-8c179803c47e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 17:08, Conor Dooley wrote:
> On Thu, Feb 22, 2024 at 09:28:19AM +0100, Krzysztof Kozlowski wrote:
>> The binding references usb-connector.yaml schema, which lists all
>> allowed properties and ends with unevaluatedProperties:false, so we can
>> simplify analogix,anx7411 binding by dropping everything covered by
>> usb-connector.yaml.
>>
>> Suggested-by: Pavel Machek <pavel@ucw.cz>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../devicetree/bindings/usb/analogix,anx7411.yaml   | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
>> index e4d893369d57..3f5857aee3b0 100644
>> --- a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
>> +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
>> @@ -23,24 +23,11 @@ properties:
>>    connector:
>>      type: object
>>      $ref: ../connector/usb-connector.yaml
>> -    unevaluatedProperties: false
> 
> The connector schema sets `additionalProperties: true`. Is removing this
> correct?
> 

I think you look at some old version:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/connector/usb-connector.yaml?h=v6.8-rc5#n327

Best regards,
Krzysztof


