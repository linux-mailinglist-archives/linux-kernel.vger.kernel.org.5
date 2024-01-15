Return-Path: <linux-kernel+bounces-25901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E829C82D7D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEED1C21941
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86639282D6;
	Mon, 15 Jan 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI8t6imj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1018E00;
	Mon, 15 Jan 2024 10:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF796C433F1;
	Mon, 15 Jan 2024 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705315935;
	bh=yNMnDGNncTu5nTM1tbDByTT3u4h9k8S1TWf2WSI5WYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CI8t6imjMbeNVG10AzRCaWdkzIXkQ/3oJNXQ3qU26ho8eV34BV5R3mkA0KAQVoYCy
	 h+nuurAfJAV/OrXWJ/BeAhjstG85Rcwvba8nyryGmoKW1Yo5UMCqLRDNk5bTTJcPEe
	 UmFA0g40BtxLHym/qG/R0umbgKJYzRJ0uukpajRhRcJdYnMT6P7olbaAnUl62B/pMM
	 fzju+e4yMF5Y7qNrx+uu1HYGpEEVHO0wZnhh6fMt/gZnPfRfWJ69DYFv4gHALUWAk2
	 QohT+d+Q8JENFO/PMxetrmc/fQmo6rkbr3hOSxgnfZa6uHKZykfJ/ZCeCgz2HJU68b
	 qQUBwXAF4IJPw==
Date: Mon, 15 Jan 2024 10:52:09 +0000
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
Subject: Re: [PATCH v3 2/4] netfilter: nf_queue: remove excess nf_bridge
 variable
Message-ID: <20240115105209.GP392144@kernel.org>
References: <20240111150645.85637-1-ptikhomirov@virtuozzo.com>
 <20240111150645.85637-3-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111150645.85637-3-ptikhomirov@virtuozzo.com>

On Thu, Jan 11, 2024 at 11:06:38PM +0800, Pavel Tikhomirov wrote:
> We don't really need nf_bridge variable here. And nf_bridge_info_exists
> is better replacement for nf_bridge_info_get in case we are only
> checking for existence.
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Reviewed-by: Simon Horman <horms@kernel.org>


