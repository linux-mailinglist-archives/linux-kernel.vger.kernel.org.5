Return-Path: <linux-kernel+bounces-44905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2288428E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEDEB28424
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B5686ACC;
	Tue, 30 Jan 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahu0NZk7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5086AC9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631079; cv=none; b=er2qZoYXfEwK/DqLNb/mJ1TZ2BifwY1+81wj1/w/a1MMhAuq+I6ArJyK5XhDc7C1sUkdqbKoPqRGkIJIRqBbxf85tA9VPZkGOKj0Mq46oOCEugITbQ0y7MNk+pIvhwezjOQJt3GbsaG5zvaQXe9uLGEH/jhhr3BRVmdgpQXHds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631079; c=relaxed/simple;
	bh=VIjb/nB9RHKaYPHzvmKL9TdrK9Hb73ekGe96FIYlepQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRTXqI9PCjCNMEw1vP2glfjCfW0acm+lKUxf2wVfRqSKd5IUq8rP34RSbKNsk0WoEC5zsC/TJOnrzYwzCaECntmjfZ/Vdxd+ensU/VAuMwsYPxQjUEtXI+VfxC5PPKMsEVQvIyz6ACN+1rtg+0hTDpRVxCiGtsUD0wK99Cuq1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahu0NZk7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7232dcb3eso20574955ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706631078; x=1707235878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PFPAnsDiMDm5sszkaQvz2+AAVMk+vumq9lWdsSNu4Q=;
        b=ahu0NZk7FGwusLgPcbCBUnlsSRz/CXs3mr1XRYKfjpAeqQH0YGN+PjnSP4FXst1OPF
         r3ICuBcloIedCabOpnNaU6W+6D5ODB/EuRaWebQJngZC465XylAnswH+VPSfRrhCMVg+
         Ze/Otz6nmNsJHBCkcoi8mAUJ4+2OaTSqBfLPp4yAq85rKrpjgunNJr0Pm/3r7t7DM/is
         dURANXpGlJw0NBs5AvatFD/mMSsEPsw77vge6o3ZXWZKRFJUy8bYE2OUCt9PKpBpqY43
         4ajaDFT5A+D/J7edma1db8epW8+a5zQlu+l3OzCb7rT8g9tc/5qTl99ECfmzQRdU6FMN
         KD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706631078; x=1707235878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PFPAnsDiMDm5sszkaQvz2+AAVMk+vumq9lWdsSNu4Q=;
        b=fjQGtzo362K+kpuuyvAQEutKbsSMWTdHesq51QffL2zU8VTQdNh9lT1yeHtGoz7agt
         2B0fMwdOG/QJwxBJhUIi/qh6l37ZeJstFknjMyomRbFeEbHkksjq5RLXHnXpMWywKicy
         jubPkgUqY7CkBS4V7BBnvpmcsmbfZXGXXdQui9BWsJvDpgIUP5EmfhTrty7nNPZgjEUa
         6fUaLj3x8trQd9fAtliJiZJNgu/xEa2J9uqO9Uk5tF+NKFYYyRooL1D2gQbhJKbh9O2x
         yJkYOpWnCLelqxG0FnGsiqhieHnPhVPhg1WHe8wEWoniqV9rvvr7LRWMcRbqpB5JxTLg
         mLcQ==
X-Gm-Message-State: AOJu0YzUWupgRF0RL/BV1FL2K80g04aO7UH8G5Uce92WencwYnwqDdIp
	AFn7Jg77gOHdUzOqp2GMTU0lhU8caqPUne3cfih+UqF6fGEEYQUU
X-Google-Smtp-Source: AGHT+IG7jJiX6InOBBB5e+neqfiCNRL2JmnauAkSnRxgb6FIu53IyHvEMxvJEtiOEV33ntwgGXwiEA==
X-Received: by 2002:a17:902:d50e:b0:1d8:ffbe:82e0 with SMTP id b14-20020a170902d50e00b001d8ffbe82e0mr2886664plg.41.1706631077527;
        Tue, 30 Jan 2024 08:11:17 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001d90b9ec345sm1478821plb.114.2024.01.30.08.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:11:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jan 2024 06:11:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: Re: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Message-ID: <ZbkfpKv7CQs2u9RH@slm.duckdns.org>
References: <20231220072529.1036099-1-tj@kernel.org>
 <e3r47rru6go5fqxl5issvduzzmsxrtkefigrkfcnqiuouxm467@72hfzpblzr36>
 <ZaCMkV_pjPfhZmrn@mtj.duckdns.org>
 <znrr4upkwnaehoifwcfuhk25ddv4kriyhrymqawcvnxseampml@drwl73kklgmq>
 <ZabvdYTNhj6fiHgl@slm.duckdns.org>
 <a4obzmueffpsmvlzfe64oksxdzyknxacxb2kkeytwzjtlzhz6r@w4lyfr6vrrp7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4obzmueffpsmvlzfe64oksxdzyknxacxb2kkeytwzjtlzhz6r@w4lyfr6vrrp7>

Hello,

On Tue, Jan 30, 2024 at 02:24:47AM +0000, Naohiro Aota wrote:
> > If so, I'm not sure how meaningful the result is. e.g. The perf would depend
> > heavily on random factors like which threads end up on which node and so on.
> > Sure, if we're slow because we're creating huge number of concurrent
> > workers, that's still a problem but comparing relatively small perf delta
> > might not be all that meaningful. How much is the result variance in that
> > setup?
> 
> Yeah, that is true. I conducted the benchmark 30 times, and the sample standard
> deviation is 320.30. They ranged as follow.
> Min 1732 MiB/s - Max 2565 MiB/s
> Mean: 2212.3 MiB/s Sample stddev 320.30
> 
> Comparing to that, here is the result on the baseline.
> Min 1113 MiB/s - Max 1498 MiB/s
> Mean: 1231.85 Sample stddev 104.31
> 
> For a reference, a result on reverted case is as follow:
> Min 2211 MiB/s - Max 2506 MiB/s
> Mean 2372.23 MiB/s Sample stddev 82.49
> 
> So, the patched one is indeed better than the baseline. Even the worst case
> on patched version is better than the best on baseline. And, as you
> mentioned. patched version has far larger variance than baseline and
> reverted one.

Yeah, the average being similar while the variance being way larger makes
sense. Before the revert, it's spraying things across the machine. After,
per run, the execution is more sticky, so you basically end up amplifying
the varince.

> > > FYI, without the kernel command-line (i.e, numa=on and all RAM available as
> > > usual), as shown below, your patch series (v1) improved the performance
> > > significantly. It is even better than the reverted case.
> > > 
> > > - misc-next, numa=on
> > >   WRITE: bw=1121MiB/s (1175MB/s), 1121MiB/s-1121MiB/s (1175MB/s-1175MB/s), io=332GiB (356GB), run=303030-303030msec
> > > - misc-next+wq patches, numa=on
> > >   WRITE: bw=2185MiB/s (2291MB/s), 2185MiB/s-2185MiB/s (2291MB/s-2291MB/s), io=667GiB (717GB), run=312806-312806msec
> > > - misc-next+wq reverted, numa=on
> > >   WRITE: bw=1557MiB/s (1633MB/s), 1557MiB/s-1557MiB/s (1633MB/s-1633MB/s), io=659GiB (708GB), run=433426-433426msec
> > 
> > That looks pretty good, right?
> 
> Yes, it is so good. Since the numa=off case is quite unusual and it has a
> large variance, I believe this patch series is a good improvement.

Great to hear.

Thanks.

-- 
tejun

