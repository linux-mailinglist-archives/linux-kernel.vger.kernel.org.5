Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379727668E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjG1JbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjG1Jas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:30:48 -0400
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3439549D1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:28:12 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2c95:0:640:f90:0])
        by forward502a.mail.yandex.net (Yandex) with ESMTP id 327C35E87E;
        Fri, 28 Jul 2023 12:28:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5SJNGQ8sICg0-6lgZZUIK;
        Fri, 28 Jul 2023 12:28:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1690536485;
        bh=zLwg7eZhmWTGwEH6CIMSDLok9Zn1jv1W2z4DpzPhfSQ=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=mg+tbqYgEcULYwLoDOtwreGoTnktQs+q8B/CrY1lrkL+nsvh4P/yNgz9FPx2CrgBX
         X63UheFFXgUS1hfEPkRThRbY1H2KSbgjn3QnYZn5GtGtTiVPmBNtIWmk925upPt9vF
         mhHV3NcjnVRDSx5DlrBheWDWFgVigCJHGBgMdu+c=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <79619e92b70fdb4b324758ddb34f84b3b8963256.camel@maquefel.me>
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jul 2023 12:28:05 +0300
In-Reply-To: <ZLqSo6B5cJXVRJS/@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
         <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
         <ZLqSo6B5cJXVRJS/@smile.fi.intel.com>
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

Hello Andy!

On Fri, 2023-07-21 at 17:13 +0300, Andy Shevchenko wrote:
> On Thu, Jul 20, 2023 at 02:29:07PM +0300, Nikita Shubin via B4 Relay
> wrote:
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_irqsave(&ep93xx_sw=
lock, flags);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_read(map, EP93XX_SYSC=
ON_DEVCFG, &val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val &=3D ~clear_bits;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val |=3D set_bits;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_write(map, EP93XX_SYS=
CON_SWLOCK,
> > EP93XX_SWLOCK_MAGICK);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_write(map, EP93XX_SYS=
CON_DEVCFG, val);
>=20
> Is this sequence a must?
> I.o.w. can you first supply magic and then update devcfg?
>=20

Unfortunately it is a must to write EP93XX_SYSCON_SWLOCK and only then
the next write to swlocked registers will succeed.

