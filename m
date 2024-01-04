Return-Path: <linux-kernel+bounces-17180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF728824937
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985BF286330
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072B2CCBC;
	Thu,  4 Jan 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0jFp9pT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA62C6B5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78158569dc6so59294685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704397377; x=1705002177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ipa5davUZdpnLP8xz+lR7PHmqo0QJqwMmEYsOeo03ZY=;
        b=X0jFp9pTYzqq2Dp6U15NExPHFhPAoxsDgi1bhweUilm1raplPMRIMBNDlsmmNXLRrd
         pZDG+eohyEfodM3DjD6a2YBkONvDiH/YCKeJwt2iksi7skQXJlDbGzGyVHdUgIAAUt7/
         XXsVXZbDPgSiAfhiL4Ywnz8lES1qoQ449zpMpY3NwrJZiVYBC2skreolleDvZFMAbUxD
         2laLMcEYWreA4i8eIUuYsTae6xkWGX9MLUpdzGyJAYw1oXTkAZjED0QlZZTsXWSckO5T
         Axrf8nIDNn81pd31U2UMs6Jl4w7ydyF9e1RzhOCCEHPPE8g7KjrbuhC/1yNYb726tMQv
         251w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397377; x=1705002177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ipa5davUZdpnLP8xz+lR7PHmqo0QJqwMmEYsOeo03ZY=;
        b=LgJ5sHaH5ZqCFkHtOEyvim3ucTmp8TwKChdOQAEgFDFm+si5fMBLBo+RrsJ8yef5FA
         9DKXnN+nHp6nILaahCh+0JRfDz3lWakE9nLdilU3Kqo3kVjReri3fWVNrB7JkLB8onia
         7tkfyN8H+CuVvMo6KMGoPFI+tYF9uzD4NxZhiUp50VTknHYShkz+Pck81bGvVxL/wnuS
         1LDwo9SsGYPba51Mqu/Ja2JX4VPId6LAXkP3YuRRpkBQ3XS7gvqY93uj6TGR/ajY0jd6
         voXb0XUFudZ+946ptXORYZgLmPt/koTLCfh0lMp47h72reES91hg/tMVGF7CoEvJDNyt
         oq1A==
X-Gm-Message-State: AOJu0Yw6NKhrFyv4t6DaAJPqPrVJPNuclp0lwlGeb9SdSptB5gr3xEm2
	H0lNVr0SDmL+yu3GpkElxrs=
X-Google-Smtp-Source: AGHT+IGzYxfjZ4YbzuyLkP6i/uhd+nmDIY9y+MM3NZ+RJvz1cXO4lg0BuTZPWGwpLqKJqUqao0clcQ==
X-Received: by 2002:ae9:c00b:0:b0:781:b471:8bc0 with SMTP id u11-20020ae9c00b000000b00781b4718bc0mr1104420qkk.11.1704397377185;
        Thu, 04 Jan 2024 11:42:57 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id qr8-20020a05620a390800b007815fb7018fsm43630qkn.4.2024.01.04.11.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:42:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id 6C45627C0060;
	Thu,  4 Jan 2024 14:42:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Jan 2024 14:42:56 -0500
X-ME-Sender: <xms:PwqXZffhhp9PLMg0zmeYnGozoU52ETWQ3GCzACz932RyXCHVYSOpDA>
    <xme:PwqXZVM8HOUGmxYY8ANPCRpB42JWtWsMKgkrsXYbtNEeCIR5Svi62zSLXxxaAJzqz
    xxUGSOPTXL3ZvQW6Q>
X-ME-Received: <xmr:PwqXZYiZHHlfcQRyTP1DQs_EWXIxKVQ1TMoGolCHb0AQePt3fZp7bZy28Jo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:PwqXZQ_7YAGoh1fYUV1WOMFAES4YMrWDOrfzvOHXIZK-GMoMa_6y8A>
    <xmx:PwqXZbsj8meAfqx78ssibvu4-w5rOL-Mne9kKLjbX_aqBUGQCzs_og>
    <xmx:PwqXZfHUfWnFD7Z9wuD4KxnCNSQDpEb7jwAcIKjtNIR65qxSxzn5Yg>
    <xmx:QAqXZU-BqcxQm9jxAuaKs71rvCO6Ukxa960cOl9BF2hvGgi8asqBrA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 14:42:55 -0500 (EST)
Date: Thu, 4 Jan 2024 11:41:47 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, ke.wang@unisoc.com, zhiguo.niu@unisoc.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock/lockdep: Add missing graph_unlock in validate_chain
Message-ID: <ZZcJ-3MXF4BPqPtL@boqun-archlinux>
References: <20240104054030.14733-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104054030.14733-1-xuewen.yan@unisoc.com>

Hi,

On Thu, Jan 04, 2024 at 01:40:30PM +0800, Xuewen Yan wrote:
> The lookup_chain_cache_add will get graph_lock, but the
> validate_chain do not unlock before return 0.
> 

Thanks for looking into this, a few comment below:

> So add graph_unlock before return 0.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  kernel/locking/lockdep.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3de5936..24995e1ebc62 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3855,8 +3855,11 @@ static int validate_chain(struct task_struct *curr,
>  		 */
>  		int ret = check_deadlock(curr, hlock);
>  
> -		if (!ret)
> +		if (!ret) {
> +			graph_unlock();

Note that when check_deadlock() return 0, there is a
print_deadlock_bug() before the return, so I think it covers the
graph_unlock() (see debug_locks_off_graph_unlock()).

>  			return 0;
> +		}
> +
>  		/*
>  		 * Add dependency only if this lock is not the head
>  		 * of the chain, and if the new lock introduces no more
> @@ -3865,9 +3868,9 @@ static int validate_chain(struct task_struct *curr,
>  		 * serializes nesting locks), see the comments for
>  		 * check_deadlock().
>  		 */
> -		if (!chain_head && ret != 2) {
> -			if (!check_prevs_add(curr, hlock))
> -				return 0;
> +		if (!chain_head && ret != 2 && !check_prevs_add(curr, hlock)) {
> +			graph_unlock();

This part is interesting, usually when an internal function in lockdep
returns 0, it means there is an error (either a deadlock or internal
error), and that means a print_*() would be called, and the graph lock
will be unlocked in that print_*(). However, in check_prevs_add() there
is one condition where it will return 0 without any print_*(), that is:


in check_prev_add():

			/* <prev> is not found in <next>::locks_before */
			return 0;

it's an internal error where <next> is in the <prev>::locks_after list
but <prev> is not in the <next>::locks_before list, which should seldom
happen: it's dead code. If you put a graph_unlock() before that return,
I think it covers all the cases, unless I'm missing something subtle.

Are you hitting a real issue or this is found by code reading?

Regards,
Boqun

> +			return 0;
>  		}
>  
>  		graph_unlock();
> -- 
> 2.25.1
> 

