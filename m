Return-Path: <linux-kernel+bounces-120645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1A88DAE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8D31F2619E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BFD3A26E;
	Wed, 27 Mar 2024 10:02:48 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F714C9B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533767; cv=none; b=I6UhyNjFtyG979Lre+lFUcIgE1fFyt7JhD9Hp3QLeZniQ0kV8BLmL840g/bM0f7OpJ/w5l+9rMNt+ZcExE58vmhYarnBfHkvzSW57cKuMWqTfqTr24js9rgEX7gATnc/SBOqCE1QfZf+2+QaDtnJrwd750s+621S+HeIU+Ekbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533767; c=relaxed/simple;
	bh=jROsE5zSV1DOsWSD2Xb5OSOLWK6tS8GklG1SMe78Jf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uq3Sn+ogokxaoUbPyG64LKl82zVVBnwLKWy3UO601sN5IG3MkNzdoRt+uA02rRw2083SQbbM+tdJ4vTVxYUFVrY3kJ8oPSklgReVJhhe623bo2qarEwSsS9Noko/d/AwsW04F4vjGt43FUkMm68dCaUG9Dghdkbsyp12H0XBSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000075988.000000006603EEBD.0023F2B6; Wed, 27 Mar 2024 11:02:37 +0100
Message-ID: <a84dd52c7ff74f9c8b84ba2ce2f0a9c2c3f20dae.camel@irl.hu>
Subject: Re: [PATCH v1 7/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
From: Gergo Koteles <soyer@irl.hu>
To: Baojun Xu <baojun.xu@ti.com>, tiwai@suse.de
Cc: robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
  lgirdwood@gmail.com, perex@perex.cz,
  pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
  13916275206@139.com, alsa-devel@alsa-project.org,
  linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
  yung-chuan.liao@linux.intel.com, broonie@kernel.org
Date: Wed, 27 Mar 2024 11:02:37 +0100
In-Reply-To: <20240326010905.2147-7-baojun.xu@ti.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
	 <20240326010905.2147-7-baojun.xu@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Baojun,

On Tue, 2024-03-26 at 09:09 +0800, Baojun Xu wrote:
> Firmware binary load lib code for tas2781 spi driver.
>=20
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> ---
>  sound/pci/hda/tas2781_spi_fwlib.c | 2374 +++++++++++++++++++++++++++++
>  1 file changed, 2374 insertions(+)
>  create mode 100644 sound/pci/hda/tas2781_spi_fwlib.c
>=20

Is this firmware loading logic the same as the already merged tas2781-
fmwlib? If yes, why don't you use that?

Thanks,
Gergo


