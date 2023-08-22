Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4E784BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjHVVPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjHVVPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E56CF3;
        Tue, 22 Aug 2023 14:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F8F634E2;
        Tue, 22 Aug 2023 21:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB45AC433C7;
        Tue, 22 Aug 2023 21:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692738896;
        bh=L1Tgc4ICYR0hdhOoCocn8nFB7tQACCiC8l6KOmZxayg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkkkLuo3eJ659WoqN5DConOGdb3TshhjgzVCLnvD97+/gIf/1mroRTqogY8Cex7vN
         PBpeWGIjwbrq1hLrNLS0s1WhTXxeLyISpIIUn3M510Srlgn+TZsR1SFbmRHhDHimc3
         yqQMBmjfodULJUTK0Y6xtlFhLjZGBcK2PUGGL+iWaSpU1j/9cEMZ9f/gXRcX+uijfN
         8OVThDyUnVelIVMondb26FOqJUNAlQksu6Y+WkBGLLcF5o5gomcLr4IRoh0KHmoaZN
         /iaxJWQvYxY/eXnKF68DluX0W7vpEHVHnQRm52UNDO8R+1omek4YKVZ7/t+pccvgsV
         CmXk232m0DH/A==
Date:   Tue, 22 Aug 2023 14:14:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 djw-vfs tree
Message-ID: <20230822211456.GC11286@frogsfrogsfrogs>
References: <20230822110551.6386dd5d@canb.auug.org.au>
 <20230822025120.GA11286@frogsfrogsfrogs>
 <20230822-turnus-quert-9b11d4e30dc9@brauner>
 <20230822182604.GB11286@frogsfrogsfrogs>
 <20230822-mitbringen-unwillig-176fd9e8873b@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822-mitbringen-unwillig-176fd9e8873b@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:19:00PM +0200, Christian Brauner wrote:
> > > my preferred solution. How do you feel about that?
> > 
> > I'm happy to have you pull my xfs-linux tags into your vfs tree. :)
> 
> Ah, sweet. I apppreciate that. I'll mention in the pr to Linus that if
> he wants to reject other parts of the super work that he should then
> still simply pull the freeze stuff from you without the rest.
> 
> > 
> > Here's a tag with just the two vfs patches:
> > https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/tag/?h=vfs-6.6-merge-2
> > 
> > This second tag builds on that, by adding the first actual user of
> > FREEZE_HOLDER_KERNEL:
> > https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/tag/?h=vfs-6.6-merge-3
> 
> Assuming I understood correctly I did just pull both tags and pushed
> them out. Would you please take a look at
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.super
> and let me know if everything looks as expected? I'll be going afk in a
> bit just waiting for the kernel build to finish to kick of some
> xfstests. If you find anything I'll fix up any issues up tomorrow
> morning.

Hmm.  Looking at the {up,down}_write -> super_{un,}lock_excl conversion,
I think you missed wait_for_partially_frozen:

static int wait_for_partially_frozen(struct super_block *sb)
{
	int ret = 0;

	do {
		unsigned short old = sb->s_writers.frozen;

		up_write(&sb->s_umount);
		ret = wait_var_event_killable(&sb->s_writers.frozen,
					       sb->s_writers.frozen != old);
		down_write(&sb->s_umount);
	} while (ret == 0 &&
		 sb->s_writers.frozen != SB_UNFROZEN &&
		 sb->s_writers.frozen != SB_FREEZE_COMPLETE);

	return ret;
}

That said, freeze_super() took an s_active refcount at the top, called
super_lock_excl (which means the sb isn't DYING and has been BORN) and
doesn't release it before calling wait_for_partially_frozen.

AFAICT, the subsequent down_write -> super_lock_excl conversions in
freeze_super do not gain us much since I don't think the sb can get to
SB_DYING state without s_active reaching zero, right?  According to
"super: use higher-level helper for {freeze,thaw}", it sounds like the
subsequent down_write calls in freeze_super were replaced for
consistency, even though it "...isn't possible to observe a dying
superblock".

The missing conversion isn't strictly necessary, but it probably makese
sense to do it anyway.

(Aside from that, the conversion looks correct to me.)

> > 
> > There will be more for 6.7(+?) if Luis manages to get back to his
> > auto-fsfreeze during suspend, or if Shiyang finishes the series to
> > handle pmem media error reporting in xfs.
> 
> Ok, sounds good let me know/Cc me when ready/needed.

Will do!

--D

> 
> Thanks for all the help!
