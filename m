Return-Path: <linux-kernel+bounces-85019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFD86AF34
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD691C21542
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420DC145FEC;
	Wed, 28 Feb 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="buvie6fj"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75E14534F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123450; cv=none; b=eEJg/hRRhuwAac7WN41UlDeZ/JIMm2b3qR68xBy9DKM873YWvcYN9/y9ybNZkm4yBYZin7bpzRpdCNK9WekTGYwmjez7A7vRFsqHTvzVIMMx9JPm+nUV7FUACaZHstPuLeFP1ZcubV+XQ+cACN1zShevSLR4i4/JHlF02AFC9uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123450; c=relaxed/simple;
	bh=rbrZB1MbCrdJEdglecBkUsgBKbk/Lf5UqKWRiSqTaHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNTAH1M4JnYjt5uB6R7SOCIZmfZbICIoMWRCUZamZSjpltamg7ksXVZKMhGKQPgvR89x3iAsGuhLYH613qHGQc9Tkd5TIRZagNWHuxY+LeNcmMOd36PA6MdcT4GvGRoIXEBznR4tVXqMo8EM5N9ikfnucO4SyBwVWifD5//GNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=buvie6fj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412b7baa9c5so394915e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709123447; x=1709728247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4koArAzLvRhp1wNjjda/nlU8knqR88gHiEfAPiHyOY=;
        b=buvie6fj0m4OgeX0tHX8IQ7/mMEc3DqoFJiqRlctRHbQrZgGtOvZGy1/5viKUmiZO3
         KZkfYI8sJcdE4lhnmuEHFlDrkK7Umgts+gpAImv2gkSMRWWIPoPDpAunFyo966dgv0H7
         Cxas7BFtfsKlxj8kTMT5m8P9Hm1o80xmsi+4Z9fs2L8zMUYOtYOKstQ+Y2kj9QTx//tp
         2V2PyhDYOuR9OU05ZJxtXLqO8LgVmkAHvqoA09DApzEsG5lHbSrd8Kb8V7o2pSThNPJA
         A3/3rQCS+sn6vjojHy+MGuSeIKBDBJDbKb/pevNGNERrq2cocFyRBWWdl2kJC9RjQSi8
         Z0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123447; x=1709728247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4koArAzLvRhp1wNjjda/nlU8knqR88gHiEfAPiHyOY=;
        b=vpANxjdElwWrCanE+KQMYjCTPmRM3aLyFcSW+l6nftTD+L8qXTasulm29kNA7fShEf
         UhDwvIj68sIEgVqRMKZUSsUw1nsU6A75GPray3wRsEpb1OfZ/+aE9WiUBF47gAhDRJKK
         cBB9En1IganH+2WVgUoOcgTtwHN++UGhc7I69UyA358WCZsp/Ho7CUHvA+nBXqguS4hO
         WxN4bWz9ZPkQwhWD9ie4U8IpLt3dpDgnUqozefL/9Rle4/dhwY7DqRQ5lZJFc6O9yhEF
         kuyMCRvCmntWf85G9NYmpWq2hM5QZ/+LVhOh4DMgqKyh/NgBopdlxdpHaN5KJKOtAGjB
         dIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6XjdgTr62sUq+XQWPltkN9yZJNZ/fGbfEK0YgOYyrFBPA2EKjV/YUCzAJzZPzDbTq91zTOojk3mpT4sJK8YRNl5WgQBKOSpiQDIiL
X-Gm-Message-State: AOJu0YxdJq1fI/argBL94UKYJIvmsrq0y7XeRKIPPkO2uysKKEtPd5OR
	eNbT5MJNFTPaT6Mm+0MHasU9DbmB0ZI5rba4NTzA990NLiHb+Eb/nFOXro8cmKk=
X-Google-Smtp-Source: AGHT+IGnLrE4m+ahq/TbdLTjtrEFYyvRyshiJ8ta0m0zukA/VYU5g+QqAuwBq+l7IwoNfsm8rqKH4w==
X-Received: by 2002:a05:600c:4e86:b0:412:a21b:5bf8 with SMTP id f6-20020a05600c4e8600b00412a21b5bf8mr6635147wmq.3.1709123446668;
        Wed, 28 Feb 2024 04:30:46 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z21-20020a05600c0a1500b0040fd1629443sm2041092wmp.18.2024.02.28.04.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:30:45 -0800 (PST)
Date: Wed, 28 Feb 2024 13:30:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Shiming Cheng =?utf-8?B?KOaIkOivl+aYjik=?= <Shiming.Cheng@mediatek.com>
Subject: Re: [PATCH net v2] Net:cache didn't flush when ipv6 rule changed
Message-ID: <Zd8nctDzf1sgO3lX@nanopsycho>
References: <3efcbaf0872481d1a842eb9e18fa368b4b94d940.camel@mediatek.com>
 <696e39599c7a5e793a9d96aceef0e34817ab0bb2.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <696e39599c7a5e793a9d96aceef0e34817ab0bb2.camel@mediatek.com>

[PATCH net v2] Net:cache didn't flush when ipv6 rule changed

Please make sure your patch subject is aligned with the rest:
$ git log --no-merges --pretty=format:"%s" net/ipv6/fib6_rules.c | head -n30
fib: remove unnecessary input parameters in fib_default_rule_add
ipv6: change fib6_rules_net_exit() to batch mode
ipv6: Define dscp_t and stop taking ECN bits into account in fib6-rules
fib: rules: remove duplicated nla policies
ipv6: fix memory leak in fib6_rule_suppress
ipv6: fib6: remove redundant initialization of variable err
fib: use indirect call wrappers in the most common fib_rules_ops
ipv6: fib6: avoid indirect calls from fib6_rule_lookup
net: fib_notifier: propagate extack down to the notifier block callback
ipv6: do not free rt if FIB_LOOKUP_NOREF is set on suppress rule
ipv6: honor RT6_LOOKUP_F_DST_NOREF in rule lookup logic
treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 372
ipv6: Use result arg in fib_lookup_arg consistently
ipv6: fib6_rule_action_alt needs to return -EAGAIN
ipv6: Pass fib6_result to fib lookups
net/ipv6: Add fib6_lookup
net/ipv6: Refactor fib6_rule_action
net: fib_rules: add extack support
net: Drop pernet_operations::async
net/ipv6: Pass skb to route lookup
ipv6: route: dissect flow in input path if fib rules need it
ipv6: fib6_rules: support for match on sport, dport and ip proto
net: Convert fib6_rules_net_ops
net: ipv6: avoid overhead when no custom FIB rules are installed
ipv6: fib_rules: Dump rules during registration to FIB chain
ipv6: fib_rules: Check if rule is a default rule
ipv6: Do not leak throw route references
net: flow: Add l3mdev flow update
net: Add l3mdev rule
ipv6: fix the incorrect return value of throw route

Use imperative mood as other subjects do, tell the codebase what do do.



Wed, Feb 28, 2024 at 09:24:55AM CET, Lena.Wang@mediatek.com wrote:
>From bf53859b379a653eec8a14fbb3f29286f9f888fb Mon Sep 17 00:00:00 2001
>From: shiming cheng <shiming.cheng@mediatek.com>

Names start with capital letters.


>Date: Mon, 26 Feb 2024 20:17:58 +0800
>Subject: [PATCH net v2] Net:cache didn't flush when ipv6 rule changed

I don't understand why you put these "headers" here. Only one "from" is
enough in this case (you are submitting the patch in stead of another
person).

If you are not, I suggest to use git-send-email for submissions.


>
>When changed from old rule&route configure to new one as below,

"as below" where?

>ipv6 cache dst_entry did not change to new route table as no
>cache flush callback function, then forward to wrong out interface.

I don't understand this sentence :/


>When fib6_check dst_entry, the fib6_node version[fn_sernm] is
>always the same with socket dst_cookie, old cache dst_entry is
>always used and no chance to update.

Sorry, this is too cryptic for me to understand :/


>
>So we need to update fib6_node version when rule changed and
>flush cache to avoid dispatching a wrong interface.

Be imperative in the patch description too, tell the codebase what do do.

https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes



>
>Signed-off-by: shiming cheng <shiming.cheng@mediatek.com>

Names start with capital letters.

Also, when you submit the patch, your signed-off-by tag should be here
as well.


>---
>v2: 
>    1. Add the fix tag.

And there, there is none...


pw-bot: cr


>    2. Changes according to David Ahern's suggestions, modify flush
>functions same way as ipv4 flush cache and use tabs to aligh with
>existing code.
>---
>---
> net/ipv6/fib6_rules.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
>index 7523c4baef35..52c04f0ac498 100644
>--- a/net/ipv6/fib6_rules.c
>+++ b/net/ipv6/fib6_rules.c
>@@ -449,6 +449,11 @@ static size_t fib6_rule_nlmsg_payload(struct
>fib_rule *rule)
> 	       + nla_total_size(16); /* src */
> }
> 
>+static void fib6_rule_flush_cache(struct fib_rules_ops *ops)
>+{
>+	rt_genid_bump_ipv6(ops->fro_net);
>+}
>+
> static const struct fib_rules_ops __net_initconst
>fib6_rules_ops_template = {
> 	.family			= AF_INET6,
> 	.rule_size		= sizeof(struct fib6_rule),
>@@ -461,6 +466,7 @@ static const struct fib_rules_ops __net_initconst
>fib6_rules_ops_template = {
> 	.compare		= fib6_rule_compare,
> 	.fill			= fib6_rule_fill,
> 	.nlmsg_payload		= fib6_rule_nlmsg_payload,
>+	.flush_cache		= fib6_rule_flush_cache,
> 	.nlgroup		= RTNLGRP_IPV6_RULE,
> 	.owner			= THIS_MODULE,
> 	.fro_net		= &init_net,
>-- 
>2.18.0
>

