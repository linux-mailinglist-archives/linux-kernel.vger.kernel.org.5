Return-Path: <linux-kernel+bounces-99305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A4287864A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6621F22D34
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B84AEFA;
	Mon, 11 Mar 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="lds/otU+"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C93482E6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177934; cv=none; b=QgHwphiW8off9FwyUoCAS2dqEyzEKzRmJxj+eGdmZwKPuwKXT3edOeSMjs6nxYt+oyeO9ukv8wBiDs/t7YpWyqnZEftWtQw/mz0iahcW3ukPFMiVguSCWL3cAzdfuzGS5j8x44MnDfnBggzL01v/WMHTMwf+5saDSxObZde14Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177934; c=relaxed/simple;
	bh=bPfBXYWm4uHn8XRxs6rHsxZ49Lw9zBDExcS5g7o3cLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQzmVNBigH1a3mAqMI4f+VRT8uIpNL9iZqlU8fxun/HYcQpzfb9vWceW+Ah+1/Gp7pAsm7Q1EvMlRJxa9V+gMlcK9O2pIYd6tgQTb4FbefAQuRFy+1su9xc9Ybde13nkNaFkNqsnd5+REBsSTLgn3XinWISidSNwosJ5ZmARJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=lds/otU+; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 83493191683;
	Mon, 11 Mar 2024 18:25:21 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1710177921; bh=HImKdhNrLAqqIR1aE4nSMlVB95mNXKBYon/NxsXM9YU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lds/otU+4KqBDUdYbVIZrlv5fqKlMMUCM0RrEXLwB0E/18QmxhoDY/Mto4omfeh/I
	 lIyPst7yaYI5psfyJSbnAmCF84ybzPNtyfxb36R3bXKBaMnjLfwvZoEgOzDsbY1s0V
	 baJIutUP4q5Khu/kDZFxRJEwnZSzx6hQqSZgnRX8kzTichdisB1JWvF73b7Wpx6kvk
	 xcy5Oa1F8I4u9rd0lrRidic/CrgniviB/fZN3cphtUCXPEAbAxJTF+NXfYnRq2FITu
	 OdYgc+BpA/zfxhVOl0kv/cag9uv8aZZ5MVWjahNxoxIK1dh7TS875m2hWS0GEbuUu1
	 piik/9/Dd+1NA==
Date: Mon, 11 Mar 2024 18:25:16 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Linux regressions mailing list
 <regressions@lists.linux.dev>, linux-kernel@vger.kernel.org (open list)
Cc: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, stable@kernel.org
Subject: Re: [PATCH 1/1] u64_stats: fix u64_stats_init() for lockdep when
 used repeatedly in one file
Message-ID: <20240311182516.1e2eebd8@meshulam.tesarici.cz>
In-Reply-To: <20240306111157.29327-1-petr@tesarici.cz>
References: <20240306111157.29327-1-petr@tesarici.cz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 12:11:57 +0100
Petr Tesarik <petr@tesarici.cz> wrote:

> Fix bogus lockdep warnings if multiple u64_stats_sync variables are
> initialized in the same file.
> 
> With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:
> 
> 	static struct lock_class_key __key;
> 
> Since u64_stats_init() is a function (albeit an inline one), all calls
> within the same file end up using the same instance, effectively treating
> them all as a single lock-class.

What happens with this fix now?

IIUC it should be reviewed by Eric, but I don't know through which tree
it should be merged. Any plans yet?

Petr T

> Cc: stable@kernel.org
> Fixes: 9464ca650008 ("net: make u64_stats_init() a function")
> Closes: https://lore.kernel.org/netdev/ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net/
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>
> ---
>  include/linux/u64_stats_sync.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
> index ffe48e69b3f3..457879938fc1 100644
> --- a/include/linux/u64_stats_sync.h
> +++ b/include/linux/u64_stats_sync.h
> @@ -135,10 +135,11 @@ static inline void u64_stats_inc(u64_stats_t *p)
>  	p->v++;
>  }
>  
> -static inline void u64_stats_init(struct u64_stats_sync *syncp)
> -{
> -	seqcount_init(&syncp->seq);
> -}
> +#define u64_stats_init(syncp)				\
> +	do {						\
> +		struct u64_stats_sync *__s = (syncp);	\
> +		seqcount_init(&__s->seq);		\
> +	} while (0)
>  
>  static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp)
>  {


