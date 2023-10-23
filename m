Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6AA7D2AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjJWGqO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 02:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjJWGqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:46:12 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994D4DF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:46:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C2FF96343CB8;
        Mon, 23 Oct 2023 08:46:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OIXc1Ua0y-Zo; Mon, 23 Oct 2023 08:46:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EBFBE6343CC3;
        Mon, 23 Oct 2023 08:46:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Yfd4N8mtWQUK; Mon, 23 Oct 2023 08:46:04 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A3DEC6343CB8;
        Mon, 23 Oct 2023 08:46:04 +0200 (CEST)
Date:   Mon, 23 Oct 2023 08:46:04 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc:     chengzhihao1 <chengzhihao1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dpervushin <dpervushin@embeddedalley.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Message-ID: <1141312317.29142.1698043564332.JavaMail.zimbra@nod.at>
In-Reply-To: <9b543be7-a858-c982-3fcf-408701ae4ac9@huawei.com>
References: <20231018121618.778385-1-wangzhaolong1@huawei.com> <1381458025.20897.1697747248632.JavaMail.zimbra@nod.at> <891e554b-c133-6378-3a65-836fc9147e54@huawei.com> <441107100.23734.1697904580252.JavaMail.zimbra@nod.at> <9b543be7-a858-c982-3fcf-408701ae4ac9@huawei.com>
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: gluebi: Fix NULL pointer dereference caused by ftl notifier
Thread-Index: K47lzcDEhIbqXCtxL40/66d/VssadQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "ZhaoLong Wang" <wangzhaolong1@huawei.com>
> An: "richard" <richard@nod.at>, "chengzhihao1" <chengzhihao1@huawei.com>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "dpervushin"
> <dpervushin@embeddedalley.com>, "Artem Bityutskiy" <Artem.Bityutskiy@nokia.com>, "linux-mtd"
> <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "yi zhang" <yi.zhang@huawei.com>,
> "yangerkun" <yangerkun@huawei.com>
> Gesendet: Montag, 23. Oktober 2023 08:41:12
> Betreff: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by ftl notifier

>> 
>> IOW, no mtdblock (hence, also no FTLs) on top of gluebi.
>> 
>> What do you guys think?
>> 
>> Thanks,
>> //richard
>> 
> 
> 
> JFFS2 needs to work on the block device, so the mtdblock needs to work
> on the top of gluebi.
> 
> This is directly reflected in the jffs2 mount command, such as
> 
>   # mount -t jffs2 /dev/mtdblockX /mnt/jffs2

The limitation is long gone. It comes from the dark and old times
where Linux was only able to mount block devices.

You can do: mount -t jffs2 mtdX /mnt/jffs2

Thanks,
//richard
