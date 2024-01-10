Return-Path: <linux-kernel+bounces-21798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0241B829472
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93263B2558A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90673D994;
	Wed, 10 Jan 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uqzi/qd6"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F363D964
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F2C563F2D3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704872429;
	bh=gqWONg/RdAipmRUniv6l6rz28Dcm60IsseyPA4ghbII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=uqzi/qd6CFcnm7AQp39X4tQdWXK6MDhkZau5kumOecuN6+F/vv+RP/su0O1k/SAun
	 E8dhZe/lzIJXhcxrIqp6qJb+PQNVdOFJgwfxDIBXXsIY/kd2jl3bDh+W2J+7vXhx3M
	 n0tZmVxZswv+Wu05Qgeo4uyEXzrtHtmgLksvF2faKBla6NFAgx9JPyvDBvYSpcyKZ0
	 MJUr6M1LYMBoJ+1f/uDZhaCZVuvWzKuNrazwa2A7cudJYTw/vIZg8fEYIbRktG8JAD
	 RuLm8600PyviYmwfCtDlGUEVI9RScy9NZGwQn3c+qgDHh/IR+6oRA8Ce+brYlEGvD/
	 eb1xFAJTCKceA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2b068401b4so233109166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704872429; x=1705477229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqWONg/RdAipmRUniv6l6rz28Dcm60IsseyPA4ghbII=;
        b=mTsFTok6wx6gWbuaWbTRCnXuqoi2PLGk94BYsKgKQYhZ15wo/J+rtSy6cMmLYWJ3HL
         tam11FzVmxOdlm4/XqwxqBw3Ch//ZyRR4mD3URRLCwjhNKil3pDo7DDV7jcrxwNJAcUo
         tCDoCLTdAbwKdqthncRFP7sprvEIqJ87c4UqcgoyVNbx/A6loUhEMiSaZJZdoX6zxnxm
         de5NJQKYzUZIx93/4zmi3j6T8WNd0H4cHlpU6+M7G5U6a5bSIyNw7hebnH9oQ1JYS1BE
         nTAhlh/ApLA0k8ADI6M2hBm4l1pwDxqOY39S5vJxrBpnLyhDRs+AW6CwHZAaoXqGP/y1
         20bw==
X-Gm-Message-State: AOJu0YwIl0EVAbYPVEb31kmuUUo+vuqXCf+Md+KXpsBQ/yhhupjkNtFm
	QpxRbF1bCPrqju2aN8m/u5nz2a3dirxU/9hCmnIRhzGofiwlJ34+QlXsNpwbEVHJcwkCZkqnVmU
	n01BV4rJlaoYr2/+nPh8BCO90dZl7KbNvgiRKcHxOi6G9Jm41
X-Received: by 2002:a17:907:5c4:b0:a26:8c4d:b0b6 with SMTP id wg4-20020a17090705c400b00a268c4db0b6mr2356453ejb.9.1704872429681;
        Tue, 09 Jan 2024 23:40:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKRVvpOQeOqJu//YjOAqylshbUQxBSAyLUbTQIb1vTDgK4Ex/+pKZIK77MQHzlICA788YN9A==
X-Received: by 2002:a17:907:5c4:b0:a26:8c4d:b0b6 with SMTP id wg4-20020a17090705c400b00a268c4db0b6mr2356437ejb.9.1704872429384;
        Tue, 09 Jan 2024 23:40:29 -0800 (PST)
Received: from localhost (host-87-18-244-72.retail.telecomitalia.it. [87.18.244.72])
        by smtp.gmail.com with ESMTPSA id z4-20020a170906714400b00a26f63d16f6sm1814846ejj.25.2024.01.09.23.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:40:28 -0800 (PST)
Date: Wed, 10 Jan 2024 08:40:26 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Tejun Heo <tj@kernel.org>
Cc: gregkh@linuxfoundation.org, ast@kernel.org,
	linux-kernel@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCHSET driver-core-next] kernfs: Protect
 kernfs_find_and_get_node_by_id() with RCU
Message-ID: <ZZ5J6jAxF38v-Tfg@gpd>
References: <20240109214828.252092-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109214828.252092-1-tj@kernel.org>

On Tue, Jan 09, 2024 at 11:48:01AM -1000, Tejun Heo wrote:
> The BPF helper bpf_cgroup_from_id() calls kernfs_find_and_get_node_by_id()
> which acquires kernfs_idr_lock, which is an non-raw non-IRQ-safe lock.
> kernfs_idr_lock used to be a non-irq-safe lock which could lead to deadlocks
> as bpf_cgroup_from_id() can be called from any BPF programs including e.g.
> the ones that attach to functions which are holding the scheduler rq lock.
> 
> To resolve the situation dad3fb67ca1c ("kernfs: convert kernfs_idr_lock to
> an irq safe raw spinlock") converted kernfs_idr_lock to an irq-safe raw
> spinlock. However, this was also broken as we call idr_alloc*() while
> holding the lock and idr itself uses an non-irq-safe lock and also calls
> into memory allocator.
> 
> Let's instead RCU protect kernfs_node and kernfs_root so that
> kernfs_find_and_get_node_by_id() can use rcu_read_lock() instead of
> kernfs_idr_lock. While this unfortunately increases the size of kernfs_node,
> it's the most straightforward thing to do and there likely are other places
> that can take advantage of RCU protection and improve scalability too.
> 
> Please see the patch descriptions for more details.
> 
> This patchset is on top of the current driver-core-next - dad3fb67ca1c
> ("kernfs: convert kernfs_idr_lock to an irq safe raw spinlock"), and also
> available in the following git branch.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git kernfs-use-rcu
> 
> Thanks.
> 
> --
> tejun

Everything looks good to me and I can't trigger any oops with this one
applied. You can add my:

Tested-by: Andrea Righi <andrea.righi@canonical.com>

Thanks!
-Andrea

