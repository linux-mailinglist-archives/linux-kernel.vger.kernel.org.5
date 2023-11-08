Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4E7E5061
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjKHGdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHGdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:33:45 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8794125
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:33:43 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-778a6c440faso351780785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 22:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699425223; x=1700030023; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D4fspm/G6oUo5hBXfZIhKs10KuHqVXOiO80KDvdhrSs=;
        b=bC3DEX9Q8gnZ7JN4zI4toqTW8swJQ8Bd6D4+51K2ENqBStYuQMZxkzKN0YqpQnJPF6
         XqkekgCQV1Jbt0ugI3ekEIcRWQODPMvFdjNkp2EGKWSwuq2WdZuavhG8quRAF8dwsWNI
         TKKTBgnsdaawNv4VBaNMY2PXCfBFqOhL34DDXTP0IrVJoYZqEssctsBsoGkXoald6B/O
         94nxAJdlVwFHMhyBTWI5pf+Mc8baBEXIDBVQEGyJE40nkBsxQAMI2c46aUxU6s2fVwms
         4pbE1VK7QYU04sH2s5ic1en311iN9fSDj5s/aPZP3NBxOEeL5ER1IqJ+Cp8iFg58vIaU
         FEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699425223; x=1700030023;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4fspm/G6oUo5hBXfZIhKs10KuHqVXOiO80KDvdhrSs=;
        b=ZPXvH65DhXrDcfvPK6SDai8hRjSllsjcjGoeDXQXt5i54N2XmXOOBva4mkmoT4b5DW
         f+dQfVlWHdlFO8VW5WOiBkJSzyS3ykMiuXD6QBdVSBgnKMgzyyxkJ7uCRqPcIjkYXXy7
         VvCvJlndBQqdcbaY7mXdglJjRMMvZ8f+kmjfP6IxoaiB3gHPnIpK9m3+9Os3AdvMKMXC
         5VuvcrDa8Pn305AaXDqtAD79DLA/qkNOJOIoo6zsBQfi3UBu1TQvl/vsvXkveEZr5BYz
         pyEGRrKXkYFvdFNvX3igpJ+NJbCO9YcE0N1LTCBxkHXB/iedHfLFXZsG+3EzOkdH7c/A
         iBLg==
X-Gm-Message-State: AOJu0Yy1VUiBZVYIViN5IXisR2DRDGeTliK+Dq1GkAnP78w3N4Ew6t/S
        IpG6erxRZc3+AXHMs9DcAc4=
X-Google-Smtp-Source: AGHT+IFm6eFEWDrr4WNEB8QDJdZvA2zNS13Rw2yOdaTtOOwT9dAIdOOsmfGvkLp0a4eFQjFKj9TWjg==
X-Received: by 2002:a05:620a:2454:b0:777:3c2:31da with SMTP id h20-20020a05620a245400b0077703c231damr840761qkn.5.1699425222791;
        Tue, 07 Nov 2023 22:33:42 -0800 (PST)
Received: from [192.168.2.14] ([74.15.198.235])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a004f00b007788c1a81b6sm718288qkt.46.2023.11.07.22.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 22:33:42 -0800 (PST)
Message-ID: <34b79d87-103e-4951-a976-761e2aa50ce3@gmail.com>
Date:   Wed, 8 Nov 2023 01:33:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.2
Subject: Re: [PATCH] drm/sched: fix potential page fault in
 drm_sched_job_init()
Content-Language: en-CA, en-US
From:   Luben Tuikov <ltuikov89@gmail.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231108022716.15250-1-dakr@redhat.com>
 <fff7a8db-be77-4c5e-a4dd-82b254adbb78@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <fff7a8db-be77-4c5e-a4dd-82b254adbb78@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2A8997NNQjZ2rshFP15jFi1t"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2A8997NNQjZ2rshFP15jFi1t
Content-Type: multipart/mixed; boundary="------------Y4eBK5Lzwu60j80WbUHWDqUC";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com, daniel@ffwll.ch,
 christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <34b79d87-103e-4951-a976-761e2aa50ce3@gmail.com>
Subject: Re: [PATCH] drm/sched: fix potential page fault in
 drm_sched_job_init()
References: <20231108022716.15250-1-dakr@redhat.com>
 <fff7a8db-be77-4c5e-a4dd-82b254adbb78@gmail.com>
In-Reply-To: <fff7a8db-be77-4c5e-a4dd-82b254adbb78@gmail.com>

--------------Y4eBK5Lzwu60j80WbUHWDqUC
Content-Type: multipart/mixed; boundary="------------RgKWDqaJgRJJrrut0FVKEXnz"

--------------RgKWDqaJgRJJrrut0FVKEXnz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-08 00:46, Luben Tuikov wrote:
> Hi,
>=20
> Could you please use my gmail address, the one one I'm responding from-=
-I don't want
> to miss any DRM scheduler patches. BTW, the luben.tuikov@amd.com email =
should bounce
> as undeliverable.
>=20
> On 2023-11-07 21:26, Danilo Krummrich wrote:
>> Commit 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable=

>> number of run-queues") introduces drm_err() in drm_sched_job_init(), i=
n
>> order to indicate that the given entity has no runq, however at this
>> time job->sched is not yet set, likely to be NULL initialized, and hen=
ce
>> shouldn't be used.
>>
>> Replace the corresponding drm_err() call with pr_err() to avoid a
>> potential page fault.
>>
>> While at it, extend the documentation of drm_sched_job_init() to
>> indicate that job->sched is not a valid pointer until
>> drm_sched_job_arm() has been called.
>>
>> Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable=
 number of run-queues")
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>  drivers/gpu/drm/scheduler/sched_main.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/=
scheduler/sched_main.c
>> index 27843e37d9b7..dd28389f0ddd 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -680,6 +680,9 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>>   * This function returns -ENOENT in this case (which probably should =
be -EIO as
>>   * a more meanigful return value).
>>   *
>> + * Note that job->sched is not a valid pointer until drm_sched_job_ar=
m() has
>> + * been called.
>> + *
>=20
> Good catch!
>=20
> Did you actually get this to page-fault and have a kernel log?
>=20
> I'm asking because we see it correctly set in this kernel log coming fr=
om AMD,
>=20
> [   11.886024] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init: e=
ntity has no rq!
>=20
> in this email,
> https://lore.kernel.org/r/CADnq5_PS64jYS_Y3kGW27m-kuWP+FQFiaVcOaZiB=3DJ=
LSgPnXBQ@mail.gmail.com
>=20
>>   * Returns 0 for success, negative error code otherwise.
>>   */
>>  int drm_sched_job_init(struct drm_sched_job *job,
>> @@ -691,7 +694,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
>>  		 * or worse--a blank screen--leave a trail in the
>>  		 * logs, so this can be debugged easier.
>>  		 */
>> -		drm_err(job->sched, "%s: entity has no rq!\n", __func__);
>> +		pr_err("%s: entity has no rq!\n", __func__);
>=20
> Is it feasible to do something like the following?
>=20
> 		dev_err(job->sched ? job->sched->dev : NULL, "%s: entity has no rq!\n=
", __func__);

Sorry, that was meant to be like this to make the print look just like th=
e original,

		dev_err(job->sched ? job->sched->dev : NULL, "[drm] *ERROR* %s: entity =
has no rq!\n", __func__);

>=20
>>  		return -ENOENT;
>>  	}
>> =20
>>
>> base-commit: c015fb6d01adb616fb54824feb55ce5ab18e8ca1
>=20

--=20
Regards,
Luben

--------------RgKWDqaJgRJJrrut0FVKEXnz
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

--------------RgKWDqaJgRJJrrut0FVKEXnz--

--------------Y4eBK5Lzwu60j80WbUHWDqUC--

--------------2A8997NNQjZ2rshFP15jFi1t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZUsrvQUDAAAAAAAKCRBMFUeUMaM0r/vA
AQCo0slYi4yKLqc8+wHKlRRqzg5yn+s2Dlp43RvutWnPCwD+Jmw209JXfmpHsghuLRu1StsPAmYw
eGR756knZXVUXQs=
=2qvU
-----END PGP SIGNATURE-----

--------------2A8997NNQjZ2rshFP15jFi1t--
