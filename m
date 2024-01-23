Return-Path: <linux-kernel+bounces-35857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97B8839770
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EDB28D862
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216C081AA3;
	Tue, 23 Jan 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHCNMsCD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B081211;
	Tue, 23 Jan 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033841; cv=none; b=Dgzah6ZN1LieJ5cOpfruz0gPgAvmRVbxcuXyaXaasRNvzeUbuocBUFQ+SZ6TfIJclWP8WBS+lpD4R4LF5IXIUTnFU5vGzjkn6UDbdOCsi4XAY7Ch1AFGjpFyPG6kV51Jrhp81iZXwbxLCw9LJPBqYQgWXiq3b44nET1UUuegXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033841; c=relaxed/simple;
	bh=unKlMqWhOrc7oLSBAs+sTo6HWltBQeZv/oWa9STjUl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkzIo91wbb+BXZqbdc9H6IchCleKOcmya9ETEbDyPUZlKw3o88jR4o/7ThQzFUhwMHPzul1cNVr1pTNNSRW7PiV0DApVpHXohnpXGIKEnaVxfx6kZGBfRZozlIdS1QNgp90mtsPEcRVR098pS7ZlVXETYIsFJi/Y8mKQWPP5yFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHCNMsCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64873C43390;
	Tue, 23 Jan 2024 18:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706033840;
	bh=unKlMqWhOrc7oLSBAs+sTo6HWltBQeZv/oWa9STjUl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHCNMsCDZNKDnH/rK96JBMsA5RQBzAlm2qY0mje8iutGUR5H/S3eVCtCYALf3Pq90
	 XDqgSnjq6EiI+ZRHMbeSHeoEIniwqyuMdv9gv2YwcfbJxtbBvuVA0BidFogIG61Q2n
	 xfzAaOhR0Z5Xg0t5VqE1WpulNSCUADhjUXfi6J8NixO5Sc8o3AGqU/8KM8Z0wRfdNi
	 9inUgqDO8x7RfjwCBbqQB2b7xvffyt4uOQm/5a037yohMFA6mBspf8TdIr3jFoFouW
	 C6Og2hJWdIvaeP7eaS1Y/X8dY9ZFRNCEihPyI1V5Fy5nkEWMc85JEZZ7y6AruQtZ5K
	 D+KihjKdDOwew==
Date: Tue, 23 Jan 2024 18:17:16 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sbhatta@marvell.com,
	gakula@marvell.com, hkelam@marvell.com,
	Suman Ghosh <sumang@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: Initialize bitmap arrays.
Message-ID: <20240123181716.GP254773@kernel.org>
References: <20240123051245.3801246-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123051245.3801246-1-rkannoth@marvell.com>

+ Suman Ghosh <sumang@marvell.com>

On Tue, Jan 23, 2024 at 10:42:45AM +0530, Ratheesh Kannoth wrote:
> kmalloc_array() does not initializes memory to zero.
> This causes issues with bitmap. Use devm_kcalloc()
> to fix the issue.

Hi Ratheesh,

I assume that the reason that the cited commit moved away from devm_
allocations was to allow more natural management of the resources
independently of the life cycle of the driver instance. Or in other words,
the need to free the bitmaps in npc_mcam_rsrcs_deinit() probably indicates
that devm_ allocations of them aren't giving us anything.

So, perhaps kcalloc() is more appropriate than devm_kcalloc() ?

> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

