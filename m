Return-Path: <linux-kernel+bounces-35994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A88399DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739B31F2C0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D5782D89;
	Tue, 23 Jan 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwKr99PE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A708003E;
	Tue, 23 Jan 2024 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039452; cv=none; b=mg1QDX7TH33ZNS8Wi0qPpMFjwubI/flvWqrmRA/elVR/MH3W6zOUfNqlvKj5pnrpL8TT6iIjJhGouoT7ClNU1ZTvbTHaW3O84qvu6WIrco/Ogomxn5pbNBStcxUAk0KYxmL4PpBjDn/c7SI8QJ7aRbp+fkj8yRAYzp9YLmjDN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039452; c=relaxed/simple;
	bh=JdM9TTZCWN64d8b7V18qvRomhjSHitoxtF6sWalz8RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G39SukdsbX9eHEA7gP24EtAV487nkhq14RsDjfTmuHULaaFOCU63K9wQxn3BYEqulFgysiBkiDFI2XV1gPmSrJVSqsmYyDSkQ5sfQqSVVzr4FIR+OZyiu1lFWT6AETjV+bWdtKNEtVFZM3/luAaGFmvb/YP/PmUH9hZU/PzNtYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwKr99PE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEEDC433C7;
	Tue, 23 Jan 2024 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706039451;
	bh=JdM9TTZCWN64d8b7V18qvRomhjSHitoxtF6sWalz8RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwKr99PE3PLFylNmMkGyJg3i1edGMRoBYyQsyR4msDUYiyaKA+xo0PT+Ml39I6VCz
	 5KJzNMIGRbczBN3pyGyY4f2HijZ2uB9vOV0Elu/ityI2QNcsEeQGkNevri9zsn9HSS
	 gORdqLmBQa58bsMPQMyiR2kCiZfserJZUXtRJFgvzXFKQ3X/dMnxzD7iKS7O1edEpW
	 52h+gTd7u/ldFMhdOpaGqpdravlexlwdaNkLrCZIbThxPgdgATJ4S2FfA6viLqqaOr
	 ogvZG+zNWX8wyKhfsUI8v3yjgWBNgESlASo9SAoJIqviMl/MhG+oH/bBFBWaJwGDqA
	 Vt5yFiXXnLoCw==
Date: Tue, 23 Jan 2024 19:50:46 +0000
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net] net: stmmac: xgmac: fix safety error descriptions
Message-ID: <20240123195046.GQ254773@kernel.org>
References: <20240123085037.939471-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123085037.939471-1-0x1207@gmail.com>

On Tue, Jan 23, 2024 at 04:50:37PM +0800, Furong Xu wrote:
> Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> XGMAC core") prints safety error descriptions when safety error assert,
> but missed some special errors, and mixed correctable errors and
> uncorrectable errors together.
> This patch complete the error code list and print the type of errors.
> 
> Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> Signed-off-by: Furong Xu <0x1207@gmail.com>

I'm not entirely sure this is a fix rather than an enhancement.
But the code change itself looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


