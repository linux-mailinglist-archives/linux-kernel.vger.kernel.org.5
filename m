Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82A878FE82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349755AbjIANnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349823AbjIANnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:43:18 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F581728
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:42:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A208B20009;
        Fri,  1 Sep 2023 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693575767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFhitebzeZDRmy+9UMlPzwkhNVK79lY88FkzLLsp83s=;
        b=b1gOHvd5A3mtZPBsk212YaR9Rm4UOwqjxorCQ9+MBAFZ4deykig3GfAlHW7adh5btQJcBJ
        AJXFdETsfwtSHqA/ys7BEpBx6zcL554599xrQFdmOzWr7APJ233lEhOL+PyUFkm9nvaVX1
        Sr85DM69E2dQi92O0cbed63NDg+DQvEOIvYLvpinrdGOlHloVDDZmRnZefjQXxCswv2SuU
        LLTPjOb+JMAAPpFEVydfKAfe6P5tN18DDjHPX9DO3n2xDCmj5B67/L8n/Zzry1F4TLmVmj
        tNb2GNjJLd86QeCmNTzw6IfBwYDOhddPGCkRgSY9cCMGIqxsjGSTlwveeChn1w==
Date:   Fri, 1 Sep 2023 15:42:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dembskiy Igor <dii@itb.spb.ru>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] mtd: tests: remove useless checks
Message-ID: <20230901154242.12417f09@xps-13>
In-Reply-To: <20230901133641.60817-1-dii@itb.spb.ru>
References: <20230901133641.60817-1-dii@itb.spb.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

dii@itb.spb.ru wrote on Fri,  1 Sep 2023 16:36:41 +0300:

> Return value of mtdtest_scan_for_bad_() is always 0. So it causes sensele=
ss
> checks in some functions such as mtd_subpagetest_init().
>=20
> Fixes: 084db4b020c7 ("mtd: tests: introduce helper functions")
> Signed-off-by: Dembskiy Igor <dii@itb.spb.ru>
> ---
>  drivers/mtd/tests/oobtest.c     | 2 --
>  drivers/mtd/tests/pagetest.c    | 2 --
>  drivers/mtd/tests/readtest.c    | 2 --
>  drivers/mtd/tests/speedtest.c   | 3 +--
>  drivers/mtd/tests/stresstest.c  | 2 --
>  drivers/mtd/tests/subpagetest.c | 2 --
>  drivers/mtd/tests/torturetest.c | 2 --
>  7 files changed, 1 insertion(+), 14 deletions(-)
>=20
> diff --git a/drivers/mtd/tests/oobtest.c b/drivers/mtd/tests/oobtest.c
> index 13fed398937e..976f40a5656e 100644
> --- a/drivers/mtd/tests/oobtest.c
> +++ b/drivers/mtd/tests/oobtest.c
> @@ -399,8 +399,6 @@ static int __init mtd_oobtest_init(void)
>  	pr_info("test 1 of 5\n");
> =20
>  	err =3D mtdtest_erase_good_eraseblocks(mtd, bbt, 0, ebcnt);
> -	if (err)
> -		goto out;

What's the point of keeping "err =3D" or even keeping a return value if
void would be more appropriate?

Thanks,
Miqu=C3=A8l
