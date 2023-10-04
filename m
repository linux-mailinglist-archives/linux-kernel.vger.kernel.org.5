Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC7A7B8401
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjJDPqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjJDPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:46:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B59BF;
        Wed,  4 Oct 2023 08:46:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7AA72183A;
        Wed,  4 Oct 2023 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696434388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RvZOogMG/ThcrYut0Ujm3IWPL1QhfU9hSbHmZMiBpTU=;
        b=oOBBH/AF54nfdqPbJf4G0UCCKHnysFDpyAwqeaYYhnH4KzHjAZ4xbr/EMg7hwo9S9Wj7Ka
        0w+2qJebuEJVt8IFcJ1FymE9RA8RmxMpAmf8bvQJXrGgtCV6rngZIjFEyUMxfwDktuvmTS
        5TdGL4XwFUkj16fp3rmXiFM8VjBE+5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696434388;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RvZOogMG/ThcrYut0Ujm3IWPL1QhfU9hSbHmZMiBpTU=;
        b=h4J9KqSrXyTOr4D6s6v+XY1c3VuEBOCrggLdCg44qDuEx031T7BODL77RmNRZpQ7gdOhgf
        GSeumD3Nxz3AhwBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2E47139F9;
        Wed,  4 Oct 2023 15:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JAWdK9SIHWU1JwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 04 Oct 2023 15:46:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3FC05A07CC; Wed,  4 Oct 2023 17:46:28 +0200 (CEST)
Date:   Wed, 4 Oct 2023 17:46:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Jan Kara <jack@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20231004154628.kgrvqbwphkjbkne6@quack3>
References: <20230928105443.1b1ad98c@canb.auug.org.au>
 <20231002112142.bfjj54ikijf4iwfr@quack3>
 <20231003132711.djftyh7vltljy2hh@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003132711.djftyh7vltljy2hh@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-10-23 09:27:11, Kent Overstreet wrote:
> On Mon, Oct 02, 2023 at 01:21:42PM +0200, Jan Kara wrote:
> > Hi!
> > 
> > On Thu 28-09-23 10:54:43, Stephen Rothwell wrote:
> > > After merging the vfs-brauner tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > > 
> > > fs/bcachefs/super-io.c: In function 'bch2_free_super':
> > > fs/bcachefs/super-io.c:166:17: error: implicit declaration of function 'blkdev_put'; did you mean 'bdi_put'? [-Werror=implicit-function-declaration]
> > >   166 |                 blkdev_put(sb->bdev, sb->holder);
> > >       |                 ^~~~~~~~~~
> > >       |                 bdi_put
> > > fs/bcachefs/super-io.c: In function 'bch2_read_super':
> > > fs/bcachefs/super-io.c:687:20: error: implicit declaration of function 'blkdev_get_by_path'; did you mean 'bdev_open_by_path'? [-Werror=implicit-function-declaration]
> > >   687 |         sb->bdev = blkdev_get_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> > >       |                    ^~~~~~~~~~~~~~~~~~
> > >       |                    bdev_open_by_path
> > > fs/bcachefs/super-io.c:687:18: error: assignment to 'struct block_device *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> > >   687 |         sb->bdev = blkdev_get_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> > >       |                  ^
> > > fs/bcachefs/super-io.c:693:26: error: assignment to 'struct block_device *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> > >   693 |                 sb->bdev = blkdev_get_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> > >       |                          ^
> > > cc1: all warnings being treated as errors
> > > 
> > > Caused by commit
> > > 
> > >   953863a5a2ff ("block: Remove blkdev_get_by_*() functions")
> > > 
> > > interacting with commit(s) from the bcachefs tree.
> > > 
> > > I would have reverted that commit for today, except I used the old
> > > vfs-brauner tree due to another build failure.  Can we just delay this
> > > one commit until after bcachefs has been converted (and any other
> > > references that may be added are fixed)?
> > 
> > Yeah, I guess removing the final commit is the easiest solution at this
> > point. It complicates a bit the series to disallow writing to mounted block
> > devices which bases on this - either I have to pospone that to the next
> > cycle after we convert bcachefs or I have to find a way for the old
> > blkdev_get_by_path() API and the new functionality to coexist. I'll think
> > about that.
> 
> Jan, Christain - what do you need from me for the conversion?

Well, the conversion is rather easy. You just need to call the new
bdev_open_by_path() function instead of the old blkdev_get_by_path(). It
returns struct bdev_handle (instead of plain struct bdev) and you
eventually need to pass this struct to bdev_release() (instead of calling
blkdev_put()).

But the merge at this point would be somewhat difficult because you'd need
to pull Christian's branch into your tree to get bdev_open_by_path() in the
first place. And that branch already depends on some changes in the btrfs
tree. So to save ourselves some headaches during the merge window, I think
not removing the old functions until bcachefs gets merged is the easiest
solution.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
