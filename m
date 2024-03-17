Return-Path: <linux-kernel+bounces-105507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE087DF77
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7001C20A00
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFDD1D54F;
	Sun, 17 Mar 2024 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih7u9U78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB31D556;
	Sun, 17 Mar 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702025; cv=none; b=mwYYvfcvc8M/uHkoN6IRADCbYOKw1R6hSakOlwR1ArY6iuKeWur7vPDTQNXEx1WIpWaTWetdYJdIfhEokp9LOnaty08hexH0C9zakeerji62DL5eqbBMkSGUcWcuy2JcZJ79HOTyZtADFfCIYwjPpqux9YEFQ2T0ASO2wLm9u5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702025; c=relaxed/simple;
	bh=/RZ6vS60NQ7l2KxzbBNyf5FX1EAhwhbDNKM40sUmExI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDqfcoO6NmG3S4kpl/4QWb6Yo5+UGKAn4ALqudUBG+rWBaUadbV0fvFPiArLotlRto382Zp7ZLBhY7Iec7jyE280uHbaiGMhAT1vyDzjpA0BMvSC9sovrmxOPrwx55Yt4L+6iMaAs8kPAYffqWuvjpxVtwA4aEqPBRGU4+RvuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih7u9U78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FE5C43390;
	Sun, 17 Mar 2024 19:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710702025;
	bh=/RZ6vS60NQ7l2KxzbBNyf5FX1EAhwhbDNKM40sUmExI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ih7u9U78GGrQuPaX/EAqYOT9tSSJaddG94KNscTMDdJo03OTevfT6uZn3C+QOgrS4
	 AqCsZxcPMGIDNXyNEBFS/VBSIDIkvBm1YZPZUVipttQxhNYIKHifZ8QrH6y/PH4hUY
	 fuwPgcvHgv/UNDZKcMyfqqSCKE1zSeZEVngPRrSYHyt/lQQnJP6rmrEl6tdN6iAhWf
	 H2zQi+DflwByVG/oUxlUTSh20x5Z1ncK+fOEUrJIVl49o6P67tjnP66YONe5qnNoBf
	 aaFLmcc8i5VoQgMCxmJZ+LcheVCcHxhBsUwlSmPmMQafUak80+G+vJj9yQrpsGMkX2
	 8Xvuu2viBgl2w==
Date: Sun, 17 Mar 2024 13:00:17 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
	matthias.bgg@gmail.com, shraash@google.com,
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
	tiwai@suse.com, trevor.wu@mediatek.com, jiaxin.yu@mediatek.com,
	nicolas.ferre@microchip.com, ckeepax@opensource.cirrus.com,
	linux-sound@vger.kernel.org, amergnat@baylibre.com,
	linux-mediatek@lists.infradead.org, broonie@kernel.org,
	dianders@chromium.org, claudiu.beznea@tuxon.dev,
	nfraprado@collabora.com, conor+dt@kernel.org, kernel@collabora.com,
	alsa-devel@alsa-project.org,
	xiazhengqiao@huaqin.corp-partner.google.com,
	zhourui@huaqin.corp-partner.google.com, lgirdwood@gmail.com,
	alpernebiyasak@gmail.com, shane.chien@mediatek.com, perex@perex.cz,
	u.kleine-koenig@pengutronix.de, jarkko.nikula@bitmer.com,
	frank.li@vivo.com, krzysztof.kozlowski+dt@linaro.org,
	maso.huang@mediatek.com, arnd@arndb.de, devicetree@vger.kernel.org,
	allen-kh.cheng@mediatek.com, eugen.hristev@collabora.com
Subject: Re: [PATCH v3 20/22] ASoC: dt-bindings: mt8186: Document
 audio-routing and dai-link subnode
Message-ID: <171070201412.2068024.3707863657848316004.robh@kernel.org>
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
 <20240313110147.1267793-21-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313110147.1267793-21-angelogioacchino.delregno@collabora.com>


On Wed, 13 Mar 2024 12:01:45 +0100, AngeloGioacchino Del Regno wrote:
> Document the dai-link subnodes and the audio-routing property, allowing
> to describe machine specific audio hardware and links in device tree.
> 
> While at it, also deprecate the old properties which were previously
> used with the driver's partially hardcoded configuration.
> 
> Also, since describing machine specific audio hardware and links replaces
> the now deprecated old logic doing the same in a driver hardcoded fashion,
> it is not allowed to have both the old and new properties together.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../sound/mt8186-mt6366-da7219-max98357.yaml  | 131 ++++++++++++++++--
>  .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   | 120 ++++++++++++++--
>  2 files changed, 233 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


