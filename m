Return-Path: <linux-kernel+bounces-41640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69883F5B8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831B91F22D3E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F9723776;
	Sun, 28 Jan 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWG48D/t"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C1CA4A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706450667; cv=none; b=UNoE9F+KQUiLuZTt96dH1xFjevDlz2izyR4R68+4hB/D46LIxsAedXoWZKHI+d/KWOBi7TFGB7Ea1Lrp90p+CeMBqRwhiaaw9JAOwr9lAg5xGLB5OQE47PuAzDFjE99tLSeMvD4auk6REW3mOoqdWyJhPLR9xdXOF7tvWH9dtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706450667; c=relaxed/simple;
	bh=3iDitO1XNkEO8CSUvtm1MSYFm/Pm3nL+trS6JqCDr3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjzQqffuWtnm7FHkEcObdQ29ilb0g/b6Qnkzj+SKLKYa5MGy7oB6NwV+EqRRSQWzr45h7YUXR+fHOIuvbPF7vOD2tzTt6Ol9lCXWw6DSEznlLWXZTP4F7ahvo6DzhReHq0XhGc66TAIvPBVfsaYdQ+kYGh74YUkOXx0u9OXwBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWG48D/t; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-290b219a60cso1070868a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 06:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706450665; x=1707055465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3iDitO1XNkEO8CSUvtm1MSYFm/Pm3nL+trS6JqCDr3A=;
        b=BWG48D/tqF65WLUh5yelOpdYJBKmCMUar0oL6pFl5ogki8OWrlhBpXfnIXEj4wD9A7
         1pqXw3V7q8YbokeF1FScGQxEuQzcYmWYj26dFnO84GvLQeaV93g+0AwFBR6XHkjYTSkR
         GV2hrR7lR6hNXDM2e9ZX0APkrdCtAtgjbcu6ueHW2o1k+8SPGngCt6imn/uV2G/ZM/zw
         x3igm0jyDg4urtJPARcZXCKRF7HSeayUQFsOtw9yMoiaerD4VhmHex5bTsuKL6z04+zF
         nealW9Ilmq4lN1K1qJJoljOfobKoN59lP3O/uyyPPWhqdOVK0GJI8LTCop/0HCBQFs0C
         LkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706450665; x=1707055465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iDitO1XNkEO8CSUvtm1MSYFm/Pm3nL+trS6JqCDr3A=;
        b=dc6fxqDZpHBvYc0WBnP1a2Wq0ANFYAPDS3C3UZ5ug7EOCsqErHRM62ejMwxOkLYKzV
         cAqMKBto2W9isdmEcRbGk8yuGbjNRxvAs+mFpkmTnR9VPMEkGf1CJCCkn7a2FV6ejYJ1
         gWdKrfb1k8xa5Ybv62kaZSGjZBHuehQsp3yfLzSXiNLVBBMlNTHJXR+0kUC29K1VDraO
         P+UdAttorjsdxEyO0qxg0s+T5pY7SV0shEhQpVxy1q2UgE+eatz9uv0HX2hI4/ktoeAl
         pIsXyRC7LRxhwmm9wt0zEXRyaXkW6hbKNd5G9ijal9ovCf6YS6DT8ccg3hcl5fEKxM8q
         2Ctw==
X-Gm-Message-State: AOJu0YxP+bGkm5tZPNyCLWl/f54BHd8RDDs5+zWQM/CDSHZZjS7OuIOF
	lg3efeiKQUuFSQmFJ+B8h/kEk3iZcJVFt5/Xa314nEttSbbQMVJWwszmxCji8wE=
X-Google-Smtp-Source: AGHT+IHySygltUDdBeoABvI+VRWCAp7UW1lj4DSCvMTPZndGgwx/hK163rGzw+PEhFUHWMTluhKl0Q==
X-Received: by 2002:a17:902:b492:b0:1d7:8cd6:24d6 with SMTP id y18-20020a170902b49200b001d78cd624d6mr1360293plr.1.1706450664739;
        Sun, 28 Jan 2024 06:04:24 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id o19-20020a170903009300b001d7233f1a92sm3701937pld.221.2024.01.28.06.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 06:04:23 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A9D54184E3308; Sun, 28 Jan 2024 21:04:20 +0700 (WIB)
Date: Sun, 28 Jan 2024 21:04:20 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Frank Tornack <f-tornack@t-online.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: Western Digital SSD freezes on power saving
Message-ID: <ZbZe5OPlqhwi_erM@archie.me>
References: <dfe9213bb86939ca4502b5b3fdd3ab77ef1b6f1b.camel@t-online.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kEwaUIh9YENCpawV"
Content-Disposition: inline
In-Reply-To: <dfe9213bb86939ca4502b5b3fdd3ab77ef1b6f1b.camel@t-online.de>


--kEwaUIh9YENCpawV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 01:26:23PM +0100, Frank Tornack wrote:
> Hash: SHA512
>=20
> Hello Linux kernel developers and experts,
>=20
> I have a question that I think is not tied to a specific distribution
> and goes pretty deep into the Linux kernel. I hope you can help me
> without subscribing to the mailing list and remember to include me in
> the answer discussion.=20
>=20
> In my old notebook I used an nvme-ssd from WD (wds500g1b0c-00s6u0),
> which is affected by a well-known bug. I currently use the parameter
> `nvme_core.default_ps_max_latency_us=3D0` to prevent the system from
> freezing.=20
>=20

What well-known bug?

> I would like to use a new SSD in my new notebook. However, as it is
> difficult to sell used SSDs, I would like to continue using the old SSD
> affected by the bug. I plan to move the SSD to a Thunderbolt enclosure
> for this purpose. I think since Thunderbolt is based on PCIe, the same
> energy saving measures and the associated bugs will probably apply.
>=20
> In the hope that my new SSD doesn't have the same bug, I would prefer
> not to disable the Powersafe in the laptop. Is there a way to set this
> flag only for a specific SSD? By identifying it by name or serial
> number?=20
>=20
> I apologise prophylactically if my question is completely out of place
> and thank you for your help. As a long-time Linux user, I would also
> like to thank you in general. If you have any follow-up questions,
> please do not hesitate to contact me.
>=20

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--kEwaUIh9YENCpawV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZbZe4AAKCRD2uYlJVVFO
o0sTAP0e4mQ3HmibZI7L+IrnI0a7gqHZTwdd3/HRZjxoxkCvrQEAnruBM/+E0z3i
+n7z/qvGHB34EXibxnmxzV6vk6wxggc=
=jxdY
-----END PGP SIGNATURE-----

--kEwaUIh9YENCpawV--

