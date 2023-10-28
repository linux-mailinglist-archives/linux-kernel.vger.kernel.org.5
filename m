Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C667DA512
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 05:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjJ1DwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 23:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJ1Dv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 23:51:59 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C92B8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 20:51:57 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d1a05b816so19517536d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698465116; x=1699069916; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OcYVrWnBqjkY6s3i+KnosMsD6+eSYCyoMq5LSmyC1Rs=;
        b=D8wZN9dK/iVATmfHZlm8XIpGNFCeg+MgWKbrN7p5PnSEafG4R+7znRHQTgmdtM/jJM
         6GM63EJHgAFRei7weWV5hK5kpiI0sl+L+wAv40NhpMueZz+Qh1EcsUl/kuZbTKB/YMQh
         q/9B2MFV6QOQBS8TemE1z1Z/p+0+tbR/mnjowA+bS2oP5ux351cqpb4xUdzSzYqU0FE2
         4qIifj0Kc0rfa+5xrwTn4ffU6QH/HN2PV82jVcxaL2SpbWIlYhwkzCF9nm1JZhqWOOfS
         ICJb2YNgS86yhWHYexERkwg6sVVemywWG1i+Ua1r1dkZZ3hZTW2xQbBbsJJbTiOZ1ECM
         DlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698465116; x=1699069916;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcYVrWnBqjkY6s3i+KnosMsD6+eSYCyoMq5LSmyC1Rs=;
        b=dXgJA+0RktnCTjAdptQ7Jj7Wv0pXN8grxs7JwNJ2tIDluOV7Tw0rACGE6SS0ZDbLNE
         w4npgROnQx6lUJ09z7vrnxVq4T400CcOH8C6rz5+MEeRiAUQas8x21+9TDBfXCMsAbTL
         KH35XM3uexH1rqCIayIRfJMUtQmiRpiAE+xvwi+PFkOZeGnYikozQKXogN1Bbs2c3k3H
         AuQdsNTkvVXaIZ4CYlenJCaYLuiGqtN05GKWp0vQgn3EwYp6CDGYzEPbcpgDS7DXtAGy
         xYFgtbuWxT8RN4ueDWzu0O/XOyPmTricQ7vjSTgL8aVDr6jcoB1Zu57yU+Bzj38N8VBu
         l0sQ==
X-Gm-Message-State: AOJu0YxLfXDxyKuE40EX3d+5FOsAMyn424fXWD1Lz++ZaZZe6UCGTvDd
        f/SWyTeIwkY67YSr3HZF7G0=
X-Google-Smtp-Source: AGHT+IHegjfJS6Sn+Nb6aE7VowTH4ygmouXpG6CghxI9hbKHXUvAsu74yh9O8aqM5JTR+RhePdS2GA==
X-Received: by 2002:a05:6214:d06:b0:66d:69d1:d57a with SMTP id 6-20020a0562140d0600b0066d69d1d57amr5571073qvh.38.1698465116411;
        Fri, 27 Oct 2023 20:51:56 -0700 (PDT)
Received: from [192.168.2.14] ([64.231.246.137])
        by smtp.gmail.com with ESMTPSA id cy7-20020a05621418c700b0065b151d5d12sm1225626qvb.126.2023.10.27.20.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 20:51:56 -0700 (PDT)
Message-ID: <df7f500b-f911-4180-adf2-5a8b8bf2b6c7@gmail.com>
Date:   Fri, 27 Oct 2023 23:51:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.1
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
Content-Language: en-CA, en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Danilo Krummrich <dakr@redhat.com>, matthew.brost@intel.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        faith@gfxstrand.net, christian.koenig@amd.com
References: <20231026161431.5934-1-dakr@redhat.com>
 <20231027102516.0e4b00ef@collabora.com>
 <a9215c37-61cd-4fbc-9f80-217daacd96bd@gmail.com>
 <20231027184143.4427edb8@collabora.com>
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
In-Reply-To: <20231027184143.4427edb8@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TqV7NTz0aDGZyZGGMAGPUxnM"
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
--------------TqV7NTz0aDGZyZGGMAGPUxnM
Content-Type: multipart/mixed; boundary="------------b0m804UtGjCwO8F33HypECbv";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Danilo Krummrich <dakr@redhat.com>, matthew.brost@intel.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 faith@gfxstrand.net, christian.koenig@amd.com
Message-ID: <df7f500b-f911-4180-adf2-5a8b8bf2b6c7@gmail.com>
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
References: <20231026161431.5934-1-dakr@redhat.com>
 <20231027102516.0e4b00ef@collabora.com>
 <a9215c37-61cd-4fbc-9f80-217daacd96bd@gmail.com>
 <20231027184143.4427edb8@collabora.com>
In-Reply-To: <20231027184143.4427edb8@collabora.com>

--------------b0m804UtGjCwO8F33HypECbv
Content-Type: multipart/mixed; boundary="------------Luda7dot3zIxE6qlYy8TW7K5"

--------------Luda7dot3zIxE6qlYy8TW7K5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-10-27 12:41, Boris Brezillon wrote:
> On Fri, 27 Oct 2023 10:32:52 -0400
> Luben Tuikov <ltuikov89@gmail.com> wrote:
>=20
>> On 2023-10-27 04:25, Boris Brezillon wrote:
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
>>>>   - fixed up influence on scheduling fairness due to consideration o=
f a job's
>>>>     size
>>>>     - If we reach a ready entity in drm_sched_select_entity() but ca=
n't actually
>>>>       queue a job from it due to size limitations, just give up and =
go to sleep
>>>>       until woken up due to a pending job finishing, rather than con=
tinue to try
>>>>       other entities.
>>>>   - added a callback to dynamically update a job's credits (Boris)  =

>>>
>>> This callback seems controversial. I'd suggest dropping it, so the
>>> patch can be merged. =20
>>
>> Sorry, why is it controversial? (I did read back-and-forth above, but =
it wasn't clear
>> why it is /controversial/.)
>=20
> That's a question for Christian, I guess. I didn't quite get what he
> was worried about, other than this hook introducing a new way for
> drivers to screw things up by returning funky/invalid credits (which we=


It's up to the driver--they can test, test, test, and fix their code and =
so on.
We can only do so much and shouldn't be baby-sitting drivers ad nauseam. =
Drivers
can also not define this callback. :-)

> can report with WARN_ON()s). But let's be honest, there's probably a
> hundred different ways (if not more) drivers can shoot themselves in th=
e
> foot with drm_sched already...

Yes, that's true. So there's no worries with this hook.

>=20
>>
>> I believe only drivers are privy to changes in the credit availability=
 as their
>> firmware and hardware executes new jobs and finishes others, and so th=
is "update"
>> here is essential--leaving it only to prepare_job() wouldn't quite ful=
fill the vision
>> of why the credit mechanism introduced by this patch in the first plac=
e.
>=20
> I kinda agree with you, even if I wouldn't so pessimistic as to how
> useful this patch would be without the ->update_job_credits() hook
> (it already makes the situation a lot better for Nouveau and probably
> other drivers too).

Sure, and that's a good thing.

The heart of the dynamic credit scheme this patch is introducing *is* upd=
ate_job_credits()
callback. Without it, it's just about like the current job flow-control s=
cheme we have with
varied job weights (credits). Remember, it is an optional callback and dr=
iver can choose NOT
to define it--simple. :-)

So, I'm very excited about this, and see a wide range of applications and=
 tricks drivers
can do with the credit scheme (albeit had it been an "int" bwha-ha-ha-ha =
]:-> ).

Have a good weekend everyone!
--=20
Regards,
Luben

--------------Luda7dot3zIxE6qlYy8TW7K5
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

--------------Luda7dot3zIxE6qlYy8TW7K5--

--------------b0m804UtGjCwO8F33HypECbv--

--------------TqV7NTz0aDGZyZGGMAGPUxnM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZTyFUwUDAAAAAAAKCRBMFUeUMaM0ry9R
AP99ffr4HYHt8VGCMy5iROcK4QMbSPUNs06YvL6SzaTxQwEAqh4nRjiYzJKeiyxwSx34v4pieDcI
66KeJE5oT9sCpAU=
=vUY+
-----END PGP SIGNATURE-----

--------------TqV7NTz0aDGZyZGGMAGPUxnM--
