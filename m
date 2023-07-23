Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2875E1CA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjGWMZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGWMZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD9A10E2;
        Sun, 23 Jul 2023 05:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1AEB60C80;
        Sun, 23 Jul 2023 12:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A143C433C8;
        Sun, 23 Jul 2023 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690115101;
        bh=GeSyt9bVQvkrC8f9GHvYq7BY5dpo1ier66wPZrop2Ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=binkHBAlMGcXEoDFzyYi8cX7uTgEbQr5ADc/0Y6Nu0R2a8phbX66VhAbAI8rg3+6z
         iVEuJRBNUv7l+8JFC5LH3YnpsJfskSgQ774TbvcpZzVuLYqLBp+7pbPi/MtyPitV+W
         FdcmDMNSMP0W2Voi/i8/UdcxxEZATQrql0kzjKdRwTeyKoWTWqzogkUWmBG2U0HzCf
         uoOx028G3IGVyeGQ3AKw4UzouaJJCk0BJdw3xtz7WZhYSJLi+ScSu6qpsSkEQb39Cv
         Zan1rDPMsudiMocl3Zmuk5aFTtxvvHEGLGTz6UsFTk8+lEbD+0500H5ggOLz8CY91u
         Y3B8MCviK0kqg==
Date:   Sun, 23 Jul 2023 13:24:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Ramona Bolboaca <ramona.bolboaca@analog.com>, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: imu: adis16475.c: Add has_burst32 flag to
 adis16477 devices
Message-ID: <20230723132458.7c1f55de@jic23-huawei>
In-Reply-To: <810d290b629e2d40550a2b375229fe2e4dd58085.camel@gmail.com>
References: <20230719123152.309624-1-ramona.bolboaca@analog.com>
        <20230719123152.309624-3-ramona.bolboaca@analog.com>
        <810d290b629e2d40550a2b375229fe2e4dd58085.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 09:39:27 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2023-07-19 at 15:31 +0300, Ramona Bolboaca wrote:
> > adis16477 devices support burst32 function, thus has_burst32
> > flag should be set to true.
> >=20
> > Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> > --- =20
>=20
> Ups...
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/imu/adis16475.c | 3 +++
> > =C2=A01 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > index 243f0a91fdf9..17275a53ca2c 100644
> > --- a/drivers/iio/imu/adis16475.c
> > +++ b/drivers/iio/imu/adis16475.c
> > @@ -726,6 +726,7 @@ static const struct adis16475_chip_info
> > adis16475_chip_info[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.max_dec =3D 1999,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.sync =3D adis16475_sync_mode,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_sync =3D ARRAY_SIZE(adis16475_sync_mode),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.has_burst32 =3D true,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.adis_data =3D ADIS16475_DATA(16477, &adis16475_=
timeouts),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ADIS16477_2] =3D {
> > @@ -741,6 +742,7 @@ static const struct adis16475_chip_info
> > adis16475_chip_info[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.max_dec =3D 1999,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.sync =3D adis16475_sync_mode,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_sync =3D ARRAY_SIZE(adis16475_sync_mode),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.has_burst32 =3D true,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.adis_data =3D ADIS16475_DATA(16477, &adis16475_=
timeouts),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ADIS16477_3] =3D {
> > @@ -756,6 +758,7 @@ static const struct adis16475_chip_info
> > adis16475_chip_info[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.max_dec =3D 1999,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.sync =3D adis16475_sync_mode,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_sync =3D ARRAY_SIZE(adis16475_sync_mode),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.has_burst32 =3D true,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.adis_data =3D ADIS16475_DATA(16477, &adis16475_=
timeouts),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ADIS16465_1] =3D { =20
>=20

