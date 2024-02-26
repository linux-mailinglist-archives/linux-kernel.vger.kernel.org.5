Return-Path: <linux-kernel+bounces-80994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53814866EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBE2285479
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CF6D1C1;
	Mon, 26 Feb 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JuIsGb/T"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E26C2033F;
	Mon, 26 Feb 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937974; cv=none; b=Fkf37ZtUfxczDa5jSPIxRs7W9HkzQAJkulk4OEnh/HnfzXwN8xMBkuUv9EjQdJ+F2DdYDGXSXYAlkgvdL79b8SO1zmAK1GsmSvm11lFEYp7jyJlQuU7mVsggEePAqlTrZeFmZNnZ04HEGn8C+C98C0fz222anYD2fVFcmifKwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937974; c=relaxed/simple;
	bh=TKMBEQsICcf1Jqz8go5zK6Xhh9LdECeamokbuWo4YyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IN7dBQShA1dIFU9/t/jM7B9FagaG76xvopR2YyHs880wv8jCq95ckAKq+/RSEWs5QnF/FHtivf/PdTP2k7DE4i+7t6mXQvOL3S2Qahj0uRENpCfqs1t3br3GSS4Aueo1YolgiXWQWrgzNqCI2QB+JsUqESJeNKlWAJSZ5UuqrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JuIsGb/T; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 826DF60008;
	Mon, 26 Feb 2024 08:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708937964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPb6uM0vuQeGyvRuwmurAcfRX+uCUbmF9exG7CadPqI=;
	b=JuIsGb/Tqmh9AHLD4dviBjlXLScBrmdGVV5R1jGgg5j267sxOuG19XceWlMRagF/nv5OSF
	dklMzNwHtdhRhQ+dMe2Ivi8C2cYlWMVkmnOJRIVxgMQIG42j+0mChiQO3ozCzOSuUFzFg5
	+4iPdt/3FSqa8oY8yhYF3/OIoBCGrZJGHCna11I0Xz1iNHwOwq3wjT/FQEcFQWqqKX6KUo
	BTcRM8W4Ygwed5tbFeahfprYw1YaNgXc1aQ4g5INwaX6neF8hpAaYnmf5YZ4U+f4nGxS4T
	vA38EF+eaTATYvVDh9Fuv1ohVZpWvYOBQjFBJXvaMz51Ld6UTpoF9G4jA48mYw==
Date: Mon, 26 Feb 2024 09:59:19 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
 <richardcochran@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Paul Greenwalt <paul.greenwalt@intel.com>, Justin
 Stitt <justinstitt@google.com>, Randy Dunlap <rdunlap@infradead.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Wojciech Drewek
 <wojciech.drewek@intel.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jiri Pirko <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Message-ID: <20240226095919.1c242444@kmaincent-XPS-13-7390>
In-Reply-To: <20240223192658.45893-2-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240223192658.45893-2-rrameshbabu@nvidia.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 23 Feb 2024 11:24:45 -0800
Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:

> Multiple network devices that support hardware timestamping appear to have
> common behavior with regards to timestamp handling. Implement common Tx
> hardware timestamping statistics in a tx_stats struct_group. Common Rx
> hardware timestamping statistics can subsequently be implemented in a
> rx_stats struct_group for ethtool_ts_stats.
>=20
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
 =20
> +/**
> + * enum ethtool_ts_stats_layer - layer to query hardware timestamping
> statistics
> + * @ETHTOOL_TS_STATS_LAYER_ACTIVE:
> + *	retrieve the statistics from the layer that is currently feeding
> + *	hardware timestamps for packets.
> + * @ETHTOOL_TS_STATS_LAYER_DMA:
> + *	retrieve the statistics from the DMA hardware timestamping layer
> of the
> + *	device.
> + * @ETHTOOL_TS_STATS_PHY:
> + *	retrieve the statistics from the PHY hardware timestamping layer
> of the
> + *	device.
> + */
> +enum ethtool_ts_stats_layer {
> +	ETHTOOL_TS_STATS_LAYER_ACTIVE,
> +	ETHTOOL_TS_STATS_LAYER_DMA,
> +	ETHTOOL_TS_STATS_LAYER_PHY,
> +};

The all point of my v8 series new implementation (asked by the maintainers)=
 was
to move on from the timestamp layer to the phc provider which is described =
by a
phc index + phc qualifier (precise IEEE 1588/approx DMA). The struct being
introduce in patch 9 of my series.
You should do the same, use the phc provider instead of the layer.

With using only the layer and in case of several PHYs we could not reach the
right ts stats.
Same goes for the MAC having both type of timestamp IEEE 1588 and DMA.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

