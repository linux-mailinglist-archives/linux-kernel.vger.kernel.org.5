Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629257B5049
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbjJBK2Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjJBK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:28:13 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41686B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:28:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6F5C76340E0F;
        Mon,  2 Oct 2023 12:28:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R2MlX5OlKfnr; Mon,  2 Oct 2023 12:28:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E90E96340E0E;
        Mon,  2 Oct 2023 12:28:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BZ6x9ZbAQMuH; Mon,  2 Oct 2023 12:28:06 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8A0F56340DEB;
        Mon,  2 Oct 2023 12:28:06 +0200 (CEST)
Date:   Mon, 2 Oct 2023 12:28:06 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Lee Jones <lee@kernel.org>
Cc:     chengzhihao1 <chengzhihao1@huawei.com>, Yu Hao <yhao016@ucr.edu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <43988304.25483.1696242486225.JavaMail.zimbra@nod.at>
In-Reply-To: <20231002101117.GA175828@google.com>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com> <977347543.226888.1682011999468.JavaMail.zimbra@nod.at> <CA+UBctA4fSbSdooQ9q9fwNuaHb_PnkfFuqJ7Q5vii-3-uCiUjw@mail.gmail.com> <412779912.228444.1682023015809.JavaMail.zimbra@nod.at> <ed510d18-47f1-7f46-03dd-84e043cab6d9@huawei.com> <1366603418.245114.1682236940160.JavaMail.zimbra@nod.at> <951e4cf7-a0ea-b3ec-931d-e6a394ddc2ab@huawei.com> <20231002101117.GA175828@google.com>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: divide error in ubi_attach_mtd_dev
Thread-Index: 62MkiFBp2u/sxgS3IlsUUBHcP38Ojw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Lee Jones" <lee@kernel.org>
> For better or worse, someone has applied to have this report associated
> with a CVE which means a bunch of companies and individuals are going to
> be tracking it.
> 
> What is the current status please?

I was about to answer that the patch is upstream, but it's only in linux-next. :-S
After lunch I'll immediately send a PR. I messed up due to too much traveling
the last months.
 
> Is this deemed to be a real issue?

I don't think so. Only the real root can install new MTD devices and run UBI attach.

> Did the report culminate in a posted patch?

Yes. As I said a patch is in next.

Thanks,
//richard
