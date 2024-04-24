Return-Path: <linux-kernel+bounces-157352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331C8B1042
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1C11F23BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DC816C854;
	Wed, 24 Apr 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4tuAbwG"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2616ABE8;
	Wed, 24 Apr 2024 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977444; cv=none; b=oTz+GW9cQNN3AS8R+jYydxab4yq/RlTiaWmwKB4pvRDswgkbeF01f6KmjgrH1abM+xo00BN/3ysOI0MOdN4dQONKr2LIelQxiJSTSXykM0hKhnQ7XwzLbw++Q21Ms7i/hIonlkkxf+2GbSiS07Yv4IhKOCT/IzkHaCqya98N21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977444; c=relaxed/simple;
	bh=EdrlcPLnGVycSPpEr02hj2ZTLSzXFjd113QA3iKYqIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d49Asn6fZnoJDvYP7YqyYWClL0IW5mUjuxLC3M+tdzH1KCOWddFHeEWwWs0+msG6nzkudghGYXLH9K7hU9Zs+r6UdiMxQJvV+SiRlSwAKJLQtde5/cMAX8poYPDQmogtIXdSnbLtZcB6ISi8X4Pa/gArWiRVVrCZ2WAiZC3TidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4tuAbwG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ee0642f718so906662b3a.0;
        Wed, 24 Apr 2024 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713977442; x=1714582242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0NdAJuF+6J2kXUl8f5yMWn7Na8Bw9VM1YHloavWwDc=;
        b=Q4tuAbwGxC8YMQaJq8aQdL0uNbKc2bV2TGwu3BUoxD+zVJ8VbmbR9ohx9ImBWNwans
         c/b5Cb5E+DeKw/P29m4d8cMhUpVJUNV0RxHhCmMCSf7ghevUw5/eggB6qW6/KDm2bO6E
         TMOCoy0/D3qd89CBIWJdRPOFjPdnZDxqRxLW/j+lOD7cnGYwDpb3LRnBO06n0hQ2Zlz/
         MrtYlUBcSdEBqThHmIOOhsdQY38l0/TUYNsrzJRZSVkfoMBNhuD4BZMLuyW0MTaGwyjy
         Zk6gpCibx5DXkWnaoMxR2y2uGJAODl/CLnuv508SW8VAdq+0rCw0TDnoMaxdzKdcaixz
         p4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713977442; x=1714582242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0NdAJuF+6J2kXUl8f5yMWn7Na8Bw9VM1YHloavWwDc=;
        b=tFDQgB/DpRmN5uo6hg7es9OiJxeu5FX3CiBXsTE4wJuYLF8J4NsSVfo00g1whjfnGq
         G0T/dUj117Et1XxAQ5mErp3PsWK4xOFES8XzUuOQd9xoteMfPzdrXFg3VkWmPi/xuQ3f
         /ihHRlxrUeBUCwb++B0+hEhw90Dw9iNuMJ7vUSY4+9X9OIGI8qP94g9yZmKaTz+llGKV
         15LrsbB47RlQVSJcskGgHmcw3sozioXKxW+wC39SBRxDb4AW7snAdhN2JupRGwQ6QDpJ
         Idz00MMkjGtFDtPL69OAvGkuTKWQwTR3o3LLdz07vnVqRWW6TBFsCQTIUCjVMYcLxcmQ
         EF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiZmUNm6tF+8CCSMf+TG/kJgTjHjTRsBfl9V3YjrWlpAxIa6I+kgWIPiW3cakfmzqaZA0niSiv/ot/2h1ElO6z+fa8Mes4eWT9LXNgLaP9RnH0FS8RjeRjwkiI31qyv7+7q0YXWl/NpQ==
X-Gm-Message-State: AOJu0YwTTbGVoEj9v+iwUWwulWpie0HBtk3xjNVauvVe6XBz+wH5tcOg
	tOWGNHXL4OZafwaufMh+8hHQu0wp7zJf0j36oqgvBrorpGKbTUoE
X-Google-Smtp-Source: AGHT+IF7eqgzrHwVVGjjqO23Dkp/jyBqlHb26nGgNc0SrpkVDyhfZEK5f1RlgUaOzNYPEibfY3B/BQ==
X-Received: by 2002:a05:6a20:564b:b0:1a9:509c:eba6 with SMTP id is11-20020a056a20564b00b001a9509ceba6mr326569pzc.25.1713977442298;
        Wed, 24 Apr 2024 09:50:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ka1-20020a056a00938100b006ecfb733248sm12051094pfb.13.2024.04.24.09.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:50:41 -0700 (PDT)
Message-ID: <f98dffd7-bb1c-4023-9a73-fdf2107160d1@gmail.com>
Date: Wed, 24 Apr 2024 09:50:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/irq-brcmstb-l2: Avoid saving mask on shutdown
To: Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
Cc: opendmb@gmail.com, Tim Ross <tim.ross@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "open list:BROADCOM BMIPS MIPS ARCHITECTURE" <linux-mips@vger.kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20240416194343.469318-1-florian.fainelli@broadcom.com>
 <87le55ulw5.ffs@tglx> <958c27b1-26d7-4927-976b-4502f33f31f7@gmail.com>
 <87il09ufl4.ffs@tglx>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <87il09ufl4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/24 16:45, Thomas Gleixner wrote:
> On Mon, Apr 22 2024 at 15:26, Florian Fainelli wrote:
>> On 4/22/24 14:29, Thomas Gleixner wrote:
>>>> +	if (save)
>>>> +		b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
>>>
>>> what's the conditional actually buying you except more complex code?
>>
>> Not much this is an optimization that is simple to carry out. There can
>> be dozens of such L2 interrupt controllers in a given system and the
>> MMIO accesses start adding up eventually.
> 
> I'm impressed by saving ~12 microseconds per one dozen of interrupt
> controllers on system shutdown :)

I know, right? More seriously are you willing to take that patch, should 
I write a better justification?
-- 
Florian


