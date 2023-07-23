Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2527675E1C6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGWMX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWMX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A8210DE;
        Sun, 23 Jul 2023 05:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A110A60CE8;
        Sun, 23 Jul 2023 12:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D518EC433C8;
        Sun, 23 Jul 2023 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690115036;
        bh=n2B5v/EKugu7gGDDnqUY4oAhQIGlqWIjnLxLDiTyc0Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NBAxto0RysOauiMyrhhxWXE1F1xj12H1bkwWdo9dGXDQfT13w/0eu3hVwGYlAOedX
         P73DH+R5diBaH24g6R7XKDIfba9299+qeH34xxDNEdNHf/KOlqGEpe6Qwu7CeKQnuk
         V3ahaYyLpVYMwod80N4LSglPg1IXgnyIFkwwKt48dyWAiyPHpPKTQ/ZhdIJ8ztj0Pr
         q8bjgzcCmfgFWqvPFGlcmJb3p3a9qKNUJlSvk43uYlhtXN4A0b3Ac8Mu7mvWfi6Cy1
         N3NaNsbsxvfjuOg9r+850Xd+9uFafbE1dp7aWwpqfyJ9zFIhV+P6NdxK/XV47tLxzb
         Tot0iBJSdejaw==
Date:   Sun, 23 Jul 2023 13:23:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Ramona Bolboaca <ramona.bolboaca@analog.com>, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: imu: adis16475.c: Remove unused enum
 elements
Message-ID: <20230723132352.0d7eb229@jic23-huawei>
In-Reply-To: <e2fa1ebc820745065e91bac875f287167a0cfef9.camel@gmail.com>
References: <20230719123152.309624-1-ramona.bolboaca@analog.com>
        <20230719123152.309624-2-ramona.bolboaca@analog.com>
        <e2fa1ebc820745065e91bac875f287167a0cfef9.camel@gmail.com>
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

On Thu, 20 Jul 2023 09:38:50 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2023-07-19 at 15:31 +0300, Ramona Bolboaca wrote:
> > Remove unused enum elements ADIS16475_SCAN_DIAG_S_FLAGS and
> > ADIS16475_SCAN_CRC_FAILURE.
> >=20
> > Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at it.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/imu/adis16475.c | 2 --
> > =C2=A01 file changed, 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > index 3abffb01ba31..243f0a91fdf9 100644
> > --- a/drivers/iio/imu/adis16475.c
> > +++ b/drivers/iio/imu/adis16475.c
> > @@ -115,8 +115,6 @@ enum {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_SCAN_ACCEL_Y,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_SCAN_ACCEL_Z,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_SCAN_TEMP,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_SCAN_DIAG_S_FLAGS,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_SCAN_CRC_FAILURE,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static bool low_rate_allow; =20
>=20

