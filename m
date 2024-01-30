Return-Path: <linux-kernel+bounces-44880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73923842875
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABA91F222C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312C886AC8;
	Tue, 30 Jan 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcalAKcL"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08985C44;
	Tue, 30 Jan 2024 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630010; cv=none; b=gU8Yn2wpCMOE3fuusVRxmaGeGoVhmYqRS1tk3Eqg0oRu9plEyUDfnNjSlPck3/UAzQMrkstdtKfXBkZgEKaxpRPP+3yhWLXkxNyTTReVznS2kyup/UdteeEaV8oO7012b9jKZhDZhWPzBM5r/bC/uv5gzv0d5G0iT9jV8uLCP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630010; c=relaxed/simple;
	bh=UIe+zdWCR/Ww2V/jLPrMjticY2axcU12ENjKMXzkdzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE2Jtt+YMRcCfT+nUadTWmOLbZM6TeDu72cuc4IZ81Jq9h2dsqhtOq5Wq/1c/bLe7X/0HtT4S8sNjpyFhJO7mf9GS14wVgsW2LmRP5YNVP4cnE+VBiJAm6b1RSzVqN1LEBsjC5c4YpiAkrpHV8ZOnY8pQs7LnPLSf5R7R6ffnws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcalAKcL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddd1fc67d2so1859525b3a.2;
        Tue, 30 Jan 2024 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706630008; x=1707234808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvnOw81iTWv+Rh9SWXo4ayaLBbjRis7Z8HFX8oWs5s8=;
        b=kcalAKcLbdpKBwbc6w0NTuUUCJ0gT3G5iONckWourp3w1KTuZB2lQMU9M7JZizlRSu
         4gCgtAOBriJUAsHrMo0krXCparfcygvavfbGT6YxYp1pbzWXJNPNFRjR+Ozz6BXv/zV/
         djxQmTaSBqyZHPvEe+qZb8trdzYO1F+MHVouGlG1ZyjGQCjhvAc55IP/P+duPJ8Rt67Q
         g/5UDZjsQqz9fKCQUk4zng7NgYrMmuWQOyHZeTiXVFga04yIzXRn14YiF8a4wvRwFxsD
         R5tZICs2JdNOKNGldZRlNjD/AmYahoEqlokTFM9vsiS0/Qph3hTSfVohcCsC1B2fEzc3
         P54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630008; x=1707234808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvnOw81iTWv+Rh9SWXo4ayaLBbjRis7Z8HFX8oWs5s8=;
        b=wi9QO9Ct7CaRYYj/Wsj5nCDjPnGEJAb317l7ajLIASs5nEyAchKpWZ7zuOJzQ/LoOR
         LYNwFP8tOW8qqfgaXmQFrcj3do7AR1k0qLav6bINaR0YZM33rremhZJX48oW7vNjSj/3
         Kz/BD7HcbYWQ445fqfPLeY23vVIH7gsFovYk5IKQmquJYkoHCl3tnsbqzeVr1tuHGrDj
         3Y9KW2Z38qKmlYOfZYTvCKhXdQ16FDofZRfNALNles8mG/tK3+qn8ea3Wrv0HAl11smT
         4/aAKWGSIMxlz/0Sjxe78EyKHwieLTkbtM+mkloOm3/xdID00Ot7HlGeZxpPuANHg2lA
         sYTg==
X-Gm-Message-State: AOJu0Yzbwsw5mH7LUOEJw+aUM489fN/oo3gCxwtt2Cso4MggVy2Lyc4Z
	c9x3+1Br5uDPasueHnfrBgqUtgoYftC7WNKioB4XlLQnV+pEJcc0
X-Google-Smtp-Source: AGHT+IHjs+7Au2nQ2UZ02r/5YFemO3930W53TAMdk751tM0g6UVfvFp8IJR1SUj7EikwCAORkxjt2w==
X-Received: by 2002:a62:d148:0:b0:6d9:ecbb:8bd8 with SMTP id t8-20020a62d148000000b006d9ecbb8bd8mr4760905pfl.32.1706630008269;
        Tue, 30 Jan 2024 07:53:28 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id gu2-20020a056a004e4200b006dde1781800sm8219654pfb.94.2024.01.30.07.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:53:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jan 2024 05:53:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, tglx@linutronix.de
Subject: Re: [PATCH 7/8] dm-crypt: Convert from tasklet to BH workqueue
Message-ID: <Zbkbdm66X2LcxSHD@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-8-tj@kernel.org>
 <20240130104645.Gvnx8KnC@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130104645.Gvnx8KnC@linutronix.de>

Hello,

On Tue, Jan 30, 2024 at 11:46:45AM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-01-29 23:11:54 [-1000], Tejun Heo wrote:
> >  		if (in_hardirq() || irqs_disabled()) {
> > -			io->in_tasklet = true;
> > -			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
> > -			tasklet_schedule(&io->tasklet);
> > +			INIT_WORK(&io->work, kcryptd_crypt);
> > +			queue_work(system_bh_wq, &io->work);
> 
> Why do we need the tasklet here in the first place? Couldn't we use
> workqueue? As per comment, the request originates in hardirq and then it
> is moved to tasklet. Couldn't it be moved to workqueue regardless?

Yes, you can and if you replace that system_bh_wq with system_wq, or
system_highpri_wq, everything should be fine in terms of correctness.
However, that would mean that the work item now would always incur a
scheduling latency which can be lengthy in certain circumstances. Whether
that's an actual problem for the subsystem at hand, I have no idea.

Thanks.

-- 
tejun

