Return-Path: <linux-kernel+bounces-37476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB5683B100
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D31B3688D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65B129A7C;
	Wed, 24 Jan 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="YTSJPYIx"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F137765D;
	Wed, 24 Jan 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119156; cv=none; b=EGF7NZwnwGAEx86xFzI0nkA/J2sqL6R63EQ6ut3W6mtmrI10Q5FG77NbHacRBSfkEeZesT/nXp80IM0D9KSt+iXhmLylc/ARCzF0txQrwm8d9PUyd0nCgbn/XWVdKeznNn4+hSoNZYBl4BZ48hEA0Sxc85IBwi0BLCSyBRiMz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119156; c=relaxed/simple;
	bh=lWzdvAHI0AUGKdM87ib+Hx1DbBZ6CPpgnwoLhZD6oZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu8MGaqPR0YBC/fh7lMcXgAG4R/7IM5teSBNRFR41+E2riYPxUj1UVspvyjaHkj2VkcbQt8BQx7sflFqlIV8+CYYRVJ0ObKZ7Q38fmbaLglU7ZJEAc4mwcCKMVr3CUFJl27MTVSqyZjxF2Gt2LaoceC2tbrN4t5qj/H7JO9HVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=YTSJPYIx; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=fMDr0QgETAeZqzF36U9g1hh7lAixkqmCVEiFhA8alDA=; b=YTSJPYIxwhWkZZCWRXnPBqV8De
	fWoFZr5SIzQMCJHPdF6qpGZq4q4bskC5OY9KsB+0WsDoR9fmzyItMSYxijCJoYbarhGNd42qO6Qy2
	EgMhF+6Htr/lLFjhjy0BynBLR3RLWmUkhVdcvHrzgcVXluEH83Kgc4UCloBRkcNZYIMVHX8TZ7MqR
	u4dhIinqD7HWslLsfSuPp9Brd/LmFgZRL8EfkyjoT2Q7yaLT9lHIOL6LOVmcDFqyl99pijaC8TgFv
	F+S57kcqcBGEPFFivMhdLLtuIhqO6Hxo6C3WlE0sza5uw9jIhSVcEEzu0V9SUcbG5MyzT5GC1HIC0
	7o8QurWQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rShWr-00EKOM-1d;
	Wed, 24 Jan 2024 11:59:13 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject:
 Re: [RFC PATCH 2/9] ntsync: Reserve a minor device number and ioctl range.
Date: Wed, 24 Jan 2024 11:59:13 -0600
Message-ID: <4892238.31r3eYUQgx@camazotz>
In-Reply-To: <2024012454-cosmos-sprint-7db7@gregkh>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <1875326.tdWV9SEqCh@terabithia> <2024012454-cosmos-sprint-7db7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 24 January 2024 06:32:13 CST Greg Kroah-Hartman wrote:
> On Tue, Jan 23, 2024 at 09:43:09PM -0600, Elizabeth Figura wrote:
> > > Why do you need a fixed minor number?  Can't your userspace handle
> > > dynamic numbers?  What systems require a static value?
> > 
> > I believe I added this because it's necessary for MODULE_ALIAS (and, more 
> > broadly, because I was following the example of vaguely comparable devices 
> > like /dev/loop-control). I suppose I could instead just remove MODULE_ALIAS 
> > (or even remove the ability to compile ntsync as a module entirely).
> 
> Do you really need MODULE_ALIAS()?  Having it for char devices to be
> auto-loaded is not generally considered a good idea anymore as systems
> should have the module loaded before userspace goes and asks for it.
> 
> It also reduces suprises when any random userspace program can cause
> kernel modules to be loaded for no real reason.

I think there's no reason we can't make loading the system's problem. I'll remove it in v2.



