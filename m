Return-Path: <linux-kernel+bounces-139708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7D8A06B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A2E1F225E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A55613BADA;
	Thu, 11 Apr 2024 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABFzBPDw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF821F176;
	Thu, 11 Apr 2024 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806161; cv=none; b=EfDx9B8/WNCUXY5kccUXtdnaRqGRu93M/ECKXXVEkhRNHIksAx16mbQHXOvl5AgXGf2fUCaT4webjnaFzEBBM+E9ZmMdfdJJmqNg7KJLs4R0drXWHmeZlI5NckZiiDicNRwrPFGijx8//ISilm6AU+JEb3AdH16OkNoURoLJpUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806161; c=relaxed/simple;
	bh=cba4HFVhpgHUdpdn6qrYkmNbC0aJQbwZ0EBzpbCf9+4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=bTM9VrZd9ML70wS2Wv2gv+xds9lDHXeZDLlgt66kKbh1we4NRAkzfwJXpk5atl6NEIpYUZg6Y9Q2L2qmIWqjE0O/KpqCwZdhUIKezSt9fCpsVYYh/dsoEFkeKahuOMa0iAxoyc+FMqry6nHc5nMPUUbrj5+NinYIyM6UTij1mBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABFzBPDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E330AC433F1;
	Thu, 11 Apr 2024 03:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712806161;
	bh=cba4HFVhpgHUdpdn6qrYkmNbC0aJQbwZ0EBzpbCf9+4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ABFzBPDw5QsEtop5NwJ2ScfXbNayKJgf5ME9pe52VcvL8lDRWMNJe8RjQHnNOaDoR
	 YZWR4emJ2l44p4pxApZQEUq58lnolKwz9GWuWFm2BJJKI48H3iOLD9NoVljKjqt5IO
	 07aq8iu5KbknRdD56sCjCW0OeGuAix2e2I0qluO7EaHdrmU+P4SPGkQqedzgc2CFpf
	 MJzg4QOqQgFggoJ5FrPNcuSxZ0XirPr4eHlZylCbqec0rcFf53pMZ1+/0FchkO16IH
	 Y4eihSz2dpevLjhyN2E0Mv3ujGx8Bz4rv+mtvvzNK/BAnjFs97SyHL1ha4xLNyHEVL
	 NkMmn49a7o1mw==
Message-ID: <574577121eb0b397a7a5b9aef59cd6b3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240410-mbly-olb-v1-1-335e496d7be3@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com> <20240410-mbly-olb-v1-1-335e496d7be3@bootlin.com>
Subject: Re: [PATCH 01/11] dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 20:29:18 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-04-10 10:12:30)
> diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq=
5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-=
olb.yaml
> new file mode 100644
> index 000000000000..c4e33a167fab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.y=
aml
> @@ -0,0 +1,125 @@
[..]
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  '^clock-controller@[0-9a-f]+$':
> +    $ref: /schemas/clock/mobileye,eyeq5-clk.yaml#
> +
> +  '^reset-controller@[0-9a-f]+$':
> +    $ref: /schemas/reset/mobileye,eyeq5-reset.yaml#
> +
> +  '^pinctrl@[0-9a-f]+$':
> +    $ref: /schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#

Yep, there shouldn't be subnodes for these. Instead, olb should have
#clock-cells, #reset-cells, etc. and the driver registers auxiliary
devices for each driver like the clk driver, reset driver, pinctrl
driver. Then we don't need syscon or simple-mfd and random other drivers
can't use the regmap.

