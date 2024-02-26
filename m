Return-Path: <linux-kernel+bounces-81635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635AB867891
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19576288C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6608112BE88;
	Mon, 26 Feb 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv6/2o7V"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D64C70;
	Mon, 26 Feb 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957877; cv=none; b=lfM3sAmXz6tpGWMRVQ0K+vgn0ccke2Pk3cjb/IwJ/Rh/2Le3H7H1O+vxjiFvpkBVgX+nGaTJq9/wp6okEdcRwb+DithMd9jnNKps2pv5ucOjuByce6MSlK3CbpkI86oXw2VV+CSnMNPrKYr1+7h+c3fBQ7TG8f2nXUY9Hbmj7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957877; c=relaxed/simple;
	bh=cJT2DX6qZTAJQvVvn+j2hEoIyZTT0t/G+xkC6QYj65o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOBie/NJuyhheOEJ0GvPVxBzDkvuxSkfZmUWLU5ijJqhhdqbaDyJq/FbTuuZiYoqHKxYJOu8cv50PArfRgfAwbtRJYKQm7zMGyUO503Y+CYocPFZLKNknmYVZFmHiuSD3tlqpSaEH7FxSH0wzPsipRpXZL2xYoL1OuRQKoyIlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jv6/2o7V; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e4f569f326so1150658b3a.2;
        Mon, 26 Feb 2024 06:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708957875; x=1709562675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LWWuiJoTDaQBVsd81KE3QCvkjLb2V6msKrjw0bQgEd0=;
        b=jv6/2o7VYPJY4hU56wNVTUAPwmkx9jJlwcG45MteekqiLj55IgfrSHJL2Raf4s3v/H
         +RjGRBvFGrthEJJeb52asKP5NZBVem+mOyAqr8xJAmo/rqPbfjX8JBwszud2KzTARZRk
         yhBh36BAey9mE0qvpXmbA7sdlGMAxvDZ/9eKDGNpc5rC9RgkwITwm56ktRsii770fa2r
         MCoJ/poRXiY6YgiUmj+FeAy0kQBb5Nxi6yBz/HnRfXAM/HBTg42ZO0I43JIyf7xqwb4n
         F6D7WKlIPtp+L9/bu3BHv/ijfhRAufGISVg4ojt/XrpUqaM62n40aBJCnFnKuQZPOXkX
         DriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957875; x=1709562675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWWuiJoTDaQBVsd81KE3QCvkjLb2V6msKrjw0bQgEd0=;
        b=Mz8utyiP75wqkZ+M4Y9sGB7/pdteMgZrTzbCHroHHr2RRALxi9/pknl7lz6PXR81Kv
         l42syMj2MV8VyONFsb+OTagvPJHrLMt8O4hN8qkxRjm7TsIvpbCbvrjuP5XnUjQ+pfXe
         tcqkSlXLq4SX4S/WmW9wLwYfuF2mMK4FKMEK5t8IQ+zbQP1RyWVwVyHYufM93+zP4Glm
         vCh75GAVB7MhEdGw55R88NI/JmoPOjIc8ZqSvHSVRKv65TYgr4PVjdZMHHhuXkk4C7eH
         QFJJxz15yNwLLyO8sRoJTIBocI2vbnMLrssfYGLGbmEA3qWA/zwniPAKIPvP45kOhqFC
         1pPw==
X-Forwarded-Encrypted: i=1; AJvYcCVCBT+TMm6iamY5digYyE0+xk/lZWCIj5SoTdXwtJw6jsjZz0M/H9dsKtS/yZaXMyJWa8ol0iK6b3cSevHG3pzHnTjMdbr8uK2Os/71VDNN1Qqhxc5vndqWqQh7TOHoaNtiGd8xvKBXxA==
X-Gm-Message-State: AOJu0YzxrpqjhAeYY4Ckj5f3Vxtivxtg8/QV+6QAtAofxeZSjRgIhqwA
	uyFzBwwIrgjcFhEq4y7rWnLOBdYy+6USE4Mu83OXMLKC856UL7ip
X-Google-Smtp-Source: AGHT+IFqyi3o6xHZkdxbBtLmmrIbIjgmkd3NDPjnXdABZL53amIBVS9EAjjWzBiDxTZ/1NmSAKrTDA==
X-Received: by 2002:a05:6a21:3183:b0:1a0:ea31:c34f with SMTP id za3-20020a056a21318300b001a0ea31c34fmr9507014pzb.38.1708957875058;
        Mon, 26 Feb 2024 06:31:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a402000000b005e45b337b34sm4028346pgf.0.2024.02.26.06.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 06:31:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <da20a51f-bf6a-466a-b4ab-401f831182c3@roeck-us.net>
Date: Mon, 26 Feb 2024 06:31:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: aspeed: ahe50dc: Update lm25066 regulator name
Content-Language: en-US
To: Zev Weiss <zev@bewilderbeest.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240226091754.16027-2-zev@bewilderbeest.net>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240226091754.16027-2-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 01:17, Zev Weiss wrote:
> A recent change to the lm25066 driver changed the name of its
> regulator from vout0 to vout; device-tree users of lm25066's regulator
> functionality (of which ahe50dc is the only one) thus require a
> corresponding update.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
> index 6600f7e9bf5e..93f3be849071 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
> @@ -18,7 +18,7 @@ efuse@##hexaddr {							\
>   		reg = <0x##hexaddr>;						\
>   		shunt-resistor-micro-ohms = <675>;				\
>   		regulators {							\
> -			efuse##num: vout0 {					\
> +			efuse##num: vout {					\
>   				regulator-name = __stringify(efuse##num##-reg);	\
>   			};							\
>   		};								\


