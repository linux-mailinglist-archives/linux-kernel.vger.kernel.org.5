Return-Path: <linux-kernel+bounces-27244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E421682ECA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4DC284753
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E38134DA;
	Tue, 16 Jan 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="uOth1IGs";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="qzYROdHf"
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [46.30.211.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6633134C7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=qDM94LF5VfoHc9kwkSM3blBUGm87Dovp97vuIUPqhVk=;
	b=uOth1IGsUTKCYwyWxHQDRJJEBpS7HCNS6ku3wNC6dZ7u+H2pTjLiuLpSDIJq0xWZWjKjLfukFLFWQ
	 pE/rkP3uTb5/vgo4h9uSKcgkTGuF3QQ5/azuL5U1WQH66OEBd+KJvX4R9Dq68tsHJsM8sf7+q/xAV1
	 CkLNUqOwZTvEiKfb4l0LC8TIoP/8L08v6eQ9LhkcHO+vNV9+40W397UqKqtK0i/aa5tkDQvp/pT8fg
	 EWoHSJxUQYipQmWHoWO8tVpYRBX49VdiYR9FjUdf1S7bZJJhfk4kPXHdxEdk7Isd0JQFictmRLQlFd
	 N96rA7dbRidXV7APY/8SRx149Ptc1cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=qDM94LF5VfoHc9kwkSM3blBUGm87Dovp97vuIUPqhVk=;
	b=qzYROdHf5FJuQZ3G1XoEZ4pzEIZN6449WCXooHVR/6asTkMTUToigYj+2M/ghlt48mev7cQusUmq0
	 TWqBWWRDA==
X-HalOne-ID: b6bbce72-b458-11ee-869b-a587b82ce961
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id b6bbce72-b458-11ee-869b-a587b82ce961;
	Tue, 16 Jan 2024 10:19:23 +0000 (UTC)
Date: Tue, 16 Jan 2024 11:19:22 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org, software@gaisler.com
Subject: Re: [PATCH] MAINTAINERS: Add Andreas Larsson as co-maintainer for
 arch/sparc
Message-ID: <20240116101922.GA369960@ravnborg.org>
References: <20240115150200.513531-1-andreas@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115150200.513531-1-andreas@gaisler.com>

On Mon, Jan 15, 2024 at 04:02:00PM +0100, Andreas Larsson wrote:
> Dave has not been very active on arch/sparc for the past two years.
> I have been contributing to the SPARC32 port as well as maintaining
> out-of-tree SPARC32 patches for LEON3/4/5 (SPARCv8 with CAS support)
> since 2012. I am willing to step up as an arch/sparc (co-)maintainer.
> 
> For recent discussions on the matter, see [1] and [2].
> 
> [1] https://lore.kernel.org/r/20230713075235.2164609-1-u.kleine-koenig@pengutronix.de
> [2] https://lore.kernel.org/r/20231209105816.GA1085691@ravnborg.org/
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

It would be great to have an active sparc maintainer.

	Sam

