Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA497E84C2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbjKJUwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjKJUvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:51:48 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D4028B1C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:25:55 -0800 (PST)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D38A409D6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699611954;
        bh=gPKnvjH5Hg4muGnCgN2WsdJlG6e8rKiWPTWzq5wjF2k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=L5I/2emQcUGd9SQiSQ6H1ORrGk6OIhclu3IXnaAbIIdHrcsoRJElXngy5b3vVtv/P
         FdNufWUTMU3J6zW2SeW+npMmo967PiIFVsyi142Xo8UEsdMh7TtUvJAoZtJ9ULvHuG
         ymQ9nx+4syHtqnCGjCRbs4rE9TkegflAsUcTRYqxwcIGdBSHCVz188uktlLB3Aovly
         0WIvSg7ap4cgdx02xA1al4uYmmZfkXY6Is3OYk+83QGunGWSRCrpXDWXBsghYKJHFU
         C6U+5s6XMfoBZEdV6febgvvef4AnpnMvxBW5K9Pp2jvBtMZCywyHdRI39CF3tCV1UT
         2GhPGpEZvx2rg==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a7d261a84bso27001297b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611952; x=1700216752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPKnvjH5Hg4muGnCgN2WsdJlG6e8rKiWPTWzq5wjF2k=;
        b=s0uylN91I1bqBUcoZ7CeLnXoenpXbKPYTgsx82zXBwZVmzdUTWIf9xerNWVkgaMhY5
         lC98J4RjoRktPz6Py0TVpUbZf2CdI2RxoZsWaZCsSUNNvTpERo9LgaGcX0W+ENIwzVEh
         NS0zVdvYVCwo5GheF+8WCqBjHAr0F8sUO0NZf1bDzajyGiKTjDdpu6B5bjbmdLKKl4Bo
         8Z/SUVRTzjjrSdUIj3HPuwKqIF1zPH8CzLjgUbszfP8R0vlKwCMR0OM43kMZDcsY1b86
         d3gic7m/7ukxpXZXEKi2mpluVi4Nqm0LClZ5OHwm0WIycu0s5tKzh/depQkaaztcjgWq
         jo8Q==
X-Gm-Message-State: AOJu0Yw8czR7zoBLsQRqQ/TbdIiwE/UwwcXSBx8kB81GGYcZfQ/em0DS
        r6jnJFX1Zw74iWp/bMkd08FnyzQVfNPH6L8JF48PCXoooEEdgsS+BVU7AeUcBDrt/63BxgOtIIT
        OGO6fAuls5fniRqBvOBbcsEXxOABQXk0ji3QVUgIFqSmiD4LlJzoXMMwUkg==
X-Received: by 2002:a25:492:0:b0:da0:4c40:67b7 with SMTP id 140-20020a250492000000b00da04c4067b7mr7527216ybe.31.1699611952375;
        Fri, 10 Nov 2023 02:25:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7Uzw6FsbRf6Dv35NVE2MMC+7rPWfQQ1o1KBRo2GlsBu+Q0CQ62RXpHoloA8Nr+Pl4ZHvt9PLk4RcUggImr4U=
X-Received: by 2002:a25:492:0:b0:da0:4c40:67b7 with SMTP id
 140-20020a250492000000b00da04c4067b7mr7527211ybe.31.1699611952078; Fri, 10
 Nov 2023 02:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20231108094303.46303-1-acelan.kao@canonical.com> <20231110053721.GG17433@black.fi.intel.com>
In-Reply-To: <20231110053721.GG17433@black.fi.intel.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Fri, 10 Nov 2023 18:25:41 +0800
Message-ID: <CAFv23QnbG0QX=cGjVYA1GnQFf9HFd7M7gXuAxBDO4o-POvO9yg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: Replace -ENOTSUPP with -EOPNOTSUPP in op checking
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

Mika Westerberg <mika.westerberg@linux.intel.com> =E6=96=BC 2023=E5=B9=B411=
=E6=9C=8810=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=881:37=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> On Wed, Nov 08, 2023 at 05:43:02PM +0800, AceLan Kao wrote:
> > From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> >
> > No functional changes are introduced by this patch; it's a code cleanup
> > to use the correct error code.
>
> Probably good to mention here that this affect only the "SPI MEM"
> drivers and the core parts. Also you could explain here that the reaosn
> for this is to make sure we use unified "operation not supported" return
> code accross these.
Got it.
>
> Does some kernel-doc need updating as well to make sure the future
> drivers will return the correct one if they do not support given
> optional operations?
I have no idea where to add this, do you mean add a section in
Documentation/spi/spi-summary.rst?
>
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> >
> > ---
> > v5. distinguish -EOPNOTSUPP from -ENOTSUPP
> > ---
> >  drivers/mtd/nand/spi/core.c | 2 +-
> >  drivers/spi/atmel-quadspi.c | 2 +-
> >  drivers/spi/spi-ath79.c     | 2 +-
> >  drivers/spi/spi-bcm-qspi.c  | 2 +-
> >  drivers/spi/spi-mem.c       | 6 +++---
> >  drivers/spi/spi-npcm-fiu.c  | 2 +-
> >  drivers/spi/spi-ti-qspi.c   | 4 ++--
> >  drivers/spi/spi-wpcm-fiu.c  | 2 +-
>
> I think you should include the SPI subsystem maintainer as well, at
> least for visibility.
Right, I should CC them.
