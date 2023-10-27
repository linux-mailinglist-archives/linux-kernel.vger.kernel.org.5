Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9867DA1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346384AbjJ0UaU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Oct 2023 16:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0UaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:30:19 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696541B5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:30:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EBDE8608890D;
        Fri, 27 Oct 2023 22:30:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G447C4Tn4azn; Fri, 27 Oct 2023 22:30:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2EF69622F591;
        Fri, 27 Oct 2023 22:30:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YQUC60C59djK; Fri, 27 Oct 2023 22:30:12 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C747B608890D;
        Fri, 27 Oct 2023 22:30:11 +0200 (CEST)
Date:   Fri, 27 Oct 2023 22:30:10 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        dpervushin <dpervushin@embeddedalley.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Message-ID: <174426702.13324.1698438610904.JavaMail.zimbra@nod.at>
In-Reply-To: <20231027194026.1bc32dfe@xps-13>
References: <20231027012033.50280-1-wangzhaolong1@huawei.com> <20231027194026.1bc32dfe@xps-13>
Subject: Re: [PATCH v3] mtd: Fix gluebi NULL pointer dereference caused by
 ftl notifier
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix gluebi NULL pointer dereference caused by ftl notifier
Thread-Index: 9idq5YltiezeBp0v4nFqPZqAKQMSSA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>> Detailed reproduction information available at the link[1],
>> 
>> The solution for the gluebi module is to run jffs2 on the UBI
>> volume without considering working with ftl or mtdblock.[2].
> 
> I am sorry but ftl, gluebi, mtdblock, jffs2 and ubi in the same report
> seem a little bit fuzzy. Are you sure about this sentence?

ZhaoLong Wang found an interesting bug while stacking various MTD components.
I suggested to just deny mtdblock on top of gluebi to avoid the whole
problem class instead of adding more duct tape.

Thanks,
//richard

The issue reminds me of one of my favorite Monty Python sketches, https://www.youtube.com/watch?v=LFrdqQZ8FFc
;-)
