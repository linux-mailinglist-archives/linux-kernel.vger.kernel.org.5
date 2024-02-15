Return-Path: <linux-kernel+bounces-67088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A97856613
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC74E1C2243F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51BE13246F;
	Thu, 15 Feb 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN6rJp0i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8313AF0;
	Thu, 15 Feb 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007813; cv=none; b=ErfKc2RVV8fAgJDFiHP85iHaMJ4RBKvJPoUrgFjiMqQcKb4qjO+kMRQ3AWelxBOH0nJzDat989j+dX5NG6dQ6+mpeI2GgLTe2igOndWAuuQqhv0TpQqREJcc6uS8g87tVtSIdOGk0WfoqLc5nm1SnR2ZTkhTCOorOVgtdUwWn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007813; c=relaxed/simple;
	bh=vbhgYI2lPpztmYcQjBjKNvW+mdUsvMXDu+M0FO1HtKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVoYFOyYTi6PeawXHVYWhLMmYcoRxHAi/Y/YSiFNP4TxryfLtXWzso6hMC8ShYHETDw3tjrfCSE/uGbvoCBRxwmC1Tx1zu7Nomyt4IefWbeIw8ItUR/y6ZM4NVidSiYPzvAKE+R3msun1rGH86dLEOjL/bgUuA6Wv0Ne7S7NYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN6rJp0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6202FC433C7;
	Thu, 15 Feb 2024 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708007812;
	bh=vbhgYI2lPpztmYcQjBjKNvW+mdUsvMXDu+M0FO1HtKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nN6rJp0i1Ngl+ajz0Neis52gGMfKrXqBpaZPzVVSsAWPE3A54PpD06R1zJJhMHPsG
	 6CINGxddc7KUnhDSXPNYY84heDWjcxVmKf4BfyHd+NvQUMr+NM0dW7ONEIaaj1YZM2
	 2eIYQ7aqaXWFAAdpM7S3WJxazptHoPZ6vpCCXXGHeJ2WT+AF+aHM5h2g6vv05X0Gij
	 xUiEvj5TZc9W/pYKC2bjTpfyAMp1sXCal0Miz/gV5ihq0B9xWhmzXUBW9tpxYub+G1
	 7pWQLgMTI7GnmlI4FtrITkDK12dRHYl3rbUjoRR4ixxxFa63xFeyF2Qle+MFOgxZkp
	 ifjJ/zx9ssIaw==
Date: Thu, 15 Feb 2024 08:36:49 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2 04/17] dt-bindings: input: touchscreen: fsl,imx6ul-tsc
 convert to YAML
Message-ID: <170800780830.16408.1737410902557011444.robh@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-5-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213010347.1075251-5-sre@kernel.org>


On Tue, 13 Feb 2024 02:00:53 +0100, Sebastian Reichel wrote:
> Convert the i.MX6UL touchscreen DT binding to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../input/touchscreen/fsl,imx6ul-tsc.yaml     | 97 +++++++++++++++++++
>  .../bindings/input/touchscreen/imx6ul_tsc.txt | 38 --------
>  2 files changed, 97 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>


