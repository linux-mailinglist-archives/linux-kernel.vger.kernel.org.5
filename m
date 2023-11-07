Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CCD7E348A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjKGEeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjKGEeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:34:19 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556E3FD;
        Mon,  6 Nov 2023 20:34:16 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so3965353b3a.1;
        Mon, 06 Nov 2023 20:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699331656; x=1699936456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5v+xl/QC//ZLXXcIvchI1qCynqxscf2nvU++0XNR+5I=;
        b=PLpo7bnIMx3nP3aRfT/ucl6rjQTYKcpBb+IdKWy4KG+lKgOcKxsU1dbS9uujZWlHT7
         oWXfHkenGPIZAFnzwlujfFk6/846gP2TvrNFTHN3ToEtLWXgd9xq4z9EXB7BNaLdOgqT
         DOgvvIwk8U+yM4ERsJavpvHxl+q8zQxgvMy2mhwzYRFLNyNAYCtJ7q48W86dK+fNJc40
         LuOgosMtXVnpZUdJuWYTjIxZUtQSQTBNrtlYjkiNtRGSqSRB7hLB0n5uwhWcANfZxzAp
         2QrSbfP4O3AYJKIMPkGvZdqQZ5+viRXmppHSs+VCGqyJpRMoQEFbv46wsdYCt8cDQXnr
         npEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699331656; x=1699936456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v+xl/QC//ZLXXcIvchI1qCynqxscf2nvU++0XNR+5I=;
        b=uIqYiW0IU4ClUE2NJNVHmUHcr3ulppGRLZCNtatVYvXJZlJJ5moUxbs7rb1bkOoy7Q
         2qitA2pALRXtDgO//klqZ93ECht61zrg+sAgEDnEI89TpIkc4jRSVlo3wEH4+Nz1vP/s
         raAoZgeLWTMI+COYha9znFexvcZLQ+U0sNnib1Motxvd8f0tXfDLMXSaJL/gSKiKYgPe
         NHFKMKypSolOk7fkl2fVwFJ1pazV0YSJKIezFjgZrFYLLwJ/NJeGkOajva9aI30fASoH
         kuHKW7e0A1H2+wIjbT6MrvnufKwrw70UH5a4ef63r8NAH60sRWmgn9ahs47VnfVdTXsY
         I7ZA==
X-Gm-Message-State: AOJu0YxSSRCASCfuZip7brVkgLuYRu9qmbX+t+iLVLcTnffDk5sPZCvI
        EivHe3wLR7GFuftjR479Oxw=
X-Google-Smtp-Source: AGHT+IEwICaZQxiKeFyoKwec6zvfZKlIIRbttwjmkWelZjZ+lCzAKASY3Jn6baxUKlpZ5E4prH4YBw==
X-Received: by 2002:a05:6a21:4881:b0:180:eef7:b3d9 with SMTP id av1-20020a056a21488100b00180eef7b3d9mr18747589pzc.57.1699331655723;
        Mon, 06 Nov 2023 20:34:15 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a19cb00b0028089fdce19sm6766313pjj.52.2023.11.06.20.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 20:34:14 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id F033D812C340; Tue,  7 Nov 2023 11:34:10 +0700 (WIB)
Date:   Tue, 7 Nov 2023 11:34:10 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 00/88] 6.5.11-rc1 review
Message-ID: <ZUm-QnC4f1UMABXf@debian.me>
References: <20231106130305.772449722@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibMRfCjAH3gXg/1B"
Content-Disposition: inline
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibMRfCjAH3gXg/1B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 02:02:54PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--ibMRfCjAH3gXg/1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUm+PQAKCRD2uYlJVVFO
o+O3AP93TAdIfltAG1Zmn9ePXLdsRoUFdlwuagy9P9xVHJSd+wEA485XLpco1j3F
wo2v/aTJZ51o+wPqdOTmZTTVNb0pwQw=
=cnMU
-----END PGP SIGNATURE-----

--ibMRfCjAH3gXg/1B--
