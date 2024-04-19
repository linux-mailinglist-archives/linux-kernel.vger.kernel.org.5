Return-Path: <linux-kernel+bounces-151954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969828AB63F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C081F22551
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181E42E41C;
	Fri, 19 Apr 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnxsxPzy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2610961;
	Fri, 19 Apr 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560991; cv=none; b=hqIajs5jvZw593ZMvpdH9+wnHMVbRem59qh4LVMIL3YnX2E+4lS3YtypCL6rfRygxaIEmCRKNnXAELkAha7ZYLgRhwmvbi261ZGHsidWONspraatMZGFevbk6gLQ1+b+eZo3BEuMPYOB2wAK/LnYr9XCgVHldh3ljhnhJTdKJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560991; c=relaxed/simple;
	bh=GCzclxZJWdtU2QJtBJyOMVjTATOp6d+Ec7EbDgAUeng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afW0qt+B9KhBHlJM9k+3UaUSmBwISUGT0Hy7hz13No6zWfk47w8kY/KvXR7ebVtC7z1Fhyr8Fot1oIomKNhKyKDxHfYAs3iTMRYkqdznwEw4luhPWeR4pFGxuv3Sze/ID2ymABw8q9Z6lvwZaRrG71DFRLCq3dIwgRG768aES7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnxsxPzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06124C072AA;
	Fri, 19 Apr 2024 21:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560991;
	bh=GCzclxZJWdtU2QJtBJyOMVjTATOp6d+Ec7EbDgAUeng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnxsxPzyZ3dJPAKcq4cF9uOQE/sl9utZo26jG/Tit6BcMQr/AoTwWES+NDFgkZ0ig
	 bMOAXacUhQTihh1hMipxDINNet9tJ8CyN1DgJUP+XUpDg4tx2iIRWcxyDz/g/Go3NX
	 6AT0JLKPySKUVymiIRPe/lo3vBGoxUhzDkTMifzQg6C1aXQaLbfYolqqHxyMc0pLcv
	 1PH/9JldpM1li2/p5BzW04N769oWuCTHxq9da/3YzoB7EnhW+dQPMX1eEbz/C7wsPW
	 j3OKmLtmOq0pVUzuLLi6muprtTBxHwjNYT03uUNMLUVi/juEf/Fal9aGggmVolwg47
	 r/7sq/pLYhD8w==
Date: Fri, 19 Apr 2024 16:09:49 -0500
From: Rob Herring <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v3 4/6] dt-bindings: clock: meson: document A1 SoC
 audio clock controller driver
Message-ID: <20240419210949.GA3979121-robh@kernel.org>
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
 <20240419125812.983409-5-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419125812.983409-5-jan.dakinevich@salutedevices.com>

On Fri, Apr 19, 2024 at 03:58:10PM +0300, Jan Dakinevich wrote:
> Add device tree bindings for A1 SoC audio clock and reset controllers.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
> 
> This controller has 6 mandatory and up to 20 optional clocks. To describe
> this, I use 'additionalItems'. It produces correct processed-schema.json:
> 
>   "clock-names": {
>       "maxItems": 26,
>       "items": [
>           {
>               "const": "pclk"
>           },
>           {
>               "const": "dds_in"
>           },
>           {
>               "const": "fclk_div2"
>           },
>           {
>               "const": "fclk_div3"
>           },
>           {
>               "const": "hifi_pll"
>           },
>           {
>               "const": "xtal"
>           }
>       ],
>       "additionalItems": {
>           "oneOf": [
>               {
>                   "pattern": "^slv_sclk[0-9]$"
>               },
>               {
>                   "pattern": "^slv_lrclk[0-9]$"
>               }
>           ]
>       },
>       "type": "array",
>       "minItems": 6
>   },
> 
> and it behaves as expected. However, the checking is followed by
> complaints like this:
> 
>   Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml: properties:clock-names:additionalItems: {'oneOf': [{'pattern': '^slv_sclk[0-9]$'}, {'pattern': '^slv_lrclk[0-9]$'}]} is not of type 'boolean'
> 
> And indeed, 'additionalItems' has boolean type in meta-schema. So, how to
> do it right?

The meta-schemas are written both to prevent nonsense that json-schema 
allows by default (e.g additionalitems (wrong case)) and constraints to 
follow the patterns we expect. I'm happy to loosen the latter case if 
there's really a need. 

Generally, most bindings shouldn't be using 'additionalItems' at all as 
all entries should be defined, but there's a few exceptions. Here, the 
only reasoning I see is 26 entries is a lot to write out, but that 
wouldn't really justify it. As Krzysztof pointed out, you either have 
the clocks in the h/w or you don't, so saying they are variable is 
suspect.

Rob

