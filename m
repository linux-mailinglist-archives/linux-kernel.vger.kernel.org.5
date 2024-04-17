Return-Path: <linux-kernel+bounces-149307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729BA8A8F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0531B212C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6920D85C5D;
	Wed, 17 Apr 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AXJ5pPYt"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF98FC1F;
	Wed, 17 Apr 2024 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396629; cv=none; b=pDwignKWy5yZQRAqSCZqFzmD70SnSTWwIt1HK4W+OXF23PDAv1vrOog9nYZBrcDZ6v8nm/7GWKm0itBWdLmkhxc0RkcWpqIvFByHJZM3iBzgiQ06oMyi7VJheZymVaJC/A5dyhymmkSVakf4sAKuYYp/JlP4fLX6/WMhoHcHAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396629; c=relaxed/simple;
	bh=uStAB8Z7PetShi7DRWS4/m48vP2jVkoqSdBYHLWZmq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2ZaF7RxLkxda4HFLRs4NQFHSdpiyL5uz5heUx2r7dN2ohOLoJ4oU6jVo/xvDRuezqNb7QgulKhDl/ALvImMANc4y5O4CzwHv1rw/Adas02KDCiEodTVXDAgeQIu5rpHKenjDQcAI5HPm4aa//koErScXQ0cCeMNEqo/lyUT8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AXJ5pPYt; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6659E20005;
	Wed, 17 Apr 2024 23:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713396619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rS7uP4fx3ZEs46hxQ2+VksSxmKsjL9TvdkkylxD0uE=;
	b=AXJ5pPYt5xis9A/7Evxs8nE7hcciW35W9j0ocdTWXJdiLVldbEKtH6UUOFTrfMmwluBM9N
	xm8DCuo/A1Rq0uKTvcu5G8AmmkyQKxvFRXB25PN4r2597PARWtNPimrC2bpf3pmevHrPBb
	a6w3Bur086buNBKEtNm2vCCFahUn6BIFBOuAzcA/QhI9ZERlVZIcdx+MU8MaKVi7FqW7y8
	1qvrOceEwd36bEqnPH7lQRWZhF3uuDIIPzufqbGu6EkjPR1CDqV5Oq7fDqdLFxS1vCgyIh
	chft9KMIXq8+D65E+u+uaXSq3TxJf8axsvvPub3oGHy/0WxLqVdgQh5Sg+PmHw==
Date: Thu, 18 Apr 2024 01:30:09 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-sound@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] ASoC: doc: dapm: various improvements
Message-ID: <20240418013009.25b6bf0f@booty>
In-Reply-To: <20240416212349079fdffc@mail.local>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
	<20240416212349079fdffc@mail.local>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Alex,

On Tue, 16 Apr 2024 23:23:49 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 16/04/2024 07:56:06+0200, Luca Ceresoli wrote:
> > This series applies various improvements to the DAPM documentation: a
> > rewrite of a few sections for clarity, style improvements and typo fixes.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>  
> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thanks for reviewing.

> > ---
> > Luca Ceresoli (12):
> >       ASoC: doc: dapm: fix typos
> >       ASoC: doc: dapm: fix struct name
> >       ASoC: doc: dapm: minor rewording  
> 
> I'm wondering whether you could improve this patch by not rewrapping the
> whole paragraph.

Yes, sure. Will do in v2.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

