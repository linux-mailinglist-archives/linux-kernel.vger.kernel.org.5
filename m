Return-Path: <linux-kernel+bounces-150245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF118A9C38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C50B248CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2821635BB;
	Thu, 18 Apr 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wu93NQS1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gqs+4Wd3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CB165FB3;
	Thu, 18 Apr 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449142; cv=none; b=NIjqMX1YoMQmHInuU8OwArqiWiraLDEzYccP3l8MmOk1zZjUWRlU0+82AXen3fcTcEN3JaeMnC8RY2Ptm05zt0D7zk9DBQlwn8R89OjbDLE96unHPbeHJtpzZRwkhR9XVu1HJSkyyr7eXFzoyUNcTVpItkVqOdVv1KUMjRR9sIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449142; c=relaxed/simple;
	bh=ybtstFCIQIBh/h+bTa3AowDxZdhqZXHjP7CMzjXMl2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvO1JNWvAvg/HIN9mzPS5LxeONCpMZxWqNLbEPdNISpKB4bcru6evan1vxUzpVpW691Ux4DXVwjVzECUDbyRpHd0I4KxXJjwPNGHnFHkvNv5zZBx8pS6fuK/9J97VgJau4rDQ7AOZAccNZOzGeBjWIHFANjxuinJWlVIvb/WuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wu93NQS1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gqs+4Wd3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Apr 2024 16:05:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713449128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdvgBf6ZpsA4n+BoYvD1NnnaPdS5+NDIXIaVMmgP4hU=;
	b=Wu93NQS1Iz2e7QuZtENBDdrlllSJjvCgf3fn/D4KJTe7mIoe907CKwFSkJ4vcoHBfDgzt5
	0aD0nIh0fAk2xY64eYSssFby3uybIltLqPaLyDz1uA3VDX0xiEc6TtiNHaiZfWZrNTSfVJ
	BL64QPsCzkIqpV0gPY5T/ywIVa7y0m3pLDRnbXzFPKIVg+3KGrmpsdALVmEUotkxmOl+T5
	UkTIRKffnude85aVxnGmuMwKmH5CM5HRoHL98stWY2jV61m7ZvL0df+cJKFPngrUf1iL5B
	4uGFoFeLoEPbpbwauSObHWyUkGuyhFtKApyOgq4AXwHCS4KvfRHTDAhampTEyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713449128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdvgBf6ZpsA4n+BoYvD1NnnaPdS5+NDIXIaVMmgP4hU=;
	b=gqs+4Wd3U0rfgEjP80HwkKZ4qF3kQb0jGka9A+b37lMDO0zvuizvVSj2HFl1TbSt4JzOKl
	GMPiRTk6EfmtCHCw==
From: Nam Cao <namcao@linutronix.de>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 jayalk@intworks.biz, Daniel Vetter <daniel@ffwll.ch>, deller@gmx.de,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 tiwai@suse.de, bigeasy@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
 Vegard Nossum <vegard.nossum@oracle.com>, George Kennedy
 <george.kennedy@oracle.com>, Darren Kenny <darren.kenny@oracle.com>,
 chuansheng.liu@intel.com
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
Message-ID: <20240418160526.3b3c385f@namcao>
In-Reply-To: <CAMeQTsbCESSTrEyHgqF9HreSuzQ9kMBnGpKLT0QNJ+n4hv9qOw@mail.gmail.com>
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
	<CAMeQTsbCESSTrEyHgqF9HreSuzQ9kMBnGpKLT0QNJ+n4hv9qOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-18 Patrik Jakobsson wrote:
> This sounds similar to the SUSE bug [1]. We fixed it by reverting [2]
> in the SUSE kernel. The problem seems to be that flush_delayed_work()
> kills the timer and re-queues the work but doesn't guarantee that it
> is finished when returning. So when the device is closed, the
> fb_deferred_io_work() function can still be queued and tries to access
> memory that's been freed.

flush_delayed_work() *does* guarantee the work is finished before
returning.

> Patch [2] tries to solve the problem of not throwing away pending data
> when closing the device. Perhaps calling cancel_delayed_work_sync()
> and then follow up with a manual call to fb_deferred_io_work() would
> be enough to flush the remaining data?
> 
> -Patrik
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1221814
> [2] 33cd6ea9c067 fbdev: flush deferred IO before closing
> 
> >
> >
> > Thanks,
> > Harshit  


