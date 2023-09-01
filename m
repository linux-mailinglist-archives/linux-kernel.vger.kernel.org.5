Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19D978FAAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbjIAJWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbjIAJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:22:38 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66211731;
        Fri,  1 Sep 2023 02:21:56 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a9b41ffe12so1135904b6e.3;
        Fri, 01 Sep 2023 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693560116; x=1694164916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGEwguk6bLI4TMWGrtViIzYLdjlDbX1BQNkbUmaUR94=;
        b=V7grwrnZNnjrkHQ2z/OPmPuDQzFK/jkcvufY7XFMdWQRmTP0JYwZ4Cc0k4WqE9o3vT
         2ht9Tet4UR+xJsRdr2CMl6oAIeSXN6eM+kexZfT0dAviexqGwz5AxY2+PJN83evjzhFe
         rVeyLaIXdQcZVVrrwMr8WZK9VE1rhsACxtuquSn3aRvESY/0jyRQpxPI7Xt/W66Cr1yk
         qyuudlN2eQuDXdYgkUqTqqqbmbyIHwA9Xg6tQxGFgZMgGFVuufiFc2yWTSnmEbW36/Lt
         CRArMx7zuWsrHJ1SKzlyJHknCq/Mjjh77PKC/kWhK41WyDKA4gIyJX2a+6r+K+wo604d
         h84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560116; x=1694164916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGEwguk6bLI4TMWGrtViIzYLdjlDbX1BQNkbUmaUR94=;
        b=RdPuBLTIjHLRJuyp74VgU7NabpCzsdF17UMo481F8HNd3SOX94RB6rlSDwYt8uu3Xi
         LMthWGCpHMM/hHZhe/EAT73j+UJo2ABj8eNr9nOYCRgHsLxxHydHGWTNysXi4rBh/mBc
         QiFFGSud9/+ZCDVRFgiRxxoNcinCaS2L+tMeoo143of/9HEev9kYPG2rMMCymrJfkx0/
         pjyPzwbXYgHOzopysVI53ya5GrFBbOcjfYnK5fGfH93M5oq1rapNjcPrp5SZrER1AtLz
         9AlArdg4adbbN7+gSXlOyvvKVJMv6FbtCFVJyqUo4cn7exdaUdPZo8JJTOtcIbI54eN1
         +qtQ==
X-Gm-Message-State: AOJu0Yw1orWK4fesv66j49L6agBCtYrc+rMmRA3CNr6vOEOP9Nb219a5
        BRcKiycj25fEQ+iniQNOYqQ=
X-Google-Smtp-Source: AGHT+IEIUPD+Ar7lDbOhlDJNHJ/6ZyFcCKOajT3BO89IbRVcAGO6nunvAnPn+SfG56qrN7t/pXTymQ==
X-Received: by 2002:a05:6808:1296:b0:3a7:2390:3583 with SMTP id a22-20020a056808129600b003a723903583mr2699702oiw.38.1693560116146;
        Fri, 01 Sep 2023 02:21:56 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id i8-20020a639d08000000b0055c02b8688asm2422292pgd.20.2023.09.01.02.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:21:55 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C31538088641; Fri,  1 Sep 2023 16:21:51 +0700 (WIB)
Date:   Fri, 1 Sep 2023 16:21:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 0/8] 6.5.1-rc1 review
Message-ID: <ZPGtL8DCiYafUQTt@debian.me>
References: <20230831110830.817738361@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pv+BAIQRhkySjQQZ"
Content-Disposition: inline
In-Reply-To: <20230831110830.817738361@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pv+BAIQRhkySjQQZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 01:10:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Pv+BAIQRhkySjQQZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPGtKAAKCRD2uYlJVVFO
o2y7AQC9eJJo28wE2CAflX8IzbkSvMiatqIpPiGTR0rhnfYNywEAykf0dUUKdS9h
CllKx1cOKa+xT9WwHmYj7NmNagE+8go=
=EqcM
-----END PGP SIGNATURE-----

--Pv+BAIQRhkySjQQZ--
