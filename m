Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275407D56AE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbjJXPja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXPj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:39:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A9ABA;
        Tue, 24 Oct 2023 08:39:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5121221BB7;
        Tue, 24 Oct 2023 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698161963;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pBbG7Dlg9ISSfxrYHybVBbiAglMyxfSjXMsUAVHI02E=;
        b=jN9jmipLmILlZjDxfH52TPyHhdKRYMkSPfP8wpUC/oAcaE5NyIIJIV7c5n9b1v0GIcJXO9
        h2nSLCnR4aMBpGuUPQpeReUt+YbK5q4Ac7+U2CSLUK6AK/jX/lYXjqgW8P9VNJ9Yw4NsjW
        aSpmV+ez3fewk2oEDxY8kowcKh3GBYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698161963;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pBbG7Dlg9ISSfxrYHybVBbiAglMyxfSjXMsUAVHI02E=;
        b=N025Ht92MTSUqFMrLPOS9y41MimMfSUTBobHGn4J2zOtxbedRBsM82a1tzjl8fDTfpyXaM
        nRd3J0eICq7s8YCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1ABDD1391C;
        Tue, 24 Oct 2023 15:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jb+1BSvlN2VMSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 Oct 2023 15:39:23 +0000
Date:   Tue, 24 Oct 2023 17:32:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Sterba <dsterba@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231024153229.GP26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231009104840.1bdadc80@canb.auug.org.au>
 <20231009-bauch-gedanken-e02e35804e03@brauner>
 <20231011083754.45a9ed53@canb.auug.org.au>
 <20231011092004.GE2211@suse.cz>
 <20231012154210.GI2211@suse.cz>
 <20231023175513.GL26353@twin.jikos.cz>
 <20231024082543.575b3edd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024082543.575b3edd@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
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
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         TO_DN_ALL(0.00)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 08:25:43AM +1100, Stephen Rothwell wrote:
> Hi David,
> 
> On Mon, 23 Oct 2023 19:55:13 +0200 David Sterba <dsterba@suse.cz> wrote:
> >
> > I have updated my for-next branch again, sorry (top commit 1a4dc97c883a4f763cbaf50).
> > There are some fixes I don't want to miss from the 6.7 pull request.
> > There should be minimal change to the VFS tree conflict resolution so
> > the diff should be reusable.
> 
> So, why did you not just merge in v6.6-rc7 (or better yet, the branch
> that contains the fix(es) that Linus merged) and then apply your new
> commits on top of that?  All the commits that were in the btrfs tree
> have been rebased unchanged.

I don't back merge Linus' branches nor the fixes that I send, that's
against what I understand is the recommended practice. The development
queue gets rebased on top of the rc, in that way it's clean and
eventually drops patches sent independently merged to the master branch.

What you suggest I don't even visualize, like keep my previous frozen
branch on rc5, merge rc7 and then merge some other branch with the
recent fix? Or create another one with just additional patches (there
were like 10)? That looks as if the btrfs tree would be quite busy but
in fact it's not, the linear series makes a lot of things easier.
For example I add Reviewed-by, CC: stable@ or other tags, fix typos or
fix whitespace as long as there's another sync point before the code
freeze.

My workflow has been working well but now there's a huge pile of
conflicting VFS changes that require other trees to effectively stop
taking new patches or require back merges from Linus.

I've assumed that linux-next can deal with rebases and eventual conflict
resolutions stay applicable in some way and that one more sync a week
before merge window is enough time for everybody to sync.
