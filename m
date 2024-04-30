Return-Path: <linux-kernel+bounces-164239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E198B7B43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D591F238CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3BC143730;
	Tue, 30 Apr 2024 15:14:21 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2813D275;
	Tue, 30 Apr 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490061; cv=none; b=h+2favszlnMob4cFTexopQ8NxRUyiy6Ph1FsJ5wMR225AumICE+6SbvjSzCAEHG5on5i+fB8SXPnYVnqvga9rB7JtgYMBpDy5CDJwQ4v93nDQl49R1Q1sGiefVLhGrWNXGUuu4uMRBgP8b7OaukJVVpUF+bi6yWUZv7nqeXt9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490061; c=relaxed/simple;
	bh=mUx66NGo+sPvkc+tvVGPZI9oRT3hr/+yib3narTd4GA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOcwDBX81kXyQ/vXg5GqAaHW5qhA9gDhbAkNjUfhZ7h8lEb1onx/b9+GaNeX5R/Ujy7oKh4PUrNqNDE4Q/umWZkma/N6LMRheMTGrYrmSESYb6nEQ47YCby7mvtoTlhl8xFdochCTqtciZ4qnI3mBfJhSFqfmzt+joKkIxcNBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTNvZ4rFvz6GD6F;
	Tue, 30 Apr 2024 23:11:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 05231140A30;
	Tue, 30 Apr 2024 23:14:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 16:14:15 +0100
Date: Tue, 30 Apr 2024 16:14:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 5/7] ACPI/NUMA: Return memblk modification state from
 numa_fill_memblks()
Message-ID: <20240430161414.00003334@Huawei.com>
In-Reply-To: <20240430092200.2335887-6-rrichter@amd.com>
References: <20240430092200.2335887-1-rrichter@amd.com>
	<20240430092200.2335887-6-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 11:21:58 +0200
Robert Richter <rrichter@amd.com> wrote:

> When registering a memory range a possibly overlapping memory block
> will be extended instead of creating a new one. If both ranges exactly
> overlap, the blocks remain unchanged and are just reused. The
> information if a memblock was extended is useful for diagnostics.
> 
> Change return code of numa_fill_memblks() to also report if memblocks
> have been modified.
> 
> Link: https://lore.kernel.org/all/ZiqnbD0CB9WUL1zu@aschofie-mobl2/T/#u
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Seems correct to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

