Return-Path: <linux-kernel+bounces-147944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD638A7BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88141C21AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8012451C3F;
	Wed, 17 Apr 2024 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EztkbxgS"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CE5026C;
	Wed, 17 Apr 2024 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330493; cv=none; b=WBBqCTdZkWbTo389k9Rb05yQBNI+mMMo1lDaoqsqqdN7BgJUpUvhLeR138Qgb/5NdyB7455zxIAxjCVpYHAoYJybonkunJDbFoefGbW8BUuXfEX/iD472MraNjlbOLPi0OykTHI95CbcFsAjLwUi2bd7fKASm3SvvgR9FPkEyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330493; c=relaxed/simple;
	bh=kHmXZoiGMAvdYufv0YTELtxGjCF+e/+A8xmBw5gbZsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JROIekoq4c5vkaiI3mRz7xK91OhZ8SAG9S6FSBY/mdFghgX1vBYVJU8U22m1yh5EbhbuGYXcbTwniSVC106e3fj/jGTIQv+wm2CRtBCLZqu/lOXzH9d1UinE5Y9REjB/ZKCxyFoltR1zKybnkwFtEbl1rpcnO3j9Ma0sDN4GLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EztkbxgS; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7985B40002;
	Wed, 17 Apr 2024 05:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713330489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4vsf7Ed6K1xX6J4cMkcuaz5lBJkIE+gM/MY02kRlH1M=;
	b=EztkbxgSMdkNMAXVew+t2yLjWBqdVHks4MDvS3ZgoVdi7U2dH0PECOpRpOSEZJbo/I31de
	c8uuQHoj9Blo580/Pn28ESV9cS7d9Sk00o7hJdX5J8hQAKzFJGbOmeAZIG9UsOPiI7fSLK
	x/MPHU4QX4h9HxeVcnvrRiE5IRevQBJl/+lHhnlUVqvNQPFEu4wCEjERh4I6znjNP9GWwd
	l13VnOSG0+vXjkMqNhb5qSaMyhXZKAn02uAUUYHGed0qdy3Ti1OsfOnnMFF4s8gpO+jJ7B
	DMwQq41nKVnj4WwyuRq+25dDHF81odLfAHhpwGUPTVhIfcT/68a1LLzO2C+E/g==
Date: Wed, 17 Apr 2024 07:07:59 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-sound@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] ASoC: doc: dapm: various improvements
Message-ID: <20240417070759.600a1730@booty>
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
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Alex,

thanks for the review!

On Tue, 16 Apr 2024 23:23:49 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 16/04/2024 07:56:06+0200, Luca Ceresoli wrote:
> > This series applies various improvements to the DAPM documentation: a
> > rewrite of a few sections for clarity, style improvements and typo fixes.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>  
> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> > ---
> > Luca Ceresoli (12):
> >       ASoC: doc: dapm: fix typos
> >       ASoC: doc: dapm: fix struct name
> >       ASoC: doc: dapm: minor rewording  
> 
> I'm wondering whether you could improve this patch by not rewrapping the
> whole paragraph.

Sure. I'm waiting a few more days for any additional comments and then
send a v2 with this change.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

