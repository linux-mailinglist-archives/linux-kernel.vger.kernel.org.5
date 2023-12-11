Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A5980CB1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbjLKNgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKNgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:36:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438CFCF;
        Mon, 11 Dec 2023 05:36:26 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4568A1FB97;
        Mon, 11 Dec 2023 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702301784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J7XMwo8gS0gIePc24K0/R+faEUaJh0tGxIvesG8PtDk=;
        b=dzHXJRl/TnGEj/ANrtQajQOj/sJOAm018+Srhtfem0ZllUrWav8snNr36k+09tXTQiSBRu
        kh+HxCxm5lGAeEoBN2sH1P6K8G+wsALcwv5jbpHNejzSwYNpdQmAtn8tTYpFMFjCOoa3Pa
        srC7hJwS/0BJ/bBBBnkvXyYVpuG6SHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702301784;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J7XMwo8gS0gIePc24K0/R+faEUaJh0tGxIvesG8PtDk=;
        b=UnV6mOccP9f7Z2PACRs+sUmwf4l6BBbSQEB01Ua9gxMuy/xUqmuO7c15Eb0Jhr/2QcFzBv
        r1PihPp6VFggoqBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702301784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J7XMwo8gS0gIePc24K0/R+faEUaJh0tGxIvesG8PtDk=;
        b=dzHXJRl/TnGEj/ANrtQajQOj/sJOAm018+Srhtfem0ZllUrWav8snNr36k+09tXTQiSBRu
        kh+HxCxm5lGAeEoBN2sH1P6K8G+wsALcwv5jbpHNejzSwYNpdQmAtn8tTYpFMFjCOoa3Pa
        srC7hJwS/0BJ/bBBBnkvXyYVpuG6SHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702301784;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J7XMwo8gS0gIePc24K0/R+faEUaJh0tGxIvesG8PtDk=;
        b=UnV6mOccP9f7Z2PACRs+sUmwf4l6BBbSQEB01Ua9gxMuy/xUqmuO7c15Eb0Jhr/2QcFzBv
        r1PihPp6VFggoqBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 33BEC134B0;
        Mon, 11 Dec 2023 13:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id 1JCaDFgQd2WqWAAAn2gu4w
        (envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 13:36:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B0E8FA07E3; Mon, 11 Dec 2023 14:36:19 +0100 (CET)
Date:   Mon, 11 Dec 2023 14:36:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH] jbd2: fix soft lockup in
 journal_finish_inode_data_buffers()
Message-ID: <20231211133619.3uaq4ri3r7fsdap5@quack3>
References: <20231211112544.3879780-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211112544.3879780-1-yebin10@huawei.com>
X-Spam-Score: 14.89
X-Spamd-Result: default: False [8.76 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(2.99)[0.998];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         NEURAL_HAM_LONG(-0.23)[-0.226];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         DKIM_TRACE(0.00)[suse.cz:+];
         MX_GOOD(-0.01)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[38.71%];
         RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spamd-Bar: ++++++++
X-Rspamd-Server: rspamd1
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4568A1FB97
X-Spam-Score: 8.76
Authentication-Results: smtp-out2.suse.de;
        dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="dzHXJRl/";
        dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UnV6mOcc;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
        dmarc=none
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-12-23 19:25:44, Ye Bin wrote:
> There's issue when do io test:
> WARN: soft lockup - CPU#45 stuck for 11s! [jbd2/dm-2-8:4170]
> CPU: 45 PID: 4170 Comm: jbd2/dm-2-8 Kdump: loaded Tainted: G  OE
> Call trace:
>  dump_backtrace+0x0/0x1a0
>  show_stack+0x24/0x30
>  dump_stack+0xb0/0x100
>  watchdog_timer_fn+0x254/0x3f8
>  __hrtimer_run_queues+0x11c/0x380
>  hrtimer_interrupt+0xfc/0x2f8
>  arch_timer_handler_phys+0x38/0x58
>  handle_percpu_devid_irq+0x90/0x248
>  generic_handle_irq+0x3c/0x58
>  __handle_domain_irq+0x68/0xc0
>  gic_handle_irq+0x90/0x320
>  el1_irq+0xcc/0x180
>  queued_spin_lock_slowpath+0x1d8/0x320
>  jbd2_journal_commit_transaction+0x10f4/0x1c78 [jbd2]
>  kjournald2+0xec/0x2f0 [jbd2]
>  kthread+0x134/0x138
>  ret_from_fork+0x10/0x18
> 
> Analyzed informations from vmcore as follows:
> (1) There are about 5k+ jbd2_inode in 'commit_transaction->t_inode_list';
> (2) Now is processing the 855th jbd2_inode;
> (3) JBD2 task has TIF_NEED_RESCHED flag;
> (4) There's no pags in address_space around the 855th jbd2_inode;
> (5) There are some process is doing drop caches;
> (6) Mounted with 'nodioread_nolock' option;
> (7) 128 CPUs;
> 
> According to informations from vmcore we know 'journal->j_list_lock' spin lock
> competition is fierce. So journal_finish_inode_data_buffers() maybe process
> slowly. Theoretically, there is scheduling point in the filemap_fdatawait_range_keep_errors().
> However, if inode's address_space has no pages which taged with PAGECACHE_TAG_WRITEBACK,
> will not call cond_resched(). So may lead to soft lockup.
> journal_finish_inode_data_buffers
>   filemap_fdatawait_range_keep_errors
>     __filemap_fdatawait_range
>       while (index <= end)
>         nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end, PAGECACHE_TAG_WRITEBACK);
>         if (!nr_pages)
>            break;    --> If 'nr_pages' is equal zero will break, then will not call cond_resched()
>         for (i = 0; i < nr_pages; i++)
>           wait_on_page_writeback(page);
>         cond_resched();
> 
> To solve above issue, add scheduling point in the journal_finish_inode_data_buffers();
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 9bdb377a348f..5e122586e06e 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -270,6 +270,7 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
>  			if (!ret)
>  				ret = err;
>  		}
> +		cond_resched();
>  		spin_lock(&journal->j_list_lock);
>  		jinode->i_flags &= ~JI_COMMIT_RUNNING;
>  		smp_mb();
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
