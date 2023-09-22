Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1A7AB3CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjIVOjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjIVOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:39:14 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4570AC6;
        Fri, 22 Sep 2023 07:39:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67AC3FF80E;
        Fri, 22 Sep 2023 14:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695393546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tT8hyAzx4ZhqoZcyPUvFHwNUdgW73Re8JuIC98mcHSU=;
        b=kGr+G68sW/V6sxZ+CuqPiY9XD8wSflqq81r1Kdwt1d+k2gNxqDeRjw0CKV8hnDyXl5xDnT
        1G9WCCX5cnViNlsg5N/BJUkz9OsFw9THGrF1zduUv5m7vwXMBHyKW92qoym6v0zCwNZ5Te
        7Gi0AApBFZDcecO0gKa6gsfc/L/Y2tovnyKnXHd4D8ooLZZKnXibyGZpE4oTpPj964F9ZQ
        oip070eo8uATdJJAV3WtFrsslsfSb3adXV92SKw6Si7/xaYS6UZKtTkFNLJpt+wGZavM95
        IN0pMDUj21bDbRQkgER13PamXMwDFzokfqcgZFrEN3hl0zXOAbA4/X+PxXrHBw==
Date:   Fri, 22 Sep 2023 16:39:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/6] mtd: parsers: ar7: remove support
Message-ID: <20230922163903.3f49ea2a@xps-13>
In-Reply-To: <20230922061530.3121-3-wsa+renesas@sang-engineering.com>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
        <20230922061530.3121-3-wsa+renesas@sang-engineering.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

wsa+renesas@sang-engineering.com wrote on Fri, 22 Sep 2023 08:15:23
+0200:

> AR7 is going to be removed from the Kernel, so remove its support for
> MTD.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes since v1:
> * added ack
>=20
>  arch/arm/configs/pxa_defconfig |   1 -

I'm not sure it is wise to merge defconfig changes through mtd. Would
you mind sending this change aside to avoid potential conflicts? Each
patch can live on their own anyway.

>  drivers/mtd/parsers/Kconfig    |   5 --
>  drivers/mtd/parsers/Makefile   |   1 -
>  drivers/mtd/parsers/ar7part.c  | 129 ---------------------------------

Do you have other changes related to this file in your tree? It failed
to apply on my side.

>  4 files changed, 136 deletions(-)
>  delete mode 100644 drivers/mtd/parsers/ar7part.c

Thanks,
Miqu=C3=A8l
