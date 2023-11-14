Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE57EA838
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjKNBcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKNBcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:32:54 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D295115;
        Mon, 13 Nov 2023 17:32:51 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5b383b4184fso60467527b3.1;
        Mon, 13 Nov 2023 17:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699925570; x=1700530370; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tukRLBW3zmQ0oPuYgOr/iYwnmqrUDyVTNwWEcMedHgc=;
        b=cBm5nTEBlGCm7uH0NlfOBemcM9nG7G/bkeYABsH4Ho3SOD+jzO0/YCKPI/hMZP9tRc
         TGEvJCmLbdAB0iw/fwtFV98nQa1Xcz6WXq9hmOmX7mcDVUXc+o6LvTAlKTVioEdSXy0R
         5GmHbw7hecyQ/US7LpgcSAKrifPJK+jGzf+tkeYOf9UmAqCO0SiYSKukfoNsGzU0ZI/w
         P9HS6fVaTex5YVaTJf5uPxoQzZ/bLeHQ6M+/v+4S1Cp7jHUIE9MSr3XaBk2Q8QOBVulK
         wKo1GdrwHEZN1mVKJx1Ge608c/fQcGu9L0JK+0HDRHfBSX+aYRL3W23I+99JthltBEx+
         jcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699925570; x=1700530370;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tukRLBW3zmQ0oPuYgOr/iYwnmqrUDyVTNwWEcMedHgc=;
        b=ENLrdoLNZ25nduq1Im2jBOYi9ENg0ufsBKFF9wc3VTXz3FnAfpjvHl0m5dsN+pnTx1
         3b66+eMvpByIevwhfdgZQYMvJ0F99D5krRVams2vv9fvca7cPw+vIZoHPDSvWDB8cwC8
         dLTfxg0MgFrf66XT5+4PalgPUlxUWIPyTS7fNTXZ3jdAMZLSdtg4xc+obTyaoA+mNU8T
         5xMv5zDJFTK0m4KHD/4tScHV0eq5gxvBcgjGisfvUBDAgsTFXlXbvCdiMJKQjbRBlqPf
         fW3jNwR45azmq9tTcWT2RcLEZl3da5ZdlNd9WmksPl3CXM8Ms1jIqOtCn9gLYMxw+578
         P7Ug==
X-Gm-Message-State: AOJu0Ywu3awxOnlTpF6VfvC0If+i5FgvJlDbvuzd3HFxRG5gjQQHcBHn
        GieSIH50YJm8JmBNpwtQRm7WoKR9e0Ldho7Y4Io=
X-Google-Smtp-Source: AGHT+IEOS4PSTo4e307r2xljjuv01x1t5vILWdqwLL6Kcb+v09Mst0VP/nhA2JZpeNAKvQUHGM31oQ==
X-Received: by 2002:a0d:dd51:0:b0:5a7:b53f:c304 with SMTP id g78-20020a0ddd51000000b005a7b53fc304mr9146485ywe.37.1699925570631;
        Mon, 13 Nov 2023 17:32:50 -0800 (PST)
Received: from [192.168.2.14] ([76.65.20.140])
        by smtp.gmail.com with ESMTPSA id s8-20020ad45008000000b0067095b0c473sm2508194qvo.11.2023.11.13.17.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 17:32:49 -0800 (PST)
Message-ID: <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
Date:   Mon, 13 Nov 2023 20:32:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.4.2
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
Content-Language: en-CA, en-US
From:   Luben Tuikov <ltuikov89@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231114075501.61321c29@canb.auug.org.au>
 <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Ag1iPz8wDKzQj3npkMVsgJvf"
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
--------------Ag1iPz8wDKzQj3npkMVsgJvf
Content-Type: multipart/mixed; boundary="------------lDsnbz37qjLh8AAZsz0OX8aD";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
References: <20231114075501.61321c29@canb.auug.org.au>
 <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
In-Reply-To: <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>

--------------lDsnbz37qjLh8AAZsz0OX8aD
Content-Type: multipart/mixed; boundary="------------aiAdaoPN5W8gHNYSkvHCD3VM"

--------------aiAdaoPN5W8gHNYSkvHCD3VM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-11-13 20:08, Luben Tuikov wrote:
> On 2023-11-13 15:55, Stephen Rothwell wrote:
>> Hi all,
>>
>> Commit
>>
>>   0da611a87021 ("dma-buf: add dma_fence_timestamp helper")
>>
>> is missing a Signed-off-by from its committer.
>>
>=20
> In order to merge the scheduler changes necessary for the Xe driver, th=
ose changes
> were based on drm-tip, which included this change from drm-misc-fixes, =
but which
> wasn't present in drm-misc-next.
>=20
> I didn't want to create a merge conflict between drm-misc-next and drm-=
misc-fixes,
> when pulling that change from drm-misc-next to drm-misc-fixes, so that =
I can apply

=2E.. when pulling that change from from drm-misc-fixes into drm-misc-nex=
t, so that I can apply...

> the Xe scheduler changes on top of drm-misc-next.

The change in drm-misc-fixes is b83ce9cb4a465b. The latter is contained
in linus-master, and in drm-misc-fixes, while the former is in drm-misc-n=
ext.
When we merge linus-master/drm-misc-fixes into drm-misc-next, or whicheve=
r way
it happens, I'd like to avoid a merge conflict, but wanted to expedite th=
e changes
for Xe.
--=20
Regards,
Luben

--------------aiAdaoPN5W8gHNYSkvHCD3VM
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

--------------aiAdaoPN5W8gHNYSkvHCD3VM--

--------------lDsnbz37qjLh8AAZsz0OX8aD--

--------------Ag1iPz8wDKzQj3npkMVsgJvf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZVLOOAUDAAAAAAAKCRBMFUeUMaM0rxlT
AQDYqVENncFQLkoIbYcqzcZcH1iZ+GrTbEhVhHu1+zUOdwEA0/VOJ+AIKj/1t82GYpzUgk6uhtGh
4Yo3BWnlJ2jC5Q4=
=5Tam
-----END PGP SIGNATURE-----

--------------Ag1iPz8wDKzQj3npkMVsgJvf--
