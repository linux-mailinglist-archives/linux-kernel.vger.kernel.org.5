Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE4792AB4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjIEQlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354706AbjIENlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46042191;
        Tue,  5 Sep 2023 06:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5C74603F3;
        Tue,  5 Sep 2023 13:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA8CC433C8;
        Tue,  5 Sep 2023 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693921261;
        bh=Uvy2CPc4Wf3EmKiapYddhGQwSCoeFK0JXoU7RKfJDbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ef6ARLaLyVlsExJtD1u2IbeHQs6i4Qmn1d6d4745bnC2cgBTDU77MMyGSLuYGGE1E
         MjPEYpDRVERFuNQhaL+wC8ezxuL7/sJN0vb4GfMjhbkmc8xPwj+fW21w1YoFAuEifK
         VTtJj/jB2uLOPHjbjlGhcbKPORnltb/iJdZmK5vOEM20RTpypJhQX3+6QoLFwhIJ7x
         2Qb4me9mbLj5AMipUT4r2RFXVzAgkJGgUyViGL57o+vffnujqL6ahaBYODqL6ZAPGM
         9seyX7aNIqggY6azgVSjIxJsqc5N/6OIdTCIk30jPoCFHnFfr4tjAELSBKshMHeCx8
         91LqBPdWW8GJw==
Date:   Tue, 5 Sep 2023 15:40:57 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Vignesh Raman <vignesh.raman@collabora.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/7] drm: ci: Force db410c to host mode
Message-ID: <6uusq7jlofbztz34yksxbr6vgqq35a3x7ibuqm62dyrpzve4g5@boaladlcrjnv>
References: <20230904161516.66751-1-vignesh.raman@collabora.com>
 <20230904161516.66751-3-vignesh.raman@collabora.com>
 <CAA8EJpq_cmFQ6TGy1xELh3ButWKLfSkQcp5ix049s_iqKw6DvQ@mail.gmail.com>
 <ueznsu2dlvq5zp3ls262fww54bnlqa3e2ssr6f65vrrionloms@ir2ywgeajj4w>
 <2c812fe4-04ba-0243-5330-c7b7e695cff9@collabora.com>
 <2jz6wurh6ejbaejwtb5r5gukjuw4zs7ujk5hbwfpsn26o6esqe@g2nnb2gjpnjp>
 <CAA8EJpoGoopP64T1nm1ye1ukTwT=u+LYY1ubQG-9dQ-j41iHiA@mail.gmail.com>
 <6be5f5d8-8940-c79b-4a01-3f3d73641e4e@collabora.com>
 <ktikqf5hu2dmqb4p7dvrqv2tjm565qn3qu2gggrvncfu47l23j@o6t2rnpbya3x>
 <427ceb32-054f-41ff-df95-446b18aa178f@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zzvnm44fyzbgrw5r"
Content-Disposition: inline
In-Reply-To: <427ceb32-054f-41ff-df95-446b18aa178f@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zzvnm44fyzbgrw5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 07:06:43PM +0530, Vignesh Raman wrote:
> Hi Maxime,
>=20
> On 05/09/23 17:27, Maxime Ripard wrote:
> > On Tue, Sep 05, 2023 at 05:11:43PM +0530, Vignesh Raman wrote:
> > > > > Also, that node actually has a label ("usb"), defined here:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/arch/arm64/boot/dts/qcom/msm8916.dtsi#n2322
> > > > >=20
> > > > > So you can end up with
> > > > >=20
> > > > > &usb {
> > > > >           dr_mode =3D "host";
> > > > > };
> > > >=20
> > > > ... which is the simplest and thus more robust one.
> > > >=20
> > >=20
> > > Should it be,
> > > &{/soc@0/usb} {
> > > 	dr_mode =3D "host";
> > > };
> >=20
> > No. The &{/...} syntax refers to a path. &... refers to a label. They
> > are not equivalent.
>=20
> Sorry I was not clear before.
>=20
> With,
> &usb {
> 	dr_mode =3D "host";
> };
>=20
> The target is <0xffffffff> and fdtoverlay fails to apply the dtbo.

You do have /plugin/ and have compiled the base device tree with overlay
support, right?

> With,
> &{/soc@0/usb} {
>          dr_mode =3D "host";
> };
>=20
> The target-path is "/soc@0/usb" (usb: usb@78d9000)

Right, and that's not the path you want to modify. The path you want to
modify is /soc@0/usb@78d9000. usb is the label, it's absolute, and you
can't mix and match a path ("/soc@0/") and a label ("usb")

Maxime

--zzvnm44fyzbgrw5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZPcv6QAKCRDj7w1vZxhR
xfUfAPsGADRw4k1O20bltzgYsVzleJ+qXoptLhYG6tJKe0W2dgD7B15nLB6bDOQA
W+FAFDt2PF7aelZR4Wdn21phYMb4LAI=
=BmTo
-----END PGP SIGNATURE-----

--zzvnm44fyzbgrw5r--
