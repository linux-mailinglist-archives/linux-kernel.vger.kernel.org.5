Return-Path: <linux-kernel+bounces-147847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0B8A7A75
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B4FB211F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C5E524F;
	Wed, 17 Apr 2024 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RdVIjrNC"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCB4428
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320439; cv=none; b=M2MNnt0maOSP/6Yn5hi2Nj5ME2WJ36F3/JTyZP9nkZHj5626aurOYs9CF7XJP/k+XJB1rcgl0y8aB9+IJjPGvzKxRDyj1mUebrHDkOnxFr7kMdChtzntfTA0tIKlIzMjLP0hOs2GBhiO6TihYVGvPvAZoJV9upEngZ8U1geUWhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320439; c=relaxed/simple;
	bh=JEO0ng65nZp0QZ6p164cReYxFc0+aDojLhQDMPMJqNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He0ldz6XNCt8lAx2pPSzvfLMILTj3XotBGA9r8+2DW13+ibOUZGYgmxbPABNC9EKyyKEbRXEx2CodKA1p06+lZ4pD4UTvdrFs9BAOlURSC6UAHVy6pMCQOHkVg6q4TDQS9lXBxwccYER516hm75elmay39DJU8EQ9DroCL4DV94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RdVIjrNC; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 16 Apr 2024 22:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713320434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3y5F04Fl5zfvkzhj2El1MuWEnqWlT8gtSPmgfEeDlh4=;
	b=RdVIjrNCwkFFpawDWlb5p/go3q8DWIsZxC/YZY6MzTAeJ9IL48Qu3AuiR3aPgFsmJpOsSD
	Pk3IzGg+83ESHtVTL5NscGWI3YxbAUeyoTlR25/gHeuJtzCDSpwVmKZS3JKKi8v8vm8V2N
	R6DPONrgcXKRMroYaiolgtAP1mr2+Tc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] bcachefs: Align the display format of
 `btrees/inodes/keys`
Message-ID: <toosz4pt2la6wf2575vwe6efebcbzsy735cq7exmlqhzrgicrf@s7g3rrbvge2l>
References: <20240417015448.84294-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417015448.84294-1-youling.tang@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 17, 2024 at 09:54:48AM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> Before patch:
> ```
>  #cat btrees/inodes/keys
>  u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:   mode=40755
>    flags= (16300000)
> ```
> 
> After patch:
> ```
>  #cat btrees/inodes/keys
>  u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:
>    mode=40755
>    flags= (16300000)

This would print a newline for keys that don't have a value...

