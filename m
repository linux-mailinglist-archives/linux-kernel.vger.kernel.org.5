Return-Path: <linux-kernel+bounces-41356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535DA83EF7F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DF41F22197
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE072D78A;
	Sat, 27 Jan 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h75dH4ps"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782EA2C19C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706380668; cv=none; b=XdUCdzrRNN9LLSXJ0CJJvCM6+I7ixVyD+IAJG60dH83nr1s3yKvV8X1760/I00rkgG51pEvc4OXlvP/qnhrvjPIVxSfn2R37vItdzUjBQ6/DV8B1c7bhMR+b97UJoqs3Cg/v1APyuB0xPZbedgyjwzi4M14Fg/vdBxk8PBkvKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706380668; c=relaxed/simple;
	bh=krEJZx1PRiMPsxGIkLE+iVCbHEiMZbFzD0vj/F8QdDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkT9HzsQiiKp6AVbxfE95AzoENsE2lAs0jS9r4OB6oDaCsTCCoP5RziPf0wx2X/5JoDWWxhfyY92WXQwEeB49LKzIk9piT4/HBOIFxo4CecdSB58bMylS80M5n77t10AY549ufoFpI4s8MKbuHSUJhene/MetCSOquZ9WeYvuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h75dH4ps; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2906dffd8ddso1158069a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706380667; x=1706985467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1crEbCppZkKwKJJtbycIbn79YP14fen8Jd+JDUcNys=;
        b=h75dH4psKq+vTpD3Vy/L/XhNrDihPR+9WLARAHbcQ0BYNF3/iDD9Ml+d4vZ28A7pmY
         PMaphIVOh3wQUp93Ch7XbQb5d2T/7KRCsJQJWKwnVEUJ5xXnyquVun8UYwZm3ZvwkA4k
         lWre5IB1cHMual/CfZOha9gjBrwdXN/ikkyFty8vjBzAdjf2969T5pu4S4QatVmv26ji
         4jDleqikPNoCG0VIPCr1g32qRVGs07L51Lb2XfBs0y2gb04GPCCYyn9QuHNMD8Rixre8
         YxxerKu74XGr1w30xX5f1lhGH+qsVjF5g6/srV+GHDnZAHfu87XsBUZM8WtWiPyulbhL
         O1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706380667; x=1706985467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1crEbCppZkKwKJJtbycIbn79YP14fen8Jd+JDUcNys=;
        b=beEoaVD2RWYxyiHyxMiGi2byFl+A4W7DbBPb6YIHf1/6qwFuLzuUC9oI6dBG+lYEWU
         whcMB5k/WPVPnrhwBTCo3sYGHn/Yd2rulDusCTXBIV2ZGxLh5I2YsgB7dDnovUQ+Evl5
         389dntpdI3Pm6L5jjFnkndf7FjXrny9ZeBZnNiXQhpvpKOJ+bDZeC8zPTaBqWxHR3Yx0
         OM7m5BOxShS2pt8Ho55SJvGJ84GkeejumR/ghEu5D8cSg8VdHT0o/NFmMZdXkTQBOS24
         HRhZX6HbY4D3cmsfdYqHCsjY96Rtc1hr68dW+rkFDFrk6Vf5isxDZf3y4DbFdo1gBc1q
         AyaA==
X-Gm-Message-State: AOJu0YzIMqA1IfmICmmX3Ag+GOdPM1Ud5a8qtietIUqrEbI8bGWopg+3
	i4zU2XYwN1HRwu0s+znwbxag1GDFTfsICIwIJlQ7soliybbwPPVH
X-Google-Smtp-Source: AGHT+IHkYSB4UO/A2kwpHwTPnB8NbcIAvjg1UAgStyqaD32HWmRau8epA5EhIXHmJ/Xdu0dR3zF/LA==
X-Received: by 2002:a17:90a:bd90:b0:293:b540:5a8 with SMTP id z16-20020a17090abd9000b00293b54005a8mr1353480pjr.8.1706380666534;
        Sat, 27 Jan 2024 10:37:46 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a8b0500b002904cba0ffbsm5176982pjn.32.2024.01.27.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 10:37:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 27 Jan 2024 08:37:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, Mike Snitzer <msnitzer@redhat.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Bob Liu <bob.liu@oracle.com>, Hou Tao <houtao1@huawei.com>,
	Nathan Huckleberry <nhuck@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] softirq: fix memory corruption when freeing
 tasklet_struct
Message-ID: <ZbVNeVkGItt1KTan@slm.duckdns.org>
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
 <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
 <ZbRDnSyiSE93puQL@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbRDnSyiSE93puQL@slm.duckdns.org>

On Fri, Jan 26, 2024 at 01:43:25PM -1000, Tejun Heo wrote:
> Hello,
> 
> The following is a draft patch which implements atomic workqueues and
> convert dm-crypt to use it instead of tasklet. It's an early draft and very
> lightly tested but seems to work more or less. It's on top of wq/for6.9 + a
> pending patchset. The following git branch can be used for testing.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git wq-atomic-draft
> 
> I'll go over it to make sure all the pieces work. While it adds some
> complications, it doesn't seem too bad and conversion from tasklet should be
> straightforward too.
> 
> - It hooks into tasklet[_hi] for now but if we get to update all of tasklet
>   users, we can just repurpose the tasklet softirq slots directly.
> 
> - I thought about allowing busy-waits for flushes and cancels but it didn't
>   seem necessary. Keeping them blocking has the benefit of avoiding possible
>   nasty deadlocks. We can revisit if there's need.
> 
> - Compared to tasklet, each work item goes through a bit more management
>   code because I wanted to keep the code as unified as possible to regular
>   threaded workqueues. That said, it's not a huge amount and my bet is that
>   the difference is unlikely to be noticeable.

Should have known when it worked too well on the first try but I missed a
part in init and this was just running them on per-cpu workqueues. Will post
an actually working version later.

Thanks.

-- 
tejun

