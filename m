Return-Path: <linux-kernel+bounces-146992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF58A6DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80074B226FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE617130A6E;
	Tue, 16 Apr 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m62TINJR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44312D76A;
	Tue, 16 Apr 2024 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277182; cv=none; b=pU92yu7JGg/wWBOqj7Pi6Ay/8rk9h3XBWdW1mW86a81rycJuzLgy83X4buKDVxRS0N9Yk0zNqRsLEb1uUCGSZdqF0Eu4/KG/d357kHI1UwBnLc4f8Vmktbq+uOYZX5PNcyMe+tXiIOPzz+uIHSSXOV/bG0IINE0ltY9HPRPlErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277182; c=relaxed/simple;
	bh=GVb7oL4aI9Hgmxi62fp4d3V7L7aG/WCmoB49f0NQbDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdvJ6oaObHtihhgiUYBKItw/ijZTe+lrX6W2PNX8wp7illmLqGQj6zGFecE1OetsF1lklOoqvfWqFMqFHqfKLGmMPHd0/JuR+dSE8hxqrUN2+QLv2J3QDBa/Dk4ls94Nymkq4BEphuVxW/TAj0lfH57lxb3t/cPfgqY6OEf678Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m62TINJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3512DC113CE;
	Tue, 16 Apr 2024 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277181;
	bh=GVb7oL4aI9Hgmxi62fp4d3V7L7aG/WCmoB49f0NQbDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m62TINJRc0iTctIW8EKh9BBJpObSadSaXkzXcdo3CrhXe8JuvCJSb3F7rvjWK4Wqw
	 yXPPD/6gpTttYxoWuqYc0P2/YoE2WD8T2t0ojgm+/7OOp0/pd87UwxQrpBTgm9sVxN
	 KcerZ4k9fKAO6Afljk88Ba3Lfsrpf7axfoGrQUcY1u13FTL0ABlxTZvHpVKrKKwIt+
	 nE2DWb/SavMApUolZU7YgqU8EcCPpnprGtLnCcpF05dwPh+SKjCI5tx2VAtP1HGaZB
	 qzKPbzAQO95jpByEtryLDIfgNN4DP8KKAi+DrN6Mg4iOaoYPeB3CxSZVDJAckvyrF/
	 WSV7oJ3u2mabg==
Date: Tue, 16 Apr 2024 07:19:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 7/7] netdev_features: convert
 NETIF_F_FCOE_MTU to IFF_FCOE_MTU
Message-ID: <20240416071940.32c67f3e@kernel.org>
In-Reply-To: <5fe95845-9cc6-4873-8748-b125cb310036@intel.com>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
	<20240405133731.1010128-8-aleksander.lobakin@intel.com>
	<20240408193806.18e227c8@kernel.org>
	<1f14cb75-ee6b-4a7d-9041-23a8cfcd8476@intel.com>
	<20240411074709.249b3482@kernel.org>
	<5fe95845-9cc6-4873-8748-b125cb310036@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 14:45:42 +0200 Alexander Lobakin wrote:
> >> This whole enum could be made as bitfields, should we convert it? Would
> >> be a big patch tho ._.  
> > 
> > As always, I haven't investigated closely :) But my thinking was -
> > we are at 34 bits in priv. We just need to convert 2 of them to
> > a bitfield, pick two with fewest uses. Then we can downgrade 
> > the field to u32 from ulonglong, and we can carry on adding bitfields?  
> 
> Hmm, sounds good. You mean convert the existing bits which don't fit
> into u32 to bitfields and then add new priv flags as bitfields?

Yes

