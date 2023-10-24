Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050527D56F2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbjJXPxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjJXPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:53:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC4283;
        Tue, 24 Oct 2023 08:53:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDACE1FE87;
        Tue, 24 Oct 2023 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698162794;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IOSYLfCHMOWYHaY/zZ/biPaqXDPGHttOtpOyAC92RI4=;
        b=BDT/ZDzYf393N477bHDpL+3QDNlWBxEyClyZNnu3ZjMBLqTaefkh1SikeVNHVfG3hmBhgM
        ZOtXVVG9OF/MEfV+hB0mS9cR2So/hxtyKN2Rfcd4lFo0rtyOETw78dz9gZ6HvXe1j0oXpr
        99krxYkw8DayAqB7Wc+4llMpVZM9Qos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698162794;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IOSYLfCHMOWYHaY/zZ/biPaqXDPGHttOtpOyAC92RI4=;
        b=VDnCPyf1ErLPb/PiPGcZMeIC+ACwsKIwzgCC06G01vKfZwQ+j78dav50TtDN9rJVMYHbjW
        5GGaLGPphw0IG9Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 978C91391C;
        Tue, 24 Oct 2023 15:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8kUEJGroN2WLWQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 Oct 2023 15:53:14 +0000
Date:   Tue, 24 Oct 2023 17:46:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: upcoming merge window: Re: linux-next: manual merge of the
 vfs-brauner tree with the btrfs tree
Message-ID: <20231024154620.GQ26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231009104840.1bdadc80@canb.auug.org.au>
 <20231009-bauch-gedanken-e02e35804e03@brauner>
 <20231011083754.45a9ed53@canb.auug.org.au>
 <20231011092004.GE2211@suse.cz>
 <20231012154210.GI2211@suse.cz>
 <20231023175513.GL26353@twin.jikos.cz>
 <20231024082543.575b3edd@canb.auug.org.au>
 <20231024-kolossal-ungelegen-f95c436de174@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-kolossal-ungelegen-f95c436de174@brauner>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -10.80
X-Spamd-Result: default: False [-10.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         TO_DN_ALL(0.00)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:59:39AM +0200, Christian Brauner wrote:
> On Tue, Oct 24, 2023 at 08:25:43AM +1100, Stephen Rothwell wrote:
> > Hi David,
> > 
> > On Mon, 23 Oct 2023 19:55:13 +0200 David Sterba <dsterba@suse.cz> wrote:
> > >
> > > I have updated my for-next branch again, sorry (top commit 1a4dc97c883a4f763cbaf50).
> > > There are some fixes I don't want to miss from the 6.7 pull request.
> > > There should be minimal change to the VFS tree conflict resolution so
> > > the diff should be reusable.
> > 
> > So, why did you not just merge in v6.6-rc7 (or better yet, the branch
> > that contains the fix(es) that Linus merged) and then apply your new
> > commits on top of that?  All the commits that were in the btrfs tree
> > have been rebased unchanged.
> 
> Please reconsider that and follow Stephen's suggestion. I'm sending pull
> requests this week and it'd be really annoying having to rebase
> vfs.super right before sending them.
> 
> We let you carry the required patches in btrfs on your insistence even
> though this effectively blocked two patchsets for a whole cycle

I hope I explained my reasons already under that series, core btrfs
changes should not go via VFS tree.

> and then
> merged in btrfs into vfs.super for that. Rebasing on such short notice
> is really not very nice.

Like said in the my other reply, the amount of VFS changes asks for
stopping taking new patches to btrfs and not continuing the patch
workflow that I've been doing. I understand that the inter-tree
dependencies are never easy so it's about finding some common way and
splitting the work over more releases eventually.

A resync of our branches a week before merge window, when there are no
significant changes on my side does not sound like too short notice, but
you can feel otherwise of course.

> I'm going to wait with the rebase for a bit.

Ok, don't rebase. I'll push to linux-next the previous snapshot and will
find a way how to deliver the new patches.
