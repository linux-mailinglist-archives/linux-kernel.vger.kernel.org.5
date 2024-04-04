Return-Path: <linux-kernel+bounces-130855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F8D897DFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9B0283645
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41A21CFBE;
	Thu,  4 Apr 2024 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/Eq3uNw"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35DA1CAA8;
	Thu,  4 Apr 2024 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712200921; cv=none; b=oI/5YZGWQfFLwU5VUeChOqg5pnaGYddpGLPyqhciJJfPpndBmjcEjWXeJpo0LI84TdtHej4uACLTJKKikfgIX7p+I8RBJjhTbJ7sZHN4z3u31028+W7KPMoDr2aYSG+hI0u4OwmnGXh7YatObRMN9yR7bWgi+wMk4FmDli+4j5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712200921; c=relaxed/simple;
	bh=5pihKYJV5l+zZgyKQNY7hM82SMB3ycBncFBLNsf40Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss23NjgWqApXEElf/aQAtbJigEIZyeguRaNtG/6pc4wd+1Uzn7gl41qa0eqv9QGsQPQnKJ8eyzS1Jpy+xSDWHzX6ZZ1s5z12pANoIeyw+vpcGziGph2k1pahRBR+YprFjbHnqPK8V38sB3DSlEnLbPFP+qAZ3rDNZzVkusuuhGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/Eq3uNw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0b889901bso4555735ad.1;
        Wed, 03 Apr 2024 20:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712200919; x=1712805719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GU3Aux58UPVrbH3W6Uj3wE48hUzrsKIMa5z5pxoNqog=;
        b=O/Eq3uNw4YytuFwgb/NGDuAvcmAjBofXZjIMYaGOQO3z9cKQ+bi8ARN0I3qC1UBoex
         WUD3eB+Sn0CbqHabmIB0QVxnCAzorzXSxES2U7pz7pj8XLqeo3ZljA5fUHjaQ6xkhWu2
         XAoPNqimzYfOs5PQMqjLKfFJjwAqueuaIyadRHTt8dSIM0n2DNgPnqxKa/YfSgA4EyDG
         1PyGbuIyo7N13iu7VQGaVPgA973Gp9hffg2pATE+vAoOx6WMIy3yb8QwErHUCguU2a/n
         QVCwVc/SvYShzNzGwnv6fscGP1mw8tp83hRbLgoVA//yDBPUgDmMDq0DWM8eVb8MOoo8
         hO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712200919; x=1712805719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU3Aux58UPVrbH3W6Uj3wE48hUzrsKIMa5z5pxoNqog=;
        b=hpWprD99AEUGyWFDC8ztV1PkkLhvw4ufHENIa44b0JdsRpR5T50atUcwhrvnewe3uE
         S6ZHFeJX96TTYt3ArVdNWTFEZ0A5zq+ik+FUnJrca/uzUi5kH6f1482hZ84iW6LWFZeF
         ehbwBzkBZ1HEVvnGHnQukZ/4QgLRKp2V5jLB4v0OezMmW1H+Kaf/crcvdu9CJAmOUGL5
         av0TE9+wLSPtU+cjRNW73DeFZKoczaWc22ePRjksxjWjg4mPWqBhJQRSL8nHYOsDZxzH
         fMpVi+ApSqDW69tbW0dfOhkOw36KFkdtMQvtUXKU49Z3etDvi96BK9DPMHC4bfnEneEC
         jCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfRP9ogHAOLC8+s1764RLRRxsOfKYZp8bCoKFj+lN7W1UrLGwP6i03O1vvmz7MD2/TP9f5ToIonqSABbvI9tmn1ZS+CbNQkrn9XJPFGR124rnMtsCMnThTD9+ZoKKBCqHOIzcl
X-Gm-Message-State: AOJu0YyeeND4NoHQOtaP466Td7JcCHw9TC6Ien6qCFPprNKpgx9yBffF
	eQ13hrh9IZwiyrfssdx/UOKu966UHTLWmznlWxXTG7jLfbMFrOxa
X-Google-Smtp-Source: AGHT+IHwC+n5eClvoTsJmGHVuTvo8bbZ7J+K9bWAMhxszyqx5x+n3iKFqDNDtOQz6nwl8Gm6+A2ZNg==
X-Received: by 2002:a17:903:494:b0:1e2:8a9f:1032 with SMTP id jj20-20020a170903049400b001e28a9f1032mr1010680plb.34.1712200919036;
        Wed, 03 Apr 2024 20:21:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001e23fcdebe9sm1833939plk.98.2024.04.03.20.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 20:21:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2CF7F1846B4A5; Thu,  4 Apr 2024 10:21:53 +0700 (WIB)
Date: Thu, 4 Apr 2024 10:21:53 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 00/11] 6.8.4-rc1 review
Message-ID: <Zg4c0QG67_ehquKA@archie.me>
References: <20240403175125.754099419@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CStTHQ9ph6xUQEGW"
Content-Disposition: inline
In-Reply-To: <20240403175125.754099419@linuxfoundation.org>


--CStTHQ9ph6xUQEGW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 07:55:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.4 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--CStTHQ9ph6xUQEGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZg4czgAKCRD2uYlJVVFO
ozMZAQCt9++fZDsa9UJocLdzy7X85idIwQtjiEp6d2lF7WB2/AEAnVWRn9Q78QY6
Zxebg39d42Idwf+MS4GvJQrre6edTAo=
=i3zm
-----END PGP SIGNATURE-----

--CStTHQ9ph6xUQEGW--

