Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639BA812AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjLNI6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLNI6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:58:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919EE10A;
        Thu, 14 Dec 2023 00:58:36 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16CE022234;
        Thu, 14 Dec 2023 08:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702544315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JfziK/3KhWhdwfw4HSp/YFBI7ijI4WOjyAomTM6eCx8=;
        b=QYVAvT75hcGPLYrp67ppwlEFwyNMB1UNfscFdBfhXxA2qXKBQHEUad253KbodqHwm6dMl2
        ial1jiubl6HccfyKwLBFt+idD9bQLvWFCVm2GUKz903142zKT7uP4GsYUOMLGs10r4SRbr
        I0e+ZdQ+zOyYKvtt29QZls8xLmlRjuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702544315;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JfziK/3KhWhdwfw4HSp/YFBI7ijI4WOjyAomTM6eCx8=;
        b=kIqCv0CWmYGR/y+lcQkWcdAQihiHBWj2FjAwIx7R3wSmLpD7ArUXQEG5yQuPuTDh5U190U
        Gce+4qLUpN4QjWAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702544315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JfziK/3KhWhdwfw4HSp/YFBI7ijI4WOjyAomTM6eCx8=;
        b=QYVAvT75hcGPLYrp67ppwlEFwyNMB1UNfscFdBfhXxA2qXKBQHEUad253KbodqHwm6dMl2
        ial1jiubl6HccfyKwLBFt+idD9bQLvWFCVm2GUKz903142zKT7uP4GsYUOMLGs10r4SRbr
        I0e+ZdQ+zOyYKvtt29QZls8xLmlRjuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702544315;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JfziK/3KhWhdwfw4HSp/YFBI7ijI4WOjyAomTM6eCx8=;
        b=kIqCv0CWmYGR/y+lcQkWcdAQihiHBWj2FjAwIx7R3wSmLpD7ArUXQEG5yQuPuTDh5U190U
        Gce+4qLUpN4QjWAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0959A134B0;
        Thu, 14 Dec 2023 08:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id 0FIFArvDemVKNQAAn2gu4w
        (envelope-from <jack@suse.cz>); Thu, 14 Dec 2023 08:58:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A9E70A07E0; Thu, 14 Dec 2023 09:58:34 +0100 (CET)
Date:   Thu, 14 Dec 2023 09:58:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH] ext4: fix inconsistent between segment fstrim and full
 fstrim
Message-ID: <20231214085834.svce3mvfnctikwyq@quack3>
References: <20231214064635.4128391-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214064635.4128391-1-yebin10@huawei.com>
X-Spam-Level: 
X-Spam-Score: -0.63
X-Spamd-Result: default: False [-2.78 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.18)[-0.894];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Score: -2.78
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-12-23 14:46:35, Ye Bin wrote:
> There will not issue discard cmd when do segment fstrim for ext4 fs, however,
> if full fstrim for the same fs will issue discard cmd.
> Above issue may happens as follows:
> Precondition:
> 1. Fstrim range [0, 15] and [16, 31];
> 2. Discard granularity is 16;
>             Range1          Range2
>       1111000000000000 0000111010101011
> There's no free space length large or equal than 16 in 'Range1' or 'Range2'.
> As ext4_try_to_trim_range() only search free space among range which user
> specified. However, there's maximum free space length 16 in 'Range1'+ 'Range2'.
> To solve above issue, we need to find the longest free space to discard.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

OK, I agree that there is this behavioral difference. However is that a
practical problem? I mean I would not expect the range to be particularly
small, rather something like 1GB and then these boundary conditions don't
really matter. This is also sensible so that we can properly track whether
the whole block group was trimmed or not. Finally I'd also argue that
trimming outside of specified range might be unexpected for the user. So a
*fix* for this in my opinion lays in userspace which needs to select
sensible ranges to use for trimming.

								Honza

> ---
>  fs/ext4/mballoc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d72b5e3c92ec..d195461123d8 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6753,13 +6753,15 @@ static int ext4_try_to_trim_range(struct super_block *sb,
>  __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
>  __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  {
> -	ext4_grpblk_t next, count, free_count;
> +	ext4_grpblk_t next, count, free_count, last, origin_start;
>  	bool set_trimmed = false;
>  	void *bitmap;
>  
> +	last = ext4_last_grp_cluster(sb, e4b->bd_group);
>  	bitmap = e4b->bd_bitmap;
> -	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
> +	if (start == 0 && max >= last)
>  		set_trimmed = true;
> +	origin_start = start;
>  	start = max(e4b->bd_info->bb_first_free, start);
>  	count = 0;
>  	free_count = 0;
> @@ -6768,7 +6770,10 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  		start = mb_find_next_zero_bit(bitmap, max + 1, start);
>  		if (start > max)
>  			break;
> -		next = mb_find_next_bit(bitmap, max + 1, start);
> +
> +		next = mb_find_next_bit(bitmap, last + 1, start);
> +		if (origin_start == 0 && next >= last)
> +			set_trimmed = true;
>  
>  		if ((next - start) >= minblocks) {
>  			int ret = ext4_trim_extent(sb, start, next - start, e4b);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
