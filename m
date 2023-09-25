Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D11D7AD485
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjIYJb5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjIYJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:31:55 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860FDC0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:31:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 43D0C635DB5B;
        Mon, 25 Sep 2023 11:31:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id M_5O8PH87ned; Mon, 25 Sep 2023 11:31:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CE4CE622F591;
        Mon, 25 Sep 2023 11:31:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R0w8n3XsPmXs; Mon, 25 Sep 2023 11:31:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 96F04635DB5B;
        Mon, 25 Sep 2023 11:31:47 +0200 (CEST)
Date:   Mon, 25 Sep 2023 11:31:47 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Message-ID: <1385178592.80194.1695634307277.JavaMail.zimbra@nod.at>
In-Reply-To: <20230925112853.6cb7fff3@xps-13>
References: <20230923005856.2538223-1-wangzhaolong1@huawei.com> <20230925104938.3f7b4284@xps-13> <495954216.80155.1695633280285.JavaMail.zimbra@nod.at> <20230925112853.6cb7fff3@xps-13>
Subject: Re: [RFC] mtd: Fix error code loss in mtdchar_read() function.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix error code loss in mtdchar_read() function.
Thread-Index: W7/WnPiEM/oyGFOILGmf+sfD68BiaA==
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
>> As pointed out by Miquel, the comment makes it clean that this behavior is
>> on purpose. If we return now all of a sudden -EBADMSG for the described
>> scenario we might even break existing MTD userspace.
> 
> The bugzilla link in the commit log [1] mentions:

Ups.
 
> * dd would just stop in the middle without showing errors
>  -> we probably don't care, we expect the userspace to know this is
>  NAND when dealing with mtd devices directly, dd is not mtd-aware
>  anyway.

Yep. That's fine.
 
> * ubiformat would loop forever
>  -> that one needs attention I guess :)

Hmm. Let me check the source.

Thanks,
//richard
