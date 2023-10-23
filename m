Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682C37D2AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjJWHPr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 03:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjJWHPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:15:45 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D93E6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:15:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 86C496343CC3;
        Mon, 23 Oct 2023 09:15:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jzIxp6FNQNy6; Mon, 23 Oct 2023 09:15:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EA21263DCAB6;
        Mon, 23 Oct 2023 09:15:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6rUs1NLI9QuN; Mon, 23 Oct 2023 09:15:41 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C413C6343CC3;
        Mon, 23 Oct 2023 09:15:41 +0200 (CEST)
Date:   Mon, 23 Oct 2023 09:15:41 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dpervushin <dpervushin@embeddedalley.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Message-ID: <879960555.29268.1698045341596.JavaMail.zimbra@nod.at>
In-Reply-To: <93b2d5ab-e36c-be08-7343-ef4ca16f991d@huawei.com>
References: <20231018121618.778385-1-wangzhaolong1@huawei.com> <1381458025.20897.1697747248632.JavaMail.zimbra@nod.at> <891e554b-c133-6378-3a65-836fc9147e54@huawei.com> <441107100.23734.1697904580252.JavaMail.zimbra@nod.at> <93b2d5ab-e36c-be08-7343-ef4ca16f991d@huawei.com>
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: gluebi: Fix NULL pointer dereference caused by ftl notifier
Thread-Index: w2v3m0BEzKt4F2H6jp2F1AuzbEeVBQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>>> If we add new ioctls to control creation/destroying of gluebi, then
>>> gluebi mtd won't be automatically created when UBI volume is added. I'm
>>> not certain whether this change will effect existing startup process
>>> that depends on gluebi.
>> 
>> Let's take a stack back. The sole purpose of gluebi is providing
>> a way to run JFFS2 on top of UBI.
> 
> Is it possible that someone runs ext4 on mtdblock based on gluebi, for
> the advantage of wear-leveling?

Unless they want to kill their NAND immediately, no.
UBIblock hat initially an RW-Mode but it was rejected because
UBI is not an FTL and will all dangerous setups.

What I'm trying to say is, I'd like to avoid adding complicated solutions
or workarounds just to make artificial stacking of outdated MTD components
possible.
Let's keep the big picture in mind.

Thanks,
//richard
