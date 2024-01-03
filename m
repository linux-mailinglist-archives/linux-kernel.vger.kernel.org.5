Return-Path: <linux-kernel+bounces-15823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F968233E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF84E286835
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE551C696;
	Wed,  3 Jan 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss1HqxdB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A11C2A6;
	Wed,  3 Jan 2024 17:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F28C433C7;
	Wed,  3 Jan 2024 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704304368;
	bh=v4FnOT3+qS+6Q7aq9Kz0FybsYzgazhhzJUuxOz3LL5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ss1HqxdB559XH1OG9QLVj/IntPizmprsqe5d39xYMFi3kgKSf8ikKu+PU1OoAdEbC
	 09ROyfaV0IBSVIVRh+zPpMSXn9cSHMCnaDKERo4QQ5yGB7g7vDeILdN54UdpTlZvEz
	 IS83nvKlHKuda0I02T2FC4ivDUptwZKcGwN9fI6TaRoSWZcIjQWUd+yLUXp1HVh6Lp
	 S0zDHARvH4ADrFs0GeusmL1Iy7vnOcUbdy4mayvsouv6SUeSEH3R2RpE4a6FdKoEGr
	 Azy0x16uqMnaLhH/KscabZPnNybpqKdr9l0QDPQlILyGaeTpTOy5VsIOcmH0yrA/vo
	 KQwWeXS7ZcKtQ==
Date: Wed, 3 Jan 2024 17:52:42 +0000
From: Simon Horman <horms@kernel.org>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH net v2] net: stmmac: Fix ethool link settings ops for
 integrated PCS
Message-ID: <20240103175242.GC31813@kernel.org>
References: <20231226083432.24920-1-quic_snehshah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226083432.24920-1-quic_snehshah@quicinc.com>

On Tue, Dec 26, 2023 at 02:04:32PM +0530, Sneh Shah wrote:
> Currently get/set_link_ksettings ethtool ops are dependent on PCS.
> When  PCS is integrated, it will not have separate link config.
> Bypass configuring and checking PCS for integrated PCS.
> 
> Fixes: ("aa571b6275fb net: stmmac: add new switch to struct plat_stmmacenet_data")

Nit: a correct format for the line above is:

Fixes: aa571b6275fb ("net: stmmac: add new switch to struct plat_stmmacenet_data")

> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>

...

