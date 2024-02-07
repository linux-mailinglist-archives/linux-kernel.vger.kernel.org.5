Return-Path: <linux-kernel+bounces-55892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1670384C318
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921AB28353B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8E101C4;
	Wed,  7 Feb 2024 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXGai1ZB"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC85FC0A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276536; cv=none; b=LBaBS4YObOteDHXfeVrpx6QfmY2bHgS11VfI/MrG9KI1gBNDKlkhFwEIhYd7/5ZswQM1HziMaK8ABiEqkrPjD5y9m/2v+E1mmemaqNlqctcwXVRA4RQne+kOdVAyD9hKT8rEq+mZtzwObmHjssgoaXVtxUwrQGbYaB3Rfr6xuk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276536; c=relaxed/simple;
	bh=Uk/kJBDdGJkB4hVPr/njPGatsIIDBSmAiw3p5h4VEiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CNbNmb551l/yo3tYNlYSxvpk62qSKzoVhI4EF6rS82RdehvtzJklKZxkNA7Ycty0pPzFPcro4ZlmPe8rSdR6do/dD1jMWwhpJzkWHDlOBpgPNtIWtHD8GIeJNxInOKYL85+9D+dLGjtR+P/1y/6Snh6mxuMVNKHUzvenTHPwvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXGai1ZB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso262762276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 19:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707276534; x=1707881334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cyw1f/YCIrgyWV8QmoyDjzgKLS5MFEQ8Je3Xn9KP80Q=;
        b=XXGai1ZBOpkaJre0j0iTcM45lYX4H+ItD/nOZgGfjWK72Uifi64sIjd6DfgwKbhrZN
         w3KQr2FCSczfzOFUnu7y25eJx/3WDWDJZJQiz70DB1CciDoLOULImOTBmBNC4spUygTH
         D1Dq1Q2pLKZv7SgbjZGHhGwhb1nbP4oQjwX8AS4wm0Bj/XLViOyU8qu+FnBLRXP7FiGu
         a4bD1lD74+JKHKliCfXlCKgWTqwPOxDUd1Usx46+8ID0nonKY1pH6xBJtP6hFXb5bRJ8
         mdmQPkYV146L6hKdFkFPf3NHu4hkh4c644obYc77OOE/FV+OFnF0Drd/G2/VQwl8Gzvx
         exxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707276534; x=1707881334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cyw1f/YCIrgyWV8QmoyDjzgKLS5MFEQ8Je3Xn9KP80Q=;
        b=Z6/O7Ov6oUyUjywwT+ZsRaxOBySJ5llIc3auC0jIL4Yop3rWnzfnbwZHofkinsm7ZW
         jUbC7SYRA1opAu8RW+1bjgURxMpwLJr/4G1/ktMYH6/QHLOzJtuyA8Ta5P1519lD1zww
         ozHKAHh2G5r1kRWcXGnLFGKhUPCVUXa9Bbd+7zGyoo/JxZZqmHw35OJvZ0amjSl0hH06
         HLZkN7k3SIndhl6Ps+AUT12W6q67zQi6UoUETAf6FKFKKw0D5/wgREDujBFp6mgrrlOe
         obIlBJmUkCectfTD1RHS/TAjjc8YE77L7YZvTwCJT4PyDS8MnRUrEGPdBv/PcXXNbiFk
         W23Q==
X-Gm-Message-State: AOJu0Ywmn6z02azWDW2t6cxYKj2dLKSrj14emPYCi/fttizou5vGa4EL
	vaQf4oZS+bbRdV4FuKpjfvYmydnZx6Lk6SyzivrWq8tnACAV4lfz7yyQkL1a+an5T2nGTK1SwyG
	+SDOCReXYdykCnSIoJA==
X-Google-Smtp-Source: AGHT+IEHkYD1LR+yO6r3NkqTM3Vgwkf3EQ+SVotOa1AJY/hml3kRuyTUAr+YK/qyoFNh3tQJeMV2CFRbosFErOkA
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1b84:b0:dc2:3268:e9e7 with
 SMTP id ei4-20020a0569021b8400b00dc23268e9e7mr148078ybb.10.1707276534388;
 Tue, 06 Feb 2024 19:28:54 -0800 (PST)
Date: Wed, 7 Feb 2024 03:28:52 +0000
In-Reply-To: <20240207025827.3819141-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207025827.3819141-1-chengming.zhou@linux.dev>
Message-ID: <ZcL49JRbCLElAF6H@google.com>
Subject: Re: [PATCH v2] mm/zswap: invalidate old entry when store fail or !zswap_enabled
From: Yosry Ahmed <yosryahmed@google.com>
To: chengming.zhou@linux.dev
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024 at 02:58:27AM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We may encounter duplicate entry in the zswap_store():
> 
> 1. swap slot that freed to per-cpu swap cache, doesn't invalidate
>    the zswap entry, then got reused. This has been fixed.
> 
> 2. !exclusive load mode, swapin folio will leave its zswap entry
>    on the tree, then swapout again. This has been removed.
> 
> 3. one folio can be dirtied again after zswap_store(), so need to
>    zswap_store() again. This should be handled correctly.
> 
> So we must invalidate the old duplicate entry before insert the
> new one, which actually doesn't have to be done at the beginning
> of zswap_store(). And this is a normal situation, we shouldn't
> WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
> to detect swap entry UAF problem? But not very necessary here.)
> 
> The good point is that we don't need to lock tree twice in the
> store success path.
> 
> Note we still need to invalidate the old duplicate entry in the
> store failure path, otherwise the new data in swapfile could be
> overwrite by the old data in zswap pool when lru writeback.
> 
> We have to do this even when !zswap_enabled since zswap can be
> disabled anytime. If the folio store success before, then got
> dirtied again but zswap disabled, we won't invalidate the old
> duplicate entry in the zswap_store(). So later lru writeback
> may overwrite the new data in swapfile.
> 
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> Cc: <stable@vger.kernel.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

LGTM with a few grammatical fixes below:

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> @@ -1608,14 +1598,12 @@ bool zswap_store(struct folio *folio)
>  	/* map */
>  	spin_lock(&tree->lock);
>  	/*
> -	 * A duplicate entry should have been removed at the beginning of this
> -	 * function. Since the swap entry should be pinned, if a duplicate is
> -	 * found again here it means that something went wrong in the swap
> -	 * cache.
> +	 * The folio could be dirtied again, invalidate the possible old entry
> +	 * before insert this new entry.

	/*
	 * The folio may have been dirtied again, invalidate the
	 * possibly stale entry before inserting the new entry.
	 */

>  	 */
> -	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> -		WARN_ON(1);
> +	if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
>  		zswap_invalidate_entry(tree, dupentry);
> +		VM_WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
>  	}
>  	if (entry->length) {
>  		INIT_LIST_HEAD(&entry->lru);
> @@ -1638,6 +1626,17 @@ bool zswap_store(struct folio *folio)
>  reject:
>  	if (objcg)
>  		obj_cgroup_put(objcg);
> +check_old:
> +	/*
> +	 * If zswap store fail or zswap disabled, we must invalidate possible
> +	 * old entry which previously stored by this folio. Otherwise, later
> +	 * writeback could overwrite the new data in swapfile.
> +	 */


	/*
	 * If the zswap store fails or zswap is disabled, we must invalidate the
	 * possibly stale entry which was previously stored at this offset.
	 * Otherwise, writeback could overwrite the new data in the swapfile.
	 */

> +	spin_lock(&tree->lock);
> +	entry = zswap_rb_search(&tree->rbroot, offset);
> +	if (entry)
> +		zswap_invalidate_entry(tree, entry);
> +	spin_unlock(&tree->lock);
>  	return false;
>  
>  shrink:
> -- 
> 2.40.1
> 

