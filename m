Return-Path: <linux-kernel+bounces-9145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E481C18E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8F31F26167
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726C778E92;
	Thu, 21 Dec 2023 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw0LhJ8Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7D78E7F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so9549575ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703199700; x=1703804500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsE9gBhCKxjgSiOjZ4BBKtBS0Fenb9nkFdDn3mvQjNM=;
        b=Pw0LhJ8YFi93VWbdYC0yLUVTgKDyGVYdCVUyAJeCC7Bhz3g3OoLpJlwcZncFlNH1Sb
         ZwkpdtwiweXBRD+eTuHENug0Z9mov07R8Sq4nzUQoVugAxF+bedt9PiXZne/5X7Ol926
         NCbg1qliIjEeJ9UNUmLRWQov3L1wvlThMx2FiaWcXJMa1IOQ5EfgtNqKEzznA6m8AAvR
         b0VHnvND741TArQMeU7tX3yk1EpsJ3Xp5LMWerWauvpjzzaJ0TBr7DLhtBPhPjMk8xZU
         SwDS2HCwhBhxXzoGlEc7FIH024m1cD/ydHfZhNNfoauKQj+4ABKMIWURtO8/s4PTMhwm
         G/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703199700; x=1703804500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsE9gBhCKxjgSiOjZ4BBKtBS0Fenb9nkFdDn3mvQjNM=;
        b=q98P5fXB6OWgvXkv+Uu+RxQ6pP/pH6jBXGG8DwI7wRDAFMD9bph8jy3U4XnqsSu+sF
         MHzvVj+IHBShlKNREPS08cpREiKSozX0GRbHHJoQnkxyUvbaeSs7zPBsBllIqo6jKsL1
         DL4zDEoqM47m/5eMyk/+PJ5TkEX4dzRCKdy/BbcRItZt8nH6+n8wi+Dm64+iXyCXBrKE
         D30BInhwXiSZ2IDjRcgjOFVjerjiYpcwfr8IiE5oRXTUZR2n8+NTNd7vgkxv/igQ89BS
         TqdQGaU5w541Yo1tFnMSwu9UE7pp6uJBUeMSkhMu8Of75FqCbx0E31agWic/x+6ZbGYg
         rCRg==
X-Gm-Message-State: AOJu0YzpomC9IfYpIH0diQ/sVv6K3MWPFxgoP/50B9ley/evzUAF0pp8
	Mxqgap6rPR4u6HjvvMXmnJo=
X-Google-Smtp-Source: AGHT+IHCo2pZ2BZg2XrRU58xrQbHW0thbvU1TZrAnZSscve0jlujdaHed6z/4jak1LMPe/uHDR4cfQ==
X-Received: by 2002:a17:902:eb89:b0:1d0:acfc:a662 with SMTP id q9-20020a170902eb8900b001d0acfca662mr290795plg.123.1703199699632;
        Thu, 21 Dec 2023 15:01:39 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id ju22-20020a170903429600b001d1cd7e4acesm2180088plb.68.2023.12.21.15.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:01:38 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Dec 2023 08:01:35 +0900
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Message-ID: <ZYTDz10ohj0kokum@mtj.duckdns.org>
References: <20231220072529.1036099-1-tj@kernel.org>
 <CAJhGHyACBBW5wnYTTz7S+AgLMhLYOsfxTnN6VHodCgECqEFeEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyACBBW5wnYTTz7S+AgLMhLYOsfxTnN6VHodCgECqEFeEg@mail.gmail.com>

Hello, Lai.

On Wed, Dec 20, 2023 at 05:20:18PM +0800, Lai Jiangshan wrote:
> The patchset seems complicated to me.  For me, reverting a bit to the behavior
> of 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu
> pool_workqueues"), like the following code (untested, just for showing
> the idea),
> seems simpler.
> 
> max_active will have the same behavior as before if the wq is configured
> with WQ_AFFN_NUMA. For WQ_AFFN_{CPU|SMT|CACHE}, the problem
> isn't fixed.

Yeah, it is complicated but the complications come from the fact that the
domain we count nr_active can't match the worker_pools, and that's because
unbound workqueue behavior is noticeably worse if we let them roam across L3
boundaries on modern processors with multiple chiplets or otherwise
segmented L3 caches.

We need WQ_AFFN_CACHE to behave well on these chips and max_active
enforcement breaks if we keep them tied to pool in such cases, so I'm afraid
our hands are tied here. The hardware has changed and we have to adapt to
it. In this case, that comes at the cost of extra complexity to divorce
max_active enforcement domain from worker_pool boundaries.

Thanks.

-- 
tejun

