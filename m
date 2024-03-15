Return-Path: <linux-kernel+bounces-104619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCC87D10F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE401F23836
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC664594C;
	Fri, 15 Mar 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxtVPwY4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493852B9D8;
	Fri, 15 Mar 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519526; cv=none; b=jNa9szOZ0dkRcO4MfHxbqwDxUhhBdjJdLA4EiJqb7793+kQ+agy2ksdFQtZN/bvXlhWpg/QhZ90RIVpzqBuFUkaRh9Xp5S6TbQERTjDPXS37VpdrwDbEKcY94VFWfFnIB+Ew3FbhR3T12O4JFF+B9EqEboxICBQwGw+wN5Mjeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519526; c=relaxed/simple;
	bh=I4yiGMKxs0fQ59nZ33YMS14pXHChscnJgtcJ520E6iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sExHRd071S+ETe5+8zNqGHvtPJbT+WfcemWMXiJ5O5AYe3znN4UyCZ+47+QpAOQMglT0zoBKFkwyPhdU7Gj7Gu/cNMiioAQw0w+yy85WRzqVzeBF+fb8KKI8X2RSerCYgfU6dtbPkXr68UKJLjvYNwF59o8Sz9Wq2NBZSQ01Yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxtVPwY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF912C433F1;
	Fri, 15 Mar 2024 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710519525;
	bh=I4yiGMKxs0fQ59nZ33YMS14pXHChscnJgtcJ520E6iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxtVPwY4vfEneiTk0m6zTkW0Ro2JARQvje9ayWwneQB4/q/b6bVXmqjyYxdzbvEfF
	 kS85xsStpchgmWCbsMVyRVguKK3uyntKlDEPrmp89rkPbVc+PIOlz/ENPUSmn8AJ/K
	 ArcWe+q7UDMl4EL4bpfXrsMZeTKV5J4kBHRdpmc6n/9dyIV2gTpmfqLfmvfVWdu3xB
	 uaQPNirGXjUFa4AuVpwevZA87e9wApe/sN9tuBekd9G19u58b5cv4O/H4Vos99RBmC
	 yJoJD0GRYvC3fMAwFqIAetSJgkUozpgKtMpyV0CwKpAh6W51VTHb52J8ksxv+omq4g
	 t0zXMWoGS1LBA==
Date: Fri, 15 Mar 2024 10:18:43 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-samsung-soc@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
	Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add Samsung S5Pv210 OneNAND
Message-ID: <171051952297.1435235.12756745883937589239.robh@kernel.org>
References: <20240313184317.18466-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313184317.18466-1-krzysztof.kozlowski@linaro.org>


On Wed, 13 Mar 2024 19:43:17 +0100, Krzysztof Kozlowski wrote:
> Document binding for Samsung S5Pv210 SoC OneNAND controller used already
> in S5Pv210 DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mtd/samsung,s5pv210-onenand.yaml | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/samsung,s5pv210-onenand.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


