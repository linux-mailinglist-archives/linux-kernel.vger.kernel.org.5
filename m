Return-Path: <linux-kernel+bounces-57294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51DD84D68B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC2E288353
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E098535A2;
	Wed,  7 Feb 2024 23:24:34 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA52032D;
	Wed,  7 Feb 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707348274; cv=none; b=ARGKzgdw9oz+7iWoO35Q9I2bioZEhYq2UK9BQ+DixsCfbPGCxHE8hsaOsuCCzKH8TrPZOphDdpuxce9bH1HUrGSSlFUKlcAp9Vs34J9p/CdU0G3hm3gGiH99Kp7ki01JBuGeUKrwtI1dM2o3H6v+LdJ1eJSFflupbVPu1gjaEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707348274; c=relaxed/simple;
	bh=YfRV9IXEHzwUlaK44nivdzdyF+BT5NriNyRCfusq6cE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fd5tv8m+PhUjzCFeKZbsT1IMm1aSb8Lxbi016UiGWuJPCaBjAkDwb5BQMel+UyzFVXkagsGustAmuL6DGux1/1+xNTgOWIgK2oMk0XjT300Ir0azj3JTgxrVETYxQ27rqMgPDUv9mEY79jr/jcuUXnmJvP6+DlMTu8I/Zy+9/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69e54.dsl.pool.telekom.hu [::ffff:81.182.158.84])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007450D.0000000065C41127.001B0535; Thu, 08 Feb 2024 00:24:23 +0100
Message-ID: <f49b85d2045fc6960088166374c73f79b551f6c2.camel@irl.hu>
Subject: Re: [PATCH] ASoC: tas2781: remove unused acpi_subysystem_id
From: Gergo Koteles <soyer@irl.hu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
  stable@vger.kernel.org
Date: Thu, 08 Feb 2024 00:24:22 +0100
In-Reply-To: <2024020745-freight-slush-9ae7@gregkh>
References: 
	<df5c94396256e9573b772962182def52d20c50d4.1707250969.git.soyer@irl.hu>
	 <2024020745-freight-slush-9ae7@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg,

On Wed, 2024-02-07 at 10:02 +0000, Greg KH wrote:
> On Tue, Feb 06, 2024 at 09:25:50PM +0100, Gergo Koteles wrote:
> > The acpi_subysystem_id is only written and freed, not read, so
> > unnecessary.
> >=20
> > Fixes: ef3bcde75d06 ("ASoC: tas2781: Add tas2781 driver")
>=20
> What does this really "fix"?  It's just a cleanup.
>=20
> > CC: stable@vger.kernel.org
>=20
> Again, what bug is this fixing?
>=20
> Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> about what should be tagged for stable kernels, which this patch series
> does not seem to fix.
>=20

Yes, you are right, this is not really a bug.
I took the scope of "oh, that's not good" too wide.
Sorry for the noise.

thanks,
Gergo



