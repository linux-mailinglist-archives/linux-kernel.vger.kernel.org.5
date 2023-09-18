Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E4A7A43EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbjIRIEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjIRIES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:04:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1DC18C;
        Mon, 18 Sep 2023 01:03:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c44c0f9138so13404415ad.2;
        Mon, 18 Sep 2023 01:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695024228; x=1695629028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kSHFx/ukiXakjyE+cYGEXqzg1y6FwwMHwQvjaFzH+eg=;
        b=ntZ+KEKLqe6h5ssuG49ECEERZk2ZFZ5fDm/MgB6ZqVDsrlQQzNYXmTAOyeoWs0ekk4
         jPm5hRHZB3+jwP9gQxASuodybq6q8IqEZBdGzeyIykE0JONPVjBdvNk3eggus2Yr9Jdn
         7mSPAxeV89byf6kVp7pmSgTcaLlbjWaHLzsmZROztYGGoqed482GaLpOdb4Nwg5Ftssn
         1SIZ8pm3foqqLn98z8JtPgqdp2Qyp1JfNzgNFEF6njnCvmPHWkq0vqaToAxmlQG3/eIq
         vV1IAikZWvOQRbF1vaxIKTeJgkCDC59Xl3eVwcPjc1VGc+LU71iT8zL0QbJNbPuNlxEH
         1GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695024228; x=1695629028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSHFx/ukiXakjyE+cYGEXqzg1y6FwwMHwQvjaFzH+eg=;
        b=WwnzERhTIPJmu6Iida3y94j75PJOWtPDt1kRc/NSuqVMgaFwtYbT7Nrdicgf5/90qy
         kudZk0oWJ/htg17vAYwje/ATUqcYqsrFYseNhM7nrOGE/PkoaBFlcukV1xYZI+1IUf0d
         aZTaYNJaVgn6V+rODiz3B346WYc7nPxHfSc4kdUYZv6BCFStXATQf8iOU2uLfrKZzi3D
         DHGhN5zKMyX3oGHnVE3UprEIAoUAwYb9McMJ9Jl3vOTeSe9dazt2w/A1jJTvHt2d98gJ
         mGHzyvjluIMKaXXzX512AW02FA4PhQNNIait1vJ2+xu0MlNEc3C08kBEMbIbyZfM9kpx
         XnCw==
X-Gm-Message-State: AOJu0YzuU1W6buUCHr5e26t/94wfnQYx9dX0Zu/hNfmkEoNjlZfNlvgL
        3E+0U5FeFwH61AHwnctmj8Y=
X-Google-Smtp-Source: AGHT+IHAsYkE9L+yqjkeVZ5pDnFElaUhrE2Mg7tfh9mnA/M3LEHopKrnW/Mim8mLemtIiaARK3Mu0g==
X-Received: by 2002:a17:903:2450:b0:1c3:2ee6:3802 with SMTP id l16-20020a170903245000b001c32ee63802mr7591800pls.47.1695024227616;
        Mon, 18 Sep 2023 01:03:47 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id ja2-20020a170902efc200b001c444106bcasm4766369plb.46.2023.09.18.01.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 01:03:47 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 766BB9C621DE; Mon, 18 Sep 2023 15:03:45 +0700 (WIB)
Date:   Mon, 18 Sep 2023 15:03:45 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Charles Han <hanchunchao@inspur.com>, <corbet@lwn.net>,
        <djwong@kernel.org>, <dchinner@redhat.com>,
        <allison.henderson@oracle.com>, <bhelgaas@google.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] Documentation: xfs: Remove duplicate 'the' in
 transaction sequence process
Message-ID: <ZQgEYU71YE6Jv38D@debian.me>
References: <20230918074054.313204-1-hanchunchao@inspur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cwMqc1Pn7DQDXQN0"
Content-Disposition: inline
In-Reply-To: <20230918074054.313204-1-hanchunchao@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cwMqc1Pn7DQDXQN0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 03:40:54PM +0800, Charles Han wrote:
> Remove the repeated word "the" in comments.

Patch title looks OK but in this case, the patch description should also ma=
tch.
Hint: there is no code comments in the doc below.

>=20
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  Documentation/filesystems/xfs-online-fsck-design.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Docum=
entation/filesystems/xfs-online-fsck-design.rst
> index 1625d1131093..a0678101a7d0 100644
> --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> @@ -1585,7 +1585,7 @@ The transaction sequence looks like this:
>  2. The second transaction contains a physical update to the free space b=
trees
>     of AG 3 to release the former BMBT block and a second physical update=
 to the
>     free space btrees of AG 7 to release the unmapped file space.
> -   Observe that the the physical updates are resequenced in the correct =
order
> +   Observe that the physical updates are resequenced in the correct order
>     when possible.
>     Attached to the transaction is a an extent free done (EFD) log item.
>     The EFD contains a pointer to the EFI logged in transaction #1 so tha=
t log

Regardless, wait for one or few days before rerolling this patch with
reviews addressed. It allows other reviewers to catch up and review. You can
also Cc: me if you'd like.

See you in v3!

--=20
An old man doll... just what I always wanted! - Clara

--cwMqc1Pn7DQDXQN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQgEYQAKCRD2uYlJVVFO
o6vTAQDsti7y+n/hNMzhITP6F/5YrQQAP/ozJb9QCW5P3p5UFQD+NILb5c69nOGo
bm2NhOTRMNGup0xBvPJeGt57WaCLzAY=
=HhT0
-----END PGP SIGNATURE-----

--cwMqc1Pn7DQDXQN0--
