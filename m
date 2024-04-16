Return-Path: <linux-kernel+bounces-147639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC98A76C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25D0282195
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663413C8EA;
	Tue, 16 Apr 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="anx82zwj"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207CB13C664;
	Tue, 16 Apr 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302638; cv=none; b=Onjrng6Cib+ulRL8nWmDwOYlLPoVZPDmpOImbcURjpz0GN5OcpFJM+WWECZkp0pp4GrjRAgHNTAH5rLN46JHOhel6+ygwXeFOvLLUsTRk0cWByohj3Hix5Kf0vb+fAtdiOgdXEUVXdVViZ+gJ3xUNyWwAPO7Wk86qhitWEOVbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302638; c=relaxed/simple;
	bh=AGxlsIIeZOw1hCiNiY9zQa7S35WYc82++11WQkIBkX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw7CuDhdkYnfOsQ1NYHKQyykd+azLmxMxURZXd7q9qTPOlJTiH5SNfV/F9PtS21f3s8TnzD/7MsWCg5ulCnqeuLJX1gcQnLcOtvhn26LRJclT9Axkc/ZsKgm8f3DV186H1J7cWC4GjSLapmfdziI273JCFdMT48wGxPViV7rHpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=anx82zwj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB4C31C0002;
	Tue, 16 Apr 2024 21:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713302634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rppgb29WBPwJgBwf6YcIy3zYefYu53Agf92ysrhH2uo=;
	b=anx82zwjU91TDZFpHnwmFVXoRJRahhjEqwJmYWqhwimW4kRFAgkJKlwQzrSn33dXCf9u9I
	tQ5ITL/hgKy4dhMS+kOfViBYgyL39P8YAvgNNxMNLL7ou5BzTfy0takhKxfYl4z0YJbfx2
	0iHXXZ7nZzNZrcbzXxAWFqBeTHLlO83biwiXHbmM4wP1xZusKgAfh4utSs/3iWpdl0DopW
	DcbP2hcfwY+mc6GvkTb4VCqpPfU/g4S9g+kpZGbJC2fw8FU3GMftutRzIjS/pk+i0SF6up
	PpOAe3ruyo73gnCUbZJBE8XNBaAlE9Bfgk2iV5qNfTqRiGKKI0PWb/FJcKd79Q==
Date: Tue, 16 Apr 2024 23:23:49 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-sound@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] ASoC: doc: dapm: various improvements
Message-ID: <20240416212349079fdffc@mail.local>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 16/04/2024 07:56:06+0200, Luca Ceresoli wrote:
> This series applies various improvements to the DAPM documentation: a
> rewrite of a few sections for clarity, style improvements and typo fixes.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> Luca Ceresoli (12):
>       ASoC: doc: dapm: fix typos
>       ASoC: doc: dapm: fix struct name
>       ASoC: doc: dapm: minor rewording

I'm wondering whether you could improve this patch by not rewrapping the
whole paragraph.

>       ASoC: doc: dapm: remove dash after colon
>       ASoC: doc: dapm: clarify it's an internal API
>       ASoC: doc: dapm: replace "map" with "graph"
>       ASoC: doc: dapm: extend initial descrption
>       ASoC: doc: dapm: describe how widgets and routes are registered
>       ASoC: doc: dapm: fix and improve section "Registering DAPM controls"
>       ASoC: doc: dapm: improve section "Codec/DSP Widget Interconnections"
>       ASoC: doc: dapm: update section "DAPM Widget Events"
>       ASoC: doc: dapm: update event types
> 
>  Documentation/sound/soc/dapm-graph.svg | 375 +++++++++++++++++++++++++++++++++
>  Documentation/sound/soc/dapm.rst       | 178 ++++++++++------
>  2 files changed, 494 insertions(+), 59 deletions(-)
> ---
> base-commit: 8f2c057754b25075aa3da132cd4fd4478cdab854
> change-id: 20240315-dapm-docs-79bd51f267db
> 
> Best regards,
> -- 
> Luca Ceresoli <luca.ceresoli@bootlin.com>
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

