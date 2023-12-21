Return-Path: <linux-kernel+bounces-8267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858AA81B4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308A51F23D68
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CC36AB88;
	Thu, 21 Dec 2023 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlclUmpB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7D6ABB2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ba52d0f9feso473084b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703157356; x=1703762156; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntJX02IfwYFQ+8rtmxZSVkWghtloy7GUaFsfd5/JpEk=;
        b=JlclUmpB3Cs756HuyqZV4Gamib4YfK8Kg/m7Dc6easPLjvLJUTdZEzlRPu4AhF6e+O
         jtPzFEZo7d40aEFD6d7s8oMWQDCc3WRt76pvb5/jLkIyurko69RYZeYlE7dMSEEaxQ6p
         D4TOCeV5YEeW9LgSA8s7Oq2b7u9zSTzVVUw8snxY8lavaLLmUcCr9+Q45G/hJOSEdV/z
         fVmPiQb1gQqU/VykQnjHAtKseRfPBa1uEdlWoQk9DMmaFRONbEJb2Vp9ul51rmL9DGoV
         a0Q/Y3zVUG+lezMkVDfEAfm2sOKB1PqluIRRENaWk60Ej3qAbOR1UVUW/uMy4PFHxo5s
         HJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703157356; x=1703762156;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntJX02IfwYFQ+8rtmxZSVkWghtloy7GUaFsfd5/JpEk=;
        b=PJr3V5885IiE4O0dZ60lrFQdPnEVoBh940Rg4cDHnrvbPsPYJ+Kuw9JkuSEpAN+ZKA
         ZTf7wu0bi/HHXJHmNEKpdtm/nL5e6yL7wEwB19NfBDqd7sz64FQVRuzkfBwlhZtiwlEU
         ifrrXGCmib/UH2pKOZ+eJduBzoYFvp7XyYGHsMPTpvaxkO+PjNKEghkeYduvxcH4vlMa
         KUTMh0QGqZOUUBxeTmDuIVFi1cSS+JdjOUQm9wjnT+9iTxXO++M6vySwMF+k957COCr5
         UYLnjP2AbqdnugdnDn6KuZGabQnhfLki9hLGXrs2pc4m93GmObV4kfvkdXibtowWlTqc
         w0Qg==
X-Gm-Message-State: AOJu0Yz4ze7I2HFkRx7ODzKq66UIYY2+MLK0rxZTn0dj0B56vUlZNzi0
	xAmo+KCHux7poxz6o5AXDGM=
X-Google-Smtp-Source: AGHT+IF1PX2xxqgpxykKHUBh3IkVlPqnoWcPe4bNr3ejM1J0EeoraIuo705ems1ceqEBSKjsuTTh6Q==
X-Received: by 2002:a05:6358:887:b0:174:b138:6192 with SMTP id m7-20020a056358088700b00174b1386192mr781431rwj.26.1703157356156;
        Thu, 21 Dec 2023 03:15:56 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j1-20020a63e741000000b005bdd8dcfe19sm1339266pgk.10.2023.12.21.03.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:15:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 655A3101B1174; Thu, 21 Dec 2023 18:15:50 +0700 (WIB)
Date: Thu, 21 Dec 2023 18:15:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Staging Drivers <linux-staging@lists.linux.dev>
Subject: "Link in bio" instead of Link:/Closes: trailer
Message-ID: <ZYQeZjN_3bPOdKKf@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IOy+elnsY4ZQ97PS"
Content-Disposition: inline


--IOy+elnsY4ZQ97PS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Let's say that there is a content creator who submits her first kernel
patch (touching drivers/staging/ of course to get her feet wet).
The patch supposes to fix a reported bug, with appropriate Fixes: tag.
But instead of using Link: or Closes: tag to the actual bug report in
the patch, she instead writes "Link to the bug report in my bio", as
it is the norm in social media world. Here in the context, her bio is
LinkedIn profile (IDK if there is a way to add arbitrary link there).
The link in LinkedIn profile, when clicked, will list many links
(including her usual social media campaigns and of course the bug report),
which makes reviewers confused about which link to the bug report she
means. In some cases, she may disambiguate by saying in the patch,
"Link to the bug report no. 99", to refer to the specific link number.

Is such practice a good idea?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--IOy+elnsY4ZQ97PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYQeYgAKCRD2uYlJVVFO
oyl4AQDFmpF+DPHFIzFJyphKvMA2JTCPGUl3MdlFX7MWpYCtCgD+KAmls0qYS/hC
3dMHV3vv6tOClNLTn4amwF/0384xzQo=
=Vqzw
-----END PGP SIGNATURE-----

--IOy+elnsY4ZQ97PS--

