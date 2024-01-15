Return-Path: <linux-kernel+bounces-25900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0756482D7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3CC1C218ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD027701;
	Mon, 15 Jan 2024 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E33T4eJr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4A1B805;
	Mon, 15 Jan 2024 10:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9302BC43390;
	Mon, 15 Jan 2024 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705315887;
	bh=75tohajdaNNSPQm1NiUNmFzTTszByQKiAf3bidIzYO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E33T4eJrLn3MtUX8dt+Z2uWqCT8mCfq1WxhCMB+oeOZ7OnujjCMb6cSs8+dGjfU8g
	 V7lVD32+MqY4D29AAALS1yMetYaEH2MQ4PDhB/M42C89VYCqK65ws6GxVgFnVSQFqq
	 D0b5CMu313a+qFulKN1AEFcEfyH1bJIwCUtD72j3EyR2H2fqb39cUYLo9fRCJkNnJU
	 UuqTH/ZMHECrigKnpLsy9iWSX8DZJBHGUog5wdrK6GeAC5HDJk+/SXoucahYvynVi6
	 hu8uODrAyU+H+qNdMv/Y11wWXnO3vGWnf7OLf7o/mMTg/NW6D70xliV2g0cTQb5X3E
	 5l3YadTHesFYg==
Date: Mon, 15 Jan 2024 10:51:20 +0000
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
Subject: Re: [PATCH v3 1/4] netfilter: nfnetlink_log: use proper helper for
 fetching physinif
Message-ID: <20240115105120.GO392144@kernel.org>
References: <20240111150645.85637-1-ptikhomirov@virtuozzo.com>
 <20240111150645.85637-2-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111150645.85637-2-ptikhomirov@virtuozzo.com>

On Thu, Jan 11, 2024 at 11:06:37PM +0800, Pavel Tikhomirov wrote:
> We don't use physindev in __build_packet_message except for getting
> physinif from it. So let's switch to nf_bridge_get_physinif to get what
> we want directly.
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Reviewed-by: Simon Horman <horms@kernel.org>

..

