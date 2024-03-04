Return-Path: <linux-kernel+bounces-89998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F186F8C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8771CB20E25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2497F4A15;
	Mon,  4 Mar 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJbLIZXS"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED217CE;
	Mon,  4 Mar 2024 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709521684; cv=none; b=oH4eTpdrAmJO6nZjrCLsAmatrS1ef7aUugsSJc2xdu4UfYzGMUS7ConQEZX3d+kCWiTCKFOF0Pqpr8FjNFlybGq0d0JUUaqPpT+oKoH9KmVDTZbgjAAueluHiVt5mt149Y3e6zDKkZgjgdrauqOIGBf7nljs3oCeDH/PAGvPJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709521684; c=relaxed/simple;
	bh=3BI8B2Bp4XeQbxQpsn++p8FJGrgiOurWA5aDjJl5cVM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+t/l62vqLVD+ozBnmF7msudSU7JysRE7F+Kkz87EkS+ldxdHNfCVHZmd2ml4q1M5ISrdryzX9frRMwXymE7pCDynyoZajacjPCkDs9vcJtPktawdsGGU2BwlXQN4c5P1T5QsZc9ira0ur4jbCby9ulAr5UYvUysuLyJbG+ovqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJbLIZXS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so1219277b3a.1;
        Sun, 03 Mar 2024 19:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709521682; x=1710126482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=09c5Ld8ZWpizXtKH4r3UpdHmyvyQCrCH0kV5BMr3LS0=;
        b=QJbLIZXSrqr+kTTbEsicCODd2Q/7qSA5XMkjsNnu1lyoVMEd0PX4IuV5cbIunjyw66
         gYjL8fEDIvNXgOA509EYO9Y5TxW2ZO0stAvFYLyFrTRQvfJXQ+Mn0YoM65SIKqIRklwy
         nMt7/9FCrkgnw66UhgZo6GiYsS5DIDsmdkB2alTRFzphDhno18N9fBpgax9qlRh5k/jJ
         e8xrNL9nLPqqcQAApZbEe7zCDkMvE40LVw81jfQBkHILjDCWOA22w8p5qXGfd01rXsdn
         NsoweUOE+DVrPa2r/tKzqWp6yyEQG1sREd9bzxxnK9YfP7aSpwgUxkUlkL15yjPPktz0
         Gavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709521682; x=1710126482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09c5Ld8ZWpizXtKH4r3UpdHmyvyQCrCH0kV5BMr3LS0=;
        b=QjcuBNKyBzWP5GTuAhNfzWUqMXjVQD04hEz8BoelDf2cc3xL6yL3R4XjH19Bsjf9tD
         ZaN5Dde3yRA0jepM5p6zh9e2l/lddwCbMqZ4L974iZObdtMqmL2zlv3ejjfvOUtxwLIG
         JnIlJIK1vp6CCBIx9DhRIqyoONLiDrqwyTaUhVCtE0lgb9KikqJSVk2TEbRAzvdfm20S
         5rPIT+0scoQbWUpGexxUCq0imUnwFq8SxeRDBjpsFpdhRw4h7oFzzXhbahYdRKukjZC/
         AoxGyTiqKZRic7zhYns/rphwpIPhOWnnbC5jpMg94ogaqe9ZhMDuBMEEntNNbrj8NEjg
         iXDg==
X-Forwarded-Encrypted: i=1; AJvYcCWuMEWl0WrbE8EOFiIjnzIO4izAXCsEleWvYWEGDueQ1MqexzGuE4vhPsBsLCeSCM6h+EckfWzSPcjDpH5OCP/+vXW+P/1LwxLl6ffCpZvp3s4oCBCEF3SJSneiymb3nHswmRzTFhDy+MfRT3NJ7CF+nqIsWuYRCptt88H+vPeuxQvNAg==
X-Gm-Message-State: AOJu0Yz3sAtTVoaRJ5cS/GxQIa/EyB70w/eFPc0XU36zgnSnpMQ/0na1
	C7SifHf8g64R6qZmLA5ACNlHteRKroPgrUfByowdrCGnWbEsz5RO
X-Google-Smtp-Source: AGHT+IG2uYM8bLWoyeF3gdZVlOJfprj9tSG/wxizpVtatiHSeXDThSwnJefuUnh4WouBjPO9U9WXKA==
X-Received: by 2002:a05:6a20:8f29:b0:1a1:461a:3691 with SMTP id b41-20020a056a208f2900b001a1461a3691mr6916853pzk.15.1709521682220;
        Sun, 03 Mar 2024 19:08:02 -0800 (PST)
Received: from debian ([2601:641:300:14de:bae0:aa65:8bdd:7233])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78643000000b006e0debc1b75sm6348979pfo.90.2024.03.03.19.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 19:08:01 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Sun, 3 Mar 2024 19:07:40 -0800
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: Hao Xiang <hao.xiang@bytedance.com>,
	Gregory Price <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org,
	john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>,
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huang Ying <ying.huang@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 0/1] Improved Memory Tier Creation for CPUless NUMA
 Nodes
Message-ID: <ZeU6_BnXIUs6pCym@debian>
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301082248.3456086-1-horenchuang@bytedance.com>

On Fri, Mar 01, 2024 at 08:22:44AM +0000, Ho-Ren (Jack) Chuang wrote:
> The memory tiering component in the kernel is functionally useless for
> CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the nodes
> are lumped together in the DRAM tier.
> https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

Is this the right patchset you want to refer to? It is about node
migration between tiers, how is it related to the context here?

Fan

> 
> This patchset automatically resolves the issues. It delays the initialization
> of memory tiers for CPUless NUMA nodes until they obtain HMAT information
> at boot time, eliminating the need for user intervention.
> If no HMAT specified, it falls back to using `default_dram_type`.
> 
> Example usecase:
> We have CXL memory on the host, and we create VMs with a new system memory
> device backed by host CXL memory. We inject CXL memory performance attributes
> through QEMU, and the guest now sees memory nodes with performance attributes
> in HMAT. With this change, we enable the guest kernel to construct
> the correct memory tiering for the memory nodes.
> 
> Ho-Ren (Jack) Chuang (1):
>   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
>     HMAT info
> 
>  drivers/acpi/numa/hmat.c     |  3 ++
>  include/linux/memory-tiers.h |  6 +++
>  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
>  3 files changed, 77 insertions(+), 8 deletions(-)
> 
> -- 
> Hao Xiang and Ho-Ren (Jack) Chuang
> 

