Return-Path: <linux-kernel+bounces-56333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5184C8CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756FA1F264AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AA614AB0;
	Wed,  7 Feb 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="Q0yC2QQi"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A11429E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302422; cv=none; b=pwag9JqSBld2SHVnNZ2uGfCWJdd706pQ8ahnBe3i7YFnG/xQq6SHdiHicxDgEX05JKAJEIlMWzhDswzKvOOeOAtwDyGCRE25cHZz82FuG4w86YRehjzBIJxG6B6CvH/femcH0byYA4RS9tcN4KhMsh0nuy5L9vqy+/k9JxcMRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302422; c=relaxed/simple;
	bh=I1z13nI231r3jcIoSd+9wnU4+7PcC4+j7mf7kcI3UmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxpaW8lr5hgXWy7m3OwJcpIZL+ql4iqm38YjOi6K6g5Jnezaf4sDF7g1n3oPJpwtN17tZZa6D3t95gtcVmnVgrqEnsR0RihgjXVslpluFnW8ygmzTJWCeSaix/KjOBuKJZvDxUpnM2qvyYFIIWANTd+U4KkuxMREorDOJ0H0Tik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=Q0yC2QQi; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bfdb5a5a63so210339b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707302419; x=1707907219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHF4yI3nxQnudDPDaoNZ26aT06zX6zXM+gcUq0rdUEM=;
        b=Q0yC2QQioJ/sWyMl5Z67mmDnV8Ow2XGqH4C/rQJVAU5b6q50IJZ7EHuO8A8BW8XDHQ
         pXN3Pvb/ziRLCr8HiE+CL2J6oP6HvN2BXbIdcFxR8XA2f+FxMdl+jiaD9tJ1xhTSYHKS
         Tdm+JZem8oilSrPci7QnwfKaViGTG9INdGxh5yNvhC7JMTIFuLjAGbkqvTcrFgAxHpgT
         gwGIP3SXXkk9FCcYvoMlR0FvK4OP6dU1sOgQg4aJMV7TD9CL4uE9p/z44y1qAaLwWNiF
         xAIKAhgZmGAIP0tmVT9apP0SoCXgGi1K7F+gDy6d/kePWXboNFZLLUaScLDFihL20bV+
         FJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302419; x=1707907219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHF4yI3nxQnudDPDaoNZ26aT06zX6zXM+gcUq0rdUEM=;
        b=N8cQ8zvIsM/Lc1EBO7PZcHzIbZRuPlj67cNP1d8UU9B74RXqk/pev4AxkswvSFLPrn
         YZ8mGQCMuTwlwOnBN+ezYXGQD3MWU0HqSGki43LwSrt9WIO2Criq2Arf4rFE6kgMLMdf
         lx7HkSAuk27MT4fqSqZD7xbjWg+RgIcW3whM9oNmIcdpngRCoWjq4N9IcyJyn0QEzBhq
         suB8iigOCY2bXZZYILMTbvo3h5G1EIYphFb0m+vVmw6j6yPGN+lamv8Wcw+19jDmVQU9
         A2D+QPqbSN/eAeouccApFxaqLTFqaFxeKf5pBzUgcMTqDhbqFwnBWS9UvkE0NX/B9Dkk
         88Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXwRIR6p2xUIJrmhaM6D6X3m5dcM2zI9ijwusvoZMu3JQKmpMBgL/0rJFc88ngT8X75Jw4kHMICNpyDyiwd7oG4EponVxW4L0KTj6XM
X-Gm-Message-State: AOJu0Yx87dcYM7ak64RCksB4Siktqa4CM8WCEiPwBrSXSvcD7o0eF2Wd
	BvWFwDn25x78swfI+xUMM+cFWQbV4UUzA6wEwgWUuLoXMo//tiM+XRfSpKRMmQU=
X-Google-Smtp-Source: AGHT+IFC4l6EcZxQ8ikTXeVZfeHf0c8+qAcAhrc/R+QH/sxMYIsjqfw7WsI2OguZcEb5hfx18XDk+Q==
X-Received: by 2002:a05:6358:703:b0:178:dac3:2b99 with SMTP id e3-20020a056358070300b00178dac32b99mr2724004rwj.1.1707302419121;
        Wed, 07 Feb 2024 02:40:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSDDBTm+CxEBpm0emQzLVFZoSDi78Y9k6L13UG6ZMtUoGi0Kk8dAQmbk+ljrVHYD3ujaxiBciZxCCrzrn8UEu03HdseP2Vl9aB0Ae4fU6ik8JjaPPTnfImJmnPJpxgGe4qsFiwxC3L+Oa/NCvc/RFklj7AiNT20pWKOHLQ3qfC7XcissPcG+d+aXPPGhGPhfkVJEjxun3rFGMz5CNAMdcmRvSVAnSvR4ehxMB0D4nyWeXPKjy5c1eANOUMIomYwMGU4kMfFo/zGKX/YPAEFAo/D8yOVTYfDvsY+Y3SIH6MjvuyrV7OAIc35eSP03GlSyb9F+xZORtffgX8jzsggQnycDLZn2j6FX/dLvX2tog9wAdYuquG0stGXwgnmpY3usgZU1SEwUcQw59N0Gpyh2cxqn4ZGSkxRT2Li2CTSUrXrSwI/rY6SYd6rzAsjxhHCmZjk7IjNOBkXV++CbwlqII0jrYQj4LYqJB51Heqhe296gqOMUmp/yClrrEbVoNriA==
Received: from [192.168.20.11] ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id j20-20020a056a00235400b006ddb77d443asm1165968pfj.209.2024.02.07.02.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 02:40:18 -0800 (PST)
Message-ID: <e3a48527-306d-42ce-b168-999c2f2ac3e7@tweaklogic.com>
Date: Wed, 7 Feb 2024 21:09:57 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] Support for Avago APDS9306 Ambient Light Sensor
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206-gambling-tricycle-510794e20ca8@spud>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240206-gambling-tricycle-510794e20ca8@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 01:17, Conor Dooley wrote:
> On Tue, Feb 06, 2024 at 11:30:12PM +1030, Subhajit Ghosh wrote:
>>    dt-bindings: iio: light: adps9300: Add property vdd-supply
>>    dt-bindings: iio: light: adps9300: Update interrupt definitions
>>    dt-bindings: iio: light: Avago APDS9306
> 
> For these 3,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
Thank you very much Conor.

Regards,
Subhajit Ghosh

