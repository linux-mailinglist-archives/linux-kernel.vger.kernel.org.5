Return-Path: <linux-kernel+bounces-97168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEF487665D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CDCB21414
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB4A48CFC;
	Fri,  8 Mar 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MsEd9dn3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1LDzq8iF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MsEd9dn3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1LDzq8iF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6A3FBB9;
	Fri,  8 Mar 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908183; cv=none; b=IdfxJhDstlxwT+y761sbkDWU3Q/yz9zpQEB5nHjPYUK+ovZjvfbgblloHA+S+1kVP+O6pX9J2uL9vCu7hNskfpBYvPY2/IBxK4BXrvHLFTcds4DUGmTC54XjY0r0upUFC4QBK3IBCpHpkNh8L5Ux0QoJl0wQngbOz51R9Iqa9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908183; c=relaxed/simple;
	bh=yfuZ3hSb+pB8JejaZWTf0biUpqodcxuCK85UX6EWMYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2xaSHMUWyIBsfVEE9xx57yn/uniGJomQBZ6Md9spBr5t6lJvk25QNpHENPO8nxhOliTvg482/7Df3UuyEFcJ+J5M67b7TRmTbHUU+XTHk5SZdSG3qjTggmAh8q8oTdT/TQLnsVThPizcocMbQHjR9Nrg10ikxdXw6uQkpv0Z5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MsEd9dn3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1LDzq8iF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MsEd9dn3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1LDzq8iF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C301D5BFAE;
	Fri,  8 Mar 2024 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709908179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCaGv2zXEJ+yXUxCmBT8XWgEX8+94ycfxb1ZkVsrRK4=;
	b=MsEd9dn3ccmnP9T3Cpj5mLwWH2TbeFojx1VQLYTt1JnuDBwvclcfpYBwqcg5Y0Znb6OvCY
	xd0SvAq/Kd97jFtX/Ox5nG8nXibxhUF32uaf/f2GMkAxdKIcpSTJ4StbdUibuh43kdhWSA
	4DnNDHQAK1pAms43FeAg/QOT7BkCz/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709908179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCaGv2zXEJ+yXUxCmBT8XWgEX8+94ycfxb1ZkVsrRK4=;
	b=1LDzq8iFTWk+W6vOGZ7wHNgG0BT1LqS/bq86WbX/lM8SF9ZNqM8n2K9f1zEbea75gvpCX+
	9u9B3WnSDKlZKsAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709908179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCaGv2zXEJ+yXUxCmBT8XWgEX8+94ycfxb1ZkVsrRK4=;
	b=MsEd9dn3ccmnP9T3Cpj5mLwWH2TbeFojx1VQLYTt1JnuDBwvclcfpYBwqcg5Y0Znb6OvCY
	xd0SvAq/Kd97jFtX/Ox5nG8nXibxhUF32uaf/f2GMkAxdKIcpSTJ4StbdUibuh43kdhWSA
	4DnNDHQAK1pAms43FeAg/QOT7BkCz/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709908179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCaGv2zXEJ+yXUxCmBT8XWgEX8+94ycfxb1ZkVsrRK4=;
	b=1LDzq8iFTWk+W6vOGZ7wHNgG0BT1LqS/bq86WbX/lM8SF9ZNqM8n2K9f1zEbea75gvpCX+
	9u9B3WnSDKlZKsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9675C13310;
	Fri,  8 Mar 2024 14:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NM/rEdAg62V3MQAAD6G6ig
	(envelope-from <colyli@suse.de>); Fri, 08 Mar 2024 14:29:36 +0000
Date: Fri, 8 Mar 2024 22:29:29 +0800
From: Coly Li <colyli@suse.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, yukuai3@huawei.com, xueshi.hu@smartx.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH] raid1: fix use-after-free for original bio in
 raid1_write_request()
Message-ID: <lch3c5p36igfup7vzsagjfxwr3otefv4igr2qahxwc2fpsntrd@qoeo67iwxzvr>
References: <20240308093726.1047420-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240308093726.1047420-1-yukuai1@huaweicloud.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.de:email,huawei.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -2.60
X-Spam-Flag: NO

On Fri, Mar 08, 2024 at 05:37:26PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> r1_bio->bios[] is used to record new bios that will be issued to
> underlying disks, however, in raid1_write_request(), r1_bio->bios[]
> will set to the original bio temporarily. Meanwhile, if blocked rdev
> is set, free_r1bio() will be called causing that all r1_bio->bios[]
> to be freed:
> 
> raid1_write_request()
>  r1_bio = alloc_r1bio(mddev, bio); -> r1_bio->bios[] is NULL
>  for (i = 0;  i < disks; i++) -> for each rdev in conf
>   // first rdev is normal
>   r1_bio->bios[0] = bio; -> set to original bio
>   // second rdev is blocked
>   if (test_bit(Blocked, &rdev->flags))
>    break
> 
>  if (blocked_rdev)
>   free_r1bio()
>    put_all_bios()
>     bio_put(r1_bio->bios[0]) -> original bio is freed
> 
> Test scripts:
> 
> mdadm -CR /dev/md0 -l1 -n4 /dev/sd[abcd] --assume-clean
> fio -filename=/dev/md0 -ioengine=libaio -rw=write -bs=4k -numjobs=1 \
>     -iodepth=128 -name=test -direct=1
> echo blocked > /sys/block/md0/md/rd2/state
> 
> Test result:
> 
> BUG bio-264 (Not tainted): Object already free
> -----------------------------------------------------------------------------
> 
> Allocated in mempool_alloc_slab+0x24/0x50 age=1 cpu=1 pid=869
>  kmem_cache_alloc+0x324/0x480
>  mempool_alloc_slab+0x24/0x50
>  mempool_alloc+0x6e/0x220
>  bio_alloc_bioset+0x1af/0x4d0
>  blkdev_direct_IO+0x164/0x8a0
>  blkdev_write_iter+0x309/0x440
>  aio_write+0x139/0x2f0
>  io_submit_one+0x5ca/0xb70
>  __do_sys_io_submit+0x86/0x270
>  __x64_sys_io_submit+0x22/0x30
>  do_syscall_64+0xb1/0x210
>  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> Freed in mempool_free_slab+0x1f/0x30 age=1 cpu=1 pid=869
>  kmem_cache_free+0x28c/0x550
>  mempool_free_slab+0x1f/0x30
>  mempool_free+0x40/0x100
>  bio_free+0x59/0x80
>  bio_put+0xf0/0x220
>  free_r1bio+0x74/0xb0
>  raid1_make_request+0xadf/0x1150
>  md_handle_request+0xc7/0x3b0
>  md_submit_bio+0x76/0x130
>  __submit_bio+0xd8/0x1d0
>  submit_bio_noacct_nocheck+0x1eb/0x5c0
>  submit_bio_noacct+0x169/0xd40
>  submit_bio+0xee/0x1d0
>  blkdev_direct_IO+0x322/0x8a0
>  blkdev_write_iter+0x309/0x440
>  aio_write+0x139/0x2f0
> 
> Since that bios for underlying disks are not allocated yet, fix this
> problem by using mempool_free() directly to free the r1_bio.
> 

Yes, the panic doesn't show up anymore with this patch.

Thanks for the fixup.


> Fixes: 992db13a4aee ("md/raid1: free the r1bio before waiting for blocked rdev")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reported-and-tested-by: Coly Li <colyli@suse.de>


Coly Li

> ---
>  drivers/md/raid1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index afca975ec7f3..fde8434c33df 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1565,7 +1565,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>  		for (j = 0; j < i; j++)
>  			if (r1_bio->bios[j])
>  				rdev_dec_pending(conf->mirrors[j].rdev, mddev);
> -		free_r1bio(r1_bio);
> +		mempool_free(r1_bio, &conf->r1bio_pool);
>  		allow_barrier(conf, bio->bi_iter.bi_sector);
>  
>  		if (bio->bi_opf & REQ_NOWAIT) {
> -- 
> 2.39.2
> 
> 

