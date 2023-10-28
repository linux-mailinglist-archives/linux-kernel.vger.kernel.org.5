Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524537DA746
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjJ1Nds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1Ndq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:33:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2DC0;
        Sat, 28 Oct 2023 06:33:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B608C433C8;
        Sat, 28 Oct 2023 13:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698500024;
        bh=hLbfxuRpowB3R+I1UXL8u9WS/bWkX7DQHooMrGVVcXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iw8etJ7+NXu9Cqluj7e1KgtXkQS4V+iaC0HhlnNGyMEC69idLx1Lb4/3271MMWr+n
         Go8lsCiwQjZCg4OLqz1ZRcHydPHZvd7o/NOUvThVRBGK2Y030Tf50GizZMzb7TQONZ
         5g3EQMrP1yhxGaVS36TVNFjwT1qv8lVN3J5XZzCbqZc+EC4jviqLZ4V6XTRF0NsMdg
         Hi6EcL0DDIggOnhRcCNVOucK43Uv57pGRKTfFpGlNFea81h5fR4H7MzBEe3PFpAPrB
         kD+tASkPnPoO+O3KxqKGdpcvEBSTbmGkqADz4ryk7VzsPEHVyp1AfXmqK9sD/vxWgy
         iLMNjo4+YSelg==
Date:   Sat, 28 Oct 2023 14:33:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio/imu: inv_icm42600: Use max() helper macros
Message-ID: <20231028143230.1a6f3187@jic23-huawei>
In-Reply-To: <FR3P281MB1757C4183E5B536D463BAEBBCEDCA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20231027094410.3706-1-bragathemanick0908@gmail.com>
        <FR3P281MB1757C4183E5B536D463BAEBBCEDCA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 15:19:49 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
>=20
> thanks for the patch, looks good.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Interestingly b4 isn't finding this tag.  I'm too lazy to look into why but
seems your email didn't reach patchwork either.
Applied it by hand whilst applying the patch to the togreg branch of iio.git
which given timing will be rebase on rc1 once available.  For now I'll just
push it out as testing to give 0-day a head start.


Jonathan

>=20
> Thanks,
> JB
>=20
> From: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> Sent: Friday, October 27, 2023 11:44
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@kernel=
.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>
> Cc: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>; linux-iio@v=
ger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <l=
inux-kernel@vger.kernel.org>
> Subject: [PATCH v2] iio/imu: inv_icm42600: Use max() helper macros=20
> =C2=A0
> Use the standard max() helper macros instead of direct variable compariso=
n using if/else blocks or ternary operator. Change identified using minmax.=
=E2=80=8Acocci Coccinelle semantic patch. Signed-off-by: Bragatheswaran Man=
ickavel <bragathemanick0908@=E2=80=8Agmail.=E2=80=8Acom>=20
> ZjQcmQRYFpfptBannerStart
> This Message Is From an Untrusted Sender=20
> You have not previously corresponded with this sender.=20
> =C2=A0
> ZjQcmQRYFpfptBannerEnd
> Use the standard max() helper macros instead of direct
> variable comparison using if/else blocks or ternary
> operator. Change identified using minmax.cocci
> Coccinelle semantic patch.
>=20
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
> V1 -> V2: Adding similar changes to inv_icm42600_gyro & inv_icm42600_buff=
er
>=20
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 5 +----
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 5 +----
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 5 +----
>  3 files changed, 3 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c
> index b1e4fde27d25..f67bd5a39beb 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -137,10 +137,7 @@ static int inv_icm42600_accel_update_scan_mode(struc=
t iio_dev *indio_dev,
>  out_unlock:
>  	mutex_unlock(&st->lock);
>  	/* sleep maximum required time */
> -	if (sleep_accel > sleep_temp)
> -		sleep =3D sleep_accel;
> -	else
> -		sleep =3D sleep_temp;
> +	sleep =3D max(sleep_accel, sleep_temp);
>  	if (sleep)
>  		msleep(sleep);
>  	return ret;
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 6ef1df9d60b7..b52f328fd26c 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -424,10 +424,7 @@ static int inv_icm42600_buffer_postdisable(struct ii=
o_dev *indio_dev)
>  	mutex_unlock(&st->lock);
> =20
>  	/* sleep maximum required time */
> -	if (sleep_sensor > sleep_temp)
> -		sleep =3D sleep_sensor;
> -	else
> -		sleep =3D sleep_temp;
> +	sleep =3D max(sleep_sensor, sleep_temp);
>  	if (sleep)
>  		msleep(sleep);
> =20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_gyro.c
> index 3bf946e56e1d..3df0a715e885 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> @@ -137,10 +137,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct=
 iio_dev *indio_dev,
>  out_unlock:
>  	mutex_unlock(&st->lock);
>  	/* sleep maximum required time */
> -	if (sleep_gyro > sleep_temp)
> -		sleep =3D sleep_gyro;
> -	else
> -		sleep =3D sleep_temp;
> +	sleep =3D max(sleep_gyro, sleep_temp);
>  	if (sleep)
>  		msleep(sleep);
>  	return ret;

