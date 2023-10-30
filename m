Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF347DB7D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjJ3KUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjJ3KTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:19:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF544AE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:14:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3313CC433BA;
        Mon, 30 Oct 2023 10:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698660841;
        bh=/PZ0DPuK2+dRsvqqflmCZcgi0jdZthU0+owMGrtV4cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dI795qS1D0EIxs3JKE8SCw58aJkHo97jOjXG+D2oG4MkkuaKjYhERfaJIeD8aahxp
         tVY7IYdfe2q7DSQRYpGtTEC/vGS10Wy+3C+GGkijUEgQvnptLd1I9xdVp4A2mkmCXP
         VpV3d3s1iFlzXfFO5pT9zrx13nAb2b4DVqR85DhcOunG10BcoVO9SCnlTl1q5hJTpF
         sGxvotAhIdsqKTzcC0j2BMcToRrQ8XW0NKic20oewLoAQWxheoKHAd3vS5CmIGPbVY
         M9cdgXJvWB7AJVTa0G7B3t32doouJMR7bm0rUT/FaxipDKDqi4ilDnzroKp1ZlH93Z
         X5ilr+kp7l+rg==
Date:   Mon, 30 Oct 2023 11:13:58 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/8] drm/loongson: Introduce a drm bridge driver for
 it66121 HDMI transmitter
Message-ID: <jcdzlawpmlllfzvn6rcninhlh3ltc6hew6s6gfzzc4dnjpu4ul@ohjrl4cleyfp>
References: <20231029194607.379459-1-suijingfeng@loongson.cn>
 <20231029194607.379459-3-suijingfeng@loongson.cn>
 <CAA8EJprjQXcTgxnC1POaBjVBzyVBvKpmKyJcCR5ExRUhVxtYoQ@mail.gmail.com>
 <3ccb9600-6990-4ec7-81de-0d7b4e1294eb@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4esgxz7yzjhi7nzs"
Content-Disposition: inline
In-Reply-To: <3ccb9600-6990-4ec7-81de-0d7b4e1294eb@loongson.cn>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4esgxz7yzjhi7nzs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 30, 2023 at 05:42:28PM +0800, Sui Jingfeng wrote:
> On 2023/10/30 06:53, Dmitry Baryshkov wrote:
> > On Sun, 29 Oct 2023 at 21:46, Sui Jingfeng <suijingfeng@loongson.cn> wr=
ote:
> > > The IT66121 is a DVO to HDMI converter, LS3A5000+LS7A1000 ML5A_MB use=
 this
> > > chip to support HDMI output. Thus add a drm bridge based driver for i=
t.
> > > This patch is developed with drivers/gpu/drm/bridge/ite-it66121.c as =
base.
> > Please use the original bridge driver instead of adding a new one.

FTR I agree with Dmitry here, duplicating drivers because it's easier is
a show-stopper

> I'm agree with the spirit of code sharing, but this is nearly
> impossible for non-DT system.
>=20
> Because the original bridge driver(say it66121.ko) is fully dependent
> on the DT. UEFI+ACPI based system can not use with it.
>
> Our I2C adapter is created by the drm/loongson.ko on the runtime.
> The potential problem is that *cyclic dependency* !
>=20
> I2C adapter driver is depend on drm/loongson
> drm/loongson depend on drm bridge driver (say it66121.ko)
> drm bridge driver (say it66121.ko) depend on I2C adapter to setup.
>
> This plus the defer probe mechanism is totally a trap,
> incurring troubles and don't work.

I'm sure all those issues can be fixed :)

Maxime

--4esgxz7yzjhi7nzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZT+B5gAKCRDj7w1vZxhR
xUu+AQDibs4qYnlNpi+9fWtEDzq0jcK1A42LnQIh+N0JBcu0FwD+PtS1h/A0YLqC
lI4n/tM1VS1hmoORSLbIFj6d0loRaw4=
=n3AP
-----END PGP SIGNATURE-----

--4esgxz7yzjhi7nzs--
