Return-Path: <linux-kernel+bounces-157662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F58B1430
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDACB25549
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A2913D2BC;
	Wed, 24 Apr 2024 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFe3YnWc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7322F1772F;
	Wed, 24 Apr 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989485; cv=none; b=UJUHNFxpWmBZNwiejsQJpziZPQeqeqGHttY6wAk1/DtFA5hC/8D1/XoJMpxXT4SPD2hRkvT500iFAL4ple77SQuq76D4rMO2HdzbYWNDZ/xjJhthSeeTwch8NwMiJtudSWbHILvRYC7cxNOsCSqAFEcXiKoUl14rb5hKcmitKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989485; c=relaxed/simple;
	bh=UBmpCETlbSLWoI/p9IWEP/1/pYi6ZGue5/z+HCap4QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQQXvKvbu3Tnb3rK1wDLCPYMyX55Q39JSpyUWMimKjh3mfukMYS19c1IjAb6QX0nhQwYhm53sQzsDQ+G1cQVaZWEDawHbcioH6XcC/l84hpx4EsTWsjFvtl8cg8/0Y3pHif6JkXhppBCjrtajbHoPmeXCV3pBf2pNe8aFF7/Xyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFe3YnWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8FAC113CD;
	Wed, 24 Apr 2024 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713989485;
	bh=UBmpCETlbSLWoI/p9IWEP/1/pYi6ZGue5/z+HCap4QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFe3YnWch1mJ9v1kOTyFBQ1xO+wLK07zzjkw9l46Cajfcdf9QIf3PRysAPy9QZV5u
	 lpvKgLD59fa/hMueX9TmogapPewP2yLmJfc+GoMS72RwTh188+VsXPU7GxHoRPbW/B
	 j2SvZOhwmvZLI91klCpxXu/EfZiXhjb6zsHBJuI7zL7EhGdogm1XWkKfeXYnz0tMuK
	 M4kXn/cbLSBEVfQpEoatCz7UMlNHNha3TcWaQMwWj+9wprUolCJbo9wY/s/JjEGA+L
	 1nr1FE76t3rPb7WE8s8EB4E4dK+5sxHo3z6JGvd6gjNYhEiT2GH3geRioQ8KlBKzRH
	 nbic3lgvAXM5A==
Date: Wed, 24 Apr 2024 15:11:22 -0500
From: Rob Herring <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
	Kevin Hilman <khilman@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Chuan Liu <chuan.liu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v7 3/5] dt-bindings: clock: add Amlogic C3 peripherals
 clock controller
Message-ID: <171398925862.427636.11006695483267074657.robh@kernel.org>
References: <20240424050928.1997820-1-xianwei.zhao@amlogic.com>
 <20240424050928.1997820-4-xianwei.zhao@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424050928.1997820-4-xianwei.zhao@amlogic.com>


On Wed, 24 Apr 2024 13:09:26 +0800, Xianwei Zhao wrote:
> Add the peripherals clock controller dt-bindings for Amlogic C3 SoC family
> 
> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../clock/amlogic,c3-peripherals-clkc.yaml    | 120 ++++++++++
>  .../clock/amlogic,c3-peripherals-clkc.h       | 212 ++++++++++++++++++
>  2 files changed, 332 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


