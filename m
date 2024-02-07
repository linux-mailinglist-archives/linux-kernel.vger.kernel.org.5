Return-Path: <linux-kernel+bounces-57053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20BD84D362
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6021D1F216CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313E127B4C;
	Wed,  7 Feb 2024 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esx+Yz0c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9078585C58;
	Wed,  7 Feb 2024 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339663; cv=none; b=GRhviug1hvprdf43CnJm+128hX+sxboUTen4ge+cjd260P+xJGGkFpiatGyLc3Qer9fy4ZWImKd/cl65qJn+m4YQ2GJDpkRg2rlq8bvqlcogIxgqfrxr6nqVZpBdm/sHK+wbf7daUTGYDaXksNmTDFGhiVf2Pmz55XiKUJ/r92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339663; c=relaxed/simple;
	bh=OfD7wr9LWAP6WJGGaRebhD936Sr/G+hRcry7kQ+lhXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6bnBabYwhVPFhVgzaJWr4eQRrLgMyitbG6MJPbfaMMSJDw0oK/PQuxy4gu7IjwsF6Ww8qy0HXhrE2PDDk+j+M7MR8m8HkZnsFzDpWSIZpefFXJjw5kiCLYbgOi806zE3nxpHU+8yQj+MDsvvllFOSzbIQsdCocJRr1nlTWj8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esx+Yz0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7005EC433C7;
	Wed,  7 Feb 2024 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707339663;
	bh=OfD7wr9LWAP6WJGGaRebhD936Sr/G+hRcry7kQ+lhXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esx+Yz0cKI5KUPIQweG+DjlJwTRzWwX1gkgVfWTEtiYPGzZ3ZvpV4SXLevxbcAlM1
	 n9PI5UkRt2blaGRYDf2Tt9hiqOz8TYPHa0vf0WxDFcJV5dkePBse8PfQLmcTNWW2Mx
	 P68JdsN6im8SYBjIbtxim12nJEgYf5o5foNzzcmP9kuzltZGYC/6CNpKocM9J5UTEH
	 CbkUOuUzTUVu3A19XPhzZB7nLNiAT2Y7MHJQGQZnr7YO+QCo3l5XDH0oAgAC5QLbN+
	 mv8Z7z67WqM+5BAPPFyntBRN5GKzaKiDD4V/i4K0nOrHO81M2MW+eYUJXZ4C5akYdd
	 W4Zphet/u6hSw==
Date: Wed, 7 Feb 2024 20:59:26 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bcreeley@amd.com,
	sbhatta@marvell.com, gakula@marvell.com, hkelam@marvell.com,
	sumang@marvell.com
Subject: Re: [PATCH net v4] octeontx2-af: Initialize maps.
Message-ID: <20240207205926.GO1297511@kernel.org>
References: <20240206024000.1070260-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206024000.1070260-1-rkannoth@marvell.com>

On Tue, Feb 06, 2024 at 08:10:00AM +0530, Ratheesh Kannoth wrote:
> kmalloc_array() without __GFP_ZERO flag does not initialize
> memory to zero. This causes issues. Use kcalloc() for maps and
> bitmap_zalloc() for bitmaps.
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> Reviewed-by: Brett Creeley <bcreeley@amd.com>
> ---
> 
> ChangeLogs:
> v3 -> v4: Used kcalloc() for normal maps
> v2 -> v3: Used GFP_ZERO for normal map arrays
> v1 -> v2: Used bitmap_zalloc() API.
> v0 -> v1: Removed devm_kcalloc()._

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

