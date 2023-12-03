Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDC6802078
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 03:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjLCCtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 21:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCCtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 21:49:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C2A11A;
        Sat,  2 Dec 2023 18:49:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2866e4ac34bso962298a91.1;
        Sat, 02 Dec 2023 18:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701571777; x=1702176577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGe2F7cGTUh0qqkd0zgqhOnKjigD2/54N0FZlpwMCw0=;
        b=JGXq8tgHbpX9DSAGX1XKNcgGp/BhQvrGnUjGv7olG5rtjh4oTDVwNG1XM014dZ7VKz
         h8JnVFL5WNEvyNiSEPeZzxYlIr7sQfP9fQXPO0LRugCaLfth5njrJYV5kmFwRRsxnsH/
         7DSenRqE1UiBM9o6kzJAL9mfdwylOE7xesHRB5RNNy36EjxZ4qBDGWsQFlte+4c1hsDC
         0RUBT7AKKxdHe/88rx/6cOgpAibKWv08l/j27HesJMFR466MvLoGHl7+Zl3iDvbb1OaD
         o//l7VWdsAMFIKrhJnHz+USVumxxwX3HLHgrcX6JxFK5Y5L6oHdBr707R1hd5BYjv3k6
         7HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701571777; x=1702176577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGe2F7cGTUh0qqkd0zgqhOnKjigD2/54N0FZlpwMCw0=;
        b=hUWuuRAU8xBDbIkzLWp7yZu9qaao2FUErGDUesIMJ/2bEcWZW3iTGsueuLnkHhj3qI
         s/Yn1CQfRwy2iM0pNjMwQl6rKZP1baVVwDRyPAyUqzj4lEsGFQqTQemut6Ha12qCspJC
         hQLJuK67DYZA0dLTazSt/kdjHAjwi6IQZSLOdbH9Ctv58qofgu9P3fZOiXX2qiDGcJCF
         1TC91GWkcZmLtc9aK8GGWbhGfWx+tCy+xDPnRdSLhMWYDk1kUgVP82esFRXShWxmvnlZ
         G+dRmCuOmYOXMrg/pzI83D1EHn12QA7csHvg7dBB2+Uo/KFlJCvqqsRHSPxzPN5aFAMy
         knzg==
X-Gm-Message-State: AOJu0YwpLLS6dtNqo/igqYwFsWLGK+dDAGqdYiMhkZ/eVZskCxNeHo9p
        nItLwVciCECsXQCdbzfqz4g=
X-Google-Smtp-Source: AGHT+IHzROYfXZKYIhNJqzyhfQ0XjCFQr63D1lHq1V+7gD4GCJJ0JPigfk1ciJooizapJm7jOuKqLw==
X-Received: by 2002:a17:90a:be12:b0:286:6cc0:cae0 with SMTP id a18-20020a17090abe1200b002866cc0cae0mr1234911pjs.87.1701571777633;
        Sat, 02 Dec 2023 18:49:37 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001cc8cf4ad16sm1438306pld.246.2023.12.02.18.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 18:49:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id BCD38102894F8; Sun,  3 Dec 2023 09:49:33 +0700 (WIB)
Date:   Sun, 3 Dec 2023 09:49:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tsung-Han Lin <tsunghan.tw@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dcoumentation/arch/arm64: fix typo
Message-ID: <ZWvsvXYm5LgaSGLZ@archie.me>
References: <20231203011804.27694-1-tsunghan.tw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5h2W3nFBGs7wo8cg"
Content-Disposition: inline
In-Reply-To: <20231203011804.27694-1-tsunghan.tw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5h2W3nFBGs7wo8cg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 09:18:04AM +0800, Tsung-Han Lin wrote:
> Should be 'if' here.
>=20
> Signed-off-by: Tsung-Han Lin <tsunghan.tw@gmail.com>
> ---
>  Documentation/arch/arm64/arm-acpi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/arch/arm64/arm-acpi.rst b/Documentation/arch/a=
rm64/arm-acpi.rst
> index a46c34fa9604..e59e4505d0d9 100644
> --- a/Documentation/arch/arm64/arm-acpi.rst
> +++ b/Documentation/arch/arm64/arm-acpi.rst
> @@ -130,7 +130,7 @@ When an Arm system boots, it can either have DT infor=
mation, ACPI tables,
>  or in some very unusual cases, both.  If no command line parameters are =
used,
>  the kernel will try to use DT for device enumeration; if there is no DT
>  present, the kernel will try to use ACPI tables, but only if they are pr=
esent.
> -In neither is available, the kernel will not boot.  If acpi=3Dforce is u=
sed
> +If neither is available, the kernel will not boot.  If acpi=3Dforce is u=
sed
>  on the command line, the kernel will attempt to use ACPI tables first, b=
ut
>  fall back to DT if there are no ACPI tables present.  The basic idea is =
that
>  the kernel will not fail to boot unless it absolutely has no other choic=
e.

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--5h2W3nFBGs7wo8cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWvsvQAKCRD2uYlJVVFO
oxN1AP0X1zno8jcgzO4aJ5n2/YaFYaJZ8NPcXTSAtOIkVK353wD/dW031Lazzzxi
adLq5PxUvtQ6e7O0YK5tb8bw6xetdgA=
=NOAU
-----END PGP SIGNATURE-----

--5h2W3nFBGs7wo8cg--
