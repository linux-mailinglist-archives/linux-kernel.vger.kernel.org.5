Return-Path: <linux-kernel+bounces-161444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A644B8B4C0B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13C7B21232
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63C6E613;
	Sun, 28 Apr 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRbtsykE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426866CDA9;
	Sun, 28 Apr 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714312206; cv=none; b=GTDUqi7YPSZOblF8/yU6qXQJinS87MSLnQOJJMZleakkV+HBq4iT9LJQ1D/WrqquDW9AXp6rGLOou8mh65NgqdLemtT9zA3UP2lGik886FJ9DSLyoRaefScKpG0JVra5+4soNSwPwjnhUIPyu28NJ2VtIFZr1apDUchguaWzVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714312206; c=relaxed/simple;
	bh=GzXNV2+6fujuS9z/eEQVtBqOWZlr/UHD92MQ+jbSz1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bi9evQ4chJlmiHPkvRYBM5QTCBYE5zT/hvdO75f7CmWbRQhgEwWQp8VIU6YhnbWHQYEvbEji1mnPW/BG9wPrI2yJ5yqPEtdn3SjTZTVVKXlcdpD84xX9b9ZAwKKU0EO3u1+UIgt3U2QQpj3sbRMF0fdy7chI3p3Fc5BaDQzZgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRbtsykE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC11C113CC;
	Sun, 28 Apr 2024 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714312205;
	bh=GzXNV2+6fujuS9z/eEQVtBqOWZlr/UHD92MQ+jbSz1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KRbtsykEpqyA+5jvtbu5T1xBhEVuA0m6B1xUcvSbuEGO3IPUwg7hCAJ7oW++DSNYB
	 DQqPkh29dezgoZ5YUTBSmKZsNKTPkpDJ9PoSUOyLF2FCn7AHBBkVcesO8D2BbrtnQ8
	 Cjv4H19AC0mdezi9hjVdFM7YsFroUdGWwpPHWWcfZfkurb4ikKbGoExCVLcEx/IlSW
	 l5IMi5Qo/CKbbF/G1HMgCS2Gul7lJbbiEqdYT0hLTlHE8FZSNonIIsTf8v8czpcrBO
	 RzRcKE1+Oj46CkW6eiAE1P3W9xR+Tu0nNaBMAA1vEcmXnSqp1FnGIST3RDLwPk0UHx
	 fU7VtfQKVbATw==
Date: Sun, 28 Apr 2024 14:49:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/7] iio: imu: adis16475: Re-define ADIS16475_DATA
Message-ID: <20240428144953.1486da0d@jic23-huawei>
In-Reply-To: <202404270958.43fSMp4J-lkp@intel.com>
References: <20240426135339.185602-4-ramona.bolboaca13@gmail.com>
	<202404270958.43fSMp4J-lkp@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Apr 2024 10:00:49 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Ramona,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on linus/master v6.9-rc5 next-20240426]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/=
dt-bindings-iio-imu-Add-ADIS16501-compatibles/20240426-215728
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tog=
reg
> patch link:    https://lore.kernel.org/r/20240426135339.185602-4-ramona.b=
olboaca13%40gmail.com
> patch subject: [PATCH 3/7] iio: imu: adis16475: Re-define ADIS16475_DATA
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/202404=
27/202404270958.43fSMp4J-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240427/202404270958.43fSMp4J-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404270958.43fSMp4J-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/iio/imu/adis16475.c:734:34: warning: 'adis1650x_timeouts' defi=
ned but not used [-Wunused-const-variable=3D] =20
>      734 | static const struct adis_timeout adis1650x_timeouts =3D {
>          |                                  ^~~~~~~~~~~~~~~~~~
>=20

I missed that entirely when reading.  Indeed, looks like a cut and paste
issue where some entries should still be using this structure and got
accidentally modified.

A case of robots saving the day :)

Jonathan
>=20
> vim +/adis1650x_timeouts +734 drivers/iio/imu/adis16475.c
>=20
> fff7352bf7a3ce Nuno S=C3=A1 2020-04-13  733 =20
> fff7352bf7a3ce Nuno S=C3=A1 2020-04-13 @734  static const struct adis_tim=
eout adis1650x_timeouts =3D {
> fff7352bf7a3ce Nuno S=C3=A1 2020-04-13  735  	.reset_ms =3D 260,
> fff7352bf7a3ce Nuno S=C3=A1 2020-04-13  736  	.sw_reset_ms =3D 260,
> fff7352bf7a3ce Nuno S=C3=A1 2020-04-13  737  	.self_test_ms =3D 30,
> fff7352bf7a3ce Nuno S=C3=A1 2020-04-13  738  };
> fff7352bf7a3ce Nuno S=C3=A1 2020-04-13  739 =20
>=20


