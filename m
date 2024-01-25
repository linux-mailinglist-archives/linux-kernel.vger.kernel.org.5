Return-Path: <linux-kernel+bounces-38525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB4A83C107
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE9E28E618
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B40151017;
	Thu, 25 Jan 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTTFy3hJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAF4EB55;
	Thu, 25 Jan 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182449; cv=none; b=fjhzvGcITPgqz51e2in2Iyyr764psmpeUpi1Hgkt+RD5W0b+OnuhT6T+vpkRbiSDvXqzPpKKlh6s5rdgtvVzxe59Na7FFToE7adrp5c4WWXvFCa9h5LSeuFgGO+LM8HkHVtmjOJz3BKliradHeLoVxFzA7hLx2UPnY8PuXM/lG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182449; c=relaxed/simple;
	bh=TLfJEnIPKzYpdMKU0V+DfSZCB/7ZpVGP02ypQwUMDQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0TVxjwDZVdJJA+FHCTzKHYA+So1bnfaN8GXL4gk/bjGwP8uGMS02i7dVNr2EairtfPSwg5lmFPJ85IZVSPuhXB7hdPJuAl/2OTsnThmaVpbfvUgq/sLfJ/y3lVdD3TijQsile+yc8yv8PLUjYpdEczNaMaCsA8HXlfAPK/mUVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTTFy3hJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B674C43390;
	Thu, 25 Jan 2024 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706182449;
	bh=TLfJEnIPKzYpdMKU0V+DfSZCB/7ZpVGP02ypQwUMDQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTTFy3hJ3SoCH4WJ3JNP1q+ofl/d/snBaI4ZYot8b6hA+hwhMTXOehJT+gouybF0d
	 c++WVZUnblKsGU92/K3GrL5P6aH1H/STAB+VmyRmmQL5r9HZU/RNYFxG9nzn0m/du6
	 c+Oofhj7A+Y5YE3MbS69vl4UfNbky7nIqI70/iy3cySdRnz0eHA/VicdfwJE1iNV6s
	 nve6bRqDgD8syPpw2FXEOckfmQAjrc+5ARSXqPUWTMy4Dw05axto+obkJj5HIojhBc
	 T7VPbg9baL0hk4YZZjfRYKQKJPkwpXjf8+XxZB0+KXt3w5SnB/5QJ/b0pP3UtTyQJu
	 abo8cex7yVmDw==
Date: Thu, 25 Jan 2024 11:34:04 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH 3/3] octeontx2-af: Cleanup loopback device checks
Message-ID: <20240125113404.GH217708@kernel.org>
References: <20240124055014.32694-1-gakula@marvell.com>
 <20240124055014.32694-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124055014.32694-4-gakula@marvell.com>

On Wed, Jan 24, 2024 at 11:20:14AM +0530, Geetha sowjanya wrote:
> PCI device IDs of RVU device IDs are configurable and
> RVU PF0's (ie AF's) are currently assumed as VFs that
> identify loopback functionality ie LBKVFs. But in some
> cases these VFs can be setup for different functionality.
> Hence remove assumptions that AF's VFs are always LBK VFs
> by renaming 'is_afvf' as 'is_lbkvf' explicitly and also
> identify LBK VF using PCI dev ID. Similar change is done
> for other VF types.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


