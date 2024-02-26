Return-Path: <linux-kernel+bounces-82263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC02868159
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C175B1C21F38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FA1130ACF;
	Mon, 26 Feb 2024 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1gWnFbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D912FF76;
	Mon, 26 Feb 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976708; cv=none; b=Fjz/dPe6IGkVUV7YOAvp2IAHvb17cmstKopIe+so1P0yl03O8pai8gH6BaQ+Y21J16Vm+NOkL+rst3pDSGEQHES1eer71NkiZZSf63LZBUD0lm7Bcc6MOfMZ4uCC4j5WUv7/Wg8NygyLlzPGMNOZe8TcS/axC2JgL4HSaiv+4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976708; c=relaxed/simple;
	bh=JInZrPa/kuD/tpdKkEdPvdh8wt+qDhbGZeTQw3e9DXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esgY1UdDUZIIEK6HUqg+2CurJzHe11hag45c9EpTq+r7rI82Tnj6QYWeU2jyL4XEFHOMdI/AOniMECSl3TB0LK79LzhNjdRhwyF5tFLNu8dCcIQ+A7LHjRl5LuiCokyIX29Ag4qykj79Xsfo8Jjy8EMBeXAFPk6gggFSF2uvmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1gWnFbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2667C433C7;
	Mon, 26 Feb 2024 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708976707;
	bh=JInZrPa/kuD/tpdKkEdPvdh8wt+qDhbGZeTQw3e9DXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1gWnFbCJyjj8F1OC0Vt0LxKPTWw6CC+6Dxkfj+iRJPbfSgCvIUxIBjnU3N1aM6il
	 sdO425r79+I5gWR5DjMTt13mXQE0+bX5a6dMNkQP4P/Pdm7TQheaE2vOMT6ZoWrAEq
	 eZwz4xssiuizOOqdExkMie3ODHqJYsWvk8KD3ImQ3vO/xKaRByYIfZf824csn+4ZN9
	 WtBZNgAQhmdAPMrndsIs2h0J/LLZ6FPDMAOGK86V0o5S7Rlg5mkJeUqStbBrWxe0z1
	 8lKqcNHAYtdx2L0gM6wgcybMxtVIf2jsvSDGBoAuwWrKLkZ73o/U3bBd71xyTBIHPG
	 3hvr0BU8d80qQ==
Date: Mon, 26 Feb 2024 13:45:04 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-remoteproc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: clock: ti: remove unstable remark
Message-ID: <170897670414.1320059.18104874403341289968.robh@kernel.org>
References: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>
 <20240224091236.10146-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224091236.10146-2-krzysztof.kozlowski@linaro.org>


On Sat, 24 Feb 2024 10:12:35 +0100, Krzysztof Kozlowski wrote:
> Several TI SoC clock bindings were marked as work-in-progress / unstable
> between 2013-2016, for example in commit f60b1ea5ea7a ("CLK: TI: add
> support for gate clock").  It was enough of time to consider them stable
> and expect usual ABI rules.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/ti/adpll.txt            | 2 --
>  Documentation/devicetree/bindings/clock/ti/apll.txt             | 2 --
>  Documentation/devicetree/bindings/clock/ti/autoidle.txt         | 2 --
>  Documentation/devicetree/bindings/clock/ti/clockdomain.txt      | 2 --
>  Documentation/devicetree/bindings/clock/ti/composite.txt        | 2 --
>  Documentation/devicetree/bindings/clock/ti/divider.txt          | 2 --
>  Documentation/devicetree/bindings/clock/ti/dpll.txt             | 2 --
>  Documentation/devicetree/bindings/clock/ti/fapll.txt            | 2 --
>  .../devicetree/bindings/clock/ti/fixed-factor-clock.txt         | 2 --
>  Documentation/devicetree/bindings/clock/ti/gate.txt             | 2 --
>  Documentation/devicetree/bindings/clock/ti/interface.txt        | 2 --
>  Documentation/devicetree/bindings/clock/ti/mux.txt              | 2 --
>  12 files changed, 24 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


