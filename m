Return-Path: <linux-kernel+bounces-10013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930B381CEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396E41F22CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8A32E620;
	Fri, 22 Dec 2023 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4X/EywzY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FB2C849;
	Fri, 22 Dec 2023 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sWYsiApgV+m5lCNkzjB01cpSiixDUk4lDKnbY8CE1+w=; b=4X/EywzYiclMcgdyUrIDhDGPic
	/aSKzz30MMz6XJ09tuvZNc1ebu/FERjt46xoWsDR51OIvNWy9aII9MVhfdBtqGzeWSrfgsDfRJDBh
	uTETxGNgZnw/XSbLhV9POiDzppFYqtRIIR5hUqPLi383AZOXEzX/zxuECk0pnvUwiyNbbL+quWqR7
	DdZFuFh6hR4LcClV6VSnkgS3MSf41mk/GmIlEf3WFTccH8OkIBq35sEWhsJV+j6OJZczijmJeAusc
	HqHgO9urxd/LyKE/FxfM5wJcgqAb4VMYN57Iyn+DVu6d33Cnw5xuPnoYojd9p958sHcKi+pxneOEk
	MZ87kDNQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlDx-006haX-2f;
	Fri, 22 Dec 2023 19:30:21 +0000
Message-ID: <74c79362-495f-4177-85fc-b348f7ac1c7b@infradead.org>
Date: Fri, 22 Dec 2023 11:30:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/7] doc: Add osdump guide
Content-Language: en-US
To: Ruipeng Qi <ruipengqi7@gmail.com>, corbet@lwn.net,
 rafael.j.wysocki@intel.com, gregkh@linuxfoundation.org,
 bagasdotme@gmail.com, carlos.bilbao@amd.com, vegard.nossum@oracle.com
Cc: skhan@linuxfoundation.org, srinivas.pandruvada@linux.intel.com,
 qiruipeng@lixiang.com, linux@leemhuis.info, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231221132943.653-1-ruipengqi7@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231221132943.653-1-ruipengqi7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/23 05:29, Ruipeng Qi wrote:
> From: qiruipeng <qiruipeng@lixiang.com>
> 
> Add osdump guide for the users who try to compile with osdump enabled,
> use, and analysis real system problem.
> 
> Signed-off-by: qiruipeng <qiruipeng@lixiang.com>
> ---
>  Documentation/admin-guide/index.rst  |  1 +
>  Documentation/admin-guide/osdump.rst | 94 ++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 Documentation/admin-guide/osdump.rst
> 

> diff --git a/Documentation/admin-guide/osdump.rst b/Documentation/admin-guide/osdump.rst
> new file mode 100644
> index 000000000000..5738b03ff684
> --- /dev/null
> +++ b/Documentation/admin-guide/osdump.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================================
> +Documentation for osdump - The Os Minidump Solution

                                  OS ?

> +===================================================
> +
> +Overview
> +========
> +
> +Osdump is a new crash dumping solution aiming at specific embedded

                   crash-dumping

> +devices within Automotive or Industrial having the following features:
> + - limited memory.
> + - require quick reboots after system faults.
> +
> +To minimize the dump file size and maximize the dump process speed,
> +Osdump provides the following features:
> + - excludes userspace memory, focusing solely on resolving OS-related issues.
> + - eliminates constant data such as text segments.
> + - core OS data for dumping, this includes:
> +    - static allocated bss and data segments
> +    - dynamic data such as:
> +       - slub data for small-sized data
> +       - some large-sized data alloced in pages.

I prefer                          allocated

> + - compresses dump data to help reduce dump file size
> +
> +Considering the large volume of non-contiguous data, a binary data format is
> +used directly.
> +
> +By utilizing the dump file and vmlinux, a standard elf format file can be

                                                      ELF

> +reassembled and parsed using crash tool.
> +
> +Declare
> +========
> +Mainly test on arm64 with 2G DDR, selecting slub as SLAB allocator, 39-bit for
> +address space size.
> +
> +Configure and Build
> +===================
> +
> +Kernel config
> +-------------
> +Disable CRASH_CORE, SLUB_DEBUG, and SLUB_TINY, and then select CONFIG_OS_MINIDUMP.
> +
> +Dts config
> +----------
> +Add one reserved region for osdump. Its size depends DDR size you are using. Here
> +add one 16M reserved region with 2G's DDR.
> +
> +osdump {
> +	compatible = "osdump";
> +	reg = <0 0x64000000 0 0x1000000>;
> +};
> +
> +Build the image after you have done with configuration.

                             are
or
                   after you have done configuration.

> +
> +Trigger one panic and analysis it
> +=================================
> +
> +0) Precondition
> +---------------
> +DDR won't poweroff during panic. Its content should not be lose.
> +
> +1) Generate dump file
> +---------------------
> +When a panic occurs, it will dump core data into specific reserved region.
> +
> +echo c > /proc/sysrq-trigger
> +
> +2) Get dump file
> +----------------
> +When system reboot from panic, run the following command to get dump file.
> +
> +cat /proc/osdump > ./osdump
> +
> +Got 13M dump file on my side.
> +
> +3) Run crash tool to generate standard elf file

                                          ELF
> +-----------------------------------------------
> +
> +crash --enable_raw_dumpfile ./vmlinux ./osdump  -m vabits_actual=39 --machdep\
> +	kimage_voffset=0xffffffbf8f000000 --machdep phys_offset=0x80000000
> +
> +Add new feature for crash tool that reassemble a standard elf format file with

                                       reassembles           ELF

> +the dump file and vmlinux. Will submit this patch later.

but this paragraph shouldn't be here...

> +
> +4) Analysis with crash tool
> +---------------------------
> +
> +crash ./vmlinux ./osdump_elf
> +
> +
> +Note
> +====
> +disable when select CRASH_CORE, SLUB_DEBUG, or SLUB_TINY.

Don't repeat that, please.

Vegard made a lot of good points. I tried not to repeat them.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

