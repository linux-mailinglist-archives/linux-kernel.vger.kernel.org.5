Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF669792ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343900AbjIEQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346462AbjIEELX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:11:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FB2CC7;
        Mon,  4 Sep 2023 21:11:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c1f7f7151fso8777175ad.1;
        Mon, 04 Sep 2023 21:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693887080; x=1694491880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIlMAZ50va4APRXsLxxo9D6kHpaz1P92F5pndkHR9ZM=;
        b=MgmB71z5zo8N1wrKYfDJ3gu7YOIXmiUMJtvbvmm/h036042UL4QU0pSxhE4TvoIljC
         acEFMk08FYVcKDBgnuR7V/B5Au+DQ9Z0Ibfm0wmk78+Eis5UFUsrjehpx5rHaudaMS7D
         rZpMVHahih5fwltRb3cisBk7z2DW2jbIz8qSCi+OLkYxua3JqV5c/Gtldf2/fdl8bSJT
         s0OJro3IafFr5H6x+//FgsckNQFHJXb5q8IXm/bpYvZQrwS3TyblWICg9hYKPgbT0nki
         1RPoGFfHmT4ThoRNE/SZvoenahD2GmzBHMHM0qO2FUzM9U1Co7YUjbb3olGcgXX08uOC
         9hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693887080; x=1694491880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIlMAZ50va4APRXsLxxo9D6kHpaz1P92F5pndkHR9ZM=;
        b=khntAUGpq1K+hizlka79WieroZVAyZEeh1LpBr0WRK+NQMkHt6mrZrtF5cGK0IrQLb
         6gsWY7WZXkk+0N3rBnicPpKCZzWPDNgNQT0QM8QRD4uFqexiVRH+Pf8rWBKw+KHi3vve
         3FFnpcevqGMfZmCmC+ugbF9z0JOHZmsbXVsTyM65qsi2CK2fcIlhZUlFvHPx8XloNltf
         m0BCWSY1NvS052fNxd/AyjCBjCVG4Z77KcM7VE27fswI9gWExUfGTSSjXcbwu8e03t1q
         R5yUVUuNws89dmgQ8zlQJsVZnmb50SV6QgUSi4r60SPagT4MH5XOM2q/nrfmkg5bGaCG
         ULHQ==
X-Gm-Message-State: AOJu0Yy+ngk7VmY6GWsxKSSb7DC63bv/YJqou6/TpGFY/UaCZLPXCDVF
        4VLsansPIRZ/h2NwzQR8+d4=
X-Google-Smtp-Source: AGHT+IF2fMTKi2lUisY9zZI1YMErIBX7PytITedg0+99Wi8JAxf48Fx0KSjjrLM/GIFEzsAxh/dgSQ==
X-Received: by 2002:a17:902:8f81:b0:1c0:d5c6:748f with SMTP id z1-20020a1709028f8100b001c0d5c6748fmr8126856plo.67.1693887079569;
        Mon, 04 Sep 2023 21:11:19 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001b54d064a4bsm8216282plh.259.2023.09.04.21.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 21:11:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C150C80665D4; Tue,  5 Sep 2023 11:11:14 +0700 (WIB)
Date:   Tue, 5 Sep 2023 11:11:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/31] 6.1.52-rc1 review
Message-ID: <ZPaqYkvpv-SuNaWe@debian.me>
References: <20230904182946.999390199@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qgY7tslBl2Et3VY2"
Content-Disposition: inline
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qgY7tslBl2Et3VY2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 07:30:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.52 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--qgY7tslBl2Et3VY2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPaqXQAKCRD2uYlJVVFO
o2+dAPoCAaTGWb68AESIogYBgM5EaLF7IGs0GRhp/v0jMPvmIAD/coVd1CGNIAUN
ubXXxb+wa7BHTAhocvV/ZP3Ls6vxsgk=
=hCPn
-----END PGP SIGNATURE-----

--qgY7tslBl2Et3VY2--
