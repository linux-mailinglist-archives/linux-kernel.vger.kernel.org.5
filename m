Return-Path: <linux-kernel+bounces-17769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B3D825253
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0CF1C23075
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B7B25554;
	Fri,  5 Jan 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNSdlM2q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34177250F4;
	Fri,  5 Jan 2024 10:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA514C433C8;
	Fri,  5 Jan 2024 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704451631;
	bh=Fj/SSOl7xNswg4fz7e/83wsnspdftizIsPCmbpEElBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNSdlM2qkOtNYE3tLN0OcykWWfC59dDMz8mCpPSRiApUdops0EKHcvjR/gbSCYKa+
	 gyMN73Mb7Iv+fU7iw8jvz7x43fjIbxRaivtZ4Iyz6jGDKSNP7J1bW1Yh3cqn88cfOz
	 b/oBbgUB6QSM49JdZZ9wvb6wp+skWKe9z/z3mqulu4nDdbjPQ86hoX/EYhxanl3YZs
	 /wRpPFpWk2AGROH2sThqfeaU4YqmT1LD8SiA4hfzfJJCLaGfpmurBP1n+TTAEaW94z
	 2yqzKl6BYvukNTYuP8h/3pSqv2T0+LanCf2ZvOTS80D+xl5zrbOiG7/fy8D/SkEdkH
	 ac2Zl1fN51GIg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rLhjJ-0003Q5-1J;
	Fri, 05 Jan 2024 11:47:10 +0100
Date: Fri, 5 Jan 2024 11:47:09 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: gbphy: make gbphy_bus_type const
Message-ID: <ZZfeLQz_WpXMxkYc@hovoldconsulting.com>
References: <2024010508-fossil-glove-c2c6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024010508-fossil-glove-c2c6@gregkh>

On Fri, Jan 05, 2024 at 11:38:08AM +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the gbphy_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Johan Hovold <johan@kernel.org>

