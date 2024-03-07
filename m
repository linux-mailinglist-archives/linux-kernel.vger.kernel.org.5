Return-Path: <linux-kernel+bounces-96040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD17875672
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404A01C21487
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E32135A5A;
	Thu,  7 Mar 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mocsx9Xy"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2F12F5B4;
	Thu,  7 Mar 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837635; cv=none; b=JsylR96gfu1XgR2VV6vPeg/FUp2lAAD0Qq1c+H87V3P48scotFAXYtF3bbSQWRUcPyOwFdzElGOVLr48QIqV3vl3gv0M8OKYKRDuZXlNJQncByNsKBWircXz7XrBl2jXoeCI0S6lWwdOuUBSUQyWZ39f60xnXx1KVucOw75otOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837635; c=relaxed/simple;
	bh=I2tvYxErnY2pyuvWilMIHBxfWpiRGMTRHoeRms2zXAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS+SPsl5tVXYUUe4AtlJpyQRwcdvdCQ3mirX5pXLu6a236usq93Dlv2Ztbp3W3U2h42o3Q6pmlIcIfY0p9KA0V/39D0oALUS6+sSIHOwpen5ULwVyyfqTmynCSVXO7wA7E4O4MO7K4T8KvfSSpVkRrd4CEHZiywpGE3c0IOq+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mocsx9Xy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so10537825ad.3;
        Thu, 07 Mar 2024 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709837633; x=1710442433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5NiY2BP4oG9jjepM9BzhKO7lbi6TQ2GmXagV5TbJb1k=;
        b=mocsx9XyIrfKxj0NDB54Z55tG56Jaj05M91a5DvHYikygfNsBZH8Af4A8w4ew+Zaxa
         JHia/okGNdWtwISCiYAXqEqr8r+vOeDWeUzyJLZ4gkiyLAE2ubQrhRWUAQKHrAgZeMaJ
         a7jsJDLNh5jwxALrHPnrZGV/07Cs4lDXCwNRg+/DeDaYleJwl7k7OynVf6ayBEvKhaVg
         CgGT1Y81mSgrkjoSGSc56wnxRbFnfmvxpxmds8caqtCrzpJZjclkfP74twi70MNbm9gU
         uOfrL3r3MPbh2ne4bPDBm3trDq7WJsBFlZ2J4OBG7XixrkJEHbA3Cpc5xPNdxGWWdkcn
         HoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837633; x=1710442433;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NiY2BP4oG9jjepM9BzhKO7lbi6TQ2GmXagV5TbJb1k=;
        b=xQAi+odm7g0DqKRCaIv94beon5Goc3PdH5Fq4ehmHHg8ZetzTM2Jdgno814f8MBs4C
         OIeLwz77+Qbn5idghRSZqr6+xWPHh7e8B41I3ulgYkftuhyyrisFsvGTCbiesp6ZyaCF
         c30DdkkNraT1Mfvj0qEJQy8XGe9P+3UvoDOq5b+IcmzpA/jmYdrzOejNepDIVbWRKkeD
         cf+3BnH48RJp+A+nxIu42tp1gWVofkvbyD7xonUckJDcjL530gLhfVDJlb/oKvcLdIuD
         20RAZ0Tt28AUEVVQJWQt3hu+PU0KDOnPWFZRQaVnzlHRpHiq634RJt4F0olvcJzc4VmE
         EnWA==
X-Forwarded-Encrypted: i=1; AJvYcCXSP24YvPPHtjCGbFa2e0fVXwdLiamdc5/nnN5ahHB3UJ0HVlW7otE5+1+gJ0b+JzU4Sg7W/Q05nwoWNQXRsKkGlM0EM3xGG+dLZSU/NAvLUeDUNtatDgWak1nyfKFFa9u7Q9pjXWiZdzKCL0KYgs10NnNR/KVEp3DAGhGQKNeAa6iGWg==
X-Gm-Message-State: AOJu0YzoH82O91hVQVyV4QsBF2jNgx81/FASV77fXUCCZY143yoCkKvo
	DxygaDG9WxAbBcu0HtIQBNTkU/OKilAWEsSdxNlLjk8ReYYCOSYVjVcV6HhJ
X-Google-Smtp-Source: AGHT+IHt2lanm3f3AMLshc+VhhymDRj3AfGXf4Wx4HCC8cXNf7N4oNAp2AEcNPcLaWighUa47dXLFg==
X-Received: by 2002:a17:902:c081:b0:1dc:a282:365f with SMTP id j1-20020a170902c08100b001dca282365fmr8309404pld.40.1709837632852;
        Thu, 07 Mar 2024 10:53:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bi10-20020a170902bf0a00b001dc3c3be4adsm14863820plb.297.2024.03.07.10.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 10:53:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9c92dac2-2cec-4f66-a8e1-4c0ccd5a3d0e@roeck-us.net>
Date: Thu, 7 Mar 2024 10:53:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To: baneric926@gmail.com, jdelvare@suse.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com,
 DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com,
 naresh.solanki@9elements.com, billy_tsai@aspeedtech.com,
 Rob Herring <robh@kernel.org>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-2-kcfeng0@nuvoton.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240227005606.1107203-2-kcfeng0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 16:56, baneric926@gmail.com wrote:
> From: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>    patternProperties:
>      "^fan@[0-2]":
>        type: object
>        $ref: fan-common.yaml#
>        unevaluatedProperties: false
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>

This patch (through its submission with the aspeed-g6 fan driver) is now in hwmon-next.

Please do not resend. Any updates should be submitted as follow-up patches.

Guenter


