Return-Path: <linux-kernel+bounces-19078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA0B826791
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 05:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CC9281CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E525660;
	Mon,  8 Jan 2024 04:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP+fXGqn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02707F;
	Mon,  8 Jan 2024 04:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-680d2ec3459so12618786d6.0;
        Sun, 07 Jan 2024 20:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704687432; x=1705292232; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=42H+8pLF3a4y4924hwnyHcgjfAQoJmqKFluj8FhzHCE=;
        b=QP+fXGqngyVuwyWgTyoGHe3WG8mLgWdIqPve8XRnUQ1IyD8hE/CONXpzIKrNucqQVi
         cG+1dV7bKETMD0RwwEmCexKsksAhIxnUfopvWKQDm9KKdWuasKJo7vDrwNhbpXPzorB+
         Vc7NWF81pvA8d2FCp/SLkvLqDVkZrSpr09/gneBACZxMgN855UD5xb1a47ZccQ5EdPCo
         7/eDXIx9nBGQX7aTs4APScGbSXRNst40JNoT70kxS3nq39WNzR0UBkxTkI1yu9DN2BMB
         KEASGhT2gD4Q5E8CQ7lr919Ray0jBjr39SVIKXcOB3euw9yw9c612r0pUKLibD/FUbay
         y2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704687432; x=1705292232;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42H+8pLF3a4y4924hwnyHcgjfAQoJmqKFluj8FhzHCE=;
        b=Bv+Wm8h4kVFpvk9IBCsnjeCdrXBLXNMGlVoCi/R1pre3Jf8R1MXO0ntgqvXxenIM7X
         K2o8MdMr4Sk84zuXTbWfPw1I5BVIqH8Hz7TFWJlrHgPlsDcCTo8b5uHjoWbYruIRT8Ju
         GUhVmw8CKoR9YV+bRh3AL2PUuSwd+6PDrjqyTrS3XAklaUjvI/k49OnAU7eEA7vD+L56
         j6kqED7zc0cCsP0k+zOokeuys+eF6qjvDyoSWkmJHm0OxJxZYdhr9otzMO2tL8EhB86W
         KQrAkQ/lIAVzL9XUYapI4Qn3jsS8MKgjrf9Pda+JMADtc9R6MsOZKlpHmNzGJ3TCytoY
         APtg==
X-Gm-Message-State: AOJu0YyiuPClHp+Y2ooy9XSrZ68YeJH6SxnjKYtvb/szSVPqbO3b5rxo
	5s0XmBuz3t5h5Pm3QjmrcH4=
X-Google-Smtp-Source: AGHT+IHBJd928t26adY7ajSfvXu37/R9j/Xx9a38JOv0M14cTLYRd7BO7EIjc3WeZk0LNrkjmllgpQ==
X-Received: by 2002:a05:6214:20aa:b0:681:962:b650 with SMTP id 10-20020a05621420aa00b006810962b650mr640676qvd.9.1704687431639;
        Sun, 07 Jan 2024 20:17:11 -0800 (PST)
Received: from [192.168.2.14] ([174.88.31.222])
        by smtp.gmail.com with ESMTPSA id mx20-20020a0562142e1400b0067f802d373bsm2557852qvb.89.2024.01.07.20.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 20:17:11 -0800 (PST)
Message-ID: <3fdc015b-33e5-4c10-88b0-964e95fb22b2@gmail.com>
Date: Sun, 7 Jan 2024 23:17:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.6.0
Subject: Re: [PATCH 2/2] drm/sched: Return an error code only as a constant in
 drm_sched_init()
Content-Language: en-CA, en-US
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
 <85f8004e-f0c9-42d9-8c59-30f1b4e0b89e@web.de>
From: Luben Tuikov <ltuikov89@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <85f8004e-f0c9-42d9-8c59-30f1b4e0b89e@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0OdjEfeS27b0xQjUbLwg8LPF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0OdjEfeS27b0xQjUbLwg8LPF
Content-Type: multipart/mixed; boundary="------------6aFc9OoRicXVkSLC0wSL3l6q";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Message-ID: <3fdc015b-33e5-4c10-88b0-964e95fb22b2@gmail.com>
Subject: Re: [PATCH 2/2] drm/sched: Return an error code only as a constant in
 drm_sched_init()
References: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
 <85f8004e-f0c9-42d9-8c59-30f1b4e0b89e@web.de>
In-Reply-To: <85f8004e-f0c9-42d9-8c59-30f1b4e0b89e@web.de>

--------------6aFc9OoRicXVkSLC0wSL3l6q
Content-Type: multipart/mixed; boundary="------------ucjVn0mqx7jv0wNqHN30m4Es"

--------------ucjVn0mqx7jv0wNqHN30m4Es
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-12-26 10:58, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 26 Dec 2023 16:37:37 +0100
>=20
> Return an error code without storing it in an intermediate variable.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thank you Markus for this patch.

Reviewed-by: Luben Tuikov <ltuikov89@gmail.com>

Pushed to drm-misc-next.
--=20
Regards,
Luben

> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> index b99d4e9ff109..1abbcdf38430 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1249,7 +1249,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sche=
d,
>  		   long timeout, struct workqueue_struct *timeout_wq,
>  		   atomic_t *score, const char *name, struct device *dev)
>  {
> -	int i, ret;
> +	int i;
>=20
>  	sched->ops =3D ops;
>  	sched->credit_limit =3D credit_limit;
> @@ -1285,7 +1285,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sche=
d,
>=20
>  		sched->own_submit_wq =3D true;
>  	}
> -	ret =3D -ENOMEM;
> +
>  	sched->sched_rq =3D kmalloc_array(num_rqs, sizeof(*sched->sched_rq),
>  					GFP_KERNEL | __GFP_ZERO);
>  	if (!sched->sched_rq)
> @@ -1321,7 +1321,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sche=
d,
>  	if (sched->own_submit_wq)
>  		destroy_workqueue(sched->submit_wq);
>  	drm_err(sched, "%s: Failed to setup GPU scheduler--out of memory\n", =
__func__);
> -	return ret;
> +	return -ENOMEM;
>  }
>  EXPORT_SYMBOL(drm_sched_init);
>=20
> --
> 2.43.0
>=20

--------------ucjVn0mqx7jv0wNqHN30m4Es
Content-Type: application/pgp-keys; name="OpenPGP_0x4C15479431A334AF.asc"
Content-Disposition: attachment; filename="OpenPGP_0x4C15479431A334AF.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1A
PnbnnRHNIkx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoA
QRYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiIC
BhUKCQgLAgQWAgMBAh4HAheAAAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlT
MqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfyJwktF7REl1yt7IU2Sye1qmQMfJxdt9JM
bMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSPcCE8uGe7FWo8C+nTSyWPXKTx
9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJl
OiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKoaMDzO9eG
z69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA=3D=3D
=3DqCaZ
-----END PGP PUBLIC KEY BLOCK-----

--------------ucjVn0mqx7jv0wNqHN30m4Es--

--------------6aFc9OoRicXVkSLC0wSL3l6q--

--------------0OdjEfeS27b0xQjUbLwg8LPF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZZt3RgUDAAAAAAAKCRBMFUeUMaM0r1Mm
AP9G375ycXDv/SdVEJRCDeXWTFESuUCs5KbEksQguSy8UAD+J8sH8QQOl1Ib2ADC2XrbF3RzIrqO
xtCJaap8RPtcjgw=
=cdoY
-----END PGP SIGNATURE-----

--------------0OdjEfeS27b0xQjUbLwg8LPF--

