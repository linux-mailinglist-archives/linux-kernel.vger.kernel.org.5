Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419427EBA48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 00:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjKNXqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 18:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjKNXqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:46:34 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62716D6;
        Tue, 14 Nov 2023 15:46:31 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso6354220276.2;
        Tue, 14 Nov 2023 15:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700005590; x=1700610390; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lbmdT3vaVBMogOtWNscVfWuqZjoV0cbQQ9JmM7/0yok=;
        b=QLYRXSTvWILFtosnKtuhjgMupTNbFEqgtoE9H+PhFh9oEGb72/gvq7rDjqVrF7qnnj
         R64rmiYwpsDKWMD5ekp8+Kmvy7AtFxge/z8e7WWra+r2PsH4pD9xqwRabTcvXvtWMZn+
         1CEF8BH5tmlpfiy7jX+yaEXT7B1qOAwUyr/cm9tMjGVPx5wVY0uZ71e8hEA0AGaDtIpn
         TUzBIhT/t+PBZj/scS6p4EFXVAO+rqtR2utas4xuzK4w+kbuPs4opFgaVdc85VImO//x
         2nR2T95xlI6a2bqOHTMAovzGo+gNJT9toSlbi1/p4QW6gx5xUdJKR/qzlXcC0ynOE3hX
         dKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700005590; x=1700610390;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbmdT3vaVBMogOtWNscVfWuqZjoV0cbQQ9JmM7/0yok=;
        b=k4oeiFGmI/Wa35LSoQE/eBiiCukuEDtszktApLz1ojdQik4Rb5ssEYex4LHlEHFfKv
         a1/mmt50xMYZnL0Ug2ehxLuKbTtdj81tkT999Dsg+741vEgOEmp1jxQG7Ei/mFGcKQoC
         gsHwYEYZz1pm90115DuvBBnGfAQtm3ikmqoj/1xW48mNd6N7E1HYMNM/9CSud41Oxzq0
         wS2nBqg+h8pihKeWqXJmK3m2LKx6Hmh/en/wDHoA2vZo5wuVsJlafV9/uyuFyboDk19c
         zPgEHfLdHp1ulfzkYZmaddvAS87QxjbnclUcexH5Zu31yypsxuYpvlz+x6c/SDv3p5pQ
         eBEQ==
X-Gm-Message-State: AOJu0YxwNPXXkKF7uzuoH2JSGYEVQwTC+tpP/lh+xmrTzejYdUAEAKc1
        iFgqtt+ltXVoDyQGNrJr6P3+dB9mrAR0JepCRg4=
X-Google-Smtp-Source: AGHT+IHRYXFN1QUK6Bv/WdbS8cwcmC/qBo7tOOXlzlCq1QPYQqnPwI2L4v8XA620Hv/ThJxpTzst4A==
X-Received: by 2002:a25:ca45:0:b0:da0:cbea:dabe with SMTP id a66-20020a25ca45000000b00da0cbeadabemr12069437ybg.35.1700005590497;
        Tue, 14 Nov 2023 15:46:30 -0800 (PST)
Received: from [192.168.2.14] ([76.65.20.140])
        by smtp.gmail.com with ESMTPSA id pp6-20020a056214138600b0067095b0c473sm61352qvb.11.2023.11.14.15.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 15:46:30 -0800 (PST)
Message-ID: <f1b21cbd-5bb6-4030-ae7d-a0ca2fbc76a9@gmail.com>
Date:   Tue, 14 Nov 2023 18:46:21 -0500
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
 <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
 <20231114140855.0b259b2d@canb.auug.org.au>
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
In-Reply-To: <20231114140855.0b259b2d@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HTKrbU5lOZ6mxXkZ7mZNSxmz"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
--------------HTKrbU5lOZ6mxXkZ7mZNSxmz
Content-Type: multipart/mixed; boundary="------------FJntXuXbfVbAwa1UJaJOp8M0";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <f1b21cbd-5bb6-4030-ae7d-a0ca2fbc76a9@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
References: <20231114075501.61321c29@canb.auug.org.au>
 <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
 <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
 <20231114134506.2ba0de1f@canb.auug.org.au>
 <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
 <20231114140855.0b259b2d@canb.auug.org.au>
In-Reply-To: <20231114140855.0b259b2d@canb.auug.org.au>

--------------FJntXuXbfVbAwa1UJaJOp8M0
Content-Type: multipart/mixed; boundary="------------F9XEukwrVCFmv4B7vuJh0xFG"

--------------F9XEukwrVCFmv4B7vuJh0xFG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-13 22:08, Stephen Rothwell wrote:
> Hi Luben,
>=20
> BTW, cherry picking commits does not avoid conflicts - in fact it can
> cause conflicts if there are further changes to the files affected by
> the cherry picked commit in either the tree/branch the commit was
> cheery picked from or the destination tree/branch (I have to deal with
> these all the time when merging the drm trees in linux-next).  Much
> better is to cross merge the branches so that the patch only appears
> once or have a shared branches that are merged by any other branch that=

> needs the changes.
>=20
> I understand that things are not done like this in the drm trees :-(

Hi Stephen,

Thank you for the clarification--understood. I'll be more careful in the =
future.
Thanks again! :-)
--=20
Regards,
Luben

--------------F9XEukwrVCFmv4B7vuJh0xFG
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

--------------F9XEukwrVCFmv4B7vuJh0xFG--

--------------FJntXuXbfVbAwa1UJaJOp8M0--

--------------HTKrbU5lOZ6mxXkZ7mZNSxmz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZVQGzQUDAAAAAAAKCRBMFUeUMaM0r01g
AP43OO1tEtqKzVowQkZbe0sU39xbKQpwKOQS03XXYHrHRQEAgTMz/7/u56riwK/eiDCRVC2cJc/M
X7DDJKQvHEZLTws=
=b6jb
-----END PGP SIGNATURE-----

--------------HTKrbU5lOZ6mxXkZ7mZNSxmz--
