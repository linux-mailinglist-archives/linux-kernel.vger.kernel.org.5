Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDFD7E34C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjKGFEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKGFEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:04:12 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9E9B4;
        Mon,  6 Nov 2023 21:04:09 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so5561942b3a.3;
        Mon, 06 Nov 2023 21:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699333449; x=1699938249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bz7iGOYk5qgRTgthykPiSTMHBpTMoBlt+4h9e44JHnA=;
        b=bkKWVGRGhVeUYK/dilcLVaS7ZtY49dmFHMEj3p340j37eg/waXbbZ0vmtHslVFND6b
         eKwXGe8XOjHDSWutqouBZgMsJApKHos1LOjX58DD1HoUzUS8ZyrUD/tg4Czq7+z5OZgG
         +WgWGGFjH9wAC9Mn74LfYDYj40IpBqb1y+WL84XP3oaZwTudfB1wyBXP5FkCAISe9AOv
         2+xdjlIkh6H3HrVop1ljPQ6Nyu53Y1uYcAoTSVrEwoENmVvXur5O8xE5WK/MIhsGB63w
         TD2LmrTbm8bSBP2UdrGnBLdBEo1hMHdPS1hoYTBRHIudDgkowdGixa8P7te1ynZfNSGi
         AfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699333449; x=1699938249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz7iGOYk5qgRTgthykPiSTMHBpTMoBlt+4h9e44JHnA=;
        b=U88uq/pDTcbZFfbTABbVCTAj0h1e7eLYCS8lny7asFY6i8LkWDaSKJ4lR/qBLkMXY8
         QTukQW3aomcodzBubwDZiPae0hwlbWigSEOSmNhgmgHeCRVsqqq7fpVbrQVeCR7isd9Z
         aL4NodLjb2x5fhvSj0P1nrYSwSg4YsZlTH5ipCOwOjGMJCCqsEYIwyOrpETvFsLd+09L
         WQ3xv5KBS3ma1gU5/SfS5JO+vJxdSOR/3FhYgxDot9wpVc1WiqPl+qV8W0NxTlbRPoGh
         Ze4zIyA6ezGtwmjm2o9+H16wlQ1oFmN6Rer14L41RX3niQ8XsaEkpgCPFYsYpU/jFA1f
         QYbQ==
X-Gm-Message-State: AOJu0YxX3wX9YAJUVy7KOyaGxW83Czqn0arv3u5me6wxBGgTpjEA7EKc
        w26YXgG0CtRkTCzGPQo6dt0=
X-Google-Smtp-Source: AGHT+IHq5rnCKDl+KFwkF0Y9L+OEede5/mV+cWlrWqRhXEUDPuut3SHzrOT6r7PkwP3AoPsQ5+LNaQ==
X-Received: by 2002:a05:6a00:98b:b0:6be:265:1bf7 with SMTP id u11-20020a056a00098b00b006be02651bf7mr39794442pfg.34.1699333448912;
        Mon, 06 Nov 2023 21:04:08 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t20-20020aa79394000000b006c0fdc98c89sm6335346pfe.85.2023.11.06.21.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 21:04:08 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 213E9812C341; Tue,  7 Nov 2023 12:04:03 +0700 (WIB)
Date:   Tue, 7 Nov 2023 12:04:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
Message-ID: <ZUnFQ2New-VTnkmp@debian.me>
References: <20231106130257.903265688@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LszhaNktL2TxPxAr"
Content-Disposition: inline
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LszhaNktL2TxPxAr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 02:03:18PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--LszhaNktL2TxPxAr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUnFPgAKCRD2uYlJVVFO
oyO8AQDXwlHwd9TsiXYqEZdXDU8pzWkIZgYug/FxILaxm0EZmwEAkMMTMf8Ql8nY
9ov4qPCQhVdErQMM0gL67N9kug203QA=
=AfLt
-----END PGP SIGNATURE-----

--LszhaNktL2TxPxAr--
