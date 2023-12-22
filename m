Return-Path: <linux-kernel+bounces-9516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B881C6D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BD0B21A99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD5F9FA;
	Fri, 22 Dec 2023 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0gr5ACid";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+33bxCiP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F33DF9C8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Dec 2023 09:47:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703234856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZXloMgiRAVOPGoz8o3+D3AfE1mP2CVP2wrPR3Txq90=;
	b=0gr5ACidvRLvpLg/q2J3xJbOGrbO2/gkpDdGk+ZaIgEF/ddU+qnZZvvkYC+JUcZMHPYJV7
	Zkja0fO0kTxDqVCgmY3D08X9hkUtN0zfzvrrviW/M6Qk+I44y38FyzMgk+n0zILYTxMgM2
	FNYdEuUTeUsgPXXyUBDmUWAV90EUWNSmX7Y+egQpSvh4/iz0NzBFrPck71+RFpv3T+5Log
	hyrTJIthTPMgyZb22BvC19J9gPIj+AZiKN4pheXToc4p9PK4dSklivV55JCxRTdv1pK7Lc
	4J4JDgivMySb9RmraUznyz8SOzXCBV3uKTQmkv3CBESSkvQiMPxTPOC15d0sxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703234856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZXloMgiRAVOPGoz8o3+D3AfE1mP2CVP2wrPR3Txq90=;
	b=+33bxCiPWOX1ZNUhk68sHH7mSW0kn6EtiMx7vuWuzh7SzaOChfeVw9dryi3RAE/DZOujlA
	tdsYDlw4HUWY0mDw==
From: Nam Cao <namcao@linutronix.de>
To: Ryan England <rcengland@gmail.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Florian Schilhabel
 <florian.c.schilhabel@googlemail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8712: fix open parentheses alignment
Message-ID: <20231222094735.5554b67a@namcao>
In-Reply-To: <ZYSemFbzTlgLROMc@kernel.ryanengland.xyz>
References: <ZYSemFbzTlgLROMc@kernel.ryanengland.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 20:22:48 +0000 Ryan England <rcengland@gmail.com> wrote:

> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Ryan England <rcengland@gmail.com>
> ---
> Made corrections give the 100 line limit. Resending v2 as no change was
> made other than including this comment below ---. Thank you for the
> correction. Here's to learning with every submission.
> 
>  drivers/staging/rtl8712/os_intfs.c            |   3 +-
>  drivers/staging/rtl8712/rtl8712_efuse.c       |   9 +-
>  drivers/staging/rtl8712/rtl8712_recv.c        |   3 +-
>  drivers/staging/rtl8712/rtl8712_xmit.c        |  60 +++---
>  drivers/staging/rtl8712/rtl871x_cmd.c         | 159 +++++---------
>  drivers/staging/rtl8712/rtl871x_cmd.h         |  37 ++--
>  drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 203 +++++++-----------
>  7 files changed, 173 insertions(+), 301 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
> index b18e6d9c832b..7554613fe7e1 100644
> --- a/drivers/staging/rtl8712/os_intfs.c
> +++ b/drivers/staging/rtl8712/os_intfs.c
> @@ -221,8 +221,7 @@ struct net_device *r8712_init_netdev(void)
>  
>  static u32 start_drv_threads(struct _adapter *padapter)
>  {
> -	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
> -					  padapter->pnetdev->name);
> +	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s", padapter->pnetdev->name);

Your description claims to fix "CHECK: Alignment should match open
parenthesis", but this one is already aligned, isn't it?

Note that, because you CAN you 100 characters, does not mean you MUST use 100
characters.

Best regards,
Nam

