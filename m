Return-Path: <linux-kernel+bounces-112518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39705887B17
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB5E281C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990065B697;
	Sat, 23 Mar 2024 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzOnuXtw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BF55B5D3
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711236141; cv=none; b=LXoxBGQDvSKJDW0QHf9hykF9jZ14OP4lDOuMPB0gztw/P0bjS7OOq+FuPfb1KWiCV1UnL2rYBT01AA8FPn5y1wbTtcJVfK3GTCFKgoG9IoOLgrw3qy8XIGG49z2u+oN0OuNyMbv4Nnzx4GQ/y8bYbkgGBIKD4iJNKMRLO3jL1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711236141; c=relaxed/simple;
	bh=mHKzunZSIQRTWpF1EaF5fmMKIa7EpDeGw9/AMj3co4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raVqBd1TRzKP1B2097CHsdcDK+SPFbBFOglZU+UlEt5cgKKpQAAEgNkygRNCSi5/rt0wA5eC4ogTUne0dFQlwZeI1b8f+W/S4VtzBiM1RuSLvJcnOaUUUGvKN//o5AASBSAJ9Wq+B6mnNfz1k2jRPAZg2Ekrb8SjtoqjhEXdQ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzOnuXtw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dff837d674so25667395ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711236139; x=1711840939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=numYesfytiCMENJq6OnJjqLqRHuG6hVWKsAhBliDRBI=;
        b=GzOnuXtww6xh9u4cEOep1dxdja3MDEi5+orFuvlEiWTcvJRGb6bBYGVW5i/gG0S8ci
         2EcTC8gbKy11K1LNKAbH+YVuDpQFcnbbFFu8LabXc3Sj8D2+9IWOxvngdDlNzaK2jFZq
         Vb1TO6lMYI4o1j+u5YD71TmzXwFR610ojlxr6xrRCAehlN9MLX0i71wuOUnTbqcU21J6
         3tE9rNHNK8JmFZPGjy6aEkRSgEviPvy1AEHrVmnhurFQ9m9xOK7ioiKwGOrPQ/UBYlOp
         Ji7tGpUykfJiE4Ga5oWdtLyXMAERSoN2ZP9z5VGrQ90Tk/EMbpCDA9w0O62rad2Lc4YK
         h34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711236139; x=1711840939;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=numYesfytiCMENJq6OnJjqLqRHuG6hVWKsAhBliDRBI=;
        b=xQpDfY3C2nZbbqoM0MN4387VFozyIh5gmK4QYIvXOSDBa6py4+/Quu1sDwWXSUee7e
         g24yJruEu2YUFRghmP5pjAzoPRedtoCNLHHGJrW8zRE/iZB53ueOgh/WyrtZ/AEfSM69
         h4Wy05Hwx5QMq0PFsvdgCgytKphDek91VAKAvfKfGOXFNnsPhC/xHhFowVzppQ+nXT54
         fmc8B8OKoIVtnATRxNAh+nIxOwivykRMNM2TerpWtUJLMN9A+zez8XFaxSJ3PVnUx2HC
         kG43J8ZXExGKslocNVZCf75sZoh2YpSgrvto6s2nb4koWuISWjG9gr/F2OyMSL32GMjX
         d4mA==
X-Gm-Message-State: AOJu0Yyf4dh6szjqefgNeBTdurtFcfJxaToFu9Gg/awzCfk8dbe0gHdj
	UJYQifktO0Xw79/2QgIDY0ReS64gdPcFyDUyexN7G2ucC+OP3lIi
X-Google-Smtp-Source: AGHT+IH7da+U373OlerZB2riMg4zTVvLs0rMSJ4B7kduDkb/wrETjP88PCq6XjGEpElQSc/CS/fU9w==
X-Received: by 2002:a17:903:181:b0:1e0:b461:d10f with SMTP id z1-20020a170903018100b001e0b461d10fmr390484plg.59.1711236139274;
        Sat, 23 Mar 2024 16:22:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709029a9600b001e00e17c4e0sm2073727plp.49.2024.03.23.16.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 16:22:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <90868fbd-8691-4d72-b211-9ecf2f6629f7@roeck-us.net>
Date: Sat, 23 Mar 2024 16:22:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: vmalloc: Bail out early in find_vmap_area() if
 vmap is not init
Content-Language: en-US
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>, Dave Chinner <david@fromorbit.com>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20240323141544.4150-1-urezki@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240323141544.4150-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/24 07:15, Uladzislau Rezki (Sony) wrote:
> During the boot the s390 system triggers "spinlock bad magic" messages
> if the spinlock debugging is enabled:
> 
> [    0.465445] BUG: spinlock bad magic on CPU#0, swapper/0
> [    0.465490]  lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
> [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    0.466270] Call Trace:
> [    0.466470]  [<00000000011f26c8>] dump_stack_lvl+0x98/0xd8
> [    0.466516]  [<00000000001dcc6a>] do_raw_spin_lock+0x8a/0x108
> [    0.466545]  [<000000000042146c>] find_vmap_area+0x6c/0x108
> [    0.466572]  [<000000000042175a>] find_vm_area+0x22/0x40
> [    0.466597]  [<000000000012f152>] __set_memory+0x132/0x150
> [    0.466624]  [<0000000001cc0398>] vmem_map_init+0x40/0x118
> [    0.466651]  [<0000000001cc0092>] paging_init+0x22/0x68
> [    0.466677]  [<0000000001cbbed2>] setup_arch+0x52a/0x708
> [    0.466702]  [<0000000001cb6140>] start_kernel+0x80/0x5c8
> [    0.466727]  [<0000000000100036>] startup_continue+0x36/0x40
> 
> it happens because such system tries to access some vmap areas
> whereas the vmalloc initialization is not even yet done:
> 
> [    0.465490] lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
> [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    0.466270] Call Trace:
> [    0.466470] dump_stack_lvl (lib/dump_stack.c:117)
> [    0.466516] do_raw_spin_lock (kernel/locking/spinlock_debug.c:87 kernel/locking/spinlock_debug.c:115)
> [    0.466545] find_vmap_area (mm/vmalloc.c:1059 mm/vmalloc.c:2364)
> [    0.466572] find_vm_area (mm/vmalloc.c:3150)
> [    0.466597] __set_memory (arch/s390/mm/pageattr.c:360 arch/s390/mm/pageattr.c:393)
> [    0.466624] vmem_map_init (./arch/s390/include/asm/set_memory.h:55 arch/s390/mm/vmem.c:660)
> [    0.466651] paging_init (arch/s390/mm/init.c:97)
> [    0.466677] setup_arch (arch/s390/kernel/setup.c:972)
> [    0.466702] start_kernel (init/main.c:899)
> [    0.466727] startup_continue (arch/s390/kernel/head64.S:35)
> [    0.466811] INFO: lockdep is turned off.
> ...
> [    0.718250] vmalloc init - busy lock init 0000000002871860
> [    0.718328] vmalloc init - busy lock init 00000000028731b8
> 
> Some background. It worked before because the lock that is in question
> was statically defined and initialized. As of now, the locks and data
> structures are initialized in the vmalloc_init() function.
> 
> To address that issue add the check whether the "vmap_initialized"
> variable is set, if not find_vmap_area() bails out on entry returning NULL.
> 
> Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>


