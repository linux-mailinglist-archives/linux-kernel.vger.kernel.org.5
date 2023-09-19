Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E657A6846
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjISPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjISPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:43:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDB9C0;
        Tue, 19 Sep 2023 08:43:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34702C433C7;
        Tue, 19 Sep 2023 15:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695138215;
        bh=GcdtwIA3CujNqnqgYnHn7vxC4/E5o49bT3JihnbJ/+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTA8mPE3QgGvcr0+J7KxEWa3ndltLPGbrC+ljy3+7xKxnFHZK4smDOuT4+ouyOtb4
         PcjP1YQCHtftevMi8R58eGUbio/1XEeBioLLu9TRIb0EV5aHD34kEPxNd5GqOoUw2c
         2XsJbXM2nI/WKQRL+huyu4cbpg2DbJBeCNUZP/En4Zz4+ctHH/4pcGapwHtfeslhH6
         6zGzSA+PYhqW4F0n9pJUPKxA4Tz1Fj00UxMghMEy+hHq0qjcNDspplF/p74f2tXE6G
         uTj3f0PpM4xOCkGyNPu9mMsuQMqKKaH/zfx127+cihCyzW6bjyoe5OVAG/LDVZFcdx
         /7PoUo1Scuw7w==
Date:   Tue, 19 Sep 2023 08:43:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20230919154334.GD348037@frogsfrogsfrogs>
References: <20230915093953.310503ee@canb.auug.org.au>
 <20230918205206.GA348037@frogsfrogsfrogs>
 <20230919-zensieren-plakat-05a044361e57@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-zensieren-plakat-05a044361e57@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:34:01PM +0200, Christian Brauner wrote:
> On Mon, Sep 18, 2023 at 01:52:06PM -0700, Darrick J. Wong wrote:
> > On Fri, Sep 15, 2023 at 09:39:53AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > The following commit is also in the iomap tree as a different commit
> > > (but the same patch):
> > > 
> > >   de5b0b257ee3 ("iomap: handle error conditions more gracefully in iomap_to_bh")
> > > 
> > > This is commit
> > > 
> > >   4aa8cdd5e523 ("iomap: handle error conditions more gracefully in iomap_to_bh")
> > > 
> > > in the iomap tree.
> > 
> > Christian, do you want to push this to Linus instead of me?  I've a
> > couple more fixes that I'm about to send out to fsdevel and could just
> > roll all the iomap stuff into a single branch... but if you were about
> > to this to Linus I don't mind letting that happen.
> 
> So I was about to send a pull request tomorrow. I thought I was supposed
> to pick up iomap stuff. Let me know what you prefer. I can easily drop
> this patch. :)

I'll push that patch, then.

In general, you can fling any non-trivial iomap patches at me, since I
will likely want to run them through my testing cloud anyway.

(And just to be clear: I don't mind if you push things like trivial api
cleanups that are part of another series through your main vfs tree.)

--D
