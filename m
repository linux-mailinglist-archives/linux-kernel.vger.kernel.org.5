Return-Path: <linux-kernel+bounces-49069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E993784657D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886B11F26F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18006DDD0;
	Fri,  2 Feb 2024 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJr2MZl6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE67D308;
	Fri,  2 Feb 2024 01:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837949; cv=none; b=qP5nKHbkT+vut5qf2rjW9o2havAg2BKVCLzLJGtVxZu74z6NPcYgRlP6vgkerofPgZqVplBv2w9T/LlLwoRZ7yxolrwj4p+fKDSTkPA64qHENVIJiRpzF927DTXyP3cCD+LcJOn4DgpdhPM2eg+oZhLUdWWJleJLEnr7LO31WVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837949; c=relaxed/simple;
	bh=GQeFl2/qpCKvJfrDbQwGR8JwlTrO2GQfCBjarFnSGH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dor2G0VeOs2F3zDR8k3rZVJLEXvQptps0DfXvQbyRg2E5ZKiDsU8uaOuZF+uGFGaV4B/oWFoIh8D+K2mN/ug/Moptjoh5GUXLbwG/YYpO/R26p8xVs+VOao5TldH2nIOHjNs+sr968CconJ1KsBd2rx6/uTIJD86uQ0+o+hUrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJr2MZl6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d93b525959so16122335ad.0;
        Thu, 01 Feb 2024 17:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706837947; x=1707442747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28uGw9ts9SOKUiZKl+s61Q53Z2SS8tF6WqdjtpSEx4U=;
        b=DJr2MZl69idDk0T/4Tp6LcE4vLM7JKAOuWQXrThaVy1bzWIxeWekyK5bp6KkC0r1jJ
         GdZWX4aWkGG0I/A0vy2ys88t+chpLX8cjC+m8XjNmIE3YC3K9cyDZs6jhPWNXvYfX3Mi
         NfXrgw5u6sP+N21xxS7yv+SoBbXxGbWMaV6At7QcADm7W0Rr3jrM1lcWw8Ct6QqZq8uS
         lTWsS3/S1ivjNpISLWmFtYTQHReX935XKzXxM9PcCm9uK2SjDMI4JFnt3CuolMigRf06
         +oau8PUpx+i4tW3KzAK9RgUxPe7eEdu9kKG5TDirFv/t+BLBCalyJRBvCSUK1VoUzjU7
         dM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706837947; x=1707442747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28uGw9ts9SOKUiZKl+s61Q53Z2SS8tF6WqdjtpSEx4U=;
        b=KzACQWDPYhz+coNtKGRSOB4H3mQN31pToeZg7dCUh2OePe+sk28W/4N1l7Cq5zq+hb
         YXKAMcAKWk6JhmBGDPSbTQzCuhGid0V1DFqOTcygB2fPD7qnvvft9FYcweRhnRKUSsOU
         iyD2SLUBYoZS5iQEPNHgdFfDNK1l3mvz9n6LNj+BjA1FZGQG2NMYoKuMsx7FvFIr2A5y
         c/SPEcvQiUTGV8hIMi6b5vzVc7r7ZpoVbmou7NHMQJI8iRCV3hel4inyT/uFFGAPnsuW
         mm4hhQQdkp4zdZkQ7BAWaurFBYgRbk7C4xRoIhJuWTcssKhi3wdK0JbJIY5xqQiEBf3W
         VFPQ==
X-Gm-Message-State: AOJu0YwGCyhvoCrN6xf9u1rnLgS/zmtTdNdRQUAWyfrlLfUUx5MqVI9N
	Pv3+p+Ah/hiDigW1elg6LqqqHCcrJ3dET2F6A3nTXZ+DGPyvmH3G
X-Google-Smtp-Source: AGHT+IHmtQrtyBTCy318EpKyvc+tfPavnCXuuwm9Uosu2FvgLZzrvVSaBgPSdCqTNzlhtQfG0u0nUw==
X-Received: by 2002:a17:902:d4c4:b0:1d7:7583:6d1c with SMTP id o4-20020a170902d4c400b001d775836d1cmr1203547plg.16.1706837946977;
        Thu, 01 Feb 2024 17:39:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVt0fhPXq91/9OIUuPC4PVwVT9hk2mJ2o9yce/phVFwGlaOpPJYgmoho77rc8RrSQthdZrY4PtNnFeJoQuBuv6jyPobhkT/f4bFk+2QA1m/bx2SAdln5XaFEK8LMgDdz22retZfx62BiBAzBaxHGfSu7AGwQSB2smQQu4MVNeMX6WnTwsVno3JvhPBYO7fhWcHXXycw
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001d70c6d40f3sm441650plb.237.2024.02.01.17.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 17:39:06 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 1 Feb 2024 15:39:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH][RFC] workqueue: Fix kernel panic on CPU hot-unplug
Message-ID: <ZbxHuS6vOc0MB7-R@slm.duckdns.org>
References: <ZbqfMR_mVLaSCj4Q@carbonx1>
 <ZbrJq3X63hIMkbl2@slm.duckdns.org>
 <8a266076-b3dc-4a39-aac4-089e2ef77da3@gmx.de>
 <ZbvM1V8CYNeds14r@slm.duckdns.org>
 <e6916a78-7872-442d-922d-31ea3920da4f@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6916a78-7872-442d-922d-31ea3920da4f@gmx.de>

Hello,

On Thu, Feb 01, 2024 at 06:56:20PM +0100, Helge Deller wrote:
> root@debian:~# drgn --main-symbols -s ./vmlinux ./wq_dump.py 2>&1 | tee L
> Affinity Scopes
> ===============
> wq_unbound_cpumask=0000ffff
> 
> CPU
>   nr_pods  16
>   pod_cpus [0]=00000001 [1]=00000002 [2]=00000004 [3]=00000008 [4]=00000010 [5]=00000020 [6]=00000040 [7]=00000080 [8]=00000100 [9]=00000200 [10]=00000400 [11]=00000800 [12]=00001000 [13]=00002000 [14]=00004000 [15]=00008000
>   pod_node [0]=0 [1]=0 [2]=0 [3]=0 [4]=0 [5]=0 [6]=0 [7]=0 [8]=0 [9]=0 [10]=0 [11]=0 [12]=0 [13]=0 [14]=0 [15]=0
>   cpu_pod  [0]=0 [1]=1

wq_unbound_cpumask is saying there are 16 possible cpus but
for_each_possible_cpu() iteration is only giving two. Can you please apply
the following patch and post the boot dmesg? Thanks.

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ffb625db9771..d3fa2bea4d75 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7146,6 +7146,9 @@ void __init workqueue_init_early(void)
 	BUG_ON(!alloc_cpumask_var(&wq_requested_unbound_cpumask, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&wq_isolated_cpumask, GFP_KERNEL));
 
+	printk("XXX workqueue_init_early: possible_cpus=%*pb\n",
+	       cpumask_pr_args(cpu_possible_mask));
+
 	cpumask_copy(wq_unbound_cpumask, cpu_possible_mask);
 	restrict_unbound_cpumask("HK_TYPE_WQ", housekeeping_cpumask(HK_TYPE_WQ));
 	restrict_unbound_cpumask("HK_TYPE_DOMAIN", housekeeping_cpumask(HK_TYPE_DOMAIN));
@@ -7290,6 +7293,9 @@ void __init workqueue_init(void)
 	struct worker_pool *pool;
 	int cpu, bkt;
 
+	printk("XXX workqueue_init: possible_cpus=%*pb\n",
+	       cpumask_pr_args(cpu_possible_mask));
+
 	wq_cpu_intensive_thresh_init();
 
 	mutex_lock(&wq_pool_mutex);
@@ -7401,6 +7407,9 @@ void __init workqueue_init_topology(void)
 	struct workqueue_struct *wq;
 	int cpu;
 
+	printk("XXX workqueue_init_topology: possible_cpus=%*pb\n",
+	       cpumask_pr_args(cpu_possible_mask));
+
 	init_pod_type(&wq_pod_types[WQ_AFFN_CPU], cpus_dont_share);
 	init_pod_type(&wq_pod_types[WQ_AFFN_SMT], cpus_share_smt);
 	init_pod_type(&wq_pod_types[WQ_AFFN_CACHE], cpus_share_cache);

