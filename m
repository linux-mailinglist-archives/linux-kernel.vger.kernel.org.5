Return-Path: <linux-kernel+bounces-31525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A67832F83
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6052869E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5372A5646C;
	Fri, 19 Jan 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdoKhSdr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631955E52;
	Fri, 19 Jan 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693864; cv=none; b=lfADv2cyk5VhDr8VDfpL+wu7Fcx0iRqMYMZE7/uQYvIjMY2HjhU6dUOwrALjckqoPqh7qEBfWiBeMOFrOmxXpsFBaoVRmI82ULf9zhWUiyH2ZL6hpcf64Xm8y56pC7s1xh3+ETDTfTdJPpf3IpBB+ZYodTr7SmvnEDstcbrHDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693864; c=relaxed/simple;
	bh=SzCF2j0Up5YH6JQzgE2/Na1H4YvwWZv6qYQ4tIsQh8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8kVd2J8ZdwX5tiLKq3tS0oux7I7jflNlnCHJ5K4D8yk1eojpP/ha/W6ASPYFPJGg8vQP+ESCSwrwsajNhytc3ls4RErU7MKkCG3qCRfFvXEl2UPBkeD5XOMCDSo3gxFgbuDQq7KV8v4MZyUHygizEgQ5VDzW3ZoXBi4KQ5lzCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdoKhSdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D87C433C7;
	Fri, 19 Jan 2024 19:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705693863;
	bh=SzCF2j0Up5YH6JQzgE2/Na1H4YvwWZv6qYQ4tIsQh8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdoKhSdrnMfM/E7IRTaV5soF3wxuSoSzE5IAevQO4gia0EcdgcwFFVOOFP6gJHoS+
	 7iwMHhbJeqY+DdMwVf6PEhrebd0VnvE9RF/0TyCPpU9RNkWfnSlkDTYMTya4O6jLTA
	 fJLmZFETTzHkOpF81yHNJAuWSCWYeO/g58VimGZ17oftrpmIy57K3OlDsoJajO1pKi
	 vuZ8ELQ9/tt8JXOo4aNSl2cRGKqRQ8hfJVr948UsgcyFzjcd6Vlv1b87Ako/z0yIiM
	 OAYUo1LLZ8Xi1WJfSRFf9guHP8WXEeCvggrcGV0u97SB5Or/iqCgVvUQ27TTCJQCUn
	 cqQWRuF5yDuEg==
Date: Fri, 19 Jan 2024 19:50:58 +0000
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, razor@blackwall.org,
	leon@kernel.org, haleyb.dev@gmail.com, ja@ssi.bg,
	judyhsiao@chromium.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] neighbour: complement nl_ntbl_parm_policy
Message-ID: <20240119195058.GA105385@kernel.org>
References: <20240119070847.5402-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119070847.5402-1-linma@zju.edu.cn>

On Fri, Jan 19, 2024 at 03:08:47PM +0800, Lin Ma wrote:
> In the neightbl_set function, the attributes array is parsed and validated
> using the nl_ntbl_parm_policy policy. However, this policy overlooks the
> NDTPA_QUEUE_LENBYTES attribute since the commit 6b3f8674bccb ("[NEIGH]:
> Convert neighbour table modification to new netlink api").
> As a result, no validation is performed when accessing the
> NDTPA_QUEUE_LENBYTES attribute.
> 
> This patch addresses this issue by complementing the policy to ensure that
> every attribute being accessed is properly validated.
> 
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>  net/core/neighbour.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 552719c3bbc3..ece0447cf409 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2293,6 +2293,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
>  static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
>  	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
>  	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
> +	[NPTPA_QUEUE_LEN_BYTES]         = { .type = NLA_U32 },

This does not compile because NPTPA_QUEUE_LEN_BYTES is
not present in net-next.

>  	[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
>  	[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
>  	[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },


## Form letter - net-next-closed

[adapted from text by Jakub]

The merge window for v6.8 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens on or after 22nd January.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

