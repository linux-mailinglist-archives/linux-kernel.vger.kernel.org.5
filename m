Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858677E7684
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbjKJBZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345580AbjKJBZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:25:18 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F1244A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:25:15 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-777745f1541so101199785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 17:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699579514; x=1700184314; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EpUnJqiUGSLxpIVZCLs3iuc/qoT2JsrHayU5aHdmSgw=;
        b=H4p94s4E2h4rlQcZumdsH1DVFRg878a+3CAVuiEvT50Upm+L0DKmw3+QSiOV2X4J8g
         +S8g+3ww0Av2TJ8r3+zzqS8rAe0GenfnyugZ2k+0+pXSVOL8YRA6rg+sZnogPiOGx+xo
         nu69A3OuDc1NsCPse4o8qOu9XcbzMewhMFd3kwPxl53Y8X0EEah8QdmEYQjLtWgrVLpY
         gkJ7LSrd8yED4r3fNUmPIiskZAtPv0+wM+NAqvv48o1TyVK/2Ly+RctGo7lRcpS1+CnW
         8RnOlrHGQntwiKzbL2qb1EccdRMjKHQ73VfVHFWcaSdtXJS/m9VWaFFBOfrHYLzDkKhb
         rgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699579514; x=1700184314;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpUnJqiUGSLxpIVZCLs3iuc/qoT2JsrHayU5aHdmSgw=;
        b=WSu3QD0Kvw8sMvKqcesjINxxouhgKN/z1n3Amn6wovujKHpcd100he+l9Tdcz6HAnL
         k96EOjlVzmMulqQ9neBNM1cJ6umOf6/0Hk4VXUW7uhQBcqV6PucYs3Ko8u5NswD7xeba
         h2iND//tACeeGs7RerlSFww06DvJJmMs8pTfr7WWniMltE7sZNkA1Abg/4a2b5Y8j1Fd
         QxmAhnTwrcoIl5usQkB/reZOc7bwnYOI0ktCjI9PNLPfcO2T7Q5a3OZ4jjPmXaWwypto
         UnXUZvlluAaUY/yQHnJmEJZCKXFzA10EcCTGgXKtbtSpFYp9ptYJoiYG03sQ9xNrNb1A
         5JSw==
X-Gm-Message-State: AOJu0YxCepGKAtmQCJit3lP3jCNj9xZXG64F3mb8NN6qpzCVU+4Byu4H
        hQsEadvWcA7+TNFvl10WYO8=
X-Google-Smtp-Source: AGHT+IFtn34MZGOJTJPoUlS84mWDoS7tZj77ECGknkw0pwVUPjcpnDLuAHDZjQKn2w0ODzoMCoyY0A==
X-Received: by 2002:a05:620a:944b:b0:776:5135:d96d with SMTP id sm11-20020a05620a944b00b007765135d96dmr4957508qkn.69.1699579513829;
        Thu, 09 Nov 2023 17:25:13 -0800 (PST)
Received: from [192.168.2.14] ([76.65.20.140])
        by smtp.gmail.com with ESMTPSA id c12-20020a05620a11ac00b007756c8ce8f5sm340439qkk.59.2023.11.09.17.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 17:25:13 -0800 (PST)
Message-ID: <42d3b0c0-bad6-4ac2-b755-6cbfc5ec5524@gmail.com>
Date:   Thu, 9 Nov 2023 20:25:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.2
Subject: Re: [PATCH drm-misc-next v6] drm/sched: implement dynamic job-flow
 control
Content-Language: en-CA, en-US
From:   Luben Tuikov <ltuikov89@gmail.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        boris.brezillon@collabora.com, christian.koenig@amd.com,
        faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231110001638.71750-1-dakr@redhat.com>
 <e2ec5036-81bd-490b-bdc2-fc215e14b8b1@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <e2ec5036-81bd-490b-bdc2-fc215e14b8b1@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bPvpcKrN0Yc0NcbiEaGlhd20"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bPvpcKrN0Yc0NcbiEaGlhd20
Content-Type: multipart/mixed; boundary="------------kgLzOj4RzCBhSFeyZnEhB2ij";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com, daniel@ffwll.ch,
 matthew.brost@intel.com, boris.brezillon@collabora.com,
 christian.koenig@amd.com, faith@gfxstrand.net
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <42d3b0c0-bad6-4ac2-b755-6cbfc5ec5524@gmail.com>
Subject: Re: [PATCH drm-misc-next v6] drm/sched: implement dynamic job-flow
 control
References: <20231110001638.71750-1-dakr@redhat.com>
 <e2ec5036-81bd-490b-bdc2-fc215e14b8b1@gmail.com>
In-Reply-To: <e2ec5036-81bd-490b-bdc2-fc215e14b8b1@gmail.com>

--------------kgLzOj4RzCBhSFeyZnEhB2ij
Content-Type: multipart/mixed; boundary="------------E8VXvVACxyfdc08ijFfa0Jwv"

--------------E8VXvVACxyfdc08ijFfa0Jwv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-09 19:57, Luben Tuikov wrote:
> On 2023-11-09 19:16, Danilo Krummrich wrote:
[snip]
>> @@ -667,6 +771,8 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>>   * drm_sched_job_init - init a scheduler job
>>   * @job: scheduler job to init
>>   * @entity: scheduler entity to use
>> + * @credits: the number of credits this job contributes to the schedu=
lers
>> + * credit limit
>>   * @owner: job owner for debugging
>>   *
>>   * Refer to drm_sched_entity_push_job() documentation
>> @@ -684,7 +790,7 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>>   */
>>  int drm_sched_job_init(struct drm_sched_job *job,
>>  		       struct drm_sched_entity *entity,
>> -		       void *owner)
>> +		       u32 credits, void *owner)
>>  {
>>  	if (!entity->rq) {
>>  		/* This will most likely be followed by missing frames
>> @@ -695,7 +801,11 @@ int drm_sched_job_init(struct drm_sched_job *job,=

>>  		return -ENOENT;
>>  	}
>> =20
>> +	if (unlikely(!credits))
>> +		return -EINVAL;
>> +
>=20
> This will most likely result in bad user experience (read: blank screen=
),
> and debugging this would be really hard without something to go by
> in the kernel log.
>=20
> (This was exactly the case with amdgpu when 56e449603f0ac5
> ("drm/sched: Convert the GPU scheduler to variable number of run-queues=
")=20
> was being worked on and merged. Without the drm_err() on missing rq in
> the lines immediately before the hunk above returning -ENOENT, there
> was no indication why setting up an fb was failing very early on (blank=
 screen).)
>=20
> So it is best to print a "[drm] *ERROR* "-equivalent string in the logs=
,
> so that we can make a note of this, without relying on drivers, old and=
 new, logging
> that drm_sched_job_init() failed.

If you add _exactly_ this,

	if (unlikely(!credits)) {
		pr_err("*ERROR* %s: credits cannot be 0!\n", __func__)
		return -EINVAL;
	}

You can add my,

Reviewed-by: Luben Tuikov <ltuikov89@gmail.com>

and push it.
--=20
Regards,
Luben

--------------E8VXvVACxyfdc08ijFfa0Jwv
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

--------------E8VXvVACxyfdc08ijFfa0Jwv--

--------------kgLzOj4RzCBhSFeyZnEhB2ij--

--------------bPvpcKrN0Yc0NcbiEaGlhd20
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZU2GcAUDAAAAAAAKCRBMFUeUMaM0r53R
AP4m/2BjdiWwu8IVlgMIUrqMF3AM/9iDocTx2+iMM4NYTQEA2dsqYHnnTHFYCAsDILyTssactkuL
aFOznk95n6x1NQU=
=WX/n
-----END PGP SIGNATURE-----

--------------bPvpcKrN0Yc0NcbiEaGlhd20--
