Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3A7D6CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbjJYNTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjJYNTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:19:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E36116;
        Wed, 25 Oct 2023 06:19:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AFBC433C8;
        Wed, 25 Oct 2023 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698239950;
        bh=Ci0vxFFZNtFeVP3RCR5K8NdyiUpR9ShP/DL1ujPvA3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ja7U9t4UPBw5U7+7ivbTtzhJDsKv74ZqnJQhhb2P4yiygiKRgqP6HJbKIFpe1+tfB
         inFd5+1NtHECdhg/QV/QOnQ5MN64AOVINbkmixGo7JVR2XND/Ay6xtHGMJVm34D121
         mMa/OvkeOryvyCuihvYJvwIoIxWlphDlz197VN9DS6OYJlnnZan8chHCKDdZ8fqO4V
         KAi+0VFc7+nP0ryVSX5eIGcWXoDUDSy+7M1o3IF+gOqrM5As2lK0Z83QwJi06YoSt6
         464vR52OL/EB9djGwfJVAGTbhiqpW+FI2dt9ilBO1xi8qDCaOYQxR3AWE5p2duokzS
         EhMQq5VsCl++g==
Date:   Wed, 25 Oct 2023 15:19:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: upcoming merge window: Re: linux-next: manual merge of the
 vfs-brauner tree with the btrfs tree
Message-ID: <20231025-braumeister-sprung-44d486e2d721@brauner>
References: <20231009104840.1bdadc80@canb.auug.org.au>
 <20231009-bauch-gedanken-e02e35804e03@brauner>
 <20231011083754.45a9ed53@canb.auug.org.au>
 <20231011092004.GE2211@suse.cz>
 <20231012154210.GI2211@suse.cz>
 <20231023175513.GL26353@twin.jikos.cz>
 <20231024082543.575b3edd@canb.auug.org.au>
 <20231024-kolossal-ungelegen-f95c436de174@brauner>
 <20231024154620.GQ26353@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024154620.GQ26353@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 05:46:20PM +0200, David Sterba wrote:
> On Tue, Oct 24, 2023 at 10:59:39AM +0200, Christian Brauner wrote:
> > On Tue, Oct 24, 2023 at 08:25:43AM +1100, Stephen Rothwell wrote:
> > > Hi David,
> > > 
> > > On Mon, 23 Oct 2023 19:55:13 +0200 David Sterba <dsterba@suse.cz> wrote:
> > > >
> > > > I have updated my for-next branch again, sorry (top commit 1a4dc97c883a4f763cbaf50).
> > > > There are some fixes I don't want to miss from the 6.7 pull request.
> > > > There should be minimal change to the VFS tree conflict resolution so
> > > > the diff should be reusable.
> > > 
> > > So, why did you not just merge in v6.6-rc7 (or better yet, the branch
> > > that contains the fix(es) that Linus merged) and then apply your new
> > > commits on top of that?  All the commits that were in the btrfs tree
> > > have been rebased unchanged.
> > 
> > Please reconsider that and follow Stephen's suggestion. I'm sending pull
> > requests this week and it'd be really annoying having to rebase
> > vfs.super right before sending them.
> > 
> > We let you carry the required patches in btrfs on your insistence even
> > though this effectively blocked two patchsets for a whole cycle
> 
> I hope I explained my reasons already under that series, core btrfs
> changes should not go via VFS tree.
> 
> > and then
> > merged in btrfs into vfs.super for that. Rebasing on such short notice
> > is really not very nice.
> 
> Like said in the my other reply, the amount of VFS changes asks for
> stopping taking new patches to btrfs and not continuing the patch
> workflow that I've been doing. I understand that the inter-tree
> dependencies are never easy so it's about finding some common way and
> splitting the work over more releases eventually.
> 
> A resync of our branches a week before merge window, when there are no

Pull requests for VFS and a bunch of other trees are going out the week
before the merge window opens. This has been requested multiple times.
It's mentioned in almost every kernel release mail that pull requests
should go out early.

So you rebasing a week before the merge window means rebasing
right before the pr is sent for us. You might send pull requests later
and are free to do so of course but you made us depend on your tree so
we need some stability. That's why the rebase is problematic here.

> significant changes on my side does not sound like too short notice, but
> you can feel otherwise of course.
> 
> > I'm going to wait with the rebase for a bit.
> 
> Ok, don't rebase. I'll push to linux-next the previous snapshot and will
> find a way how to deliver the new patches.

Thanks! So I know you have your workflow and that's obviously fine but
rebasing when other major trees depend on your tree is a problem and I
believe Stephen has already linked to our official "Rebasing and
merging" documentation:

"- Do not reparent a tree without a good reason to do so.  Just being on a
   newer base or avoiding a merge with an upstream repository is not
   generally a good reason."

[...]

"A frequent cause of merge-window trouble is when Linus is presented with a
patch series that has clearly been reparented, often to a random commit,
shortly before the pull request was sent.  The chances of such a series
having been adequately tested are relatively low - as are the chances of
the pull request being acted upon."

So I'll make sure to point out that we're depending on the btrfs tree
and I have a clear merge commit explaining why we're pulling it in. All
of that would be invalidated if you're rebasing. So not rebasing really
helps us a lot.

I specifically put Linus in Cc so hopefully everyone is aware up front
and there are no unnecessary suprises during the merge window.
