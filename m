Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78B1789D3B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjH0LQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjH0LPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:15:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2682113E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:15:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68bed8de5b9so1493685b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693134951; x=1693739751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Yb9ywtrv/VosRqMU0PvJeYqFdA2q0hHR5WEiWHTEQo=;
        b=VbXYT8MSBbfPtxYCoDDenmi/fEbHKGio/6h0Gll1oi5aBP+Q/iJExw5R2H46pWlKTe
         ioMN7F7h3qYfzpPqGGxQonTG6n/EaNBA3eQVlIr5n8vHozpYoIxlfjhx+0SOHOrzQrIC
         y5uZJa155RFS/qPJrXeL7x/Nc2eEd4gbXxX2GNrrYaEwIuO74br//oJxJptIkSd6h30i
         RldleW4oyV5FTE6H2EADHYVE14V6pWi3IZnQMPU3lnz/+lmpwLp37Sc8J05DPhAkObEF
         P3i7OUI9wOjZGS1yAx1oVsuzYySxqiQO1wX3zxdTCdsN8V+OexQXE16CwlhXf/Wv1cwC
         An4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693134951; x=1693739751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Yb9ywtrv/VosRqMU0PvJeYqFdA2q0hHR5WEiWHTEQo=;
        b=JJxcHjESubjfACei3NCHi2Xq3xLcLItUAlQa8C3JfHlQ7AvJHTyKwKWe4kheoh5c4a
         olNJ0TDM7cLfr65XxKnZkE+eU25/SPXSIwfGSxu0yIEe1j/9eng4tvt7u35QNvesPlJi
         qX3pLLD/6D2F36Xhk0DvATmofr8XMECypYeBr3nWLsn84Nz88OlyJe4fsIRUObCwIfr9
         3j4zC3ZqFZmZhMGTxBcAkHIBiiOjBNnENKDkqRhFVIeGyAyOy3zzKi1CEyA9sfg+2Ivw
         UgLtpKIaQ2KqBBJOcdFUpoAlaSmViGHzUzNk5NOAu8KqZS0bLvrscsscn0VoXgoTAyoi
         YjQQ==
X-Gm-Message-State: AOJu0YyRlmBIx0k7XWRNjS22wJwWYtA2Oyoo9vBaR0DjtnlLALBOiPPA
        42sDC8VpQiaUrns6z3aaKGE=
X-Google-Smtp-Source: AGHT+IFWJVeHxuSa/N6as2E1vzawmgZYP44JJ6nbtGg4KzCf5GkZarut6qJryU/+4i9JmFVLxKCZYg==
X-Received: by 2002:a17:902:d345:b0:1bb:1e69:28be with SMTP id l5-20020a170902d34500b001bb1e6928bemr17853040plk.42.1693134951550;
        Sun, 27 Aug 2023 04:15:51 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b001bde877a7casm5058546plk.264.2023.08.27.04.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:15:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C853581BD5A2; Sun, 27 Aug 2023 18:15:48 +0700 (WIB)
Date:   Sun, 27 Aug 2023 18:15:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: 6.1.48 regression at boot : WARNING: CPU: 0 PID: 0 at
 arch/x86/kernel/alternative.c:572 apply_returns+0x1e4/0x210
Message-ID: <ZOswZJ/uVtm0Qvjy@debian.me>
References: <3d6fbd04-2861-91a8-938c-45195f307eed@gmx.de>
 <ZOqeRpAHzqLDrlno@debian.me>
 <875888ab-9934-b29c-b69f-189b195ba68d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DPyTEa0P8mrOep6q"
Content-Disposition: inline
In-Reply-To: <875888ab-9934-b29c-b69f-189b195ba68d@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DPyTEa0P8mrOep6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 27, 2023 at 12:52:14PM +0200, Toralf F=C3=B6rster wrote:
> On 8/27/23 02:52, Bagas Sanjaya wrote:
> > Do you have any external modules?
>=20
> No.
> And I can confirm, it is a regression.
> Latest mainline I'd like to avoid at this system.
>=20

Sorry, but to have your regression fixed, you have to check the mainline
to see if it still persists or not. And it is also helpful to perform
bisection (see Documentation/admin-guide/bug-bisect.rst for how).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--DPyTEa0P8mrOep6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOswZAAKCRD2uYlJVVFO
o1DxAQCIrvbDpue1aIGNHoWSIdX/aTZY+ikpJ9kfZwYnEwSqMAEA13UxZu7e2viO
hncZtf0yU/EmHnZYcajuQKAZ/Ci4MgA=
=o94C
-----END PGP SIGNATURE-----

--DPyTEa0P8mrOep6q--
