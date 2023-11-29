Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8AB7FCE07
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376909AbjK2EpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjK2EpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:45:02 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0BE19AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:45:08 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67a38e506c4so18397816d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701233107; x=1701837907; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d7Y0qZNLFICjLrmGifWVjYtYxOxOp0Zj6BSl0M+oReQ=;
        b=D8pgiaKdlRiXMA3oK8kz8Z10VnX/bz4ah0DcIRXSbMDpiMvZ4LG/1IG3cyzfQ7qOL6
         eafq/Sn+JX9jLdq1JCqCY7tekj3OQDIgb/Ng/nYqj72fy3XQrd51veNGdApxKNR6pIhC
         NVno1q1AEaXu812k7Y4VeHNdcWfl6T+vi2xD4gtVcKoypH5JV/IP9AROmJ2eQNRH2NJ3
         hlgkQ7pZgeBtjQrBVKhkZ9A7r30T1vL2F9uNDAPx8zXrK3wrvxnTj5q42GLTqkdLsFij
         WJ5pSmwH6Iuu9yjPLmebmGxQ/P/wN+o6lu76oSsy277Uhi+LhmdypKmA6rdvXEnYoKW9
         ixcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701233107; x=1701837907;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7Y0qZNLFICjLrmGifWVjYtYxOxOp0Zj6BSl0M+oReQ=;
        b=eyfOih5QKwjjpezjx1XtbXOuUR0MuR4ATzc6CpzR0Mg8KwEsYG0p3NKDI4sKfz0Zea
         oisDVheVhHfvfi54UlyCqQx/tp+7E6z1q/f3ja/vxWxJecfvF/6pqqfNEDKgoW+EnVfo
         gB3yW5QZ5pd49bABOCa1ZYMqDLkyAdqgvpOe6KRn+lRM4dbBu/4IjLAWLrxP04/tEfQz
         /NIkAZVBzFVIPlenqVyEWqnjrlaDsEVDu9ygJe5G+8JFNYA57ZYBXeXi4GdKFGtHCEDf
         YrnysqVHqXvtufQy6KIdXTfMIKXoItLHTVHfB7embZNjnmnKQ4i8Kf4I9rnZQ9+FCdCZ
         2n+g==
X-Gm-Message-State: AOJu0YzJ9UDZzVItUbZALCSgZqSkXiHtIN6UGennHHXyJqGVpdg9LwID
        ANyG0jTZnIeGyE2kWRvi3IQ=
X-Google-Smtp-Source: AGHT+IGuTwbMcogkXsTn/hgaHHthLzunhkCa/ta+F0yax0RoSK2iaf26YLDOyUGXPYctUebz/mtuJA==
X-Received: by 2002:a05:6214:104f:b0:67a:f89:22e5 with SMTP id l15-20020a056214104f00b0067a0f8922e5mr19243475qvr.3.1701233107388;
        Tue, 28 Nov 2023 20:45:07 -0800 (PST)
Received: from [192.168.2.14] ([76.65.20.140])
        by smtp.gmail.com with ESMTPSA id y10-20020a056214016a00b0067a53aa6df2sm1604358qvs.46.2023.11.28.20.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 20:45:06 -0800 (PST)
Message-ID: <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com>
Date:   Tue, 28 Nov 2023 23:44:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.5.0
Subject: Re: Radeon regression in 6.6 kernel
Content-Language: en-CA, en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        Phillip Susi <phill@thesusis.net>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        ltuikov89@gmail.com
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
 <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com>
 <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net>
 <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
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
In-Reply-To: <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------B9KvWMDdbyeGAXg0IZipz9I3"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------B9KvWMDdbyeGAXg0IZipz9I3
Content-Type: multipart/mixed; boundary="------------zdhIbyuVIrAPRu0RHztAccg6";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>, Phillip Susi <phill@thesusis.net>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-kernel@vger.kernel.org,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 ltuikov89@gmail.com
Message-ID: <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com>
Subject: Re: Radeon regression in 6.6 kernel
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
 <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com>
 <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net>
 <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
In-Reply-To: <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>

--------------zdhIbyuVIrAPRu0RHztAccg6
Content-Type: multipart/mixed; boundary="------------sNB7zEQc118Idxyi1MymNAMe"

--------------sNB7zEQc118Idxyi1MymNAMe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-28 17:13, Alex Deucher wrote:
> On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@thesusis.ne=
t> wrote:
>>
>> Alex Deucher <alexdeucher@gmail.com> writes:
>>
>>>> In that case those are the already known problems with the scheduler=

>>>> changes, aren't they?
>>>
>>> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'm
>>> misunderstanding what the original report was actually testing.  If i=
t
>>> was 6.7, then try reverting:
>>> 56e449603f0ac580700621a356d35d5716a62ce5
>>> b70438004a14f4d0f9890b3297cd66248728546c
>>
>> At some point it was suggested that I file a gitlab issue, but I took
>> this to mean it was already known and being worked on.  -rc3 came out
>> today and still has the problem.  Is there a known issue I could track=
?
>>
>=20
> At this point, unless there are any objections, I think we should just
> revert the two patches
Uhm, no.

Why "the two" patches?

This email, part of this thread,

https://lore.kernel.org/all/87r0kircdo.fsf@vps.thesusis.net/

clearly states that reverting *only* this commit,
56e449603f0ac5 drm/sched: Convert the GPU scheduler to variable number of=
 run-queues
*does not* mitigate the failed suspend. (Furthermore, this commit doesn't=
 really change
anything operational, other than using an allocated array, instead of a s=
tatic one, in DRM,
while the 2nd patch is solely contained within the amdgpu driver code.)

Leaving us with only this change,
b70438004a14f4 drm/amdgpu: move buffer funcs setting up a level
to be at fault, as the kernel log attached in the linked email above show=
s.

The conclusion is that only b70438004a14f4 needs reverting.
--=20
Regards,
Luben

--------------sNB7zEQc118Idxyi1MymNAMe
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

--------------sNB7zEQc118Idxyi1MymNAMe--

--------------zdhIbyuVIrAPRu0RHztAccg6--

--------------B9KvWMDdbyeGAXg0IZipz9I3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZWbByQUDAAAAAAAKCRBMFUeUMaM0r6jz
AP4zTPvRhz6Cv17QqsLz2rphQRnP0Y53BGjckIVgs/JMUAD/R/QYTr1qhzapp2VOHTym3teg3yR4
P0cKURfARvAUOw0=
=1QtL
-----END PGP SIGNATURE-----

--------------B9KvWMDdbyeGAXg0IZipz9I3--
