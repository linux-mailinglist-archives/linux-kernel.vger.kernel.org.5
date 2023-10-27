Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A9C7D9B79
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbjJ0OdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345900AbjJ0OdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:33:05 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB45D7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:33:02 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-586a5d76413so1096060eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698417182; x=1699021982; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CpdGlrhIkHOtBTG4xIg7MKLAautQ7JbXFpIzulYae/o=;
        b=H4ks0TFf45nWPOQW/Qz/eJTS27MZ6JNOvq7zsPgGu/khVLiOL58f+3zKBCqZQZDOb3
         evopKXFIR7Gcx5S2jPrCdRfzgOzU8YDYnNelygmrvUzH5Shulh0zl7dV8NL5HS42ymCq
         DQYmPOTdFJhykt5Dt44SXnclFdCUv+soOOWIcoSSOy7GaemSdAEwP0LJCCYECVSzt6+n
         53HT+AYIbEtqOlea+7U2zv1yXqv/xjIfbRu26tJoMhNxMoyk6ImONPiHjJNPQRZ3zHtC
         A+f68IZSLzecumSpdJf6sw79w2Cqwhe6/0giMh7iVWV/h2qZwgpulTG3nGachkeH0KPS
         0gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698417182; x=1699021982;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpdGlrhIkHOtBTG4xIg7MKLAautQ7JbXFpIzulYae/o=;
        b=FbU53Llc7jSvhR7d03BUm4B60X1mE4FnD0JxtARrGpZ4DFaw4P5u60o03nCUO/sxkc
         UO3MVKEjU9PCgUW1PGvtLYQXjnIv1U4w8IFZfkb5ZizWXfstBXm3nnMIDOnPVh0kgsTc
         bo6CYny1JiYXBai/qvmd/iOrWeI8arnac9r7LVt+9JyRDO5j/RCWSdx6K0toUwyOyY1E
         9cA3mUqlPio99SE82ye5hesoqpeUgdUkh/Soe4W+qGY49KRPGPe3yCm+qp+qNNjpwklU
         wPekz2Twn6a6EvDuhktIjuqv6i08f1zS50+f1uNlaDpNmDo7mPszxOlpHN0RYlbMulst
         ZgfQ==
X-Gm-Message-State: AOJu0Ywmd7TNgGgP1Tdpsd3adltkuwO1WncahwBilAK4miDQioAP6HiK
        npgZBlEnbckpcxAYiiu7pWA=
X-Google-Smtp-Source: AGHT+IF/03cFrqTJn8+O4ys2b4VjFDTKEBXHF7ZPV37R13mCKzXZTO5FNCeultSc3iwIboLOAI59jQ==
X-Received: by 2002:a05:6358:186:b0:168:dea8:8897 with SMTP id d6-20020a056358018600b00168dea88897mr4449782rwa.22.1698417181757;
        Fri, 27 Oct 2023 07:33:01 -0700 (PDT)
Received: from [192.168.2.14] ([64.231.246.137])
        by smtp.gmail.com with ESMTPSA id r7-20020a0cf807000000b00655d6d31470sm658768qvn.43.2023.10.27.07.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 07:33:01 -0700 (PDT)
Message-ID: <a9215c37-61cd-4fbc-9f80-217daacd96bd@gmail.com>
Date:   Fri, 27 Oct 2023 10:32:52 -0400
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
In-Reply-To: <20231027102516.0e4b00ef@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zBbQHo0nGdz20abYaC4EXeG0"
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
--------------zBbQHo0nGdz20abYaC4EXeG0
Content-Type: multipart/mixed; boundary="------------M3s91CY0sQdA9iUwyyOVqLNg";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@redhat.com>
Cc: matthew.brost@intel.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, faith@gfxstrand.net, luben.tuikov@amd.com,
 christian.koenig@amd.com
Message-ID: <a9215c37-61cd-4fbc-9f80-217daacd96bd@gmail.com>
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
References: <20231026161431.5934-1-dakr@redhat.com>
 <20231027102516.0e4b00ef@collabora.com>
In-Reply-To: <20231027102516.0e4b00ef@collabora.com>

--------------M3s91CY0sQdA9iUwyyOVqLNg
Content-Type: multipart/mixed; boundary="------------vrFRQuCgLc5Nc6W7iMwOFl6n"

--------------vrFRQuCgLc5Nc6W7iMwOFl6n
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-10-27 04:25, Boris Brezillon wrote:
> Hi Danilo,
>=20
> On Thu, 26 Oct 2023 18:13:00 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
>=20
>> Currently, job flow control is implemented simply by limiting the numb=
er
>> of jobs in flight. Therefore, a scheduler is initialized with a credit=

>> limit that corresponds to the number of jobs which can be sent to the
>> hardware.
>>
>> This implies that for each job, drivers need to account for the maximu=
m
>> job size possible in order to not overflow the ring buffer.
>>
>> However, there are drivers, such as Nouveau, where the job size has a
>> rather large range. For such drivers it can easily happen that job
>> submissions not even filling the ring by 1% can block subsequent
>> submissions, which, in the worst case, can lead to the ring run dry.
>>
>> In order to overcome this issue, allow for tracking the actual job siz=
e
>> instead of the number of jobs. Therefore, add a field to track a job's=

>> credit count, which represents the number of credits a job contributes=

>> to the scheduler's credit limit.
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>> Changes in V2:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   - fixed up influence on scheduling fairness due to consideration of =
a job's
>>     size
>>     - If we reach a ready entity in drm_sched_select_entity() but can'=
t actually
>>       queue a job from it due to size limitations, just give up and go=
 to sleep
>>       until woken up due to a pending job finishing, rather than conti=
nue to try
>>       other entities.
>>   - added a callback to dynamically update a job's credits (Boris)
>=20
> This callback seems controversial. I'd suggest dropping it, so the
> patch can be merged.

Sorry, why is it controversial? (I did read back-and-forth above, but it =
wasn't clear
why it is /controversial/.)

I believe only drivers are privy to changes in the credit availability as=
 their
firmware and hardware executes new jobs and finishes others, and so this =
"update"
here is essential--leaving it only to prepare_job() wouldn't quite fulfil=
l the vision
of why the credit mechanism introduced by this patch in the first place.
--=20
Regards,
Luben

--------------vrFRQuCgLc5Nc6W7iMwOFl6n
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

--------------vrFRQuCgLc5Nc6W7iMwOFl6n--

--------------M3s91CY0sQdA9iUwyyOVqLNg--

--------------zBbQHo0nGdz20abYaC4EXeG0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZTvKFAUDAAAAAAAKCRBMFUeUMaM0rykV
AQC2uWndwUzaOjsm0B4ArlehJLxJdgkhjAU6cRSrqPbGFQEAzQO8/yIHT9LKQ4J3SXO0uMYyJu4y
4l+ltVrrttUSoQM=
=obLk
-----END PGP SIGNATURE-----

--------------zBbQHo0nGdz20abYaC4EXeG0--
