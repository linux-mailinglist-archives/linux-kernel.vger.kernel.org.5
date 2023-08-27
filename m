Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC83789D11
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjH0Ktf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjH0KtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:49:24 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B2F9;
        Sun, 27 Aug 2023 03:49:22 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34bbc5eb310so8247745ab.2;
        Sun, 27 Aug 2023 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693133362; x=1693738162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pW7IzFA0mTX34WomjctbyWOYGPZAXEGhbrFXLCtnqaw=;
        b=g7rTEQDet1fKpExTG3EFTT+sTkjp6iso3Fb71bHkDwSLdvG+tEl60fXwUO36YPt1ir
         RkMZJ2HP7sMC37Woi9psbrpESHQ6jzJoKq8XdOon64ARpxGcOvn5i9CUjgW6BRMCZuMW
         xSX5gEuKphIvTRK1KbMx1VTnqj5n7mHMuSwFs1024dYCkrpEbeqCkwNMFDF0Oha9F+5U
         f3BczKeElsrModFN+xniZOnEnE6zlPny6wUazEjYFFpeTS6zyj9+wdfWmvpYOpLPHMmQ
         +hDodKK7ZVXCh//t4BKhYK1ztJrUpW6WEZ7kuH6sLo1L3yCX5G53R+KGHjU/tSoZ2xSp
         njqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693133362; x=1693738162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW7IzFA0mTX34WomjctbyWOYGPZAXEGhbrFXLCtnqaw=;
        b=QmTL5lIEi9vMUdu5QZ3OPRN5CTlAchddneie0cUXMGr5Ivj0rnIiDl63Fh4GGYLpi9
         B2mPB3H+13mYQJuXzmlkibB/CpXqdz1koeMM+k3NOiNm1D+h+hkM9lHQcVt0b7drenzD
         e0sSEHT8ObihJ6WpE4AD5IYXXL+PRKFwQXei5REMcHtfZFDRawqBzRwO91DXSM/3NdNj
         ngSNoKa8UBUQ6IwyMYhGU75oND+0KYuhVZVXRE0jY0LaG3KlBBl0AWHEcrH1cWD8MOdo
         8dBk1R7t9eDc7AeXJ38urbWBiSx12O3ct7MHavougmWXATWiUHP5S8NQiI2Bq0hKW0lb
         5xuA==
X-Gm-Message-State: AOJu0YzQrH5oWH+tnWCrC+v6KBXVCsg5KcVsBrV9Zj052tKh9M9sWVtY
        Ru4vM23lsUczDMPq4Wushp4=
X-Google-Smtp-Source: AGHT+IHZK+KETXES93aurwx91PrqJAtM8/WBWNO/krX25zFGiQVPK+XzbIEnEQQkbS5TXtzQVqTg1w==
X-Received: by 2002:a05:6e02:2181:b0:34c:e4c6:c51c with SMTP id j1-20020a056e02218100b0034ce4c6c51cmr6174119ila.9.1693133362040;
        Sun, 27 Aug 2023 03:49:22 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b001b04c2023e3sm5068240plg.218.2023.08.27.03.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 03:49:21 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0D8418158460; Sun, 27 Aug 2023 17:49:15 +0700 (WIB)
Date:   Sun, 27 Aug 2023 17:49:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 0/4] 6.1.49-rc1 review
Message-ID: <ZOsqK0NvgddvFQkD@debian.me>
References: <20230826154625.450325166@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LAOyK7J7JXf1jAJC"
Content-Disposition: inline
In-Reply-To: <20230826154625.450325166@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LAOyK7J7JXf1jAJC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 05:47:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.49 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--LAOyK7J7JXf1jAJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOsqJgAKCRD2uYlJVVFO
o0WeAQDF56rn55bfNoItb91KPLkJZYyGOPOwXraSMp+r2n89bwEAhkQUfswTlIgK
vAU9NK3a5gHRUqX3gUjdWCem3mlqJQI=
=NDqK
-----END PGP SIGNATURE-----

--LAOyK7J7JXf1jAJC--
