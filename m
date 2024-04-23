Return-Path: <linux-kernel+bounces-155485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A38AEB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB4A284043
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CACA13C911;
	Tue, 23 Apr 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37W9Fk1H"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57543605CE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886672; cv=none; b=sxkhWPnR7LUg90fLRTifDD67SvFiMal+tX7I5HqMi3Rl8DF6D6Z45qLKHyR9SPTz0hAxRz2jQGv7E51M+cj038mqyWviTN55xJ2IHHV3g5ga7LwxQ0yveLmW2hwXapkP+2hGV/3OhLYJjyGiJruW2NOD0fh2VsblwkX0neJqTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886672; c=relaxed/simple;
	bh=vl3GRAzYz99s0lWym4/W6lfyNnieohCIbEozsVCTjag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJ6Tj9goXpVOVMVBsJ180cjt8nbhqffmORqIFHAdGavvXdlGrOKbAPRgko2abXKwoNknsPfUu2VYMNw68mTsLRcby+JtmWZG2j+R+10cSeJ35olQxSQ3f117+hqcfZ9cAqlvBXDRFvnpccjEhAPI1ygNmC4wFc1fF9ZUiCXUgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37W9Fk1H; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e8fcb0b860so210315ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713886670; x=1714491470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELOEiKBNPubW2OIGLE+1HSCC+4SjR5FivEAPE1zzPx0=;
        b=37W9Fk1H8XPxycm74jeZaPqE+v2bZ7qzJDY4Teut5l73MuKBrXMuRa1Wsb+UHIAh6T
         iG/fV6vh9He1ZiIl1h0Li9Z8QI8T7K0N9nQxYjscjDy+eVCp1FEsEX+aBgSHn51Ba5Pj
         O4DShzUUzebtgxYfGVWL83BMe98DeXB1pQCMM3LMQv574sdoutwDUFlrjtcfwBpd4MkB
         9kdrgfZ8/f2mcvk9WmSi4Kn+rC0Y0Wj6m5V6C6A39ZR0CVQ7ZjBKC0+eM65Uc4AKOhKD
         WYNoDZvEQnr0ZAnqGyEEgpgJKYKnyCJupp3S/+M6uKkAOzpf/qcDkkcG5qK8yf/Lzt1W
         ipnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886670; x=1714491470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELOEiKBNPubW2OIGLE+1HSCC+4SjR5FivEAPE1zzPx0=;
        b=Q/AcRLdLJ8uTDA/0JQe6k03bbCy40M/AC7qTWG1T9qiIbnyrrEDgn9PLWl7CLNx5Fj
         xcowV7CRR5p/X/VPnVqqMfdLGtftbJ/02Gp/DCav+AakXTaEC19P/ku+N6na4JN64CQ8
         5trt/mE8YNSyNQA8ZjVOh0AiEmIv8TV7XqO3BUQtOrnXlTbQpVqRqJwbsHl3zVfyvE+Z
         55LcOG1a7kc/KqcDq5Kc53VQzUtJU45tTg3axq3Hsg5nPp3Xt9qSkxsvqV9EcPDpq3tI
         nD1YqYgFbkMbk/DI3rQWFrc1hm41LwFt6+dBzr04D9Ebh3hByJkoIs00t3LfUBDQlYwJ
         ffpg==
X-Forwarded-Encrypted: i=1; AJvYcCWYX9OfDqPdQF5cpoOQMAM0pOkmOKpHXSAwcFc4mkvOBD4nzMW5s/zr9bdriA0uV0eyV2T6u/yWRCLTpBs46bDS1biFehoajOjJTCkF
X-Gm-Message-State: AOJu0Yw9GjH5mTjckdgFpUsPhJDw7acjFXXyJFW0wk+XqQ63Bj1jI36N
	NmEtxU56cwWFLEq47zK3IlLa0YzGOgb6RO02SxjbJtOf/kUFivTtk0hkAS3IKA==
X-Google-Smtp-Source: AGHT+IGgaTqKcq+i+yPtDAOE8UP2FdqxGzb3uuymH0A+e0Rp9pmpsohZFyxdCX8qDm6ENYzvXQPmpA==
X-Received: by 2002:a17:902:ea04:b0:1de:f0c7:108 with SMTP id s4-20020a170902ea0400b001def0c70108mr272281plg.6.1713886669001;
        Tue, 23 Apr 2024 08:37:49 -0700 (PDT)
Received: from google.com (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id u3-20020a631403000000b005bdbe9a597fsm9626776pgl.57.2024.04.23.08.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 08:37:47 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:37:44 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, abhishekpandit@chromium.org,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] usb: typec: ucsi: Always set number of alternate
 modes
Message-ID: <ZifVyNAfLyq4qG5H@google.com>
References: <20240419211650.2657096-1-jthies@google.com>
 <20240419211650.2657096-5-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eJT88a/Gw6Jw6Zqe"
Content-Disposition: inline
In-Reply-To: <20240419211650.2657096-5-jthies@google.com>


--eJT88a/Gw6Jw6Zqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 09:16:50PM +0000, Jameson Thies wrote:
> Providing the number of known alternate modes allows user space to
> determine when device registration has completed. Always register a
> number of known alternate modes for the partner and cable plug, even
> when the number of supported alternate modes is 0.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index cd4c3b7a5d989..ea76d42fd1504 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -812,10 +812,11 @@ static int ucsi_check_altmodes(struct ucsi_connecto=
r *con)
>  	/* Ignoring the errors in this case. */
>  	if (con->partner_altmode[0]) {
>  		num_partner_am =3D ucsi_get_num_altmode(con->partner_altmode);
> -		if (num_partner_am > 0)
> -			typec_partner_set_num_altmodes(con->partner, num_partner_am);
> +		typec_partner_set_num_altmodes(con->partner, num_partner_am);
>  		ucsi_altmode_update_active(con);
>  		return 0;
> +	} else {
> +		typec_partner_set_num_altmodes(con->partner, 0);
>  	}
> =20
>  	return ret;
> @@ -1138,7 +1139,7 @@ static int ucsi_check_connection(struct ucsi_connec=
tor *con)
>  static int ucsi_check_cable(struct ucsi_connector *con)
>  {
>  	u64 command;
> -	int ret;
> +	int ret, num_plug_am;
> =20
>  	if (con->cable)
>  		return 0;
> @@ -1172,6 +1173,13 @@ static int ucsi_check_cable(struct ucsi_connector =
*con)
>  			return ret;
>  	}
> =20
> +	if (con->plug_altmode[0]) {
> +		num_plug_am =3D ucsi_get_num_altmode(con->plug_altmode);
> +		typec_plug_set_num_altmodes(con->plug, num_plug_am);
> +	} else {
> +		typec_plug_set_num_altmodes(con->plug, 0);
> +	}
> +
>  	return 0;
>  }
> =20
> --=20
> 2.44.0.769.g3c40516874-goog
>=20

--eJT88a/Gw6Jw6Zqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZifVyAAKCRBzbaomhzOw
wmzdAP4hLwx+iB6UOZExWPt/9/X7A4cZYouNkVFA1g9q1otaAwD/QZDPpf1OQo4e
hI75vwIXV5x7lzjWASoeMN7ptmzbMgE=
=rovc
-----END PGP SIGNATURE-----

--eJT88a/Gw6Jw6Zqe--

