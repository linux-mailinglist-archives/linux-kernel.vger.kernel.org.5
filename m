Return-Path: <linux-kernel+bounces-45740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC28434CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACAE286AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763D168C6;
	Wed, 31 Jan 2024 04:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXX8ioQY"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94F16426
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706675095; cv=none; b=utl2es4MSurVECg9S9wX/cLXCyJeqSQKvUtURBNdTj2s3NLUEL+0/k5Cmhw3VnN4KoNqSAuVKYFmONjf75l6Q07U6wL2EbJo09OL4Tg5YydzbW3NBs4dQd6oPhXlQabSLYz740w9/ou+Hb6tFuizsQMbBbpCD/FUx4IbJyFy748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706675095; c=relaxed/simple;
	bh=N+1QEZ+BRcs7BOQ5nBQPBh303YGe27NxYK2sQ4cGaOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDRMjxP4Luw78xNY3puiXynacKlvgdR9MN2i+pMaBRztaXB8WYLdGdws80i4NX2XORtpFwpt5PNbI0y5XRkw58s0/bzHNrM0m8ONiA3xyHgWjiA+NtXPRNaqFEp/vfm2qjy6mIcZMt3drYp2ePDVicHL9sbQb780fv/4RD2FXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXX8ioQY; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a33aa7ee4so965798eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706675093; x=1707279893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEgaHLs+BcV7NdROP3Ox4QuGIZkqUVcpoz8GYHmGC88=;
        b=nXX8ioQYa3r4ll426DZsYv6PoWt/qsTXey7lN8O7k/SwyimV3WFhr8ikXPYvFs88je
         o4KpZyas6l+AX6rzSTIeRIaLK7XIyja3Ll8GQke975UnnUTE4VwHIkehZ+rZ42pen+qG
         OPzYvN7vZGQ3tI5UKe2zp6NDBcqLKR02V8bWTZGPqQrWz12q14EVaSjQ2W8n9rTlA45D
         MDUwhawnqpIR3na3CNpZMUh3D0Gaj3J6RM4uvp2FHxs8vJOPvzLHoRvXcgqroI+/Dl21
         8jzb4LZ5K/aFpVv5nYGaaN7DRO2W2bBcUBK88GjHqqlvMTFkMGCM6AP6AEePVv4Nqd8g
         Yyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706675093; x=1707279893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEgaHLs+BcV7NdROP3Ox4QuGIZkqUVcpoz8GYHmGC88=;
        b=P/9Y+yMgHcARdDGD9kQpuVcsW2EReElHCICYDEmy9HXQDAy776NvvrVdTGS9OyH8co
         1LIl5ZwtJ8omIEiK2bTXJSpXwJST4GLhbM99fgDrqazznRbHGaTYCSoji+Qi1NtTdBig
         Z4oNYuuI5x5/XP3NGhK1ZApQR9V+Sp5MDC0/HKacfP2y/p8dgCasZ5c4lXt3X+QYs2dy
         odbhnCceU1wA+7vYFeiqfTQF+R96yL+Aee+rKsvT8BQMqZpQ1pEyTwgm2/jJLq+ghsBS
         mbrpH5B9RO3vscaIGlUEjjmIzxYelPRDVDD+5pkJ9EtfKV6+Jht1S2jxr38wnXJkP9G6
         zIJw==
X-Gm-Message-State: AOJu0Yy7aa0xkfCylaV64c0TDTDFvL2zEnUOVLPEu+rohhGZ5/z8CjV+
	pi867qQ9AbbE9siF4+LuYxaPEgU0GkkTesup/Hz4MQf7xW8RPZHB
X-Google-Smtp-Source: AGHT+IGaQ2SntjSIW3jJHpf4SncViherg/pXOoISehsjO9inNmWEr9+TfUCDvfaSpKNvtp4T3EWCRQ==
X-Received: by 2002:a05:6358:d089:b0:175:4f0f:bbb6 with SMTP id jc9-20020a056358d08900b001754f0fbbb6mr252433rwb.25.1706675092591;
        Tue, 30 Jan 2024 20:24:52 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id k139-20020a628491000000b006ddd355283asm9381862pfd.91.2024.01.30.20.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 20:24:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jan 2024 18:24:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Message-ID: <ZbnLk7pZbcODRNER@slm.duckdns.org>
References: <20240125170628.2017784-1-tj@kernel.org>
 <20240125170628.2017784-10-tj@kernel.org>
 <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
 <ZbfrEx9nnkr0FnZE@slm.duckdns.org>
 <CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>
 <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
 <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>
 <20240131041205.GA3517117@dev-arch.thelio-3990X>
 <ZbnIzqmClhAvPxKC@slm.duckdns.org>
 <20240131042031.GA3946229@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131042031.GA3946229@dev-arch.thelio-3990X>

On Tue, Jan 30, 2024 at 09:20:31PM -0700, Nathan Chancellor wrote:
> On Tue, Jan 30, 2024 at 06:13:02PM -1000, Tejun Heo wrote:
> > On Tue, Jan 30, 2024 at 09:12:05PM -0700, Nathan Chancellor wrote:
> > > Hi Tejun,
> > > 
> > > On Tue, Jan 30, 2024 at 06:02:52PM -1000, Tejun Heo wrote:
> > > > Hello,
> > > > 
> > > > Thanks for the report. Can you please test whether the following patch fixes
> > > > the problem?
> > > 
> > > I just tested this change on top of 5797b1c18919 but it does not appear
> > > to resolve the issue for any of the three configurations that I tested.
> > 
> > Bummer. Can you map the faulting address to the source line?
> 
> Sure, here is the arm64 stacktrace run through
> scripts/decode_stacktrace.sh, the line numbers correspond to your tree
> at 5797b1c18919.

Ah, I see. How about the following?

Thanks.

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9221a4c57ae1..31c1373505d8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1510,7 +1510,7 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 
 	lockdep_assert_held(&wq->mutex);
 
-	if (!cpumask_test_cpu(off_cpu, effective))
+	if (off_cpu >= 0 && !cpumask_test_cpu(off_cpu, effective))
 		off_cpu = -1;
 
 	total_cpus = cpumask_weight_and(effective, cpu_online_mask);

-- 
tejun

