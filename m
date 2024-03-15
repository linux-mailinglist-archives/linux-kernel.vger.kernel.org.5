Return-Path: <linux-kernel+bounces-103934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3987C6B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF5282A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644A946AB;
	Fri, 15 Mar 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WcOlNYhc"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EAE28E6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710461732; cv=none; b=JLrxNj2iQ4BW0QcGHm1pGB+MaiEY54/rT4hEbDjLDBuwZzJ7EYgaUUjhmrsEvL7rzpc3YVNvUglf9i4VnDYHNpasY6YMJ3GOIXdGegymP6F4uIygtxdi++J7QwADly5aSXX0qA+xYmEYbGzBOX+YKbFRHU4lm0955V0f9QHCcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710461732; c=relaxed/simple;
	bh=iPCvI9cAJJ6XqrwM3LbOqg+ugNAqYjJ/jVKsE8WUJU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYuROF9zQTn5E2vvOsia5x6YBatHlByTpQ+A5C5MnxGd9RITs+cqCpp3qLu4/6tZs0WyksaomR/LF299SvzjA4n/sTdO2HZQ9np/gCg20mTuRTbTHJLjWf2LVnpiTzxtzU+WqhF+yEgLM9axsIYUcHHzAC2skB87EqeG5bavd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WcOlNYhc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dee917abd5so58465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710461730; x=1711066530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGSSZFxOEggqk7jtO3U/5Y+eCNhXKvWEHeIQxNPQo9E=;
        b=WcOlNYhc2+tulIEJ/D/bTlPcUPMji6HnKrvzbHHcRc9J6y1IAw48gsJfgaVjUXx2Zs
         o8ugWA426mdMW9c5CDS6jXU1xoM00qIe8RM4JxfYSOvolon2N4yBZpvdsuRCyD5S1qC2
         ZHThyRkG0lEykeUGxPcinBBsr0pLSOlpVC7W7ipZvjRSkvMUbG+GUDTttw7+muBPZSeG
         GtfVLewcXVL50rUVHp6KSSiex228g3Vj9zUpSXcvuMemry+yYb58jeU6RDL6byaLwxP0
         DB9Rq4jZw8tPQbBaxj42oum+oYFcJe9FIlmkUQ/dXovAwcdZhngNMK0gFk6md1R1wg6o
         DqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710461730; x=1711066530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGSSZFxOEggqk7jtO3U/5Y+eCNhXKvWEHeIQxNPQo9E=;
        b=ctduERnCgZ4VhmG2JNb43K5K1rF3QvCkONvTXG0CevdzxjFAofrihIYFN0Ba+hHWzH
         ioITG4vaBgp5IkvzLNL42RnxtNLMg4d2Fkgybvr0m7RwacFnMFI1mHP7unWv7PNTLg5g
         Ehad1yCon4dT/AlV5i5aaLZpAWHxT0GJERV2GNMfeX/aKCwFZrqb4RU+sV6wYlpVuZ+k
         Mhb2iVqswLa5adNcQbGqXZAzIbwReB9FurMUOwoANFFy+lWmlWrneFhA49QGYGhf1VK1
         LmluEGHHk0rAtPgRloWTz5mj+sL2BHgfNkqd9loQnAv5Y/ARYRVg+7Ao98RM7rO4NJND
         fnWg==
X-Forwarded-Encrypted: i=1; AJvYcCVDwKKV/1ANFSfuXqtacKhqSccsqdbX3Tlkog1JRmzaIh5XEs0Y9UEksxnIPNKF6R2GvfY0b8Gh32+rpDqE03Gjt7o6qFoUt+PlDAVG
X-Gm-Message-State: AOJu0YyYCqq6YDSD9FZtUGPeWteVF08WNE2Iq2nbznDBUuaLOc6Ii+eK
	GA6OSF59ftxJ3KBNuChXf7vyRyRvYybAl30RbNptwXSC9tRV6t0pHPVo8Mz7QQ==
X-Google-Smtp-Source: AGHT+IEcvqgIL3VybGQG+8q2mrFaBDvw6CR0GhSZf3+d/kN6TA6FONV7338Vak/zUFI6rr/n/F8Crg==
X-Received: by 2002:a17:902:e88d:b0:1dd:b505:d518 with SMTP id w13-20020a170902e88d00b001ddb505d518mr359597plg.22.1710461729413;
        Thu, 14 Mar 2024 17:15:29 -0700 (PDT)
Received: from google.com (109.120.125.34.bc.googleusercontent.com. [34.125.120.109])
        by smtp.gmail.com with ESMTPSA id s12-20020a056a00178c00b006e6a52307dcsm2118603pfg.122.2024.03.14.17.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 17:15:28 -0700 (PDT)
Date: Fri, 15 Mar 2024 00:15:24 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, abhishekpandit@chromium.org,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: typec: ucsi: Check capabilities before cable
 and identity discovery
Message-ID: <ZfOTHO6FMlpjeQhZ@google.com>
References: <20240314235554.90079-1-jthies@google.com>
 <20240314235554.90079-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iqTGluPntXbmFBuc"
Content-Disposition: inline
In-Reply-To: <20240314235554.90079-2-jthies@google.com>


--iqTGluPntXbmFBuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jameson,

On Thu, Mar 14, 2024 at 11:55:54PM +0000, Jameson Thies wrote:
> Check the UCSI_CAP_GET_PD_MESSAGE bit before sending GET_PD_MESSAGE to
> discover partner and cable identity, check UCSI_CAP_CABLE_DETAILS before
> sending GET_CABLE_PROPERTY to discover the cable and check
> UCSI_CAP_ALT_MODE_DETAILS before registering the a cable plug.
>=20
> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Jameson Thies <jthies@google.com>

Since Neil pointed out that this error appeared starting in 38ca416597b0,
I think it would be appropriate to tag this commit with a Fixes: tag.

See here on instructions how to describe a Fixes:
https://www.kernel.org/doc/html/v4.10/process/submitting-patches.html#descr=
ibe-changes


> ---
> Confirmed a device which supports GET_PD_MESSAGE, GET_CABLE_PROPERTY and
> GET_ALTERNATE_MODES still requested identity and cable information.
>=20
> This moves 8 bits from "reserved_1" to "features" in the ucsi_capability
> struct. Really, this should be 24 bits to reflect the field size in UCSI.
> But, as of UCSI 3.0, this will not overflow becasue the bmOptionalFeatures
> description only defines 14 bits.

Are you sure you wanted to include this information below the --- ? This wo=
n't
be incorporated into the commit message when this is merged.


Thanks,
Benson

>=20
>  drivers/usb/typec/ucsi/ucsi.c | 34 +++++++++++++++++++++-------------
>  drivers/usb/typec/ucsi/ucsi.h |  5 +++--
>  2 files changed, 24 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index cf52cb34d2859..958dc82989b60 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1133,17 +1133,21 @@ static int ucsi_check_cable(struct ucsi_connector=
 *con)
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D ucsi_get_cable_identity(con);
> -	if (ret < 0)
> -		return ret;
> +	if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE) {
> +		ret =3D ucsi_get_cable_identity(con);
> +		if (ret < 0)
> +			return ret;
> +	}
> =20
> -	ret =3D ucsi_register_plug(con);
> -	if (ret < 0)
> -		return ret;
> +	if (con->ucsi->cap.features & UCSI_CAP_ALT_MODE_DETAILS) {
> +		ret =3D ucsi_register_plug(con);
> +		if (ret < 0)
> +			return ret;
> =20
> -	ret =3D ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
> -	if (ret < 0)
> -		return ret;
> +		ret =3D ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
> +		if (ret < 0)
> +			return ret;
> +	}
> =20
>  	return 0;
>  }
> @@ -1189,8 +1193,10 @@ static void ucsi_handle_connector_change(struct wo=
rk_struct *work)
>  			ucsi_register_partner(con);
>  			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
>  			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
> -			ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
> -			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
> +			if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
> +				ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
> +			if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
> +				ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
> =20
>  			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) =3D=3D
>  			    UCSI_CONSTAT_PWR_OPMODE_PD)
> @@ -1589,8 +1595,10 @@ static int ucsi_register_port(struct ucsi *ucsi, s=
truct ucsi_connector *con)
>  		ucsi_register_partner(con);
>  		ucsi_pwr_opmode_change(con);
>  		ucsi_port_psy_changed(con);
> -		ucsi_get_partner_identity(con);
> -		ucsi_check_cable(con);
> +		if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
> +			ucsi_get_partner_identity(con);
> +		if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
> +			ucsi_check_cable(con);
>  	}
> =20
>  	/* Only notify USB controller if partner supports USB data */
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 32daf5f586505..0e7c92eb1b227 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -206,7 +206,7 @@ struct ucsi_capability {
>  #define UCSI_CAP_ATTR_POWER_OTHER		BIT(10)
>  #define UCSI_CAP_ATTR_POWER_VBUS		BIT(14)
>  	u8 num_connectors;
> -	u8 features;
> +	u16 features;
>  #define UCSI_CAP_SET_UOM			BIT(0)
>  #define UCSI_CAP_SET_PDM			BIT(1)
>  #define UCSI_CAP_ALT_MODE_DETAILS		BIT(2)
> @@ -215,7 +215,8 @@ struct ucsi_capability {
>  #define UCSI_CAP_CABLE_DETAILS			BIT(5)
>  #define UCSI_CAP_EXT_SUPPLY_NOTIFICATIONS	BIT(6)
>  #define UCSI_CAP_PD_RESET			BIT(7)
> -	u16 reserved_1;
> +#define UCSI_CAP_GET_PD_MESSAGE		BIT(8)
> +	u8 reserved_1;
>  	u8 num_alt_modes;
>  	u8 reserved_2;
>  	u16 bc_version;
> --=20
> 2.44.0.291.gc1ea87d7ee-goog
>=20

--iqTGluPntXbmFBuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZfOTHAAKCRBzbaomhzOw
whB3AP946oaNmuw0wJkY/4atT3JxeH7Zt2KDypPL00UNC6SxaAEArNt5K27sbk4W
opP71xy41YA4ERBox7GvTmIcXBU4jgU=
=DycA
-----END PGP SIGNATURE-----

--iqTGluPntXbmFBuc--

