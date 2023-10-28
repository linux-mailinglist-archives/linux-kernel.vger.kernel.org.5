Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB4D7DA50D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 05:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjJ1Dhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 23:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJ1Dhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 23:37:54 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F1B11F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 20:37:50 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d76904928so18069536d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 20:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698464269; x=1699069069; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6sxFci3204DARfNl7G2N7esVdiS4OFPlTEl/0ZVjaUM=;
        b=iRsMMxfajOy3Ts9BqaLEAxspbWaTCtp9M9rvRIYPvsV64Oncckmk4r7WO0DHjOjts2
         W47juHXGsIWOVHPyhnEtBW7m0lidsxD2cmXjXixvmTBZNmeeJYtz1cYK5SigeJtvBqI8
         /e0rbMwxP7jsjQKhN94yqClv3SihXkzYS0WOnusl8X7fLGkSNkB3aAxzSyy2NapMan0E
         BMbkRLnHxnMfdtsxw7cIfYLC+hOKO3r91tj7iF9qFmxc2T1zRBjrFqyX/nsyJdo48mMh
         UPOfwcY2GEnTFmqjO9v8OFmKMMLGH8AM36NryuMRlHvojaX3KB+257mk6sEoRDtxs2tC
         Ae2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698464269; x=1699069069;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sxFci3204DARfNl7G2N7esVdiS4OFPlTEl/0ZVjaUM=;
        b=ByMng+aITimbQPYcpuRosIhQdq/QxOS1AmEGkAqE69f6Ow0sPPjxMQgSAqt1Gdca/+
         KxF3LD8sx6tMnneNMlkxhDpTyMiyhUtIudvf1jeiNmQtGpMDg9Wa+Sy/wlBHKBrTtDks
         FXPsCpp9CmSGrEWV1QAqilYrl2X+aVrWgX4U5cg4HgdsTLk+qPEt5MoFIzmQyxOoWtjQ
         Xo5yaa5yAPIVPdoCqilwqutJe0msjJhweWeh5Xymji+nl5XIOZOII+tuXtcIU5gy8Rxg
         o9Y7okGHj6Fh/mX5YaV0UBDFnY+nnlSxg+fnt2zTwP+ABvujMCBSkm6Y4tVFfYjRdoMQ
         zhgg==
X-Gm-Message-State: AOJu0YwQ7yk0cIDcvWKOuglsrtsOvcqsl8J6+6xnREpiKDNyKZJH1Kwn
        7x27GU6XCcoxjLHivYQARgn/TAxf8wLxFhcIH7c=
X-Google-Smtp-Source: AGHT+IHmYLmhAgnBciR1pWpU+FB7W9fmmrurqtDITcvxmU5SBkw4FUvN4RKHFikttfpjJyDvma3u+Q==
X-Received: by 2002:ad4:5bab:0:b0:66f:ae60:8c51 with SMTP id 11-20020ad45bab000000b0066fae608c51mr6035257qvq.11.1698464269428;
        Fri, 27 Oct 2023 20:37:49 -0700 (PDT)
Received: from [192.168.2.14] ([64.231.246.137])
        by smtp.gmail.com with ESMTPSA id l11-20020ad4408b000000b0066cfadfb796sm1198714qvp.107.2023.10.27.20.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 20:37:49 -0700 (PDT)
Message-ID: <a6405799-23bc-49f3-a526-bb4b10ae4b99@gmail.com>
Date:   Fri, 27 Oct 2023 23:37:40 -0400
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
 <20231027102516.0e4b00ef@collabora.com>
 <8e117f9f-a01c-4242-8781-b2ed4969513b@redhat.com>
 <20231027183158.2dc4cce4@collabora.com>
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
In-Reply-To: <20231027183158.2dc4cce4@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eErwffIILQ9RM7zYxqImmKSy"
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
--------------eErwffIILQ9RM7zYxqImmKSy
Content-Type: multipart/mixed; boundary="------------Cyw5V0O07cph60p3kgB5bh45";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@redhat.com>
Cc: matthew.brost@intel.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, faith@gfxstrand.net, luben.tuikov@amd.com,
 christian.koenig@amd.com
Message-ID: <a6405799-23bc-49f3-a526-bb4b10ae4b99@gmail.com>
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
References: <20231026161431.5934-1-dakr@redhat.com>
 <20231027102516.0e4b00ef@collabora.com>
 <8e117f9f-a01c-4242-8781-b2ed4969513b@redhat.com>
 <20231027183158.2dc4cce4@collabora.com>
In-Reply-To: <20231027183158.2dc4cce4@collabora.com>

--------------Cyw5V0O07cph60p3kgB5bh45
Content-Type: multipart/mixed; boundary="------------b5TOUiOKkU5vnp0t4wN2Wo3M"

--------------b5TOUiOKkU5vnp0t4wN2Wo3M
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-10-27 12:31, Boris Brezillon wrote:
> On Fri, 27 Oct 2023 16:23:24 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
>=20
>> On 10/27/23 10:25, Boris Brezillon wrote:
>>> Hi Danilo,
>>>
>>> On Thu, 26 Oct 2023 18:13:00 +0200
>>> Danilo Krummrich <dakr@redhat.com> wrote:
>>>  =20
>>>> Currently, job flow control is implemented simply by limiting the nu=
mber
>>>> of jobs in flight. Therefore, a scheduler is initialized with a cred=
it
>>>> limit that corresponds to the number of jobs which can be sent to th=
e
>>>> hardware.
>>>>
>>>> This implies that for each job, drivers need to account for the maxi=
mum
>>>> job size possible in order to not overflow the ring buffer.
>>>>
>>>> However, there are drivers, such as Nouveau, where the job size has =
a
>>>> rather large range. For such drivers it can easily happen that job
>>>> submissions not even filling the ring by 1% can block subsequent
>>>> submissions, which, in the worst case, can lead to the ring run dry.=

>>>>
>>>> In order to overcome this issue, allow for tracking the actual job s=
ize
>>>> instead of the number of jobs. Therefore, add a field to track a job=
's
>>>> credit count, which represents the number of credits a job contribut=
es
>>>> to the scheduler's credit limit.
>>>>
>>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>>> ---
>>>> Changes in V2:
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>    - fixed up influence on scheduling fairness due to consideration =
of a job's
>>>>      size
>>>>      - If we reach a ready entity in drm_sched_select_entity() but c=
an't actually
>>>>        queue a job from it due to size limitations, just give up and=
 go to sleep
>>>>        until woken up due to a pending job finishing, rather than co=
ntinue to try
>>>>        other entities.
>>>>    - added a callback to dynamically update a job's credits (Boris) =
=20
>>>
>>> This callback seems controversial. I'd suggest dropping it, so the
>>> patch can be merged. =20
>>
>> I don't think we should drop it just for the sake of moving forward. I=
f there are objections
>> we'll discuss them. I've seen good reasons why the drivers you are wor=
king on require this,
>> while, following the discussion, I have *not* seen any reasons to drop=
 it. It helps simplifying
>> driver code and doesn't introduce any complexity or overhead to existi=
ng drivers.
>=20
> Up to you. I'm just saying, moving one step in the right direction is
> better than being stuck, and it's not like adding this callback in a
> follow-up patch is super complicated either. If you're confident that
> we can get all parties to agree on keeping this hook, fine by me.

I'd rather have it in now, as it is really *the vision* of this patch. Th=
ere's no point
in pushing in something half-baked.
--=20
Regards,
Luben
--------------b5TOUiOKkU5vnp0t4wN2Wo3M
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

--------------b5TOUiOKkU5vnp0t4wN2Wo3M--

--------------Cyw5V0O07cph60p3kgB5bh45--

--------------eErwffIILQ9RM7zYxqImmKSy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZTyCBAUDAAAAAAAKCRBMFUeUMaM0rx0W
APwIdBw9Qnmcs068xXCtVJetNER6MsLx50TxtZnWXJqyvwD+PFDELZEPfRb8eRSHaleIraGHufLg
vGxcEKyzLA06kwk=
=VbPL
-----END PGP SIGNATURE-----

--------------eErwffIILQ9RM7zYxqImmKSy--
