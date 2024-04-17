Return-Path: <linux-kernel+bounces-148722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C139F8A869E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC11B256DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C3C142919;
	Wed, 17 Apr 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfl02LAI"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F01422C5;
	Wed, 17 Apr 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365209; cv=none; b=Q8xWs5gOEsb37rDe/xx8jm1LkVdYw7IBse0K4HChs+HZf5VCWc40nLaFSTxuxc0SGlO2RXbnLxrQAnSgtHEyfZzS2y3HwiJ0+myhfGCz+SuS7RF3+L/rng715cL99ol861QcKTYFg+ahQS0XlcCJ16Hu0e1c7LLhfH4cQr21aOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365209; c=relaxed/simple;
	bh=fGlLeTfFvg7JFvQm4TKQ5gDwKW0+diYPRbXJEB+sd4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0CNLTC02uj+Ew4bPiYKzdM/s32wlNb+xihAcmnO4pWlW6JsHdxtaxMDV1H4V3ofkx01ffHGfcxIrVjSg/Hu1iGfcszlv0VAgye2vIgJktMR2UhFhGrcnPJTgqF97wXBYZv23Bw/bL8zAgGxduCcmkBT/2uSxNi+KoY6QSKp0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfl02LAI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-346407b8c9aso2075625f8f.0;
        Wed, 17 Apr 2024 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713365206; x=1713970006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5JcPGqfKiwPJCd7YzK2Kx6EbZlzGWadlP5okF3X0Cg=;
        b=mfl02LAIVc655X8PNGduZv7xhwmWStI+QqSM4sRyow0dQ3uGwxzcENlsy1vBcZFkA/
         4iEdR+pEBsZ9TdMZXjgYwJeF/kILP5DupYrbrBuPLCakaNLJ3RyWN6vYIStgS7vX/8Np
         knVKs8ICSTilnFOBmFJkogMQ5waVGOvBFHcp0QdgrcKHvAhjtayVwXgTTstiP9G0qXsv
         rCzmhjZQCVXEJcMSQq7OMWK+Sk3tiOPpC7tx37kwg2b4oSa9FQhSWCL7I+V3cqtXjKgi
         8wA4caPmBvAlppBHlHSyHGMSzV+zRqOsgbf3ga06n/ZBMvQVJRtMlxSvFCZRVzB49mby
         IM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365206; x=1713970006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5JcPGqfKiwPJCd7YzK2Kx6EbZlzGWadlP5okF3X0Cg=;
        b=qZxgd4U5Iyvm8dpw+1tjSkdy7c6lgZK0kL25lyh9El2zW/v1k1nWJE9tUqgJogSzd3
         +RbDKe2923MNvgJN3nethcQAkubP1qqKlZxSL56ndvylNDLMj9xwKM9eWXLIvY9K+L2u
         mU0xRJdbaBcSNnVWGj/B6HjjjfAtHBmhdtmEFrzJWa3+cxPZU3kimKEFjsIZAY34Wex/
         mRdT5mEdaXTYRPRxZCBguG1SBJEFdOox4PtSvNtZgQuUgI7Pudprq0DoYTIuQWSMmkNj
         66Blu2Se1PCo5As8b8H2LMAlq30zJRnVkm+YInCDxbXqQvl8rG1uPjoS91BVGcW3VuSO
         HVAg==
X-Forwarded-Encrypted: i=1; AJvYcCW7EpPGwPyRNz4X5YmZzI0qtZZk2TuyTY1YUt4D6U32m5h8J4U9PM0Eckl13zV9grLuas9TiHd0Tsab++UsjAnzS4UfkqbQhOrHcUYPOCwC+U07+Us0//m6i+CgehSWKQdoyliGaNcA3j6BMR8e
X-Gm-Message-State: AOJu0YzAXcCdRqKeL45Ar7TffX6WZIKf0VBnzm9JHq0IlYpjebl0j04K
	9vkGyWawt6Rr0gOGtExdJpyiu30lfFK4EcvJv8p7yemrnyXP5K7h
X-Google-Smtp-Source: AGHT+IHmeAAetI9OZ8EEJiSNFTGOp5WmlYsN1EspEZtYuuUzUPUaryoENI09sDnVwPCP3CLFHhlrYQ==
X-Received: by 2002:a05:600c:1c97:b0:418:2a57:3806 with SMTP id k23-20020a05600c1c9700b004182a573806mr8841334wms.0.1713365205950;
        Wed, 17 Apr 2024 07:46:45 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b00417f65fb982sm3154060wmq.6.2024.04.17.07.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:46:45 -0700 (PDT)
Message-ID: <10085ec8-0109-444c-bce4-d0b0ef1a4164@gmail.com>
Date: Wed, 17 Apr 2024 15:46:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] string: Implement KUnit test for str*cmp functions
To: Andy Shevchenko <andy@kernel.org>
Cc: keescook@chromium.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20240417135415.614284-1-ivan.orlov0322@gmail.com>
 <Zh_cgnMOFHuP-lKu@smile.fi.intel.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <Zh_cgnMOFHuP-lKu@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/24 15:28, Andy Shevchenko wrote:
> On Wed, Apr 17, 2024 at 02:54:15PM +0100, Ivan Orlov wrote:
>> Currently, str*cmp functions (strcmp, strncmp, strcasecmp and
>> strncasecmp) are not covered with tests. Implement the test which
>> covers them all.
>>
>> The strcmp test suite consist of 8 test cases:
>>
>> 1) strcmp test
>> 2) strcmp test on long strings (2048 chars)
>> 3) strncmp test
>> 4) strncmp test on long strings (2048 chars)
>> 5) strcasecmp test
>> 6) strcasecmp test on long strings
>> 7) strncasecmp test
>> 8) strncasecmp test on long strings
>>
>> The test aims at covering as many edge cases as possible, including
>> the tests on empty strings, situations when the different symbol is
>> placed at the end of one of the strings, etc.
> 
> ...
> 
>>   lib/strcmp_kunit.c | 170 +++++++++++++++++++++++++++++++++++++++++++++
> 
> Why is not part of the existing string_kunit.c?
> 

There are already 2 other KUnit tests in `lib/` covering different 
groups of string functions separately (lib/strscpy_kunit.c, 
lib/strcat_kunit.c), so this patch just follows this pattern. I believe 
it makes sense: the tests are separated to cover one specific group of 
string functions with a similar purpose

---
Kind regards,
Ivan Orlov


