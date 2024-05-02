Return-Path: <linux-kernel+bounces-165882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD108B92E8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6060DB22084
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D00101E6;
	Thu,  2 May 2024 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWsTqIfi"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE0C8CE;
	Thu,  2 May 2024 00:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714610813; cv=none; b=unP4wqQO1zNYJd3QO9ueq5HWe/zVAnGUUgjKdEteTmUNUFOHiL/Zj1+LMvaPtjoqAIiFFsjvNkMBPZ6poaMk/IRQGjriqVXUU6Q7cmTrCezmr3mDwhTRRchsNJ6deVIpc56VqjAIJz9MbNNYTuPsKCoRTHTkyzKyPzyHt1Y8dfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714610813; c=relaxed/simple;
	bh=r6vRcnyfra/XvQVBWqFon0COqo1Zoj1iroQVqm6E308=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyX2fhrJuGWwlucDRXRlUP4oQlIbFlZqsHfM1510JJT53CXRELKD9gSoqRo5d6nRvHS75esHr3FuYd4UOEH6+DwECuej5E6qmp5C60Rq/i8qQ/PEPCAZKM14ufM3B4+CBM6/jKIWzHt/x+zOwmy6jQdcL+igj0rC4sWpvQlgXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWsTqIfi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecec796323so7026768b3a.3;
        Wed, 01 May 2024 17:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714610811; x=1715215611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6vRcnyfra/XvQVBWqFon0COqo1Zoj1iroQVqm6E308=;
        b=dWsTqIfinz1s8KLVBXEQP5F6mY9cKjuHK1xrL0xKnmOV6YhWNIPeLW6LC513d8+fyH
         pKmrTyxGewZkQxFVPVq3JO2Lsv87Dx8WGQV9KvAaceSJxcGBk0z4dDLntOd9Mwt+VUxO
         K3OFtQvr0HyBySyYKegYj/BAVCemnLFOjRGm77sXZwdjE4raP9xxKFGOyVc90xA51iak
         F/n2dRBAc16JgO/OqeT07VlAMptG3RTw7DrwAbscUvrBNCyZDPAcw5V8FUiz8OhM2Kzz
         9Eun+3Z/6gnERukVDbeSR5jn4qUmOVL4u5jQUURrOeZU5yBvxKn+sCv57ruUVkQJkFrf
         fipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714610811; x=1715215611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6vRcnyfra/XvQVBWqFon0COqo1Zoj1iroQVqm6E308=;
        b=ZTMdQd4kp2Ohh2N4QZGRVZaKkcagJJPM42RmCdeHzKbmpvQ6A3rBBZ4YawIQNSMF4M
         HLwFUyu4q/9SBj/kF1ZvXYGOF4XGJP58LurffsB83OUgnmrPpnkTEYFHucJwQTSrMPd5
         R3NCDI/v1r5fcRXh1noK80OWwLRrKOboJIYwnqfXIubqGfa6ZBxR/uIfiLG1tq8+ZQfR
         stJmeGn6aCVTjGxvXYJMApOMLke23TVx9cmBzgdDGYwGZTvR3IOOyZ5ZASTV4qKRzsId
         wGJ/c4UlXREMmIhI5gAgmYde/Im1OKqTK3ogB9y4cAim37oV1KFBLhB8cHB9INnwGcET
         tHtw==
X-Forwarded-Encrypted: i=1; AJvYcCXrbu5vRw7SbffEIp9Efb1KMECXcRnCk7NmUHUZXck00xPApl/ly5xK0OWIrF6fwvGljXH75vApo9yUmCapHxKcATghtCtQh/oAAbvctSZ/f1OVNcrtXOcMWqtPG423VolmRxgu60Px
X-Gm-Message-State: AOJu0YzANvQEKJrLdLxl4EH92AApGNM6GTzxOXmZl1TTOE9pkalY7BsA
	I7hucH5QGE0VGnnL5j+qNl8f/I9ZAPq51Dj2EV5K4EBYMcS1SNa2
X-Google-Smtp-Source: AGHT+IHwU4/61QY/W4PI397ZvWqj9/LHxy0c+jQK8AspbpBzjbs2tbF+eYJN0yoDRgWGYQujUcR60Q==
X-Received: by 2002:a05:6a00:1ad3:b0:6e8:f66f:6b33 with SMTP id f19-20020a056a001ad300b006e8f66f6b33mr4870989pfv.4.1714610811128;
        Wed, 01 May 2024 17:46:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id x37-20020a056a000be500b006edcceffcb0sm23225000pfu.161.2024.05.01.17.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 17:46:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E24CA18462B26; Thu, 02 May 2024 07:46:48 +0700 (WIB)
Date: Thu, 2 May 2024 07:46:48 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
	corbet@lwn.net, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v4 1/1] Documentation/core-api: Add swiotlb documentation
Message-ID: <ZjLieHFvjlTJrCUM@archie.me>
References: <20240501151651.2912-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xmC8L8lm/UzjLhNP"
Content-Disposition: inline
In-Reply-To: <20240501151651.2912-1-mhklinux@outlook.com>


--xmC8L8lm/UzjLhNP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 08:16:51AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
>=20
> There's currently no documentation for the swiotlb. Add documentation
> describing usage scenarios, the key APIs, and implementation details.
> Group the new documentation with other DMA-related documentation.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--xmC8L8lm/UzjLhNP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjLieAAKCRD2uYlJVVFO
oxauAQDt9V+aVqf0N3EOJm2WLmYhylB3nbvQWXzkMfVxhz7V4wD/Uge4eZdVPJha
nkCxgxnQOBxzAnRSJPmMohaEeSVNUAo=
=IKGL
-----END PGP SIGNATURE-----

--xmC8L8lm/UzjLhNP--

