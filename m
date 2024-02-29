Return-Path: <linux-kernel+bounces-86707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6940386C955
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2704A1F216ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502E7D3EB;
	Thu, 29 Feb 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="K4OItbXt"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701076F1B;
	Thu, 29 Feb 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709210270; cv=none; b=cH93bH2SHYvaHIktCYUp9SRAo7gQQ6iBLB5caJjqbWAEE8LTLhjwcnYedXrHtidvUoMTyuF0zZVOd0z1qC32ySbSMT5l5ak4oZAvp6svICGmR+nMb7stZZcVCbo2cKb+HMB/OMqweqLhqS5jlaOcyk3ZVOGF+n0MrbKilfDS21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709210270; c=relaxed/simple;
	bh=AvGhLOoKUDqqy9KaIaDf0K9xjzbSMlNJ6ya8jzTrjSI=;
	h=Message-ID:From:Content-Type:Mime-Version:Subject:Date:Cc:To; b=HeXizdHOQnOTbFgMBhGiLuXT/oLN9c8xDLoU0FLYtvBVokGPu3l01tW9hVtxxyAfGz33Tr3IL6GsEaKYQUKr+8O4oVkf3jANLZnMgou+HAloX8c88gp2QcK03VpdZpKvzDsWSACnJaKU/pJXEcMdByXZ6Dmi1PHZPPmOeo03s3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=K4OItbXt; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709209958; bh=lPBJoIJYfKW+bOc4tNQX2WIoMB8SZ331BN+JVibczvM=;
	h=From:Subject:Date:Cc:To;
	b=K4OItbXtUVSDzD90OE2deqKL3o81qj5w/x++G126gryOJpinruIsEJsXLpUknzQDQ
	 gsrSgkCH455BoZPPleKE6LSG2XXOGRSnjGOKDDnaqsg8WgijPK6Xrp6HHWjllUOAVe
	 itTsx+Thy1I+d+axVe/WUhYcbKKOGrdaLLdsEMyM=
Received: from smtpclient.apple ([218.94.142.74])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 8248FCE4; Thu, 29 Feb 2024 20:32:36 +0800
X-QQ-mid: xmsmtpt1709209956tvfil1jbg
Message-ID: <tencent_746C490722E89EE23629C2988896C8D02F05@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jPrWLUXj9WwmoiT7Fe5PHrvoNodMCtIuEN94qQ6LfBJ6O+jPPii
	 dfrFYDRbk19ZS6ICkj668m0rWPei6Jcs0LVFh3oMMMUo41yhTSmDg6v1UqRCj3CiRZYOzjXgfv+5
	 7202rc+HsDU6Ay/wYNDgiAJ5jp5eKGEnIlNHSZ/AuagG+ekdz2B24zfPN5V6O8VxSPupLS1Ctuht
	 k55xkXENTcpb9NeGoTT+k5eWvq5pSUgUdKgsoyzfw7KW7ll5CUWcUKrQnlXpq+5XoNxXF6Y74MOH
	 ecvLkCJIVAoJ5xP9gI1PEA6iX+w4MAS1w0bWgR0D4uMQWPkjLE75XMaqkB5mGL9sq6dUhF0fg2CN
	 MyhdtynXCF46czDHAeUT4iiNZYS/mffjjbxVg1mHLiVj7r6mwlUVkB9tYHWf42D+0n6W7053fhqh
	 V0nPTQjgDCTQ0mdHLx3nEbxZ6itcLanuSXfZZZlRXXoNXB43VxekacERGawWwWs+bwiOkxnmox7K
	 TCFw11Kj6VKXt3Ia4Y2LosCc1KW7klCXvkWgpVpgcSCsUDx+YafBnImnks+7S+0PODD+93lB43+7
	 fTbd3Zh1JpQyvnHfTGG0fJbN2MD8zQ3BMrNYqAFx5izJT12ICgQS/TiyS5rhaOmKgRKowFaHOIL0
	 N6c8cBkxFZec/yinC7CaZwhCp5SSzJfAVNZ2MyP+0l5JhVMGBrGuEI4LwBYKH1YiyzSjCRxfD+mb
	 HwJtQTOSYv96n2J4t3AkV3RCvnQRWeI787F3tNiMAUkBOovDwW9QhRScauRN0/RqU+NkBqbzLl5R
	 HsAwMpiJeAvvj/jNLw9hDJUKwKUAVgiWMSv0nYtlmQ6UkZdMtbchRUuFZmcLHZlvzqe6jOpxbpPJ
	 +lwA4B3NiB2y5SYUtRZL1r2k/kPdC5PYrvchTN/1ITweYTfbCrm8pkJPNQ5xMGC8uM1xWkae54jJ
	 MR/uEAA6Ad/cVXL17DX/HctnDgUS8PW1pGpQ8MPbRkNaucl3LawlusD+holGYvq9zcXJ5J40Rcku
	 lA454eINztXv75KBEwa/KEjeBDpe5lmRtXvqo7U+g4Q+vja66salhkeOEaC4E=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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


