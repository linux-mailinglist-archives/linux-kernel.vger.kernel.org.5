Return-Path: <linux-kernel+bounces-76643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AC785FA67
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103A31F24BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E904B13959C;
	Thu, 22 Feb 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhIh2Xhs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C21134CE5;
	Thu, 22 Feb 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610056; cv=none; b=I1vVOlKsBijnfsEVJYwgz7eyq8QAmSdB5+96nNffW/VlG30tVs44nH8bSdNOrVj5QQ9CZZCZHBZz2GhAg0/WBntwdkOm7KdaJEVnYde7HRs7UW/UIlHt1Toqc+ANh9vBz8L2O+KnFnZQXgOlBBdMfB1daICYiPR71fFEWtLs+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610056; c=relaxed/simple;
	bh=TFqTDDc7hfgU+NmeSyhNhMWiSsAwWXo+2EEjwbhB9NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=une7QYfL5SYFil4+D0JdkdfpLNrq/lI58tY3h2B1tHPleod0iEjeQ1YGo/JUkiKWv5GqenV2VuP6aNMTL8WKrBryB57kHtZxnm6Gc+61Nptde/X+IMz83OD+he2OPv3N5qyLFxip7i/bvb4bDk4xJMU+ThMS3NDutP0kJpkxd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhIh2Xhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E91C433F1;
	Thu, 22 Feb 2024 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708610055;
	bh=TFqTDDc7hfgU+NmeSyhNhMWiSsAwWXo+2EEjwbhB9NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhIh2XhskNnFDqhlshGY5CJ1ZjtI+yVVJithb8D4km1zc527YGA9k2xeIy0smnTYM
	 gf/SvP1qQ6Mf+4EEFkLZF/qxVXIU+dcBrP6PXuR4RVBrUaFEMd6KAYrdv6HL4bSqrE
	 GoRBiIio3VehM5XmfruHvU7hy5bK0cDC6steaagzObJVVt3oRAgyXGGTYSpPDT+6DK
	 tojXe02djpvcHwk3JaPAmHEdeEeXARubluikQHLy0qVyDA2CGlTYvhWw/R7aaWkGQp
	 t8hdxZGLiSZXsG4BPFN2OKiNGIEv2rh/r+G2sbmjch0FcgLFsPqALA7CFC5HA/vevY
	 GkZHtNQZ0xnrQ==
Date: Thu, 22 Feb 2024 13:54:11 +0000
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: microchip: lan743x: Fix spelling mistake
 "erro" -> "error"
Message-ID: <20240222135411.GA961545@kernel.org>
References: <20240220091737.2676984-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220091737.2676984-1-colin.i.king@gmail.com>

On Tue, Feb 20, 2024 at 09:17:37AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a netif_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Horman <horms@kernel.org>

FWIIW, confirm is mispelt twice in comments in the same file.
But unlike the problem addressed here, it is not user visible.

