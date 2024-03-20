Return-Path: <linux-kernel+bounces-109021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E90881374
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA9D28336F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2B147F7F;
	Wed, 20 Mar 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph5sdZPr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727893F9CF;
	Wed, 20 Mar 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945486; cv=none; b=W80/lEs6rIxuen4YxychD41Hv5IT91UITfXj671Z2zckp9QWK7J0wfQr/0gqwKwGYAPxo/MPCLHycic5HeUzo5LbG8alWxagZEdtIQ8cmUUSyWv2HNX/hIg5Xddvqyw5NaATywhtn7HfFN7JGWmirRSQgArMHO32mSzQ9+DflYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945486; c=relaxed/simple;
	bh=x1Ftdzv3aUzGEjLyA02rR25sr8loAwqsHEClXsh3sws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW+U4hetW9hYbEK+IrPItUuJY4mg0hho6Zr2w3b9hH5zP+I+LR8ObFY/Bd25s4KTU9t43ZcUcMRx+zcYnGeu5YERNl475eMaLCnGoWLPr691qZBDLSK/FOT+NbYQ2rKy5KVTdswUPS+73NbEMEUUdCx/s4KOdg3qlfa9AlASekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph5sdZPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8726C433F1;
	Wed, 20 Mar 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945486;
	bh=x1Ftdzv3aUzGEjLyA02rR25sr8loAwqsHEClXsh3sws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ph5sdZPre/ADMcYJpljALajU8K0VuGWZAJ+mnP4iXVs2LeuQdhFXxCGnDHCitRiG+
	 OoOOeXbjl/0GEA1FeUjn+L4oQkb9DlyxThIMYyj3EWjjBoustVzw52jypsA2w6w5WC
	 rOBc9qw7k6OiU1EyOm9PuoOlly1Lw0mYeLjlXoR8gNKGGXn1aIqYOm8BgYXXAyFRWc
	 wa0pYOc/dXBPz0qTMS2mgHucwAlgU7XR8D1yywiiDB++Oz/eDs5EGqscvApxQgxc6l
	 snKkfOOZ2aLXjyrMp2Kx5hw3WPelWY/iYk+VPHb1l+NsCrQ+0jhkLh82zVudzhuFna
	 tKrpAxp/NsjkA==
Date: Wed, 20 Mar 2024 09:38:03 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev,
	linux-sound@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v7 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <171094548267.1688735.6689735252604213826.robh@kernel.org>
References: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
 <20240318-asrc_8qxp-v7-2-01ce5264a761@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-asrc_8qxp-v7-2-01ce5264a761@nxp.com>


On Mon, 18 Mar 2024 15:00:08 -0400, Frank Li wrote:
> fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> have 1 interrupt.
> 
> Increase max interrupt number to 2 and add restriction for platforms except
> i.MX8QXP and i.MX8QM.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,spdif.yaml         | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


