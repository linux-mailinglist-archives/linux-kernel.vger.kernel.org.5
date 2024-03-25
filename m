Return-Path: <linux-kernel+bounces-116358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE678889820
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69912B37A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBB613AD1C;
	Mon, 25 Mar 2024 04:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6iTqyP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F1199EB9;
	Mon, 25 Mar 2024 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711327008; cv=none; b=W/jjUAf5zcNX9/UpKsjTLt+JdLHaxnETw9FDNpjdrbKPpKt/YCSI9b8wLxg7ZzWDaYLywL1U4B3NJxiaKI82jTz/8bXgQFaL919tp851lzFgFP1+E8qlGBXvzBkjTz8hK3ypWOn/JzN3zaSUFtn+3DZ63+8iQjdQODLjmOJxzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711327008; c=relaxed/simple;
	bh=ADKAmQUOaYHldXWJswv5b4u4EPWPvg9ByIPOXE0+E3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL+PuDByn6TvoLO0/1vzDBcNNABgZ/0TMOKsBdmEZyUwZO1P2wp5P3EURtwolr9LtgMknLoICsLaknq42P+RxU3hBhXDftUeSMGaupwYucfWZolifPeCZE+08b/riq5e1WKb7xOCObDcB8SueJqiuuVd85vU5fMkGtoeq0akOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6iTqyP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0046C433F1;
	Mon, 25 Mar 2024 00:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711327008;
	bh=ADKAmQUOaYHldXWJswv5b4u4EPWPvg9ByIPOXE0+E3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6iTqyP39S1pX5fGsw1LZXl6ncapNQezHvfHTeLJKS30LaTeYj6Z8MK+IwejcJ7Qv
	 Ig5G2+lUW6oHG/tlb+3GHga0k7qqwiEZS7p3mYTMTOZFF8+jXGwV9Yr4tl8iEF2R85
	 11p0kcn/DQBATlZz4j0vY/TZ/ySkPRAPhA2iW38wOz+7P2MMTQRYlyDuUOEY9aLRDp
	 avlSB1StyP2g6OEXIze3qGnkGppCcdd5j51SfERaJHPNaOMp2lA8SIMfQXljP2ppSU
	 IoZ19Endl2ecX4Z648yNiXD1LLz3cHDU1D81+9y31t/FS+C3EmHNicM53f0DoUQi4x
	 vI0t1EGf3fusw==
Date: Mon, 25 Mar 2024 08:36:43 +0800
From: Gao Xiang <xiang@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
	Christoph Hellwig <hch@lst.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 6.6 329/638] erofs: Convert to use bdev_open_by_path()
Message-ID: <ZgDHG8Ucl3EkY4ZS@debian>
Mail-Followup-To: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
	Christoph Hellwig <hch@lst.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
 <20240324230116.1348576-330-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240324230116.1348576-330-sashal@kernel.org>

Hi,

On Sun, Mar 24, 2024 at 06:56:06PM -0400, Sasha Levin wrote:
> From: Jan Kara <jack@suse.cz>
> 
> [ Upstream commit 49845720080dff0afd5813eaebf0758b01b6312c ]
> 
> Convert erofs to use bdev_open_by_path() and pass the handle around.
> 
> CC: Gao Xiang <xiang@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: linux-erofs@lists.ozlabs.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/20230927093442.25915-21-jack@suse.cz
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Stable-dep-of: 0f28be64d132 ("erofs: fix lockdep false positives on initializing erofs_pseudo_mnt")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I don't think it's necessary to be backported to v6.6 as well as
the previous one "block: Provide bdev_open_* functions".

The patch
"erofs: fix lockdep false positives on initializing erofs_pseudo_mnt"
should be manually backported instead.

Thanks,
Gao Xiang


