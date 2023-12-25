Return-Path: <linux-kernel+bounces-10889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9533581DE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375DB2817C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC5D10EE;
	Mon, 25 Dec 2023 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBcNPFWB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80ECEA6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-35fb0dcec7aso15979835ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 20:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703479182; x=1704083982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfKyhVgY9bapo2txxnaDiDpV+zqhiz7hEGxnfpCVkzs=;
        b=JBcNPFWB25EdNjJ+slJbbk10Ey9fPArXKaN7y8kwdw6JVmNY5Kp7O6zfsA7ZmqQ+gm
         KsVmkGO1kItTOwBHp78JG1el3N3TnfhUxYt+wKsrqZUzxHxipLuWUXpoMlwVXGhAkZge
         JXfrJi9DqYjrp9TltURM5vP7HZlNCrGJPgt+6m8uL9FUMyiqIzIt7qtUP55bw4Bhzsi4
         wL8sLpz69T3YUBeh5iD2I8QHzUJly6iw/YxNCB5HWjd7vlxPgyK6JxFB6GivwK58M1pT
         rNxlQnReN+nONiotmdqfzSGbv8wYAugEF9aN9ZjNOe8h4RfaS+ALWLmWEJFyNcQ3Jzd1
         8H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703479182; x=1704083982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfKyhVgY9bapo2txxnaDiDpV+zqhiz7hEGxnfpCVkzs=;
        b=iC93gKlXI8zbleQ2bYWZPviAD27qvelaQQLdoRur7JDQmZyFTJnnq4im/6dGf6jmHQ
         vLeWN6zucrMm0mF7l4MSeZ8D4nHpVEMV6nVTX7kebQAHC9BZOwxYgVpH2K4CgQWmKzxo
         wgaw9cjLI8a96LtdVHcMI/5e5nz7M1SAkVeRvqWBPxm0YZ9ef7Jfv0gdtLfFpIMZwkim
         NOWFgxIh3Pkgd7BcAr/BugxtMbvwd79MNbjzR4cOeA275ASEOm3ZHOTNJ0/zNi94f6/U
         KUMBvsDvHcM33nYO0/sImH3c12vAcYsLihO3TaqIA2NQBLdZ2xRzcX6/SoxQimqbA7k0
         1Isg==
X-Gm-Message-State: AOJu0Yyq+anZe/5DUddJ+TQK1KDkVf28f9txoqRK5uV/rM/Rjgy2kGeM
	prpzlu/nRSPCPEZRwpameVlVZnLOi50Bpw==
X-Google-Smtp-Source: AGHT+IETa4bQ/LBMOoI9mGBUNrWu6SwVhE9XBVau1Q9J2zg8yBnHZ08v9jxDW6NZ8ZY/6gyQ3pnaQw==
X-Received: by 2002:a05:6e02:1aa6:b0:35f:d9e4:9c7c with SMTP id l6-20020a056e021aa600b0035fd9e49c7cmr7564939ilv.62.1703479181681;
        Sun, 24 Dec 2023 20:39:41 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id n10-20020a1709026a8a00b001ab39cd875csm7299975plk.133.2023.12.24.20.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 20:39:40 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A6B7E10207150; Mon, 25 Dec 2023 11:39:36 +0700 (WIB)
Date: Mon, 25 Dec 2023 11:39:36 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Rudy Zijlstra <rudy@grumpydevil.homelinux.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I can't get contributors for my C project. Can you help?
Message-ID: <ZYkHiA6SIjfUpSWI@archie.me>
References: <549578214.4148875.1703446908152.ref@mail.yahoo.com>
 <549578214.4148875.1703446908152@mail.yahoo.com>
 <e274b55d-9818-0919-fb90-bc6d0b522b0e@grumpydevil.homelinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TQ8auetMcA807Zyj"
Content-Disposition: inline
In-Reply-To: <e274b55d-9818-0919-fb90-bc6d0b522b0e@grumpydevil.homelinux.org>


--TQ8auetMcA807Zyj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[trimming unneeded addresses]

On Sun, Dec 24, 2023 at 09:25:38PM +0100, Rudy Zijlstra wrote:
> blacklisted. Long ago i needed to do that...

Also done on my side (block the desperate spammer using Gmail interface).

Ciao!

--=20
An old man doll... just what I always wanted! - Clara

--TQ8auetMcA807Zyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYkHhQAKCRD2uYlJVVFO
oxxEAQCJmEyXvENCwPsGs/V4vgp1N/Q6imN6wKlMvGKaGdKCpAEA+UJ4QKKRz84M
1pi6QL1tyMtepbvbpzf9omyScf7ynQs=
=0Rkv
-----END PGP SIGNATURE-----

--TQ8auetMcA807Zyj--

