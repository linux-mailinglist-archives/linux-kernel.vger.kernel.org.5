Return-Path: <linux-kernel+bounces-109698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C650881C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A21B20F67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5CD4D10A;
	Thu, 21 Mar 2024 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gCbqFw/l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LcBbmugh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gCbqFw/l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LcBbmugh"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668F47A76;
	Thu, 21 Mar 2024 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003194; cv=none; b=PXWVphPCwgsYHVgW+USz7dV0P4Cf+9g4TzHO2N4fKJQ7feU5u9Bhku49P11bLChcNbeopx3yNXzaBI2XNPSuzT1rPWGoAmBDZqiXwZV1lRub/t6eAaukBjEHc6vAwWr5+Hd00VfnJ53j06i+OIqmfUYRkScjYQtI6br606p5GdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003194; c=relaxed/simple;
	bh=oUJWDMfrfUpzYO+tOtsFrHzuwqXseft6+acuv7NgPZQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILRdDqjanv+G80yv4ISMh7AvkBnqNPxRWOcEKCmiHqT0HHwB32XvFfN/QcyKrFqzL/1p7bjgcLJb/blhwsqRH6Lo2hKMj+Cy/odHLXJd79B5nEkWUCqtaTV+21RgcTsT4JjSzyjTsz/rxfOVQhr4SavsjHJnlylkIXG02m0grqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gCbqFw/l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LcBbmugh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gCbqFw/l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LcBbmugh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 961C433705;
	Thu, 21 Mar 2024 06:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711003189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CiYumubyt3zhsXcLHnCGuaJsTo3o4F3ApZzKhMcqdCA=;
	b=gCbqFw/l7UTdwoDX6FJ+JXmaR814GcUcTmRQJ5mVYxa1l1ZHptWmJWvpW+CHxZWVEqB/+Z
	kbVMztGKKhFAUZy03LDIgghP0DtFgfKLuvvwgHLcJVdnjtejeKU/WLCK//Hy7oM5QGskgF
	z5B3WE9JaOcuH1XBIm+YWCIlU9Y+KDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711003189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CiYumubyt3zhsXcLHnCGuaJsTo3o4F3ApZzKhMcqdCA=;
	b=LcBbmughsrYAdJCuXNc/W5c06uINkHnmqetb5oQ5RuyoczJzRv2ZeA61xrwUVtANhc6qA7
	Rg8QdybtvK/MAGAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711003189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CiYumubyt3zhsXcLHnCGuaJsTo3o4F3ApZzKhMcqdCA=;
	b=gCbqFw/l7UTdwoDX6FJ+JXmaR814GcUcTmRQJ5mVYxa1l1ZHptWmJWvpW+CHxZWVEqB/+Z
	kbVMztGKKhFAUZy03LDIgghP0DtFgfKLuvvwgHLcJVdnjtejeKU/WLCK//Hy7oM5QGskgF
	z5B3WE9JaOcuH1XBIm+YWCIlU9Y+KDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711003189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CiYumubyt3zhsXcLHnCGuaJsTo3o4F3ApZzKhMcqdCA=;
	b=LcBbmughsrYAdJCuXNc/W5c06uINkHnmqetb5oQ5RuyoczJzRv2ZeA61xrwUVtANhc6qA7
	Rg8QdybtvK/MAGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7658A136AD;
	Thu, 21 Mar 2024 06:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BE0cGzXW+2UdUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 21 Mar 2024 06:39:49 +0000
Date: Thu, 21 Mar 2024 07:39:49 +0100
Message-ID: <87v85grsui.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: Regression: SUnreclaim leak: snd_ctl_ioctl?
In-Reply-To: <1710953751.8yx03664pf.none@localhost>
References: <1710953751.8yx03664pf.none.ref@localhost>
	<1710953751.8yx03664pf.none@localhost>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="gCbqFw/l";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LcBbmugh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[yahoo.ca];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 BAYES_HAM(-1.50)[91.66%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[yahoo.ca];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 961C433705
X-Spam-Flag: NO

On Wed, 20 Mar 2024 18:01:22 +0100,
Alex Xu (Hello71) wrote:
> 
> Hi all,
> 
> In the last few days of running torvalds master kernel, I found that 
> SUnreclaim memory seems to increase indefinitely. slabinfo -r kmalloc-2k 
> says:
> 
> Slabcache: kmalloc-2k       Aliases:  0 Order :  3 Objects: 1272941
> 
> Sizes (bytes)     Slabs              Debug                Memory
> ------------------------------------------------------------------------
> Object :    2048  Total  :  264991   Sanity Checks : On   Total: 8683225088
> SlabObj:    6144  Full   :  264972   Redzoning     : On   Used : 2606983168
> SlabSiz:   32768  Partial:      19   Poisoning     : On   Loss : 6076241920
> Loss   :    4096  CpuSlab:       0   Tracking      : On   Lalig: 5213966336
> Align  :    2048  Objects:       5   Tracing       : Off  Lpadd: 542701568
> 
> kmalloc-2k has no kmem_cache operations
> 
> kmalloc-2k: Kernel object allocation
> -----------------------------------------------------------------------
> 1272283 snd_ctl_ioctl+0x45f/0x6d0 waste=1048361192/824 age=6141/183854/366927 pid=687-33984 cpus=0-1,3-8,10
>         memdup_user+0x21/0x70
>         snd_ctl_ioctl+0x45f/0x6d0
>         __x64_sys_ioctl+0x85/0xa0
>         do_syscall_64+0x3d/0xf0
>         entry_SYSCALL_64_after_hwframe+0x46/0x4e
> 
>     189 acpi_add_single_object+0x38/0x710 waste=119448/632 age=368130/368134/368138 pid=1 cpus=0
> [ ... ]
> 
> kmalloc-2k: Kernel object freeing
> ------------------------------------------------------------------------
>  633587 <not-available> age=4295305473 pid=0 cpus=0
>  382872 rcu_core+0x284/0x540 age=4513/194630/361523 pid=0-21201 cpus=0-11
>         rcu_core+0x284/0x540
>         __do_softirq+0xad/0x1de
> 
>  247690 amdgpu_dm_atomic_commit_tail+0x1721/0x3740 age=6157/199198/366963 pid=163-19507 cpus=0-11
>         amdgpu_dm_atomic_commit_tail+0x1721/0x3740
>         commit_tail+0x8a/0x120
>         process_one_work+0x12b/0x250
>         worker_thread+0x2d9/0x3f0
>         kthread+0xac/0xe0
>         ret_from_fork+0x28/0x40
>         ret_from_fork_asm+0x11/0x20
> 
>    2794 __sk_destruct+0x17a/0x1b0 age=994/147194/368001 pid=0-19414 cpus=0-11
> [ ... ]
> 
> So, if I understand correctly, some memory copied from userspace for 
> snd_ctl_ioctl is not freed correctly. The PIDs were pipewire, 
> wireplumber, and pipewire-pulse, so I restarted those but it didn't 
> resolve the issue.
> 
> Let me know what other information is needed.

Likely the same issue fixed by
  https://lore.kernel.org/r/20240320062722.31325-1-tiwai@suse.de

It'll be included in the next PR for 6.9-rc1.


thanks,

Takashi

