Return-Path: <linux-kernel+bounces-104568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5D887D011
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79F71F22153
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40FB3D963;
	Fri, 15 Mar 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTmptNUO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496E3D396;
	Fri, 15 Mar 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516027; cv=none; b=EH0zNqUy/WDazJ615J0ANJcsvXa9HPUGAVDzyqPIFFHhdf70gjwZkrrsKNByBAKqVDVhYCnXXzgHH6sk5qPDA+yMLXgFhG7g0qz0lkdyYvImta4z/ClMWRGSKCZGpH/ad9iMinJU/fDPPIno6TnpKyPaQTPN6/mWyt0IZzXbJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516027; c=relaxed/simple;
	bh=21VpxPs3+rq7HQ+Y9/R9zqGm855H1I7PaAuGVdU4uyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pfe0OMN0MXYuXuNspFdDxHV0EVoR1itE7xjTrkaNud8m2j6ZkMiyxG6p+2dVqlGguOWWidv9aPZfSD2UInDvTp38K3jluDFIuyHAe9WeVY2gZH7YNex6wJjWQQS095YjGHdI2fMQ19mvr76vshkE7AW1PnAfZV6WTCtJlklqbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTmptNUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E2FC433F1;
	Fri, 15 Mar 2024 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710516027;
	bh=21VpxPs3+rq7HQ+Y9/R9zqGm855H1I7PaAuGVdU4uyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTmptNUO9MOEgZkkd7GAfM2/XaQ23q26PmCzIlgO6yWjA3wjzwU58As57UxjflRFO
	 sR59sa8asUYa4SOuQ2hyzVLJaUNH/JIZ3m7qpzTXJJw7zGby9LZB2KECQmdNDj+Ti4
	 w5Ocuf6vPl1alpzTVF20ZJ+8oP1fG/AxFmPu2r1kifHCu4jsnyjrSrNzUWi2SZYFUn
	 OurfbvUU1bmtTxyJcG3uIhZSCbIpU9sNZNGJFqLkyxlyIAruM7afib47aK5FAiPDp+
	 SZzuMvsm5IhH+n4s0ryVYhCnevev1/UQclGN7hikXIHGm8otUkAsZu0m5LkcmiE8dm
	 74NG1hTKSYarA==
Date: Fri, 15 Mar 2024 09:20:25 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: soc: imx: fsl,imx-anatop: add imx6q
 regulators
Message-ID: <171051600462.1317802.15202887261312463766.robh@kernel.org>
References: <20240314145953.2957313-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314145953.2957313-1-alexander.stein@ew.tq-group.com>


On Thu, 14 Mar 2024 15:59:53 +0100, Alexander Stein wrote:
> imx6q has additional regulators compared to imx6ul. Add them to the list
> of allowed patterns.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Commit 465c7756d1ff ("dt-bindings: soc: imx: fsl,imx-anatop: add binding")
> only added regulators for imx6ul. I'm not sure if this warrants a Fixes
> tag.
> 
>  Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


