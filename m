Return-Path: <linux-kernel+bounces-21106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224AA8289EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508EA1C24691
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E283A3A1D2;
	Tue,  9 Jan 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHgQfZLp"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391153A1C2;
	Tue,  9 Jan 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704817524; x=1736353524;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pqvftV7jqXdOf/U1WVzf1rrU3Eu0865Q2QbvOkuWV+k=;
  b=aHgQfZLp7SjKiOVe0Tmb6hSxRpQZT7O7+n/aLA0I1bw6vKk2O4vMQN41
   WOMyD5yV1hcsWWVInnpZk+y7QDJZGnO+Ygn61zc52Pymea+0SgMidG7tT
   vO8UEapvAms2bqhvYoj0gYYcvEZT4FfUgR/6dQ7pKHHaI1kifiLngi1XP
   grXYPwV5x9q40+GF60Upr//Egm0410qbpSyj02LKgPyE2Gv9IFc58v3pc
   S05vQZ28DUlRkx/V7Z3Y5bNoCzApk1c0xAsY3YCihZAQrphP7SXv694Ck
   WhTge4Mhj3ER8Etd8t96Iyf4veXNI/AzKrek1U2NeBX4z3TSZWmoU+N0H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="484427254"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="484427254"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 08:25:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="16334102"
Received: from rohitpra-mobl1.amr.corp.intel.com ([10.212.96.32])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 08:25:23 -0800
Message-ID: <30948df0bebe6d37d722b4ca4ab5feba7b7c0895.camel@linux.intel.com>
Subject: Re: [PATCH v1] crypto: iaa - Remove unnecessary
 debugfs_create_dir() error check in iaa_crypto_debugfs_init()
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Minjie Du <duminjie@vivo.com>, Herbert Xu <herbert@gondor.apana.org.au>,
  "David S. Miller" <davem@davemloft.net>, "open list:INTEL IAA CRYPTO
 DRIVER" <linux-crypto@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Cc: opensource.kernel@vivo.com
Date: Tue, 09 Jan 2024 10:25:21 -0600
In-Reply-To: <20240109021916.20960-1-duminjie@vivo.com>
References: <20240109021916.20960-1-duminjie@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-09 at 10:19 +0800, Minjie Du wrote:
> This patch removes the debugfs_create_dir() error checking in
> iaa_crypto_debugfs_init(). Because the debugfs_create_dir() is
> developed
> in a way that the caller can safely handle the errors that
> occur during the creation of DebugFS nodes.
>=20
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks Minjie,

Tom


> ---
> =C2=A0drivers/crypto/intel/iaa/iaa_crypto_stats.c | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
> b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
> index 2e3b7b73af20..cbf87d0effe3 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
> @@ -275,8 +275,6 @@ int __init iaa_crypto_debugfs_init(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iaa_crypto_debugfs_root =
=3D debugfs_create_dir("iaa_crypto",
> NULL);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!iaa_crypto_debugfs_root)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -ENOMEM;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debugfs_create_u64("max_c=
omp_delay_ns", 0644,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 iaa_crypto_debugfs_root,
> &max_comp_delay_ns);


