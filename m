Return-Path: <linux-kernel+bounces-53079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F1184A06F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB280B23970
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D31446BC;
	Mon,  5 Feb 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjLMnhnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681344C66;
	Mon,  5 Feb 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153558; cv=none; b=YUiT9bPOSM4itGqreOvtF2EtFpuOxZSesIg1A0rPou1RRQRcrs9K5+wWFsbizZdN1oE9X+j1l+WxQDPX9GvYLO9elQLfdqv23ecDg77siYJsJK2/b5FrAYXznnHWwOfL2WLG5lrEXevjOH/mYrkyaBTW1mLL30DDT/kMouFA7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153558; c=relaxed/simple;
	bh=I/dPQVxNsqI+9sYP9jfmmTlxuMjd/mdTPS+ppBlP91k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s302S1tHwKk9mm+gMv0U1lIshUaZtkOIkuxWCBrHcWLNJl59MWhS6HDo/0qp3dRm6IeCNycsjR7nFXK97GmG8J6gV4nZXy9B/xkaCLj4IXxKym7Lla8Eyc1CbElGBPHdY0nx+vGh6jBao1wz7DFHgLujiquDiBxAh+qXsOLS+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjLMnhnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBD8C433F1;
	Mon,  5 Feb 2024 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707153558;
	bh=I/dPQVxNsqI+9sYP9jfmmTlxuMjd/mdTPS+ppBlP91k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjLMnhnS6bLqj5NEb2kdZC1z8lR4VQEnrshyp+MlHCJjA9yFuBHRtW3ApRELIL5Vq
	 D1QlzYPuzqErllQIS+pbu5Fak5hAKAyUuf9S8xTCw90/v2nRz4eXBVHT760hftISK5
	 hG6xlJ/mLI0206EygnzvudqY+8M47NFCv7JpN1RNSz/CbMn5SrkIQ00wEP7406MdQE
	 TSuHLhB5i1JeyqdjlSQkp3+wa/+1pGKx3xQvjjmyK3Kc1u1j+A5plAEZwsVviM2Qbe
	 mGIjWSyPOrdcW+kpHLypq/JrTs2jdf5VBd+Ec7VXO5f2JkH9u4jEMOjW71JtZPUSJz
	 kkZzWmjmM/rQA==
Date: Mon, 5 Feb 2024 17:19:15 +0000
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: linux-gpio@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Rob Herring <robh+dt@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mips@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
	devicetree@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v4 06/18] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl:
 add bindings
Message-ID: <170715355367.3639066.15524146689406248436.robh@kernel.org>
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-6-bcd00510d6a0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131-mbly-clk-v4-6-bcd00510d6a0@bootlin.com>


On Wed, 31 Jan 2024 17:26:19 +0100, Théo Lebrun wrote:
> Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 242 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 243 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


