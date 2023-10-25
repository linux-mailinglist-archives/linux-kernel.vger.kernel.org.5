Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A041D7D5F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbjJYA0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbjJYA0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:26:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC9D7D;
        Tue, 24 Oct 2023 17:26:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so4046241b3a.3;
        Tue, 24 Oct 2023 17:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698193607; x=1698798407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3F2VdRItguO8Qn8qfdo62Ksc1kh2lTspD/WC/mgVdY=;
        b=cVvowyua32B54eR0b0l7JmFIJlwBpckjEIOPZ4oc4ftpXfX3D37XeWtJvX6hnfuOd2
         Nnjyhwv2TQI21cn2hEWytNDErKlVZtGvjv8/5WCY134Ukc8dgXzAMVSxYEyl/VJ2MdCv
         FgBkuNSljVlgBeKcfFroFyjMfuF5hsfM3b3nI4a/k9jzD499v573QDHHxtB7Fo5Ry7dZ
         NJkincetQQcF5X7QWbze4xN0IHuIsI7uguKMK+iIYw+TNG+ef0d4YPUETmI1J5AhCtdG
         XkgW7ds76Gc1VMn/mP34cXPeBRiUQ33lUpM0SKcrvd5flC6rUpRPeSCegjPT5Neub+17
         mBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698193607; x=1698798407;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3F2VdRItguO8Qn8qfdo62Ksc1kh2lTspD/WC/mgVdY=;
        b=u+odv3HoE3EhnMir7H5dLsuS/wImGZ8wef0FV5v5WfHMVID3xIqjjRCUy2yg1iZ68b
         NspvT5cfk8/UIXjTmcFpguW/ZO+JtItbe/vNZn4B1OT7v+SOB9x1n7asvJB23oVOaKnw
         mGsIn5wlEpHF6CzvVMUXmg75cpdJFRL2MzQxxUyiH+8PmFWOzehYZpkWhT7YbyO0yP/A
         CaLP1zIxWukXotkkZsJA19iuINrlGrg+4WnSydPN97C2CgCgaTmVLBzwHbyA4mhljTyB
         bfn9IwiddBK7WmNoiYZlmX2+sToWx1Niqhed1OBi/IifwjKaKLAOlew7D/DxGLURmdV2
         cfnA==
X-Gm-Message-State: AOJu0YwCvGlO/rd/TQrlbHrTFaZghlpFWXXnFvSnaM741aZvrkh3l/If
        ts8sLQfvpFHq1lb15nKQbnE=
X-Google-Smtp-Source: AGHT+IGwil2QExW2jjgPAHWVLebg0bcU8kR9WMPGCNoJTzaVao/0RJjFNxctyecv0cMV5CDBsjC2oQ==
X-Received: by 2002:a05:6a00:2da7:b0:68f:fa05:b77a with SMTP id fb39-20020a056a002da700b0068ffa05b77amr12413656pfb.31.1698193606798;
        Tue, 24 Oct 2023 17:26:46 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7949d000000b006be5e537b6csm8182779pfk.63.2023.10.24.17.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:26:46 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 380F3819CFF3; Wed, 25 Oct 2023 07:26:41 +0700 (WIB)
Date:   Wed, 25 Oct 2023 07:26:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     JPT <j-p-t@gmx.net>,
        Linux Media Subsystem <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Gon Solo <gonsolo@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: si2157 not working at all?
Message-ID: <ZThgwTieDv7Gi8UG@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TLSra6wXNX2H1c3R"
Content-Disposition: inline
In-Reply-To: <1cfa1365-ca0d-4e33-a149-751277183440@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TLSra6wXNX2H1c3R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 07:44:28PM +0200, JPT wrote:
> Well,
>=20
> I was able to make a fresh ubuntu install and build 6.6-rc7
>=20
> find the logfile here:
> https://pastebin.com/9zsRuYFv
>=20
> comments inside, at the end.
> the last lines are:
>=20
> si2168 8-0067: downloading firmware from file 'dvb-demod-si2168-b40-01.fw'
> si2168 8-0067: firmware version: B 4.0.25
> si2157 9-0063: device is buggy, skipping firmware download
> si2157 9-0063: firmware version: \xff.\xff.255
>=20
> so even in the newest kernel, the chip is marked as buggy.
>=20
> could someone please have a look what is the problem with si2157?
>=20
> here seems to be a patch for kernel 4.19
> https://github.com/brandsimon/debian-kernel-terratec-cinergy-tc2

Please don't top-post; reply inline with appropriate context instead.

What patch do you mean on that repo? Can you try applying that to see
if it helps?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--TLSra6wXNX2H1c3R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZThguwAKCRD2uYlJVVFO
o2ErAQCXNdYt1/eGQFlB6JShDXYnX6Qy/eeHzCEHOLYvsBv1JQEAwVk8BHG63c2r
T+IXELt7j7/IZ1SLMv1NzVQhpLp6ZQU=
=ZriE
-----END PGP SIGNATURE-----

--TLSra6wXNX2H1c3R--
