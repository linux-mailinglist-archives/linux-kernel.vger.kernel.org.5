Return-Path: <linux-kernel+bounces-25126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45E82C844
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1981F233D7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494B336C;
	Sat, 13 Jan 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMs/GMZ0"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58575195
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so5010162a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105084; x=1705709884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcdqPz1bbjH9uZhuGQcoiXTrvGelHZMyP88Xqr6kyhE=;
        b=UMs/GMZ0M2uvhxlwYzs/vSjqHFOb0ymFEkzm2fs0470rf71ck8EGoeC/wyWa8/sQIb
         1NJSlWF8Tx/tUGQdlp4wRQBWxQND6AMPYZF+szDVatvJgzJADHArgz4nhG9tPrpH537/
         D31lovG0aA/7H94+LNO+uSoEtwbjkfdwbYUua0b9lYPjoUA+8j8D5nS21reeTSa7WAA2
         XBnf4jSEhgQxcgrDg5cMRCx2T84SUAxqBTQUZKeglGbZNMaIepQW1GRjiSCLHyGQmF5b
         yUwtq4DAtesv6p/fyaSqhBPhriEryL9cM7P8OpFH8t7/k137p9gZkKWdfcn6xGf8O50j
         UKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105084; x=1705709884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcdqPz1bbjH9uZhuGQcoiXTrvGelHZMyP88Xqr6kyhE=;
        b=Qag+2VU8Pf9qIDZj56iVuvL3jGeI2mQ+4p18zyjC0vdmy3Ir2KDh642pjXZwwBy0Sm
         fSawIUqcCLD7aQn53aOsCV7gUh+kBXc7lhgEBsdU5ITrOSdaX1bewbzxT048mCXB2fuX
         JJ6DXfgfBE1xkBLgdi9wPmjTmYwvqN8tbHqGKENMPQHVvQKTK4t69/+o2GNdTFuK3DBm
         MApsJCHiLKpWqMt3ifXZ6U+/n3j/Vc96f5i2YvWM+hZ4Lze4fj6NHEeOivEIiv2R2nZ/
         PeaJiPg2vcGWi3VCqzmqK026Z4qr+mmoChYy83sHrzImhycQ5wELMJpwb6CJ4dtYmAQE
         JBzA==
X-Gm-Message-State: AOJu0YzmmauEa9e5WB0gxxZfM4Qa3jOY6U0bmHfc8Sm5ePJxVgrV5Jux
	wdC1uXjo4qOuOuTKSIdfVFp8MRZkoDI=
X-Google-Smtp-Source: AGHT+IEziLiBF8V16Hax+QLmCJNPxoXFMKapyFF2TaJ7mLHwAYWCj8QC7Kzff3YZONAC3ZCSiVS0Kw==
X-Received: by 2002:a17:90b:612:b0:28c:ee69:c1c6 with SMTP id gb18-20020a17090b061200b0028cee69c1c6mr4600072pjb.41.1705105084428;
        Fri, 12 Jan 2024 16:18:04 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id sm2-20020a17090b2e4200b0028d134a9223sm7201163pjb.8.2024.01.12.16.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:18:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Jan 2024 14:18:02 -1000
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH 10/10] workqueue: Reimplement ordered workqueue using
 shared nr_active
Message-ID: <ZaHWukHxfndSWAOK@slm.duckdns.org>
References: <20231220072529.1036099-1-tj@kernel.org>
 <20231220072529.1036099-11-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220072529.1036099-11-tj@kernel.org>

On Wed, Dec 20, 2023 at 04:24:41PM +0900, Tejun Heo wrote:
> Because nr_active used to be tied to pwq, an ordered workqueue had to have a
> single pwq to guarantee strict ordering. This led to several contortions to
> avoid creating multiple pwqs.
> 
> Now that nr_active can be shared across multiple pwqs, we can simplify
> ordered workqueue implementation. All that's necessary is ensuring that a
> single wq_node_nr_active is shared across all pwqs, which is achieved by
> making wq_node_nr_active() always return wq->node_nr_active[nr_node_ids] for
> ordered workqueues.
> 
> The new implementation is simpler and allows ordered workqueues to share
> locality aware worker_pools with other unbound workqueues which should
> improve execution locality.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

This patch breaks ordered workqueues as the inactive pwq RR logic doesn't
follow work item queueing order. I could reproduce severe perf degradations
and outright hangs. I'm dropping this patch.

Thanks.

-- 
tejun

