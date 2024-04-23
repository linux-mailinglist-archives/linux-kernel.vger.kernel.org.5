Return-Path: <linux-kernel+bounces-155483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75E8AEB36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11302B20EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192C13C9C0;
	Tue, 23 Apr 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAaN9T6+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C917BA8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886561; cv=none; b=FartYdc8l6siHyFYG1zv8V594N5q5/7Qsy603THsRtkVnNANjCGOKyOWsZLOMte+e7kYtBo4N1tEmeMYoQ5npCwcdNy5DsKn7RdWrQ/nIeEFO/61IWYUheEMDyqMNYmfQbE3xgtEf4eY4svPtdnaIx2ThoYy3KMbLfomWZF4HQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886561; c=relaxed/simple;
	bh=3l4IWHlo4FBl22jlavtlXCLATKpqmRJOm/W+8dhML4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqtPIeYpWqOv10vqwpGd8wAexI+LohRn5xOFdl0NkQr5iFWboUectes8mxpw0duu/iBc+Z/1FPFxJV+VRqjRBPLoSQQoRexVB8Vl/zVmP0WgVjuxP/6S/07sfGE5+MpA7M/bM4ifWVBarybO1D5MbR6eXqDE9XU26SHaJiVnqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAaN9T6+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e8fcb0b860so210005ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713886559; x=1714491359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZKchwpeRb+GhSAX5RArUTFkziKYCy4THGiKgOpnTKU=;
        b=xAaN9T6+48GP5WAVtUlTGd5O5kI6tBH6NUoi4Ih5vOJhJXleAdtZrs9BjwjqGLOyn3
         MV4833Tu8yBu4CyXRw092W8+9Cj3+mtcpA32r4gqsjteI73/VGM1MKmfcmeU6dYnIX1P
         acTfarhPu1bYkllLj4ruzZRf0XFujnXrD23vDL01ugahyq2yFUJDQ1IN4JU9VKF3VxBK
         n/om4kt/fImMKZxFodXAUgux4pr6E038+JJiVIoEjQVv9P5hvMUF0ClaOyh/lxVWPAMa
         J3MgaaE5ZZWFjIMviHZOui6iLFgQ2hhDOT8/aYTz3ak2C/YcBfoCJrMvj5TezPThYS0c
         sPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886559; x=1714491359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZKchwpeRb+GhSAX5RArUTFkziKYCy4THGiKgOpnTKU=;
        b=FbrK5eFNdi4CkSWnSWwJ8y8wg4KPDdiK3jJ4ZSeeIOFAyiFxu243bnBJIjbl2EAd6t
         KLN7uV52pSr2Xh98fZwic0it+0E7RoPjjz2jLw3lEcpuS1YGqaZC+RsXz+up5uGZqd/E
         0DuuyyaTZeDyhk0QGlkFX0PIPieq/mAklU9oXXahG1qOll+pw03/K9bxoE62aCuwTJxu
         UAUSUSPd1BbwkPSmS8j7mj//ssajp4YYtsDOydjk3UYCKtWHfj0JEVOgi+UA/7Rv27DB
         gPT20ilxmYHx2rexmRsNbOxZFSgsHp45AfENnUsi28GlcCpw+6ddCkrv0F/eUnCEuTRb
         e4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG0Wkmz1gdhdtPncNnghu0bkEPT+sRQcoimPExl2CpifQ/F7a0Xb/LfsLRCRjxw3wsfOxZiVpg44Qb+zbqk7o2wA0DhOi1y8YO3Gtu
X-Gm-Message-State: AOJu0YzJWI5ephTomYC9Khx0RULAG64Zmp1G02G7xabziRWkI3bye2na
	MGdHywhAQhWWHZyj8a46yaM5fOXJtj9DyaFadIwxhz0VG6Cj4OGQhb3e1FVyqA==
X-Google-Smtp-Source: AGHT+IGX89rnpKNcaO3q/DhHRZ4FQafeAExWN80hXpNqwv5SFj8GubN26PQSHp8C9mjXqeodUPig2w==
X-Received: by 2002:a17:902:f54c:b0:1e3:d23a:2d5e with SMTP id h12-20020a170902f54c00b001e3d23a2d5emr211183plf.21.1713886558627;
        Tue, 23 Apr 2024 08:35:58 -0700 (PDT)
Received: from google.com (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id v2-20020aa78082000000b006eab6ac1f83sm9791713pff.0.2024.04.23.08.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 08:35:57 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:35:54 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, abhishekpandit@chromium.org,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] usb: typec: Update sysfs when setting ops
Message-ID: <ZifVWgG2PTna95MM@google.com>
References: <20240419211650.2657096-1-jthies@google.com>
 <20240419211650.2657096-3-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lzrJQjUThhd7EzhD"
Content-Disposition: inline
In-Reply-To: <20240419211650.2657096-3-jthies@google.com>


--lzrJQjUThhd7EzhD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 09:16:48PM +0000, Jameson Thies wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>=20
> When adding altmode ops, update the sysfs group so that visibility is
> also recalculated.
>=20
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/usb/typec/altmodes/displayport.c |  2 +-
>  drivers/usb/typec/class.c                | 18 +++++++++++++++++-
>  drivers/usb/typec/ucsi/displayport.c     |  2 +-
>  include/linux/usb/typec.h                |  3 +++
>  4 files changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec=
/altmodes/displayport.c
> index 596cd4806018b..92cc1b1361208 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -746,7 +746,7 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	dp->alt =3D alt;
> =20
>  	alt->desc =3D "DisplayPort";
> -	alt->ops =3D &dp_altmode_ops;
> +	typec_altmode_set_ops(alt, &dp_altmode_ops);
> =20
>  	if (plug) {
>  		plug->desc =3D "Displayport";
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 9610e647a8d48..9262fcd4144f8 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -467,6 +467,22 @@ static const struct attribute_group *typec_altmode_g=
roups[] =3D {
>  	NULL
>  };
> =20
> +/**
> + * typec_altmode_set_ops - Set ops for altmode
> + * @adev: Handle to the alternate mode
> + * @ops: Ops for the alternate mode
> + *
> + * After setting ops, attribute visiblity needs to be refreshed if the a=
lternate
> + * mode can be activated.
> + */
> +void typec_altmode_set_ops(struct typec_altmode *adev,
> +			   const struct typec_altmode_ops *ops)
> +{
> +	adev->ops =3D ops;
> +	sysfs_update_group(&adev->dev.kobj, &typec_altmode_group);
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_set_ops);
> +
>  static int altmode_id_get(struct device *dev)
>  {
>  	struct ida *ids;
> @@ -2317,7 +2333,7 @@ void typec_port_register_altmodes(struct typec_port=
 *port,
>  			continue;
>  		}
> =20
> -		alt->ops =3D ops;
> +		typec_altmode_set_ops(alt, ops);
>  		typec_altmode_set_drvdata(alt, drvdata);
>  		altmodes[index] =3D alt;
>  		index++;
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucs=
i/displayport.c
> index d9d3c91125ca8..eb7b8d6e47d00 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -337,7 +337,7 @@ struct typec_altmode *ucsi_register_displayport(struc=
t ucsi_connector *con,
>  	dp->con =3D con;
>  	dp->alt =3D alt;
> =20
> -	alt->ops =3D &ucsi_displayport_ops;
> +	typec_altmode_set_ops(alt, &ucsi_displayport_ops);
>  	typec_altmode_set_drvdata(alt, dp);
> =20
>  	return alt;
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index b35b427561ab5..549275f8ac1b3 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -167,6 +167,9 @@ struct typec_port *typec_altmode2port(struct typec_al=
tmode *alt);
> =20
>  void typec_altmode_update_active(struct typec_altmode *alt, bool active);
> =20
> +void typec_altmode_set_ops(struct typec_altmode *alt,
> +			   const struct typec_altmode_ops *ops);
> +
>  enum typec_plug_index {
>  	TYPEC_PLUG_SOP_P,
>  	TYPEC_PLUG_SOP_PP,
> --=20
> 2.44.0.769.g3c40516874-goog
>=20

--lzrJQjUThhd7EzhD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZifVWQAKCRBzbaomhzOw
wgzKAQDutO7PxZZmrsHtG9ddC9XxkmJElv1XwC3nlGuAjT6zsgEAuIMeG411uWiX
v+/8HebGvTwGWOBConsvt901Hru3awo=
=v14f
-----END PGP SIGNATURE-----

--lzrJQjUThhd7EzhD--

