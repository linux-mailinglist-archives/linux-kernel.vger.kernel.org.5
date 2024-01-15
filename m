Return-Path: <linux-kernel+bounces-25902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C382D7D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0032A1C218C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91192BB00;
	Mon, 15 Jan 2024 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhKyMAZ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA61B805;
	Mon, 15 Jan 2024 10:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7F3C433C7;
	Mon, 15 Jan 2024 10:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705315952;
	bh=RFaulRgL6X5vCPqvRQjmHpBtz1DdcxcvExPxt1UW5fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhKyMAZ3ztc5BvVHdPsEvp9MjjR+nORDfzw00YT6eyQmQhw6KH2PPvGcWXxjYvqmZ
	 yyYo7Z2xSjXS+dou4KXfUJ0s65npVFKhd+pAsiErA621XxFO17CMPc1JrNzaryoDAL
	 NLCnrKOy5Xs0HsHnFGv2k3CFrq+BeVA7N/r4tt94kyziszrcBGhK3BZH8eP5CEzXAP
	 Dokv2zoWd3wd4gDGZ6Y1ugWgCu8j1SVi7x+yToE8BFfc8PqEtKinCO4PW2nmwHvU8H
	 fWL7jMlVg22cgYrmD8Lbk5btb3S/u/qzADIh47QcHynNgTLlOd5CWQg+Tz7G5nCph4
	 obC+LNkSjDOvQ==
Date: Mon, 15 Jan 2024 10:52:26 +0000
From: Simon Horman <horms@kernel.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>, David Ahern <dsahern@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Kees Cook <keescook@chromium.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev, kernel@openvz.org
Subject: Re: [PATCH v3 3/4] netfilter: propagate net to
 nf_bridge_get_physindev
Message-ID: <20240115105226.GQ392144@kernel.org>
References: <20240111150645.85637-1-ptikhomirov@virtuozzo.com>
 <20240111150645.85637-4-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111150645.85637-4-ptikhomirov@virtuozzo.com>

On Thu, Jan 11, 2024 at 11:06:39PM +0800, Pavel Tikhomirov wrote:
> This is a preparation patch for replacing physindev with physinif on
> nf_bridge_info structure. We will use dev_get_by_index_rcu to resolve
> device, when needed, and it requires net to be available.
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Reviewed-by: Simon Horman <horms@kernel.org>


