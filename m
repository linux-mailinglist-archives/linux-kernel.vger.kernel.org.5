Return-Path: <linux-kernel+bounces-155276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344458AE801
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666F61C2235E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255E135A6D;
	Tue, 23 Apr 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KED5v42A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186FA745E2;
	Tue, 23 Apr 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878590; cv=none; b=rRDtUZTxggv25GvDNQs/MGNCCt5llfDNvc9r4Nr9s6jJP3jvr1ej/P1liWN/QOkH8XSIcKrKquykmvxBwOHbQJ+SX3JovPZxFYQYGuXfjERKwV10dMY0g4mGM9DVj3yShNTatdcFH5QA05jHjPBywYn/5q3/Yfy1FJTaTCi4mhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878590; c=relaxed/simple;
	bh=Y3e+kyYzGZmeqX9U2y8Sf5GaMC6t/3cbauRRDhpXMhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxnE/6XIP8bu/Phj7qrqQmLKKbuwGBv3UQUW50Kh/tbJCOhB025Ly4X29E7JAkszPFd6zn4q8mmNcWdxwYF8ku7+vofBHOyS5YR1HvOwXL4UWlt2HdD1oXzb3CGbfjBwy7T1vRpmRWfbfbqGdJ2nrzdi0dyHu8h2RZDuIJHCkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KED5v42A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2E8C116B1;
	Tue, 23 Apr 2024 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713878589;
	bh=Y3e+kyYzGZmeqX9U2y8Sf5GaMC6t/3cbauRRDhpXMhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KED5v42A/DIYWTinaT6HqZ0EzXjUr/GomwKAiORVTHqV3Qh9fIy66439eRBhYoqwv
	 EOvMe9pDnPvmkhEXh6PL9LftXU9Mm0nYAvr45JyMrwFuqCjWZCFqQkjaFxXuNVHEAc
	 BZ5Ns8FatnJO7xpQ33PIzjx8BbzxQCM7SJpXPCCMoR4kNj1V+KLUMIaMCvUfLHFCb2
	 84cs3gH35Qbnp/Cm5Rz6VJkaAO8bx7IO752OdXImQvv+1jg2vOsoUWDte9/imL10cl
	 SUYBichI0SnZxDT5+Ayzxur9FAw3WU7lNP6a8XDHtcld32dGJa98fiGJEh8DcP1pE+
	 ncXSNdg3AEguA==
Date: Tue, 23 Apr 2024 14:23:04 +0100
From: Simon Horman <horms@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <20240423132304.GS42092@kernel.org>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416121032.52108-3-eichest@gmail.com>

On Tue, Apr 16, 2024 at 02:10:32PM +0200, Stefan Eichenberger wrote:
> Add a new device tree property to disable SGMII autonegotiation and
> instead use the option to match the SGMII speed to what was negotiated
> on the twisted pair interface (tpi). This allows us to disable SGMII
> autonegotiation on Ethernet controllers that are not compatible with
> this mode.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
> ---
>  drivers/net/phy/mxl-gpy.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index b2d36a3a96f1..4147b4c29eaf 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c
> @@ -114,6 +114,7 @@ struct gpy_priv {
>  	 * is enabled.
>  	 */
>  	u64 lb_dis_to;
> +	bool sgmii_match_tpi_speed;
>  };
>  
>  static const struct {
> @@ -262,8 +263,17 @@ static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
>  
>  static int gpy_config_init(struct phy_device *phydev)
>  {
> +	struct gpy_priv *priv = phydev->priv;
>  	int ret;
>  
> +	/* Disalbe SGMII Autoneg if we want to match SGMII to TPI speed */

nit: Disable


