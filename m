Return-Path: <linux-kernel+bounces-102685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0C187B5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCB92832A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61380523C;
	Thu, 14 Mar 2024 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKZfX1Rn"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA04A08
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377670; cv=none; b=TsByd6rTx8vQThi2nMdZXAdHObd2yB7Huxn8l82XC48Aa6K0LcOGKAhRV5qixOOGB7ABBRRM3LIm/HmhbCtPmsZlNxbnMdeQwSOVqiSZxUIemLz0Q2kx57orLSE8SrbkUJaeAjX9FnKhlSrH1cAMF9DgQR+RTt+nDqteag1js+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377670; c=relaxed/simple;
	bh=LmqHoxohNH/kQuq4gaMgzO0rmeG9VOjuhO5wq+Wm214=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKmz5WEUAwPC2VbxUp4T8zKC6vqq/Cb3kE3q64qFSjDmtkaPIV1rOd+RazzXbyAQ2XEvG7s7fGaqcAvhvnxz9rriElB8R5O2BS87JhENjwDUAtHhkdl6qogAi6JLsLREqlVEoXTpudI5kvpYVqss0QO1Phd1+LyaFFMIflQIpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKZfX1Rn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51321e71673so555850e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710377667; x=1710982467; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mqJPs1wz+Vc99rAJkyLVt9LcomnEQsuq+Ot/gHWQyw=;
        b=GKZfX1Rn6itYvfrzZzAeW+G/XOeYG6YZgtIF6fvsNv+fTrV1g5L6NqOO7NeWrXd0Cj
         uqYUhIwter/pGK41BCYo5Bvn/ARqQzSCQW9kOZyzglxfmhCsyp8RG98SjET6uyOGFvO3
         uOsacirnNbYEQIP0qEzsxDbVxxvttkbbUXCovMK7c/ZEjknb6xePl3HghxvDi+L6QCvJ
         noy6u5SnfSiNWKMxhhfDeNAGlb0DcVGvQDBVCix0JeBbGcoHWEJwzyqrQQH/XN0tV9Q5
         a0bMf0kD+5q/eg3cCdwYr3YRCu8VpxbkjJuJpojGZ7WWP8mMFsQxoiEg4zu382fbGjjm
         SM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710377667; x=1710982467;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mqJPs1wz+Vc99rAJkyLVt9LcomnEQsuq+Ot/gHWQyw=;
        b=bCr9egfGSJi9WUXOH0qgC3Iq5qdnbk2ZBI4XiUQ+BvZwrS88qDBHMA1NWOuY2DfSpE
         eSALN1IcwHzmr5D8c10fpo7saiOTdrR0cVnFI0ay/8x+1kET+lKW+CIPHUYTp/lNX1Pr
         cWXoAy7piP2zqb6H0kaYzRJU7S6Fa0hDH8MsdbG8uMfoIQNJHXdLmFledUritjZ4KuQH
         euWO7WgcgMSiW2FoWYa439+0Gc32kz5rOuY3dCHU2oerPc8Yx7U6mHhE4oFmtTZmsOff
         hcwuMkeXxY3/Ku4NsxSA72Wcd8IwlELXRd/wQJrT9wO7DUX284nIaYzkOIlcEbZV6Gll
         Hi0w==
X-Forwarded-Encrypted: i=1; AJvYcCWJuQRXMGo7+2lqiAywYeJCEWZp5w40+57b/TTacuUKQAk+ok8g5l4HI6WrzGORZPMtA/UYR9MwtVRQic7tZonXoiXWcdO03pfVr60R
X-Gm-Message-State: AOJu0YyN6He2Smy5PANTYT/tTSuR0K+C1R2T6MNaAZf9XNk5XjLo1ziO
	VntTaSuLx3CpdPuBe8mToQxV3E2aUonyRPHPso5AfKA37xoOeyv3
X-Google-Smtp-Source: AGHT+IGwoBE1VCIpeZaAe2/7OY+mDv7pxLP7Yb+1flrcTWrV/kKpYq0VEUSoGEnawpLOE0z3Td63aA==
X-Received: by 2002:a19:8c01:0:b0:513:25c6:e98e with SMTP id o1-20020a198c01000000b0051325c6e98emr114739lfd.1.1710377667139;
        Wed, 13 Mar 2024 17:54:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h11-20020a1709062dcb00b00a466b8c2c72sm148659eji.162.2024.03.13.17.54.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2024 17:54:26 -0700 (PDT)
Date: Thu, 14 Mar 2024 00:54:26 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/boot: replace __PHYSICAL_START with
 LOAD_PHYSICAL_ADDR
Message-ID: <20240314005426.5c3vqgxpq7pxs4h5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
 <20240313075839.8321-3-richard.weiyang@gmail.com>
 <d167bf69-64f7-4b7b-81ee-054f05d39c98@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d167bf69-64f7-4b7b-81ee-054f05d39c98@suse.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Mar 13, 2024 at 12:29:37PM +0200, Nikolay Borisov wrote:
>
>
>On 13.03.24 г. 9:58 ч., Wei Yang wrote:
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
>>   arch/x86/include/asm/boot.h       | 5 -----
>>   arch/x86/include/asm/page_types.h | 8 +++++---
>>   2 files changed, 5 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
>> index a38cc0afc90a..12cbc57d0128 100644
>> --- a/arch/x86/include/asm/boot.h
>> +++ b/arch/x86/include/asm/boot.h
>> @@ -6,11 +6,6 @@
>>   #include <asm/pgtable_types.h>
>>   #include <uapi/asm/boot.h>
>> -/* Physical address where kernel should be loaded. */
>> -#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
>> -				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
>> -				& ~(CONFIG_PHYSICAL_ALIGN - 1))
>> -
>>   /* Minimum kernel alignment, as a power of two */
>>   #ifdef CONFIG_X86_64
>>   # define MIN_KERNEL_ALIGN_LG2	PMD_SHIFT
>> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
>> index 86bd4311daf8..acc1620fd121 100644
>> --- a/arch/x86/include/asm/page_types.h
>> +++ b/arch/x86/include/asm/page_types.h
>> @@ -31,10 +31,12 @@
>>   #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
>> -#define __PHYSICAL_START	ALIGN(CONFIG_PHYSICAL_START, \
>> -				      CONFIG_PHYSICAL_ALIGN)
>> +/* Physical address where kernel should be loaded. */
>> +#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
>> +				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
>> +				& ~(CONFIG_PHYSICAL_ALIGN - 1))
>
>Why don't you simply define LOAD_PHYSICAL_ADDR via
>ALIGN(CONFIG_PHYSICAL_START, CONFIG_PHYSICAL_ALING) it's way more readable.
>

Sure, will do it.

>> -#define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
>> +#define __START_KERNEL		(__START_KERNEL_map + LOAD_PHYSICAL_ADDR)
>>   #ifdef CONFIG_X86_64
>>   #include <asm/page_64_types.h>

-- 
Wei Yang
Help you, Help me

