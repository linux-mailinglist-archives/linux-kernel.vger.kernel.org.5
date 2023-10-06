Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75C97BBBE9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjJFPlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjJFPlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:41:42 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF06AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:41:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 754BCFF80A;
        Fri,  6 Oct 2023 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696606899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWgixyze7ly2jxAoSChg1RnG0qY3wYNYv8+NFu8WJl0=;
        b=IKJou9RkycVWCcf7n+d7yoYGr1piTPjh9K5pok60FzRAqerD29qvCVjAUYl1Ss6XmakocD
        LLa3wX7a14toQNvGnFtHPw8G1BLisvCMJ0DWOQoOqefhyP7BYiF7S7kn4ZS5m+cgQve3Op
        2xLQVE7YPmPCCUzHBWldvxcTuU1/I5cYWIkF+eBkDqxa/hyNxoSX3Ui7dQnwyT9ZrHlS8K
        JMuaCJz7VCGiklbJ2OqqMUVs+fIAX1GEsjtA9pQ1OOjX9MQVhHwPL6Uh1ZuqE04m9QZKOC
        SnW4mDUvnxzfzF70eQNtvHv67cJFnxAiqnL2FYBs3g9kERyjNxCNDNN3WkT1Sw==
Date:   Fri, 6 Oct 2023 17:41:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     JaimeLiao <jaimeliao.tw@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: rawnand: Remove unused of_gpio.h inclusion
Message-ID: <20231006174137.2e745cb4@xps-13>
In-Reply-To: <ZSAkUMnXw4SbS2pC@smile.fi.intel.com>
References: <20230615164210.25515-1-andriy.shevchenko@linux.intel.com>
        <CAFBinCAJ5m+NTVry56=0AYMYr9xiM9KS7F837Hqb=ptOG_u54g@mail.gmail.com>
        <ZKvW0yzxU1ktDALd@smile.fi.intel.com>
        <ZSAkUMnXw4SbS2pC@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Fri, 6 Oct 2023 18:14:24
+0300:

> +Cc: GPIO maintainers
>=20
> On Mon, Jul 10, 2023 at 01:00:51PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 16, 2023 at 12:10:52AM +0200, Martin Blumenstingl wrote: =20
> > > On Thu, Jun 15, 2023 at 6:42=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote: =20
> > > >
> > > > The of_gpio.h is not and shouldn't be used in the drivers. Remove i=
t.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> =
=20
> > > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> =20
> >=20
> > Thank you!
> >=20
> > Can it be applied now? =20
>=20
> So, this is still not applied, does it mean we need to go via GPIO tree
> with it?

I remember your ping and also answering it, but I cannot find it. Let
me look into this. In any case, apologies for that.

Thanks,
Miqu=C3=A8l
