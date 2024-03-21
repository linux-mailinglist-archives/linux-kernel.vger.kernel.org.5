Return-Path: <linux-kernel+bounces-109897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AE788577B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA092836AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E55644E;
	Thu, 21 Mar 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="13vteFed";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5nukl2Hm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HOjINw6m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YOZ1e2cY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F041CD33
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017139; cv=none; b=UYVGjbL+fEpyJJrmS6K4A5ojcMtswu8W5ORO48zBoQAGQ7h1dWAnh0LTe7bng5NtLdNjzgoXp5gS70FV6cI7prAraHNHYZEwjYCkNkifLB5NrP0YNFSfgV28aZKdfT9odTA9enlXvsCd+Hqo73POwukxSCKJtvH41kBYeDCj84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017139; c=relaxed/simple;
	bh=OeZ4RXtvl+FBuLQosIoBLXvimfnZcrsfLMZ2/4zVQ30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAIeDwHSoN9pDHVo38JlmNgPGeMN6shESbXb32dJM1RPVCdNPU0z6TdLM/UzI1UkIitGlSMSr9lG8H6kzI2Ob91FHGNNWtLGLCKQC3fDawbrmAUPEX60t19Z2jRAIe1U+Qx2tuGTizSzkFypTluYr22mOaEW75W+ryFLqN7UmCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=13vteFed; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5nukl2Hm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HOjINw6m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YOZ1e2cY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 15607371E2;
	Thu, 21 Mar 2024 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711017135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnetYEamxYncT4FyPau+ZNn1O61ZG25GO69+cy3P2YE=;
	b=13vteFedUUVxmufczNCJawD0Yk2W50hvquAptpr/jQdyWZOYeAqlC0MpFRhw1IpkUeODzT
	K2N/TlaRC0RlTaFoRQseXMP2ks1QpDyGWtQra7BjlDlaixO4JDtAtjtKSouZfLXuXNBiu1
	HJmMb006uq1wCHGs9BsTJYO3+RwuTCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711017135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnetYEamxYncT4FyPau+ZNn1O61ZG25GO69+cy3P2YE=;
	b=5nukl2HmVzOfMk837ThsumTolA/lj5Ise4JXlAup5LV5lBQ8YLoMRHnPBcmYl0tfwG5pZ0
	ib1gLy6kKHoe8tAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711017134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnetYEamxYncT4FyPau+ZNn1O61ZG25GO69+cy3P2YE=;
	b=HOjINw6mcHqRfq650Ub2UWbtVR51MEEZLOXc18FA4XJp6hEzgSWW/NpiiEL7YTAIX7wPnD
	CuYcMdZSQi61Ixbg0apHOIJ62IGzR3SnIzPMSU9G6SmN7i0jqEK4u9lJkMOd7IZL33Vpz+
	6+4ZxVu3GHX3li3ISz28mbp7vVvkLfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711017134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnetYEamxYncT4FyPau+ZNn1O61ZG25GO69+cy3P2YE=;
	b=YOZ1e2cYbsbiJxDynT6FYsJKv93I+fyipycrdT6O/Uk1fGX6AyH6lTd1Exelc9v+H8WeAb
	XjFOk3KROLRWz2AQ==
Date: Thu, 21 Mar 2024 11:32:14 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	"Huang, Kai" <kai.huang@intel.com>
Subject: Re: [PATCH V2] x86/kexec: do not update E820 kexec table for
 setup_data
Message-ID: <ZfwMribQCTKWSO9l@dwarf.suse.cz>
References: <Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com>
X-Spam-Score: -4.20
X-Spamd-Result: default: False [-4.20 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROMTLD(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.10)[-0.508];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Hi,

On Thu, Mar 21, 2024 at 05:23:20PM +0800, Dave Young wrote:
> crashkernel reservation failed on a Thinkpad t440s laptop recently. 
> Actually the memblock reservation succeeded, but later insert_resource()
> failed.
> 
> Test steps:
> kexec load -> /* make sure add crashkernel param eg. crashkernel=160M */
>     kexec reboot -> 
>         dmesg|grep "crashkernel reserved";
>             crashkernel memory range like below reserved successfully:
>             0x00000000d0000000 - 0x00000000da000000
>         But no such "Crash kernel" region in /proc/iomem
> 
> The background story is like below:
> 
> Currently E820 code reserves setup_data regions for both the current
> kernel and the kexec kernel, and it inserts them into the resources list.
> Before the kexec kernel reboots nobody passes the old setup_data, and
> kexec only passes fresh SETUP_EFI and SETUP_IMA if needed.  Thus the old
> setup data memory is not used at all.
> 
> Due to old kernel updates the kexec e820 table as well so kexec kernel
> sees them as E820_TYPE_RESERVED_KERN regions, and later the old setup_data
> regions are inserted into resources list in the kexec kernel by
> e820__reserve_resources().
> 
> Note, due to no setup_data is passed in for those old regions they are not
> early reserved (by function early_reserve_memory), and the crashkernel
> memblock reservation will just treat them as usable memory and it could
> reserve the crashkernel region which overlaps with the old setup_data
> regions. And just like the bug I noticed here, kdump insert_resource
> failed because e820__reserve_resources has added the overlapped chunks
> in /proc/iomem already.

wouldn't this be caused by
4a693ce65b186fddc1a73621bd6f941e6e3eca21 ("kdump: defer the
insertion of crashkernel resources")?

Before that the crashkernel resources were inserted from
arch_reserve_crashkernel() which is called before
e820__reserve_resources().

The semantics of E820_TYPE_RESERVED_KERN wrt kexec quite
inconsistent. It's treated as E820_TYPE_RAM by
e820__memblock_setup() and e820_type_to_iomem_type().

The problem we're seeing here is the result of the former.
e820__memblock_setup() will add the E820_TYPE_RESERVED_KERN
region to the memblock, merging with the neighbouring memblocks,
allowing crashkernel region to span across the originally
reserved area.

e820_type_to_iomem_type() treating E820_TYPE_RESERVED_KERN as
E820_TYPE_RAM will make the E820_TYPE_RESERVED_KERN appear as
system ram in /proc/iomem. If the old kexec_load (not
kexec_file_load) syscall is used, the userspace kexec utility
will construct the e820 table based on the contents of
/proc/iomem and the kexec kernel will see the
E820_TYPE_RESERVED_KERN range as E820_TYPE_RAM.  When
kexec_file_load is used the E820_TYPE_RESERVED_KERN type is
propagated to the kexec kernel by bzImage64_load() /
setup_e820_entries().


> Index: linux/arch/x86/kernel/e820.c
> ===================================================================
> --- linux.orig/arch/x86/kernel/e820.c
> +++ linux/arch/x86/kernel/e820.c
> @@ -1015,16 +1015,6 @@ void __init e820__reserve_setup_data(voi
>  		pa_next = data->next;
>  
>  		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -
> -		/*
> -		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> -		 * to be reserved.
> -		 */
> -		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
> -			e820__range_update_kexec(pa_data,
> -						 sizeof(*data) + data->len,
> -						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -

Your tree is missing this recent commit:
7fd817c906503b6813ea3b41f5fdf4192449a707 ("x86/e820: Don't
reserve SETUP_RNG_SEED in e820").

Wouldn't this fix [/paper over] your problem as well? I.e., isn't
SETUP_RNG_SEED the setup_data item that's causing your problem?

Regards,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


