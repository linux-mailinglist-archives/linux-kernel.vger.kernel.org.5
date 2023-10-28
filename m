Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8939B7DA50A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 05:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjJ1DfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 23:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJ1DfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 23:35:02 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A24106
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 20:34:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4197fa36b6aso19100601cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 20:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698464098; x=1699068898; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6/x/fWtOaMCDtHa2HFwP4K6azSwVNRlI6ZfSIipQI+w=;
        b=N0uJoAMwad5ZSUyHsFVK/Z3NCzi7gxmnaXLzsGaBwJmipCkWqNglEnV0I+PbZTMQCF
         lpbM6KGx5fIZCV0Du8mBE0d0NGg4PRu5nN0l3QlM2qzbF0ZyhHiEJ78LUtnCgrXfX+L8
         z9rrCmLyq2kqVB1Xyrn9VqXy1RoPodwE9pqfP6Fe/AY+1d4WsmBUd7xW/drwpJz/sIpT
         k9cyrXKUHJ6XkyfOycXi92WtgNz5CRhzpLEAs+Ay7WEoZm0MNqP0xIBIBZOr/mwxWazJ
         JHwcZA9VubACeQIUDJBMHNHCMAkQ4r1ge6naHE/Gi8fR4kHH4/0JSkXPYr1gPAX7Agie
         CuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698464098; x=1699068898;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/x/fWtOaMCDtHa2HFwP4K6azSwVNRlI6ZfSIipQI+w=;
        b=YeR7/1LnsitOntVPKMn+jFEry9mc/ZS07T6k6Yl7A0R45AjKilKJXbrChChD2Qw2yp
         qhZinQIfd8ihM2Ge+9YK7Bh/QneW/3Xtw12Aw2K6Cj4oubC+gGEcBajNrQbvNQJUmIqI
         slcgT3Chj70a53SIueCsLPnp9MQK58zymqfTeGPIuOtGXj1lv2BGRCmN6Nep52zL635e
         KtTN+IMIY/Z2TLirV4A77MdG3wRXPAaUEJcMWKoThigly8TYHIKtmC1tjklDUa0h1+EE
         wRZqm/Xhex8rmFa0Pu8An2SAvvahWCcL+q1Oa0MsFne2LiByYRfD1tx4aCJq/eOtEguE
         VOPQ==
X-Gm-Message-State: AOJu0YwdjRrm592VloxkWxb73+y7LNWqOeBliwZs6p0q8ib/vfbOE7p5
        QLxlf5vZSP1DGKWNcRQ4Fs4=
X-Google-Smtp-Source: AGHT+IE8g6YimTx10BSLo9Yy4GEHlhD/nInE3bokdtc7iKRPtYfN0BN/YgWszm9xujnJkIK0Yqqp3g==
X-Received: by 2002:ac8:5acb:0:b0:410:a088:38f5 with SMTP id d11-20020ac85acb000000b00410a08838f5mr4653718qtd.4.1698464098449;
        Fri, 27 Oct 2023 20:34:58 -0700 (PDT)
Received: from [192.168.2.14] ([64.231.246.137])
        by smtp.gmail.com with ESMTPSA id l15-20020ac84ccf000000b004198ae7f841sm1204214qtv.90.2023.10.27.20.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 20:34:57 -0700 (PDT)
Message-ID: <57c16f9d-44d9-4bc0-9d7d-8ff70b8135f0@gmail.com>
Date:   Fri, 27 Oct 2023 23:34:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.1
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
Content-Language: en-CA, en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     matthew.brost@intel.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, faith@gfxstrand.net,
        luben.tuikov@amd.com, christian.koenig@amd.com
References: <20231026161431.5934-1-dakr@redhat.com>
 <20231027091755.3635be36@collabora.com>
 <794f9b45-db0d-4261-aefe-7da2ad0ed3b7@redhat.com>
 <20231027182626.6a8ba090@collabora.com>
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
In-Reply-To: <20231027182626.6a8ba090@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9LL3U5XSr7bK8DAxLhm3pVsZ"
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------9LL3U5XSr7bK8DAxLhm3pVsZ
Content-Type: multipart/mixed; boundary="------------cBkC50s3CdthBKWq61ceOa2O";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@redhat.com>
Cc: matthew.brost@intel.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, faith@gfxstrand.net, luben.tuikov@amd.com,
 christian.koenig@amd.com
Message-ID: <57c16f9d-44d9-4bc0-9d7d-8ff70b8135f0@gmail.com>
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
References: <20231026161431.5934-1-dakr@redhat.com>
 <20231027091755.3635be36@collabora.com>
 <794f9b45-db0d-4261-aefe-7da2ad0ed3b7@redhat.com>
 <20231027182626.6a8ba090@collabora.com>
In-Reply-To: <20231027182626.6a8ba090@collabora.com>

--------------cBkC50s3CdthBKWq61ceOa2O
Content-Type: multipart/mixed; boundary="------------fJHrkKB5gFcyCdf2TrELsTEv"

--------------fJHrkKB5gFcyCdf2TrELsTEv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 2023-10-27 12:26, Boris Brezillon wrote:
> On Fri, 27 Oct 2023 16:34:26 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
>=20
>> On 10/27/23 09:17, Boris Brezillon wrote:
>>> Hi Danilo,
>>>
>>> On Thu, 26 Oct 2023 18:13:00 +0200
>>> Danilo Krummrich <dakr@redhat.com> wrote:
>>>  =20
>>>> +
>>>> +	/**
>>>> +	 * @update_job_credits: Called once the scheduler is considering t=
his
>>>> +	 * job for execution.
>>>> +	 *
>>>> +	 * Drivers may use this to update the job's submission credits, wh=
ich is
>>>> +	 * useful to e.g. deduct the number of native fences which have be=
en
>>>> +	 * signaled meanwhile.
>>>> +	 *
>>>> +	 * The callback must either return the new number of submission cr=
edits
>>>> +	 * for the given job, or zero if no update is required.
>>>> +	 *
>>>> +	 * This callback is optional.
>>>> +	 */
>>>> +	u32 (*update_job_credits)(struct drm_sched_job *sched_job); =20
>>>
>>> I'm copying my late reply to v2 here so it doesn't get lost:
>>>
>>> I keep thinking it'd be simpler to make this a void function that
>>> updates s_job->submission_credits directly. I also don't see the
>>> problem with doing a sanity check on job->submission_credits. I mean,=

>>> if the driver is doing something silly, you can't do much to prevent =
it
>>> anyway, except warn the user that something wrong has happened. If yo=
u
>>> want to
>>>
>>> 	WARN_ON(job->submission_credits =3D=3D 0 ||
>>> 		job->submission_credits > job_old_submission_credits);
>>>
>>> that's fine. But none of this sanity checking has to do with the
>>> function prototype/semantics, and I'm still not comfortable with this=
 0 =20
>>> =3D> no-change. If there's no change, we should just leave =20
>>> job->submission_credits unchanged (or return job->submission_credits)=

>>> instead of inventing a new special case. =20
>>
>> If we can avoid letting drivers change fields of generic structures di=
rectly
>> without any drawbacks I think we should avoid it. Currently, drivers s=
houldn't
>> have the need to mess with job->credits directly. The initial value is=
 set
>> through drm_sched_job_init() and is updated through the return value o=
f
>> update_job_credits().
>=20
> Fair enough. I do agree that keeping internal fields out of driver
> hands is a good thing in general, it's just that it's already
> free-for-all in so many places in drm_sched (like the fact drivers

"Free-for-all" doesn't mean we need to follow suit. We should keep
good programming practices, as this patch strives to.

> iterate the pending list in their stop-queue handling) that I didn't
> really see it as an issue. Note that's there's always the option of
> providing drm_sched_job_{update,get}_credits() helpers, with the update=

> helper making sure the new credits value is consistent (smaller or
> equal to the old one, and not zero).
>=20
>>
>> I'm fine getting rid of the 0 =3D> no-change semantics though. Instead=
 we can just
>> WARN() on 0.
>=20
> Yeah, I think that's preferable. It's pretty easy to return the old
> value if the driver has a way to detect when nothing changed (with a
> get helper if you don't want drivers to touch the credits field).
>=20
>> However, if we do that I'd also want to change it for
>> drm_sched_job_init() (where 0 currently defaults to 1) such that we ac=
cept 0, but
>> WARN() accordingly.
>=20
> Sure. You update all drivers anyway, so passing 1 instead of 0 is not a=

> big deal, I would say.

At this point in time, we should consider 1 as normal, 0 out of spec and
WARN on it but carry on and (perhaps) reset it to 1. Drivers in the futur=
e, may
see a need (i.e. do tricks) to return 0, at which point they'll submit a =
patch which
does two things, 1) removes the WARN, 2) removes the reset from 0 to 1, a=
nd
explain why they need to return 0 to allow (one more) job, but we're nowh=
ere near then yet,
so status quo for now.

I don't see how it makes sense to call drm_sched_job_init(credits:0), and=
 I believe
the code is correct to default to 1 in that case--which defaults to the c=
urrent
flow control we have, which we want.

>=20
>>
>> I think it's consequent to either consistently give 0 a different mean=
ing or just
>> accept it but WARN() on it.
>=20
> Using default as a default value makes sense when you're passing

I suppose you meant "using zero as a default value".

> zero-initialized objects that are later extended with new fields, but
> here you update the function prototype and all the call sites, so we're=

> better off considering 0 as an invalid value, IMHO.

Yes, absolutely.

You never want to give 0 a meaning, since as you pointed out, it is zero-=
ed
memory, and as such, can have any meaning you'd like. So yes: WARN on 0;
1 is good and normal.

Regards,
Luben

--------------fJHrkKB5gFcyCdf2TrELsTEv
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

--------------fJHrkKB5gFcyCdf2TrELsTEv--

--------------cBkC50s3CdthBKWq61ceOa2O--

--------------9LL3U5XSr7bK8DAxLhm3pVsZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZTyBWAUDAAAAAAAKCRBMFUeUMaM0r+GT
AQD5M+Vsy3/CC3u9EriJhgR5H2ey+pDNNLFNqHQ+tORdXwD+Js8yPnCsFXiztdQGYpLW51x6T1LF
gUB5jhbVJMmPvwo=
=e2F8
-----END PGP SIGNATURE-----

--------------9LL3U5XSr7bK8DAxLhm3pVsZ--
