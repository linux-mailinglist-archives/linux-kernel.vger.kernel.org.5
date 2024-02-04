Return-Path: <linux-kernel+bounces-51756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57274848EF8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E166B1F220AD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6362261A;
	Sun,  4 Feb 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+dbddqf"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F9225CE;
	Sun,  4 Feb 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061415; cv=none; b=acGXjvMVnQI8n/N+E1jmOcEUJouJm6VsAc1iqvrEEsy1HF7XVxiIMCxYK8kRGGI83bgwNZyEWWL1E3Ao2UdrA5WvI0bD9W4EVueGfgdUxyR7ty+CNfftm2/p1scJDWAV7R7ncMNEvA3r5Fxts38oKPIxNZX3uy8uzXRB1laekfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061415; c=relaxed/simple;
	bh=j8bT92korZPHKU9UJD58DKUuXoIYCuBG26pqbJmYj/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+EntRXWg57nL484s8JnwcXqf/1STmddp1WedsB/gIp2or9grMtJdLQO6HzIVOG5JyvWFM8dJvV6IwP5pF/haHUa4jt9yUhUiLRdgHrLFXRX3xsFMrlhwIjRNcnp7JmlfLaaPZHFhZ2UHf09s2qpL+alqCOgGvWpLYZP214Tps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T+dbddqf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=HPr856mnIn7UchtaSPmbDT13xvs3uix0kLrT0nAz+H8=; b=T+dbddqfIFAZ0ZeL3RVZjQnB4g
	ZNoTgQJSGq/5zCYsWqAPV1YQiYKCGpvkIXjV/SfBiWNVkZjfJP6/5iitKD5J83fwADBOY4voShV8d
	yHBHzQs0TtiDpGA97fs5S7Xq5H0UjOTW36fE05FeFh+EJTIJUT+Bo9DJxbzA0/uKcnaqGC9UQPvUO
	NbCmcoBvaZqUFB2Z+95BkqAZ5Bk9/+UCGq8FkRWbE9Hd3rxMCe3k43rncM1KXuqxY+9HGiUoEC7b8
	Q39I9JMnH86N69gmICJTObM3/JLGwz2wiTgP18PmnR1N9mFCBhkpPg5PvjVzJkLauQLHJ4dZhhbLE
	x8+WXYMA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWeeW-000000014T6-2LMA;
	Sun, 04 Feb 2024 15:43:29 +0000
Message-ID: <fe192b1d-da96-4f58-abe2-c3447adf0676@infradead.org>
Date: Sun, 4 Feb 2024 07:43:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tipc: remove redundant 'bool' from
 CONFIG_TIPC_{MEDIA_UDP,CRYPTO}
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 linux-kernel@vger.kernel.org, tipc-discussion@lists.sourceforge.net
References: <20240204131226.57865-1-masahiroy@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240204131226.57865-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/4/24 05:12, Masahiro Yamada wrote:
> The 'bool' is already specified for these options.
> 
> The second 'bool' under the help message is redundant.
> 
> While I am here, I moved 'default y' above, as it is common to place
> the help text last.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
>  net/tipc/Kconfig | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/net/tipc/Kconfig b/net/tipc/Kconfig
> index be1c4003d67d..bb0d71eb02a6 100644
> --- a/net/tipc/Kconfig
> +++ b/net/tipc/Kconfig
> @@ -32,16 +32,17 @@ config TIPC_MEDIA_UDP
>  	bool "IP/UDP media type support"
>  	depends on TIPC
>  	select NET_UDP_TUNNEL
> +	default y
>  	help
>  	  Saying Y here will enable support for running TIPC over IP/UDP
> -	bool
> -	default y
> +
>  config TIPC_CRYPTO
>  	bool "TIPC encryption support"
>  	depends on TIPC
>  	select CRYPTO
>  	select CRYPTO_AES
>  	select CRYPTO_GCM
> +	default y
>  	help
>  	  Saying Y here will enable support for TIPC encryption.
>  	  All TIPC messages will be encrypted/decrypted by using the currently most
> @@ -49,8 +50,6 @@ config TIPC_CRYPTO
>  	  entering the TIPC stack.
>  	  Key setting from user-space is performed via netlink by a user program
>  	  (e.g. the iproute2 'tipc' tool).
> -	bool
> -	default y
>  
>  config TIPC_DIAG
>  	tristate "TIPC: socket monitoring interface"

-- 
#Randy

