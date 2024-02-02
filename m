Return-Path: <linux-kernel+bounces-50500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF38479F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0375728768D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9E280632;
	Fri,  2 Feb 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqgI7VGz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9A8060B;
	Fri,  2 Feb 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903562; cv=none; b=QVVzyGe8wiy6POzIQtmkz7cJxqDuU106m1I77a5bHuKfy9FxJQs4Qsebu9InLi1awrbbG48lViXgM6Wacpjbg2skGcjrLgYH09SM2PLTJWpPgh0qVutYZLuSUxidIG4v4mR7KcDeQaeWot3IWQTs7SXOmyEAcLkG5weK9PULZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903562; c=relaxed/simple;
	bh=NAW4yo/gyTsP/aDVFL1AKzWX4VS5afMpBgisLsIzRkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARXiJ2HZnaP5LEP8ywhyyo4hQ4TnIbkLLGgWwLMTcduUjEBn4UwCxjnCGu+djn+uFLcVBF5wp+yiKhzgdv9/obzs1KlFnW2NaMYfMDRl4CPpVq5zGa9a8tYbNTp/Dhx2+wn1FQ0yjlbQcpaQW1fA6vMpgJcT8nt9hLnW7rpKA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqgI7VGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34A3C433C7;
	Fri,  2 Feb 2024 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903561;
	bh=NAW4yo/gyTsP/aDVFL1AKzWX4VS5afMpBgisLsIzRkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqgI7VGzDc1EHE4RPDCHV/OyWZsm8JXYzPROSDrkLtkWdbei8RzMvhASvMJ6Cg24w
	 sIZ3t0uoENEzkZJAIpDkQyLMQNbe2PL2B6OzyJ90Kn8ExWXHNoLstZ4hUXpi+nrg9y
	 j8QgZtWw7l/h178yr/QF3WleoVL4rYWHuS0r6hfjLIVZDLgTNzWMAY9KtmEd8+bLty
	 biIVmYXNOQSUQaxFSIUz/6bgPNeiCuhhjwPqfJoQ1I0Arp36eBpuc6olf2sjiognM4
	 RSbiYipy+2z4k+exFBLvlZ1dmIVmZ3wnFVanQm4ke/dwOvwF7NyuSg0qVZIj/1wlPZ
	 GBzZHDyZgbTxQ==
Date: Fri, 2 Feb 2024 13:52:39 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 03/18] dt-bindings: pinctrl: allow pin controller
 device without unit address
Message-ID: <20240202195239.GA854204-robh@kernel.org>
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-3-bcd00510d6a0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131-mbly-clk-v4-3-bcd00510d6a0@bootlin.com>

On Wed, Jan 31, 2024 at 05:26:16PM +0100, Théo Lebrun wrote:
> Allow a pin controller device to have no address, therefore no unit
> address.
> 
> The previous $nodename was enforcing a unit address, but
> scripts/dtc/checks.c enforced that names with unit addresses have reg
> or ranges:
> 
>    Warning (unit_address_vs_reg): .../pinctrl@0: node has a unit
>    name, but no reg or ranges property
> 
> Fix pinctrl.yaml to adopt a (pinctrl|pinmux)(-[a-z]+)? node name when
> neither reg nor ranges are required. Use [a-z]+ to avoid conflicts with
> pinctrl-consumer.yaml.

You can drop this patch now.

Rob

