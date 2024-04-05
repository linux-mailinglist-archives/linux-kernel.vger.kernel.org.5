Return-Path: <linux-kernel+bounces-133377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C4089A2FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0A4281D2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4F171672;
	Fri,  5 Apr 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lP+u2JXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A464171654;
	Fri,  5 Apr 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336354; cv=none; b=WsgGmPNuI0gLeOup8bH4VVxiyrVToUSlRAl0a5je3jMscdoRZtRinIkkcePhdsGaugaBLit9ygXKAbaHuCdaSVVeAxDEx0fhxj3Iy0NLDDe04A1Lq+IXTV3WB6B9VbRjOj75Z8xAeY9xiE0H0Bh9BzVEZMD6OSgOS9K7x8m3aUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336354; c=relaxed/simple;
	bh=d/B9BUVScbOGJpc3/gnx1X+oCXRIadBU2xdDvQPlLYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVjVXsS4FRwGFQksLL3cTFHV2dVTTI5+BkpV3XbcqvwiK+1xXZomgNYtAtmVFqXCoOQ8ldsiW8T26g7orQkIdDL/HA0stwLq0loSN0v5hk/ZIuOWljM8r6FzKAKXb/+FtmTlNJfihKRbI6ot6Mxr7xItuZwic96+ZcloPz+3hU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lP+u2JXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF4EC433F1;
	Fri,  5 Apr 2024 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336354;
	bh=d/B9BUVScbOGJpc3/gnx1X+oCXRIadBU2xdDvQPlLYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lP+u2JXZ9n8HUkFq4xNM0Ac+TW30ZZYeMNJSfpYqo4IUEy4JAzMYGqerY5AW/9VWP
	 Kcd1UD3ByKFFaHpA0x1F+um1ud6Z78Q15h6CH3TXq52yZaYBYRD0x/EsypM0TflpqT
	 cDPU8kFs7QA0/ChNKfaZcMBWgYywX0zAsDzwTxnnra1rHnj9cY5PwWmTbRWWh8k7r3
	 8jTZRdMdCPVF1XicJyCuO4ET5XK8kdGhCpbgE3eiVXf0Dfx5I85nryWJSNyBY4E2f0
	 m6hnSRRZwRN1BM9/muMUrH0XdGn+Fv+nzr6aBbHDY8nvDfAaxIMocW4oTVB+LrQ1CR
	 YDXWG6in03LRA==
Date: Fri, 5 Apr 2024 22:29:10 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Wayne Chang <waynec@nvidia.com>
Cc: jonathanh@nvidia.com, thierry.reding@gmail.com, jckuo@nvidia.com,
	kishon@kernel.org, gregkh@linuxfoundation.org,
	linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] phy: tegra: xusb: Add API to retrieve the port
 number of phy
Message-ID: <ZhAt3kPzn212vAH4@matsya>
References: <20240307030328.1487748-1-waynec@nvidia.com>
 <20240307030328.1487748-2-waynec@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307030328.1487748-2-waynec@nvidia.com>

On 07-03-24, 11:03, Wayne Chang wrote:
> This patch introduces a new API, tegra_xusb_padctl_get_port_number,
> to the Tegra XUSB Pad Controller driver. This API is used to identify
> the USB port that is associated with a given PHY.
> 
> The function takes a PHY pointer for either a USB2 PHY or USB3 PHY as input
> and returns the corresponding port number. If the PHY pointer is invalid,
> it returns -ENODEV.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

