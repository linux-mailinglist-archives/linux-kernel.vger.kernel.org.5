Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5657DCAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343862AbjJaKdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjJaKdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:33:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FB683;
        Tue, 31 Oct 2023 03:33:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D00C433C8;
        Tue, 31 Oct 2023 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698748428;
        bh=a7gp7DRcv8OvpRKdsAuuXs9I/KTIhEXp5Xl8gQxofyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gw1t8yei/wFammCr5hGFfPzbIb24gFBJBVbXT6+URmoWYBfd484sBiQ9UQsAqEzxj
         74B0ifPSjDs/6KOohiE4/7tTX1ILG3NFRTUrjE44KYrSaUGHpGNiEY7KAk6O4WQfLK
         FdWvlnhd2t/MBrbr3zIoCSDyRag2JN6DvYAItBjL6dTqp32eph0wXBn4VBMyxRRlQb
         MasSZwft6Y3YlRh+miqFJaJxdkQa635nnJ4iYc5CxvrB8t87uJgdXw2aLDEuX5aHoh
         E8Niv+eVqA7lVNr82Ucuqj67ATp4xuaeeppngbN0/3IYTwxmxzYxqRePMxIOvw7DQ7
         KN+BE38dPnGIA==
Date:   Tue, 31 Oct 2023 11:33:43 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Jan Kara <jack@suse.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
Message-ID: <20231031-laienhaft-weshalb-bc27f8dacd9e@brauner>
References: <20231030103415.401ce804@canb.auug.org.au>
 <20231030173228.691620ca@xps-13>
 <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at>
 <20231031085158.o4ilb5d47sxcqm3o@quack3>
 <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:02:10AM +0100, Richard Weinberger wrote:
> Jan,
> 
> ----- Ursprüngliche Mail -----
> >> >>   1bcded92d938 ("mtd: block2mtd: Convert to bdev_open_by_dev/path()")
> >> > 
> >> > I haven't seen this commit, I was not Cc'ed.
> >> 
> >> Me neither. :-/
> > 
> > I'm sorry for that but I took the maintainers entry for BLOCK2MTD which is:
> > 
> > BLOCK2MTD DRIVER
> > M:      Joern Engel <joern@lazybastard.org>
> > L:      linux-mtd@lists.infradead.org
> > S:      Maintained
> > F:      drivers/mtd/devices/block2mtd.c
> > 
> > And both Joern and linux-mtd were CCed on the patch. If different people
> > should be CCed these days, please update the entry. Thanks!
> 
> Ah, you did a manual lookup?
> Because get_maintainer.pl seems to do the right thing:
> 
> $ ./scripts/get_maintainer.pl drivers/mtd/devices/block2mtd.c
> Joern Engel <joern@lazybastard.org> (maintainer:BLOCK2MTD DRIVER)
> Miquel Raynal <miquel.raynal@bootlin.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
> Richard Weinberger <richard@nod.at> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
> Vignesh Raghavendra <vigneshr@ti.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
> linux-mtd@lists.infradead.org (open list:BLOCK2MTD DRIVER)
> linux-kernel@vger.kernel.org (open list)
>  
> >> >> from the vfs-brauner tree and commit:
> >> >> 
> >> >>   ff6abbe85634 ("mtd: block2mtd: Add a valid holder to blkdev_put()")
> >> > 
> >> > I will drop this commit from mtd/next. Please take it through the
> >> > vfs-brauner tree as well to avoid conflicts or otherwise, Richard, can
> >> > you send an update at -rc1?
> >> 
> >> A side effect of 1bcded92d938 ("mtd: block2mtd: Convert to
> >> bdev_open_by_dev/path()")
> >> is that it fixes the problem too. That's a good thing.
> >> 
> >> I'm a bit puzzled how to fix the problem for 6.5.y and 6.6.y stable releases.
> >> Back porting 1bcded92d938 seems risky to me since the commit is large.
> >> On the other hand, ff6abbe85634 will not make it into Linus' tree and therefore
> >> is not suitable for stable either.
> > 
> > Yes, that's one of the cases where stable rules make life harder for actual
> > fixes... You can try pushing ff6abbe85634 to stable even if it is not
> > upstream since it fixes a real bug and taking the upstream solution is
> > indeed IMO too intrusive. Sometimes stable maintainers accept such fixes.
> 
> Yep, let's try this route. :-)

Is there anything for me to do? IOW, do I need to grab that patch or
not? :)
