Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECC766EED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbjG1N6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjG1N6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:58:34 -0400
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 06:58:32 PDT
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E82E78;
        Fri, 28 Jul 2023 06:58:32 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5f1d:0:640:49bf:0])
        by forward502a.mail.yandex.net (Yandex) with ESMTP id 1A7DF5E60E;
        Fri, 28 Jul 2023 16:53:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JrNbvTADeSw0-7PPWQYMX;
        Fri, 28 Jul 2023 16:53:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1690552400;
        bh=IGd1caYMnGQqPAgvXoIm8JMgIZ2GeGdFwnaOHTKLCpk=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=ZRh0MkarejUMzSy8oqhtMQoF75RrJV8Gq5MOOpq8/7pluKNwqJaMGuSUNnM71EGZy
         EQ8Bu2RyeQfz0PvG3T9FgDHgjyHR3GInMQLund6lzK6GbxA6HkIeG2Nu2+KVk5ZwPx
         tqOtou/6UPVPKkPx3qwzyOyQnWvltcWa/RSPKOlw=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <7788b12515f7e00b4bb0a04da30fc7fd0fdb8d51.camel@maquefel.me>
Subject: Re: [PATCH v3 14/42] power: reset: Add a driver for the ep93xx reset
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jul 2023 16:53:19 +0300
In-Reply-To: <ZLq0Z0QgBdCoDpV+@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
         <20230605-ep93xx-v3-14-3d63a5f1103e@maquefel.me>
         <ZLq0Z0QgBdCoDpV+@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-21 at 19:37 +0300, Andy Shevchenko wrote:
> On Thu, Jul 20, 2023 at 02:29:14PM +0300, Nikita Shubin via B4 Relay
> wrote:
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > Implement the reset behaviour of the various EP93xx SoCS in
> > drivers/power/reset.
> >=20
> > It used to be located in arch/arm/mach-ep93xx.
>=20
> ...
>=20
> > +// SPDX-License-Identifier: (GPL-2.0)
>=20
> Are you sure this is correct form?=C2=A0

Should it be // SPDX-License-Identifier: GPL-2.0+ ?

> Have you checked your patches?

Could you please be more specific:
$ scripts/checkpatch.pl -f drivers/power/reset/ep93xx-restart.c
total: 0 errors, 0 warnings, 86 lines checked

$ git format-patch -1 51f03c64b8fde79fb16b146d87769b7508b6d114 --stdout
| scripts/checkpatch.pl -
WARNING: please write a help paragraph that fully describes the config
symbol
...
WARNING: added, moved or deleted file(s), does MAINTAINERS need
updating?

I don't see any license complains...

checkpatch.pl is working as intented as:

$ scripts/checkpatch.pl -f drivers/power/reset/ep93xx-restart.c
WARNING: 'SPDX-License-Identifier: (FOOOO)' is not supported in
LICENSES/...
#1: FILE: drivers/power/reset/ep93xx-restart.c:1:
+// SPDX-License-Identifier: (FOOOO)

>=20
> ...
>=20
> > +#include <linux/of_device.h>
>=20
> Do you need this?
> Or maybe you need another (of*.h) one?
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Issue the reboot */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ep93xx_devcfg_set_clear(priv=
->map,
> > EP93XX_SYSCON_DEVCFG_SWRST, 0x00);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ep93xx_devcfg_set_clear(priv=
->map, 0x00,
> > EP93XX_SYSCON_DEVCFG_SWRST);
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mdelay(1000);
>=20
> Atomic?! Such a huge delay must be explained, esp. why it's atomic.

Indeed let's drop it entirely.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_emerg("Unable to restart =
system\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NOTIFY_DONE;
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D register_restart_han=
dler(&priv->restart_handler);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return dev_err_probe(dev, err, "can't register
> > restart notifier\n");
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return err;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>=20

