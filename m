Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DF180BA57
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjLJLUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJLUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:20:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5599E5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:20:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A2EC433C8;
        Sun, 10 Dec 2023 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702207243;
        bh=OOh3EDNf5zwe5BLuj3S2jqpHweINStKCQ1+6FlVjk60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FuHakKtjM8RGMAvLs5lso7QjoJignx8IGhTO8UqZwqoDUkleUTHP2go5jsvEVeEHH
         Vf1OnWewQbZyp8ikwSyMPu3ZW0ESax87B8hBcZhmrbohaNHAJKA5vwVUoCZlNb5pnT
         3SiIIXGbFp9iPT08an3vdUCpmY1zd2tcaLgoQnCtAYAnM06sJHqL8CLHxgnJkE4fGr
         JAvGF+d+anIxfD0fRAuol6Rh8zq7L/maT27i3mqy70SdSB1MVHaUA4GSsNqadjxVcP
         rfBi/cJZNxdmTQskc8ys1B5pDbWKlMs/7eGof7LABVdr7HOTEQYm9+zDDQbSlKJOc8
         gwYisPcTO+Kpg==
Date:   Sun, 10 Dec 2023 11:20:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     Hiten Chauhan <hiten.chauhan@siliconsignals.io>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600
Message-ID: <20231210112038.6c4613d3@jic23-huawei>
In-Reply-To: <FR3P281MB1757AC113CAD4072B85BB695CE8AA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20231117151446.49738-1-hiten.chauhan@siliconsignals.io>
        <FR3P281MB17576C325FD416F14DCE4B7FCEB4A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
        <MAXPR01MB4118176054665C88E3C6FAE7EABFA@MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM>
        <FR3P281MB1757E3C062BA1D363B6D7E80CEBDA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
        <MAXPR01MB41180BBF8B6743966FB0B135EA8AA@MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM>
        <FR3P281MB1757AC113CAD4072B85BB695CE8AA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Fri, 8 Dec 2023 15:37:32 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hi Hiten,
>=20
> you can define property that are shared between channels by defining them=
 inside info_mask_shared_by_type or info_mask_shared_by_all filed. As done =
for scale or for sampling_frequency.
>=20
> Thanks,
> JB
>=20
>=20
> From: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
> Sent: Friday, December 8, 2023 15:14
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@kernel=
.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.=
kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux=
-kernel@vger.kernel.org>
> Cc: kernel test robot <lkp@intel.com>
> Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600=20
> =C2=A0
> Hi Jean,
>=20
> As per your suggestions (thanks for this), I have looked into creating ch=
annels instead of custom sysfs entries.
>=20
> I have looked into an example of "mma9551.c".
>=20
> Now, by comparing the datasheet of mma9551 and inv_icm42600, in mma9551 t=
hey provide X, Y, and Z tilt interrupt registers.
> But in the case of inv_icm42600, there is only one register to receive in=
terrupt for tilt.

Just to check.  Can you tell which axis the tilt event was on, or is it sim=
ply 'tilted somehow?' From a look
at the datasheet its 'tilted by 35 degrees in some direction'
There are a couple of ways we can report this case if that's what you have.=
  There is a modifier for
X_OR_Y_OR_Z and we have several users already.  With hindsight that's a bad=
 design option and we should have
just reported it on each axis but there is precedence for doing it with thi=
s modifier so we are stuck with that.
Maybe we should consider adding an explicit X_OR_Y_OR_Z Channel that just h=
as events. The risk is that
existing userspace software won't expect that so might not know what to do.

For event controls, it's fine if one control affects multiple events.  So e=
nabling tilt_x may well enable tilt_y
and tilt_z as well.  User space is meant to cope with getting events it did=
n't explicitly request.

Jonathan

>=20
> It appears hardware limitation in our case, so can you please suggest her=
e how we can overcome=C2=A0this?
>=20
> Appreciate your feedback.
>=20
> --
> Thanks and Regards,
> Hiten Chauhan
>=20
>=20
>=20
> From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Sent: Monday, November 27, 2023 4:08 PM
> To: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; jic23@kernel.org <ji=
c23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.o=
rg <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@=
vger.kernel.org>
> Cc: kernel test robot <lkp@intel.com>
> Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600=20
> =C2=A0
> Hello Hiten,
>=20
> this is more complex than that.
>=20
> First, you need to use pm_runtime functions to handle chip on/off state (=
you can have a look inside inv_icm42600_accel.c for direct reg access how i=
t is done).
>=20
> You cannot directly write inside PWR_MGMT0 register, otherwise you are ov=
erwriting sensor states. For example with your code, if the chip buffer is =
running with accel and gyro on, when turning the tilt on it will power off =
gyro and move accel in low-power mode. We really don't want that.
>=20
> We need to track the existing power states, and only do the required chan=
ges. For that, you can use inv_icm42600_set_accel_conf() for turning accel =
on. But you will have to add support and handle correctly the INV_ICM42600_=
SENSOR_MODE_LOW_POWER sensor mode and the associated filtering (INV_ICM4260=
0_FILTER_AVG_1X can be sufficient for tilt).
>=20
> This is the multiplexing I was speaking off. That's more complex than it =
first seems. If power is not very important for you, you can simplify thing=
s by just setting the accel to low-noise mode when turning it on with inv_i=
cm42600_set_accel_conf().
>=20
> For testing your tilt implementation, you need to turn it on/off while da=
ta buffer is off and while data buffer is on, and check that it doesn't imp=
act the data flow (accel and gyro have to stay turned on in low-noise mode).
>=20
> Thanks.
>=20
> Best regards,
> JB
>=20
> From: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
> Sent: Saturday, November 25, 2023 08:05
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@kernel=
.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.=
kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux=
-kernel@vger.kernel.org>
> Cc: kernel test robot <lkp@intel.com>
> Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600=20
> =C2=A0
> Hello Jean, Thanks for your support, For the first issue can I use "struc=
t iio_event_spec" for tilt interrupt instead of a custom sysfs file? In the=
 second issue I have just disabled tilt related register so when I turn til=
t off other=20
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender=20
> This message came from outside your organization.=20
> =C2=A0
> ZjQcmQRYFpfptBannerEnd
> Hello Jean,
>=20
> Thanks for your support,
>=20
> For the first issue can I use "struct iio_event_spec" for tilt interrupt =
instead of a custom sysfs file?
>=20
> In the second issue I have just disabled tilt related register so when I =
turn tilt off other functionality on the accelerometer will work fine. can =
you please cross-check?
>=20
> Thanks & Regards,
> Hiten Chauhan
>=20
> From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Sent: Monday, November 20, 2023 7:48 PM
> To: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; jic23@kernel.org <ji=
c23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.o=
rg <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@=
vger.kernel.org>
> Cc: kernel test robot <lkp@intel.com>
> Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600=20
> =C2=A0
> Hello Hiten,
>=20
> thanks for your patch.
>=20
> I see first a big issue at the root. Tilt event is something that should =
be reported as an IIO event, not in a custom sysfs file. Jonathan can confi=
rm this, but this is my understanding.
>=20
> Second issue, there is no multiplexing between the tilt and normal data s=
ampling. Meaning turning tilt off will stop the data output of the chip if =
it was on. And turning data output off will stop tilt functionnality. All t=
hese things have to be multiplexed together and chip power off/on must be c=
entralized.
>=20
> Thanks for your work.
>=20
> Best regards,
> JB
>=20
> From: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
> Sent: Friday, November 17, 2023 16:14
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@kernel=
.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.=
kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux=
-kernel@vger.kernel.org>
> Cc: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; kernel test robot <l=
kp@intel.com>
> Subject: [PATCH v3] Added tilt interrupt support in inv_icm42600=20
> =C2=A0
> Description: Add new device attribute to enable and disable Tilt interrup=
t from kernel user space Signed-off-by: Hiten Chauhan <hiten.=E2=80=8Achauh=
an@=E2=80=8Asiliconsignals.=E2=80=8Aio> Reported-by: kernel test robot <lkp=
@=E2=80=8Aintel.=E2=80=8Acom> Closes: [[https:=E2=80=8A//urldefense.=E2=80=
=8Acom/v3/__https:=E2=80=8A//lore.=E2=80=8Akernel.=E2=80=8Aorg/oe-kbuild-al=
l/202311170235.=E2=80=8AHaVJnmWa-lkp@=E2=80=8Aintel.=E2=80=8Acom/__;!!Ftrht=
PsWDhZ6tw!Abqqh_UwyEydZ0xeIy7YQwPWb_knCM2hsJJWavoAq3igeGccV4RZI87CTV__lZgfB=
jZytNesx5cUc_RXsP6mu9lmvUGZg_rGWg$[lore[.=E2=80=8A]kernel[.=E2=80=8A]org]]h=
ttps:=E2=80=8A//urldefense.=E2=80=8Acom/v3/__https:=E2=80=8A//lore.=E2=80=
=8Akernel.=E2=80=8Aorg/oe-kbuild-all/202311170235.=E2=80=8AHaVJnmWa-lkp@=E2=
=80=8Aintel.=E2=80=8Acom/__;!!FtrhtPsWDhZ6tw!Abqqh_UwyEydZ0xeIy7YQwPWb_knCM=
2hsJJWavoAq3igeGccV4RZI87CTV__lZgfBjZytNesx5cUc_RXsP6mu9lmvUGZg_rGWg$[lore[=
.=E2=80=8A]kernel[.=E2=80=8A]org]https:=E2=80=8A//urldefense.=E2=80=8Acom/v=
3/__https:=E2=80=8A//lore.=E2=80=8Akernel.=E2=80=8Aorg/oe-kbuild-all/202311=
170235.=E2=80=8AHaVJnmWa-lkp@=E2=80=8Aintel.=E2=80=8Acom/__;!!FtrhtPsWDhZ6t=
w!Abqqh_UwyEydZ0xeIy7YQwPWb_knCM2hsJJWavoAq3igeGccV4RZI87CTV__lZgfBjZytNesx=
5cUc_RXsP6mu9lmvUGZg_rGWg$[lore[.=E2=80=8A]kernel[.=E2=80=8A]org]]https:=E2=
=80=8A//urldefense.=E2=80=8Acom/v3/__https:=E2=80=8A//lore.=E2=80=8Akernel.=
=E2=80=8Aorg/oe-kbuild-all/202311170235.=E2=80=8AHaVJnmWa-lkp@=E2=80=8Ainte=
l.=E2=80=8Acom/__;!!FtrhtPsWDhZ6tw!Abqqh_UwyEydZ0xeIy7YQwPWb_knCM2hsJJWavoA=
q3igeGccV4RZI87CTV__lZgfBjZytNesx5cUc_RXsP6mu9lmvUGZg_rGWg$[lore[.=E2=80=8A=
]kernel[.=E2=80=8A]org]=20
> ZjQcmQRYFpfptBannerStart
> This Message Is From an Untrusted Sender=20
> You have not previously corresponded with this sender.=20
> =C2=A0
> ZjQcmQRYFpfptBannerEnd
> Description:
> Add new device attribute to enable and disable
> Tilt interrupt from kernel user space
>=20
> Signed-off-by: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all=
/202311170235.HaVJnmWa-lkp@intel.com/__;!!FtrhtPsWDhZ6tw!Abqqh_UwyEydZ0xeIy=
7YQwPWb_knCM2hsJJWavoAq3igeGccV4RZI87CTV__lZgfBjZytNesx5cUc_RXsP6mu9lmvUGZg=
_rGWg$[lore[.]kernel[.]org]
> ---
> =C2=A0drivers/iio/imu/inv_icm42600/inv_icm42600.h=C2=A0=C2=A0 |=C2=A0 24 =
++++
> =C2=A0.../iio/imu/inv_icm42600/inv_icm42600_accel.c | 129 +++++++++++++++=
+++
> =C2=A02 files changed, 153 insertions(+)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h
> index 0e290c807b0f..39ed39e77deb 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -187,6 +187,8 @@ struct inv_icm42600_state {
> =C2=A0#define INV_ICM42600_FIFO_CONFIG_STOP_ON_FULL=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(INV_ICM42600_FIFO_CONFIG_MASK, 2)
> =C2=A0
> +#define INV_ICM42600_REG_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
GENMASK(7, 0)
> +
> =C2=A0/* all sensor data are 16 bits (2 registers wide) in big-endian */
> =C2=A0#define INV_ICM42600_REG_TEMP_DATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x001D
> =C2=A0#define INV_ICM42600_REG_ACCEL_DATA_X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x001F
> @@ -239,6 +241,7 @@ struct inv_icm42600_state {
> =C2=A0#define INV_ICM42600_REG_PWR_MGMT0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x004E
> =C2=A0#define INV_ICM42600_PWR_MGMT0_TEMP_DIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(5)
> =C2=A0#define INV_ICM42600_PWR_MGMT0_IDLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BIT(4)
> +#define INV_ICM42600_PWR_ACCEL_MODE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(1)
> =C2=A0#define INV_ICM42600_PWR_MGMT0_GYRO(_mode)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(GENMASK(3, 2), (_mode))
> =C2=A0#define INV_ICM42600_PWR_MGMT0_ACCEL(_mode)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> @@ -306,6 +309,21 @@ struct inv_icm42600_state {
> =C2=A0#define INV_ICM42600_WHOAMI_ICM42622=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x46
> =C2=A0#define INV_ICM42600_WHOAMI_ICM42631=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x5C
> =C2=A0
> +/* Register configs for tilt interrupt */
> +#define INV_ICM42605_REG_APEX_CONFIG4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x4043
> +#define INV_ICM42605_APEX_CONFIG4_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK(7, =
0)
> +
> +#define INV_ICM42605_REG_APEX_CONFIG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0056
> +#define INV_ICM42605_APEX_CONFIG0_TILT_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(4)
> +#define INV_ICM42605_APEX_CONFIG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BIT(1)
> +
> +#define INV_ICM42605_REG_INTF_CONFIG1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x404D
> +#define INV_ICM42605_INTF_CONFIG1_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMA=
SK(5, 0)
> +#define INV_ICM42605_INTF_CONFIG1_TILT_DET_INT1_EN=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 BIT(3)
> +
> +#define INV_ICM42605_REG_INT_STATUS3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0038
> +
> +
> =C2=A0/* User bank 1 (MSB 0x10) */
> =C2=A0#define INV_ICM42600_REG_SENSOR_CONFIG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1003
> =C2=A0#define INV_ICM42600_SENSOR_CONFIG0_ZG_DISABLE=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(5)
> @@ -364,6 +382,8 @@ typedef int (*inv_icm42600_bus_setup)(struct inv_icm4=
2600_state *);
> =C2=A0extern const struct regmap_config inv_icm42600_regmap_config;
> =C2=A0extern const struct dev_pm_ops inv_icm42600_pm_ops;
> =C2=A0
> +extern uint8_t inv_icm42605_int_reg;
> +
> =C2=A0const struct iio_mount_matrix *
> =C2=A0inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan);
> @@ -395,4 +415,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_ic=
m42600_state *st);
> =C2=A0
> =C2=A0int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
> =C2=A0
> +int inv_icm42605_generate_tilt_interrupt(struct inv_icm42600_state *st);
> +
> +int inv_icm42605_disable_tilt_interrupt(struct inv_icm42600_state *st);
> +
> =C2=A0#endif
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c
> index b1e4fde27d25..311f6ea09e64 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -47,6 +47,8 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .ext_info =3D _ext_info,=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +uint8_t inv_icm42605_int_reg;
> +
> =C2=A0enum inv_icm42600_accel_scan {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_SCAN_=
X,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_SCAN_=
Y,
> @@ -60,6 +62,68 @@ static const struct iio_chan_spec_ext_info inv_icm4260=
0_accel_ext_infos[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {},
> =C2=A0};
> =C2=A0
> +static ssize_t tilt_interrupt_show(struct device *dev,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr, char *buf)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D d=
ev_get_drvdata(dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(st->map, inv_ic=
m42605_int_reg, &val);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(buf, PAGE_SIZE, "Read reg =
%x value %x\n", inv_icm42605_int_reg, val);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return strlen(buf);
> +}
> +
> +static ssize_t tilt_interrupt_store(struct device *dev,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct device_attribute *attr, const char *buf,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 size_t count)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D d=
ev_get_drvdata(dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int value;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!st)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -EINVAL;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kstrtoint(buf, 10, &value))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -EINVAL;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42605_int_reg =3D INV_ICM426=
05_REG_INT_STATUS3;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (value) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 1:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D inv_icm42605_generate_tilt_interrupt(st);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (ret !=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D inv_icm42605_disable_tilt_interrupt(st);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (ret !=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -EINVAL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return count;
> +}
> +
> +static DEVICE_ATTR_RW(tilt_interrupt);
> +
> +static struct attribute *icm42605_attrs[] =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_tilt_interrupt.attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL,
> +};
> +
> +static const struct attribute_group icm42605_attrs_group =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .attrs =3D icm42605_attrs,
> +};
> +
> =C2=A0static const struct iio_chan_spec inv_icm42600_accel_channels[] =3D=
 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_CHAN(=
IIO_MOD_X, INV_ICM42600_ACCEL_SCAN_X,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_accel_ext_infos),
> @@ -702,6 +766,7 @@ static const struct iio_info inv_icm42600_accel_info =
=3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .update_scan_mode =3D in=
v_icm42600_accel_update_scan_mode,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hwfifo_set_watermark =
=3D inv_icm42600_accel_hwfifo_set_watermark,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hwfifo_flush_to_buffer =
=3D inv_icm42600_accel_hwfifo_flush,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .attrs =3D &icm42605_attrs_group,
> =C2=A0};
> =C2=A0
> =C2=A0struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *=
st)
> @@ -791,3 +856,67 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *in=
dio_dev)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0}
> +
> +int inv_icm42605_generate_tilt_interrupt(struct inv_icm42600_state *st)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char sleep =3D 10;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map,=
 INV_ICM42605_REG_APEX_CONFIG4,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42605_APEX_CONFIG4_MASK, 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_PWR_ACCEL_MODE;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_PWR_MGMT0, val);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42605_APEX_CONFIG0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_I=
CM42605_REG_APEX_CONFIG0, val);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_SIGNAL_PATH_RE=
SET_DMP_MEM_RESET;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_SIGNAL_PATH_RESET, val);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep(sleep);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_SIGNAL_PATH_RE=
SET_DMP_INIT_EN;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_SIGNAL_PATH_RESET, val);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42605_APEX_CONFIG0_T=
ILT_ENABLE |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 INV_ICM42605_APEX_CONFIG0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_I=
CM42605_REG_APEX_CONFIG0, val);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map,=
 INV_ICM42605_REG_INTF_CONFIG1,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42605_INTF_CONFIG1_MASK,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42605_INTF_CONFIG1_TILT_DET_=
INT1_EN);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +}
> +
> +int inv_icm42605_disable_tilt_interrupt(struct inv_icm42600_state *st)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_I=
CM42605_REG_APEX_CONFIG0, 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map,=
 INV_ICM42605_REG_INTF_CONFIG1,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42605_I=
NTF_CONFIG1_MASK, 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +}
>=20
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86

