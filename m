Return-Path: <linux-kernel+bounces-105415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511E87DD92
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07501F211BA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188031C695;
	Sun, 17 Mar 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="es3n8pFW"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221351C680
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687129; cv=none; b=a4ATaYddFbNK+V1Zd2UlMZwMVPYrmo3r0NQn89/ga4QH6iV1S7VoQhHeIC00l+Qz+uaYMHisyQnkosRZn+sEXX8xeqxC8ndNSVNMvsTjjkc56//iu1F9tqJkF9ws3Iy00sAUdCDW5DFgV4ZhBD2yO4VNGtELr7Q7BKfVJvWCZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687129; c=relaxed/simple;
	bh=f2Icuq/ACq6T+8dZhLB1yQt/9EcVLoebQgqEIqasx8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o1Ijv33vP1EFEoGpmXmALrCqvqq4ccaPB5vEHGdpLsLb1ZL+hSlzrMfVny38LRZV9TrjsmeKoAYOuiIrmUbySaJacYctTutNm5NpOc82D5NKGbF0hcFElGrakGWnbs7ASL6NRNDgYg7MymFmN9bjL0j+oqL/LCD3CuDWxjDBd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=es3n8pFW; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id lrrerSoLHBnpilrrerSLfh; Sun, 17 Mar 2024 15:52:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710687124;
	bh=rmVj1Zo0ysD4EU1EPoLJ4zF5lxo04akNScGS3Kgu0rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=es3n8pFWzUybMMGy6wp5nM9KyX/HUzWICIddF4WGuv313uiXYM1raVUThr+qKOvaS
	 hxLOyDZ5CfSfRYnsd5zDBj88XJlcK6mQ0eBP9HLBS3gtC4wNO+tqnoglw43CsjxmOk
	 OTHv2g0AiHuF0hwWJz6qNtGPfqKk5kRJMw7Z0O9XZnFCHgS2K/COX2FCicG/ft5Ahp
	 TT5JJfuUHI1YVyjGh+tjr2LuRPsuceXlAAD7loIgbZWttDKzKEBu9NiqU5tfdOU5sQ
	 GWWpZ8YvhiiSm148kXzVyiSNezNlFrx3MVsJmfaG1mDhEneWREry5/Ujm5/h7EyMVj
	 9ge5NVWMB9Skg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Mar 2024 15:52:04 +0100
X-ME-IP: 92.140.202.140
Message-ID: <5b98c4a1-26c0-4b69-b000-44ae97eb6edb@wanadoo.fr>
Date: Sun, 17 Mar 2024 15:51:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 08/14] fork: separate vmap stack alloction and free calls
Content-Language: en-MW
To: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de,
 brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
 dave.hansen@linux.intel.com, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 hch@infradead.org, hpa@zytor.com, jacob.jun.pan@linux.intel.com,
 jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com,
 kent.overstreet@linux.dev, kinseyho@google.com,
 kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org,
 mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com,
 mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com,
 peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com,
 rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de,
 urezki@gmail.com, vincent.guittot@linaro.org
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-9-pasha.tatashin@soleen.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240311164638.2015063-9-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/03/2024 à 17:46, Pasha Tatashin a écrit :
> In preparation for the dynamic stacks, separate out the
> __vmalloc_node_range and vfree calls from the vmap based stack
> allocations. The dynamic stacks will use their own variants of these
> functions.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   kernel/fork.c | 53 ++++++++++++++++++++++++++++++---------------------
>   1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3004e6ce6c65..bbae5f705773 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -204,6 +204,29 @@ static bool try_release_thread_stack_to_cache(struct vm_struct *vm_area)
>   	return false;
>   }
>   
> +static inline struct vm_struct *alloc_vmap_stack(int node)
> +{
> +	void *stack;
> +
> +	/*
> +	 * Allocated stacks are cached and later reused by new threads,
> +	 * so memcg accounting is performed manually on assigning/releasing
> +	 * stacks to tasks. Drop __GFP_ACCOUNT.
> +	 */
> +	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
> +				     VMALLOC_START, VMALLOC_END,
> +				     THREADINFO_GFP & ~__GFP_ACCOUNT,
> +				     PAGE_KERNEL,
> +				     0, node, __builtin_return_address(0));
> +
> +	return (stack) ? find_vm_area(stack) : NULL;

Nit: superfluous ()

> +}

..


