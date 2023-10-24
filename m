Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574CC7D4B64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjJXI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjJXI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:59:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C4C0;
        Tue, 24 Oct 2023 01:59:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927FCC433C7;
        Tue, 24 Oct 2023 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698137984;
        bh=bwCKOeae3hSrhlEhSnNT9VrO7FtptDrwqE+crRAZFB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTa9g/TqOKqBXjXKmQgF8Y1hSmWPP8Uh/y4umZIPLDC3hmeI8Vt/ybGibLbAMDr02
         cTck6JUXSRUTu+VTFzDWBp0sRruPQ/fo7cLa6uGCjJLF6shyMoHk8DWeCnJm5qRBIt
         HDNWccRQego6ymue7uYPY8eH21XV8ywrStWd60CcHzq+05wvZuLULy0sYVrt94e1YM
         8A4KrjvGSvRsnhDYqJ1FLo25MwSMt1IgEyB48LHwJoGaN9C+y7eUsRQTKkt8qbjm75
         Xt/mL0gSMkmbzB3HDkOYH9u+AiHF9Klskgs7ql8xE3LcABLReRUUXICC0DSMR7NQWy
         X25txjdeylosQ==
Date:   Tue, 24 Oct 2023 10:59:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: upcoming merge window: Re: linux-next: manual merge of the
 vfs-brauner tree with the btrfs tree
Message-ID: <20231024-kolossal-ungelegen-f95c436de174@brauner>
References: <20231009104840.1bdadc80@canb.auug.org.au>
 <20231009-bauch-gedanken-e02e35804e03@brauner>
 <20231011083754.45a9ed53@canb.auug.org.au>
 <20231011092004.GE2211@suse.cz>
 <20231012154210.GI2211@suse.cz>
 <20231023175513.GL26353@twin.jikos.cz>
 <20231024082543.575b3edd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024082543.575b3edd@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Please reconsider that and follow Stephen's suggestion. I'm sending pull
requests this week and it'd be really annoying having to rebase
vfs.super right before sending them.

We let you carry the required patches in btrfs on your insistence even
though this effectively blocked two patchsets for a whole cycle and then
merged in btrfs into vfs.super for that. Rebasing on such short notice
is really not very nice.

I'm going to wait with the rebase for a bit.
