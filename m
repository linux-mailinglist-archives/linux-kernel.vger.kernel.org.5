Return-Path: <linux-kernel+bounces-81048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85D3866F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB64B27F22
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA61C54BCF;
	Mon, 26 Feb 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jeLtCvF5"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AACC335C0;
	Mon, 26 Feb 2024 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939585; cv=none; b=sDCsLmR+slg1v5aa8Q1veoQXhOuNxqYjx+ilkWSPrMq6FDf8gTRh3f4DyreMt4Pbi6wBeE4Qc1B/ormaYY172p5RQjP0obfJvRuGQjttmrvQmVKye+4AvK0q4+nI7Cuh9VQJOHXo4Ms66VSq49Jtw2PlENrohEUPFlCOq6itP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939585; c=relaxed/simple;
	bh=XwLxxp8u8DvmEjdgtmzsdNA/nMFyAao9iyW50HyGSqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4kXQOgek7s9f0jaL9cJb6lNWOP8wRkZeHkSXoIdysLwOvvx+kVERxi0J69/CAAz/WyRS848fNBI3zqpxYbcSutZDumf6oFW/bJm5vwQUADYU6sOFfQiAo1U9lZsJqnmz0/FdN44ExwhdBzh91UCVPJj9YVmCkRjXyFDcSuXXUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jeLtCvF5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8654920007;
	Mon, 26 Feb 2024 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708939574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJ/TScN96xow2EgjcWkCcR2wGSrDb70yHEKhAIhIqck=;
	b=jeLtCvF51DIye3jd9TDzyVizqTWW0ZkjrTr6zB6ApmN3dCkSvOaMv1ITwAKf8eG/rXsQ7b
	O2XzGbGiBzFsf7rXcq6WEhPQLZIoEpmR0EEXImxcuSixWK1OE7ZPQ33JDy1RfLTFoli/ZY
	y9b9UvjEw6QfZ20HsI3BbfCFP+v7uOlRtg3MN3H/K0WN2blm86CKEzOIw3NhIU0n6j0WJC
	http5/7pXhfjw3qlWgVIzdrLL69waGkW2hnybaReMfji+i46OI+2YTM46LRInjSNgpCpAd
	o3yTHnLaT8x4TKNzgHoLN0bomHuraPzXRS/N7VDTcoMfBZHiy1DVJWzfpFjuGA==
Date: Mon, 26 Feb 2024 10:26:08 +0100
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
Subject: Re: [PATCH RFC net-next v1 4/6] net/mlx5e: Implement ethtool
 hardware timestamping statistics
Message-ID: <20240226102608.135cb11c@kmaincent-XPS-13-7390>
In-Reply-To: <20240223192658.45893-5-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240223192658.45893-5-rrameshbabu@nvidia.com>
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

On Fri, 23 Feb 2024 11:24:48 -0800
Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:

> Feed driver statistics counters related to hardware timestamping to
> standardized ethtool hardware timestamping statistics group.
>=20
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c index
> bc31196d348a..836198445726 100644 ---
> a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c +++
> b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c @@ -1155,6 +1155,74 =
@@
> void mlx5e_stats_rmon_get(struct mlx5e_priv *priv, *ranges =3D
> mlx5e_rmon_ranges; }
> =20
> +void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
> +			struct ethtool_ts_stats *ts_stats)
> +{
> +	enum ethtool_ts_stats_layer layer;
> +	struct mlx5e_ptp *ptp;
> +	bool tx_ptp_opened;
> +	int i, j;
> +
> +	mutex_lock(&priv->state_lock);
> +
> +	tx_ptp_opened =3D priv->tx_ptp_opened;
> +
> +	/* NOTE: this needs to be changed whenever ethtool timestamping
> +	 * layer selection is implemented.
> +	 */
> +	if (ts_stats->layer =3D=3D ETHTOOL_TS_STATS_LAYER_ACTIVE)
> +		layer =3D tx_ptp_opened ? ETHTOOL_TS_STATS_LAYER_PHY :
> +					ETHTOOL_TS_STATS_LAYER_DMA;
> +	else
> +		layer =3D ts_stats->layer;
> +
> +	switch (layer) {
> +	case ETHTOOL_TS_STATS_LAYER_PHY:
> +		if (!tx_ptp_opened)
> +			return;
> +
> +		ptp =3D priv->channels.ptp;
> +
> +		ts_stats->pkts =3D 0;
> +		ts_stats->err =3D 0;
> +		ts_stats->late =3D 0;
> +		ts_stats->lost =3D 0;
> +
> +		/* Aggregate stats across all TCs */
> +		for (i =3D 0; i < ptp->num_tc; i++) {
> +			struct mlx5e_ptp_cq_stats *stats =3D
> ptp->ptpsq[i].cq_stats; +
> +			ts_stats->pkts +=3D stats->cqe;
> +			ts_stats->err +=3D stats->abort + stats->err_cqe;
> +			ts_stats->late +=3D stats->late_cqe;
> +			ts_stats->lost +=3D stats->lost_cqe;
> +		}
> +		break;
> +	case ETHTOOL_TS_STATS_LAYER_DMA:
> +		/* DMA layer will always successfully timestamp packets.
> Other
> +		 * counters do not make sense for this layer.
> +		 */
> +		ts_stats->pkts =3D 0;
> +
> +		/* Aggregate stats across all SQs */
> +		mutex_lock(&priv->state_lock);
> +		for (j =3D 0; j < priv->channels.num; j++) {
> +			struct mlx5e_channel *c =3D priv->channels.c[j];
> +
> +			for (i =3D 0; i < c->num_tc; i++) {
> +				struct mlx5e_sq_stats *stats =3D
> c->sq[i].stats; +
> +				ts_stats->pkts +=3D stats->timestamps;
> +			}
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&priv->state_lock);
> +}
> +

To follow the same logic as my patch series you should use phc qualifier in=
stead
of the layer. See patch 9 of my series.
With HWTSTAMP_PROVIDER_QUALIFIER_PRECISE for the IEEE 1588 which mean the P=
HY
layer on your case and HWTSTAMP_PROVIDER_QUALIFIER_APPROX for the DMA layer.

Even if the timestamp is made physically on the PHY, this driver does not
register any phy device. The NIC manages all the network architecture by
itself. We decided to use the phc qualifier to fit this use case.

The layer description should only be used internally in the kernel when we =
are
registering a PHY device and using the phy tsinfo/hwtstamp/rxtstamp/tstsamp
callbacks.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

