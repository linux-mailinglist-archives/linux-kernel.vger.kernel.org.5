Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD875268C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjGMPRt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGMPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:17:44 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D730F3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:17:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1A12B62F290F;
        Thu, 13 Jul 2023 17:17:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id On-fwFvgGn7i; Thu, 13 Jul 2023 17:17:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 515CD62F2916;
        Thu, 13 Jul 2023 17:17:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wjzgm6220rwR; Thu, 13 Jul 2023 17:17:15 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2B91F62F290F;
        Thu, 13 Jul 2023 17:17:15 +0200 (CEST)
Date:   Thu, 13 Jul 2023 17:17:15 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, heiko@sntech.de,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        yifeng zhao <yifeng.zhao@rock-chips.com>
Message-ID: <1618382560.2326931.1689261435022.JavaMail.zimbra@nod.at>
In-Reply-To: <20230712154142.3c49d782@xps-13>
References: <0047fc52-bc45-a768-8bdd-c0f12cddc17e@gmail.com> <457c1da7-61dc-2a56-4f86-47413795138c@gmail.com> <20230704171348.5eee98f7@xps-13> <3af40582-d350-8eac-8639-10c285964c49@gmail.com> <20230712154142.3c49d782@xps-13>
Subject: Re: [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add
 skipbbt option
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: rawnand: rockchip-nand-controller: add skipbbt option
Thread-Index: ROgfjDoY10Wn2JoZkeBFpS1VV4xmgg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> 
>> > For the boot I think I proposed a DT property. I don't remember how far
>> > the discussion went.
>> 
>> Is there a web link of that discussion?
> 
> https://lore.kernel.org/linux-mtd/20230609104426.3901df54@xps-13/
> 
> Maybe the term "DT property" did not appear but that's what I had in
> mind :-) I don't know if it must be a chip or a partition property.
> 
> Richard, here is where I would like your feedback, I am kind of opposed
> to a "skip_bbt" module parameter. It's not a strong opinion, if you
> think it's fine I'm open.
> 
> I would rather prefer a DT property which says "do not use the
> standard pattern".

Yes, please no new module parameters. A module parameter should only affect
the behavior of the driver itself (e.g. debug mode) but not be device specific.
We made this mistake in the past too often. :-(
A single driver can serve more devices. Therefore IMHO controlling this via DT
makes perfectly sense.

Thanks,
//richard
