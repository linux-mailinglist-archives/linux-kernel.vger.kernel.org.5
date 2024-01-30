Return-Path: <linux-kernel+bounces-43914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95963841AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344EC1F251AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74F376EB;
	Tue, 30 Jan 2024 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l/hWkHuy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239DC374CC;
	Tue, 30 Jan 2024 03:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586642; cv=none; b=MpwtGkybZNDJF28pmBDOjEhfz+4vOPkLLYd9Yc3Bt8BD8OpGkxIMGk0gXd4yWDDMNVsP226TxgOfZFf+UrSxJm1RAm4NxDLMNzIOpzaL7IT/yFdV7x4BlG0iYMqs3l6HiWlDdBRe0W0koBw8JR9Tqh8iQQ1dIihag5u8cYtBRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586642; c=relaxed/simple;
	bh=7ZK7bUmZ3AcQDoBReIB1HzVsVj2N1VuLXliI6DRv89I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0RJNvJm8HQnbU+ZXUJzb8HOXJJcx+C3N/gdBGie/GtAsg8I+8n7nr+9qazfMAOoguVrpuO2bFuRPmhf+CL8IOus4BxGAZ06sjXX8vmXLgedVRXSS2p7wenwEiWKxk3Om5L6jF9JwoMN3FwrrxPckeW3MZTDwp3b7zqzN3VSWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l/hWkHuy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=U0REQpN9hbIQWgR0Ue2gsh4o1QUpwKI0aeyFoce7w7I=; b=l/hWkHuyDs96Rj1rJflnG1WZGd
	EsXifELP9MVhzT9amoampH69KB3MoT3QRdfiM/Ed5RyxcCvh30mJe9q+eFqx7pgvFUOyLe8TAFST2
	WkWonv1n24J2XfJ4qmjxOHKzqtpX1b06czkV0HqTkdPXhnAm4FeYT2+URlRbbbslEzxtxMeXiXuD8
	jvAXSgO9Z3IOk1wlm/aS2UpiDx7BtDw6P7ycLn0gkW68EkBVqS4+IjpgxRR8W0RAeGFJP49K2JjX0
	bJZSIh3KEFCSNlICtxeeAicGny1J3Zlxe2UELExxEKaimuOJE+bQ1ZSc2tvF/xxP36TMYDAIn1YrW
	6ilVpIsQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUf8v-0000000FAwh-3YYS;
	Tue, 30 Jan 2024 03:50:37 +0000
Message-ID: <ec5dc528-2c3c-4444-9e88-d2c48395b433@infradead.org>
Date: Mon, 29 Jan 2024 19:50:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jan 29 (fs/Kconfig: HUGETLBFS)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Gang Li <ligang.bdlg@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>
References: <20240129143030.16647483@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240129143030.16647483@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/28/24 19:30, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20240125:
> 
> New trees: i2c-host-fixes, i2c-host
> 

This

menuconfig HUGETLBFS
	bool "HugeTLB file system support"
	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
	depends on (SYSFS || SYSCTL)
	select MEMFD_CREATE
	select PADATA

doesn't play nicely when CONFIG_SMP is not set, since PADATA depends on SMP.

This warning occurs on multiple arches:

WARNING: unmet direct dependencies detected for PADATA
  Depends on [n]: SMP [=n]
  Selected by [y]:
  - HUGETLBFS [=y] && (X86 [=y] || SPARC64 || ARCH_SUPPORTS_HUGETLBFS [=n] || BROKEN [=n]) && (SYSFS [=y] || SYSCTL [=n])


-- 
#Randy

