Return-Path: <linux-kernel+bounces-126740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF9893C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603C5284AA2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592624206E;
	Mon,  1 Apr 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW2aEOn5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744A41740;
	Mon,  1 Apr 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981299; cv=none; b=LOmFv7p6ZS9TMb9jKxTZI1PMj5mUVjSTJT9gNi991AtpSBCcfELenlv0Kexran7c4/5n0rk/bhIHccvqYbsSuOj1RnsjCSh06+1mSISPCJskiYYQPf2ilJcjC8bWE2RdEgna4WLY8mNtAcyCx0V93VVLOQCGXG1bSR6hWw02qHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981299; c=relaxed/simple;
	bh=4iM2W3ENye1EjjINEM9MZSd721nlwsc4Mz61aqbvpO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfjdIc+mdzXzXpT1gG6lKMsauMILFkv+ssOawHwhMiCP96E2mhk930jAGMJQYAWXg7s9+pT2r1sSvzZbb1XBB68m6Accg9/VzFPA2QX+QWRHoG9CxA295XK+cv3Cm/14iJC/lfTZlDie7vUSQjxj3V8Y74MQFYVhfvnxNMnlJek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW2aEOn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADD6C43394;
	Mon,  1 Apr 2024 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711981299;
	bh=4iM2W3ENye1EjjINEM9MZSd721nlwsc4Mz61aqbvpO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bW2aEOn5dRM4Tv6hNuT1wmspPzXPjVcTS4A+m6VEdzx5dIXw9/VMnwVVKGVRBA6TC
	 LAyIUjoyxApNHNJtHFc4eKGDkpe77MH1Agkb/C4rk+Z4xtS7W3Gp6+L1xt5oTVTAJU
	 BVAtccQMAKhTokiuNBTXsftQFMe1Qdi/ey4NfOOQaFnq/PiiRaiRlN7oVPrU0mKbvA
	 x42ox1dfkUEadgXTE67j7h9C7u8krNErXwpjmIaFNaTvyTt1m3bQpGrDtwzYVYxQDY
	 g1PQNgOU6JdZRtYLBnQXlR7bpMn76gnzYrs6fKJnH3EUgaB5nu5204VrjCYxjG6Ddj
	 HLc6qQGp4j4Ig==
Date: Mon, 1 Apr 2024 09:21:36 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com,
	mturquette@baylibre.com, sboyd@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
	martin.blumenstingl@googlemail.com, kernel@salutedevices.com,
	rockosov@gmail.com, linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/6] dt-bindings: clock: meson: a1: peripherals:
 support sys_pll_div16 input
Message-ID: <20240401142136.GA559114-robh@kernel.org>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-4-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329205904.25002-4-ddrokosov@salutedevices.com>

On Fri, Mar 29, 2024 at 11:58:43PM +0300, Dmitry Rokosov wrote:
> The 'sys_pll_div16' input clock is used as one of the sources for the
> GEN clock.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../bindings/clock/amlogic,a1-peripherals-clkc.yaml          | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
> index 6d84cee1bd75..f6668991ff1f 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
> @@ -29,6 +29,7 @@ properties:
>        - description: input fixed pll div5
>        - description: input fixed pll div7
>        - description: input hifi pll
> +      - description: input sys pll div16
>        - description: input oscillator (usually at 24MHz)
>  
>    clock-names:
> @@ -38,6 +39,7 @@ properties:
>        - const: fclk_div5
>        - const: fclk_div7
>        - const: hifi_pll
> +      - const: sys_pll_div16
>        - const: xtal

And adding an entry in the middle is also an ABI break. New entries go 
on the end (and should be optional).

