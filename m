Return-Path: <linux-kernel+bounces-86706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9AD86C954
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA167B239B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FDD7D077;
	Thu, 29 Feb 2024 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UfIgf3Km"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6D76F05;
	Thu, 29 Feb 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709210269; cv=none; b=cmqRMdIKjUqIEMhFe2Ld+fAIjDK8jRNExECy5Ao0vQI7GNxJk37ovf+cZABdL3EkUFIiqqo+0KHUVIL/6HkF+A1YasezaX3yFeSYRNIDl/zECyx7PlccNLrEplrFz8tMlKd0omBKCAQ6au81H7btysuzbKf68fiBSjr4NrydP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709210269; c=relaxed/simple;
	bh=AvGhLOoKUDqqy9KaIaDf0K9xjzbSMlNJ6ya8jzTrjSI=;
	h=Message-ID:From:Content-Type:Mime-Version:Subject:Date:Cc:To; b=SGKrUKsGnc1JRDlk27mfLQoQApM3MbiZfQBOQU0q3QA9n9s/89JrRPDnSQ8C+7XIdvdeYElWIm0xNmprILC3+5vhFoXSNMS4hlWja2tilBvGrSjrQyx5rWY3cKJUntuUwsnJlNGJE8bXxPjyqa8Fbjex3HbC56Xn9lMUIdJXO5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UfIgf3Km; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709209959; bh=lPBJoIJYfKW+bOc4tNQX2WIoMB8SZ331BN+JVibczvM=;
	h=From:Subject:Date:Cc:To;
	b=UfIgf3KmujDPPt2xcYGFQac0hClYHXxvLiUzYEXGEm89RkeF29h6S6qAFOcQmA0tj
	 kmDrkdUMFLvzgMiArt5SP5iIcCSTecJ4V9uKtg8TV2HODZvfbWwQnYNQ8b4X11FdqO
	 uGpquZcJ1Crt5HZciFaxDUuwNYg37PWx67EFZQus=
Received: from smtpclient.apple ([218.94.142.74])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 8252F8DF; Thu, 29 Feb 2024 20:32:37 +0800
X-QQ-mid: xmsmtpt1709209957teuo37va1
Message-ID: <tencent_BE8C3169030CD9C2FC7548832C2994921609@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69bGzgJtECDds6/nBj/Ojn+MmGnB4elv2o+9w6ZjWjgPjupNeCpb
	 oqk2T07lzH0A2x4hEbC9CQN5fz+v4j5Dy6yAyQrDz4dyfD1QwBODHR3dDNN+YtCzGUc0XxHRqeG0
	 xW44ORYQBvxlFg46JX6WQJSl/Z0X8PW7XldWsVPnd0ocoX5ip8sBJyMPNl4A1f8nSggUf/n3OZtg
	 apT5OZnanWbASty0e3uWd3McIHvqjhfxB0l0V/TTFwyu5Gy04CUkP6Stb1d+w13pyVdWd8l2Yai2
	 3u9T9M8ApniAWhV6zYB8vVb+IXr50E7XgduxTfkCZ98TNwP0w260LePn9eM3FANpHVBOvRB6CTqg
	 hR5/8pVFg9yzZKUeGe/8GVejN2RlfIYoRa+YlijKvleLio1A3OZXevDCnFtgdJKQW5NCego7R3oi
	 v5ma5eXcThgg7uyGka0glU/Uyk2UkZXtN8QtOh0G80sEbUn9vURs0ytoGzs36hIMPQN1yBYVsHBe
	 zVVys2jon1ofQl2uKZjLqtbwTaWK2jhLYyqbvCgkP7179Lge/KC332vZ+xH1ilNXoua4ZcAwix5E
	 pBdSwdNzsuUHgi9OWcKj6LxvBNHjlgfBJ6Bw+E6GvlYHL//WXjAJWm0MOlSicjk09teM9VdPdTO1
	 8bxPVfS6ZtmA/PDRh0T1wtS1sSH0lJBYSEJ/UMi0CJXQUxOh6uJKdnO4YfLOrBXNeaYnSFoaplg5
	 vXE5q4QyJekrUEQdsCKieqgyKU7wCraKIMlnDPQDln+GCiJoJsIIEs8ZmIc+FhlTOP4cLu2NW97o
	 y3HlU+729fpQbbADJhI4lMHYgTluYwc19eZXBTb8AUCsKG86xCsENJ8T89PJ7b/0278dpMaSjxrz
	 73PS+UHD/rUSkRwBsDAtW2Kjx0cgKEkr1EsLVrt8YFH5fsfd5cdCjSiXRajuKxftZT6mBDfTbmWQ
	 rON56AoaF3Sw2NGWMihM925LIlUPD4F7hr6+boHPNg8ZmJ9dfVKHSHvdWZVAstcui5mrwSK1TqRn
	 0HGq/efY1TPa7Ji1zp1hrExd+8Dnb+8RmG3ONDQ/2EgIKLR+Zi8/bYCZZscWnO77KUv++rqbHiKe
	 qGqfnlmjWojYZQ9X4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
X-OQ-MSGID: <ED746152-3258-443B-BDC4-B968D05002B4@qq.com>
Date: Thu, 29 Feb 2024 20:32:26 +0800
Cc: lilinke99@qq.com,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org
To: rostedt@goodmis.org
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Steven, sorry for the late reply.

> 
> Now the reason for the above READ_ONCE() is because the variables *are*
> going to be used again. We do *not* want the compiler to play any games
> with that.
> 

I don't think it is because the variables are going to be used again. 
Compiler optimizations barely do bad things in single thread programs. It
is because cpu_buffer->commit_page may change concurrently and should be
accessed atomically.

	/* Make sure commit page didn't change */
	curr_commit_page = READ_ONCE(cpu_buffer->commit_page);
	curr_commit_ts = READ_ONCE(curr_commit_page->page->time_stamp);

	/* If the commit page changed, then there's more data */
	if (curr_commit_page != commit_page ||
	    curr_commit_ts != commit_ts)
		return 0;

This code read cpu_buffer->commit_page and time_stamp again to check
whether commit page changed. It shows that cpu_buffer->commit_page and 
time_stamp may be changed by other threads.

        commit_page = cpu_buffer->commit_page;
        commit_ts = commit_page->page->time_stamp;

So the commit_page and time_stamp above is read while other threads may
change it. I think it is a data race if it is not atomic. Thus it is 
necessary to use READ_ONCE() here.


