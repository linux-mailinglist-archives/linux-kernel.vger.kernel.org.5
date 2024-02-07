Return-Path: <linux-kernel+bounces-56411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAA084C9D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D9D283E39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4281D529;
	Wed,  7 Feb 2024 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA0SLtk4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5931B803;
	Wed,  7 Feb 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306198; cv=none; b=KdRFblT+jTs2FCXOi9IzZ26OF66zqOsjHb3/Xvw2GjYRQIdBUVYqds9dPXNbt836R5uG4fYzMRbmSsWZsdksn++O0QGafaKWvGoma9xvGn6ItH42RTZ5o7RvtW+j9cR2labZi2SPLFhbAnArFtK9Xdznbezhmc1gkf1f+SMnGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306198; c=relaxed/simple;
	bh=eJmWmpAaGlJo37i1l50LRJbPbWJ0e61aybJMwT12O+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih6U0F45sxZHWaf1a2HLR6nEL5qE7ROPBXQIYVtNu1WPgwnvCKUY0cu7hi5T0KWQDIxYCbR9TggA0/1Ky3y4wLINKc1QPeL1GxjGr6SWEV5VJwjig7ngk0wni1R7GoTGLUoOD+UFtYHuv6u3sIbZCukJabnE2gJURbFDiCqHyLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA0SLtk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFF2C433F1;
	Wed,  7 Feb 2024 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707306198;
	bh=eJmWmpAaGlJo37i1l50LRJbPbWJ0e61aybJMwT12O+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BA0SLtk4laeyClQXmbEAwAw0x2ywPt+VHq5dwJ8sUTA4kaU/X7j6GYMOB0pJJdVe+
	 DnVoXAKCWc0UZDNEi5Xy3uVEx7YvEla1DD3mBtn612cgtIh8aV6+EsiyaYbSAcV5cd
	 BnPAG4hvDPJQ1E1MV2CBfvPTrYbQZFlyjin6YRjTR6+LCVsP9B7Gqf0zl3U4ksnCUM
	 JCwRgUSv78jUFyyXshyDchYwC3jmyx7BelzrvqcOjnl3eCuxeiFzoA8Yv+EeftgpH+
	 hhA/z7JYdw1tT8mRdX0rbM+GI1x0xT0n7+7j4Nd5Te0WyDRtLZkbuU8gJHT+4wGqmt
	 bWzzQu4bDP1/g==
Date: Wed, 7 Feb 2024 11:43:14 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net v2 8/9] net: fill in MODULE_DESCRIPTION()s for ipvtap
Message-ID: <20240207114314.GK1297511@kernel.org>
References: <20240207101929.484681-1-leitao@debian.org>
 <20240207101929.484681-9-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101929.484681-9-leitao@debian.org>

On Wed, Feb 07, 2024 at 02:19:27AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the IP-VLAN based tap driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


