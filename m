Return-Path: <linux-kernel+bounces-118156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E1C88B514
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317011F3ED5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA2F82D76;
	Mon, 25 Mar 2024 23:13:46 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729D6F50F;
	Mon, 25 Mar 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408426; cv=none; b=D4fLj93AZzSxPktBIBTyuwGqPHQG4zZYGgIR2eZ41gdn0qzEljqpHPk0DV1KajCcXAhKq6Mwp/sxq9Uaiumz74L6JQYXkjI7VMFLLaWfCl+mOoAJXkCl7luc88qxMbxnn9Znzt42ujgAv572FfBhFGfVSfETccm76WybeLcSceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408426; c=relaxed/simple;
	bh=Mrh9SPT/w9jyav9m5OpYx1ZRCZOxPVd30OC7EfnHLQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTJbm79leWAMslrBsdAbbitE5EZXRwHoaZSuPxbEWQxolb+DOuvjfDC8rJ6JNFh8Kg/00FD/9CXvBgymI7SpODSRfWakTeYTM70CZNkRhIVxgsVBvMzF/vY7GBxtpqJ+pkXSAtRCVK3Eka6OqOs7I1JnI45Zrh6/6FyFZ1umlys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000077165.0000000066020525.0023AE94; Tue, 26 Mar 2024 00:13:41 +0100
Message-ID: <e5a06991c5540219366db84ce4e820e22a939929.camel@irl.hu>
Subject: Re: [PATCH 3/3] ALSA: hda/tas2781: add debug statements to kcontrols
From: Gergo Koteles <soyer@irl.hu>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
  Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>,
  Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org
Date: Tue, 26 Mar 2024 00:13:40 +0100
In-Reply-To: <377e0f33-697c-4baf-ac48-baff6199dd53@linux.intel.com>
References: <cover.1711401621.git.soyer@irl.hu>
	 <cbdc337b911bee0f80f805b936041fd59c1db54a.1711401621.git.soyer@irl.hu>
	 <377e0f33-697c-4baf-ac48-baff6199dd53@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Pierre-Louis,

On Mon, 2024-03-25 at 17:01 -0500, Pierre-Louis Bossart wrote:
>=20
>=20
> > +++ b/sound/pci/hda/tas2781_hda_i2c.c
> > @@ -189,6 +189,9 @@ static int tasdevice_get_profile_id(struct snd_kcon=
trol *kcontrol,
> > =20
> >  	ucontrol->value.integer.value[0] =3D tas_priv->rcabin.profile_cfg_id;
> > =20
> > +	dev_dbg(tas_priv->dev, "%s: %d\n", __func__,
>=20
> Nit-pick: you don't need to add __func__ to dev_dbg logs, the user can
> add the information with the dyndbg parameter, e.g.
>=20
> options snd_intel_dspcfg dyndbg=3D+pmf
>=20
> dev_err/warn don't have this functionality though so in those cases
> there's no replacement for __func__
>=20

Thanks. I just put a #define DEBUG into the first line and rebuilt the
module. It will be faster this way :)

I will send a v2.


Regards,
Gergo


