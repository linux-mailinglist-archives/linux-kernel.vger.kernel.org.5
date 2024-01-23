Return-Path: <linux-kernel+bounces-35805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E088396CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C3929462B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5181219;
	Tue, 23 Jan 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyIWJyHw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D381214;
	Tue, 23 Jan 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032042; cv=none; b=mkDBCz36Y5+ZaggtEKou3QUklqi2PaAJMn0xwIN4HaJYAPBV8TUdNuvGToZQiynrTAPcQdVilYHcnF4UUsEOu49P/zbpIXU6YFnwf7Nthp/CZeSsgpvOsnrTkLB9108h0c9PmlSc/SoO+mWE6MznCGQL/GxJSBC+2BUICFO3FJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032042; c=relaxed/simple;
	bh=3R8bmd0q4QtWrQqo2gw2iug+ZABLfttDQzX/cn6VU7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX5AIt6+IWPYDdatWwejZOv1PaBv10YSweZzyXGcyKKXMglp3bA7udJkgKgx/MjEzQjyjJCsOGYsHsLtFlaRvBjoDHHwlL/z2iiczwmPa1GBeO0HD3BqWZ5e+rR4wY15Ld3uLthBQIlakQrgaGM6SzqIdDntMZye1ukvkxwkLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyIWJyHw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d50d0c98c3so45042375ad.1;
        Tue, 23 Jan 2024 09:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706032040; x=1706636840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HHKusWEIOtduiXqr0YYe8V2d8aUcA+XcDRPQDAy0c08=;
        b=hyIWJyHw3M2iCoofuCcqMc+FNdKsFeSZxS7zAQUr6j0GF4h/2/b0rWyy1Km0+7KdwS
         gUI6iU9dqoGPx1TwOB03ntaI5Xz9Unf5h2CmLCHLi3zqmbwv4kuRd38ncgdJyehiO/5L
         r/nvd5jSlDWaXfjot/bFJ+AWh25VmNjLhwu4lkeye8/8r9OGuIBZkQ+HG7zat189Vw79
         SJe7ld9j0AgHZzGWjnmFrKX0b7GMhSyPqH/vQx3z4xqn9cFDT/dQ31Tqksf8NJ/nH1UF
         MdOqTlSfaVlifgvPEgU2jqdXHj83AXMHnmt58CCiMdIN0g0I7jhqwi22Q4WP1a3qmldd
         jJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032040; x=1706636840;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHKusWEIOtduiXqr0YYe8V2d8aUcA+XcDRPQDAy0c08=;
        b=gYqsWzoMgCLnmpYgS0LdMQx5vaDhbfUjKhQfzP2BV5zQtmtazjdyuo9kjaMptjgtfL
         N3/duN25/NzhZx/tnPKE+0Wd9KIFtfUMsQrJ7DjpbTseqw5lodkLmwn0GGuuBQ2lSF4y
         oPHnRASRK1YFkfxtrk1F0gz7d+3RO0IEDCkp+m4MqNekqkt3x9RIELOSYocFHp0h2qJ/
         9GmLbX9LXNFBORzDRzqkCaLa2bxC9BNsU5FvHkxGIE9FvxvQX32gZESblYUPgtAx9rj7
         urGgqY7F69F8g4QVWlJL4d+r7crX1XeHmBm9mKsbY8Iz8VZhBpa8LchAQcZi1iAJowOh
         XegA==
X-Gm-Message-State: AOJu0Yyz9HF3iG/87at8VL+6arz36KSFuyCb7i6aA2CNkK8gIMnztlDF
	25JeI0LURBFyqCijZoFNOHLpSY9L2GuyKcCXSPeu4BQ1qn7iqdjY3I5XTQlQ
X-Google-Smtp-Source: AGHT+IFvOGX/9HkLHlxmE3Q5yc4xVqJr26/I4w/wwkXFOc5G9+wfZFVS+sRMKa1zHy3E66DdzGJtSw==
X-Received: by 2002:a17:903:249:b0:1d5:7522:9c11 with SMTP id j9-20020a170903024900b001d575229c11mr7606222plh.2.1706032039683;
        Tue, 23 Jan 2024 09:47:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jh10-20020a170903328a00b001d6ea47ce68sm9161745plb.52.2024.01.23.09.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 09:47:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <801eecbe-4bf9-4bb8-9de0-1a7ca6673ddf@roeck-us.net>
Date: Tue, 23 Jan 2024 09:47:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
Content-Language: en-US
To: Jonas Gorski <jonas.gorski@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
 <20240123120430.75c7ace0@bootlin.com>
 <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
 <93385fc2-7596-4f66-b0c1-07d7d5c9ed8d@csgroup.eu>
 <49b52941-6205-48bd-b2ae-e334018ac5cd@sirena.org.uk>
 <CAOiHx==FzSyyqP3NzLTeOSVxUQYy3ZhypZrDLsc-OjGCdSzvUA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAOiHx==FzSyyqP3NzLTeOSVxUQYy3ZhypZrDLsc-OjGCdSzvUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/23/24 08:50, Jonas Gorski wrote:
> Hi,
> 
> On Tue, 23 Jan 2024 at 14:56, Mark Brown <broonie@kernel.org> wrote:
>>
>> On Tue, Jan 23, 2024 at 01:26:04PM +0000, Christophe Leroy wrote:
>>> Le 23/01/2024 à 14:18, Mark Brown a écrit :
>>>> On Tue, Jan 23, 2024 at 12:04:30PM +0100, Herve Codina wrote:
>>
>>>>> Moving the SPI_CS_CNT_MAX value from 4 to 8 is not enough to handle my case.
>>>>> Tested moving SPI_CS_CNT_MAX to 16 and it was ok.
>>
>>>> OK, I've also heard 12 as a number which this would cover.
>>
>>> By the way the comment in include/linux/spi/spi.h is confusing. This
>>> SPI_CS_CNT_MAX is really not the max number of CS supported per SPI
>>> device but the max number of CS supported per SPI controller.
>>
>> Well, it's a combination of the comment being confusing and the
>> implementation being a bit broken - we simply shouldn't be limiting the
>> number of chip selects per controller, the per device limit is much more
>> reasonable.  So ideally the code would be changed to reflect the
>> comment.
> 
> At a first glance at all places using SPI_CS_CNT_MAX I don't see
> anything being broken / reading out of bounds if a controller has more
> chipselects than SPI_CS_CNT_MAX.
> 
> So I think the check of ctrl->num_chipselect in of_spi_parse_dt() is
> bogus/unnecessary and is in the wrong place, as this is for parsing a
> spi device node and not a controller node. The following check for the
> amount of chip selects defined for the spi device should just check
> against SPI_CS_CNT_MAX instead of ctrl->num_chipselects.
> __spi_add_device() later will ensure that any chip selects are valid
> chip selects, so no need for of_spi_parse_dt() to check that either.
> 
> But I didn't do a very thorough read, or even tested it, so I might
> have easily missed something.
> 

struct spi_controller {
	...
	char                            last_cs[SPI_CS_CNT_MAX];

does introduce the limit for controllers.

Guenter


