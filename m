Return-Path: <linux-kernel+bounces-48764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66F78460EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E25A1C22FD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924585278;
	Thu,  1 Feb 2024 19:28:14 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EE84FC8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815694; cv=none; b=MmTDXYXzDqrSxhHpR7VWah+hI7yk9kmGgbruNGFlvqEpahdcDqCjXp2/5dRGxzwfRfsOLDnN7ZL969ZXu0RuciFKf4NfhAazDyGX3Cd2QrnEq9sUiGYEVMFo7yjs6psNCBBoVrramGN5ZEIf8cDIhbodqclPtQoXLi2ya46EuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815694; c=relaxed/simple;
	bh=XyogCzSlUl5xWF3HeYQu023Da3FPDuU0wOYxruYx9JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5E4Aq7mGemprqgKLIblFC639QBnvgw2AwMdtfIrnHGesCJrqoxxmPF2V4W/8y4lQGsTk36VmFysqWpG71Kn+csZO9Gs+baO6i8N2tXZCSAO5fJ/II+7SbOYN2q/mNAuxP8pCPH+oZDq2GmU0+ynLtoOdFAlS02TOLWBtNGaj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5957ede4deaso855433eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815692; x=1707420492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyogCzSlUl5xWF3HeYQu023Da3FPDuU0wOYxruYx9JI=;
        b=xII920KiadE5OSesi+yrinn2dMvkQhh2LbfTuGi9I6YYkb4MAV+VjauFK+gUtKVxFz
         chJtKawYKQPd0BVxaPv1iTO7yeECRDAE7AAAqc/e05MCgpdn9Ls6oK8hppKLKgskWexr
         dQYuTCKcffC6vMxMF00r984/jWS2IJLMA+GgBLDFIrgrfO7thaaI/mS+rqKoeYDeSDAK
         zRNT4wAT0yK9FeYxZSPy8i5wg9bvXxE7YyYi+uEl3bq0Vi4CCKZKikUcx+eRXv8f4oM2
         oyKpkhmG7M1EFdlF5QPGqRvehCLpRN274vJx6Mx3kLLm+WCmU/1rCshD9rg5TKWoD4Me
         t5vg==
X-Gm-Message-State: AOJu0YwZ2mkulGJ03iDnaHMShB/tQW5Rvb/LemAcy0fdoDVgfHceWOJ2
	p8SxfJ3e69Zo4QiT9A7Yn8LNpoq5tHq+9RFECMp3LCqPX+pLk5Yz
X-Google-Smtp-Source: AGHT+IGnF7ExLK9KlyRQPCtHHdH0VOOkNCQRGtK/V6UOpJVCgVrIeGE+O29tH7fyDBPDiacg7NJsQQ==
X-Received: by 2002:a05:6358:7205:b0:176:2852:3ac1 with SMTP id h5-20020a056358720500b0017628523ac1mr6290692rwa.28.1706815691702;
        Thu, 01 Feb 2024 11:28:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIW0ne5a43yHh3XzblCPT6hgJJN4gi/j9NGFnUiBzxLyRIaOo1gXFiER8C7JtsG50ljLPHKvh7pD/pLbW0Q72HUVjDnW+Nx1IQXoaKuAFDJQikacdNYosKvTqJrt+5FkOPQyffzhizU1wEk/Zzv/KSR2NpkVRkpuKwG5ee+V+FejuHabRaJ7+ycVc9GNN++S8FcpypCvskShAFgMU7auxGOerWHfF9pWQGgmKJUjPEAlMdTwBJ243D18Fc5VsolWsGSezeLxsEhMw3Azt9F6rwmw2L0nj2CFMXgym3sAFMWFsAmnxo6dbkwUKEZF6PArKQe1fM9XdgAN1e7XLGEZM8uwjj5Q==
Received: from ?IPV6:2620:0:1000:8411:170e:a1a5:1887:adb2? ([2620:0:1000:8411:170e:a1a5:1887:adb2])
        by smtp.gmail.com with ESMTPSA id q11-20020a63e94b000000b005d6a0b2efb3sm200016pgj.21.2024.02.01.11.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:28:10 -0800 (PST)
Message-ID: <cc828212-9a90-430e-8719-e6b19bdab600@acm.org>
Date: Thu, 1 Feb 2024 11:28:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 xuewen.yan@unisoc.com, Carlos Llamas <cmllamas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/24 23:48, Zhiguo Niu wrote:
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
> -001|queued_spin_lock()
> -001|lockdep_lock()
> -001|graph_lock() // try to hold graph lock
> -002|lookup_chain_cache_add()
> -002|validate_chain()
> -003|lock_acquire
> -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
> -005|lock_timer_base(inline)
> -006|mod_timer(inline)
> -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
> -007|__call_rcu_common(inline)
> -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
> -008|call_rcu_hurry(inline)
> -008|rcu_sync_call(inline)
> -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
> -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
> -010|nocb_cb_wait(inline)
> -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
> -011|kthread(_create = 0xFFFFFF8080363740)
> -012|ret_from_fork(asm)

The above call trace shows a graph_lock() call from inside lock_timer_base().
How can that happen? In lock_timer_base() I see a raw_spin_lock_irqsave() call.
Did I perhaps overlook something?

Thanks,

Bart.


