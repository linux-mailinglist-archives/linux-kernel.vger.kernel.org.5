Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074757DC101
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjJ3ULo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Oct 2023 16:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3ULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:11:43 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735FFD3;
        Mon, 30 Oct 2023 13:11:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6EB236343CA0;
        Mon, 30 Oct 2023 21:11:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZYgkxrrDMg9H; Mon, 30 Oct 2023 21:11:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A4EB463437BE;
        Mon, 30 Oct 2023 21:11:36 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7NJbZFwEBpqM; Mon, 30 Oct 2023 21:11:36 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7BAFE6340E1A;
        Mon, 30 Oct 2023 21:11:36 +0100 (CET)
Date:   Mon, 30 Oct 2023 21:11:36 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at>
In-Reply-To: <20231030173228.691620ca@xps-13>
References: <20231030103415.401ce804@canb.auug.org.au> <20231030173228.691620ca@xps-13>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-next: manual merge of the mtd tree with the vfs-brauner tree
Thread-Index: HPMrm5kihO8NFtG5G6tEC9db0fYSBQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>> Today's linux-next merge of the mtd tree got a conflict in:
>> 
>>   drivers/mtd/devices/block2mtd.c
>> 
>> between commit:
>> 
>>   1bcded92d938 ("mtd: block2mtd: Convert to bdev_open_by_dev/path()")
> 
> I haven't seen this commit, I was not Cc'ed.

Me neither. :-/
 
>> from the vfs-brauner tree and commit:
>> 
>>   ff6abbe85634 ("mtd: block2mtd: Add a valid holder to blkdev_put()")
> 
> I will drop this commit from mtd/next. Please take it through the
> vfs-brauner tree as well to avoid conflicts or otherwise, Richard, can
> you send an update at -rc1?

A side effect of 1bcded92d938 ("mtd: block2mtd: Convert to bdev_open_by_dev/path()")
is that it fixes the problem too. That's a good thing.

I'm a bit puzzled how to fix the problem for 6.5.y and 6.6.y stable releases.
Back porting 1bcded92d938 seems risky to me since the commit is large.
On the other hand, ff6abbe85634 will not make it into Linus' tree and therefore
is not suitable for stable either.

Thanks,
//richard
