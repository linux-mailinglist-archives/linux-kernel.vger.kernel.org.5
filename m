Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863CC776C65
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjHIWoC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Aug 2023 18:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjHIWoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:44:01 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE2D2;
        Wed,  9 Aug 2023 15:44:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A2B1F635D29E;
        Thu, 10 Aug 2023 00:43:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id v_JwZWmfHdUG; Thu, 10 Aug 2023 00:43:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4E2D4635D29D;
        Thu, 10 Aug 2023 00:43:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jfzWTASF6VHD; Thu, 10 Aug 2023 00:43:59 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2EA2A635D28F;
        Thu, 10 Aug 2023 00:43:59 +0200 (CEST)
Date:   Thu, 10 Aug 2023 00:43:59 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     hch <hch@lst.de>
Cc:     Stephan Wurm <stephan.wurm@a-eberle.de>,
        linux-block <linux-block@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>
Message-ID: <533238598.5052964.1691621039144.JavaMail.zimbra@nod.at>
In-Reply-To: <20230809223703.GA10719@lst.de>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm> <1293911429.1782934.1691445776353.JavaMail.zimbra@nod.at> <20230809135308.GA32214@lst.de> <ZNOec8JmndA63Mnh@PC-LX-Wurm> <20230809141542.GA32614@lst.de> <366198994.5052941.1691620484888.JavaMail.zimbra@nod.at> <20230809223703.GA10719@lst.de>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubiblock: null pointer dereference using scatterlist in work_queue
Thread-Index: r+jP0Y2+YKP9h0H5tuoMD33XwrLVCg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> On Thu, Aug 10, 2023 at 12:34:44AM +0200, Richard Weinberger wrote:
>> Will do so! So far I managed to get UBIblock work with scsi_kmap_atomic_sg().
>> Sadly now with kmap'ed memory a bounce buffer is needed since IO in UBI/MTD can
>> sleep.
>> Is there a strong reason why scsi_kmap_atomic_sg() needs IRQs disabled?
> 
> I don't think it needs irqs disabled.  Also if you switch from the
> deprecated kmap_atomic to kmap_local first you can sleep and don't
> need bounce buffers.

Yep, for upstream kmap_local will do the trick, but I need also something
for the stable trees.
Anyway, time to get some sleep.

Thanks,
//richard
