Return-Path: <linux-kernel+bounces-144936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61218A4CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA7E2855C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A95D49F;
	Mon, 15 Apr 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HArTBWPx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561D5D48D;
	Mon, 15 Apr 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178161; cv=none; b=gimwE4vQTbxQUZRuNrac5+ytiQM/gkK03hI11+XQhPNrqDJv7ErZuljKO/99MJFX8nYc1vDGBaZFjNv6QC4T/5C3Lm6nGeXar+Y9cDwo1U+ffAT0819kjkHQ+4rSLkaiqdToasJEE5S9Oe/kwxysKaZmY5Zkao7xkxbcHrdpk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178161; c=relaxed/simple;
	bh=VkoLIjMfNZTvr+tRbMnom1duDqUONl1TjFQKiVbF0Lc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GlTgF3MPGf2VPr/1/fYDppDet5P7aDkv4jvZ35ycDCAHr/i4hVmGPtWuGRooP0bwPMZkwkTVeE4F38p2YcCZdd0gCJhyjBmFmnPCmPl6YZlSNZVCJYgjlGtq5jZK5CikwbmYAc/vQ3EkhRqN2uX848WXYxPDra+seKBu8B1+tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HArTBWPx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713178157;
	bh=VkoLIjMfNZTvr+tRbMnom1duDqUONl1TjFQKiVbF0Lc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=HArTBWPxAA1OrcKymipiXN8qbO9S5Bxwi1bJlVkM8V8CEkZnDLCO94fzTJ0dBEGNY
	 QlZMhM3fFb70b7JfPkGeAQ3jSbFJ6ciXk/8T6RY59xgdsfEJvukShzBr/7ANPuZKb7
	 Aa5jtJqJ5HqhIEcdHKWzetM2tg1esivxIAgdL0P0ZKOIdPsFZuMSVEe5MFET2v1sQ0
	 1+bSPuq60FLiKHuKRSC0VjDMptnQZoHH2f4TqNuaCTkvzqISqtyqK6IxOZeTEWbLR0
	 hhWFaOmsae1RfucFStqX8jcnICLgbORycGbAKGQQ3V48kXcMP9Alik/fdTjtlRj+5O
	 dNRYZD8SDmzsQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D278037820AB;
	Mon, 15 Apr 2024 10:49:15 +0000 (UTC)
Message-ID: <47348f40-0902-4a52-8ec7-79b202916486@collabora.com>
Date: Mon, 15 Apr 2024 12:49:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 13/14] ASoC: SOF: mediatek: mt8186: Constify
 snd_sof_dsp_ops
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
 <20240414-n-const-ops-var-v1-13-8f53ee5d981c@kernel.org>
Content-Language: en-US
In-Reply-To: <20240414-n-const-ops-var-v1-13-8f53ee5d981c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/04/24 20:47, Krzysztof Kozlowski ha scritto:
> 'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
> const for increased code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


