Return-Path: <linux-kernel+bounces-55838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BDE84C244
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25ADB2A936
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE304DDD4;
	Wed,  7 Feb 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzTtPjzQ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F3DDA1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271830; cv=none; b=JxYtNb5/JpHLu+Me+w0cIACZqVq5NXCNQBYRS++2MXdrdoWGpyTsXeXyMBt6xr3DUvlp2v270f0I4l83fv2lIJPudZgRcilJkf8O38KyiPeCpkbZEJGLH7Uk7tmoi74R6+rfoPCz3RqHUcxxONVYQEs73okSr1Ac0TUrAWz8vkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271830; c=relaxed/simple;
	bh=PCQ7Gj9QWzP+srbqgGUy1FtW5pS8vSwx8NzbVeevI2k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl2TozO6ifUGfqQakiphQbazqsbdzvjBFnojgGSvOMHTb2+IDigAszM7NWsijxplQPKfL/rPCTeiXwDk1BO1+G6Lw+VzMgD+vLyTcvf43eCdpNk4HUdGBCkmzYZPp9WixlHXAqSctbP6ZLsR/ATnuLDamTijg0M0hfhxaIgSQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzTtPjzQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e05456a010so130162b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 18:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707271828; x=1707876628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCQ7Gj9QWzP+srbqgGUy1FtW5pS8vSwx8NzbVeevI2k=;
        b=dzTtPjzQV4Nk8yUlmhvhFvS70FTOe91txFgIuctLVFhzQGuQV0y9P7p3nqhzAPXsN0
         IXErIerHw3utEVmsQBJ6exRsLK5Rgv0uh+Oioeeir8h5KrECUlQk5FJjX2kJK9GRdq3R
         7zAV2vL4iAVG+w6WNUv5yP2nQvXj7k8VHgjwXjzG8CVWLb9uUE6WocEg/MAZu3scHH+r
         PtKp0cYObC9ylTQmLb0b8uLxM1JicVpvsMExn1R4gly6iPEptxiV7G4tCxPpEUsHLwfZ
         u6m9zGYoxIVQDh+yfSaxzGMKj+05aAdUxlyV/IF7rFbfiI/4SQEq7kco8YyLEuzgse8S
         Sa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707271828; x=1707876628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCQ7Gj9QWzP+srbqgGUy1FtW5pS8vSwx8NzbVeevI2k=;
        b=jsjHu7iO4qnJQQ3ZYgLYTbIkgko4rNzSr9Jk+Y3jy/pWvYlbD/vJMhpfwaZVZxi+cQ
         DC6UvlL1CSOU3Sju0TF00CTGS6SaDTk/2t1uIk6Rq20iCFPDEaQCo4naz+IRiiDvLX4z
         5rBLjuBrvhupAS/5sSUE/SmRRb+XBkCRnozq4Npujsnre6k3wpCEpO29y1LHGC1ar6zR
         gS5J+otM2DS7Tm4hwtGcZJP+2osd2lVVb1RZlnjiFVDz/yRHe0oAixju6d0oV5W7aGEN
         uj68LFQ/oTH9I/XmCmlNVy99QKTXo5VH7vpXbj5nwgiSg3jA5Gcxi+qjQ3RXbEYECJZI
         LXAw==
X-Gm-Message-State: AOJu0YyJp8EsXz+r/m7qTeEURv8qpRaVqWH1nGTQt3xZJguipo9eFJPS
	p3zsG/P5KKrYMpK+4IxWewE09wytKzen+7hRr35zMp9SRchUUT8zF+xRjo4Hkmg=
X-Google-Smtp-Source: AGHT+IGxiEwRnKC11TyvSOmZ7VjMC6SrHhyKqA1jK89ZsEkR+d6/6fPURqY1ohXn9XgL9DaBZDCOUw==
X-Received: by 2002:a05:6a21:3a94:b0:19c:5651:adc1 with SMTP id zv20-20020a056a213a9400b0019c5651adc1mr4087695pzb.38.1707271826064;
        Tue, 06 Feb 2024 18:10:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWR9gyVN7Jao4kCsBnTUERjr+vaD+gMtpFFdZtntxGlE2ExDoxRsUK41glWK3KGx3WNhkYjZX7e0j9FgWrv76T8dSnFk1wozHjt8cc3
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id gd8-20020a17090b0fc800b002960e3745d9sm2513540pjb.13.2024.02.06.18.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 18:10:25 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 59549184797C6; Wed,  7 Feb 2024 09:10:22 +0700 (WIB)
Date: Wed, 7 Feb 2024 09:10:22 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nir Lichtman <nir@lichtman.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: add boot param to disable stack dump on panic
Message-ID: <ZcLmjrBxE2BA_hLG@archie.me>
References: <20240206213902.GA1490631@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UQDW+9kRGM8WYLKU"
Content-Disposition: inline
In-Reply-To: <20240206213902.GA1490631@lichtman.org>


--UQDW+9kRGM8WYLKU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 09:39:02PM +0000, Nir Lichtman wrote:
> From: Nir Lichtman <nir@lichtman.org>
> Date: Sat, 3 Feb 2024 10:19:30 +0200
> Subject: [PATCH] kernel: add boot param to disable stack dump on panic
>=20

Can you describe why this patch is needed (or beneficial)?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--UQDW+9kRGM8WYLKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZcLmiQAKCRD2uYlJVVFO
o0y4AQDT40rp2o7yPBEMbHEOW4SMrvQ1howJNYThIE3qMFO4mQD+O2lepbuCAQ2P
r/XYquEJJsq8eUOATdSz23U6YjqzAAQ=
=A6Wn
-----END PGP SIGNATURE-----

--UQDW+9kRGM8WYLKU--

