Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789F27CB93D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjJQDZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjJQDY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:24:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14BA9F;
        Mon, 16 Oct 2023 20:24:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6be0277c05bso1314009b3a.0;
        Mon, 16 Oct 2023 20:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697513096; x=1698117896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6/kOuKag6maEqKqguiwwkDZZk+DdVjPal1eBex6cNI=;
        b=I8NIi0/6WyIgN0nt8TlW4+MH3kGVEnyHv0vPGk5TThv5s18sdem7HH8TQtW9NmeSCc
         Or8EkK/X0p/G5LNoC1lWiE5xE4HpABWEkfNeDKZ5EBVdfsEPx6VW6K2glQG2scSRvJ7p
         UctNF4F2YubnBuJTP+B2FHtW7H/vBmGXNyXBRLmv5Hq1whyws1v2iAXAemTtYas+rahT
         SrUrtyIrqMrwkH6lHETtR0T7KLWGep7DWevns/u7ifSW2sd0kMY447fXamD1Tv/MIkjX
         GXdnWEuc1dHsdphHX1WVbmHo//e0X2GeWaojvmSUyrmouUKW7DgffVBvSOOHF7u9U/7d
         mVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697513096; x=1698117896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6/kOuKag6maEqKqguiwwkDZZk+DdVjPal1eBex6cNI=;
        b=jYTjUZ52u4HIFsPPDUM3ePdMxRe+2Gb04TmuGZz6esnKH5s8HrKJ+t86CowdxTIjT9
         Ib3eIIu1BjcaLEIOk4RGhbjqaalxIrL5tdEoaeY/OYeynDFLvp4mSwj2EF3Yd6Q6KQij
         zNMS9hjfoNecXylS23b3jbt/nMkdqWqH9qBqo7yiiAbYC8dNVaQbYGakQVdxQ6O3V+4h
         gOK6JUHqXPmKlNP+9ErUadErIfnQRoqVe1CE+wHRnRL5l2wDZFtHvKNGib/ErKPqBFyF
         1BxjxcHEoEngdQESoDn3psMVdKuNC+O2NljEXWlFmy5DtLt7ruP9MLdkyp9bzY9dum29
         Y5xA==
X-Gm-Message-State: AOJu0YxrjYhiZ56GtZ+Ohe9LPVwOj4+V7H83RMOrwiLeWF+fvSA7m9ej
        hy7r1tB/w8JC64vR3yelYQQ=
X-Google-Smtp-Source: AGHT+IH/k/r0RAjJkMceTPBqzDYnJbE1R647TfI+lJGjjuF4cLnYArt5BWTtw6p2Ciqk/goWvMraKw==
X-Received: by 2002:a05:6a21:3394:b0:171:a3e8:8c05 with SMTP id yy20-20020a056a21339400b00171a3e88c05mr985447pzb.53.1697513096214;
        Mon, 16 Oct 2023 20:24:56 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b001c9d968563csm346086plh.79.2023.10.16.20.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 20:24:55 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BA6288026B2E; Tue, 17 Oct 2023 10:24:50 +0700 (WIB)
Date:   Tue, 17 Oct 2023 10:24:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/190] 6.5.8-rc2 review
Message-ID: <ZS3-guNZf9p14Ys0@debian.me>
References: <20231016185002.371937173@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L7zFWBF9Sh9LBLK+"
Content-Disposition: inline
In-Reply-To: <20231016185002.371937173@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L7zFWBF9Sh9LBLK+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 09:48:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.8 release.
> There are 190 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--L7zFWBF9Sh9LBLK+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZS3+eQAKCRD2uYlJVVFO
o7l8AQCI03RMOn2epFw7zrBnWWf6GythfmHBsFeEO0kYnZWZ7gEAhzwMfleTxmYK
0bXnnxOImsInevciKiCTXBVdcH5vfg8=
=XPKQ
-----END PGP SIGNATURE-----

--L7zFWBF9Sh9LBLK+--
