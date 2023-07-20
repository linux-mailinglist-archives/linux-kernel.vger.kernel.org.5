Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1975B702
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGTSkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGTSkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40F6E47;
        Thu, 20 Jul 2023 11:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8262761BF4;
        Thu, 20 Jul 2023 18:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC743C433C8;
        Thu, 20 Jul 2023 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689878443;
        bh=/6QVSsokpaGbIcdE+fnOF8ooj6sFvlYDvCCv/ARgiaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M8YYd1c7o/smKB+jB6xBAaGqznaTmS9Rk5tLTQ1CAl7bugQjl4uRS68piCN4Ky7U5
         8m++dC5hgyXy9BptO1MomkB4pYdxabKs2NejU6HKE90Rtf8N8YCgsqfU3RFirA9AWD
         uvqgKz////cjm9Yho6FegesxoI88+65C/tMFDaoUwgPLvQbmX7z3CeNPcgunZQzXm2
         g/cUmPJHod5yYUpBgegjyS0T+F7Ai6R+DcWy9NBvQ1q5NokB6rOL/hek9/VJqYn+cA
         eaMyLCbLod2YCLgKzlsbCeMrGxcIJlla2Arudxg9V7QUzozd+/7gLGMri67Zpy++FG
         a1RcwC1m4BLog==
Date:   Thu, 20 Jul 2023 19:40:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: lsm6dsx: Fix mount matrix retrieval
Message-ID: <20230720194037.60d109d7@jic23-huawei>
In-Reply-To: <3017278.mvXUDI8C0e@alexpc>
References: <20230714153132.27265-1-atafalla@dnyon.com>
        <20230715183515.56deaa1d@jic23-huawei>
        <3017278.mvXUDI8C0e@alexpc>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 17 Jul 2023 23:17:10 +0200
Alejandro Tafalla <atafalla@dnyon.com> wrote:

> On s=C3=A1bado, 15 de julio de 2023 19:35:15 (CEST) Jonathan Cameron wrot=
e:
> > On Fri, 14 Jul 2023 17:31:26 +0200
> >=20
> > Alejandro Tafalla <atafalla@dnyon.com> wrote: =20
> > > The function lsm6dsx_get_acpi_mount_matrix should return an error when
> > > ACPI
> > > support is not enabled to allow executing iio_read_mount_matrix in the
> > > probe function.
> > >=20
> > > Fixes: dc3d25f22b88 ("iio: imu: lsm6dsx: Add ACPI mount matrix retrie=
val") =20
> >=20
> > I can fix it up whilst applying if no other issues, but there must not =
be
> > a blank line here.  All tags need to be in a single block for some tool=
ing
> > that is used with the kernel tree (and some of the checking scripts warn
> > about this so it won't get applied with the blank line here). =20
>=20
> Okay, i'll keep it in mind for new patches. Thank you.
Np.

Just waiting for Lorenzo to have time to take a final look.

Jonathan

> >  =20
> > > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > > ---
> > > Changes in v3:
> > > - Removed unneeded check for err =3D=3D -EOPNOTSUPP.
> > >=20
> > > Changes in v2:
> > > - Use of error codes instead of true/false
> > >=20
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c index
> > > 6a18b363cf73..b6e6b1df8a61 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -2687,7 +2687,7 @@ static int lsm6dsx_get_acpi_mount_matrix(struct
> > > device *dev,>=20
> > >  static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
> > > =20
> > >  					  struct  =20
> iio_mount_matrix *orientation)
> > > =20
> > >  {
> > >=20
> > > -	return false;
> > > +	return -EOPNOTSUPP;
> > >=20
> > >  }
> > > =20
> > >  #endif =20
>=20
>=20
>=20
>=20

