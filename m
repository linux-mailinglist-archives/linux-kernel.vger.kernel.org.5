Return-Path: <linux-kernel+bounces-67087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5062856611
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82911287393
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6096113246E;
	Thu, 15 Feb 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcrWaRcV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560B4317F;
	Thu, 15 Feb 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007725; cv=none; b=uYAm+DlsdVFYabLT+fwjK1XFgP5ieBJOV0yAFDCgwGfDbeLMdgk3bziXinYQGRb+ZkwIXxH2MdPEzB8sWdWn0lEGQIQTnt0yOVgGJ5Oh3q5BDV4Th61ZtApmsED2mpu6nM1AAb8E+tcfgB722D9YCXPfHe9hgwBksTuS+P8VL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007725; c=relaxed/simple;
	bh=WoZcdGwGPGkkIa7tREMPjbuwqHXBXFFy5cGKfsjId7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJvRvqr6F8g748C5VHDFrzYR2hp6CmmC8z1rPpLjyc1giP9ZR3TvFY+jlWefLolS8W7P+TiscD04w+6wsX2uP905FYB5/cnXiuseO7o0k/IR3bh7JWMojmlH2rmhenrOgjpQHsriTtm5f8QP8NMVJXlnlHxmK/e8bZj5pxq6NOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcrWaRcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD236C433F1;
	Thu, 15 Feb 2024 14:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708007725;
	bh=WoZcdGwGPGkkIa7tREMPjbuwqHXBXFFy5cGKfsjId7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcrWaRcVGu0m7bRyGMClZkT7wXGeVObhk6h9S2stUyzmE1VjU3gsS05sA0KifIOJk
	 l6gmuyfmBpZk7gtTm2Ow96+msOXNDZZTR1Fcm+R9oS5dErj6PcLYszmpE6V0J0Tgfe
	 Ali+mZ1U82roHDAjBNEPwnXB7O2DXju/994vrVXxGSd6DOplDvSP+R2v/2uUM0svJH
	 7h5ll15XCpLvgXbyqjUAKBSLp79O8Yi++zC/6BA+B9QPvttSQPifCbnbrrBCiNmmww
	 dXV1TI+5YGd81q/56ZGqMcuDsCHU3HoZ2OgJDdpKxXeYL8PVOn4q80EQ1rMOpMdM1a
	 4/qF+TaE9VtYQ==
Date: Thu, 15 Feb 2024 08:35:21 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, Mark Brown <broonie@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 01/17] dt-bindings: pinctrl: fsl,imx6ul-pinctrl:
 convert to YAML
Message-ID: <170800772112.14828.3515005867069429971.robh@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-2-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213010347.1075251-2-sre@kernel.org>


On Tue, 13 Feb 2024 02:00:50 +0100, Sebastian Reichel wrote:
> Convert i.MX6UL pinctrl bindings to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt   |  37 ------
>  .../bindings/pinctrl/fsl,imx6ul-pinctrl.yaml  | 116 ++++++++++++++++++
>  2 files changed, 116 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


