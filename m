Return-Path: <linux-kernel+bounces-41621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F8B83F57E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D961C20FCB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C9E2206B;
	Sun, 28 Jan 2024 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqDm96Zt"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25D208C6;
	Sun, 28 Jan 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706444872; cv=none; b=q3HWAhpVZBqStWrhnJhw0FzuuI8yjvpr/iGwQxxFKl0rfJmXy0+EGm9NP1BpIwzO1iZhFab6+w6d89ithVAHajge607drdKqW2hqeiZLXwU/ABFf2jnxXu27a8MiXf/lpp+jTIbuj+OawStFVscNx2bE4o82yWhWQfy/2erioDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706444872; c=relaxed/simple;
	bh=RazE+jc+SID1Wz2okl+YhaUu42pguW2xXu+B0GsHDOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwHRJqQmXFEqhNpToaPbEZtN9KtHArgMgo2yXOXzg4Gd0s6FZ3P/ePooJyVQJnj79/oTuAbPWaoTwA74ZjiWJZOVagGH6OImOWUAJvhFXiH+TIUNIWru1NM9kYlHylF4YNbxtWMBIfP3dvTwOT6NQNsG0YFDFJnAs532uMFJAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqDm96Zt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d8cec0f71aso2059555ad.1;
        Sun, 28 Jan 2024 04:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706444870; x=1707049670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f6A3+XdkKqU1Q3k8PxIHg8Ql7lOhl/fZYFw1hUekQ9U=;
        b=OqDm96ZthoWYG47eVbqQ+D6O7dOPxxCsayRieaZGpujkN8MMPE3L7QYRi26l/5Az6t
         qZC63SiPuJZyVr2kTzgonf7gwlPjv3OaOb0tWfUEkrSKQEDQVXIKst9XvWC+RWKLib07
         Mx8UO4UxW33Pyn6n+odHxdhvFUo//eSLU8F5csD8ZinTUQK4OUL3xo+RibR7aar8shvF
         m+WH0CVP6A2YQ9/c3S0OW4d3bE6XTjYo4sDBKPUc9nMLBEQDTN50ymSdDukr6gd9IQI0
         4P9ldsCQidoclcJV7xpzsSJvQpQHgXaXffIDkEguHYry96qcPlW3r5WJcm0sV4pxDK63
         Essw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706444870; x=1707049670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6A3+XdkKqU1Q3k8PxIHg8Ql7lOhl/fZYFw1hUekQ9U=;
        b=Zv/kBkqQfl5CSvOp1yLma8XZ8ouVrjvgW6tF0PDMIs9mJ/YcmT9AYLuqkiskWZaMxF
         E1ojWV0L15F8wrLIrMlQ0hvzFhL6vUuFh6VjFLZHpFUqhPGKcE+lFbL+90fMLu9wHn4f
         rdWjW0n8IO5UWPRzYPeaPlhLMSWOHj4ZUvt6J8aPTRVygof1x8NYAkpPPDXq4+FEMlwG
         Sr2luLGckwCMFiG0z2yX7MZe1bel9iOzgvgDGPByXNNlKew05MNd7Qv9+nAQddFeWJML
         jEJgYRrz8ZhMxux+IrYz5sVAPOni0RbQ60nAfyfHDTJOqSnVTF7UOWyU9BvBNAQx4jCE
         M/Vg==
X-Gm-Message-State: AOJu0YwkYdGbnqbWUOD3yhXdw0G7PFk8/F5V+aj5JjUBdQQ7US8KTcfV
	hh0/2LaXtqk6+S+3rF2TRAAZC8kwKg54nLjt3zcEiwgztGuXUyya
X-Google-Smtp-Source: AGHT+IG1q/641b1QavA3wBgGsZom93VKUFtlhiyXKQo2Fnsfgaw1etUBlzUT0VPgje31Cfs9zdexSQ==
X-Received: by 2002:a17:902:b615:b0:1d7:2337:9ff4 with SMTP id b21-20020a170902b61500b001d723379ff4mr2600554pls.46.1706444870084;
        Sun, 28 Jan 2024 04:27:50 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001d787672afcsm3584848plg.258.2024.01.28.04.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 04:27:49 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D83B718550346; Sun, 28 Jan 2024 19:27:45 +0700 (WIB)
Date: Sun, 28 Jan 2024 19:27:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Thorsten Leemhuis <linux@leemhuis.info>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: More detailed text about bisecting Linux kernel regression --
 request for comments and help
Message-ID: <ZbZIQc91DRrTeMtZ@archie.me>
References: <c763e15e-e82e-49f8-a540-d211d18768a3@leemhuis.info>
 <ZbW5emVndDNZlPTg@archie.me>
 <a373a71c-f5b6-471b-b7d2-b1f21dc505ca@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QW2iM5aW2BJe83wI"
Content-Disposition: inline
In-Reply-To: <a373a71c-f5b6-471b-b7d2-b1f21dc505ca@leemhuis.info>


--QW2iM5aW2BJe83wI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 06:28:52AM +0100, Thorsten Leemhuis wrote:
> On 28.01.24 03:18, Bagas Sanjaya wrote:
> > On Wed, Jan 24, 2024 at 01:19:16PM +0100, Thorsten Leemhuis wrote:
> >> .. _bisectstart_bissbs:
> >>
> >> * Start the bisection and tell Git about the versions earlier
> >> established as 'good' and 'bad'::
> >>
> >>     cd ~/linux/
> >>     git bisect start
> >>     git bisect good v6.0
> >>     git bisect bad v6.1.5
> >=20
> > If stable release tag is supplied instead as "good" version instead (e.=
g.
> > v6.0.1), as in many regression cases, git will ask to test the merge ba=
se
> > instead, which is corresponding mainline release (in this case v6.0).
>=20
> That should not happen if people follow the guide, as this is avoided by
> an earlier step:
>=20
> "'"
> .. _rangecheck_bissbs:
>=20
> * Determine the kernel versions considered 'good' and 'bad' throughout
> this guide:
>=20
> [...]
>=20
>   * Some function stopped working when updating from 6.0.11 to 6.1.4?
> Then for the time being consider 'v6.0' as the last 'good' version and
> 'v6.1.4' as the 'bad' one. Note, it is at this point an assumption that
> 6.0 is fine that will be checked later.
>=20
> "'"
>=20

Oops, I didn't see that context above. Thanks anyway.

--=20
An old man doll... just what I always wanted! - Clara

--QW2iM5aW2BJe83wI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZbZIPAAKCRD2uYlJVVFO
o2AVAP94Vb9po75H476YPkW8Ab5KWGCdPe5GMFhjORBuZzA/VwD+N2tvHII2zzQS
Z/Pbfh53eCGsd7inrATn8J6SOemepwU=
=gE8H
-----END PGP SIGNATURE-----

--QW2iM5aW2BJe83wI--

