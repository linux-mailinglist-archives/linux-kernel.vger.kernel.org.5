Return-Path: <linux-kernel+bounces-25125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291482C840
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1A528869D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A233185E;
	Sat, 13 Jan 2024 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UESj/l95"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D21847
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbd6e37a9bso5885299b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105024; x=1705709824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CVbXRPQ3jFV7zgexS23fksVP6zEliMrtXHT8Sh2qFc=;
        b=UESj/l95jc+FIYdy6Z2HgCftJVU4vcCHm+YdqOniUogZOCFPzXLwqrfIyQzwjOCWqL
         iGmYqDEHJkN1uXnUYAh6pTlWq7gga7pTablUpn3Zx6zXRGRD/igNp/sSfzlkOm9H9vGx
         fxm8/Kz4N3z6dncH4Wpg7zxDArwNvxQlnSHw7C1ZzBHqw01myBdlDNbMgN+63ll9RuFh
         +BoCiEZjGqhZZHC+dCTS31j8aVqnLGmLeOxGS9zsu46x/njh0GKx2I6orGqBSJ65/tub
         /rjJOXbu+471zE/UsYUe8v4njX0T6h3nyDNW9QgJIUWhhEHKTjxPvTc/tWSe874rFXKu
         Dtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105024; x=1705709824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CVbXRPQ3jFV7zgexS23fksVP6zEliMrtXHT8Sh2qFc=;
        b=rj9o+sst/X0eFrLyYMTP9gc0dPGiNcGqYgENiAhdsrU0MDiBL6qbgqY+ih8+WzAAhI
         5kAiv0t4h/kZTjLQGSZh/SKy3Rf9S/idoXTlqoief3ICG7boKCtcOhUeVz8GA/0Ny6dT
         EVbDgnq8rA0D8hjBnFmHaLYsv60zBxEtxn+Bgi8EJAUDQJtUtFHLtTBo22Q3dU0RubWK
         +R6buGjW/GLn+8+nXRKsVsWVVf2zrCWXLB+WiPDh6Caqv8CCxzPXRt1q+Zhx/aCdHHib
         +yxWQKWhRRTYXeNg4YmFYQ8kjhfxeAl/rkvZxsl6QCLc9ZZFlqTqMZUi8a7NeasdoV9C
         N6GA==
X-Gm-Message-State: AOJu0Yw4CqiiXoqWIXDxmrh4qf3Xd1G2elCn8BZN7oG04F0uM8b3YIZn
	RUnuooLGPvwNBgsV6uw8hVE=
X-Google-Smtp-Source: AGHT+IECmUgfYkW5iimCxNuAW3iN6ApAgvgpu8QgdGSP8bz5jjOk7yLUTL+f8lfqVIOab+EDUwkslQ==
X-Received: by 2002:a05:6808:6541:b0:3bd:692a:6633 with SMTP id fn1-20020a056808654100b003bd692a6633mr654803oib.47.1705105023066;
        Fri, 12 Jan 2024 16:17:03 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id fj15-20020a056a003a0f00b006d9a5a6b059sm3807123pfb.91.2024.01.12.16.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:17:02 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Jan 2024 14:17:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Message-ID: <ZaHWfWYvAiolChWG@slm.duckdns.org>
References: <20231220072529.1036099-1-tj@kernel.org>
 <e3r47rru6go5fqxl5issvduzzmsxrtkefigrkfcnqiuouxm467@72hfzpblzr36>
 <ZaCMkV_pjPfhZmrn@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaCMkV_pjPfhZmrn@mtj.duckdns.org>

Hello,

On Thu, Jan 11, 2024 at 02:49:21PM -1000, Tejun Heo wrote:
> On Fri, Jan 05, 2024 at 02:44:08AM +0000, Naohiro Aota wrote:
> > Thank you for the series. I applied the patches on btrfs's development tree
> > below, and ran the benchmark.
> > 
> > https://gitlab.com/kdave/btrfs-devel.git misc-next
> > 
> > - misc-next, numa=off (baseline)
> >   WRITE: bw=1117MiB/s (1171MB/s), 1117MiB/s-1117MiB/s (1171MB/s-1171MB/s), io=332GiB (356GB), run=304322-304322msec
> > - misc-next + wq patches, numa=off
> >   WRITE: bw=1866MiB/s (1957MB/s), 1866MiB/s-1866MiB/s (1957MB/s-1957MB/s), io=684GiB (735GB), run=375472-375472msec
> > 
> > So, the patches surely improved the performance. However, as show below, it
> > is still lower than reverting previous workqueue patches. The reverting is
> > done by reverse applying output of "git diff 4cbfd3de737b
> > kernel/workqueue.c kernel/workqueue_internal.h include/linux/workqueue*
> > init/main.c"
> > 
> > - misc-next + wq reverted, numa=off
> >   WRITE: bw=2472MiB/s (2592MB/s), 2472MiB/s-2472MiB/s (2592MB/s-2592MB/s), io=732GiB (786GB), run=303257-303257msec
> 
> Can you describe the test setup in detail? What kind of machine is it? What
> do you mean by `numa=off`? Can you report tools/workqueue/wq_dump.py output?

So, I fixed the possible ordering bug that Lai noticed and dropped the last
patch (more on this in the reply to that path) and did some benchmarking
with fio and dm-crypt and at least in that testing the new code seems to
perform just as well as before. The only variable seems to be what
max_active is used for the workqueue in question.

For dm-crypt, kcryptd workqueue uses num_online_cpus(). Depending on how the
value is interpreted, it may not provide high enough concurrency as some
workers wait for IOs and show slightly slower performance but that's easily
fixed by bumping max_active value so that there's some buffer, which is the
right way to configure it anyway.

It'd be great if you can share more details on the benchmarks you're
running, so that we can rule out similar issues.

Thanks.

-- 
tejun

