Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CDD7549FB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGOQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGOQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:06:54 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3363D2D51
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:06:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9423EFF802;
        Sat, 15 Jul 2023 16:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689437208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odzVbkDgtiA71LEDlKd4dEBNkmtu+z7kQ+SHhZfMdfM=;
        b=mMhGy9AayDUYSGnvXU5pn5X25YoNIvbMFPOjjI6U9aO1AWS27vXg85lxgr5NAAe6LKSPAJ
        4m9yxi1tTtzfDUOEVjPsaXomWQkL8iJ9JFxNpY1amz/IXAg0LkjSSNaklRzl7hczUmulWx
        GPu9BDj65AWihZl9wV3m+qn7tuEVOMLzPW6wVoY2wXQS75N2jYmZMw1dlxBCgUlsmY8LVS
        nsoqLxK6T4LWn6DanI+O+zj3GiuHwZ0OjFE6jpwdUjn/oedpAmNA6EBo9uiHp4FwWDgkOY
        dfMFM6i/a1/+Hkt8c9Wk13k5J+ivQr8KdF/WjDt1gpm83nntVYLb0W7DTdbu9w==
Date:   Sat, 15 Jul 2023 18:06:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 12/18] mtd: nand: omap: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230715180646.32a764d7@xps-13>
In-Reply-To: <20230714152701.GA1300718@dev-arch.thelio-3990X>
References: <20230707040622.78174-12-frank.li@vivo.com>
        <20230713075751.486075-1-miquel.raynal@bootlin.com>
        <20230714152701.GA1300718@dev-arch.thelio-3990X>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

nathan@kernel.org wrote on Fri, 14 Jul 2023 08:27:01 -0700:

> On Thu, Jul 13, 2023 at 09:57:51AM +0200, Miquel Raynal wrote:
> > On Fri, 2023-07-07 at 04:06:16 UTC, Yangtao Li wrote: =20
> > > Convert platform_get_resource(), devm_ioremap_resource() to a single
> > > call to devm_platform_get_and_ioremap_resource(), as this is exactly
> > > what this function does.
> > >=20
> > > Signed-off-by: Yangtao Li <frank.li@vivo.com> =20
> >=20
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.gi=
t nand/next, thanks. =20
>=20
> Please apply the updated version at [1], the current version is
> obviously not correct, as clang points out in next-20230714:

I will replace the first version by the corrected one.

>=20
>   drivers/mtd/nand/onenand/onenand_omap2.c:470:2: warning: variable 'c' i=
s uninitialized when used here [-Wuninitialized]
>     470 |         c->onenand.base =3D devm_platform_get_and_ioremap_resou=
rce(pdev, 0, &res);
>         |         ^
>   drivers/mtd/nand/onenand/onenand_omap2.c:465:25: note: initialize the v=
ariable 'c' to silence this warning
>     465 |         struct omap2_onenand *c;
>         |                                ^
>         |                                 =3D NULL
>   1 warning generated.
>=20
> KernelCI also reported this at [2]. I apologize if this has already been
> reported or fixed locally, I did not see your branch updated.
>=20
> [1]: https://lore.kernel.org/20230713104422.29222-1-frank.li@vivo.com/
> [2]: https://lore.kernel.org/64b137dc.170a0220.b8a13.feee@mx.google.com/
>=20
> Cheers,
> Nathan


Thanks,
Miqu=C3=A8l
