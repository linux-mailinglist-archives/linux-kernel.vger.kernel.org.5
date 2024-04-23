Return-Path: <linux-kernel+bounces-155484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF178AEB39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8616B2830C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380113C909;
	Tue, 23 Apr 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2FI5F/C"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132A13B7BD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886609; cv=none; b=DMeLXmdWSJmDwrJzvDNhhT46lV81jWvxIiH/h4dcATcZC3qTHaTizWOjygAWBAUg3FgH5ueJ5XcngeFlRkxy4t66EEk62YXl8lzy/bmbyi0uNYPnTRb7ISdmZnC68m6f9DojdNQYIiub0ERj/UOl75WQgqDoEuGYS4MmKPRrDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886609; c=relaxed/simple;
	bh=jDvBKQG05oLemGWaV3UZWdHozbfOYKKcI6YA8cJFeXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihkKGIFNnEZrX33xNFFIvIkf+o3udcU6rvWnEdLKHJb/Rp6q2UDfM0GByHezQY0eYJwrBqUNI3jXtumM4H3s7pGL1GC6GMuKQqbRx7K40JA+g0vO/14T4HGS9rDN+NiAuoyaB2GDW3sx+oY2RS0+cuXn7olrtMLp3ZG5BVmoDuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c2FI5F/C; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e8414dc4e8so145705ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713886608; x=1714491408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4ubhm6fkojtxWKFe2qMR5L5Z0nBCehD/B0hZZ53teU=;
        b=c2FI5F/CJyaw477h8bEkV0bNIg1HZLgYjyECwbDTKZ2BKRCl6O7abGMTmPzBpRYfJi
         A0BbALsNc25j1midtz2B23oMfRRsfRfYJXcQzZ0rukQ3Lob3skp2mo6xdFZKGgSXNJUl
         nYIS+Lo1UhcU266zUUSCibo4a4KHKr8n/C5ZBA3GbLdR+jR5I1nu9+oF+KKm5WopY7Yc
         Z8t6ZeY7KZ+1W3qEuy6CDQgr/qsi/pKh9Tbu1phcC+0/UGeMAoUcL84EUHMgAgigiCy/
         ONAdu72vMZA/656mLXq/fiTgvyt4MMoN0lGkccUvCZGp3WeCD/GHOSujFeunxFpS82RG
         cjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886608; x=1714491408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4ubhm6fkojtxWKFe2qMR5L5Z0nBCehD/B0hZZ53teU=;
        b=J8i0jvG/Dz3RYD/lgxUEvQw/rja00PCx/cIWWMI2q4EDjIp1+Tv4eUUZQmatGVE5xl
         teDiQKO2MuRuRh9puJ0XcuT5wPtm/gUVg+QjOt3oKhNdn2eps/D1fMYTBxG1UQx+duEd
         kfEKhB4+7fJ7rbICysiCFlBUACQETfLo764rKeX9CxlsQQ8T/ks2MM3f/U5HbJn/l7pg
         eA4ZoG2i9JnOwuzjQW9P2THa9hLFVX9F22QlMq6Na78LLAE3g/us1Tr99bjgUb6HvS3Z
         d3Iaeej04Q2OOCEGUgcBWX+kRdQiIcdI1olZFDUj2myPzWHP80kZIJpyK+nbUKgfvJK0
         LdxA==
X-Forwarded-Encrypted: i=1; AJvYcCXyYZIq2M3CveaGgey9DTY3wmNtW8GYz42ovDRFLlECoTjrTs+sYlT0qNOVf4usAuFTQRGpdO5CdFEp21pZjbxZX3SLCtBCZuFNp3jj
X-Gm-Message-State: AOJu0YxU3Ls+IJh4axHy8VT6VIT1FU3/xQW57Ap71EtmtWw4/XWRJeTD
	myjhuOyTgrjb4NgEmMHdO4zUvyxKbzIFrfbEwMBbACnxT/ENpGuvCTa0yGUtpg==
X-Google-Smtp-Source: AGHT+IHNT/+s+PTrZqElSeDpIy9K6lXA/MCCFFeEsktNCCaSV2KcQpwQT6dQJTQuNdWibrFs2eQybg==
X-Received: by 2002:a17:903:11d2:b0:1e3:c01d:fb17 with SMTP id q18-20020a17090311d200b001e3c01dfb17mr221412plh.11.1713886607326;
        Tue, 23 Apr 2024 08:36:47 -0700 (PDT)
Received: from google.com (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a070900b002a528a1f907sm12328417pjl.56.2024.04.23.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 08:36:46 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:36:42 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, abhishekpandit@chromium.org,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] usb: typec: ucsi: Delay alternate mode discovery
Message-ID: <ZifVitZN6otehLfr@google.com>
References: <20240419211650.2657096-1-jthies@google.com>
 <20240419211650.2657096-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IpCsqH9qr7AvMRlR"
Content-Disposition: inline
In-Reply-To: <20240419211650.2657096-4-jthies@google.com>


--IpCsqH9qr7AvMRlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 09:16:49PM +0000, Jameson Thies wrote:
> Delay the ucsi_check_altmodes task to be inline with surrounding partner
> tasks. This allows partner, cable and identity discovery to complete
> before alternate mode registration. With that order, alternate mode
> discovery can be used to indicate the ucsi driver has completed
> discovery.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index b8d56a443531f..cd4c3b7a5d989 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -963,7 +963,7 @@ static void ucsi_pwr_opmode_change(struct ucsi_connec=
tor *con)
>  		con->rdo =3D con->status.request_data_obj;
>  		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_PD);
>  		ucsi_partner_task(con, ucsi_get_src_pdos, 30, 0);
> -		ucsi_partner_task(con, ucsi_check_altmodes, 30, 0);
> +		ucsi_partner_task(con, ucsi_check_altmodes, 30, HZ);
>  		ucsi_partner_task(con, ucsi_register_partner_pdos, 1, HZ);
>  		break;
>  	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
> @@ -1247,7 +1247,7 @@ static void ucsi_handle_connector_change(struct wor=
k_struct *work)
>  	}
> =20
>  	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
> -		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
> +		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
> =20
>  out_unlock:
>  	mutex_unlock(&con->lock);
> --=20
> 2.44.0.769.g3c40516874-goog
>=20

--IpCsqH9qr7AvMRlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZifVigAKCRBzbaomhzOw
wty6AP4rgPBa73MdW6ufqEHb363O5GEUiAUiMMV1Ot2U4+vwNQEAlY6ORdjutWGO
zpBiXhvaSFvGyblFv66FCATSEVwGwA4=
=cg41
-----END PGP SIGNATURE-----

--IpCsqH9qr7AvMRlR--

