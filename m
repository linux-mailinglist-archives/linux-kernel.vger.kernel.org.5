Return-Path: <linux-kernel+bounces-140691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7184F8A17C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F9284273
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680EDF42;
	Thu, 11 Apr 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwecqAAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A40F9DA;
	Thu, 11 Apr 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846831; cv=none; b=nXFcNrIxfXQql1eINyjTbux5H75/mfscpHfmMK2++udwoU69VouiF25IsSs3Y8TQh1Wueo92jOxtSo1dmxdeop3GlPLe1FengiMD79x0xFPbNoSqw/Pmy9Dd+JD77IwxIqQ2TXsN+IPBYf3XJrnSBE7NglEUjgLogeYooKoGvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846831; c=relaxed/simple;
	bh=Zb0JBOe6YIm233S2t28Imn/lwnjsEqRahBqWBCo/pFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5KVV4OkOiokw7w0LPoSExmu8w//ykUYzGPrAiD7WEW9OQoYSfJk00Q4AUpOyoJ9rK55kRBPd3c1ryU9ZMEMwohG7hiXpv4QqSq87i/LOEOxWy62oYYPSu9F0mkfy3PCxuVB9bsGYu4x7XF2hIrH1EYARlw6xQhHhQw6o2cLXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwecqAAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53991C2BBFC;
	Thu, 11 Apr 2024 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712846830;
	bh=Zb0JBOe6YIm233S2t28Imn/lwnjsEqRahBqWBCo/pFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VwecqAAYJQb2m3omWvRV1wxYx9OmhDT/0SZSWCtForipxHiXD8ZBAkwXyJLZLZGg6
	 LpW3kiObBAWoyx0jWpB4WoPFn6KyuORQEAGBxVGMD0E4gbU+4/SpJiqMjuXIwWlTln
	 6WKY/FmlEJPuEwWATY/pazEv76+TtGuod9N0YauU5w2Jy1sZkxR5XMKRaaZVckDV+z
	 4z849AXjgfersS2/RsoYoQGS8X0mcUR0cncW2Iva2AhZlxQWxN/5zs2mL9gq/J7pWJ
	 xW1sT+ZXlX4VARq8mdopAzgAXi5pxbgSrwo0gJ0gtur2ihrM+pP2E2ZX/p+vywpqt3
	 a2ASJzpF9/YSA==
Date: Thu, 11 Apr 2024 07:47:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 7/7] netdev_features: convert
 NETIF_F_FCOE_MTU to IFF_FCOE_MTU
Message-ID: <20240411074709.249b3482@kernel.org>
In-Reply-To: <1f14cb75-ee6b-4a7d-9041-23a8cfcd8476@intel.com>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
	<20240405133731.1010128-8-aleksander.lobakin@intel.com>
	<20240408193806.18e227c8@kernel.org>
	<1f14cb75-ee6b-4a7d-9041-23a8cfcd8476@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 12:28:08 +0200 Alexander Lobakin wrote:
> > Any reason not to make it a bitfield? I haven't looked at the longer
> > patches but this one seems to be used like a basic bool.  
> 
> This whole enum could be made as bitfields, should we convert it? Would
> be a big patch tho ._.

As always, I haven't investigated closely :) But my thinking was -
we are at 34 bits in priv. We just need to convert 2 of them to
a bitfield, pick two with fewest uses. Then we can downgrade 
the field to u32 from ulonglong, and we can carry on adding bitfields?

> > But this definitely _is_ a uAPI change, right?  
> 
> Why?

It will be user visible, ethtool -k is losing a field.
Whether that's actually going to break anything depends on how silly
user space is.

As Andrew pointed out, definitely something that should be called out
in the commit message.

