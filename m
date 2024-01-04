Return-Path: <linux-kernel+bounces-16743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCB982432E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83F328746C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062D7224D6;
	Thu,  4 Jan 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DLsV7sLW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D2224CF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d76923ec4so4756365e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1704376673; x=1704981473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T4wmb4F7h9mu12XcfWrx+6kUqvGBAF7BSgy37ShfsWc=;
        b=DLsV7sLWzBWIhaUqhQ5wRPbwJzAuBBE5CxnxPUG9fFjS+OsirhmgGVn7djWwyqwpzr
         TdEjOEIZQcXJbt4Xx153bFZrF2aWFBlTFmrRHBl/Sh70jylIcbGgz4CSdiBPZVpEJuoa
         k7Wf1CnO4TTJYjeJRM1C9sdjGYD5buvFV43jFI42e0tyZ7z4x+KKgmUSZg3Frt4NJPKb
         NluNluJlL6Djyf5BNvagTiw8IBZWOXbc7XcM0teXsRb+Ljh7EolDQZ/KFdewVWXBv0HU
         /aa8uozvN3m7e3BFhV/Gb0ZW92cU9gW/159FBT/yvU5Ermh2RGA53+0Txqcx9sc2xvka
         Cfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376673; x=1704981473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4wmb4F7h9mu12XcfWrx+6kUqvGBAF7BSgy37ShfsWc=;
        b=XRwWS1KxjCvB+rz0/LTtQOZn1EzO3/dCMY341KOyHAF3SNCl/zcaaqQIXdtIeRj/OL
         ROd27t/KGKbA3p7YSkce27j9NNGU7kl+/SdKGkryq/3niZA6c1sDo0aryvysajYhPR9b
         g1FhwXsnNbe+czQ+kqpnBgdGtpg6iwV3VCjmoU4wpZsnY1SOKkoOEGrlqD6JP8AIB1HU
         If6P5ehPz/JP+YAPE3TlUp+v7SE5I3unVsbMvOA5reNeOIKuyQWFLo8muXwmTUUGePEP
         VKhNL2owLTBmfNwQlc/4vGN6gxLn3Np8NYCfnaV2Qxb51FQiah2Fz4AZUMeSkaI01lH1
         fj+w==
X-Gm-Message-State: AOJu0YygQhJ8DxXTOugbLm9eYf9IQp9VpnKr/TucZ5pUIje4F5u19yFF
	DCZjH6NXTCAl5utacv4/6dgzqC+hqe/W
X-Google-Smtp-Source: AGHT+IE2jvjkFkwuxql63GSmfDhZZY+qtTSoXWZl+aj/Rq7+NLSjxi+dXKAH5hHdPPEdlP4pmkY6eQ==
X-Received: by 2002:a05:600c:1c0d:b0:40d:7f71:3f4f with SMTP id j13-20020a05600c1c0d00b0040d7f713f4fmr403356wms.176.1704376672868;
        Thu, 04 Jan 2024 05:57:52 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040d8cd116e4sm5836429wmq.37.2024.01.04.05.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 05:57:52 -0800 (PST)
Message-ID: <d3de02c2-5158-4cae-b6f7-02d0fe7dae35@arista.com>
Date: Thu, 4 Jan 2024 13:57:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tcp: Only produce AO/MD5 logs if there are any keys
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Christian Kujau <lists@nerdbynature.de>,
 Salam Noureddine <noureddine@arista.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/24 13:42, Dmitry Safonov wrote:
> User won't care about inproper hash options in the TCP header if they
> don't use neither TCP-AO nor TCP-MD5. Yet, those logs can add up in
> syslog, while not being a real concern to the host admin:
>> kernel: TCP: TCP segment has incorrect auth options set for XX.20.239.12.54681->XX.XX.90.103.80 [S]
> 
> Keep silent and avoid logging when there aren't any keys in the system.
> 
> Side-note: I also defined static_branch_tcp_*() helpers to avoid more
> ifdeffery, going to remove more ifdeffery further with their help.
> 
> Reported-by: Christian Kujau <lists@nerdbynature.de>
> Closes: https://lore.kernel.org/all/f6b59324-1417-566f-a976-ff2402718a8d@nerdbynature.de/

Probably, it also can have

Fixes: 2717b5adea9e ("net/tcp: Add tcp_hash_fail() ratelimited logs")

> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/net/tcp.h    |  2 --
>  include/net/tcp_ao.h | 26 +++++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 144ba48bb07b..87f0e6c2e1f2 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1788,8 +1788,6 @@ struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
>  					 const struct sock *addr_sk);
>  
>  #ifdef CONFIG_TCP_MD5SIG
> -#include <linux/jump_label.h>
> -extern struct static_key_false_deferred tcp_md5_needed;
>  struct tcp_md5sig_key *__tcp_md5_do_lookup(const struct sock *sk, int l3index,
>  					   const union tcp_md5_addr *addr,
>  					   int family, bool any_l3index);
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 647781080613..b04afced4cc9 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -127,12 +127,35 @@ struct tcp_ao_info {
>  	struct rcu_head		rcu;
>  };
>  
> +#ifdef CONFIG_TCP_MD5SIG
> +#include <linux/jump_label.h>
> +extern struct static_key_false_deferred tcp_md5_needed;
> +#define static_branch_tcp_md5()	static_branch_unlikely(&tcp_md5_needed.key)
> +#else
> +#define static_branch_tcp_md5()	false
> +#endif
> +#ifdef CONFIG_TCP_AO
> +/* TCP-AO structures and functions */
> +#include <linux/jump_label.h>
> +extern struct static_key_false_deferred tcp_ao_needed;
> +#define static_branch_tcp_ao()	static_branch_unlikely(&tcp_ao_needed.key)
> +#else
> +#define static_branch_tcp_ao()	false
> +#endif
> +
> +static inline bool tcp_hash_should_produce_warnings(void)
> +{
> +	return static_branch_tcp_md5() || static_branch_tcp_ao();
> +}
> +
>  #define tcp_hash_fail(msg, family, skb, fmt, ...)			\
>  do {									\
>  	const struct tcphdr *th = tcp_hdr(skb);				\
>  	char hdr_flags[6];						\
>  	char *f = hdr_flags;						\
>  									\
> +	if (!tcp_hash_should_produce_warnings())			\
> +		break;							\
>  	if (th->fin)							\
>  		*f++ = 'F';						\
>  	if (th->syn)							\
> @@ -159,9 +182,6 @@ do {									\
>  
>  #ifdef CONFIG_TCP_AO
>  /* TCP-AO structures and functions */
> -#include <linux/jump_label.h>
> -extern struct static_key_false_deferred tcp_ao_needed;
> -
>  struct tcp4_ao_context {
>  	__be32		saddr;
>  	__be32		daddr;
> 
> ---
> base-commit: ac865f00af293d081356bec56eea90815094a60e
> change-id: 20240104-tcp_hash_fail-logs-daa1a4dde694
> 
> Best regards,

-- 
Dmitry


