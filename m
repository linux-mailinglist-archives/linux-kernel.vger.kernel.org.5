Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FBD7F53B2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjKVWuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjKVWuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:50:08 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A092;
        Wed, 22 Nov 2023 14:50:05 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41cc537ed54so1271001cf.2;
        Wed, 22 Nov 2023 14:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700693404; x=1701298204; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pgUF2jw5fhh4WgDjWnxiVoJOmAD0MbdmhXUbJVHtxqs=;
        b=fJd2fw6DzeRQH/BBtKKnx5BQEq3bb2OJ6LP0JvY4tnPPtVuzDxfcfskcuo10IWa4AX
         cD7bZkzffb//Z/9hnNS72Jfe/HKwSz+75crhT08BoFvYdZBlngWoDiwr0loRfFiqvU2R
         mo+t7LkiHcV+7EMVSBU3/pbROyiYavbzeZg5GrnQN1i7iHBMbRv+C1thnbeZtZxuQ2N9
         ubRsi66VAuD3aoPhMZTeYkFcHTe05aU5MyRo0WNx/DkMDMHm5ZjzE5WYZg9rPbAKwqTP
         KhHhxGUUXquMvFIa6+jR1hJAgbXXdlzBgUhVuKs7g36QssbARba2Ul0X9vXrHW0qOdCr
         J7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693404; x=1701298204;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgUF2jw5fhh4WgDjWnxiVoJOmAD0MbdmhXUbJVHtxqs=;
        b=AdreYJwSVhpvT78WhIMuXDmAYF+tbackKy+2Zo+KJIUxaiTXQJSGe+TVqJJnzO5WSP
         AQLC9cIP1lEhw4lK5osZi7iDicMWAkHuHdl/kSQOUE/FHnK06evsr6sTTWMKfvcjHZKS
         xdomIf2QXqpt84nczRjyvkBEOqSW8D5KWMGxIkxxufglAgqSJqjijAT6AxnANuSZywxo
         pZ91vkWqaDemfZR/yBa+fRu69q2+am4H0IrTrMC9mtKLEXxS85APX95ZylzGLn9mxAqe
         YzkfXEJAchSPrutr8OLtDxmY/anLqubisPjw+/o+UuvC1/KZncfj/a2LB7vcHeD8TDMt
         +SXQ==
X-Gm-Message-State: AOJu0Yw8c1eq/ULpF80jOcZ12GeQb7jvwjlZuSdkAKTBOlRjKk/Duo+8
        sStdgMzcE7MtZpayXRAAsF8=
X-Google-Smtp-Source: AGHT+IFxFtVzEMOttPulrUYMFhaJqDwiYUxwlliQIjlXN+6KPQ9fIo7F72WMer0S3lfosciSxMWjSw==
X-Received: by 2002:ac8:4e45:0:b0:417:b026:794a with SMTP id e5-20020ac84e45000000b00417b026794amr4777426qtw.34.1700693404221;
        Wed, 22 Nov 2023 14:50:04 -0800 (PST)
Received: from [192.168.2.14] ([76.65.20.140])
        by smtp.gmail.com with ESMTPSA id jr38-20020a05622a802600b004182037f655sm180094qtb.14.2023.11.22.14.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 14:50:03 -0800 (PST)
Message-ID: <ed5f8aa6-c46b-414a-a10e-afcdd3535487@gmail.com>
Date:   Wed, 22 Nov 2023 17:49:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.5.0
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
To:     Maxime Ripard <mripard@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231114075501.61321c29@canb.auug.org.au>
 <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
 <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
 <20231114134506.2ba0de1f@canb.auug.org.au>
 <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
 <20231114140855.0b259b2d@canb.auug.org.au>
 <f1b21cbd-5bb6-4030-ae7d-a0ca2fbc76a9@gmail.com>
 <73cg637ax5cahqocscx5cjvtqkwlt4ves6cxgprbwqllasxq6v@gk6vzsqfc46j>
 <ZVXSjt_1uWHuYXsq@phenom.ffwll.local>
 <zuz7zpcjfqzeymfrn53tbhcsem5abqh2l4vcaqkxo5wbgoc742@bnxnkek3wv6t>
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
In-Reply-To: <zuz7zpcjfqzeymfrn53tbhcsem5abqh2l4vcaqkxo5wbgoc742@bnxnkek3wv6t>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cW0jnkQpqvbooC61FfCQNjc4"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cW0jnkQpqvbooC61FfCQNjc4
Content-Type: multipart/mixed; boundary="------------BOlQ1N8z9TxlZfDl0VeePWbr";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Maxime Ripard <mripard@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <ed5f8aa6-c46b-414a-a10e-afcdd3535487@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
References: <20231114075501.61321c29@canb.auug.org.au>
 <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
 <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
 <20231114134506.2ba0de1f@canb.auug.org.au>
 <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
 <20231114140855.0b259b2d@canb.auug.org.au>
 <f1b21cbd-5bb6-4030-ae7d-a0ca2fbc76a9@gmail.com>
 <73cg637ax5cahqocscx5cjvtqkwlt4ves6cxgprbwqllasxq6v@gk6vzsqfc46j>
 <ZVXSjt_1uWHuYXsq@phenom.ffwll.local>
 <zuz7zpcjfqzeymfrn53tbhcsem5abqh2l4vcaqkxo5wbgoc742@bnxnkek3wv6t>
In-Reply-To: <zuz7zpcjfqzeymfrn53tbhcsem5abqh2l4vcaqkxo5wbgoc742@bnxnkek3wv6t>

--------------BOlQ1N8z9TxlZfDl0VeePWbr
Content-Type: multipart/mixed; boundary="------------odbxRq18VREOLDcToXr8M3b2"

--------------odbxRq18VREOLDcToXr8M3b2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-22 07:00, Maxime Ripard wrote:
> Hi Luben,
>=20
> On Thu, Nov 16, 2023 at 09:27:58AM +0100, Daniel Vetter wrote:
>> On Thu, Nov 16, 2023 at 09:11:43AM +0100, Maxime Ripard wrote:
>>> On Tue, Nov 14, 2023 at 06:46:21PM -0500, Luben Tuikov wrote:
>>>> On 2023-11-13 22:08, Stephen Rothwell wrote:
>>>>> BTW, cherry picking commits does not avoid conflicts - in fact it c=
an
>>>>> cause conflicts if there are further changes to the files affected =
by
>>>>> the cherry picked commit in either the tree/branch the commit was
>>>>> cheery picked from or the destination tree/branch (I have to deal w=
ith
>>>>> these all the time when merging the drm trees in linux-next).  Much=

>>>>> better is to cross merge the branches so that the patch only appear=
s
>>>>> once or have a shared branches that are merged by any other branch =
that
>>>>> needs the changes.
>>>>>
>>>>> I understand that things are not done like this in the drm trees :-=
(
>>>>
>>>> Hi Stephen,
>>>>
>>>> Thank you for the clarification--understood. I'll be more careful in=
 the future.
>>>> Thanks again! :-)
>>>
>>> In this case, the best thing to do would indeed have been to ask the
>>> drm-misc maintainers to merge drm-misc-fixes into drm-misc-next.
>>>
>>> We're doing that all the time, but we're not ubiquitous so you need t=
o
>>> ask us :)
>>>
>>> Also, dim should have caught that when you pushed the branch. Did you=

>>> use it?
>>
>> Yeah dim must be used, exactly to avoid these issues. Both for applyin=
g
>> patches (so not git am directly, or cherry-picking from your own
>> development branch), and for pushing. The latter is even checked for b=
y
>> the server (dim sets a special push flag which is very long and contai=
ns a
>> very clear warning if you bypass it).
>>
>> If dim was used, this would be a bug in the dim script that we need to=

>> fix.
>=20
> It would be very useful for you to explain what happened here so we
> improve the tooling or doc and can try to make sure it doesn't happen
> again
>=20
> Maxime

There is no problem with the tooling--I just forced the commit in.
--=20
Regards,
Luben

--------------odbxRq18VREOLDcToXr8M3b2
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

--------------odbxRq18VREOLDcToXr8M3b2--

--------------BOlQ1N8z9TxlZfDl0VeePWbr--

--------------cW0jnkQpqvbooC61FfCQNjc4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZV6FkgUDAAAAAAAKCRBMFUeUMaM0rxFN
AP93JLSs3wqu/h4O8tmvb4N4qyVUopXOTtP+nR7M4vTyhwEAwdX4NkfewGDmbecj6BkSq+XYkdfa
e1ykbMruFW40tg4=
=0V1M
-----END PGP SIGNATURE-----

--------------cW0jnkQpqvbooC61FfCQNjc4--
