Return-Path: <linux-kernel+bounces-86273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8DB86C32D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9AFB217E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7064C619;
	Thu, 29 Feb 2024 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cy55BXTE"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68347F77
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194223; cv=none; b=l3gqKqVNFU5/9leNctd1/coxIOtCTCGm7JV4GsKsJvhWeuysQU7HzPSanmvhZzPkWz0R6qxmxKWMED6eljSkty+UaEKOkO3h+Ylf0YP/Hooe6JVbGMwKAI5jUXYgImc/6WVQqJIk8MKN+pYNWjjxnEXBbl2BoZu5Gd9Tkk0lXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194223; c=relaxed/simple;
	bh=uT5GGwIZZRLo+4HhIG63ksrrdu9o3l3CWHmLecptEf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeLf6it36dMotuY4ViIUNk0SO2hp/vqhKHMcWC/jc1xpBx8JaMR67Yuxy8CFXyKKxPFFwiqUnC/1Ad5zVVUBusANc/XhnbG1F/seMTPsP8gwM2Ces+bifY/IcDo35Z5ARh59j0wXq+oVSYXNIPYey/CiSTJ08eiSOyODAKlrxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cy55BXTE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44282a09bdso91266766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709194220; x=1709799020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8akaM+m0YgLq/GsVoWpb9QMM3bF3RbFZg6ap5EIWC4=;
        b=cy55BXTETFnxvCIwp48K/5JgoCucDqDjXoEv5YGzliBFjh+cbM9yEWS+piJwTSCZFC
         q33ngYho07cbgqJwSyo+A8oPGUqqfx9OMyFZSN6X7GsoamuxSWLHXnB+OmQNSjH/wta6
         Z66KRofd+QFVLnTTlcdB8SVTvmBkiLE0uiCptZhKQbtQJ8p9NmPXk6ZYaRs7RdbQX9M5
         jU7KsvdWgWmJoMy96V8hdmZAKJu/JCTyUTUG12uBhkq/+ZyDVbWT2SNmSd22P9U8ewhz
         CBJp7yZZncXkdIqn2lRu9AH3y5h1jP9OWCCSeO2TkzBWLqsaYrbTu6y9cz/Evht3OHLM
         MfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194220; x=1709799020;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8akaM+m0YgLq/GsVoWpb9QMM3bF3RbFZg6ap5EIWC4=;
        b=JScB1QRBctD+BZnwqDhDtCs0b05T9g5IBoe7k0XHQb2xIcVXYfr5eld7RaPbufp/gB
         NozZej1rYVlAwBDA+vpbNedRwHjvxbMJo9AeOTS2ajArHxJCaFAwMsxDuJO9Fw3FUIIF
         oknN12N4fkrgQ4K5rMysMvp81YhHcPDlrc6P2qAbCtBpJ4qQZhqmHK3FAkZ+95RkMdYl
         B/cXeZFfvvzs8aYUlWzNbR7eUpsDVbV9e2WfseKIbcmm/rX1YS9DQADLovEINXIMqFxq
         hOEeie1c5trjqDKFBbkepKo8Paizcaek/C91usEfAEOZ0sraPBiouKjZOiIWa2OTWwIe
         CGmw==
X-Forwarded-Encrypted: i=1; AJvYcCVjCgPBZR9tdHZWx4QsqURbZ+CrTNdPMoN2ADExoc3X5krTVsbrg9HhIQBQFSqg7iWs8mZMVpv0PrqtFHSWcBUFPbFeHWT9TThgmvAE
X-Gm-Message-State: AOJu0Yw5SOYZNUlSw8KyjutUmXdr1LUM8P9LmdDLBkZ12uGkH6HF3OwQ
	MTke0802xQeS3JSv6ATVRVFtRNEJjMoxAGeGKvDYV5z8G/0M/MT31nYu9JiAHno=
X-Google-Smtp-Source: AGHT+IFaHpZ67jUVd3zXoivqSxrmPyd0hbZSsQlpghOfbyAQfKNEL64B40Kh7EgIMyXUg4TEx/9+ow==
X-Received: by 2002:a17:906:3442:b0:a43:4c31:c4f1 with SMTP id d2-20020a170906344200b00a434c31c4f1mr896170ejb.11.1709194220139;
        Thu, 29 Feb 2024 00:10:20 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id cu5-20020a170906ba8500b00a440ec600e3sm411228ejd.121.2024.02.29.00.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 00:10:19 -0800 (PST)
Message-ID: <7c171041-30cd-41a1-8b8a-00168d112cc5@linaro.org>
Date: Thu, 29 Feb 2024 09:10:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 11/11] net: hisi_femac: add support for
 hisi_femac core on Hi3798MV200
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
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
 <20240228-net-v6-11-6d78d3d598c1@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228-net-v6-11-6d78d3d598c1@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 10:02, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Register the sub MDIO bus if it is found. Also implement the internal
> PHY reset procedure as needed.
> 


>  
> @@ -947,6 +992,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>  static const struct of_device_id hisi_femac_match[] = {
>  	{.compatible = "hisilicon,hisi-femac",},
>  	{.compatible = "hisilicon,hi3516cv300-femac",},
> +	{.compatible = "hisilicon,hi3798mv200-femac",},

No, it does not make any sense. Why do you keep growing this table?

Best regards,
Krzysztof


