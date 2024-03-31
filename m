Return-Path: <linux-kernel+bounces-126368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A148935C0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 22:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F89E284E94
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897A6147C77;
	Sun, 31 Mar 2024 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ASpYmpIy"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E963087;
	Sun, 31 Mar 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711916777; cv=none; b=S1W/f6VC8eARFoz/lkY1Sao/ncRcx+0hQCtV0F0xZ9CeDknXYWE7nGPtaeSzjm5MlsKZnGbjrD83ms2PiiiO3HRYSD+76icMNS2pvzGWcyWliel/7tpiCAMGexTnm9IFZht9Y+iO65jgke3alK6IIPpXBMWw2nXNNrDuytApE3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711916777; c=relaxed/simple;
	bh=70jluzot/fLDvHyPHosxOXnuOeZ9PZFiq2k72HElDPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knFggfxaq+4hlOaYuKMcZPo8FGQeh+5+NDKYD17C8sEOzEs1qpQDZ3YxBE4JgE6x960yV/I5zHFSl84LcUkql+JkaXR8icKhAoxpDOM2ggJXvyFcx8ojFKUoz1Vol1TXwZZXFR7wgnyQky16HjBfF8ja7LojRhIPr/jzRuvAuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ASpYmpIy; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EC7931FA4F;
	Sun, 31 Mar 2024 22:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711916765;
	bh=5jhCHaUlKtQAHxBedBly8GQUjQboC4x/vhqiptxebnA=; h=From:To:Subject;
	b=ASpYmpIygRIj2YpPIHsE169JqVKv/sLb1BN9WtDewBm1mXqYGqXaUXb+QYbEKflUe
	 FJDLj1rUy0yfqASBExeku4LhuavN4WgWfg4GTdDD0UsoAYeX2N6jIORvxgNG5TvmH4
	 yPB2B10ul8wW4vA6i+QsJaJh8xNJndknbatXfMOj/1T6veKX6CMKKQ7fd6WpvHffPL
	 xrB0knVifYPueBtF/j8q5qKXiLpLrhYLCYT9bHp97r8ddd8AgMXAHwSkTJuzjhGU9i
	 LtvwHoWBqI+X+R5XeRZfzeLIAOg35wugDdEXm8uJYp+s+hGq219bh/eTOvKSwsudWb
	 0xKxRFcT4UIDw==
Date: Sun, 31 Mar 2024 22:26:00 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] wifi: marvell: mwifiex: replace open-coded
 module_sdio_driver()
Message-ID: <20240331202600.GA4116@francesco-nb>
References: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
 <20240329171019.63836-6-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329171019.63836-6-krzysztof.kozlowski@linaro.org>

On Fri, Mar 29, 2024 at 06:10:19PM +0100, Krzysztof Kozlowski wrote:
> Use module_sdio_driver() instead of open-coding it.  No functional
> difference.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


