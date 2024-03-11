Return-Path: <linux-kernel+bounces-99040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536A88782AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5413D1C217C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432574174A;
	Mon, 11 Mar 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHOAYznz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35540873;
	Mon, 11 Mar 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169452; cv=none; b=A7thVm/lcaYo1gEEgqYXf8K/cmjxI8lmggnWATX+U7B8ZlajIFfs5fH0dcMj1oVOKxCV0IeUtzP9TU4TVrEhdADR9XGtfP+Gy6HCtjoyv1q4gMXL4r9wm8QpmeXmDFQRszgmKbE+WuDcesqbc2UMViBHZBzgkRrtdP0vpEriT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169452; c=relaxed/simple;
	bh=02c4YoqEvY+eWsTE1wgKlX51r+VUj8a5cx6VKw0yVLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYkpTCZbqWhk0suXl52/xUZNH1lzigDRG4CXQlji3Q6HjcAavIyzBvNiIt1dx+pHuCW2jbwWBWFZW972pkFhMmAp4ItmgrrhABlKOihDibC3Y/AswY61etjUt7h+dW4k/u/YtDGGklaoH2WXRYSbW8ipzAS1DyWXOcziJOzB4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHOAYznz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6350C433C7;
	Mon, 11 Mar 2024 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169452;
	bh=02c4YoqEvY+eWsTE1wgKlX51r+VUj8a5cx6VKw0yVLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHOAYznzP1DS53pVNaqXeEaOBrFBRkrAR598/7pnmgFVTWpXaHOnOCy76UrBJRq9f
	 qBdNoeNz1tCnxN+PdwPttGqQVXiO/1cunDZDRoPNJxZKLUh7iWUVm7d8IImEtrmVG5
	 CVJZl8QxL9TSYuRetPdbrPw36yzMdCL0VjOoUfF8ZmId3yqdfmVZNXZr3Y+nZeUI3d
	 fM8Gv3vKYvyRb8sfkNZxRrlokDzbAO0vnv+x1h0/pCjXfle0qsYvTPH09ZqVyCJ57B
	 nY+z+K9EOw56k1kHZ3ODdb6EhFGIVrvEOG/1+frBiJ4FVvHjL05EtkaMQndrioGfIO
	 GNz8as0Mr52Aw==
Date: Mon, 11 Mar 2024 09:04:04 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, magnus.damm@gmail.com,
	mturquette@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	sboyd@kernel.org, geert+renesas@glider.be
Subject: Re: [PATCH v2 01/10] dt-bindings: clock: r9a07g043-cpg: Add power
 domain IDs
Message-ID: <171016944349.1184113.14007505060428814877.robh@kernel.org>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
 <20240307140728.190184-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307140728.190184-2-claudiu.beznea.uj@bp.renesas.com>


On Thu, 07 Mar 2024 16:07:19 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add power domain IDs for RZ/G2UL (R9A07G043) SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v2:
> - added "RZ/G2UL Only" comments to some defines
> - added RZ/Five specific defines
> 
>  include/dt-bindings/clock/r9a07g043-cpg.h | 52 +++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


