Return-Path: <linux-kernel+bounces-44241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255DD841F61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E4AB2FE33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A190E65BD1;
	Tue, 30 Jan 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KocUuPi5"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0D6088E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606384; cv=none; b=kt9qMmNWpP1JdD+m383oLaJbP7pOab10V5gaPsVHspGZB391Rj8s+au7lylA3MT93C+NMjCMUmcYtoCBUY5X60CqRvtntAenSP0aGxc825MeJJWMCctEMbBRXa7Ln9PD7nMq9LMnHnPjdf1ZD71QOo3a0+7RFF/6AbkGR6qn9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606384; c=relaxed/simple;
	bh=BuQ21+ovIZw4O3X3gm0jwHDGVMsfPwdAs6CkLmSfngU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSGWSTxx4wHpeSUgMI5MQoDsqq8SFpXuqyGKA+ev/d8dq/dBmC5sU8NFlkzYYox7DWH/MHzYCO3owBugHFo/Z8kLIIL0Cmmj+tNLvyBd8TyZVBzrSnC5zaeHJlnNdRmKfbtb0z8KHO2yz6kfNEPIE0Z2/tj7HVUktzkAPs0tdO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KocUuPi5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ddc0c02665so1462349b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706606382; x=1707211182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIxMkx8XGFZp5+ArdrZFjloeoHh0HNlPldRTN466UNk=;
        b=KocUuPi5P/Zq3Wu+Nidt1+gfiWiORY2QGViemAiTmitSwyr07NIvQnO/c9glsjRHWF
         EZqWKC9pIAc6fa3xAnkj/HCliR8RFiKYikGa+RS2YbooP75tbh33y6hU+eQDTTxbmHxM
         n0TE5CrHRmghxZuFOlO4P6HPGGMbf+fwLDf5d3fffw0bYQcG2NUNg6oD/0i3ptUIETUq
         PryizZjG6spJ8wp0z03u9mRBu07U7s8uRe6fjViBGZIyZCUfFFMcZ9VfEbvn0mKfee+k
         Wt+YjslbqmFGDI7C7VjCgNQUBiyKEDnfpYbbM6AaoaYVMTVaF70rRminVq7oQ0qgYcWf
         B0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606382; x=1707211182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIxMkx8XGFZp5+ArdrZFjloeoHh0HNlPldRTN466UNk=;
        b=QMtLcxyMv+uIOos0dqiYOE36hol9VKtdAHexTuEpQ+SkiJ95uy2pWYdn7QG0b9Lavv
         ZOiZffXOpvF9U22J2E7ndbJc0RDQ3YEFuByG+ZJVe/r/K/HRYrU2bLg2H35pMXWmN4fv
         wG8NTbaiDQp4I9qfWDo3AOXpfNgu2lDiRhSzWi7v6erZzaE/WrshzgqxYTi979o0VZFG
         RBfz+gOFtQFH+oIYO7/VQe7xgzCERK8uIZWqdBJVhgu2e/zvXK0Vwfv1594uZYF44G+X
         w1s+t9g6NghY3Cdqy7ryfbueRHTwH6gitrtnqnJb5EvdWSu2EQny3ycdlpnBBPmfQp6t
         +08A==
X-Gm-Message-State: AOJu0YyymKUoHdQzAfSJaqu3Wp0XcyBOIUy1u/89mgblNuiBVmg87tPV
	9u6FM4TO/v+mo1hOLVcoheLYb/Cek3SE6ZFDeMaR7876GJlgb4i1
X-Google-Smtp-Source: AGHT+IGQdC4nLoSoiscOQZE9pZywsieV6oVbh3SRyarT8ETvZ7d0gpH15qiT4cLqoktVJeltXJRpKA==
X-Received: by 2002:a05:6a00:bc2:b0:6db:e491:c879 with SMTP id x2-20020a056a000bc200b006dbe491c879mr3924610pfu.20.1706606381971;
        Tue, 30 Jan 2024 01:19:41 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id g4-20020a056a0023c400b006dbc5569599sm7485770pfc.10.2024.01.30.01.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:19:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Jan 2024 23:19:40 -1000
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
Message-ID: <Zbi_LNCeuZDVC0HH@slm.duckdns.org>
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
 <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
 <ZbRDnSyiSE93puQL@slm.duckdns.org>
 <ZbVNeVkGItt1KTan@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbVNeVkGItt1KTan@slm.duckdns.org>

On Sat, Jan 27, 2024 at 08:37:45AM -1000, Tejun Heo wrote:
> Should have known when it worked too well on the first try but I missed a
> part in init and this was just running them on per-cpu workqueues. Will post
> an actually working version later.

For posterity, the patchset is at

 http://lkml.kernel.org/r/20240130091300.2968534-1-tj@kernel.org

-- 
tejun

