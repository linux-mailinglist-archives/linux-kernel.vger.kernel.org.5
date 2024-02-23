Return-Path: <linux-kernel+bounces-78969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB6D861B74
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC58B22F51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF67141987;
	Fri, 23 Feb 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrLpW/XA"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44414263E;
	Fri, 23 Feb 2024 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712443; cv=none; b=X8de8bc8EZW/CJ+LAjVbPtyRjI+v5/ULVoPU1oSAoO7jkofKjgbOYfjMsTfEhv0osFLSyJXq7QqOzzjoYhzDVlcQBizqKfsVombK9S4nxWHrm/rirR9zOxlY6F2hHY7pRgZxAIs6dDhLaVveYyTCNnGrNN9onUi1GXAractLA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712443; c=relaxed/simple;
	bh=4Qrvq1AhP6eyIkuoH88pa0hlk5TiVVHr6E9tQvZNksE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPTv6Mavb8Y6eUlGkIEzWUuPnE90mIVLQqLEXJG5re2ASKKMEhQ51TKTf6HV0+1cds6lIoarLkdyS+5dhOh0wrZtDEeSUdhQR5eP+wQWjdkr/g+bKYVqBVxFUM2Nunzw/gsKxS6lah3EE4svFtulB7n4WR4t9Spx00wm06A3ce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrLpW/XA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso999005a12.3;
        Fri, 23 Feb 2024 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708712438; x=1709317238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvmCBum3obDIzEvJJBYCmhBj4c5cWpFkxhaUjZo6Kko=;
        b=jrLpW/XA9Gpvqhw2vvohkxecNbvp2boguflh8dUqSnJ7otPwc2uXpYjE5dO20hdeuP
         EluHRC6NhES11Iq+xbCEOcl9lsXXt14u7UZZJETWX9zuafRWtX2bc/t66p1nnkVLNLF9
         VfADDENc5cg4P6UQuWDGGbyDty5hT+bLzWVULGjgZf1HLYfLQZOVmjHRalfifH/or/Av
         JdWUjM9SaUbjFQotcp0anP4rmO10F4vLp32KbThK8xH9IgRzQOPNl6GjPbtBOCbuv/uY
         zeGoIJruytT3Q1qdZntKAvJPVWgNaHs+N0gYe1A28bl10ve5Hsdc4dEwZAS6BS4pHzXE
         55hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708712438; x=1709317238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvmCBum3obDIzEvJJBYCmhBj4c5cWpFkxhaUjZo6Kko=;
        b=lhUIVWehDyaUXA6h4XSupE8bOdd3wu0j9YRPH9FH77soo9tvbcpZbsZtnrNIAKvQHg
         9uND2FWe7Z7fQIHmfYes9fnTW4cjaOfdhxiTCoEsEp+4a0yKWRTRMcgh3mHoQKK0/imc
         QVZ19GhqkOFT9w85ntRj7VynWTpmktiWTD/DBsPQ6dZ64dwIvX/IHSyUkarvPow04EgV
         8L4fQuC0QgdH8eP56UTcDlmhTn0W9qf0ZohHaZ1y1Bj6cTjfXnFsimBMSPybTmhCiVo/
         Z8LtwRQhnbiTs09VVDDn6xuA/NbtJpRyKRKp1XzakLJOUGFljWvku2BiWqmdsfrG+VZk
         tNMw==
X-Forwarded-Encrypted: i=1; AJvYcCVBqQsdf9keqRJ0PTNa4BpEpE5Ms/tWxl+xpPQcOTvgbF5RwiljKO4opp//uccC48QvRXel+uPhJ9nipsL462hxtMYUOqOHExc=
X-Gm-Message-State: AOJu0YwVjDAbJLWQ6CjFlVlFGx+1tagegCczdMKV95HZqbhQQ2lZYagu
	y7q+fgjsXespj9iV4DyeKC8z2VadTHtXwmhPEoMzciVsiPQsmaUg
X-Google-Smtp-Source: AGHT+IGg7ReM16zETYG2CYBHHz4NjUZ7dBtJCjwrpYyfNBFSVowWkw/L6NHszSznrq68kkWUt/LnqQ==
X-Received: by 2002:a05:6a20:4c9b:b0:1a0:ce31:128b with SMTP id fq27-20020a056a204c9b00b001a0ce31128bmr519668pzb.34.1708712437592;
        Fri, 23 Feb 2024 10:20:37 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t42-20020a056a0013aa00b006e06b8548c3sm3986146pfg.139.2024.02.23.10.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 10:20:37 -0800 (PST)
Message-ID: <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com>
Date: Fri, 23 Feb 2024 10:20:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
Content-Language: en-US
To: Guan-Yu Lin <guanyulin@google.com>, rafael@kernel.org, pavel@ucw.cz,
 len.brown@intel.com, gregkh@linuxfoundation.org,
 andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com,
 rdunlap@infradead.org, james@equiv.tech, broonie@kernel.org,
 james.clark@arm.com, masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240223143833.1509961-1-guanyulin@google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240223143833.1509961-1-guanyulin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 06:38, Guan-Yu Lin wrote:
> In systems with a main processor and a co-processor, asynchronous
> controller management can lead to conflicts.  One example is the main
> processor attempting to suspend a device while the co-processor is
> actively using it. To address this, we introduce a new sysfs entry
> called "conditional_skip". This entry allows the system to selectively
> skip certain device power management state transitions. To use this
> feature, set the value in "conditional_skip" to indicate the type of
> state transition you want to avoid.  Please review /Documentation/ABI/
> testing/sysfs-devices-power for more detailed information.

This looks like a poor way of dealing with a lack of adequate resource 
tracking from Linux on behalf of the co-processor(s) and I really do not 
understand how someone is supposed to use that in a way that works.

Cannot you use a HW maintained spinlock between your host processor and 
the co-processor such that they can each claim exclusive access to the 
hardware and you can busy-wait until one or the other is done using the 
device? How is your partitioning between host processor owned blocks and 
co-processor(s) owned blocks? Is it static or is it dynamic?
-- 
Florian


