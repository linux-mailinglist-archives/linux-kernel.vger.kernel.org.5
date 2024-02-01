Return-Path: <linux-kernel+bounces-48655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C80845F66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279CD1F24988
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBAC85273;
	Thu,  1 Feb 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ltNvwXQg"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5485275;
	Thu,  1 Feb 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810685; cv=none; b=PxNl/GpVyvelz42NC/s+yOPIKx3LvqIK3HQJfRxOIoJm/r4YJ8Ew3A6I751dqx5mxJfBjTpNCe57/OqTDVmT6VPceNFQmFRT4ZazYkHdiarH+0Nax/B8hCPY3KAOWIb1fy1Old0gl+6Ofj39n3mWpFZdi5hnUz4252HhJSG9kKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810685; c=relaxed/simple;
	bh=rEPnT8Us11qXeFJgOKYx1MG1CW6Fq55hMhCM2wTL6r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otUN562p86NtMHIt8AWbyKSJLruEY+bBlMChiKbKWpt4soVClx3NSY/ZPH13f1CAkw2so2ArnVGr5cgHB+OugiF2v7ugIYgGaX8oJiXV7NGcoshqrOBbV23Nmd0kvdIUXjxPfFGzTFC3euGhB/S33j0eVQsD6Y1sMriVOOnnrl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ltNvwXQg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7w2qjfviPfksTMRAs8z5Kp6sfX6leF46kq6yvMVfkmc=; b=ltNvwXQgOGMNzhfWt4K43ajbYZ
	oGwSEr3w6+GGJfzcnAbhDJ2Z4oJl6aHOX4PV+HswHiAud+qlleXOiqv618hOwySCs7mPkJCehSq68
	skQtZ3MFdaIy4zzeRhnkgh/oeM7eiSSFfn00Cqupfi9JJC5d2mys47WYZPVoiBMJ09fLF+d4k2F3O
	hqfZ8BMcdCvAZn/r7oCM4JRq7Pp5kYtx2FtJxqfD3+6Eq/W6WB3g+ZHp6XZLX9vXHj4aFmbRkIR0k
	OapEqVNhA/Qe/ImcH8TJU0b7ib/6jk6syUbSWQHnr+fTfMjbjVRRkIXs+kQBjmWxVi3pTXXhKmjsN
	4eQd2Rww==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVbQY-00000008vhJ-3d7A;
	Thu, 01 Feb 2024 18:04:42 +0000
Date: Thu, 1 Feb 2024 10:04:42 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] lib/test_kmod: fix kernel-doc warnings
Message-ID: <ZbvdOjMNb--7AYjV@bombadil.infradead.org>
References: <20231104042044.17807-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104042044.17807-1-rdunlap@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Nov 03, 2023 at 09:20:44PM -0700, Randy Dunlap wrote:
> Fix all kernel-doc warnings in test_kmod.c:
> - Mark some enum values as private so that kernel-doc is not needed
>   for them
> - s/thread_mutex/thread_lock/ in a struct's kernel-doc comments
> - add kernel-doc info for @task_sync
> 
> test_kmod.c:67: warning: Enum value '__TEST_KMOD_INVALID' not described in enum 'kmod_test_case'
> test_kmod.c:67: warning: Enum value '__TEST_KMOD_MAX' not described in enum 'kmod_test_case'
> test_kmod.c:100: warning: Function parameter or member 'task_sync' not described in 'kmod_test_device_info'
> test_kmod.c:134: warning: Function parameter or member 'thread_mutex' not described in 'kmod_test_device'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org

Applied and pushed, thanks!

  Luis

