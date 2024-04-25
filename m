Return-Path: <linux-kernel+bounces-158904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2DD8B2682
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D2F1C21FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED39514D715;
	Thu, 25 Apr 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHCB1Lyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC614E2CF;
	Thu, 25 Apr 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062638; cv=none; b=p2SEWaC+0G/exAKPaitqeeXj4r0xB5NHBKBtXQK9TwF5kN+ZOG+YmVMVas7kxOIlpCm7bcT56XOUDSuGhoVaqkLUvblkGWTGP0Fck/8zwpK1Ix8GvZafR7MgYr/+e/6c8KoXcUBx4wrIap+Zd1lYrHF9/KuCxhlIutrjWXi1B9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062638; c=relaxed/simple;
	bh=o6qnkohJ43I0c9dUSdw3e1QtuR0Qmn9fqg4+khVlmGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmGHIS6lI37Fv3gab74g0XqTvxepHLIujF9AbPkjU+yG3LJk4jWXaawOv3amQoL3TvBC//dtHZP0LFbJYx+9p6JsPRCcY3EQb51fNalNrP5h3d6RjkiOLn2/t2zxd0lzOliNUtZHjR/P2YpXAAq9PHwbcxl3jXmwKHp8L3fA4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHCB1Lyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFADC113CC;
	Thu, 25 Apr 2024 16:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062637;
	bh=o6qnkohJ43I0c9dUSdw3e1QtuR0Qmn9fqg4+khVlmGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHCB1LyzEL+j8iFGW5mQoqMy1mB1Uv50bhBymZOdc1h+qVy3ZCZe/494SBd2S1fj/
	 OHbyMfU6/0D9dOG4YWHpFE/YcC1ckg+qNP1mvehERsCl4sfzKGv72r1+P3qZB62M70
	 Jy5LZoZZ2BLzcVor9re17KnYDOVwyfMcUsYKvy9dBuq/yLNCihv5OWGWp8qfN4FiJi
	 WfNS+53EGZrcPHi4G1E5qdqXyJDqcVKETUnmsr3we7x0gBZ8x83FlDqjJkXCiKPSJd
	 dpuDmBiRVV3j53YaKEUYfcWmviAAL1RIV2IhIgpvumhO90gvGitPGCgu1DS7srJJwf
	 g7evSH24HCbAw==
Date: Thu, 25 Apr 2024 11:30:35 -0500
From: Rob Herring <robh@kernel.org>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Pascal Paillet <p.paillet@foss.st.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/3] ARM: st: use a correct pwr compatible for stm32mp15
Message-ID: <20240425163035.GA2783061-robh@kernel.org>
References: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425074835.760134-1-patrick.delaunay@foss.st.com>

On Thu, Apr 25, 2024 at 09:48:31AM +0200, Patrick Delaunay wrote:
> 
> This patchset removes the unexpected comma in the PWR compatible
> "st,stm32mp1,pwr-reg" and uses a new compatible "st,stm32mp1-pwr-reg"
> in STM3MP15 device trees.

Why? I don't see any warnings from this. Yes, we wouldn't new cases 
following this pattern, but I don't think it is worth maintaining 
support for both strings. We're stuck with it. And the only way to 
maintain forward compatibility is:

compatible = "st,stm32mp1-pwr-reg", "st,stm32mp1,pwr-reg";

Rob

