Return-Path: <linux-kernel+bounces-4506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9627D817E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E031F23459
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC2747E;
	Tue, 19 Dec 2023 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1i6h7yR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DD6129;
	Tue, 19 Dec 2023 00:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2B4C433C7;
	Tue, 19 Dec 2023 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702944024;
	bh=uH9ugU+7qqeRDjMYoKm8lVQHLGXGmWs2ElB1AqWtjug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U1i6h7yRznY+6DGXxmEsXQibpH+4jvmWkcauqO2DbhOJQSwU9vJ3fb/rzhwH9dpS9
	 aBJ/zC9Bnvs2YI/dcwLWEbOBZfWQnCQGI2v+m+ylfM775kbiVdCAxeny2HqS+K4T6g
	 u8SUFuAUGVaqB4LDHhJ9ILJ1PlnHeuFY/63oH0KDcwWtY2YALw1nDDOe65FM+AAI4b
	 gWv0rESaCCs+HCy1B4VGPkVdPCFfienU8u1+POUYrJm+vwknBvZqlAQAJtdnpyLgQ0
	 QjBAfcuqS5sZaL7gC+6CpQniFcFQh4Dq3psxjzJpTvHbUluOmlIEr1wZjLBlAPhVsM
	 dL3EF3FoH8tpw==
Date: Mon, 18 Dec 2023 16:00:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leone Fernando <leone4fernando@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ipmr: support IP_PKTINFO on cache report
 IGMP msg
Message-ID: <20231218160022.60434a91@kernel.org>
In-Reply-To: <63bd69c0-8729-4237-82e6-53af12a60bf9@gmail.com>
References: <63bd69c0-8729-4237-82e6-53af12a60bf9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 17:19:35 +0100 Leone Fernando wrote:
> In order to support IP_PKTINFO on those packets, we need to call
> ipv4_pktinfo_prepare.
> 
> When sending mrouted/pimd daemons a cache report IGMP msg, it is
> unnecessary to set dst on the newly created skb.
> It used to be necessary on older versions until
> commit d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference") which
> changed the way IP_PKTINFO struct is been retrieved.
> 
> Changes from v1:
> 1. Undo changes in ipv4_pktinfo_prepare function. use it directly
>    and copy the control block.
> 
> Fixes: d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference")
> Signed-off-by: Leone Fernando <leone4fernando@gmail.com>

Applied to net-next, thanks!

