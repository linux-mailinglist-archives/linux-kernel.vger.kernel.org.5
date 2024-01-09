Return-Path: <linux-kernel+bounces-20802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5EC828565
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDF1284267
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758C3381B1;
	Tue,  9 Jan 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="mfYU0U1b"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6C3717B;
	Tue,  9 Jan 2024 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3841D1C0050; Tue,  9 Jan 2024 12:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1704800764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxKjPdKA0cEwZTm0Buk8HkHBJ6hCFNagp4tne2EQE7Y=;
	b=mfYU0U1b7uGQQoExKH6W9VFQLMNptLoosPF+okjDjAg+org+jb13+HjMJHKTAWca8Ri6/N
	Pu4267KRnOjrKZzbPFZ8rvMVAwkVctYgBCqJKFzwqEj7gwmrb4o12Og9dKh0ttx3zLL1f7
	8T8pVr5ynFrkirQax9+n90X92SHoKqs=
Date: Tue, 9 Jan 2024 12:46:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vishnu Sankar <vishnuocv@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 12/24] platform/x86: thinkpad_acpi: fix for
 incorrect fan reporting on some ThinkPad systems
Message-ID: <ZZ0x+wlRGxwPOArK@duo.ucw.cz>
References: <20231226002255.5730-1-sashal@kernel.org>
 <20231226002255.5730-12-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RqAJcv4WMeLX7X9R"
Content-Disposition: inline
In-Reply-To: <20231226002255.5730-12-sashal@kernel.org>


--RqAJcv4WMeLX7X9R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 66e92e23a72761f5b53f970aeb1badc5fd92fc74 ]
>=20
> Some ThinkPad systems ECFW use non-standard addresses for fan control
> and reporting. This patch adds support for such ECFW so that it can report
> the correct fan values.
> Tested on Thinkpads L13 Yoga Gen 2 and X13 Yoga Gen 2.

This is just a new feature, and is > 200 lines. We should not have
this in stable.

BR,
								Pavel





> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/r/20231214134702.166464-1-vishnuocv@gmail.c=
om
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 98 ++++++++++++++++++++++++----
>  1 file changed, 85 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index 05a55bc31c796..6edd2e294750e 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8149,8 +8149,19 @@ static struct ibm_struct volume_driver_data =3D {
>   * 	TPACPI_FAN_WR_TPEC is also available and should be used to
>   * 	command the fan.  The X31/X40/X41 seems to have 8 fan levels,
>   * 	but the ACPI tables just mention level 7.
> + *
> + * TPACPI_FAN_RD_TPEC_NS:
> + *	This mode is used for a few ThinkPads (L13 Yoga Gen2, X13 Yoga Gen2 e=
tc.)
> + *	that are using non-standard EC locations for reporting fan speeds.
> + *	Currently these platforms only provide fan rpm reporting.
> + *
>   */
> =20
> +#define FAN_RPM_CAL_CONST 491520	/* FAN RPM calculation offset for some =
non-standard ECFW */
> +
> +#define FAN_NS_CTRL_STATUS	BIT(2)		/* Bit which determines control is en=
abled or not */
> +#define FAN_NS_CTRL		BIT(4)		/* Bit which determines control is by host =
or EC */
> +
>  enum {					/* Fan control constants */
>  	fan_status_offset =3D 0x2f,	/* EC register 0x2f */
>  	fan_rpm_offset =3D 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
> @@ -8158,6 +8169,11 @@ enum {					/* Fan control constants */
>  	fan_select_offset =3D 0x31,	/* EC register 0x31 (Firmware 7M)
>  					   bit 0 selects which fan is active */
> =20
> +	fan_status_offset_ns =3D 0x93,	/* Special status/control offset for non=
-standard EC Fan1 */
> +	fan2_status_offset_ns =3D 0x96,	/* Special status/control offset for no=
n-standard EC Fan2 */
> +	fan_rpm_status_ns =3D 0x95,	/* Special offset for Fan1 RPM status for n=
on-standard EC */
> +	fan2_rpm_status_ns =3D 0x98,	/* Special offset for Fan2 RPM status for =
non-standard EC */
> +
>  	TP_EC_FAN_FULLSPEED =3D 0x40,	/* EC fan mode: full speed */
>  	TP_EC_FAN_AUTO	    =3D 0x80,	/* EC fan mode: auto fan control */
> =20
> @@ -8168,6 +8184,7 @@ enum fan_status_access_mode {
>  	TPACPI_FAN_NONE =3D 0,		/* No fan status or control */
>  	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
>  	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
> +	TPACPI_FAN_RD_TPEC_NS,		/* Use non-standard ACPI EC regs (eg: L13 Yoga =
gen2 etc.) */
>  };
> =20
>  enum fan_control_access_mode {
> @@ -8195,6 +8212,8 @@ static u8 fan_control_desired_level;
>  static u8 fan_control_resume_level;
>  static int fan_watchdog_maxinterval;
> =20
> +static bool fan_with_ns_addr;
> +
>  static struct mutex fan_mutex;
> =20
>  static void fan_watchdog_fire(struct work_struct *ignored);
> @@ -8325,6 +8344,15 @@ static int fan_get_status(u8 *status)
>  		}
> =20
>  		break;
> +	case TPACPI_FAN_RD_TPEC_NS:
> +		/* Default mode is AUTO which means controlled by EC */
> +		if (!acpi_ec_read(fan_status_offset_ns, &s))
> +			return -EIO;
> +
> +		if (status)
> +			*status =3D s;
> +
> +		break;
> =20
>  	default:
>  		return -ENXIO;
> @@ -8341,7 +8369,8 @@ static int fan_get_status_safe(u8 *status)
>  	if (mutex_lock_killable(&fan_mutex))
>  		return -ERESTARTSYS;
>  	rc =3D fan_get_status(&s);
> -	if (!rc)
> +	/* NS EC doesn't have register with level settings */
> +	if (!rc && !fan_with_ns_addr)
>  		fan_update_desired_level(s);
>  	mutex_unlock(&fan_mutex);
> =20
> @@ -8368,7 +8397,13 @@ static int fan_get_speed(unsigned int *speed)
> =20
>  		if (likely(speed))
>  			*speed =3D (hi << 8) | lo;
> +		break;
> +	case TPACPI_FAN_RD_TPEC_NS:
> +		if (!acpi_ec_read(fan_rpm_status_ns, &lo))
> +			return -EIO;
> =20
> +		if (speed)
> +			*speed =3D lo ? FAN_RPM_CAL_CONST / lo : 0;
>  		break;
> =20
>  	default:
> @@ -8380,7 +8415,7 @@ static int fan_get_speed(unsigned int *speed)
> =20
>  static int fan2_get_speed(unsigned int *speed)
>  {
> -	u8 hi, lo;
> +	u8 hi, lo, status;
>  	bool rc;
> =20
>  	switch (fan_status_access_mode) {
> @@ -8396,7 +8431,21 @@ static int fan2_get_speed(unsigned int *speed)
> =20
>  		if (likely(speed))
>  			*speed =3D (hi << 8) | lo;
> +		break;
> =20
> +	case TPACPI_FAN_RD_TPEC_NS:
> +		rc =3D !acpi_ec_read(fan2_status_offset_ns, &status);
> +		if (rc)
> +			return -EIO;
> +		if (!(status & FAN_NS_CTRL_STATUS)) {
> +			pr_info("secondary fan control not supported\n");
> +			return -EIO;
> +		}
> +		rc =3D !acpi_ec_read(fan2_rpm_status_ns, &lo);
> +		if (rc)
> +			return -EIO;
> +		if (speed)
> +			*speed =3D lo ? FAN_RPM_CAL_CONST / lo : 0;
>  		break;
> =20
>  	default:
> @@ -8899,6 +8948,7 @@ static const struct attribute_group fan_driver_attr=
_group =3D {
>  #define TPACPI_FAN_2FAN		0x0002		/* EC 0x31 bit 0 selects fan2 */
>  #define TPACPI_FAN_2CTL		0x0004		/* selects fan2 control */
>  #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
> +#define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addr=
esses */
> =20
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst =3D {
>  	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
> @@ -8917,6 +8967,8 @@ static const struct tpacpi_quirk fan_quirk_table[] =
__initconst =3D {
>  	TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (2nd =
gen) */
>  	TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),	/* P15 (1st gen) / P15v =
(1st gen) */
>  	TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen) */
> +	TPACPI_Q_LNV3('R', '1', 'F', TPACPI_FAN_NS),	/* L13 Yoga Gen 2 */
> +	TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),	/* X13 Yoga Gen 2*/
>  	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) =
*/
>  };
> =20
> @@ -8951,18 +9003,27 @@ static int __init fan_init(struct ibm_init_struct=
 *iibm)
>  		return -ENODEV;
>  	}
> =20
> +	if (quirks & TPACPI_FAN_NS) {
> +		pr_info("ECFW with non-standard fan reg control found\n");
> +		fan_with_ns_addr =3D 1;
> +		/* Fan ctrl support from host is undefined for now */
> +		tp_features.fan_ctrl_status_undef =3D 1;
> +	}
> +
>  	if (gfan_handle) {
>  		/* 570, 600e/x, 770e, 770x */
>  		fan_status_access_mode =3D TPACPI_FAN_RD_ACPI_GFAN;
>  	} else {
>  		/* all other ThinkPads: note that even old-style
>  		 * ThinkPad ECs supports the fan control register */
> -		if (likely(acpi_ec_read(fan_status_offset,
> -					&fan_control_initial_status))) {
> +		if (fan_with_ns_addr ||
> +		    likely(acpi_ec_read(fan_status_offset, &fan_control_initial_status=
))) {
>  			int res;
>  			unsigned int speed;
> =20
> -			fan_status_access_mode =3D TPACPI_FAN_RD_TPEC;
> +			fan_status_access_mode =3D fan_with_ns_addr ?
> +				TPACPI_FAN_RD_TPEC_NS : TPACPI_FAN_RD_TPEC;
> +
>  			if (quirks & TPACPI_FAN_Q1)
>  				fan_quirk1_setup();
>  			/* Try and probe the 2nd fan */
> @@ -8971,7 +9032,8 @@ static int __init fan_init(struct ibm_init_struct *=
iibm)
>  			if (res >=3D 0 && speed !=3D FAN_NOT_PRESENT) {
>  				/* It responded - so let's assume it's there */
>  				tp_features.second_fan =3D 1;
> -				tp_features.second_fan_ctl =3D 1;
> +				/* fan control not currently available for ns ECFW */
> +				tp_features.second_fan_ctl =3D !fan_with_ns_addr;
>  				pr_info("secondary fan control detected & enabled\n");
>  			} else {
>  				/* Fan not auto-detected */
> @@ -9146,6 +9208,7 @@ static int fan_read(struct seq_file *m)
>  			       str_enabled_disabled(status), status);
>  		break;
> =20
> +	case TPACPI_FAN_RD_TPEC_NS:
>  	case TPACPI_FAN_RD_TPEC:
>  		/* all except 570, 600e/x, 770e, 770x */
>  		rc =3D fan_get_status_safe(&status);
> @@ -9160,13 +9223,22 @@ static int fan_read(struct seq_file *m)
> =20
>  		seq_printf(m, "speed:\t\t%d\n", speed);
> =20
> -		if (status & TP_EC_FAN_FULLSPEED)
> -			/* Disengaged mode takes precedence */
> -			seq_printf(m, "level:\t\tdisengaged\n");
> -		else if (status & TP_EC_FAN_AUTO)
> -			seq_printf(m, "level:\t\tauto\n");
> -		else
> -			seq_printf(m, "level:\t\t%d\n", status);
> +		if (fan_status_access_mode =3D=3D TPACPI_FAN_RD_TPEC_NS) {
> +			/*
> +			 * No full speed bit in NS EC
> +			 * EC Auto mode is set by default.
> +			 * No other levels settings available
> +			 */
> +			seq_printf(m, "level:\t\t%s\n", status & FAN_NS_CTRL ? "unknown" : "a=
uto");
> +		} else {
> +			if (status & TP_EC_FAN_FULLSPEED)
> +				/* Disengaged mode takes precedence */
> +				seq_printf(m, "level:\t\tdisengaged\n");
> +			else if (status & TP_EC_FAN_AUTO)
> +				seq_printf(m, "level:\t\tauto\n");
> +			else
> +				seq_printf(m, "level:\t\t%d\n", status);
> +		}
>  		break;
> =20
>  	case TPACPI_FAN_NONE:

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--RqAJcv4WMeLX7X9R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZZ0x+wAKCRAw5/Bqldv6
8qqZAJ9yLVMfcZHaTUOxiqyLXH8+CSa8tQCfZbamj9avaPyizT5U11bthYaCPDQ=
=3p+4
-----END PGP SIGNATURE-----

--RqAJcv4WMeLX7X9R--

