Return-Path: <linux-kernel+bounces-144935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D78A4CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67D7285604
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F48F5C911;
	Mon, 15 Apr 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KcHWyvnG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EAD58AA4;
	Mon, 15 Apr 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178155; cv=none; b=AhhhxAiUQSEYyNTcEUBYL4vCtoeei9y/DROyRNRj4EWnb+m14GqFADskrZ2E+hXySqYsv81WsUwrxkAlQQtm2uqa4V6Qx4GjoMQkw2ZbOvB2JLfzqjehuvvBzwcp5RFQ+ZAu8vvOlbYtJAwj/KMdQ5Nk/k77bw11xEWdL9XxRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178155; c=relaxed/simple;
	bh=VkoLIjMfNZTvr+tRbMnom1duDqUONl1TjFQKiVbF0Lc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UAa8nIwpgoiw/Y7smx0tJl9Id2PPlvpOeLqmgWzwjQki5ws2cV348MteK1QuBi7mdMQyIXMA7JQ+J7yPi6qYwV7JMjH9mKfvD+gBYFhAZDxE5BPIgUsYG8jcisllT3kONEv0rFY5mdHM8T1HPCvTr2eGP+QOPEUTPH+XKWufsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KcHWyvnG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713178152;
	bh=VkoLIjMfNZTvr+tRbMnom1duDqUONl1TjFQKiVbF0Lc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=KcHWyvnGAgdW9ZW4VFd4Xi9hmwJAWTZ35eKwXcw2bVHYhaWIqoDxUnhLHsG32T1OU
	 waSGhlxo+xMZdyyvRWL6tbfEeIbMLdJjXMcOP03/xyUgH8q1VMB7OuBVsXnq1JjGXN
	 RIekDF2m4QzemuXTd/Hb4SYd6U63g8jLDLrKDMYVKGqjIBWwOe15RdykL7tscHD9gS
	 V/XoBBjC6RR0Idz9F+ZOSTL/e+VH4gb0Xw94LNdf+AUJ2Uxz4GeSS7luTSC7aW2Jh5
	 U+KsCndweUCNFjRdgE/l9/jc2SpyJwLy/c+bfsMSBZFdAPxSWRz1L7PpHbR9cAII8l
	 IrFqGtuHOZn5w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E957A378203F;
	Mon, 15 Apr 2024 10:49:10 +0000 (UTC)
Message-ID: <1306b0ec-24b3-426b-b656-dd8cc9741912@collabora.com>
Date: Mon, 15 Apr 2024 12:49:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 14/14] ASoC: SOF: mediatek: mt8195: Constify
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
 <20240414-n-const-ops-var-v1-14-8f53ee5d981c@kernel.org>
Content-Language: en-US
In-Reply-To: <20240414-n-const-ops-var-v1-14-8f53ee5d981c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/04/24 20:47, Krzysztof Kozlowski ha scritto:
> 'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
> const for increased code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



