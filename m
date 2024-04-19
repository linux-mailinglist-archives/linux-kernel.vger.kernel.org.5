Return-Path: <linux-kernel+bounces-151659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B42D8AB1AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4AEB22688
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9418712FB34;
	Fri, 19 Apr 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xjCz/GSk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GMFja7Ny"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC812F59B;
	Fri, 19 Apr 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539919; cv=none; b=qsFeXbsHBT+01ig6xLgUPNUEbLfz22SbwVCBf7n2O8iJydIB40aPV40TnPOUS1Qedb2qREmrZuquDzxNFUu2H6AF4t4RXshxHQ2AvGYpHrU4TwrjKZYRxeCRSE/p0vfrZ7uq+DXnK9GatTCQj0wpD2dsoFIfzvp2Yf7XE5EedW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539919; c=relaxed/simple;
	bh=v1u6M1I7hfUyhQBN/cwpO9ocGTQ1Qy4P5YzpeMaFhQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvZwHVpWsRmtnCd26TSM8ABpEz9q00EydsPlPA8JAY32P3QNdXREoSsQY4YxNBIj8LxXCPjUTbVpy6W78qiRIZdow12xnneBrJ7RvL5mUXo+Hi/vUuLN/la0eCvVm/UA+lAcHzJIij9ZEaJSy8bXlITVWCw8TSPA72KrkZY5jO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xjCz/GSk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GMFja7Ny; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Apr 2024 17:18:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713539916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1u6M1I7hfUyhQBN/cwpO9ocGTQ1Qy4P5YzpeMaFhQk=;
	b=xjCz/GSkAs50I+QI7DCxQjyQohYIKc6gfvXM/lOOMOQ9u4NDYv4qdY0z6mGx+hROJgFmKZ
	9zWABT+BP9mqJwBa9/4yjtYDKpgRik0Cv9GA8jRsyhvXHu/MKWDm8b66esCWPBv2iLgmtT
	+ClBiXzbUFG/aZE+faPmaO96/IJ0GxLADiEcabH9wroL7jIYAF5/fsnkaYTATpoXx5G1gu
	UgVOwkWp2/Iqt4SGIo5q/Y+khYcmWoOpDBOZm1LsGnQBxF6IWpUDLvaO9NHxL5ECZ/Fox7
	Yx5FU8Trbb/wjAuloMMQjlBMJpWky5bQgDrrxWHMEZ7QpqqDNeF6CkxOGonjOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713539916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1u6M1I7hfUyhQBN/cwpO9ocGTQ1Qy4P5YzpeMaFhQk=;
	b=GMFja7NyiVFhz0KcOQninz2/TkAOL/1k/FUec7DzdPA2AaqJJSnOAQ/5sXQ/BziLmr/ddB
	rUE1t7yBUbab7YDw==
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
Message-ID: <20240419171835.5f31e32d@namcao>
In-Reply-To: <CAMeQTsaGXv6hUmXg3ROLb83JZEAfoSuQGCQgz0wG38Me8UtQYA@mail.gmail.com>
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
	<CAMeQTsbCESSTrEyHgqF9HreSuzQ9kMBnGpKLT0QNJ+n4hv9qOw@mail.gmail.com>
	<20240418160526.3b3c385f@namcao>
	<CAMeQTsaGXv6hUmXg3ROLb83JZEAfoSuQGCQgz0wG38Me8UtQYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2024-04-18 Patrik Jakobsson wrote:
> On Thu, Apr 18, 2024 at 4:05=E2=80=AFPM Nam Cao <namcao@linutronix.de> wr=
ote:
> >
> > On 2024-04-18 Patrik Jakobsson wrote: =20
> > > This sounds similar to the SUSE bug [1]. We fixed it by reverting [2]
> > > in the SUSE kernel. The problem seems to be that flush_delayed_work()
> > > kills the timer and re-queues the work but doesn't guarantee that it
> > > is finished when returning. So when the device is closed, the
> > > fb_deferred_io_work() function can still be queued and tries to access
> > > memory that's been freed. =20
> >
> > flush_delayed_work() *does* guarantee the work is finished before
> > returning. =20
>=20
> Right, flush_work() does guarantee that the work is finished, but it
> doesn't guarantee that the queue is idle if work has been requeued
> since flush started. So fb_deferred_io_work() should be able to happen
> after the device is closed. Or am I missing something?

I'm confused: how is it possible for fb_deferred_io_work() to run after
the device is closed?

The workqueue is flushed during closing of device. If more work is
queued during/after the flushing, then someone must be writing to the
device during/after the closing of the device. How can that happen?

Best regards,
Nam

> > =20
> > > Patch [2] tries to solve the problem of not throwing away pending data
> > > when closing the device. Perhaps calling cancel_delayed_work_sync()
> > > and then follow up with a manual call to fb_deferred_io_work() would
> > > be enough to flush the remaining data?
> > >
> > > -Patrik
> > >
> > > [1] https://bugzilla.suse.com/show_bug.cgi?id=3D1221814
> > > [2] 33cd6ea9c067 fbdev: flush deferred IO before closing
> > > =20
> > > >
> > > >
> > > > Thanks,
> > > > Harshit =20
> > =20


