Return-Path: <linux-kernel+bounces-24190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461B482B8C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87B7B20E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E0EBD;
	Fri, 12 Jan 2024 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEjQxfjE"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5037F3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbc755167fso5331748b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705020563; x=1705625363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FQ7R3JBITNGLsXiqLRbywnWEkmLNVKXegw/n5Fq2gA=;
        b=VEjQxfjE6o69vBTLXQ0kw1AJvGVtRCysh2I6Kn+4aO3sx22XZZIlkdraWDD8vupKGS
         14dICEAhrws4f5Hv3KrlUkK5HbohGV0B+qUPwPSBhWt7bC81DWLSEpN//MhaATwbWOkv
         CPGd4S4LaVuMYecdkov1wN0xAqesuVDDlq2cT/PWho85RmL4AwYIVCsWY0agapfWY31J
         JUUWPl4dLUM1QrmoQixzc0HAO7I6LE/rx+dJm3MMzHi+0ppBCDEyrC2wTluYGsIilFy1
         YwrH1KIM7caHu3nVmYNvhZvHBJ9PizH4oE8FMPFC6IQRS64YuBveIKEVTDQkyu+MUGmZ
         a7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705020563; x=1705625363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FQ7R3JBITNGLsXiqLRbywnWEkmLNVKXegw/n5Fq2gA=;
        b=ZaSwXdZSDfkUkUsyMvxrdejk1q7j4vV+JnsmZAc+h72zqpcUO2h8T6Fi9Stz2yXZoF
         ilN5eoeJcXuPG1C57bsGL58Qcv7MgVnTN80fJVIrzebIfjyi6vuBX7bSk5kKfZEVo3t1
         CmdiNJ2vr4my3Ybo9j4XIgxoxsRjXAUHalx062pBdmQQ4WUdXdJzl8JVa9p6qr4tStt1
         PKb6h0ICaJeo4BxIxuVEvMRbOuKmJn99TUrXBKEc167tnwikfjCCPOTV1y0FZVKETsIJ
         wHljGNQcfBdoQ3PKiPgfusWXeN1Q6YNu4M3OBkhZiR9JGQe9rWcYVF3exeipsSBr1RJJ
         yotg==
X-Gm-Message-State: AOJu0YxfyEijsNL1D3XRxvtytA7CSrZaLMDBv3QR0I5ZJrXef7hHUiyf
	flsssUQ1HrVbW1i25jogYog=
X-Google-Smtp-Source: AGHT+IEcalphQzon4iujraPaLBvi+UwgFbnwheFCV1qfp1a1JnfRscUjYLh2ErbX150EmT1uV/6I5A==
X-Received: by 2002:a05:6808:6488:b0:3bc:2ec7:a400 with SMTP id fh8-20020a056808648800b003bc2ec7a400mr151014oib.102.1705020562980;
        Thu, 11 Jan 2024 16:49:22 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id t126-20020a625f84000000b006d9b93ca5e2sm1986451pfb.146.2024.01.11.16.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 16:49:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jan 2024 14:49:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Message-ID: <ZaCMkV_pjPfhZmrn@mtj.duckdns.org>
References: <20231220072529.1036099-1-tj@kernel.org>
 <e3r47rru6go5fqxl5issvduzzmsxrtkefigrkfcnqiuouxm467@72hfzpblzr36>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3r47rru6go5fqxl5issvduzzmsxrtkefigrkfcnqiuouxm467@72hfzpblzr36>

Hello,

On Fri, Jan 05, 2024 at 02:44:08AM +0000, Naohiro Aota wrote:
> Thank you for the series. I applied the patches on btrfs's development tree
> below, and ran the benchmark.
> 
> https://gitlab.com/kdave/btrfs-devel.git misc-next
> 
> - misc-next, numa=off (baseline)
>   WRITE: bw=1117MiB/s (1171MB/s), 1117MiB/s-1117MiB/s (1171MB/s-1171MB/s), io=332GiB (356GB), run=304322-304322msec
> - misc-next + wq patches, numa=off
>   WRITE: bw=1866MiB/s (1957MB/s), 1866MiB/s-1866MiB/s (1957MB/s-1957MB/s), io=684GiB (735GB), run=375472-375472msec
> 
> So, the patches surely improved the performance. However, as show below, it
> is still lower than reverting previous workqueue patches. The reverting is
> done by reverse applying output of "git diff 4cbfd3de737b
> kernel/workqueue.c kernel/workqueue_internal.h include/linux/workqueue*
> init/main.c"
> 
> - misc-next + wq reverted, numa=off
>   WRITE: bw=2472MiB/s (2592MB/s), 2472MiB/s-2472MiB/s (2592MB/s-2592MB/s), io=732GiB (786GB), run=303257-303257msec

Can you describe the test setup in detail? What kind of machine is it? What
do you mean by `numa=off`? Can you report tools/workqueue/wq_dump.py output?

Thanks.

-- 
tejun

