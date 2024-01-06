Return-Path: <linux-kernel+bounces-18658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A928260A3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9561F21268
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C57D537;
	Sat,  6 Jan 2024 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2jTszp5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCCBD51B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e741123acso532442e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 08:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704558986; x=1705163786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2PkbTEqLvSjOGH4gAdgvm5eYy4RG+4E+lRHHV2QJza4=;
        b=E2jTszp5GaANSCDdcDKruErCsroQtjocwhWXqUt8CPZrsj5SgFUCRr9qoAgYsKGPSA
         WtQIv57y+z1KWgNbZ6spOtDimcIC1YDbk3Qgd0kXFf2VdMj8IB+JTRsQ49cLLfh/UxH9
         YBk6zdfG3mgYUoM5gEnZIEP3139HrE7T8S9GlBw45wXy5cUFiOVqvuySsIiysxYUELmU
         3yUCbrXEFZv0LzMy58fq3+FEDmt8GhU7XNc1ctG1NuvzGRQlRhLvuAhe18e0cyjgyt+r
         LuVdcuvnK1RgJsFvP1pO7Zf+HHHXv2CcGkBYDMfixI6AZfIjvmTY/ZKtxKHsa0/Aht1l
         Wwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704558986; x=1705163786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PkbTEqLvSjOGH4gAdgvm5eYy4RG+4E+lRHHV2QJza4=;
        b=BSAKxpjHr9JW7QZHnFdvjqlGuV7kFIaPIsFR3dyO/KlME06XVM0N5KYYMNGPvq7k5Y
         4uNXiTOMvGMFYnvo2RdKCO0dk99/kEcriqYANoAeqZu4h+mtTN3J2QBRanpUBu6Wiru5
         +qyHj0Y6ovrjSEIggqI1GX2gx0VDx0olG//M1CnDh8DjJB3Cn0rcaQ6esYJDDoQCnazz
         fA+tpEvACXTqlrN9CNYNAIJWM9MOmgrabPv2C4RUEeBXjk2Im/j8HNCThVai+cmfM6jp
         6EyKBxEWMn0r4mpScm1U64pa3I8QRq23dQp4jd32GU/jUzPVIRqmdNPnecYPPiEOVi0W
         cQfA==
X-Gm-Message-State: AOJu0YxTrsR3NxiqdunJklzZbSjeE71N2grra5+ywVcNemVAAhHFlqE8
	1wYYTicdZ54lsPxvbxdS1+k=
X-Google-Smtp-Source: AGHT+IGx58E/aB8XT4+HDN2sbb8Yr4CM8JOoydFTdDzNP6CGkX6RTKDZF4zPDJyYa3KMVmh4U0huNQ==
X-Received: by 2002:a05:6512:36d3:b0:50e:7f88:f541 with SMTP id e19-20020a05651236d300b0050e7f88f541mr437850lfs.16.1704558986281;
        Sat, 06 Jan 2024 08:36:26 -0800 (PST)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id r8-20020ac25f88000000b0050e67d56093sm566500lfe.224.2024.01.06.08.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 08:36:25 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sat, 6 Jan 2024 17:36:23 +0100
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	shaozhengchao <shaozhengchao@huawei.com>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/11] mm: vmalloc: Remove global vmap_area_root
 rb-tree
Message-ID: <ZZmBh-g_evLcNHT1@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-5-urezki@gmail.com>
 <238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com>
 <ZZfe4O850fFaxOgQ@pc638.lan>
 <52766da2-41de-41ce-b60b-1118da343b8a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52766da2-41de-41ce-b60b-1118da343b8a@linux.alibaba.com>

> 
> On 2024/1/5 18:50, Uladzislau Rezki wrote:
> 
> > Hello, Wen Gu.
> > 
> > > 
> > > Hi Uladzislau Rezki,
> > > 
> 
> <...>
> 
> > > Fortunately, thank you for this patch set, the global vmap_area_lock was
> > > removed and per node lock vn->busy.lock is introduced. it is really helpful:
> > > 
> > > In 48 CPUs qemu environment, the Requests/s increased by 5 times:
> > > - nginx
> > > - wrk -c 1000 -t 96 -d 30 http://127.0.0.1:80
> > > 
> > >                  vzalloced shmem      vzalloced shmem(with this patch set)
> > > Requests/sec          113536.56            583729.93
> > > 
> > > 
> > Thank you for the confirmation that your workload is improved. The "nginx"
> > is 5 times better!
> > 
> 
> Yes, thank you very much for the improvement!
> 
> > > But it also has some overhead, compared to using kzalloced shared memory
> > > or unsetting CONFIG_HARDENED_USERCOPY, which won't involve finding vmap area:
> > > 
> > >                  kzalloced shmem      vzalloced shmem(unset CONFIG_HARDENED_USERCOPY)
> > > Requests/sec          831950.39            805164.78
> > > 
> > > 
> > The CONFIG_HARDENED_USERCOPY prevents coping "wrong" memory regions. That is
> > why if it is a vmalloced memory it wants to make sure it is really true,
> > if not user-copy is aborted.
> > 
> > So there is an extra work that involves finding a VA associated with an address.
> > 
> 
> Yes, and lock contention in finding VA is likely to be a performance bottleneck,
> which is mitigated a lot by your work.
> 
> > > So, as a newbie in Linux-mm, I would like to ask for some suggestions:
> > > 
> > > Is it possible to further eliminate the overhead caused by lock contention
> > > in find_vmap_area() in this scenario (maybe this is asking too much), or the
> > > only way out is not setting CONFIG_HARDENED_USERCOPY or not using vzalloced
> > > buffer in the situation where cocurrent kernel-userspace-copy happens?
> > > 
> > Could you please try below patch, if it improves this series further?
> > Just in case:
> > 
> 
> Thank you! I tried the patch, and it seems that the wait for rwlock_t
> also exists, as much as using spinlock_t. (The flamegraph is attached.
> Not sure why the read_lock waits so long, given that there is no frequent
> write_lock competition)
> 
>                vzalloced shmem(spinlock_t)   vzalloced shmem(rwlock_t)
> Requests/sec         583729.93                     460007.44
> 
> So I guess the overhead in finding vmap area is inevitable here and the
> original spin_lock is fine in this series.
> 
I have also noticed a erformance difference between rwlock and spinlock. 
So, yes. This is what we need to do extra if CONFIG_HARDENED_USERCOPY is
set, i.e. find a VA.

--
Uladzislau Rezki

