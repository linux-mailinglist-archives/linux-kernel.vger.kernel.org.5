Return-Path: <linux-kernel+bounces-55417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8543284BC6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E606FB22401
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF71D52A;
	Tue,  6 Feb 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDKvgOJM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8FD52B;
	Tue,  6 Feb 2024 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241294; cv=none; b=di0XamKQ4V5nDt580ciwfazzD3m5lFrj0Pg5tCR9JCDI7Dlqq9IZCWLfdpMwJ1eFgwHmNFwsRZSOttoiT4nHl/y828m0FiuSQi1kP5q1Auy5pJns3lhkLjnsDqLuRsu7rMrvR+nv9wxTnKmzGw2HXbAZfWgTf8qWt0QgtqHKmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241294; c=relaxed/simple;
	bh=5Gy+tuV3cfqrHMBsMU3iVRWGOH7JO7iDYWB46agyCjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9exam0baBzJkSN5DrPnK0iPZTdzU17p7tqicAZ3T2EgE1BOmTHQu73QzzhgkDgEW4F6LbHaEqHqPxz+yQ0uL0cil6G+Xm/XJMJEMQznIbnFQ7exTbeenQVh382PGQlJxowKzjQkjn46O+FLtOllt6hvejpynQ2LCQhr9bheT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDKvgOJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B27C433C7;
	Tue,  6 Feb 2024 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707241294;
	bh=5Gy+tuV3cfqrHMBsMU3iVRWGOH7JO7iDYWB46agyCjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDKvgOJMUtHhIQorsPE/w7pjsfJBicF+amIeobEhIepdEQgzyA4z6bsFb23n/73P1
	 aBr0rwOQ+Gee7l36LfkxCvPiK2fBbq3mHNXM/SuImZO9N9rstXrv3OY1wKVW6fJ5vV
	 I8dXrT566JmuiPkp8X8ZRtUUhJEqOU7mjB16gNgo+HGbftiZJsC0M+/OQJ7xtOfgOE
	 hJjJJhQXnqXTG41DOORWCNyi+QTkoAMsg3QCEJRqGfkqXQ0vf2JihN7VCohWo5dx7a
	 mJJBQgHbqMDsQ4Te2VLq16CtLyK3dn3sdxHnBqozap82s1YP4xxXWHO6re3lh+4Fxb
	 4Qnup/Zi/SAjw==
Date: Tue, 6 Feb 2024 17:41:30 +0000
From: Simon Horman <horms@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: remove duplicated CONFIG_SUNGEM_PHY entry
Message-ID: <20240206174130.GF1104779@kernel.org>
References: <20240204123151.55005-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204123151.55005-1-masahiroy@kernel.org>

On Sun, Feb 04, 2024 at 09:31:51PM +0900, Masahiro Yamada wrote:
> Both drivers/net/Kconfig and drivers/net/ethernet/Kconfig contain the
> same config entry:
> 
>   config SUNGEM_PHY
>           tristate
> 
> Commit f860b0522f65 ("drivers/net: Kconfig and Makefile cleanup") moved
> SUNGEM_PHY from drivers/net/Kconfig to drivers/net/ethernet/Kconfig.
> 
> Shortly after it was applied, commit 19e2f6fe9601 ("net: Fix sungem_phy
> sharing.") added the second one to drivers/net/Kconfig.
> 
> I kept the one in drivers/net/Kconfig because this CONFIG option controls
> the compilation of drivers/net/sungem_phy.c.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks Yamada-san,

This looks good to me as-is,
but I guess a follow-up question is if sungem_phy.c
should move to drivers/net/phy.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> 
>  drivers/net/ethernet/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index 5a274b99f299..6a19b5393ed1 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -15,9 +15,6 @@ if ETHERNET
>  config MDIO
>  	tristate
>  
> -config SUNGEM_PHY
> -	tristate
> -
>  source "drivers/net/ethernet/3com/Kconfig"
>  source "drivers/net/ethernet/actions/Kconfig"
>  source "drivers/net/ethernet/adaptec/Kconfig"
> -- 
> 2.40.1
> 
> 

