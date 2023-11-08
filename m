Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722C07E501C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKHFql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjKHFqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:46:39 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18241706
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 21:46:36 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66cfc96f475so40986896d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 21:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699422395; x=1700027195; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zu1B8DgVQtJr4Wjq4F1030egCyGMUDlWnV/j6bqPL0Y=;
        b=XwFlpyY3zfKperW/0od1+QdPaJaG02kGS68HaBFxEkkBHECxRsUkaUSqVRzS2t4Exm
         MU4olmofp/S6C3PFoF9bcuhsBp7myKS4o5Qx4FKo4LY38MwJKIOXK5AuHNMh7Te2bOIX
         tL0oNKoPlML2UAqUAD5g+qQ8Y89YxvaUnqdXzx9BftUOKEzADNkNzep4tInGo0egkEyn
         oSWrj4woA6upQcvjefa7MHZIo8mZhlhCewlkvtJ+0aXVJCVjLLpXZ/HpiG8JKQw21tGS
         o3rpfO+AROLvxqvfIWinekfyWuFwTWMX2eO4r6zTvETdzjCKs0BLLLq0VAgiyEL7hocP
         njCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699422395; x=1700027195;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zu1B8DgVQtJr4Wjq4F1030egCyGMUDlWnV/j6bqPL0Y=;
        b=h+ZlPwGOtthHe85wrb86aJs5xGVNqoIjE7j0WPU04AbXcweOc6CFQtbxddtgSNUB74
         6WqZnrYblntmxzUS3p2/JX7QOeUcLCp7CtQyqH4n3hWYwwQ2peYsZfOPlXroDxbIYnrJ
         Tg5GpBQJxjENc0wcMSL2BGfaOYr7oX2QHxVYR6gMAeOB58OoxZkW1rbRqC2OTULIpqR4
         xTmIFHHthxdmhErETS+vy0NEnRCqSOH4hbNlVGckrbmuLJoGun4oGKj66qw+ebZq1DRt
         6WDCDiuRRtAT+DNQHTbCRd5YU1vfDJTKRXtI+EHe1Rk1dl9MBwIClEKYLlq2g/CVzsr6
         4xEA==
X-Gm-Message-State: AOJu0Yy48k2mh6G3S1flJHwyBcYk7Cy2kbNHkgesCMoRMiWi8spWtaUy
        bnQnm2mRda0icD64NJTR6cM=
X-Google-Smtp-Source: AGHT+IHSPhNJSTdi7vCBGKA2B216AXS7IN4kfyXHyaOB6H/fYImEHJU3OeOBAbdXfXm7HZ536x5aLA==
X-Received: by 2002:a05:6214:21aa:b0:66d:2e59:4fc2 with SMTP id t10-20020a05621421aa00b0066d2e594fc2mr931231qvc.40.1699422395494;
        Tue, 07 Nov 2023 21:46:35 -0800 (PST)
Received: from [192.168.2.14] ([74.15.198.235])
        by smtp.gmail.com with ESMTPSA id i10-20020ad4538a000000b00670bd5a3720sm709754qvv.97.2023.11.07.21.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 21:46:35 -0800 (PST)
Message-ID: <fff7a8db-be77-4c5e-a4dd-82b254adbb78@gmail.com>
Date:   Wed, 8 Nov 2023 00:46:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.2
Subject: Re: [PATCH] drm/sched: fix potential page fault in
 drm_sched_job_init()
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231108022716.15250-1-dakr@redhat.com>
Content-Language: en-CA, en-US
From:   Luben Tuikov <ltuikov89@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <20231108022716.15250-1-dakr@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UGdY5zLUPuElTkXAuNfJeVsk"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UGdY5zLUPuElTkXAuNfJeVsk
Content-Type: multipart/mixed; boundary="------------fOE005u163L7eTYwK9JuzEbe";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com, daniel@ffwll.ch,
 christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <fff7a8db-be77-4c5e-a4dd-82b254adbb78@gmail.com>
Subject: Re: [PATCH] drm/sched: fix potential page fault in
 drm_sched_job_init()
References: <20231108022716.15250-1-dakr@redhat.com>
In-Reply-To: <20231108022716.15250-1-dakr@redhat.com>

--------------fOE005u163L7eTYwK9JuzEbe
Content-Type: multipart/mixed; boundary="------------VB0Zul1e8VgVc0hPoacCCzse"

--------------VB0Zul1e8VgVc0hPoacCCzse
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Could you please use my gmail address, the one one I'm responding from--I=
 don't want
to miss any DRM scheduler patches. BTW, the luben.tuikov@amd.com email sh=
ould bounce
as undeliverable.

On 2023-11-07 21:26, Danilo Krummrich wrote:
> Commit 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable
> number of run-queues") introduces drm_err() in drm_sched_job_init(), in=

> order to indicate that the given entity has no runq, however at this
> time job->sched is not yet set, likely to be NULL initialized, and henc=
e
> shouldn't be used.
>=20
> Replace the corresponding drm_err() call with pr_err() to avoid a
> potential page fault.
>=20
> While at it, extend the documentation of drm_sched_job_init() to
> indicate that job->sched is not a valid pointer until
> drm_sched_job_arm() has been called.
>=20
> Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable =
number of run-queues")
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> index 27843e37d9b7..dd28389f0ddd 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -680,6 +680,9 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>   * This function returns -ENOENT in this case (which probably should b=
e -EIO as
>   * a more meanigful return value).
>   *
> + * Note that job->sched is not a valid pointer until drm_sched_job_arm=
() has
> + * been called.
> + *

Good catch!

Did you actually get this to page-fault and have a kernel log?

I'm asking because we see it correctly set in this kernel log coming from=
 AMD,

[   11.886024] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init: ent=
ity has no rq!

in this email,
https://lore.kernel.org/r/CADnq5_PS64jYS_Y3kGW27m-kuWP+FQFiaVcOaZiB=3DJLS=
gPnXBQ@mail.gmail.com

>   * Returns 0 for success, negative error code otherwise.
>   */
>  int drm_sched_job_init(struct drm_sched_job *job,
> @@ -691,7 +694,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
>  		 * or worse--a blank screen--leave a trail in the
>  		 * logs, so this can be debugged easier.
>  		 */
> -		drm_err(job->sched, "%s: entity has no rq!\n", __func__);
> +		pr_err("%s: entity has no rq!\n", __func__);

Is it feasible to do something like the following?

		dev_err(job->sched ? job->sched->dev : NULL, "%s: entity has no rq!\n",=
 __func__);

>  		return -ENOENT;
>  	}
> =20
>=20
> base-commit: c015fb6d01adb616fb54824feb55ce5ab18e8ca1

--=20
Regards,
Luben

--------------VB0Zul1e8VgVc0hPoacCCzse
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

--------------VB0Zul1e8VgVc0hPoacCCzse--

--------------fOE005u163L7eTYwK9JuzEbe--

--------------UGdY5zLUPuElTkXAuNfJeVsk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZUsgsgUDAAAAAAAKCRBMFUeUMaM0r4Ux
AP42XIcikJp3Nof/hM8PI5NaV+fNoMP8oaHTGmZXkpmfBgD/Y/zLX+NrSNZasdqC2wV2ctqBcWdP
sQVN0bTo3fJzTQY=
=XOK3
-----END PGP SIGNATURE-----

--------------UGdY5zLUPuElTkXAuNfJeVsk--
