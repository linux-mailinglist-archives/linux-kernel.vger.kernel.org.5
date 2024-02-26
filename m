Return-Path: <linux-kernel+bounces-81134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C258670CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB101F29886
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C805914A;
	Mon, 26 Feb 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ETyCFEzv"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0D1CD32;
	Mon, 26 Feb 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942196; cv=none; b=L7tKumsUZD+PgjjtQr0woPbZiitqT6pqwvK8Hh/osJi8a7TXfaEJ0EL8GAAwHLQgrcsPLWCDKP234VAmeqr+X3sGBHKOGX4nXbR0VI3AlQhmh5RkbWHG8MUQyirmxXLCAXJowF19TRnUnn41kL278RomikmZ7Ln95T27C9JY3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942196; c=relaxed/simple;
	bh=fD06I6761Bblu6LIz/0Vqc/s50lUzSjG3wEpIkRmx+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jic/BIh9qA9n2CbtOkZm19yJfDIpwfDXcBaZvRPUzXW9n1pPPpxMBb9F266Bq00/NklkEdMxKEpxegVOwuUryxjVoS5fYWSflIMV/i0ilSSr3nFcKiCnFHju37JRFTCzFfR8f5uVHdNWtrpFwoIHf0J5+Zk0n0A1aos4QVlHbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ETyCFEzv; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3794E0013;
	Mon, 26 Feb 2024 10:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708942190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZjpenESpoom5pXFPq/3Rgc0cq0sAg4BJvGnYZALf+U=;
	b=ETyCFEzvQnohjoo51KU0oyPDzRB5Zwv+KDf9I/3SAn+w2caCL7sdiLNDo5jV8nEkpR6OZy
	oIvi8m4Vg3MYIr9ECx7T1EERfMoiBCzbVUpw8KQvJVuK8tKWSPcUeMcVWhuvi7BPo9TEtU
	WsHcpis5x1mzSlvkquPS72cdWpjpR0pAuvBEn6D9FwFsXfrO7SD/WOF2kn/lYnCeegDR2i
	/mWsYJjPS8JgkTkT/Kc8TPsTqNBfmxIgnHdfkqENOhnz6srjUlF5o6A5thMb62WnZKOnHi
	+Iyh6QekmauaK6/ugbgW58kbcANNxVoUjrugGjhgFYj05G0RZCfxdyz9IzNv0A==
Date: Mon, 26 Feb 2024 11:09:46 +0100
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
Message-ID: <20240226110946.626a8474@kmaincent-XPS-13-7390>
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


> +
> +const struct nla_policy ethnl_stats_get_policy[__ETHTOOL_A_STATS_CNT] =
=3D {
> +	[ETHTOOL_A_STATS_HEADER] =3D NLA_POLICY_NESTED(ethnl_header_policy),
> +	[ETHTOOL_A_STATS_GROUPS] =3D { .type =3D NLA_NESTED },
> +	[ETHTOOL_A_STATS_SRC] =3D
>  		NLA_POLICY_MAX(NLA_U32, ETHTOOL_MAC_STATS_SRC_PMAC),
> +	[ETHTOOL_A_STATS_LAYER] =3D
> +		NLA_POLICY_MAX(NLA_U32, ETHTOOL_TS_STATS_LAYER_PHY),
>  };

You should add this new netlink attributes to the specs in a new patch to be
able to test it.

diff --git a/Documentation/netlink/specs/ethtool.yaml
b/Documentation/netlink/specs/ethtool.yaml
index cfe48f8d6283..118508de2c88 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -859,6 +859,9 @@ attribute-sets:
       -
         name: src
         type: u32
+      -
+        name: layer
+        type: u32
   -
     name: phc-vclocks
     attributes:
@@ -1526,6 +1529,7 @@ operations:
           attributes:
             - header
             - groups
+            - layer
         reply:
           attributes:
             - header

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

