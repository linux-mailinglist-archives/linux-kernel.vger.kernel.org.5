Return-Path: <linux-kernel+bounces-89853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD0886F687
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940BB28165E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769877641C;
	Sun,  3 Mar 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="jnuDn6pM"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051267C51
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709489183; cv=none; b=W790kdk7YMgmjFm//KJFA8oHGkSbdRXhK4iDFGdSvlAGtyznSObd3OPsXfA2HIKcKEZKEL9NE9kpBeaUkscSYCh40OUha8+ULsFXkqw5WXpDlTMifYEdbXPIm53M+M3D6FWtWt/XXg18kLGjeTURpwDErJUTr5P0P0kuP66WZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709489183; c=relaxed/simple;
	bh=Exg7GvXinQtPYAvj+8NQ3g6/WOwIFv0U9/wMieXJOhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTLnF3kBmKoiJmI3IgZDnTQVWMIdG3kplToZeJ2TWxW1W0KulUTk5QUvdyPcxZoA+Cda7o5qV1F/gYr8v5IUJhIc5UFxLktNKctq0+2Ee8dtgHCdxLjszsIRYmj/FhLhCi5SVT0dcr/1YbesldFG0MyxHN8HGxHmKbxYrHPuGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=jnuDn6pM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412e2dfa58eso1291285e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709489180; x=1710093980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DrEkKMmOl//LEQLxPzRf+ffrBlSy+ppQFC5nF5w2lHE=;
        b=jnuDn6pMlCjkwdxp3dEUMxXY1+v6xeW7Wq/wO1KG/wRcmtz9Te2UGv1GwG6R3496xq
         xM5066/tuNxuDqSJmmY4ew0JwORwIhGoQDEeIUWNwNHnKi9yxJdfo5k+j804NYA7dndz
         4kDwlk/Q9imZFZqP/y/LsPq56C3SQnncPHRe2CWOUHb28S5AooKehjIBQ6ngv6iCPaU+
         DXzCOD9dzSo2aBcmGePfkVWxngkHBoUy1n/T1/+TZJ1QLA0kZZWyaUCLt61O1bGim27Z
         UArDCmFUIflFTzX3x+e6BEZDKfwDDfFa+pjaoOsYNy+GT7zd92OVSlhNum3d94ubLpQq
         JgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709489180; x=1710093980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrEkKMmOl//LEQLxPzRf+ffrBlSy+ppQFC5nF5w2lHE=;
        b=jFg3lxgIFFS+V8iepx2WrQNKe+2XUtCh9QyLYMGoKbHJmvPua9rehKqpRcHK6PfI1h
         GyIE5CJJ2Wj68YIjt9D0XpEs6y/uUkrfIbu8k9ctgZlBNZZ/+UynFjk2t82HkwFuCvNQ
         0Dw2rv2f2bUMn0oInm3Pi6EZI+o0roWuL3I9JjozMzHii90gcZ+bN67mqGomCm09FxON
         ydNIf9CdQEqU/E31oWUwFVFDDxNIIHm+5v1mduHN+ofZCy4izLbXfQv2Y72D7iZzY1A1
         +trtorygDxbRmVHcV/6u2kpi3fydxcm+KPJn0bw+Ye9kirxiUfAKa9OvuUcYlXDc6PxP
         2fww==
X-Forwarded-Encrypted: i=1; AJvYcCXYTrJoPzitZzirqEI+og/dkS1qPJTf8+PRDL4FlgXjSowPrjYaqChLy+8pV1eIS2NOw2kLnDxK0/KBZci5SG4d12CjWmhNL7czzsWx
X-Gm-Message-State: AOJu0Yzh7DHZNTm9E+JkuEw3Wkp0wB9qoduGBJlpbVAWCae4Cyaxc56I
	v9mKSxBLnJlor3NTKoQ1o2thx3cva6RvqbShYySKFHZsKg/HP5sETTCgyG70F2g=
X-Google-Smtp-Source: AGHT+IF95YFMtRBk2d9rsEE6b3wJCR8hzirTwui5b9L/i8nxKjtn34cTKJEYydsX1dGXzNsjXQlzng==
X-Received: by 2002:a05:600c:1991:b0:412:c1d4:dd0d with SMTP id t17-20020a05600c199100b00412c1d4dd0dmr7363452wmq.3.1709489180144;
        Sun, 03 Mar 2024 10:06:20 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id q11-20020a05600c46cb00b00412b4dca795sm12392525wmo.7.2024.03.03.10.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 10:06:19 -0800 (PST)
Date: Sun, 3 Mar 2024 18:06:18 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	yu.c.chen@intel.com, dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
	aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com,
	vschneid@redhat.com, pierre.gondois@arm.com,
	morten.rasmussen@arm.com
Subject: Re: [PATCH v2 0/2] sched/fair: Limit access to overutilized
Message-ID: <20240303180618.mgpdr5bydaeh5l6z@airbuntu>
References: <20240228071621.602596-1-sshegde@linux.ibm.com>
 <20240229000817.n2bnr4kioigaqtct@airbuntu>
 <ff18e64e-d444-40a4-91a7-778d3a523050@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff18e64e-d444-40a4-91a7-778d3a523050@linux.ibm.com>

On 02/29/24 10:16, Shrikanth Hegde wrote:

> > Is the fact these two share the cacheline is part of the problem? From patch
> > 1 it seems the fact that overutlized is updated often on different cpus is the
> > problem? Did you try to move overutlized to different places to see if this
> > alternatively helps?
> > 
> > The patches look fine to me. I am just trying to verify that indeed the access
> > to overutilzed is the problem, not something else being on the same cacheline
> > is accidentally being slowed down, which means the problem can resurface in the
> > future.
> > 
> 
> We did explicit cachealign for overload. By doing that newidle_balance goes away from
> perf profile. But enqueue_task_fair still remains. That because there is load-store 

I don't have a solution, but this accidental dependency is something to ponder
for the future..

> tearing happening on overutilized field alone due to different CPUs accessing and 
> updating it at the same time. 
> 
> We have also verified that rq->rd->overutilized in enqueue_task_fair path is the reason
> for it showing up in perf profile. 

Something to ponder as well. Maybe this is better converted to a per-cpu
variable if it can cause such cacheline bouncing. But that's probably not good
enough on its own.

Anyway. Something to ponder for the future too. I think the current definition
of overutilized is due for a revisit and I'll keep this problem in mind if we
can introduce a friendlier pattern.


Thanks

--
Qais Yousef

