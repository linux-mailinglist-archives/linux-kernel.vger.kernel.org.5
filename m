Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA607EA817
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjKNBI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNBI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:08:27 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D7AD51;
        Mon, 13 Nov 2023 17:08:24 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778711ee748so329426385a.2;
        Mon, 13 Nov 2023 17:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699924104; x=1700528904; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JKcvvlyi44mL6KlohMsUtHtgv16cdE0L7BYR9br9JrA=;
        b=kqlbzcOGD7QvrK9CeHwTjdLwUdVHspLJCy7JiqqHtR7qTXY0fkzDTz6PS8I3dGCF/A
         pyZ9CL8tKH6PROCKYWFfGa/YiGUMm5NQ6NLU3os4deSFwDnluZRoHS8dTxX51cgktWzd
         0RwNGJc0BKk+DpPZnfkZO02+Zjg7jQ+kzccFCHf5z97XoQqR09ear/BrdF6A/MHiZv95
         CyxLcjpI678N2JBqEXi5qzONVOu7ohefTDsqYUjdoiTBAqrbaHh0KFD4cHC1p6Ya1Vb+
         j9FTBbAMOQrrabBUgzgDLOBul9IE2md6zmoVH1CTSZ2ge2Cvv6c+NBCARrqIyfSzzJJJ
         yKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699924104; x=1700528904;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKcvvlyi44mL6KlohMsUtHtgv16cdE0L7BYR9br9JrA=;
        b=VIl9mjyfEf/GulrEKY3hbobsml0uv6FlU/qJr1oyPczz893qs2Vml4dZU0dVqC+oPx
         H8qFA4V726dPk5KkXkW45yRBEkCU2Nr3Cs0RcinXfeLmNkJYzc3zQdKxACC7Wl7LSxhp
         eEA0I5PWXAJq++fjpsShGwIGlMt2fc2Y46lMTEUFkI/J12XHpvvGGkO+y/1ozHUqQCmZ
         oTtNMhcJV3l3TDBn15XNe4oTATLCfW4RzOWUyWIXy4gkktwW+rUkzisxla03OaCBeE0V
         qUxZ74An9mBEwIqVW3pGuieyXZAUggsbmXbvpr9BpjdzmUL7mNQZnAC4gY4+9obkp+Fo
         eUcw==
X-Gm-Message-State: AOJu0YyeZIMZRvcHHOj9cZcK+Mw3bQvsQegoscgzetEAEoLRvN43FclB
        sgp3cwZ0WLiJsHlAPSaZ/whq1PsRdHm0SkGjYAE=
X-Google-Smtp-Source: AGHT+IFiQWl24h9GC1sLTorOF/ZdWCUlUOYvQPa91zZrJC9cw0bp+El0mMCJWAMiyBDFPfqhTaNV+g==
X-Received: by 2002:a05:620a:19a1:b0:779:d1ea:c5da with SMTP id bm33-20020a05620a19a100b00779d1eac5damr972334qkb.37.1699924103773;
        Mon, 13 Nov 2023 17:08:23 -0800 (PST)
Received: from [192.168.2.14] ([76.65.20.140])
        by smtp.gmail.com with ESMTPSA id qf6-20020a05620a660600b0077407e3d68asm2268274qkn.111.2023.11.13.17.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 17:08:23 -0800 (PST)
Message-ID: <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
Date:   Mon, 13 Nov 2023 20:08:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.2
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
Content-Language: en-CA, en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231114075501.61321c29@canb.auug.org.au>
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
In-Reply-To: <20231114075501.61321c29@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vEfybuPWDPn3tC0gL2qgH3Ql"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
--------------vEfybuPWDPn3tC0gL2qgH3Ql
Content-Type: multipart/mixed; boundary="------------B4ohSNNGqjiBnNCLqzuihuRH";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
References: <20231114075501.61321c29@canb.auug.org.au>
In-Reply-To: <20231114075501.61321c29@canb.auug.org.au>

--------------B4ohSNNGqjiBnNCLqzuihuRH
Content-Type: multipart/mixed; boundary="------------qvDQOYufPGufy4Mj2qrN1Ci0"

--------------qvDQOYufPGufy4Mj2qrN1Ci0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-13 15:55, Stephen Rothwell wrote:
> Hi all,
>=20
> Commit
>=20
>   0da611a87021 ("dma-buf: add dma_fence_timestamp helper")
>=20
> is missing a Signed-off-by from its committer.
>=20

In order to merge the scheduler changes necessary for the Xe driver, thos=
e changes
were based on drm-tip, which included this change from drm-misc-fixes, bu=
t which
wasn't present in drm-misc-next.

I didn't want to create a merge conflict between drm-misc-next and drm-mi=
sc-fixes,
when pulling that change from drm-misc-next to drm-misc-fixes, so that I =
can apply
the Xe scheduler changes on top of drm-misc-next.
--=20
Regards,
Luben

--------------qvDQOYufPGufy4Mj2qrN1Ci0
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

--------------qvDQOYufPGufy4Mj2qrN1Ci0--

--------------B4ohSNNGqjiBnNCLqzuihuRH--

--------------vEfybuPWDPn3tC0gL2qgH3Ql
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZVLIfgUDAAAAAAAKCRBMFUeUMaM0r7zT
AQCiNDNdfwwEl1fqI+vA0gRQhPhPspazrejdUdFVOa2rkwD9Ey1+rknoP3/l6BG/sMCB6KcSvzYM
VqgKbrH9xS0SCQk=
=MWyy
-----END PGP SIGNATURE-----

--------------vEfybuPWDPn3tC0gL2qgH3Ql--
