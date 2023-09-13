Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0622C79ED47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjIMPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjIMPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:37:48 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A58CC1;
        Wed, 13 Sep 2023 08:37:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFCDFFF805;
        Wed, 13 Sep 2023 15:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694619461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDuZH+uvutfHgzRCfxDkmOKfULSH31Y70SqnVTdAeGk=;
        b=iTv6IPZ5VJ6ivejmv38YJcRCQo4Bk742r5mSjfamtnlAULg3m5HGMB8U+owY39f6WMVb0b
        1pS4JKckO5+cvma/c7QPR8yQ8z30gBdbSVHME8MYCQR+cO+G1853ASCKJqjO69AoIc5qfn
        ZUFUu5xx9Sup0UTmjl6Pnm1h4DmSklI5ymlYQbBLpOOEQ4WjR3LT++w3kfOfeNJ60KM1UA
        Q8V25gbjIOj8MziacdZ0D2/yl3Se9FFa/x6/lTR7mBlaCjz6ZdCWpKBySBo/A4lk4+e8AR
        r0A6QTwhz/lts1oACqie3EZBrFgebCCFCkbODHPc/UgsOUSA/zKFmqo+rbZF0w==
Date:   Wed, 13 Sep 2023 17:37:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/5] mtd: rawnand: ingenic: use gpiod_set_active_high()
Message-ID: <20230913173724.60ed3b8d@xps-13>
In-Reply-To: <a3c8b1eaba0e7aae190cb5f2ffd8a360fab0251c.camel@crapouillou.net>
References: <20230913115001.23183-1-brgl@bgdev.pl>
        <20230913115001.23183-3-brgl@bgdev.pl>
        <a3c8b1eaba0e7aae190cb5f2ffd8a360fab0251c.camel@crapouillou.net>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

paul@crapouillou.net wrote on Wed, 13 Sep 2023 14:01:47 +0200:

> Hi,
>=20
> Le mercredi 13 septembre 2023 =C3=A0 13:49 +0200, Bartosz Golaszewski a
> =C3=A9crit=C2=A0:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >=20
> > Use the new, less cumbersome interface for setting the GPIO as
> > active-high that doesn't require first checking the current state.
> >=20
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org> =20
>=20
> Works for me.
>=20
> Acked-by: Paul Cercueil <paul@crapouillou.net>

For me as well, the new API looks much better.

I saw Hans is fine with you merging the platform/x86 patch. I am also
fine if all maintainers agree on that. In this case:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

However, if you finally need to produce an immutable tag, let me know
and I will take the patch through our tree.

Thanks,
Miqu=C3=A8l
