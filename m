Return-Path: <linux-kernel+bounces-12304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7666181F2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356E91F220CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0F649F6C;
	Wed, 27 Dec 2023 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCpAdwIh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5198D49F65
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9aa51571fso2561399b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 15:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703718391; x=1704323191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/b/hB6Fa/6OyAyT/V295kvGGkM0E9QPOt8SSGOO8Xg=;
        b=XCpAdwIhgZ+HdBJv+6pOyb/dt6/hPXCN9AXDowkQkDu6DMoc0vvydEc+1YZ1Ig9JpD
         xO6GsMTYh5ob89a+Ibs6/NCGk1wcEoALwBkhR+JJt/4C/AdZc14j5TwW8hNdzS8l96Jy
         N0NxKSzgU2u5duukiuoyoUGFwgMpdPDFmi/WGcenxdGIl1Di+lMP3ysU5rUKDzcyUqxf
         ems/7cpy66qO5UHtG4MoAGD69PeTK66Ke9Tu/fqESQQtTKYXKmifXJZUfSsk+4BIjTJI
         AMdRxlSMKQJR1KqJn1XpPm7ZZBYJRuZvQpJka0iHspkTMWoa1d1JuUJJVyJsF7KdoXFu
         qwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703718391; x=1704323191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/b/hB6Fa/6OyAyT/V295kvGGkM0E9QPOt8SSGOO8Xg=;
        b=U71oa2NgJC7OA4EW7hg8lPcWKL8MJOZV0MzWT6Io3QCeAjCyfcErc+qtYl/VdwKeO9
         KCrzBfeyrIjx37bBiF5uENacS+q2Ch4AZJjglU53WagBSQ6h80rHE8Ik4DSwtLebzBii
         XFHnsU2y2i2x8YUyVP2K1nQeDItdz2JuLe6yooNYJoPd33fBmqXUjuLir1k9WtUNDPT1
         k0q0xzh5E1zpoQ5iWb4BvkOEMqICJNhPRRqiZGHFKE1T0X/uOANqVcNeDCPSzEQ0Blvp
         +RamrL6sHKJ9enPtgCZ1pCk4MmKttp1tO9szVvuDrHBB7IkKKvcbf8m6sl1VvVghi3Cr
         Bifg==
X-Gm-Message-State: AOJu0YxwqZ+tUG3+stotawD2Hi5Wi2luyvXJAb4HE9yXoe2xFFTCxM0f
	3r2RfmhiMoE3pGbnICBuRN8=
X-Google-Smtp-Source: AGHT+IGGH98x+UnUacoxoPpZxxUPlGjNMMD1D9hMRpmTtkpbQKXMLpUwdKxw1OIO3OS8Mjy59l4qgg==
X-Received: by 2002:a05:6a20:2904:b0:196:12ff:f330 with SMTP id t4-20020a056a20290400b0019612fff330mr1725427pzf.7.1703718391487;
        Wed, 27 Dec 2023 15:06:31 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id x9-20020a63db49000000b005ccf10e73b8sm11758282pgi.91.2023.12.27.15.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 15:06:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Dec 2023 08:06:27 +0900
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: [PATCH 6/7] workqueue: Implement system-wide max_active
 enforcement for unbound workqueues
Message-ID: <ZYyt821TugsgVx76@mtj.duckdns.org>
References: <20231227145143.2399-1-jiangshanlai@gmail.com>
 <20231227145143.2399-7-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227145143.2399-7-jiangshanlai@gmail.com>

Hello, Lai.

On Wed, Dec 27, 2023 at 10:51:42PM +0800, Lai Jiangshan wrote:
>  static int pwq_calculate_max_active(struct pool_workqueue *pwq)
>  {
> +	int pwq_nr_online_cpus;
> +	int max_active;
> +
>  	/*
>  	 * During [un]freezing, the caller is responsible for ensuring
>  	 * that pwq_adjust_max_active() is called at least once after
> @@ -4152,7 +4158,18 @@ static int pwq_calculate_max_active(struct pool_workqueue *pwq)
>  	if ((pwq->wq->flags & WQ_FREEZABLE) && workqueue_freezing)
>  		return 0;
>  
> -	return pwq->wq->saved_max_active;
> +	if (!(pwq->wq->flags & WQ_UNBOUND))
> +		return pwq->wq->saved_max_active;
> +
> +	pwq_nr_online_cpus = cpumask_weight_and(pwq->pool->attrs->__pod_cpumask, cpu_online_mask);
> +	max_active = DIV_ROUND_UP(pwq->wq->saved_max_active * pwq_nr_online_cpus, num_online_cpus());

So, the problem with this approach is that we can end up segmenting
max_active to too many too small pieces. Imagine a system with an AMD EPYC
9754 - 256 threads spread across 16 L3 caches. Let's say there's a workqueue
used for IO (e.g. encryption) with the default CACHE affinity_scope ans
max_active of 2 * nr_cpus, which isn't uncommon for this type of workqueues.

The above code would limit each L3 domain to 32 concurent work items. Let's
say a thread which is pinned to a CPU is issuing a lot of concurrent writes
with the expectation of being able to saturate all the CPUs. It won't be
able to even get close. The expected behavior is saturating all 256 CPUs on
the system. The resulting behavior would be saturating an eight of them.

The crux of the problem is that the desired worker pool domain and
max_active enforcement domain don't match. We want to be fine grained with
the former but pretty close to the whole system for the latter.

Thanks.

-- 
tejun

