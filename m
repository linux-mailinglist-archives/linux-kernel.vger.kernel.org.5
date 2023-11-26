Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B27F9089
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 01:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjKZAwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 19:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjKZAwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 19:52:33 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F507182;
        Sat, 25 Nov 2023 16:52:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfa5840db3so13303315ad.2;
        Sat, 25 Nov 2023 16:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700959958; x=1701564758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKbAS2Hz5r5UYPT9wOmOu1Kao71kWGzQNplLWwlmgQU=;
        b=ckMBdsB2id3LK26Mv6+dz0EwE4Kq173WdDS2sPFuFh2Fu3R5BltksI5v65zfmV5tFS
         1L/x/TIhKSHye3p7vmUthJRDLtUgkuxAceia1NdW97Hyh2M6gC9KCOk4miUFVcsq9G3y
         Q+MG2MpMTCiiFJSuROThO7ZI3Hx7ACJdeCsBljr/m19WF4PHtSxiEmgk6vDX5yt6j+fw
         l1K9dDKSpvy7gGFgORE7P9jYiz67LGayk44PENJDAxSnPpJBlHx9cWWJwF40z0wh/1MU
         Q6M7TnTs52kd+JUgcjQXncLUbB/tC42GSULCuTBfqy5ztUpx+0uUdlLEYeR9zg5Yu1NV
         kquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700959958; x=1701564758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKbAS2Hz5r5UYPT9wOmOu1Kao71kWGzQNplLWwlmgQU=;
        b=SWD91WWo4O0DnecE/cnzdmj0DOmy1dnjR5tNk2DFkYvRanQNjFyU8/6x5yoktiGT1p
         ZvtUjh7KhQR3xnn8GRqHZoAj6g10YqAkYSqRyfduqkx7GTj+6HIeB0Mak9B1MdtKQqvK
         phI5alhS/XpeflV4oelI1tDYkHiygvgpQ1wQQKawBwi3bQ0NuvSc80jwFX3eSAdIhTsF
         2HXX51OkCAuOZrXnJB1rRS5ssjH4jh8YzQiCKU+NRi7DMx0VVE0mPVkxtxMVUTai5t0V
         d62UqQHysBDAVCyG/2mYLgXSPm/tDkLTvf5wgq34CrWkdjpIWH3w8W3zM7tuqlLSlO0E
         8mqw==
X-Gm-Message-State: AOJu0YwJvUZvBb8wxV76sE9P8+RAZRNtB8dGGO2C8cn3FWZSTtQAgqjq
        DDKlJl+cpolLaI/Ka60fH/U=
X-Google-Smtp-Source: AGHT+IH6FyNJyJqu6BLrI29L97TNTsQiQLKSRLQqESyUex6zppGa1K4ONTCLBwy7o/MD+4fL1ghkiA==
X-Received: by 2002:a17:902:d2cd:b0:1cc:4467:a563 with SMTP id n13-20020a170902d2cd00b001cc4467a563mr10099829plc.3.1700959957964;
        Sat, 25 Nov 2023 16:52:37 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jc11-20020a17090325cb00b001ce664c05b0sm5509447plb.33.2023.11.25.16.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 16:52:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 56C7F10205C41; Sun, 26 Nov 2023 07:52:35 +0700 (WIB)
Date:   Sun, 26 Nov 2023 07:52:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/527] 6.6.3-rc3 review
Message-ID: <ZWKW0rxstUR9Qnen@archie.me>
References: <20231125194417.090791215@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YjTMKzLNLP7oLp3F"
Content-Disposition: inline
In-Reply-To: <20231125194417.090791215@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YjTMKzLNLP7oLp3F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 07:45:29PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 527 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--YjTMKzLNLP7oLp3F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWKWzwAKCRD2uYlJVVFO
o/F9AQDS2pa83YDWDhWxMzoiLWzfNPcGYt2GVvwS4pBVMs7wTAEAyYfn/Fvrxdj/
jEtZeTGhjlo+BcrcpQT+79IChb732Q4=
=zVdp
-----END PGP SIGNATURE-----

--YjTMKzLNLP7oLp3F--
