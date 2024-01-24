Return-Path: <linux-kernel+bounces-36408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDFA83A03A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285D1289BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFB16FBB;
	Wed, 24 Jan 2024 03:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="JxWBDVLl"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049DC120;
	Wed, 24 Jan 2024 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067793; cv=none; b=cH3kULNR/3T9stRbL9W8LgkNKn4Q8M0BwQAk4t5gGriDKtCBjJMVKVZB1y2aYPM9pfzb9/SsH74+ptl+KLsRrE7VidR8ZRBnM9P1HD/dsEef5DXmfImtJefmqq8Nur1y6puDSmzuCs/BikJmNggUn2ofbyIdAwdDyZdRKaIoX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067793; c=relaxed/simple;
	bh=iO5HnuFMu7pUUj8dP2XGCJW3PAt14gadTX9j046o31M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9MqY+klLbRq5MoQCjPvmvE5ETXUigl6zA/nyWlzVs7I05vQpP+LEaoueJr+sQARm8WzNIlSnZpvrXuRlDZQu1bBz69eKdKjGeybkV/W6MLC28JJXSOSKHOVAgQHKzNs/gSGI2+R4Y+kKFDwvHZ7ejeYvYAPNjDf8ojOY5pasdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=JxWBDVLl; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=tGCM2n4LHRSDdt8wWKFkazewP4vabbqwENB8cy55Cos=; b=JxWBDVLlIHKlFBC3gE2azcL+TM
	4qzRWlgXwwyHHp9LOq+F9JcG9wwPjpE/6vDURVcx8Mmx3n6zqZ46bH9ttgN7+Oy/UefMz9govI6km
	TCz2RvD+xPrX4bfk0/5dT5mchyVCrXx7BVZ/8hfm3GlTo+6hz3dDkMQwebtPRswhFgBtLRoiC8NKN
	bwozwiWR7fiGiRupSCymlnD4f0mcyTFgh69JT0eLA66YmZWD788q3wp/VLxoLMqJxewXb4hY2jAeN
	rchzhO4+I+pW+VPa70d1twzLFi6qET2hBiXUTFvlsgwGPqXdaiPguODss2AgMfkUUlcQyr65QSZVo
	/xoYj8Mg==;
Received: from [10.69.139.2] (helo=terabithia.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSUAQ-00Ddbv-0s;
	Tue, 23 Jan 2024 21:43:10 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject:
 Re: [RFC PATCH 2/9] ntsync: Reserve a minor device number and ioctl range.
Date: Tue, 23 Jan 2024 21:43:09 -0600
Message-ID: <1875326.tdWV9SEqCh@terabithia>
In-Reply-To: <2024012356-dove-duke-f7f6@gregkh>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-3-zfigura@codeweavers.com>
 <2024012356-dove-duke-f7f6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 23 January 2024 18:54:02 CST Greg Kroah-Hartman wrote:
> On Tue, Jan 23, 2024 at 06:40:21PM -0600, Elizabeth Figura wrote:
> > Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> > ---
> 
> Note, we can't take patches without any changelog text, and you don't
> want us to :)
> 
> >  Documentation/admin-guide/devices.txt              | 3 ++-
> >  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
> >  drivers/misc/ntsync.c                              | 3 ++-
> >  include/linux/miscdevice.h                         | 1 +
> >  4 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/devices.txt
> > b/Documentation/admin-guide/devices.txt index 94c98be1329a..041404397ee5
> > 100644
> > --- a/Documentation/admin-guide/devices.txt
> > +++ b/Documentation/admin-guide/devices.txt
> > @@ -376,8 +376,9 @@
> > 
> >  		240 = /dev/userio	Serio driver testing device
> >  		241 = /dev/vhost-vsock	Host kernel driver for virtio 
vsock
> >  		242 = /dev/rfkill	Turning off radio transmissions 
(rfkill)
> > 
> > +		243 = /dev/ntsync	NT synchronization primitive 
device
> > 
> > -		243-254			Reserved for local use
> > +		244-254			Reserved for local use
> 
> Why do you need a fixed minor number?  Can't your userspace handle
> dynamic numbers?  What systems require a static value?

I believe I added this because it's necessary for MODULE_ALIAS (and, more 
broadly, because I was following the example of vaguely comparable devices 
like /dev/loop-control). I suppose I could instead just remove MODULE_ALIAS 
(or even remove the ability to compile ntsync as a module entirely).

It's a bit difficult to figure out what's the preferred way to organize things 
like this (there not being a lot of precedent for this kind of driver) so I'd 
appreciate any direction.

--Zeb



