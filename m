Return-Path: <linux-kernel+bounces-94497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7AF8740AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F68C1C212EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16870140389;
	Wed,  6 Mar 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVuqLScG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A00140368;
	Wed,  6 Mar 2024 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754232; cv=none; b=uToBwZCrVfyGEpZuZeYihzZudYgRo7mxAEAfFWolCybtduAxbJNtvvF6CioXpJKT6naCnCnFDdA2+q/3RNW5pTh3ic2kMg1F5/znRjONSZvnZai4v0vLDvK4nxt9M2gWf4MfNE/af0OicK/7J8cqyoEYpyWmltKh6bLTnk62qO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754232; c=relaxed/simple;
	bh=cDcynlg09PGkT09NRyUpJm9Vb1/jsYZ/mjlNe+XyGRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5lcCV5Ble7oB/UrhEcCpZtGCunCS2Z0slo0dIL3FcjoCy5Rbrjegefe3Xmk3Vo+y/mXj6fGLiOFiUgiEVdONUuvXEJuR8+ei9fx/iYmo5CamS3wzdXZTGfr9D3ML2VvH7Hp21G6P1LunyXUFF3mOuXunsulCgfU7NrNO3D0vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVuqLScG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421BAC433F1;
	Wed,  6 Mar 2024 19:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709754231;
	bh=cDcynlg09PGkT09NRyUpJm9Vb1/jsYZ/mjlNe+XyGRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVuqLScGrbDQLbjTW+Gko6kM1DNY9/oIAe6jT28G1JpZflHZGIelb5Ibrv6VA1lKx
	 VV3EEJrKuzmmln98Q8oujcR3jh5pFqjgR0GUrlfg3VuhaTSwYQ/QRMPJXI4ATGZcvW
	 sDYu8ASnyK5GN10BhEu7rghIP6FeZeJaZsB0me8EjAw/ylNclzFE44FV172bNvnOTh
	 XMYuebMh+yAHKZG3+HKPYuKgDzRqFJTYQyZbqF278Y1S/W/RMuZ8a1jQmucnYIcMmX
	 Gsf7nCTXC0mhCbWxFB/U3cZbXV/QiPJDPGrSy5Abz8oocTsaSylSFre0/sz1AIDPkl
	 oQbylq66sqmFA==
Date: Wed, 6 Mar 2024 19:43:47 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH net-next 2/2] net: geneve: Remove generic .ndo_get_stats64
Message-ID: <20240306194347.GB281974@kernel.org>
References: <20240305172911.502058-1-leitao@debian.org>
 <20240305172911.502058-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305172911.502058-2-leitao@debian.org>

On Tue, Mar 05, 2024 at 09:29:10AM -0800, Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


