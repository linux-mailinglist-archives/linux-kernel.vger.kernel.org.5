Return-Path: <linux-kernel+bounces-41510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 763FD83F2FC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1329D1F2260F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA806FB8;
	Sun, 28 Jan 2024 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8zo2wPC"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1312539A;
	Sun, 28 Jan 2024 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408321; cv=none; b=YlHdo8hf25IY6RD7rGJkaxVuLlRc2fo1pBdLwdJzh9cqRqaXcd8oIrSqDi5pLkgkp5acXvO1NiAdgU62mNI4SrvdYdbGMyhu8miUXSlNZaqPd4m3ZuG4juRsxJrFClGU/Ba7OfMnS+CmWWmXAG5MVniyd1sFmy5NhX7evz3jXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408321; c=relaxed/simple;
	bh=26YGlgSUeQwTXup9PHvb6iEOzNbarNhzu6L8VCS/7Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8+KyRtVHzg2E9sk+ZZQ8X9RNG4wUGKGOiADFWr+QPORf87cORgfSM8oNRegBMd1hi74TGXxInDdX5ypdDIWCH6zx2SzjimrlFCtd8tdDpopoYc3ANg60UuVKzWpu3+9+xLEF7ciJCQFuIPJffiOjeTukbemOhZIErGskL8ekmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8zo2wPC; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e117e0fee8so439467a34.2;
        Sat, 27 Jan 2024 18:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706408319; x=1707013119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LX4mqVYij6KEkFtWInw51O9XUMFwiWF+hZ3Lbcz68b4=;
        b=O8zo2wPCQVP0iTnOOzs6QRxYQx5UvxT8lTHIBGgdI8b3NMoWV7OKyhZjawCQVvmQFJ
         uyCHN1+U1XZLYoeodXu7lQUQpQkEuJJ2rFigUzsAC6ogg+H2YFs0bE+TZbB0P48n0ljg
         7v8rJ+HGAhZctEOY/o60+5bJyW2T8GTPbdJcZxkMLIeVe2w2Lngbcnpt4YkNPFrxPjX+
         J03k7miPm1pIwcC9hd5Rccd/ub6DBQkLC4eB8vUvcBcrJP/+VrV4Xbkldt6WfM+v5YyZ
         rcUTL9kPThgAEBbAONHGkICkqlYIXUQgKbmju9PL2pFeS55PGVa0ii1Lpz/7VSy0q9lE
         engA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706408319; x=1707013119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX4mqVYij6KEkFtWInw51O9XUMFwiWF+hZ3Lbcz68b4=;
        b=bo98zoZ3Po9KmZs1BKJDDvlb+Nds7etV40IsVOkUq3sr2cmJQuFWpZ5Cndt+i5WpeM
         /kV2gyVj9ezWg2ULjEZGORw9o5IABTiTTQ4Hi6QdiJ6DXFEwQqJqrY3Pv93p2ku72Q1x
         6HGnYZ40zy/gjWO7rAf1ZCqZWaHeX3ns3MXVCWQyaiMW97yYdXWxHlo4/Z6aP0z+XBKk
         l/ae4kcWozOKp8zK/JDWNGVVJTzz2iyTsnIbFkebechocf++X26P40GU8WT9it0IdxU5
         JwpMJY/alnUotPJH2jDTOBB/Ip4mVPKkPk96n/VAJC+d2XC1uB6TcfOTIfrFbOjO44XM
         JI/A==
X-Gm-Message-State: AOJu0YyTiWanRmpxFJSPvqP4i/opTXSQT4c2vi6+NzqhPr3g/WusL4WT
	B/ldjpuJp/vcmnxQceZvINCudh5etK0tqx5W5kB3Po7blhvRiuMgVsGTB0iZG50=
X-Google-Smtp-Source: AGHT+IGcixK/L0BwSGtpQKvqwR9URrR4xk6sq2YDEJNjTNIpW1x3LobwCStd9u4g6gLFEQr0FmgszA==
X-Received: by 2002:a05:6830:619:b0:6dd:e810:3ab9 with SMTP id w25-20020a056830061900b006dde8103ab9mr3151539oti.4.1706408318659;
        Sat, 27 Jan 2024 18:18:38 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id k1-20020a634b41000000b005b7dd356f75sm3513189pgl.32.2024.01.27.18.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 18:18:38 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id C372318523300; Sun, 28 Jan 2024 09:18:34 +0700 (WIB)
Date: Sun, 28 Jan 2024 09:18:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Thorsten Leemhuis <linux@leemhuis.info>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: More detailed text about bisecting Linux kernel regression --
 request for comments and help
Message-ID: <ZbW5emVndDNZlPTg@archie.me>
References: <c763e15e-e82e-49f8-a540-d211d18768a3@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q5Ak87mt+ZHiI+QT"
Content-Disposition: inline
In-Reply-To: <c763e15e-e82e-49f8-a540-d211d18768a3@leemhuis.info>


--Q5Ak87mt+ZHiI+QT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 01:19:16PM +0100, Thorsten Leemhuis wrote:
> .. _bisectstart_bissbs:
>=20
> * Start the bisection and tell Git about the versions earlier
> established as 'good' and 'bad'::
>=20
>     cd ~/linux/
>     git bisect start
>     git bisect good v6.0
>     git bisect bad v6.1.5

If stable release tag is supplied instead as "good" version instead (e.g.
v6.0.1), as in many regression cases, git will ask to test the merge base
instead, which is corresponding mainline release (in this case v6.0).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Q5Ak87mt+ZHiI+QT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZbW5egAKCRD2uYlJVVFO
o5DeAQDTPa/eTL2vmdlMXx5dd/SS6WEDl3lfwEv9dC1T2bZFLwD/XGGr0HikyNc7
hYOttmeJADRT8PIX/8b8PdVtP0V1KQQ=
=98El
-----END PGP SIGNATURE-----

--Q5Ak87mt+ZHiI+QT--

