Return-Path: <linux-kernel+bounces-87434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D356686D459
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C56C283FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7146144057;
	Thu, 29 Feb 2024 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxsy7Um3"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6A1428FC;
	Thu, 29 Feb 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239053; cv=none; b=a7jnnRGukkYjdcfw2iNXe2IcB0SpRnX4mePBTNcJbpYzFZBLdVb9GHdOyTjimqQAXT+ywH1jXnJBQlpjHYxQmeovedrVz9PIF6TgFhCLeibURvUUaQNrUaWExSuHOSmSKPi5uZGL5m5UhKWSa/SuowLuUvwbLPRKtIrahvzWqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239053; c=relaxed/simple;
	bh=ii4D7YiCreEVMR4r5RTvfhi7WZ6+lvbN3NGPlbGfYUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMys/j2UClzr/S2bsuj5Jw49J0KjB89bqSTei6KHe/kXSPMtPs/HszncR1M3p4jaaVQnPd8xi/JusrijgoQwizuEX5Mvk0JxPWDALoIVp/o5YY8XIScsblrKkAUJ8ndHKjL9bh30GOtoJO/MlTdZn94oxaaYEwpBHPeA1bPoBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxsy7Um3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc96f64c10so13739325ad.1;
        Thu, 29 Feb 2024 12:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709239051; x=1709843851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5blMfwCgLp1FPPnA5HDVy206wgmfNgtw944me58i0A=;
        b=cxsy7Um3pV09VqTA9KVIG9RIW297u9aObGYhimN9F3l6bWl2/9wEsJfuuKw+pGWuSw
         VZej06F3BjGz6NP6vsFG1NqtgZGlDb51g+AYQWsALsjVDZLpCwpQwuFdkguP6V43MKFH
         VP+5yKfDeTid7GiosH1uZdI7FysPvTQs9W9pH6F3L/1u1be/RSjJPoBy+l+ytEx7FuvJ
         eTJZNPdkjU6dWrivxvExMXZQrePH/Yo2zOpVgyLK0Zvwcen2DDoyaymGt49kqfDNyYMy
         lblfXP9uLlVCHqIQdiybBHd7ldiS8691qfTONlXrKTwTuc18LHTnRVMNQsoKITV5Ld+v
         WjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709239051; x=1709843851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5blMfwCgLp1FPPnA5HDVy206wgmfNgtw944me58i0A=;
        b=Ln5UDKbzHR7gVcO3OuFN4o4Z++p59+h21bJiUV9V7vAVR7KE8m2aC6RNJSM/+VJWvp
         VWN0vme49FnixMZpv+k6VfK/wLQbgEt5LRR/xwGU0A4Z3rp2Zg6siMWQpN/tZ7Ajkcto
         GvraDrbgZ74cK9/dyGBZ9pnUC13aQytc9uucM60b8F3ib+eF85sM4shIQ7mOitBaYaD+
         UOa+NLcyp0HVuJoWRCE18wbu7NAUdsLt7MBu7MaDvHTJRx5tzSLeUWdvLqNVtvRdnvTt
         kFEDimhY3o4KzZZ85tydz68+jX6Q+ER6lhTK2TtDi0Fg9tGXbLHtmnf9oFWWEBTUBGdK
         rZGw==
X-Forwarded-Encrypted: i=1; AJvYcCXkJxk2JuLi1aw3d3CIqBrBC9QaP07g3LYQxCCx609IYRxkUahyfmluhzPc0RRcZ/CyARJke5d64seUMsVrWQOhJcLjyGA1Y9W3NnAY35CvPskp5lw0lrh7s+0gPtxZC6rpynpE
X-Gm-Message-State: AOJu0YxPYdG3JjYdKMMC5XBwZ5gySF+GV+AyYoE1R5w7v7a5Nvd2yyEe
	nFzOLksqcLMR7H/REgdSexTBg5nQ1kGVH0SQzWUd4QyoiJjCTDg0
X-Google-Smtp-Source: AGHT+IFceYVsyf342UvaMXXreAwvaQzmHEhFmJrWZ40V54W++PEy915RjWYjmCRa7EohfqoaHubDsA==
X-Received: by 2002:a17:902:c403:b0:1db:ecf1:3b67 with SMTP id k3-20020a170902c40300b001dbecf13b67mr4292849plk.66.1709239050771;
        Thu, 29 Feb 2024 12:37:30 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:8305])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902ed4500b001dbb06b6133sm1920015plb.127.2024.02.29.12.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:37:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 29 Feb 2024 10:37:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH for-6.9] workqueue: Drain BH work items on hot-unplugged
 CPUs
Message-ID: <ZeDrCMLlzVZpvbrG@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-4-tj@kernel.org>
 <ZcABypwUML6Osiec@slm.duckdns.org>
 <Zdvw0HdSXcU3JZ4g@boqun-archlinux>
 <Zd09L9DgerYjezGT@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd09L9DgerYjezGT@slm.duckdns.org>

On Mon, Feb 26, 2024 at 03:38:55PM -1000, Tejun Heo wrote:
> Boqun pointed out that workqueues aren't handling BH work items on offlined
> CPUs. Unlike tasklet which transfers out the pending tasks from
> CPUHP_SOFTIRQ_DEAD, BH workqueue would just leave them pending which is
> problematic. Note that this behavior is specific to BH workqueues as the
> non-BH per-CPU workers just become unbound when the CPU goes offline.
> 
> This patch fixes the issue by draining the pending BH work items from an
> offlined CPU from CPUHP_SOFTIRQ_DEAD. Because work items carry more context,
> it's not as easy to transfer the pending work items from one pool to
> another. Instead, run BH work items which execute the offlined pools on an
> online CPU.
> 
> Note that this assumes that no further BH work items will be queued on the
> offlined CPUs. This assumption is shared with tasklet and should be fine for
> conversions. However, this issue also exists for per-CPU workqueues which
> will just keep executing work items queued after CPU offline on unbound
> workers and workqueue should reject per-CPU and BH work items queued on
> offline CPUs. This will be addressed separately later.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Boqun Feng <boqun.feng@gmail.com>
> Link: http://lkml.kernel.org/r/Zdvw0HdSXcU3JZ4g@boqun-archlinux

Applying this to wq/for-6.9.

Thanks.

-- 
tejun

