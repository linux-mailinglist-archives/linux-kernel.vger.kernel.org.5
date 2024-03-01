Return-Path: <linux-kernel+bounces-87939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D4086DB38
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A46B225FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF15102D;
	Fri,  1 Mar 2024 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wDx/MYGV"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4F524A5;
	Fri,  1 Mar 2024 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271762; cv=none; b=Ya4XPfVSL8w+nt/7dvQ+H/vQIpZzbdxyYmVst2qd1yrRg1r1a7GUrkUaCnAnEQ/w+TyQD0NNwY10BVxjUhQCS5jqbM/yX8zGWV/uId9qIbzPqlr3hjZJfpc4vr7FOncqEB0GDOXRa4Q5lndDnSxhUsEhz3ti1rMyUnWy6yAIva0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271762; c=relaxed/simple;
	bh=V55SRGUOrAG+ysoALTc6f/0/cboBmLuqRrBCtb77ei8=;
	h=Message-ID:From:Content-Type:Mime-Version:Subject:Date:Cc:To; b=a+zOVSxbotqo9KM2qJHUSj5W1Dshhe5AKUxXWhKxiQjf290uHGxbgubXGi3usIF39oj14uxfT4Rj0gP0f6DS683MSuDcgxPWEkUspRyzM62ErouQh8E41m0dqY4bW6vqfeQLoeHcaf2t5y6BTNkGKNk/Mvbpn+L1lSmGG7a6elc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wDx/MYGV; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709271450; bh=qZXT0P42bHzo0PmK5eOZmbcv9JddLo3kkS/Aj42v6Ng=;
	h=From:Subject:Date:Cc:To;
	b=wDx/MYGVIjo9Ut9LpNZ2csvlbctH9MgMPKQKjq62XhIT2d75AxJj0dPX3Spt2D6nO
	 7S3utlEv3rl0zWIWvwkjHsMQ6XuGIn4AQvVcqHM4/4TndwmER3FqN+96cFCXWU1ep/
	 sr5cys98vcXpi7b3mAMya6DRq2wsRHfmz8Uu9Lpc=
Received: from smtpclient.apple ([218.94.142.74])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 95C29000; Fri, 01 Mar 2024 13:37:28 +0800
X-QQ-mid: xmsmtpt1709271448t77ai8bwg
Message-ID: <tencent_3F31ADAB6142D8948E5BD02B854ED2A77106@qq.com>
X-QQ-XMAILINFO: NwOS7QznqjGThWe5KOAADO7w6ppx5kSvb5GFYiKExrv+90H4CdxCHzO14Nezmu
	 fEdXL9Vp+ba8vkHos46h1O84dpTmzydLPyCC5K/8GuX6ke6h3ZVY52aNnkz7uoltBsJF58Xxjh3t
	 p4i9wGNASn7i4lrVx5vaW3bq90K0KSKzjE5pgjihZWvBvnaJkEhbMZK7C4dqo/NA8o9K6f0EzLeI
	 UnOC8P5YpHOXXIS4nillSU/TQVmFPaIWYmV3IaQsXYOT1/7AhiQQC+/6P2vyBAtPVcEVCf6p6ftH
	 fy2RnNO26ZMONSiK3aICSr0JzL5J9dxYW+K2o+kMAA0vWueCenyxB1KJppzk6pnE8tRv+oLq1Kc6
	 YzaFGUf/DY+vi5gnvSyRKmT1D5X8m/GVLqysdnoKCoBRVzXF/K0nnmC9PLihK9CFIi7ggxH7qQHA
	 8JhZnTJV6GUP3kpp4Hd3UJ18BVaRq8in1Z3Je8BxMsnVSJ5XeP/WhMhQ0dbRA8rLkV7coHlNEvCM
	 hVj8TBshdzO3vJKfsycgOONRaPKLjzBb3vc4v3sIYUOR0unOg9lnI+tJU1kN+Sc6yjfCaX+iTd3M
	 xTOuV6/2VsFbA0MRH/l8KoZJpAsfwmbSIBQ+0ZX+CatYrbXYdNgVAKqCb28QRZsZ8H7iS9e3Npg4
	 YfycQtCiZ4fJTsdaR1C9CSNPigJ1BY++qG84630E45udQ2i++n0VSIIDUHdO4zAG7gumCCUUZCc7
	 kdugCsu5uG4SGPVjuQ9WsCHf3BfOUb66FydeglzW+wtNVfRYmXpaGBPU7rznhluVzplp5IoST8ar
	 gT10K4bTmf+oD6TmKHWaw4XSZxKuz0TWQLAE3bocINKe8jn0zGrSdmdNo1e2FEOLWV2Kb2xY9HSY
	 ASR3yNGwTwMHSwFDet1AHGH0X+Q/iPFCP1SEqaMn7pOkhPC5UTROnFmykQ1qpf/Z0qeZny73uv8z
	 S1OVDVQ4tYhZ+YBV/reKbqP0bFkBtspFrglSi6a7bMhNossz6lqfMyBwmVSQ2F6CJqgJndtz+lxs
	 vYcFCZ4w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: linke <lilinke99@qq.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] ring-buffer: use READ_ONCE() to read
 cpu_buffer->commit_page in concurrent environment
X-OQ-MSGID: <53443CFB-3969-40B4-91B6-35DEBDD0559E@qq.com>
Date: Fri, 1 Mar 2024 13:37:18 +0800
Cc: lilinke99@qq.com,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org
To: rostedt@goodmis.org
X-Mailer: Apple Mail (2.3774.100.2.1.4)

> So basically you are worried about read-tearing?
> 
> That wasn't mentioned in the change log.

Yes. Sorry for making this confused, I am not very familiar with this and
still learning.

> Funny part is, if the above timestamp read did a tear, then this would
> definitely not match, and would return the correct value. That is, the
> buffer is not empty because the only way for this to get corrupted is if
> something is in the process of writing to it.

I agree with you here.

	commit = rb_page_commit(commit_page);

But if commit_page above is the result of a torn read, the commit field
read by rb_page_commit() may not represent a valid value. 

In this case, READ_ONCE() is only needed for the commit_page.


