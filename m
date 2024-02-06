Return-Path: <linux-kernel+bounces-55723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB5A84C0CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE00B25B66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122481CAB3;
	Tue,  6 Feb 2024 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur6PL279"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0BB1CD19;
	Tue,  6 Feb 2024 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261690; cv=none; b=iY/ji/7VPiwVMNhRtiGrKErbIQ+saOSuPQMmOTGjAxvElRlngqIy324BqjTF189+Jl9dQLAW6BppaSoqObaMp9p4i0ebmZzrWw0ZAhhGRNxtyAR+acDkMRebjCUikL+IWpXAN0NEH0kuywKwKefVa8ayHFuTFy07y5o1/KWRYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261690; c=relaxed/simple;
	bh=ithrnW7mrAUwgzefWAlkisiO97xAaMWaVn7JYX2tYuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQEVGDydl8JVJs0iRbhhaDhTxkjqj5ef+6pkZqCT9GqRuDu2MI6ePpIe+bzGGt/V1g9CaOR6pXn/qPVyQvGTdjzu0zp2l1ER71uom+YYPc4jnF6RgCZ4CBjHy71iv4XGi88FHqfLooQ5OqQT9grtv2/HiR+xfBtPBnT2rcO0ffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur6PL279; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69075C433F1;
	Tue,  6 Feb 2024 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707261689;
	bh=ithrnW7mrAUwgzefWAlkisiO97xAaMWaVn7JYX2tYuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ur6PL279EzOqkACouJUT1+NEejB6pR2/B+UmPX4aDMUq0B4xftyGUNy1qtB/ApPJR
	 +s/NKRjyqDDkteKaEqKfLDes9+B7Jtyam6MLKm7HU3nyMNmXId5kZZmHOKqf/6hwUD
	 qXXlRAnRKZvFjrxcQRB2Jj62sX6RkEacqKVJ861BgLomPDLXTyTGCRt2ttST0JxnOk
	 VbGXS7Eu14TyShXSGKXQ1m9l3nCOaGejscWqBIyOvOMQgAmiHuKVzK2uulDjedYQx4
	 G+367LOoCM7u2epKasAl1X6/XXmMgsiY2ZMzWqispNj0tbjfBjBRfttWCMYsoVzz6d
	 G7krIZuvpjvWQ==
Date: Wed, 7 Feb 2024 00:21:27 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] s390/vtime: remove unused
 __ARCH_HAS_VTIME_TASK_SWITCH leftover
Message-ID: <ZcK-992HhIrSHOK6@localhost.localdomain>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
 <b3623605ba5c1d386d8f59e17c930ca2c3cca07c.1706470223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3623605ba5c1d386d8f59e17c930ca2c3cca07c.1706470223.git.agordeev@linux.ibm.com>

Le Sun, Jan 28, 2024 at 08:58:52PM +0100, Alexander Gordeev a écrit :
> __ARCH_HAS_VTIME_TASK_SWITCH macro is not used anymore.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> ---
>  arch/s390/include/asm/vtime.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
> index fe17e448c0c5..561c91c1a87c 100644
> --- a/arch/s390/include/asm/vtime.h
> +++ b/arch/s390/include/asm/vtime.h
> @@ -2,8 +2,6 @@
>  #ifndef _S390_VTIME_H
>  #define _S390_VTIME_H
>  
> -#define __ARCH_HAS_VTIME_TASK_SWITCH
> -
>  static inline void update_timer_sys(void)
>  {
>  	S390_lowcore.system_timer += S390_lowcore.last_update_timer - S390_lowcore.exit_timer;
> -- 
> 2.40.1
> 

