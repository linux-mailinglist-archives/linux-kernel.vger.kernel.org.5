Return-Path: <linux-kernel+bounces-44655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01A84258A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283731F24F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6086A32C;
	Tue, 30 Jan 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+Jh8axz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B1381DA;
	Tue, 30 Jan 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619328; cv=none; b=tVfYKy+wEkLkl/9UPYBEjT6WgYLhI69Zdl/cVfvYF3TuygjK5FyHeG+n84JEA5IVeCVtipNU0KAACaYavJzuARJgy9BVDKWmT+GfqUeo7ZPIF1g8zHpyVz63iThi0qsyr5IGLxtG2xhZ4D2tU17mDpsDlF3ac6637aCbI7THgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619328; c=relaxed/simple;
	bh=Tf6ndaQvlZ7unN6I7bVzuwq5MVCoWh4gApMnQqBAE+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9lk+c8901imbir9Xn1Elx1A22TcIbUg+d3XF/nT90Ew+Vqy66IeU//ymW6Wb4ZbNT6ecZ5PZlDJaHBMWdu5aICRPAheIihMNr0QFIr2o7Iw9fi4jzJbtYD1s42rs+Vmq4CkG3UX08lxG80MZfEs62ZNf9bPlLY8AljLEhF9f+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+Jh8axz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E164CC43399;
	Tue, 30 Jan 2024 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706619327;
	bh=Tf6ndaQvlZ7unN6I7bVzuwq5MVCoWh4gApMnQqBAE+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+Jh8axz98CGLCSvMFGqOSpOnoa/5X83e/2NAWGvGPGUy0urpLrfzdpSg5vuhRQua
	 eNOJW+o0505b/YpqgC0bonI3Scr6VBp66tBCtb6/JuhFZ0AAwsWnMGLNoLSR4aIayz
	 hYYcVYsFMvNm8ffE3AuZDSIbQU1U5uTT5favyxy3R3emdXpPrO/qlxWrO+qr0AdT6f
	 fClrrVf8/bwma91gPIX5AsicdR7F4jeuW5+T2MlXjgwkvCUMwQa9HoZeIHsIUsOHbr
	 Ud5t+JawLno/w7VP8diV3QXiOOb7b/adD1vgjzPDZaWsRzOyrkBVIi4vzZgfb1e+kD
	 /GAKzN7nBWklg==
Date: Tue, 30 Jan 2024 12:55:19 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Nicolas Pitre <nico@fluxnic.net>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	dsahern@kernel.org, weiwan@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH net 03/10] net: fill in MODULE_DESCRIPTION()s for SMSC
 drivers
Message-ID: <20240130125519.GB351311@kernel.org>
References: <20240125193420.533604-1-leitao@debian.org>
 <20240125193420.533604-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125193420.533604-4-leitao@debian.org>

On Thu, Jan 25, 2024 at 11:34:13AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the SMSC 91x/911x/9420 Ethernet drivers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


