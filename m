Return-Path: <linux-kernel+bounces-23433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F92282ACB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C11EB279AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D2914F75;
	Thu, 11 Jan 2024 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnCVlOR1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19B14F60;
	Thu, 11 Jan 2024 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3eb299e2eso32260815ad.2;
        Thu, 11 Jan 2024 02:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704970685; x=1705575485; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWamW41Ap8oPTNtdnzB8JWBusKcGic3r0TyiCdKA/iE=;
        b=gnCVlOR1Vv+DgsETON4rR0wm53RPkUvzjlCrXl9jqA46MWFPyaiQyKF6SXVvqM8Uk0
         4bAkmERMh1OMvryWiZ5nes4j+LYsnP7HalFB61jQhPuenKgEjrdcHQMbJJzrBDjYs0qa
         xEfPrMRt0MkdGH9pgjlSK1+fSSCqkS4xnNFDWnmzg4kTsu6fv2nCW1SY+lO051ekzzqM
         QZitFG26kVzidNFe7BLdl+gjuJWNgGy4bOccDx7opI12tU0MbgM67JAfRZe0ODTyW/0t
         3M5oVHFdWIzJDwVAdZ+sslwVJgkbYxwcEMBlIDDDCO+TkGe4Q2L7RKVhaGZDGnS5z/ZA
         5kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704970685; x=1705575485;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWamW41Ap8oPTNtdnzB8JWBusKcGic3r0TyiCdKA/iE=;
        b=CnfqXedSDJZ4v2MkmgcK4OADyk9/ebaA3phYItt777n2rqoZJ/3B+4RvxkEABILnEH
         re67fSs282R6Cs6kS/VV8tmRwc/xBn6H/pteZgxGdwiAQ1NraafMK1zThMR1Ne/3oTIh
         Z9OpLVowXS9XGpJnfyXkOC2CLasumdIERkvIK+SwBBQIm0TSZZ4aLUwUP5cmJ65P5LbQ
         DPpD67+EezCX0vAkSJ3GsVIaeZubxjBeodBH2TGGMgSQFeKGO7sECHcEe+S6yuVAVmDi
         oYEKYtNkdWZEs+mQOtU6rvcQqJ7L8xMBD2tXbNF/uIc9E76/HELNU56jHtQmIfdnlvBx
         oetg==
X-Gm-Message-State: AOJu0YwJoKk2lSN8pu0H5BANW04TrHyFR4dOQ/DgYtPYeWZW1V8XE6Dv
	TFNlZDOjmY9bY0o71qqNDEw=
X-Google-Smtp-Source: AGHT+IGEJmiv9Djq3/WfoW+VTA+3JXoOAH7U0B34FApIQWSNLeGcAmUYrMopts7S+gaYCex3VKSuLw==
X-Received: by 2002:a17:902:e88f:b0:1d4:ceaf:e7bd with SMTP id w15-20020a170902e88f00b001d4ceafe7bdmr819484plg.99.1704970685243;
        Thu, 11 Jan 2024 02:58:05 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id iy12-20020a170903130c00b001d536a910fasm903632plb.77.2024.01.11.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:58:04 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 8B4951864A63A; Thu, 11 Jan 2024 17:58:01 +0700 (WIB)
Date: Thu, 11 Jan 2024 17:58:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: What to do on MIA maintainers?
Message-ID: <ZZ_JuZd0RJUzIrgY@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BYm8BsRp/pqDToxj"
Content-Disposition: inline


--BYm8BsRp/pqDToxj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi maintainers,

Earlier in late last December, I sent a patch removing Karsten Keil
<isdn@linux-pingi.de> from MAINTAINERS due to inactivity [1], but Greg was
unsure about that [2]. So I privately tried to reach Karsten (asking for
confirmation), but until now he is still not responding to my outreach, hen=
ce
IMO he is MIA.

What to do on this situation? Should he be removed from MAINTAINERS?

Thanks.

[1]: https://lore.kernel.org/lkml/20231221091419.11764-2-bagasdotme@gmail.c=
om/
[2]: https://lore.kernel.org/lkml/2023122156-diocese-movie-3d75@gregkh/

--=20
An old man doll... just what I always wanted! - Clara

--BYm8BsRp/pqDToxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZZ/JtAAKCRD2uYlJVVFO
ozkUAP9szxEqgdPe1IMIXsaME+pJR8JQd6UbQsdKADzuthaWVQEAqf1Sniqmm9Iv
Yv79OMOp7ZCyowFW6JEoGFalIYqgYgY=
=Gv1a
-----END PGP SIGNATURE-----

--BYm8BsRp/pqDToxj--

