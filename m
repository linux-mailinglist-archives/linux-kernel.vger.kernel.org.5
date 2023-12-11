Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679ED80C401
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjLKJLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKJKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:10:51 -0500
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE9BF1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:10:57 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2e14:0:640:2cd1:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id BA67660B25;
        Mon, 11 Dec 2023 12:10:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pAddjN8Caa60-KabXMH28;
        Mon, 11 Dec 2023 12:10:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
        t=1702285852; bh=UKtwdG87cbMckGwyNHeE1b5Vb5hNiKX74obiGUxAGKg=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=K97AbeapFDKuCtOee6amDMu8ldcf1mWMhdW2PujdAsJoL+9o2MZyTuY/7IDMsqjtw
         QkEKLt+s2RMGhpDdgZyeAfvVlikeRXavIin32CqkoKmoDlmEoPXKOWxVkR9X/2ZKm0
         CiCY0mtu7tPsvVcfT/s4miaxYBgyB4ZCi1JtZvD0=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <1bbcd4e612a1577d83456a5c88ad633547e59e9b.camel@maquefel.me>
Subject: Re: [PATCH v5 39/39] dma: cirrus: remove platform code
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Mon, 11 Dec 2023 15:10:51 +0300
In-Reply-To: <ZV30llA4yDUs2G-Z@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
         <20231122-ep93xx-v5-39-d59a76d5df29@maquefel.me>
         <ZV30llA4yDUs2G-Z@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy!

On Wed, 2023-11-22 at 14:31 +0200, Andy Shevchenko wrote:
> On Wed, Nov 22, 2023 at 12:00:17PM +0300, Nikita Shubin wrote:
> > Remove DMA platform header, from now on we use device tree for dma
>=20
> DMA
>=20
> > clients.
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (device_is_compatible(cha=
n->device->dev, "cirrus,ep9301-
> > dma-m2p"))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return true;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return !strcmp(dev_name(chan=
->device->dev), "ep93xx-dma-
> > m2p");
>=20
> Haven't you introduced an inliner with the similar flow? Why not
> reuse it?

It's the same, i moved it from platform header file into driver itself,
as i am removing "include/linux/platform_data/dma-ep93xx.h" completely.

>=20
> ...
>=20
> > +/**
> > + * ep93xx_dma_chan_direction - returns direction the channel can
> > be used
> > + * @chan: channel
> > + *
> > + * This function can be used in filter functions to find out
> > whether the
> > + * channel supports given DMA direction. Only M2P channels have
> > such
> > + * limitation, for M2M channels the direction is configurable.
>=20
> I believe
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scripts/kernel-doc -v -no=
ne -Wall ...
>=20
> against this file (and maybe others!) will complain ("no return
> section"
> or alike).
>=20
> > + */
>=20

Agree, dropped doc style comment and converted it to simple comment, it
is internal to driver now, so no point putting it into docs.
