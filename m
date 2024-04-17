Return-Path: <linux-kernel+bounces-148287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215538A805E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444711C2127C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42EF13AD14;
	Wed, 17 Apr 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAzs3ZuR"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758C13A258;
	Wed, 17 Apr 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348342; cv=none; b=aKotXkkS9xCcP0POe5Kk0jopAB7BOFPVzZQjBY5ItccajdNy7IPztNuyUrw+3d8oFv4JcGlXSkTzt6NOmq6P9+yMLtVbVzIZZXlO9N9EuEGG5kSFsU0V9bik0qNB8++Zkksa4e1mH7s7eL4PjnzNqLWTNS1pm7Sr1vzzFS5qKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348342; c=relaxed/simple;
	bh=1gRmg87JIr+AbQO3Esc+cHkCY63QUm02iWl6ErooOoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1gfO8ucyMfydlTHUFuf9SDLrFAoOZtjhQTv9e5gmJ0MS085w7yKlIvYGQM0CH3QHioEMnV8t4QcSG0PHBqo5XXIysRhL3KK8ee57DyzH8JykzQcBsQVJWdAXRlcUk7wutKUgbASxupaZd8yiGqEocxZFgAJ5kU99suoVpVtCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAzs3ZuR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso4045939a12.2;
        Wed, 17 Apr 2024 03:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713348340; x=1713953140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gRmg87JIr+AbQO3Esc+cHkCY63QUm02iWl6ErooOoI=;
        b=AAzs3ZuRJX7XDEU/S31apMVw0w4s7Q7KO0FdVCxGcPYSQYxeRSY28pC1eu3Nrio5c1
         /8hlCKRtkZAgyv8u2ZkQRGfxaZJMq1OWpJiBVcvOqdTd2WBLQIZ2kjfFBum4N2R8Isih
         f2SkFV+0ugaXXipJ2Nlmu4lZAs98Uu7pgtHxn5StoZ+osrPawfSsDoFTHgEoyq2Tt6Q8
         NRjLJNg4pvoJ5WApc/OPQ4IAFhbQ7RH2Kz3RT5CY8e2rwsQ/E1wXGXRIyVxPAPyHxqu0
         xXjLmG+nWpVe8EKo2OzaEGE6HiF4EW+wqWYp7nr6UxxOhqD0p14pNRRYbP31JFxGWdYJ
         BuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713348340; x=1713953140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gRmg87JIr+AbQO3Esc+cHkCY63QUm02iWl6ErooOoI=;
        b=iIRsi31AfcqzDKUNNO6o9d3ib8xGzePLs9voX9qMDY78+WB0gtQYpo7kXPOBnw2WTm
         YzYRwT+Oo0gI3yiO4xGWx6DR+eU0urjiDqvVEdgaDP/jcMcgDaLBdIH6/wDsRP3KCpgl
         Pz+utAPk2ispxU0TLWkBdG2f4Y4/LM1n+AfVbxPPAGTpgEf9i0JxbOqcd4fZCsMHsSE0
         pmro/RaRuyLVSEcdLlg9r7LgoRzpd4G5HWENm4VxUvcuRbrI2iiRiJTACsZIVfN12aSC
         5gZk7AoirKe21tUqOoK9HMtPad2H4a5jwUjYz7cl5xmXvftqdXkjqWsHFMN08st5+AzW
         qHEA==
X-Forwarded-Encrypted: i=1; AJvYcCX7IS6j45Gfqpkz+GTYOT1w1GCNrANLl/xhNlogdKJkw3K3EqUqgFKkc2TgQcow4QdjzjHAuB5G3fNaypVxqolnIJrRwppo7MhG2zZs9+/T/Nbl7SXr3Y2gQvvWRjUjEaiFSkIs1YjlyYKaPbKoSs+JVjxeDE6jhEgRQPQzpZbQHKVI10sX1XjmInTqEUNM70jCiOsLvZiLojjq55CPA52TGCgxr5GK93NyY2kPva240GtdGqkSCf2ItMR1qGvwAKhKpy4rGF4SeQ==
X-Gm-Message-State: AOJu0Yy7solfZwT8Xrej9ZNsZNk0qeXZSEkViORqFlj1vWa7k1MVELAA
	SlxwR+1FqfC8+ES8QkGdUbyMlj4fEsK0Id+6u0iD26wAp++h3IEJ
X-Google-Smtp-Source: AGHT+IHoSQwgWNaYYN9PHfJ92Leu3dCSJnPJtoI+4IJ8iitgaNIncK7hpg/lzzZCpwVd83QGt3/Z2Q==
X-Received: by 2002:a17:90a:108:b0:2aa:7057:437b with SMTP id b8-20020a17090a010800b002aa7057437bmr6040509pjb.16.1713348339921;
        Wed, 17 Apr 2024 03:05:39 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090a5d8c00b002a474e2d7d8sm1019325pji.15.2024.04.17.03.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 03:05:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1682E18462BA0; Wed, 17 Apr 2024 17:05:35 +0700 (WIB)
Date: Wed, 17 Apr 2024 17:05:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net,
	zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v17 20/21] Documentation: add ipe documentation
Message-ID: <Zh-e7945DM6f2u9T@archie.me>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
 <1712969764-31039-21-git-send-email-wufan@linux.microsoft.com>
 <Zh0Zh3-xraVl85Lm@archie.me>
 <a2266217-c3ad-4bb2-8188-498a2c8ae36c@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0nWDRmFxn5oWDUvp"
Content-Disposition: inline
In-Reply-To: <a2266217-c3ad-4bb2-8188-498a2c8ae36c@infradead.org>


--0nWDRmFxn5oWDUvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 07:56:16AM -0700, Randy Dunlap wrote:
>=20
> On 4/15/24 5:11 AM, Bagas Sanjaya wrote:
> > The doc LGTM, thanks!
> >=20
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> Hi,
> Please see netiquette, section "Trim replies".
> Thanks.
>=20
>=20
> --=20
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

Thanks for the tip!

--=20
An old man doll... just what I always wanted! - Clara

--0nWDRmFxn5oWDUvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh+e6wAKCRD2uYlJVVFO
o4TXAPwN11FytsnDX/+gFpUvWYFc3CxPaaA7sJCuHF5qVYQtGAEA6GP0hs+AljG4
tOsfo209C7he+IJJJUnxDpScnZoh/wc=
=jvcJ
-----END PGP SIGNATURE-----

--0nWDRmFxn5oWDUvp--

