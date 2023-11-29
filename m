Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18547FDD74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjK2Qlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2Qlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:41:49 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF7884
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:41:52 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41cd97d7272so37888941cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701276111; x=1701880911; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fjs3Okyq9EWbreP6AOnF4Rr0g4Cepv9m/ouV8NW/+O4=;
        b=aLO/03p96Mk4mQbpxqK4cE+4FN+3FVe9RhanazpCe+bA4OMFAJMFiEUTXjkSyvaGHb
         r0veVp7wWS2lsocPiRxPbrv1nuBHWJZzrMveQDUMyJ1EW78Gv1D4zD25Wi6GXGDCwrCk
         pmxQCN8wav9vOJBfbN0mrBngRIBugcRtP5I81A614YfG97k9o1nLHKS5i8Lo4NkucG0S
         Iy5WOKR/NihG2sAiwME9D6H5qYW9Lv4vCj+ZFHTMdmApjjcnYOuMUq/jBwi3CguRoF1T
         nSU6UsCkLrdjB9VWOZPy9iWjQTq4hQwWs8RO0aSnvxiLQpDlU5pnr2HQ6xvOFffXPRqn
         bt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276111; x=1701880911;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fjs3Okyq9EWbreP6AOnF4Rr0g4Cepv9m/ouV8NW/+O4=;
        b=u5S41KkDaaqWhoMd2rLAujCFpR0IewL8Mir/AMPhdggGVMpyVlpfGLLVpW6FLsSRiy
         9Uy/4UeBbr3lrhxzTRX1NPGxquO17ZvXx8egRcTBBDcay/lcT/kcr+NRaAnD33TP1Ov2
         0fPhsr+XUKkBW2+d4kPzoYo4tZKIGlfW8ZT2iDBuOBQ5WH2Ex6kUk08HwuPIYQSm17h4
         zGmqTWGsyeBdkk8UCcL6JkaOgAObs2zj5+1zkLtCmDo4YFPcBOP0VtqAG3RnC/+KdA/Q
         m+kTu16/DvJTNDtNuFlvTEVlrBx93KT6sJauwLR9oMhf8QBXcCZBJYRJlKeeUCVJr4he
         XoUQ==
X-Gm-Message-State: AOJu0Yx/ysEm+g4D327os5WdSY3qp6vjKDHhvtRQA3pK0srMhniQRp/0
        qp2YhNoAZ1HO6q309t9uJqBvCCz6INepoQ==
X-Google-Smtp-Source: AGHT+IHJLt6t2SBXVcMOy+x4u9k4HCGdsvez9v81S9XkJIrlzx7UuYuSel6DeNSKzD86cKYjhVoQ+Q==
X-Received: by 2002:a05:622a:4c0e:b0:423:d75b:2b62 with SMTP id ey14-20020a05622a4c0e00b00423d75b2b62mr8468314qtb.51.1701276111101;
        Wed, 29 Nov 2023 08:41:51 -0800 (PST)
Received: from [192.168.2.14] ([76.65.20.140])
        by smtp.gmail.com with ESMTPSA id fc21-20020a05622a489500b00423e6885152sm909995qtb.75.2023.11.29.08.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 08:41:50 -0800 (PST)
Message-ID: <9595b8bf-e64d-4926-9263-97e18bcd7d05@gmail.com>
Date:   Wed, 29 Nov 2023 11:41:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.5.1
Subject: Re: Radeon regression in 6.6 kernel
Content-Language: en-CA, en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Danilo Krummrich <dakr@redhat.com>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
 <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com>
 <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net>
 <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com>
 <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>
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
In-Reply-To: <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UyehoVd0FbltVXpXzUgljOtM"
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
--------------UyehoVd0FbltVXpXzUgljOtM
Content-Type: multipart/mixed; boundary="------------0XZomOJokaOIq0ur7sjc7Zhs";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Phillip Susi <phill@thesusis.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-kernel@vger.kernel.org,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@redhat.com>
Message-ID: <9595b8bf-e64d-4926-9263-97e18bcd7d05@gmail.com>
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
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com>
 <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>
In-Reply-To: <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>

--------------0XZomOJokaOIq0ur7sjc7Zhs
Content-Type: multipart/mixed; boundary="------------X4lhUOpMG3SysAtmJ6e16SnL"

--------------X4lhUOpMG3SysAtmJ6e16SnL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-29 10:22, Alex Deucher wrote:
> On Wed, Nov 29, 2023 at 8:50=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
=2Ecom> wrote:
>>
>> On Tue, Nov 28, 2023 at 11:45=E2=80=AFPM Luben Tuikov <ltuikov89@gmail=
=2Ecom> wrote:
>>>
>>> On 2023-11-28 17:13, Alex Deucher wrote:
>>>> On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@thesusis=
=2Enet> wrote:
>>>>>
>>>>> Alex Deucher <alexdeucher@gmail.com> writes:
>>>>>
>>>>>>> In that case those are the already known problems with the schedu=
ler
>>>>>>> changes, aren't they?
>>>>>>
>>>>>> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'=
m
>>>>>> misunderstanding what the original report was actually testing.  I=
f it
>>>>>> was 6.7, then try reverting:
>>>>>> 56e449603f0ac580700621a356d35d5716a62ce5
>>>>>> b70438004a14f4d0f9890b3297cd66248728546c
>>>>>
>>>>> At some point it was suggested that I file a gitlab issue, but I to=
ok
>>>>> this to mean it was already known and being worked on.  -rc3 came o=
ut
>>>>> today and still has the problem.  Is there a known issue I could tr=
ack?
>>>>>
>>>>
>>>> At this point, unless there are any objections, I think we should ju=
st
>>>> revert the two patches
>>> Uhm, no.
>>>
>>> Why "the two" patches?
>>>
>>> This email, part of this thread,
>>>
>>> https://lore.kernel.org/all/87r0kircdo.fsf@vps.thesusis.net/
>>>
>>> clearly states that reverting *only* this commit,
>>> 56e449603f0ac5 drm/sched: Convert the GPU scheduler to variable numbe=
r of run-queues
>>> *does not* mitigate the failed suspend. (Furthermore, this commit doe=
sn't really change
>>> anything operational, other than using an allocated array, instead of=
 a static one, in DRM,
>>> while the 2nd patch is solely contained within the amdgpu driver code=
=2E)
>>>
>>> Leaving us with only this change,
>>> b70438004a14f4 drm/amdgpu: move buffer funcs setting up a level
>>> to be at fault, as the kernel log attached in the linked email above =
shows.
>>>
>>> The conclusion is that only b70438004a14f4 needs reverting.
>>
>> b70438004a14f4 was a fix for 56e449603f0ac5.  Without b70438004a14f4,
>> 56e449603f0ac5 breaks amdgpu.
>=20
> We can try and re-enable it in the next kernel.  I'm just not sure
> we'll be able to fix this in time for 6.7 with the holidays and all
> and I don't want to cause a lot of scheduler churn at the end of the
> 6.7 cycle if we hold off and try and fix it.  Reverting seems like the
> best short term solution.

A lot of subsequent code has come in since commit 56e449603f0ac5, as it o=
pened
the opportunity for a 1-to-1 relationship between an entity and a schedul=
er.
(Should've always been the case, from the outset. Not sure why it was cod=
ed as
a fixed-size array.)

Given that commit 56e449603f0ac5 has nothing to do with amdgpu, and the p=
roblem
is wholly contained in amdgpu, and no other driver has this problem, ther=
e is
no reason to have to "churn", i.e. go back and forth in DRM, only to cove=
r up
an init bug in amdgpu. See the response I just sent in @this thread:
https://lore.kernel.org/r/05007cb0-871e-4dc7-af58-1351f4ba43e2@gmail.com

And it's not like this issue is unknown. I first posted about it on 2023-=
10-16.=20

Ideally, amdgpu would just fix their init code.
--=20
Regards,
Luben

--------------X4lhUOpMG3SysAtmJ6e16SnL
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

--------------X4lhUOpMG3SysAtmJ6e16SnL--

--------------0XZomOJokaOIq0ur7sjc7Zhs--

--------------UyehoVd0FbltVXpXzUgljOtM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZWdpxAUDAAAAAAAKCRBMFUeUMaM0rxMG
AP0VKIwpMtTXzjbkhP+YlAOkqgomRWdt1ImVdFZwC6ss/AEA1HV4kiVP2+VGwRtGUUImxMuRwOGE
gH5ERcUPC6tIlA0=
=9LNu
-----END PGP SIGNATURE-----

--------------UyehoVd0FbltVXpXzUgljOtM--
