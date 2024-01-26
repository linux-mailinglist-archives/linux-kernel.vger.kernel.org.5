Return-Path: <linux-kernel+bounces-39461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758EF83D184
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131E11F263FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF34439;
	Fri, 26 Jan 2024 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aodNg0hX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8752E1C05
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706229242; cv=none; b=Zq/F/OIL6CNHcxExQg2oRY9B8NqJVDYJvEnNUkw0j8HkCoCG1zSGPfJGXum5rucERwv2z/qIKyWIbQlDKccxER5aHC+0/UyGz9T4QTQwUHURrloSdBti6UbV3ByJjKy10yAAGF4Cyl7q31U9Njtr1PeLMUFdKmr/9apc9hb3cZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706229242; c=relaxed/simple;
	bh=FAQRl1q6MnMVV8np0W8lncH+zy9FvDuPzVQNBdoDOQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCa0FxnaCABkx3uUNbgIysHG75Wk7uC49ifbo51gckpn5sDIT6Nh79tjZCfcBWBv7mof/Vw3bH0AArysnEueMlvlqTVgt98f0H/8fSBidZ7ppn9I1w0oaNTTE9vdPQGf6blR/MiRYsA/UHS3fE/8a+efdjZFQEJ1w6Y31fAM7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aodNg0hX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d748d43186so36323945ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706229240; x=1706834040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PulaV0cbKx4FOxtybdvesZKMhhcYdEXyXz4FJ1O5Yc=;
        b=aodNg0hXNVsPoGpRERX6Nb54Pz8n+Do9+6sBWYaHNtCpnyV6sAQS0Wxx6B8QC82FU6
         XOKF3CCMrxFceEFuFSiW+oKYEXYxQQhUogn3/W8G+KtPi80puWLMCSRLvwcAjnEV4dzj
         9vqrSmIv96qEX2Bwhk41nC+smbBVMpgwa1Wy9OFhtwA545bdmcXTtz+Xb3N2rY38lj5L
         urB1mrhDuW0B9wSSzwY1VPg02f8+/FQEppuWmusJHcGaIPIwv/X57lQ+vwi3b4MMfdCP
         m7rC3OtbnDvPezlgpdhnr3NKtevTtXUmKwGTXzQrpuxiZslBXGDeOD6C59N/ot86U/Jz
         ugGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706229240; x=1706834040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PulaV0cbKx4FOxtybdvesZKMhhcYdEXyXz4FJ1O5Yc=;
        b=Fuvr26zwojV7SE+hGvQkIfs1XxmHo5N5SPfs0KGFi4Rtsffx2BTYgqGMfK6ZJVLsDg
         HEL67kgqPu+QjgY+Z9cV5pe8J+kSNGhxS3UgWMup0zLL7xLrWfzRqueSbV2V+vfUGJy/
         e0/YJTJ4yllF2tzKs0FcaSs+mfaDTU3krZGYr8m9nlCiExllisO830GZPcm6EblrSiiZ
         51rPJ04+oDKinC1fFgfNXhMap2dJ+o6F0MUZv2uVuBCLKy0XjIzA9eSpoml4W4smaYhF
         AwryhRNcxyShcrJXsHHHUXw+/lmP3tVQ186cibDrTMrZXR1XOCd0ZJbjh42h0efByWob
         rXHw==
X-Gm-Message-State: AOJu0YzaqbQIjwGLdD3vDlXpvVnHQ5SaKpQnsiYCg7cdWQcUcic50FSU
	aToFDB02s67/Ytodf1D7Lv0zoC3bE73aVR7nW+dfS5K+jwLw/TUYZkCIZ/p1
X-Google-Smtp-Source: AGHT+IGsZ90XesWFH+F/pb8nvUEBzeH8/0SplhG0HyJjVfwXbaLRgNNljfHmxWpq7afN0SRUOMs9mw==
X-Received: by 2002:a17:902:efca:b0:1d4:cb8c:fafe with SMTP id ja10-20020a170902efca00b001d4cb8cfafemr384611plb.74.1706229239570;
        Thu, 25 Jan 2024 16:33:59 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902eec100b001d785fc6ec7sm79412plb.177.2024.01.25.16.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 16:33:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 25 Jan 2024 14:33:57 -1000
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
Message-ID: <ZbL99b6ywZUqG3YK@slm.duckdns.org>
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
 <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>

Hello, Linus.

On Thu, Jan 25, 2024 at 11:51:28AM -0800, Linus Torvalds wrote:
..
> So we could have a per-cpu 'atomic_wq' that things can be scheduled
> on, and that runs from softirqs just like tasklets, and shares the
> workqueue queueing infrastructure but doesn't use the workqueue
> threads.
> 
> Yes, the traditional use of workqueues is to be able to sleep and do
> things in process context, so that sounds a bit odd, but let's face
> it, we
> 
>  (a) already have multiple classes of workqueues
> 
>  (b) avoiding deep - and possibly recursive - stack depths is another
> reason people use workqueues
> 
>  (c) avoiding interrupt context is a real concern, even if you don't
> want to sleep
> 
> and I really *really* would like to get rid of tasklets entirely.
> 
> They started as this very specific hardcoded softirq thing used by
> some drivers, and then the notion was generalized.
> 
> And I think it was generalized badly, as shown by this example.
> 
> I have added Tejun to the cc, so that he can throw his hands up in
> horror and say "Linus, you're crazy, your drug-fueled idea would be
> horrid because of Xyz".
> 
> But *maybe* Tejun has been taking the same drugs I have, and goes
> "yeah, that would fit well".
> 
> Tejun? Please tell me I'm not on some bad crack..

That doesn't sound too crazy to me. I need to think more about how flush /
cancel paths would look but hopefully it won't be too bad. I'll hack up
something and see how things look.

Thanks.

-- 
tejun

