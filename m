Return-Path: <linux-kernel+bounces-38880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC0083C7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAF2295641
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F47D7C080;
	Thu, 25 Jan 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpWot5ru"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A156EB64
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199498; cv=none; b=bLGr7tp33BcVQCxmxp+FnOORlYenCipR6yEMOglM+pS6UTFks0g6uQZsCmmqjBYYq0Ivf052gg8OcCNtoWhk6on0XRYIOVj6V1021NcrjOwy5OsFia1DvFTsDhqw8csNob+Kvn7oWV1ZnAxBJam1jDVgvKeVUYxixgf1Fx8rDTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199498; c=relaxed/simple;
	bh=WoVDPF/mMUTc/TdVb1Vqz29n8UJqHd0WHp/NcXLoLNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSBmEHIodS5BnQQiBatRHUtjOAImSsZnGj9QeGCdAtlycmpwmv2Jag/v+Wrv1rdjTiI8XertETvXDsBdw/oVqPB29X90FzcK0wd+oq9W9eOB6/U4EouggFPjqVcqySbWtXpE7uGaVSCgwzqGbdLeMJUt2kVDisJM64h922Q/Hwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpWot5ru; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d71c844811so36964995ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706199496; x=1706804296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MoEmBbzGBVk8q97dYyCdtd+kj6HEalfHfdlRpBuITs=;
        b=HpWot5ru83/5f/Hy8GHZNMfdYBrHj3y96Chcizl8TnSXQ7z9C/0pHh6Glp+vYsJDs5
         WnCtHgd0YVH2yefVf3nLOiK85vmqhlzSBpnA9azCgzLBBrIO8zPGYyV87X4TzIN5+4cC
         tddyAZvsN94VrKlGKpFaU8RIdxGvb6GoGm8ZmLmQoxzgLWUtU+BhnLVAwx1ycAjr1F91
         xirfBNvxazOc5zTOLfihgyc6AW3mbhbixmRUXZimdgtxX80bwbFfBi7S8r/CFWQtrRxv
         63c+cinhD8oqeYFMhRSVQW4eTHzmRiyvmycBW/1f8wuh0eDvjFxBUFbZR4awptm3M6FF
         csfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199496; x=1706804296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MoEmBbzGBVk8q97dYyCdtd+kj6HEalfHfdlRpBuITs=;
        b=OfENCVsGX+OocAHz5L8teVleb7XpqSEZ1tiJ7gF3NZbos9vK2NyILVaNBGc00XTijU
         5k0aLpWl7fL7lslDREPpH1jzApp7xZMiiAJcgaQdIm49wsT0GNI5oW3v1SD9p7hhZvtD
         f/10rQmLZrB+ue8NI2n6ChAHONqLhHAj20X5n5q1i6gKPMk9Z/+utJHJCBKuxg7mUUPB
         iQu8NC07UYMSC33hWgITuSarlksXD3Uzwm7BY//kOjnCVwDvawdQs6ct98H5ebmc25dB
         CrGB8jWWUI4gaE0cyYfEJ7xNF87Dxf+BxDAx0HJHbC3mpvlqLv26ViTvofvquO/9et8D
         CMAw==
X-Gm-Message-State: AOJu0YxvX9T/yyZprrxeDLV5oUSbsy6Gx0lIIwHROIe9e6kS0sL01XzF
	IQ6b+c0hAkNoTSAWZ39QqyOFSJSQqiMgMMBCbqjw1BiUBExxTUS0
X-Google-Smtp-Source: AGHT+IHp3oQIwDA7nqdKmSLARGKqNkhZc+nJU/BAfGtnG0f0+kya/5KEeLlsYrTQyVUNuid10sHksQ==
X-Received: by 2002:a17:902:ced0:b0:1d7:7664:f2bd with SMTP id d16-20020a170902ced000b001d77664f2bdmr1333892plg.2.1706199495810;
        Thu, 25 Jan 2024 08:18:15 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902b19400b001d72f145ebdsm8745815plr.35.2024.01.25.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 08:18:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 25 Jan 2024 06:18:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH 9/9] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Message-ID: <ZbKJxri2LJCUkPH2@slm.duckdns.org>
References: <20240113002911.406791-1-tj@kernel.org>
 <20240113002911.406791-10-tj@kernel.org>
 <CAJhGHyDaNCoXaK4g4fKg3vfBYuQ7r+e8TT8ObrtT3nBcTeeuMg@mail.gmail.com>
 <ZbBaH2uSqLmJmSsV@slm.duckdns.org>
 <CAJhGHyByJkvANA_w2JXeOiZYid9cQ=5a5dZSwSBLgBL_oKkWUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyByJkvANA_w2JXeOiZYid9cQ=5a5dZSwSBLgBL_oKkWUg@mail.gmail.com>

Hello, Lai.

On Wed, Jan 24, 2024 at 10:54:26AM +0800, Lai Jiangshan wrote:
> If an active item for a PWQ is canceled, the PWQ will lose a hard-earned
> nr_active and have to wait on the round-robbin queue for another nr_active.
> 
> It seems it is unfair for this PWQ. If a user's program pattern is
> queuing-checking-cancelling items, it can cause delays for other users
> sharing the same workqueue.

pwq's get RR-queued iff there's congetion in the workqueue and when an
inactive work item gets activated, it gets dispatched for execution right
away. Note that for unbound workqueues, need_more_worker() is always true
when there are active work items on the worklist.

ie. The only time there's meaningful time window between a work item getting
activated and starting execution is when more workers need to be created and
the system is under significant memory pressure. Note that the former is
always a temporary condition as we retain workers for a while once they're
created.

IOW, there's no meaningful time window in which a work item which was
activated after waiting on node_nr_active pending list and then can get
canceled. It's a possible but fringe scenario which won't happen in any
meaningful frequency and even when that happens the impact isn't much to
worry about. I don't think it's a good idea to add complications for such
cases.

Thanks.

-- 
tejun

