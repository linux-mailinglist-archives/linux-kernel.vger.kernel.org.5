Return-Path: <linux-kernel+bounces-8244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B9781B45F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF061F2565B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E206A013;
	Thu, 21 Dec 2023 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iJsKq+Xu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7736A011;
	Thu, 21 Dec 2023 10:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A60C433C8;
	Thu, 21 Dec 2023 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703155849;
	bh=iJyk8f2MowYD6uZ5ePa9utt8IglVliEpSVturMm8E0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJsKq+XunMYGBp2w86P0Rp6muKt1motWEAGG70a+Uw7bEOxpHHoRxeK2yLk0MZGbu
	 sdrLxEPw0/Sro0tRU1tCj5CukmSZZt7KW4UmCfcr5U4BobVHIZZvmjiZg3OEAq2QvT
	 wSYlYD5D9Gu646dnE/gAPp+ImsT8j2eLATnlK55U=
Date: Thu, 21 Dec 2023 11:50:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: ivan.orlov0322@gmail.com, surenb@google.com, 42.hyeyoo@gmail.com,
	Liam.Howlett@oracle.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
	BassCheck <bass@buaa.edu.cn>
Subject: Re: [PATCH] usb: mon: Fix atomicity violation in mon_bin_vma_fault
Message-ID: <2023122140-mobile-barrel-5db2@gregkh>
References: <20231221104034.4851-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221104034.4851-1-2045gemini@gmail.com>

On Thu, Dec 21, 2023 at 06:40:34PM +0800, Gui-Dong Han wrote:
> Fixes: 6f23ee1fefdc1 ("USB: add binary API to usbmon")
> Reported-by: BassCheck <bass@buaa.edu.cn>

You need to document this tool as per the researcher guidelines in the
kernel documentation, right?

thanks,

greg k-h

