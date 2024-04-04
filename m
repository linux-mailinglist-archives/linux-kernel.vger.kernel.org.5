Return-Path: <linux-kernel+bounces-132067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE9898F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED831F25074
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500781350D6;
	Thu,  4 Apr 2024 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="QSzLaYoR"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8413473D;
	Thu,  4 Apr 2024 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260823; cv=none; b=KBWlFiQlqUNg3JD98DAVu1XzH6CbOyEfXWmTrPDEeDwlAY4LKVZV9kcW5iQ7lX7uNLW1nmcM7g9Nd8v3dGnmamR4LNdG/qyANpY14Uf4ThRhJWAvPOvu5ZwMAfNa9dCx/DwZVADOSNqZsMZUB15M2bSTz6ggFAyKoTVQs9aQuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260823; c=relaxed/simple;
	bh=VkyQOwhX0POpiVMq8+gw5wqGIfOpK1hRYU/I34lI+sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOMGFyD6nzjFBhqmLOPwaT4H81S9bknGhJglTjUdJhkqcKY2OjR4RHeu1p9EVHdxijpYoy3+Fv/Yl9FkVdRT0LcrJX1LzIDYImMkTft2cBcDD2n7V2GTZJ41aTbazB1kMr12vFcm7/k0nV2hzq3orUgwxmdCnqPQU9bPimtw7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=QSzLaYoR; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434Hxp44027220;
	Thu, 4 Apr 2024 19:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=w680ITrszYT2heZFFUe+ftzKpRdYzCkxaiZzn5aJnSs=;
 b=QSzLaYoRyr2RKvibIJzmwOXObT9opMEGjHZ9Qm16dJLO7vKVxnmnVN50dRCMDem1Vn1S
 p/6/CBFHYmobaO+mtxdn8U0Meeg1/v5xNkn8IP62HZ9TYvT7QKkW0d7RTdM6fpcL8Br7
 DlJuIdDYkAesQ7e+YsWIJLcXPDgu54ZyfsSJLOFNDbKICVkDiVm6LPk4eHhGI+klpGtn
 TtqdgGF8FIu2BACS3vctBwhtcctoY0Zl9VYLIo9NX8lEWjhGxbpisjNI0u1iGph39Xom
 HMRThWHXmZjfufrgMZGSvNOFQGXmZR2I9OI3EJx9o+smKLCUjtfFtd3fcr6R0J5mXFpF +g== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3xa08es6f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 19:59:10 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 594B88059E0;
	Thu,  4 Apr 2024 19:59:09 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 8B2F2800ED6;
	Thu,  4 Apr 2024 19:56:43 +0000 (UTC)
Date: Thu, 4 Apr 2024 14:56:41 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Steve Wahl <steve.wahl@hpe.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Russ Anderson <rja@hpe.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
        Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <Zg8F-YmsY4DeBOAw@swahl-home.5wahls.com>
References: <87o7b273p2.fsf@email.froward.int.ebiederm.org>
 <ZgHTXvCQr6ycbVzp@swahl-home.5wahls.com>
 <87r0fv6ddb.fsf@email.froward.int.ebiederm.org>
 <ZgQ8Ej-MLlNJR6wn@swahl-home.5wahls.com>
 <87zfuj2bgh.fsf@email.froward.int.ebiederm.org>
 <ZgWO5I_p8zHyp3en@swahl-home.5wahls.com>
 <87msqf12sy.fsf@email.froward.int.ebiederm.org>
 <ZgrPrZqAXeq7e_wh@swahl-home.5wahls.com>
 <ed6a32ef-85f0-4f90-883b-911ef0964984@intel.com>
 <ZgsBqS5JquMgIh_j@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgsBqS5JquMgIh_j@swahl-home.5wahls.com>
X-Proofpoint-ORIG-GUID: QitlkC5EkglhJnK5Sa2bN9uQiQLfaVb_
X-Proofpoint-GUID: QitlkC5EkglhJnK5Sa2bN9uQiQLfaVb_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_16,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040142

On Mon, Apr 01, 2024 at 01:49:13PM -0500, Steve Wahl wrote:
> On Mon, Apr 01, 2024 at 11:03:20AM -0700, Dave Hansen wrote:
> > On 4/1/24 08:15, Steve Wahl wrote:
> > > From that point of view, it does make sense to special case UV systems
> > > for this.  The restricted areas we're talking about are not in the map
> > > when the bootloader is started on the UV platform.
> > 
> > Just to be clear what I'm looking for here: Special casing UV systems is
> > theoretically OK.  What I don't like is doing that in using GB pages or not.
> > 
> > It would be much nicer to have specific, precise information about what
> > UV needs done.  For instance, do we know where the special address range
> > is?  Is it fixed?  If so, I'd much rather have code that says: "Whoa,
> > don't map this range with *any* identity map page tables" versus
> > something targeted specifically at gbpages.
> 
> The area is not fixed.  Some reserved memory in each numa node,
> address and amount varies depending on the amount of memory in the
> system.
> 
> We've kept the memory range marked as reserved in the e820 memory
> tables, and our experience is the kernel respects that in all other
> aspects.  Even creation of the identity maps is on the surface
> respecting those areas being listed as reserved, but using GBpages
> "swings wide" and includes the reserved areas in the identity map.
> 
> So, I don't fully understand your hesitation in being more selective
> in the use of gbpages on UV, or what I might suggest in its place.

Dave, given the above, can you explain more precisely why the current
aproach in the patch is not acceptable to you, and what you'd like to
see different?

Or is it maybe ok as it stands?

Thanks,

--> Steve Wahl

> Here's partial kernel output showing the memory map, from a randomly
> selected system in case it helps illustrate it for you:
> 
> [Tue Mar 21 09:40:00 2023] BIOS-provided physical RAM map:
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000000000100000-0x0000000068285fff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000000068286000-0x0000000068286fff] ACPI NVS
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000000068287000-0x0000000068baefff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000000068baf000-0x0000000068bb1fff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000000068bb2000-0x0000000068c3ffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000000068c40000-0x000000006a33ffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000000006a340000-0x000000006d5fefff] ACPI NVS
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000000006d5ff000-0x000000006fffefff] ACPI data
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000000006ffff000-0x000000006fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000000100000000-0x0000003f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000003f80000000-0x000000407fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000004080000000-0x0000007f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000007f80000000-0x000000807fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000008080000000-0x000000bf7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000000bf80000000-0x000000c07fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000000c080000000-0x000000ff7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000000ff80000000-0x000001007fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000010080000000-0x0000013f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000013f80000000-0x000001407fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000014080000000-0x0000017f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000017f80000000-0x000001807fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000018080000000-0x000001bf7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000001bf80000000-0x000001c07fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000001c080000000-0x000001ff7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000001ff80000000-0x000002007fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000020080000000-0x0000023f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000023f80000000-0x000002407fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000024080000000-0x0000027f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000027f80000000-0x000002807fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000028080000000-0x000002bf7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000002bf80000000-0x000002c07fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000002c080000000-0x000002ff7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000002ff80000000-0x000003007fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000030080000000-0x0000033f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000033f80000000-0x000003407fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000034080000000-0x0000037f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000037f80000000-0x000003807fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x0000038080000000-0x000003bf7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000003bf80000000-0x000003c07fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000003c080000000-0x000003ff7fffffff] usable
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x000003ff80000000-0x000004007fffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x00001ffe00000000-0x00001ffeffffffff] reserved
> [Tue Mar 21 09:40:00 2023] BIOS-e820: [mem 0x00001fffc0000000-0x00001fffdfffffff] reserved
> [Tue Mar 21 09:40:00 2023] printk: bootconsole [earlyser0] enabled
> [Tue Mar 21 09:40:00 2023] NX (Execute Disable) protection: active
> [Tue Mar 21 09:40:00 2023] e820: update [mem 0x3d279018-0x3d2b3a57] usable ==> usable
> [Tue Mar 21 09:40:00 2023] e820: update [mem 0x3d279018-0x3d2b3a57] usable ==> usable
> [Tue Mar 21 09:40:00 2023] e820: update [mem 0x3d23e018-0x3d278a57] usable ==> usable
> [Tue Mar 21 09:40:00 2023] e820: update [mem 0x3d23e018-0x3d278a57] usable ==> usable
> [Tue Mar 21 09:40:00 2023] extended physical RAM map:
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000000000100000-0x000000003d23e017] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000000003d23e018-0x000000003d278a57] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000000003d278a58-0x000000003d279017] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000000003d279018-0x000000003d2b3a57] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000000003d2b3a58-0x0000000068285fff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000000068286000-0x0000000068286fff] ACPI NVS
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000000068287000-0x0000000068baefff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000000068baf000-0x0000000068bb1fff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000000068bb2000-0x0000000068c3ffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000000068c40000-0x000000006a33ffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000000006a340000-0x000000006d5fefff] ACPI NVS
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000000006d5ff000-0x000000006fffefff] ACPI data
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000000006ffff000-0x000000006fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000000070000000-0x000000008fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x00000000fe010000-0x00000000fe010fff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000000100000000-0x0000003f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000003f80000000-0x000000407fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000004080000000-0x0000007f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000007f80000000-0x000000807fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000008080000000-0x000000bf7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000000bf80000000-0x000000c07fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000000c080000000-0x000000ff7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000000ff80000000-0x000001007fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000010080000000-0x0000013f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000013f80000000-0x000001407fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000014080000000-0x0000017f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000017f80000000-0x000001807fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000018080000000-0x000001bf7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000001bf80000000-0x000001c07fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000001c080000000-0x000001ff7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000001ff80000000-0x000002007fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000020080000000-0x0000023f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000023f80000000-0x000002407fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000024080000000-0x0000027f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000027f80000000-0x000002807fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000028080000000-0x000002bf7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000002bf80000000-0x000002c07fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000002c080000000-0x000002ff7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000002ff80000000-0x000003007fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000030080000000-0x0000033f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000033f80000000-0x000003407fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000034080000000-0x0000037f7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000037f80000000-0x000003807fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x0000038080000000-0x000003bf7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000003bf80000000-0x000003c07fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000003c080000000-0x000003ff7fffffff] usable
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x000003ff80000000-0x000004007fffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x00001ffe00000000-0x00001ffeffffffff] reserved
> [Tue Mar 21 09:40:00 2023] reserve setup_data: [mem 0x00001fffc0000000-0x00001fffdfffffff] reserved
> [Tue Mar 21 09:40:00 2023] efi: EFI v2.7 by HPE
> 
> Thanks,
> 
> --> Steve Wahl
> -- 
> Steve Wahl, Hewlett Packard Enterprise

-- 
Steve Wahl, Hewlett Packard Enterprise

