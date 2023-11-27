Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F07F976B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjK0CMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0CMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:12:51 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3AB11C;
        Sun, 26 Nov 2023 18:12:48 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cc44736f2so21376311cf.3;
        Sun, 26 Nov 2023 18:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701051168; x=1701655968; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qugBdKBw39THHjgwXW3RTBqPcyk8dRGoduuik4Rrsqg=;
        b=T6ix7D/9iWEzI9WueRm5oUVD80QZD7Cip89Ibo5UNGn2/AqI10M2vZDcyiA1ZaX7Vu
         4zqIYAfbL1E4bZb95ytDGjhmfUICMmznyJWVKZ9xPdPVptWCA1PFXx18Q4P8xH9K+VzZ
         gzYNpmM3NLeaPdSNPaTBbSyLlsmxNUQcLxNo4I4GAtmgXCQDVb/522VxYB2Mj5+NYC3a
         lPErEdqBET73NzhV1TDZ8QKFLK0PwxgIEjUf94Rfc2lWSDzJ7e+cD8tjI0gpd5AVqcxE
         OhRRmVMAjwwmkytMtOOQcUa5aY+otGPNGhCjKxnNo4XreVu3rxdbnzK6l9sxMmMnRufG
         DLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701051168; x=1701655968;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qugBdKBw39THHjgwXW3RTBqPcyk8dRGoduuik4Rrsqg=;
        b=VkbzBn46Ua2IvfvG78JBUj0ZH/1fd7BTM2zBgALfw3qp6zbMKphJ7UcdVTr5PNUbmt
         jt33vSSZGvBxNpgQR7t489MTocEUM6/yk2oBCRxa8fscdSz5RBqeBGl0qfGIyIngUVvj
         mLQvuPCNCHs5WZOBqtZj2tqG/jMIgiaH0it1EBEcD6MvpgEqHdp8TMHHopH5xDdiKRhU
         uyKpFrxcyQcEdg8vj6gYGB3W/+BKa6iQm6aZ3wbJGZgTLtj8pYCUxl+oB4O2E1A+R8W1
         hGuN5Ygo8+q1Sr/5OjZvCkYw05IedpPgYJI2Gotf0nfpX+fjGMOywVFJ2uEX3dZEcwN3
         KXYg==
X-Gm-Message-State: AOJu0Yy4UuxeKDeU+MpbFTGZ9/CWsuCVyrmXCURNXH8TJJpuAPNUtw3k
        ToGgyBvatN1aSOwVSfp4dusTBatHncUhlA==
X-Google-Smtp-Source: AGHT+IHMpVJuXgS5KglBGiTNBGXulFF0WfBXXWwEUewotEA8G5zPSVHNOuRY9FQrqtvAoosIfFTOsA==
X-Received: by 2002:ac8:5749:0:b0:423:8b9c:cfb8 with SMTP id 9-20020ac85749000000b004238b9ccfb8mr12564359qtx.24.1701051167787;
        Sun, 26 Nov 2023 18:12:47 -0800 (PST)
Received: from [192.168.2.14] ([76.65.20.140])
        by smtp.gmail.com with ESMTPSA id h7-20020ac87447000000b0041ea59e639bsm3369008qtr.70.2023.11.26.18.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 18:12:46 -0800 (PST)
Message-ID: <ad3bcdd0-9b73-436a-91cd-6e034bd8980c@gmail.com>
Date:   Sun, 26 Nov 2023 21:12:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.5.0
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Content-Language: en-CA, en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231127103806.35efa376@canb.auug.org.au>
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
In-Reply-To: <20231127103806.35efa376@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wviEZ0IpOBd7JAaeKWbJOXsz"
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wviEZ0IpOBd7JAaeKWbJOXsz
Content-Type: multipart/mixed; boundary="------------vmKbUiNtiy3e77Q6SGunvJYP";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <ad3bcdd0-9b73-436a-91cd-6e034bd8980c@gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
References: <20231127103806.35efa376@canb.auug.org.au>
In-Reply-To: <20231127103806.35efa376@canb.auug.org.au>

--------------vmKbUiNtiy3e77Q6SGunvJYP
Content-Type: multipart/mixed; boundary="------------DF08rh0qV4ytr5U57IfaV0Cd"

--------------DF08rh0qV4ytr5U57IfaV0Cd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-26 18:38, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/gpu/drm/nouveau/nouveau_sched.c:21:41: error: 'DRM_SCHED_PRIORI=
TY_MIN' undeclared here (not in a function); did you mean 'DRM_SCHED_PRIO=
RITY_LOW'?
>    21 |         NOUVEAU_SCHED_PRIORITY_SINGLE =3D DRM_SCHED_PRIORITY_MI=
N,
>       |                                         ^~~~~~~~~~~~~~~~~~~~~~
>       |                                         DRM_SCHED_PRIORITY_LOW
>=20
> Caused by commit
>=20
>   fe375c74806d ("drm/sched: Rename priority MIN to LOW")
>=20
> I have used the drm-misc tree from next-20231124 for today.

I posted a fix for this yesterday:
https://lore.kernel.org/r/20231125192246.87268-2-ltuikov89@gmail.com
--=20
Regards,
Luben

--------------DF08rh0qV4ytr5U57IfaV0Cd
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

--------------DF08rh0qV4ytr5U57IfaV0Cd--

--------------vmKbUiNtiy3e77Q6SGunvJYP--

--------------wviEZ0IpOBd7JAaeKWbJOXsz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZWP7FQUDAAAAAAAKCRBMFUeUMaM0r/HA
AP0UwqabBpVwQ4K3Cv7V8M8DEsDBst4mh3U3M+A5V78C7gD/WO/c1PqfHpIqZmVeELHy7rZod8ha
r+IfEQRrxFpNCAQ=
=y3V8
-----END PGP SIGNATURE-----

--------------wviEZ0IpOBd7JAaeKWbJOXsz--
