Return-Path: <linux-kernel+bounces-100949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEF8879FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22931C21A41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7534CB2B;
	Tue, 12 Mar 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKVokIYI"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A59481AB;
	Tue, 12 Mar 2024 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287899; cv=none; b=iriBJvgF54u1++kN7hiFBNiahoUGMiYylBDURDA+P+A34lfljZ+Wc6TCFT1o22hMLnCe/ELyX5GKIqk5gJHd5x6gTqxH5G1WuGfQBdOMgaUIIYRiK/ZVtNKEPI8jjcmm/ua3T9iH9iqNsKUzSMgB9fcR8QE1aZ5mnFkePE/dMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287899; c=relaxed/simple;
	bh=yweMbCmLcmrrPFl0rGuY2HgleyqsnF7bABowNG+ClS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFOFeveeWEN7/GER/8m14oTHZhu8b/Itz2EQNYHTyuzfXODI3SVyTAi8fnHvBuNhFM9rJ7rmvTV0QqBd+AHzH2h0jOuwzo2IUY+EknlqtSlh9gE2YReGtARuSmqBjDjA63JqfnThSGZZN/en93KdJ93U0xQGGsvF5z/KFYFKLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKVokIYI; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a1d2cac52aso1181844eaf.0;
        Tue, 12 Mar 2024 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710287896; x=1710892696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D5DpqtpdfFAZzATRb5uTD8cUR8uacTJP27bayC6m7nM=;
        b=lKVokIYIzG9+HBPfEqQ4osPIewiZoAXyuDI8l1yLX1BBnQjmoOD7q338sABbEOm0gt
         dbEsNgqHTDDgovvq0vsCvi16R1KWspMQWBgkOQ1eq0NRzb/4DDCtzWY6+fAPWJX7651N
         W2M3VIY5UE8xEIXngrvuuPRyT/8Nv8hcqBwSHW8/xbBMG2JL4+2hYxrfQ8h9QIYltWOh
         MEy6tLu9H5b0m4qoQlQUn3QlqD1kGATsQonSz0W9FVkxVo7xHiUx6qSvfquD298V7JGB
         cX08252iivHse/tBnUuf53HiheKBj+aeDQsVrLoa02eIcrOeBWAiLa2zUpMKXqTes2QY
         4A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710287896; x=1710892696;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5DpqtpdfFAZzATRb5uTD8cUR8uacTJP27bayC6m7nM=;
        b=MJYPZw5Km0Vg58vw6+G9R7c/6SUxk/TIV985g4M/ZJdJi2cOvPjP9+Q5xrOrXAcwAI
         wiCf363x7ozKDDRNlZmSq0sjf35SsYGTzX1Twc0G0mUYF/CKLidtpPNgZdXRX1dD1zhy
         G2pwTRk6fRkYcAkK5Ni43XbFvnNb3YklYDItyTMqQELpnat1d/JhECcCRbdyAR1K37K1
         dxOUPzWuaN+1+F+Kr7Fj1FBAmrxiq/cmvms5dHpNIpZxNMqVQrIh/+/0N9UpDn+6dfc5
         4mw8iiUTFj6gATaMw9O4CJcM7TibJyRs9+fQrXqrbNncjhO8Apk77LzugF7n6MELsCDk
         SisQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+zmyLtY/qcHC/WiKyJ2UKuyJ64czeHbT316fu6uvctmYEKZkPOvHTl70foSTDRVafxx4WA1RXCoP8Q9/ymXZxXP8pgvl2igfXFjl+/Gv8xMiqs/lC8PkZ52eWAlqIJSJEq/aGSAf7J4MUlzSGyIRM1nINYJFcpwq5XuEIX8K6ZjFWzaEU+4dD7fihagKZZOePllTQ3f79b/UKiybdzoC
X-Gm-Message-State: AOJu0Yx+ZYnh25AZjYDOK4EjL6llmxp/jL4ub7zzO0cNX53/e3p5icWY
	RzoLhpPv7/gzEmRLnjwWtZXyzESdQRvITwqLhBbZjeMWtOHtwu0o
X-Google-Smtp-Source: AGHT+IHsQwzlczYnyrpZsrGroO9kt+77qGT/uSc+9d9A4+NnU8JEdqQaZ+X0170u6VFsjZw/HfuBQQ==
X-Received: by 2002:a05:6358:495:b0:17b:e053:84e2 with SMTP id x21-20020a056358049500b0017be05384e2mr9148948rwi.12.1710287895812;
        Tue, 12 Mar 2024 16:58:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bq5-20020a056a02044500b005dc89957e06sm5791801pgb.71.2024.03.12.16.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 16:58:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <37e11daa-c24e-45b2-a22d-769693fd2038@roeck-us.net>
Date: Tue, 12 Mar 2024 16:58:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
Content-Language: en-US
To: Zev Weiss <zev@bewilderbeest.net>, Ban Feng <baneric926@gmail.com>
Cc: jdelvare@suse.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, kcfeng0@nuvoton.com, kwliu@nuvoton.com,
 openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com,
 naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <a90ed00c-f836-4fb6-8191-9974937e3eb7@hatter.bewilderbeest.net>
 <CALz278Zgfgob573vgWz4PgC7vb=i8xt3kC1hSjo_cQi00B0XAg@mail.gmail.com>
 <cd63bec7-01c6-466e-b772-3a3d3d90a7d5@hatter.bewilderbeest.net>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <cd63bec7-01c6-466e-b772-3a3d3d90a7d5@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/12/24 16:18, Zev Weiss wrote:
> On Wed, Mar 06, 2024 at 11:35:31PM PST, Ban Feng wrote:
>> Hi Zev,
>>
>> On Sat, Mar 2, 2024 at 4:19 PM Zev Weiss <zev@bewilderbeest.net> wrote:
>>>
>>> On Mon, Feb 26, 2024 at 04:56:06PM PST, baneric926@gmail.com wrote:
>>> >From: Ban Feng <kcfeng0@nuvoton.com>
>>> >
>>> >NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.
>>> >
>>> >Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>>> >---
> 
> <snip>
> 
>>> >+
>>> >+static const struct of_device_id nct7363_of_match[] = {
>>> >+      { .compatible = "nuvoton,nct7363" },
>>>
>>> As far as I can see from the code in this driver, it looks like this
>>> driver should also be compatible with the nct7362; shall we add the ID
>>> table entry for it now?  (Though I only have a datasheet for the
>>> nct7362, not the nct7363, so I don't know exactly how they differ.)
>>
>> As far as I know, the difference between these two ICs is 0x2A~0x2C
>> Fading LED for 7362, and 0x2A Watchdog Timer for 7363.
>> In my v1 patch, I indeed add the nct7362 to the ID table, however,
>> this makes it more complicated and our datasheet isn't public yet.
>> I think maybe supporting more chips will be done in the future, but not now.
>>
> 
> If the only differences are in features the driver doesn't utilize, I'm not clear on how it adds any complexity.  As far as I'm aware, neither datasheet is public (NCT7363 nor NCT7362), so if we're going to have a public driver for one, why not also do so for the other?  It's a single additional line -- and furthermore, having made that change and tested it out, I can report that the driver seems to work just fine on NCT7362 hardware as well.
> 

"if we're going to have a public driver for one, why not also do so for the other"

If you are trying to say that there should be two separate drivers, sorry, that
would be absolutely unacceptable.

Guenter


