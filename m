Return-Path: <linux-kernel+bounces-102684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300C787B5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7A01F22A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA352C9E;
	Thu, 14 Mar 2024 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaEyLSYE"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B78BF0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377646; cv=none; b=ByTXgqhILpiM5vPtZGBRYINM+gLdH24V+jv2dr6o4Fsdnv3QiKk8vC5P5zvc47s9LKKIwz7yrDjC5LrK13Wq0mC+YvM6zgOlwnLhR0iBKnFQcV3EbCAumJ536CWip4KRVZBSXgNUy/fEyKqEaRkBQRM8lmPEI5VmDK32Miw5d5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377646; c=relaxed/simple;
	bh=mnNIWLOUf3jUfLRgScmyi+W0U9dYdEDQTaL2zcoZSFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FivZ6t5CkcSaW9QpR6cZYONnAkI2p6JEAbM2OyzVjGsp7yNANA6/IqRJqFPlGvIVlCiIMa1srYP1d3+VZmXc84DNG2MJ1FrKHdePjLvtWfJ+c2v5QsurDeWG0s4iBWtlgBxSOMppRq1sC1A3FxCJ+gYdfOVs0ulFqguGOjxLhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaEyLSYE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5131316693cso620314e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710377643; x=1710982443; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJpGQ68Mh73LfyLqrLfagpl8drWS+K1QPIPD1EIn7ZM=;
        b=NaEyLSYEb34APkb733hDBebSaCe3vg4rgBmWMruAu5wgEMzVkNXb7I3UoBqvoNrJPb
         tQnBmM4321xXk40ySWqAYXnssrrP6yQfF4LEDco4VkYVeaWOIglb6Urs5j5aiKPJBgE3
         119xrzQca8tXGY9MUh9WNW3VXaLzKnkOAnri/mi9zOaChcijvnBOsyesijBwKNQFMCv7
         vmWgOWcsn9HfY4zFW7mmMXe5Wvh1agC/YCHy4cOWBP8KiulYTZWlcQo3zH2TQ5EqlyFq
         K5ppcyETKmZ6IL1fUJST1mI0iR+4j4GbuY8U1KmEUZpWAqRev8ey6jOc3u+x5Fl7RFlO
         kxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710377643; x=1710982443;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJpGQ68Mh73LfyLqrLfagpl8drWS+K1QPIPD1EIn7ZM=;
        b=QM8PVHk8JgouY5SRAuXvu3TFQBynJT7UOVy811+E8DvSTSzCglSs1kn4Ssnb6v4dy8
         ujiS4Bekkv4sSIyai1TUmUFBilzVZA77FiIfSEh8W11NnRr9ZoKWRGLsqiSGrZrZS1Ib
         nbdmeXuIoB27al+07Ypk3sUQR5vMDI+eEnMTCEEEXksvtmVZ/ZNEI66tD8WcqIp153g/
         6ADqEU373L0DOCwMon+xCuBX3K9naqEwTJJ2+oK6HTuu+9fX66ehAhnaZ17FdBOeUrF/
         4t10KU1IsXdOUTWlR/MJrg+XH90MGP35gnBFqOTFkYaabYMAkUQHAUYSkyRXiJDIQNOs
         qUyA==
X-Forwarded-Encrypted: i=1; AJvYcCV7sTPX4q4PNZL+9GfiQ513m636PBiTtwwGf4gYjwumzqY11rwCREOAWAxVxwfpPYr/ilXOrK//M5L+AfiCEbUBKiAQitLDrL/z7x+F
X-Gm-Message-State: AOJu0YzwJhxFBW/37RdJVo5PT3qmu34Ayt9Zjc/l8us/q6z40elms0JC
	ObpJzPvXWS3SXoX5lauV8mn6joR3iNotsDUFw5L+QK6Nfk9dWS5K
X-Google-Smtp-Source: AGHT+IGa/yHMH2XRtD2EICtZB07klEVkbXqqeKDp/yVQQnE1BkmW1wP0f0kZmNlmb1i/ns6Tjdv6pw==
X-Received: by 2002:a05:6512:32a6:b0:513:cfa6:3ea3 with SMTP id q6-20020a05651232a600b00513cfa63ea3mr131518lfe.6.1710377642734;
        Wed, 13 Mar 2024 17:54:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u20-20020a1709060b1400b00a449076d0dbsm153037ejg.53.2024.03.13.17.54.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2024 17:54:02 -0700 (PDT)
Date: Thu, 14 Mar 2024 00:54:01 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/boot: replace __PHYSICAL_START with
 LOAD_PHYSICAL_ADDR
Message-ID: <20240314005401.hhsqmagppuxwdkrs@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
 <20240313075839.8321-3-richard.weiyang@gmail.com>
 <ZfF/ekjP9R91dw2j@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfF/ekjP9R91dw2j@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Mar 13, 2024 at 11:29:33AM +0100, Ingo Molnar wrote:
>
>* Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> Both __PHYSICAL_START and LOAD_PHYSICAL_ADDR are defined to get aligned
>> CONFIG_PHYSICAL_START, so we can replace __PHYSICAL_START with
>> LOAD_PHYSICAL_ADDR. And then remove the definition of __PHYSICAL_START,
>> which is only used to define __START_KERNEL.
>> 
>> Since <asm/boot.h> includes <asm/pgtable_types.h>, which includes
>> <asm/page_types.h>, it is fine to move definition from <asm/boot.h> to
>> <asm/page_types.h>.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  arch/x86/include/asm/boot.h       | 5 -----
>>  arch/x86/include/asm/page_types.h | 8 +++++---
>>  2 files changed, 5 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
>> index a38cc0afc90a..12cbc57d0128 100644
>> --- a/arch/x86/include/asm/boot.h
>> +++ b/arch/x86/include/asm/boot.h
>> @@ -6,11 +6,6 @@
>>  #include <asm/pgtable_types.h>
>>  #include <uapi/asm/boot.h>
>>  
>> -/* Physical address where kernel should be loaded. */
>> -#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
>> -				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
>> -				& ~(CONFIG_PHYSICAL_ALIGN - 1))
>> -
>>  /* Minimum kernel alignment, as a power of two */
>>  #ifdef CONFIG_X86_64
>>  # define MIN_KERNEL_ALIGN_LG2	PMD_SHIFT
>> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
>> index 86bd4311daf8..acc1620fd121 100644
>> --- a/arch/x86/include/asm/page_types.h
>> +++ b/arch/x86/include/asm/page_types.h
>> @@ -31,10 +31,12 @@
>>  
>>  #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
>>  
>> -#define __PHYSICAL_START	ALIGN(CONFIG_PHYSICAL_START, \
>> -				      CONFIG_PHYSICAL_ALIGN)
>> +/* Physical address where kernel should be loaded. */
>> +#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
>> +				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
>> +				& ~(CONFIG_PHYSICAL_ALIGN - 1))
>
>I agree with this simplification, but the ALIGN() expression is far easier 
>to read, so please keep that one instead of the open-coded version.

Sure, will send v2.

>
>Thanks,
>
>	Ingo

-- 
Wei Yang
Help you, Help me

