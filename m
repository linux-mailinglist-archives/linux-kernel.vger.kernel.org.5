Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D037EA8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjKNC4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 21:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKNC4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:56:41 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2BD1A1;
        Mon, 13 Nov 2023 18:56:38 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7789577b53fso321547385a.3;
        Mon, 13 Nov 2023 18:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699930598; x=1700535398; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z8gh+tyvh6xU3CtUfgvuoYYHt+9hj8SrGt0ODg/Sa40=;
        b=Nwjv5tGTXjr6q65Zc4azatXH2xZP5B0tanJ+UUAdChu+peDceLWE3qbxjQsFyRq7A2
         jvAxAUHG2t0hodwfWrpGwEjkDcEj0sQRWKsQSrN/UDIjkM+E+uYpPmJNQB3N2TFPq/8o
         /6OR9wCYGMmyW2C2P9ecV0r/KBZp3UOHETyV23MIqn7q1/eLfhai4/691GG8c/B3woFi
         69onc0mi68KYcNHMuRaO8YdXCtG3wJAXFANXzrNm6EDMYxgf55QFOxZtT7E7boPZCxI3
         McBcNMQMmiBcoKLU+vR+khGBWTf7SZnPM5fkk3SWo5hJX/fluy//NzvGx507Bv7c4Ui6
         1KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699930598; x=1700535398;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8gh+tyvh6xU3CtUfgvuoYYHt+9hj8SrGt0ODg/Sa40=;
        b=E2Zz4x3l/q63y3ZPnjxe2q3su0M4duxqDtQh564dfpAqdmq6vrdwleDU1Au1n+JwC3
         ZHfRMJRZDuYELDKzrDkF2Jh7Qvr8AkV4R25nNXHMwv4KGrc9hQVL09ZDHz4rmH48oVBj
         exqavjrxU3iSp7JNcgRHFHEHGFwuYCUs/gLXXqg2LIj2BP3nsJdic/efH2QE2nkEs3ia
         bwv2Ycy4IoOFBhVW68Xhf0g+NvqqZ3YFn1ee7tGsjmqDZzU8HeMBjSN8GrpYb8jV+W+F
         WeN80mbjvOx3rUnJ3OxXoDjzDq9C1EzOWMBu1XbgG5Pmp98UNS0Xzh/QBxepQeD+MZH+
         qdPg==
X-Gm-Message-State: AOJu0YxV6oAKt7K3fWYPH8tsNNfY2/ikE7l47pARsgL/9tj5IZKm0r3d
        Zrs2Y7pJ3ul+OResHYaTpGHLCwSH9+Lixd9jPNE=
X-Google-Smtp-Source: AGHT+IHUuAN3MAFGpLTAWV4ImXiPpTFZOBaOLMZe+wLj3VOPkU70r1ErUhHhns1ksiQHY/wxs1Xjqg==
X-Received: by 2002:a0c:ec81:0:b0:66d:bc21:814c with SMTP id u1-20020a0cec81000000b0066dbc21814cmr974712qvo.65.1699930597891;
        Mon, 13 Nov 2023 18:56:37 -0800 (PST)
Received: from [192.168.2.14] (bras-base-toroon0964w-grc-76-76-65-20-140.dsl.bell.ca. [76.65.20.140])
        by smtp.gmail.com with ESMTPSA id w8-20020a0cc708000000b0066d5220d860sm2560468qvi.18.2023.11.13.18.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 18:56:37 -0800 (PST)
Message-ID: <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
Date:   Mon, 13 Nov 2023 21:56:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.2
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
Content-Language: en-CA, en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231114075501.61321c29@canb.auug.org.au>
 <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
 <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
 <20231114134506.2ba0de1f@canb.auug.org.au>
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
In-Reply-To: <20231114134506.2ba0de1f@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Tencx0UITbqjxESm55irdpdp"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Tencx0UITbqjxESm55irdpdp
Content-Type: multipart/mixed; boundary="------------YqVmdYYomq0UeOq8wwTkv7P8";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
References: <20231114075501.61321c29@canb.auug.org.au>
 <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
 <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
 <20231114134506.2ba0de1f@canb.auug.org.au>
In-Reply-To: <20231114134506.2ba0de1f@canb.auug.org.au>

--------------YqVmdYYomq0UeOq8wwTkv7P8
Content-Type: multipart/mixed; boundary="------------NJtk4VEkjq3D80zuPf9TXKVC"

--------------NJtk4VEkjq3D80zuPf9TXKVC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-13 21:45, Stephen Rothwell wrote:
> Hi Luben,
>=20
> On Mon, 13 Nov 2023 20:32:40 -0500 Luben Tuikov <ltuikov89@gmail.com> w=
rote:
>>
>> On 2023-11-13 20:08, Luben Tuikov wrote:
>>> On 2023-11-13 15:55, Stephen Rothwell wrote: =20
>>>> Hi all,
>>>>
>>>> Commit
>>>>
>>>>   0da611a87021 ("dma-buf: add dma_fence_timestamp helper")
>>>>
>>>> is missing a Signed-off-by from its committer.
>>>> =20
>>>
>>> In order to merge the scheduler changes necessary for the Xe driver, =
those changes
>>> were based on drm-tip, which included this change from drm-misc-fixes=
, but which
>>> wasn't present in drm-misc-next.
>>>
>>> I didn't want to create a merge conflict between drm-misc-next and dr=
m-misc-fixes,
>>> when pulling that change from drm-misc-next to drm-misc-fixes, so tha=
t I can apply =20
>>
>> ... when pulling that change from from drm-misc-fixes into drm-misc-ne=
xt, so that I can apply...
>>
>>> the Xe scheduler changes on top of drm-misc-next. =20
>>
>> The change in drm-misc-fixes is b83ce9cb4a465b. The latter is containe=
d
>> in linus-master, and in drm-misc-fixes, while the former is in drm-mis=
c-next.
>> When we merge linus-master/drm-misc-fixes into drm-misc-next, or which=
ever way
>> it happens, I'd like to avoid a merge conflict, but wanted to expedite=
 the changes
>> for Xe.
>=20
> None of that is relevant ... if you commit a patch to a tree that will
> be in the linux kernel tree, you must add your Signed-off-by to the com=
mit.

Hi Stephen,

Noted!

So I always do this when I do git-am and such, but wasn't sure for this o=
ne single cherry-pick whose
original author was the committer in drm-misc-fixes, but will add my Sign=
ed-off-by in those
rare circumstances.

Thanks for the clarification!
--=20
Regards,
Luben

--------------NJtk4VEkjq3D80zuPf9TXKVC
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

--------------NJtk4VEkjq3D80zuPf9TXKVC--

--------------YqVmdYYomq0UeOq8wwTkv7P8--

--------------Tencx0UITbqjxESm55irdpdp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZVLh4AUDAAAAAAAKCRBMFUeUMaM0r6eC
AQDsvW6naENA3rNs8pbN5QJSlkKy0CBPsgq9ZPggDgmaQAEA4QpMMKV/zVghKFWu/sjG3dYjdpUG
3j9N4V02JICJBwE=
=tP9x
-----END PGP SIGNATURE-----

--------------Tencx0UITbqjxESm55irdpdp--
