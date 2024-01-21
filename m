Return-Path: <linux-kernel+bounces-32126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AFC8356CB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B5F1F225B9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3945381AA;
	Sun, 21 Jan 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmCYsjZZ"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66786381A8;
	Sun, 21 Jan 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856323; cv=none; b=ZWpKr6idXfFH578K/UnJfEseq/PT2vFsyI4mz9RQ5TsJQqLidiwI0EkgMuXbaR2O2f3ClrBIv854uKakCnRrhQJxC+ktlMnnqCLlCeXoIlMbIjEBSZGRk0CQ/G9kIcGgfqPof/5X9RLze9xlFXeQWY20ZWaxe9KquRx6PqkZlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856323; c=relaxed/simple;
	bh=4cWkTNk5eXzwloB2ePvtdqvsDXBMCVOrukxcEv6s2E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8jhGisYHhdhSvzyap0NCoYB+L78xA1jg1xexPoggihZcqSE+SqV75Apj2wZQ5km2Vqdt0c6muewlZILW9ODUy6AXtYYETWU0lIkrCLs9/BtLfbHWo0pi/T9JmYBsJG+asGZuuCU6E097NyZK+q94B5AoO74GpLbGhn/3GgH3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmCYsjZZ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e0e08c70f7so801370a34.2;
        Sun, 21 Jan 2024 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705856320; x=1706461120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UTin+pUtKKFwXKEjsKCtXLOTNCLrJJcqZ1pcaGmtLvE=;
        b=HmCYsjZZgYpynEFLGf5Atfrq0xstd84U9ldWg3TyVxYeXx8kti5XhpfN3Hpc9ygekC
         qKU36KhyMn3uuJdOATrpkiFTlqG2Nqj0yop8ucLRz4NipTq3QI0+ejd11yZmoRF0oouA
         iLsMXgDUPOEL4lEaGjUsQZ+TlTBVRa88m9L+iIHHMesgPbN0cTtB1V6FtCKuF6GkDQia
         3gMoz9Kwfbhfp/2QVgc6qtyhRcJvJRPov1hVAJ0TEEmHDFRomumCIptukkeTBnx2nl0h
         wGq3+JxUbs6nC7292vD2N8nWJTX6cNOAy6ShBG8X4xMr6/YRQ10MJIZ3vI5tQU3bU9tc
         H8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856320; x=1706461120;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTin+pUtKKFwXKEjsKCtXLOTNCLrJJcqZ1pcaGmtLvE=;
        b=IGUrCs2heF7xV8d936tcHDYMQmbh4dq913FYgVbNyfV0wAj/CS01g1jQqZB1ozyuZy
         RVxPv9UdMC1fk1Fabl7IbWEMCFcGHryh+miVg0WuQLb9+8WP1gUCRgY2OWyFi0RbDXAd
         ZQl10y13eYnVDWhBggO1Op1mKLbSsavSefBtBPcjrWQ0oX2raLTZTmZ6l3rAptaRj0v1
         OrQ/bdmk4elwJfeoJCETpyZq+/h1Y8ly5TOW3ia7jrL5mNvJ0/PjeG6tY949ymnXgovX
         I7Va6eJl0Lvo5A3mY/Ibe6wXloij8B9lvgWUSIuLlPQ3wu2HcSiyz/IY9T+LXNs49xKM
         87mA==
X-Gm-Message-State: AOJu0Yz1M6hHiWS6LJc0tAkYelJN0Vwv4qkPE+d27+1dFGIwLeEBWvy6
	Y+W6dguVSmsSk3R2H083UPbRaC0lBi/i482XWGvIeM7aqBE0FfiJ
X-Google-Smtp-Source: AGHT+IE6/IIMGPrM1Pn/AcOYfyt0ZVyudQ6g+shGqX1BDyHmA9qG0H50bS5cQRnoANoGmRhP4CEWkg==
X-Received: by 2002:a05:6830:12c1:b0:6e0:c060:66f6 with SMTP id a1-20020a05683012c100b006e0c06066f6mr3248433otq.32.1705856320418;
        Sun, 21 Jan 2024 08:58:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kq13-20020a056a004b0d00b006daf6892afesm8476843pfb.144.2024.01.21.08.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 08:58:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ec7e7972-d48d-4a47-bd03-eec0c4334471@roeck-us.net>
Date: Sun, 21 Jan 2024 08:58:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/10] spi: Add multi-cs memories support in SPI core
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 tudor.ambarus@linaro.org, pratyush@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, sbinding@opensource.cirrus.com,
 lee@kernel.org, james.schulman@cirrus.com, david.rhodes@cirrus.com,
 rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, michael@walle.cc,
 linux-mtd@lists.infradead.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>
 <3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net>
 <d3c93c4c-3754-480c-84c2-9455ec8af702@roeck-us.net>
 <Zaxtm0JlQYU0/K/v@finisterre.sirena.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zaxtm0JlQYU0/K/v@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/24 17:04, Mark Brown wrote:
> On Sat, Jan 20, 2024 at 09:05:43AM -0800, Guenter Roeck wrote:
> 
>> FWIW, the problem is due to
> 
>> +#define SPI_CS_CNT_MAX 4
> 
>> in the offending patch, but apeed2400 FMC supports up to 5 SPI chip selects.
>>
>>   static const struct aspeed_spi_data ast2400_fmc_data = {
>>          .max_cs        = 5,
>> 	^^^^^^^^^^^^^^^^^^^
>>          .hastype       = true,
> 
>> Limiting .max_cs to 4 or increasing SPI_CS_CNT_MAX to 5 fixes the problem,
>> though of course I don't know if increasing SPI_CS_CNT_MAX has other side
>> effects.
> 
> Yeah, I was coming to a similar conclusion myself - the limit is just
> too low.  I can't see any problem with increasing it.

It would cost a bit of memory and somewhat affect performance sine many
of the newly introduced loops are bound by SPI_CS_CNT_MAX and not by
num_chipselect.

It also might make sense to document the new limit somewhere. Prior
to this commit it was not limited at all.
Documentation/devicetree/bindings/spi/spi-davinci.txt lists 5 chip
selects in its example for the use of cs-gpios.
Documentation/devicetree/bindings/spi/spi-controller.yaml also does not
list a limit.

Thanks,
Guenter


