Return-Path: <linux-kernel+bounces-91000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0623870842
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7024C1F22065
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A2612ED;
	Mon,  4 Mar 2024 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z79strOx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF511FA4;
	Mon,  4 Mar 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573320; cv=none; b=L/eO+YvajTrxrz4M2QKim4Nyt6PzR+TgYVlQHK5dIQrNoEV2RbFcxcH4MAkjsOJSc+C0/IVTLFgN6hkeUkaETgwiFMHFp4q01WezuXIaa2XbDXYubauKHF+9Oo37J66r9RQKsL1LTOUPlfzGCxOuaBYolKiltTD7duT5kIJllGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573320; c=relaxed/simple;
	bh=jXPoWYEypMCzFQJdRgp7dQtRm04IRd4h4Diw6kjWE18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ymv9XwTmKbhbTTaJ82Rydg0V9jp6UE2WmbZ4XK5ENtSjh1iUWLdF4/qgqwAKCa5Olvwx/yzmny7I/ngiNzDbjSogy5mW89dXkMpjLSuv7toM48XaHqAr5Cc8TY3V/uts4YG4ERlQBYce9clsiEUjJ8jicr3bFQpsLJR6rYcjHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z79strOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84262C433F1;
	Mon,  4 Mar 2024 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709573320;
	bh=jXPoWYEypMCzFQJdRgp7dQtRm04IRd4h4Diw6kjWE18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z79strOxPlpgeFkzNKa0ZTCRVrEl7Hh7G7FCNFoCdx3F5tSZu6TpNQjpTpue9ubL/
	 0O15rGxSH7/0DRXWaOBwLl/Oq7arEX86vxH9j3k9yyj7dTBV88N1hCSxEwPe4hnBKM
	 P0vFsTQTYEViW3grtMyhsvhs0lp79qgz0wNhm+4iRB88bp7gPsVuajhT1kzIF09unK
	 kuZE5p0BL0m4MpIBiMaNqq3ypU3Z9t1hbJewn3eU9VtA1UtrUsEpps3hlmp9zE40Gy
	 A+ujujDFjjy3Jbq2Ybp5Gnh7XDNXr84PxiNTnFEIg4j8LkkToxkTVCv826gLyfslr2
	 4hQWj2ad3usCQ==
Date: Mon, 4 Mar 2024 17:28:36 +0000
From: Simon Horman <horms@kernel.org>
To: R SUNDAR <prosunofficial@gmail.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removed blocking_link field description to prevent
 kernel doc warning
Message-ID: <20240304172836.GL403078@kernel.org>
References: <20240303144359.7066-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303144359.7066-1-prosunofficial@gmail.com>

On Sun, Mar 03, 2024 at 08:13:59PM +0530, R SUNDAR wrote:
> ./net/tipc/socket.c:143: warning: Excess struct member 'blocking_link' description in 'tipc_sock'
> 
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
> ---
>  net/tipc/socket.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index bb1118d02f95..7e4135db5816 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -80,7 +80,6 @@ struct sockaddr_pair {
>   * @phdr: preformatted message header used when sending messages
>   * @cong_links: list of congested links
>   * @publications: list of publications for port
> - * @blocking_link: address of the congested link we are currently sleeping on
>   * @pub_count: total # of publications port has made during its lifetime
>   * @conn_timeout: the time we can wait for an unresponded setup request
>   * @probe_unacked: probe has not received ack yet

Thanks, this looks good.
However, it duplicates a patch accepted upstream in January.

Link: https://git.kernel.org/netdev/net-next/c/88bf1b8f3c31

-- 
pw-bot: not-applicable

