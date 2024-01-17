Return-Path: <linux-kernel+bounces-28551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9DB830005
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5503C1C23A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA88C0B;
	Wed, 17 Jan 2024 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGyMzZZh"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341B945A;
	Wed, 17 Jan 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705471912; cv=none; b=bX3u9o6uIMOXPe5gtus1zG2inScvnH4snh2HNS5JohPj0svuDBzS7Jo3TY/zo9J5TFMad9bEuJXMLbzJoiEBmft9oYYfZL5YFO1CJtuXFw8P2RYhjGgdXdyMdMHzJJOp8eR8DTB/qpUs8pQcn1Kqvfdix9rT4lW0WJLf9qTi964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705471912; c=relaxed/simple;
	bh=agyNKKHeWmBULe5eCNrnhpH47X6wjlLOcZf7OlF16TQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=WVps+iayEvilx6uKfN2BVneAWWBoS+az4BnRz6BHUc+uocXBhfE85RKd/vdjzppVndLds88DYsD8Fz5qC+hwFd2xQcZV+FiTZN9oaZ9I0fUFyGBBi4/Ixc9eUbADXcvfMa3MKIEoDGOHoSohnz/RgX02A53NxgttKVKYoQyjp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGyMzZZh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso5036519a12.2;
        Tue, 16 Jan 2024 22:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705471911; x=1706076711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OuJailNbnMKsoTe4rvq4VOL/78ldsC8lUzKL4himcuw=;
        b=UGyMzZZh9FdwMDIRGSytAaHsO/FGpSl9uWe2x5wTCgFeO7bVlkhrddaiDbcbdKHLB1
         vVucVQ8jF0LfNKwoJr6Nu5y1+EryePmEEPwsZOKPnpL2ZJ0iww0vCXV3+FN/t2EBCGX5
         fcY+0sOg644DB0LHTjGpLoJeqkfJvjyFjnqeEhvA0UY6JrAqExlXkk1zr5lCDeSoYpcj
         QnWtI0dpycnssfyOa/KGOwnJM1ncrgbq9PhHab2cd+QFJ7Zw0wgrlzFfklb5c1oRX6t0
         myLl0TkmMC7PjUfTXa41+Xgj91MZM4G5VxyKTKysht5inG+34mPYnZHc0BW6vNCfwYeu
         YzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705471911; x=1706076711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OuJailNbnMKsoTe4rvq4VOL/78ldsC8lUzKL4himcuw=;
        b=Z0xLU515h7BectVQjpO3A+vJzuoN5+Il2cJKCyvygg2etC05ICO9GbAaQiDem6j05c
         apuGFF0IyGIJ43UbEQ7MaHI5yuwOe4Mkpo/HKG/PVHLEo5ipDZsICAQLfgjg2qiu6AOl
         qDJZRxz1zjfVIqXz2Qgn61GcYqxA+rQ/ZXlKfFlTofJMtKTKp/OvxiIp6ieMPSJALvFK
         mv3v9N4gNWX9pcjwIHiFk2AhRCA8BWAAeMRyKPc8kW3snFge7XZGgT24r5kx4J1EPeuX
         1XrQ3/1FK3YpBs5VkRS6ZY4LC28PE+UTl+QX8k/NqwwpYoFu8j02iP902wBW+hplgczs
         +0zg==
X-Gm-Message-State: AOJu0Yzw7lVafXmZ7rbC6xCC4kQLbDMYE+gmYmwXZKifbhjNmrA4RGaa
	j572qPC8N1ervIcUsryTycwZ8oTAsQs=
X-Google-Smtp-Source: AGHT+IHJTgNC3XOQcrLVeV1yrDVV12NKDyRqb4t0DsgepV6OX32Ke9U2ebYhPQKqqd9SPiVcfX2FQQ==
X-Received: by 2002:a05:6a21:3982:b0:19a:fa18:c2fe with SMTP id ad2-20020a056a21398200b0019afa18c2femr3179002pzc.44.1705471910635;
        Tue, 16 Jan 2024 22:11:50 -0800 (PST)
Received: from [192.168.7.25] (45.78.55.121.16clouds.com. [45.78.55.121])
        by smtp.gmail.com with ESMTPSA id mi15-20020a170902fccf00b001d5f009a69fsm1637873plb.142.2024.01.16.22.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 22:11:50 -0800 (PST)
Message-ID: <ce4f98a3-7683-490b-a717-0eeb035cbd86@gmail.com>
Date: Wed, 17 Jan 2024 14:11:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix length of strscpy()
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240101175051.38479-2-pugokushin@gmail.com>
 <cb12eefa-9588-4244-a1de-b1ea62f6096d@kernel.dk>
Content-Language: en-US
From: Guoxin Pu <pugokushin@gmail.com>
In-Reply-To: <cb12eefa-9588-4244-a1de-b1ea62f6096d@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/01/2024 05:26, Jens Axboe wrote:
> On 1/1/24 10:50 AM, Guoxin Pu wrote:
>> In commit 146afeb235ccec10c17ad8ea26327c0c79dbd968 ("block: use strscpy()
>> to instead of strncpy()") , the length that should now represent the length
>> of the string with the terminating NULL was not updated alongside the
>> change.
>>
>> This has caused blkdevparts= definition on kernel cmdline to be not
>> correctly recognized and partitions not correctly initialized, breaking any
>> device relying on such partitions to boot, on stable releases since 6.6
>>
>> This patch fixes the lengths to contain the terminating NULL.
> This needs a Fixes line.
>
Sorry for the late reply.

Thank you for the review. The Fixes line was added and I've sent the new 
patch as "[PATCH v2] block: fix length of strscpy()" earlier on Jan, 2nd.

And since 6.7 is out, do I need to rework the v2 patch and add cc stable 
6.7.x?


