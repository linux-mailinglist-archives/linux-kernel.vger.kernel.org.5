Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3671E812FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572984AbjLNMV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572970AbjLNMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:21:55 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DF6BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:22:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28b0def5d30so136029a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702556521; x=1703161321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdkMvlmQKDEjb01URG4TvG4VxvCoEXt3iAKwNgfPtHw=;
        b=Lc7JSMnhNAL/2gmeDN5QWSX6Xjv6DhlprNm+sDRGuTwE1pl1ImU73h/anDB1SZLJZl
         IaPex6fGqfUTiEhcut1TWpxKTC5FEgMDC8lfpC/Y5v0yEV0rmVYN25iPv158XeGJly/V
         hmuRQei8+yqpUFy0Op5zm5eTjBP7ebHSEylRotatv1B2V42AsFhpO9VmuAdT6121Q/BD
         vrwy22gS6dq1PrJkyMs9vyWwuIcVDb+l/JmQzDZQlOkP+TVD+Jxtr/kFLCT9hQdxpLhL
         iUUUmWT0U0rA2OyUoEvg1bPWjFtR0yuSYxKmLJ/BtbbICekmw5VOe0kSoju8kuPWTjQr
         rEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556521; x=1703161321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdkMvlmQKDEjb01URG4TvG4VxvCoEXt3iAKwNgfPtHw=;
        b=ZoV976NGLQUZE6rgpZcwrOvS+zrotu8VDPP4QWLDKPwZo8Fii8SChKjOplZMZXZJ2c
         4gSTxnyl3iOXQ/EXRLLsZiY7/t9+kSWd5tp1918mYlv/e7pTcvdLZShLbbRkVRXks7zx
         d9K2NhtUi9mon583xP/1iqkXDBvKgWQHJAXIGDn+nHLLxQOThVEAEZJqWaykWGqNWhSz
         a7uUBGUacDV+LyO+FbbjkunJeNzWsEYY8ExxOxCvs83whurfsth5FBNIkyW3l664LdEy
         Mvb5jcxpM13BOsPHNbRMXTV/HZR+h6UOOC+BDtqKTcNSrNiW8F9d85bVKvAFLOllfaGO
         buhg==
X-Gm-Message-State: AOJu0YwaJhTfDgEwJvKxlRe2jpI+HXbT6oaLa9ISTgKTeelpXWGdUbWf
        LhmI/XEF7trfT6Djo9ymZqb4BK6BaToNEQ==
X-Google-Smtp-Source: AGHT+IHbBUlyiWnQL0ZKhN6GUkjXp9o1sUaGiprlLSq9PpYCXYmE0v5xf604HXaQ/15w6RmWBHjD3w==
X-Received: by 2002:a17:90a:a581:b0:285:a1fb:4ffd with SMTP id b1-20020a17090aa58100b00285a1fb4ffdmr4559000pjq.1.1702556521351;
        Thu, 14 Dec 2023 04:22:01 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090ac08a00b0028ae9a419f0sm3042882pjs.44.2023.12.14.04.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:22:00 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id A393410205C51; Thu, 14 Dec 2023 19:21:52 +0700 (WIB)
Date:   Thu, 14 Dec 2023 19:21:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ryan England <rcengland@gmail.com>, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Outreachy <outreachy@lists.linux.dev>
Subject: Re: [PATCH] staging: rtl8712: remove unnecessary parentheses
Message-ID: <ZXrzYJrgewdXP6NH@archie.me>
References: <ZXn/JjyrLGQzS9zD@kernel.ryanengland.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s5FMv0bSj2naLsZb"
Content-Disposition: inline
In-Reply-To: <ZXn/JjyrLGQzS9zD@kernel.ryanengland.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s5FMv0bSj2naLsZb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 06:59:50PM +0000, Ryan England wrote:
> Adhere to Linux kernel coding style.
>=20
> Reported by checkpatch:
>=20
> CHECK: Unnecessary parentheses
>=20

tl;dr: see [1], [2], and [3] for why Greg NAK this kind of patch.

Thanks.

[1]: https://lore.kernel.org/all/Y%2FiaYtKk4VSokAFz@kroah.com/
[2]: https://lore.kernel.org/all/20190626015622.GC30966@kroah.com/
[3]: https://lore.kernel.org/all/20190401060216.GA5286@kroah.com/

--=20
An old man doll... just what I always wanted! - Clara

--s5FMv0bSj2naLsZb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXrzWwAKCRD2uYlJVVFO
o8+NAP98FzD1B6CV4uL2FchjaZ3vn6JaWdAhDfuSox9ccpgixgEAxp0n7hdXcxzO
48a5vUg7cL57+Q4Pet5w+m0GjJWRdgY=
=CuBH
-----END PGP SIGNATURE-----

--s5FMv0bSj2naLsZb--
