Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BBA7DC8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjJaJCW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjJaJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:02:17 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A6EC2;
        Tue, 31 Oct 2023 02:02:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8A8866342D5C;
        Tue, 31 Oct 2023 10:02:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CS5USPw8IH5C; Tue, 31 Oct 2023 10:02:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 849EA6340E19;
        Tue, 31 Oct 2023 10:02:10 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5yoruwCswDZN; Tue, 31 Oct 2023 10:02:10 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5EAD76342D5C;
        Tue, 31 Oct 2023 10:02:10 +0100 (CET)
Date:   Tue, 31 Oct 2023 10:02:10 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Jan Kara <jack@suse.cz>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at>
In-Reply-To: <20231031085158.o4ilb5d47sxcqm3o@quack3>
References: <20231030103415.401ce804@canb.auug.org.au> <20231030173228.691620ca@xps-13> <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at> <20231031085158.o4ilb5d47sxcqm3o@quack3>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-next: manual merge of the mtd tree with the vfs-brauner tree
Thread-Index: HKeddtRf2AjLVc7MtEHJD/VlOU/yeQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan,

----- Ursprüngliche Mail -----
>> >>   1bcded92d938 ("mtd: block2mtd: Convert to bdev_open_by_dev/path()")
>> > 
>> > I haven't seen this commit, I was not Cc'ed.
>> 
>> Me neither. :-/
> 
> I'm sorry for that but I took the maintainers entry for BLOCK2MTD which is:
> 
> BLOCK2MTD DRIVER
> M:      Joern Engel <joern@lazybastard.org>
> L:      linux-mtd@lists.infradead.org
> S:      Maintained
> F:      drivers/mtd/devices/block2mtd.c
> 
> And both Joern and linux-mtd were CCed on the patch. If different people
> should be CCed these days, please update the entry. Thanks!

Ah, you did a manual lookup?
Because get_maintainer.pl seems to do the right thing:

$ ./scripts/get_maintainer.pl drivers/mtd/devices/block2mtd.c
Joern Engel <joern@lazybastard.org> (maintainer:BLOCK2MTD DRIVER)
Miquel Raynal <miquel.raynal@bootlin.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
Richard Weinberger <richard@nod.at> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
Vignesh Raghavendra <vigneshr@ti.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
linux-mtd@lists.infradead.org (open list:BLOCK2MTD DRIVER)
linux-kernel@vger.kernel.org (open list)
 
>> >> from the vfs-brauner tree and commit:
>> >> 
>> >>   ff6abbe85634 ("mtd: block2mtd: Add a valid holder to blkdev_put()")
>> > 
>> > I will drop this commit from mtd/next. Please take it through the
>> > vfs-brauner tree as well to avoid conflicts or otherwise, Richard, can
>> > you send an update at -rc1?
>> 
>> A side effect of 1bcded92d938 ("mtd: block2mtd: Convert to
>> bdev_open_by_dev/path()")
>> is that it fixes the problem too. That's a good thing.
>> 
>> I'm a bit puzzled how to fix the problem for 6.5.y and 6.6.y stable releases.
>> Back porting 1bcded92d938 seems risky to me since the commit is large.
>> On the other hand, ff6abbe85634 will not make it into Linus' tree and therefore
>> is not suitable for stable either.
> 
> Yes, that's one of the cases where stable rules make life harder for actual
> fixes... You can try pushing ff6abbe85634 to stable even if it is not
> upstream since it fixes a real bug and taking the upstream solution is
> indeed IMO too intrusive. Sometimes stable maintainers accept such fixes.

Yep, let's try this route. :-)

Thanks,
//richard
