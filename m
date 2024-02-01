Return-Path: <linux-kernel+bounces-48557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED71845DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A60C28CECC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B72C5399;
	Thu,  1 Feb 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMeEsvY4"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5925242;
	Thu,  1 Feb 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806489; cv=none; b=r5aFpqzm/AOBao6yT3bQ+fmDnA+Ni6XNPzc6TDyGuVsCQwNu3mNeUzYP5rxeRCYGcrUMaxtu8fRTtTFMk6nQG+h0qiwM3UXG/E6bANxczftpyG/E0LwdpxsiqmmlGVhhVKqryksc9EWNID79DSoDhk9Np8nDCedF709szTDr3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806489; c=relaxed/simple;
	bh=paVA37qC7UagKYbaYGHhj5L2kN0/melhn59qPaD0UmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUu2Xt3SxodqzqfV3g7rKn9uDc63HcyEVW4/1mSnDcNvFKUCOwuuQ4bUuvNqFlJVHX4bbTvjX8ZiQRrdFboXaByRIRWRq+0pfj9VuSCV7wco/N24ze7hh8mevBJeGPGQLAg5iRaKi3ZyRwtuci7UpwurYX9cfb6LJb5Qg8WyojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMeEsvY4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8df34835aso880214a12.0;
        Thu, 01 Feb 2024 08:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706806487; x=1707411287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Le26Her3iuF2oyQhqRLORCxI/GBX9Z+AzUxUWgF+utg=;
        b=RMeEsvY4Ran70ahVgYqPZc5V7plB/CQJtrmnarg7OSip50jYy1IyUgVcs5QC/kxWkS
         hzbFaj6MO/d7iRCCSX/FpbBx38hxyTdDr2eF9HnzkZftN6Accxh02yEinPKeooRbPdG2
         3bSjjSL4z4cXA+eb4VQhIKIPLZFbZuaCTiIbtme417A5jSWvVxZ6jWkDwob06v8zW++0
         aYRrIk9AGCJBgE0Rjr+NrcKvAHlwkxg6dJvBuF/GxrWicCzEPqinfl4emSHAsHzrWePB
         EgKXdAFlidwTrHr1U3GPM29CapemA3z/2RrwE4KmRDEie/2stGcgMiLDlv8DZ/TllMTH
         R8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706806487; x=1707411287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Le26Her3iuF2oyQhqRLORCxI/GBX9Z+AzUxUWgF+utg=;
        b=k7TNozOmswnmb+JReV7Z7Xz1Z9lMKSGI+jLw605xAsFtS2kxSkmoHs/KNbGD6keq9b
         J4wMhRxAMzkCL9l6xTNwd8zs7a0f4VrhTtmFOXHd8DyB9LQ9ld1JJ1dzr5xBXsI/X28S
         vOauK9gKUMSNoAXjkBkC+6oGb4499BwUBQPx4jnoWQgDCZaZrBKIzDo2JmQiF/ZQYQ7A
         1DxFLw6fZLiX5ppCEQ8aeKGdiCdjHb56ZiVIagtjNINHW0/u+8VDgavrG+kZoCKqH7+u
         3a8amJrn0lQRp10RMGo8kRKBMsSH2eGrkMsmG0okHfpU4wanvvOLJnQHWITutdgBa23p
         wsgQ==
X-Gm-Message-State: AOJu0YxlI6yCuP2PeVdNckMpgjun2QXKmaQLXMVjiyipHLW5t0ZWfMRH
	kqPYBqSPCgkU+uGsrsySdQe3Aq5A9tu+ocv/H4QbhKU+RFOZZrv/
X-Google-Smtp-Source: AGHT+IHgS0JUF5oqOAt1EuMRkPOrJ3ytf37UrR80F1aeEmI2/7NvuDIB98SbIB6Jn/e/9kBFghzJoQ==
X-Received: by 2002:a05:6a20:5488:b0:19e:2d00:10c6 with SMTP id i8-20020a056a20548800b0019e2d0010c6mr11084501pzk.23.1706806487287;
        Thu, 01 Feb 2024 08:54:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUTlW5dC0lx8f6Ilw5WQKSfoag1Z8lvuDLBKcLSl6zDcdI4i2Z7abT2WlJal6M2jncVnNn5VZzV0+K1/kouwDvN52NWSz+p13VUI12cbZAH/WFZ6OxVT0lpa1Y0bvfzro85d4cjubz/FpNJB0T5K5OdtF9ZVsFPyAFmYM6N9cQImXTcbzYpDwEz9y07NewN5/V6/lhd
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id y7-20020a655287000000b005db034d1514sm5276785pgp.82.2024.02.01.08.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:54:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 1 Feb 2024 06:54:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH][RFC] workqueue: Fix kernel panic on CPU hot-unplug
Message-ID: <ZbvM1V8CYNeds14r@slm.duckdns.org>
References: <ZbqfMR_mVLaSCj4Q@carbonx1>
 <ZbrJq3X63hIMkbl2@slm.duckdns.org>
 <8a266076-b3dc-4a39-aac4-089e2ef77da3@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a266076-b3dc-4a39-aac4-089e2ef77da3@gmx.de>

Hello, Helge.

On Thu, Feb 01, 2024 at 05:41:10PM +0100, Helge Deller wrote:
> > Hmm... I have a hard time imagining a scenario where some CPUs don't have
> > pwq installed on wq->cpu_pwq. Can you please run `drgn
> > tools/workqueue/wq_dump.py` before triggering the hotplug event and paste
> > the output along with full dmesg?
> 
> I'm not sure if parisc is already fully supported with that tool, or
> if I'm doing something wrong:
> 
> root@debian:~# uname -a
> Linux debian 6.8.0-rc1-32bit+ #1292 SMP PREEMPT Thu Feb  1 11:31:38 CET 2024 parisc GNU/Linux
> 
> root@debian:~# drgn --main-symbols -s ./vmlinux ./wq_dump.py
> Traceback (most recent call last):
>   File "/usr/bin/drgn", line 33, in <module>
>     sys.exit(load_entry_point('drgn==0.0.25', 'console_scripts', 'drgn')())
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/drgn/cli.py", line 301, in _main
>     runpy.run_path(script, init_globals={"prog": prog}, run_name="__main__")
>   File "<frozen runpy>", line 291, in run_path
>   File "<frozen runpy>", line 98, in _run_module_code
>   File "<frozen runpy>", line 88, in _run_code
>   File "./wq_dump.py", line 78, in <module>
>     worker_pool_idr         = prog['worker_pool_idr']
>                               ~~~~^^^^^^^^^^^^^^^^^^^
> KeyError: 'worker_pool_idr'

Does the kernel have CONFIG_DEBUG_INFO enabled? If you can look up
worker_pool_idr in gdb, drgn should be able to do the same.

> Maybe you have an idea? I'll check further, but otherwise it's probably
> easier for me to add some printk() to the kernel function wq_update_pod()
> and send that info?

Can you first try with drgn? The script dumps all the config info, so it's
likely easier to view that way. If that doesn't work out, I can write up a
debug patch.

Thanks.

-- 
tejun

