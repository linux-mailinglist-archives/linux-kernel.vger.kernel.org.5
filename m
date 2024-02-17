Return-Path: <linux-kernel+bounces-69520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC4A858A80
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88DAB24A32
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7493F3D71;
	Sat, 17 Feb 2024 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="kkbger9l"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6819802
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128290; cv=none; b=jaONmkYf+RWAJmfK3xdbh+x1Y0OzR5QmjTtysG0ljzgbkBrxKgAvUtSS8qWDLrAxWfU5ZcF+SiLxUNYckJUvslaffcK+dsDBKX0P/dKoQmq8oW3JU0o8DxgwxjtvdVG2wAA1AcK2qZ/M9Kdc+VM5uAP6MYC0c/vpaCGEP/XI2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128290; c=relaxed/simple;
	bh=3nKxXv+a13aom4LTOZ3NnsV2RrerkFayOaft5ppMDkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdDTlDgpPrHaDQUXTpOC65ya4Ay536lImPrNY6W7kAkqZP8hvxD4C5BS9xZxL/WYRalOlMY9s9i6dudgLjM8NoGH9aMJDN7Q+iVd+MQeQZ9a0d7pk9/0XV63BgRA61z6MUf3Q9isNqx+pDvsUJrlEBlEVS/fbYXJBerxMcGuRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=kkbger9l; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id b7YGr4e3eTHHub8CArZrPo; Sat, 17 Feb 2024 00:04:42 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id b8C8rVHzIgqgEb8C9rFacO; Sat, 17 Feb 2024 00:04:41 +0000
X-Authority-Analysis: v=2.4 cv=bYHIU/PB c=1 sm=1 tr=0 ts=65cff819
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=A7XncKjpAAAA:8 a=pGLkceISAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=S3e1UlYFMFTUAia5eQoA:9
 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
 a=R9rPLQDAdC6-Ub70kJmZ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ljkmbjR1wZVH0YMxK1quNarSuTzJMheeVQqhKZsr5SM=; b=kkbger9lKaj723jXWSInOx6/G1
	E347snhH6PKIcvwa+H9yyCmJJg7R2tWkSxbUzcXyNN/j5tpWsy1YzhPTyJhgTwFkjwR0Co5vH0YH4
	yPKOUK+A1WEA8e+i2tBGYn4DS/fjcjnZATu0H3KhZY/9Wq3VXlEPu8/6lgpXTEC7Jb6b1ldoLl2IQ
	FUIuaQ0WBVrFBtagt2SljBfVkeYWYIrTlY6Srdd0TdPW5vDUukrw8nrpCidSpaxF3bRspvbLiNpPq
	ls6fdqgqkISKEnXZZh3hcZxxJtpJ38UF8oNSOdfxScOuwuTUnsYuMNJ6AriiEFB1qgcXYD4ES6hF0
	w6einTVA==;
Received: from [201.172.172.225] (port=49674 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rb8C7-002dlw-0R;
	Fri, 16 Feb 2024 18:04:39 -0600
Message-ID: <9ed28341-8bf7-4b6a-ba9a-6cfe07dc5964@embeddedor.com>
Date: Fri, 16 Feb 2024 18:04:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: Annotate struct tc_pedit with __counted_by
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240216232744.work.514-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240216232744.work.514-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rb8C7-002dlw-0R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:49674
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCVq46oP8SNec+SF81E9o/+RmDiZKVQqrZj9ZI8o6SwsrS1HJLmcsAKDpc50L4L6ZV7xGXDC9DfKA/YNnM/Zz6nqwsApOd+s9yugA0X/RA4WEY7nqkyo
 qILELFkHigfN/xhDRP6d6VVcd59hE4aaUF0oOfOtSwa3VlhwXyLzPtzeSYFw239WUY8GEaAcm/TJH7BuhhOyAfEFAOt9ysL7wex+f966ZKAvTzGY5KcZmivp



On 2/16/24 17:27, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct tc_pedit.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org

`opt->nkeys` updated before `memcpy()`, looks good to me:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   include/uapi/linux/tc_act/tc_pedit.h | 2 +-
>   net/sched/act_pedit.c                | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/tc_act/tc_pedit.h b/include/uapi/linux/tc_act/tc_pedit.h
> index f3e61b04fa01..f5cab7fc96ab 100644
> --- a/include/uapi/linux/tc_act/tc_pedit.h
> +++ b/include/uapi/linux/tc_act/tc_pedit.h
> @@ -62,7 +62,7 @@ struct tc_pedit_sel {
>   	tc_gen;
>   	unsigned char           nkeys;
>   	unsigned char           flags;
> -	struct tc_pedit_key     keys[0];
> +	struct tc_pedit_key     keys[] __counted_by(nkeys);
>   };
>   
>   #define tc_pedit tc_pedit_sel
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index 2ef22969f274..21e863d2898c 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -515,11 +515,11 @@ static int tcf_pedit_dump(struct sk_buff *skb, struct tc_action *a,
>   		spin_unlock_bh(&p->tcf_lock);
>   		return -ENOBUFS;
>   	}
> +	opt->nkeys = parms->tcfp_nkeys;
>   
>   	memcpy(opt->keys, parms->tcfp_keys,
>   	       flex_array_size(opt, keys, parms->tcfp_nkeys));
>   	opt->index = p->tcf_index;
> -	opt->nkeys = parms->tcfp_nkeys;
>   	opt->flags = parms->tcfp_flags;
>   	opt->action = p->tcf_action;
>   	opt->refcnt = refcount_read(&p->tcf_refcnt) - ref;

