Return-Path: <linux-kernel+bounces-82242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC887868100
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591511F2DF0A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2409912FF71;
	Mon, 26 Feb 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzFxYvyj"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711312FB3D;
	Mon, 26 Feb 2024 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975762; cv=none; b=DHAjK3F63Awy1CDuj8Ra1bPyAkjBRLCd7ren0Hwnkye20NIR3VuJRNTiVjD6hIJjuc9hV5CD62IfKQszfxb3nN/pisntT3gTAE9SFtMpb/mheiSXzF3D0y7uJ8SO8E5zIQAFkB80xLrj62nIhdZn8vbXKmA64LdFmMUU4GkMJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975762; c=relaxed/simple;
	bh=pzn0ZncNBxfqWLhJOjD6jRvXY1I6BehRr4oC5jt9FXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBCnUpi0zPK0e+6sbqyiQP2ijdqxPdO6hgF0B9rdAYCFNrptoqZZHh4hx3mFRfiqmUqLILiGsMNmHsNzl4JFwNFPEb9DhhISg8c1wOFNmO4g89RJWusesCY73GZmZrqZTI4w2QHu/YeNis2aQvh2X9MmO0LzSsJNlwiM394i4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzFxYvyj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso28713335ad.3;
        Mon, 26 Feb 2024 11:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708975760; x=1709580560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPWdCKuKMXOCg7OdGv4GkDBEzhKQAW9zONsmjZ4GyO8=;
        b=UzFxYvyjqlNDlNxn+CBxubpdlIQtBEmDHMRKJa1ZKVDoG2J/+w/THL9tu2FIfo2J4u
         FzP/PNtF5595BxMqki8pVxYO7///6EP1EBr2jCpLAnZhsjX38lfkG33GBHje6/zPRKES
         9uUGvR5dCtc/dpxgQZRiaAuR8hkrpvrZcsTdQ78L4ZBrIrCm2tz6VpQQBcCsTpynupr2
         H3Pj4QdxS+1G+553vc3TFvqK9nTFNuo7N4Q3b4wX/La4Tjp4bYtLEPXqDrsDOXqXQjpc
         kco1N127S3jRu3NCvuFGpTr/qmyYLybn4B+AqPQ8HQWFF49OwW2blWzcCuovVHCqFobv
         L8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708975760; x=1709580560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPWdCKuKMXOCg7OdGv4GkDBEzhKQAW9zONsmjZ4GyO8=;
        b=cjUlLxpT4iokFebQu/n2RoRqLfMSHyZmsmal0g4aP3MTOivI9lGUq/aQg1ahsYYzBT
         yx+MdZFewzub4KyR7B5SiD1LaWI3p8v4s8cS6iZFOZLzauZjmwsNa8U7f5uSwwjt6a3H
         Wuft/ZDHCkNCiXfECt0xuiGaupf6GYy58oREnFoBpiqfd2mX124FyGgxBnOsrm3+6vg6
         3jN7uMOt4IxykPE4RkztdwPilR6Krn4yYEY2Wj254Uqt404kGRPTfpZJyPGUayXX/ka/
         Y9rrHWb/HqJ5mPR7n7xZCbPmGC9QS030v7WQ7nk5J7u7gqNtunakz/5s29Irk2CELPiL
         dcCA==
X-Forwarded-Encrypted: i=1; AJvYcCUGyi8sL984h9r/hc2DWPS2CJSgEQBean8cLywl0J1q2aDf/UBOm+B8AXzR67NL8xITCPREo5RQN9cFkJ0vlYLFbT28YU1rwbsOW11F
X-Gm-Message-State: AOJu0YwPK/FxUSbRLN9qZDRxhw9vCalJEgYYo+6Uq2o9Low1g5QQ+gZp
	dYPrZeZoHtSl97xqeUF0O0yyc3Ckc6TjSPRBbKgi4tj04KycUSf4odCRP6J+
X-Google-Smtp-Source: AGHT+IHDtyeLzOkphtZJk6Eeb7FQQuG/gJNl59TE4WnV+2B58WYwnXtDV5euQdYCyAhb4nipKAs2lg==
X-Received: by 2002:a17:903:1109:b0:1dc:63b2:7c2e with SMTP id n9-20020a170903110900b001dc63b27c2emr7796425plh.31.1708975759752;
        Mon, 26 Feb 2024 11:29:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l20-20020a170902e2d400b001d71729ec9csm47824plc.188.2024.02.26.11.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:29:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Feb 2024 11:29:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc/unaligned: Rewrite 64-bit inline assembly of
 emulate_ldd()
Message-ID: <d5c6f6b6-e65b-4928-912d-464b9f2f6661@roeck-us.net>
References: <20240216073315.3801833-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216073315.3801833-1-linux@roeck-us.net>

Hi Helge,

On Thu, Feb 15, 2024 at 11:33:15PM -0800, Guenter Roeck wrote:
> Convert to use real temp variables instead of clobbering processor
> registers. This aligns the 64-bit inline assembly code with the 32-bit
> assembly code which was rewritten with commit 427c1073a2a1
> ("parisc/unaligned: Rewrite 32-bit inline assembly of emulate_ldd()").
> 
> While at it, fix comment in 32-bit rewrite code. Temporary variables are
> now used for both 32-bit and 64-bit code, so move their declarations
> to the function header.
> 
> No functional change intended.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Implemented while analyzing a bug. I am not really sure of it is worth
> the effort, but I figured that I might as well submit it.
> 
>  arch/parisc/kernel/unaligned.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
> index c520e551a165..622c7b549fb8 100644
> --- a/arch/parisc/kernel/unaligned.c
> +++ b/arch/parisc/kernel/unaligned.c
> @@ -169,7 +169,8 @@ static int emulate_ldw(struct pt_regs *regs, int toreg, int flop)
>  static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
>  {
>  	unsigned long saddr = regs->ior;
> -	__u64 val = 0;
> +	unsigned long shift;
> +	__u64 val = 0, temp1;
>  	ASM_EXCEPTIONTABLE_VAR(ret);
>  
>  	DPRINTF("load " RFMT ":" RFMT " to r%d for 8 bytes\n", 
> @@ -180,25 +181,22 @@ static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
>  
>  #ifdef CONFIG_64BIT
>  	__asm__ __volatile__  (
> -"	depd,z	%3,60,3,%%r19\n"		/* r19=(ofs&7)*8 */
> -"	mtsp	%4, %%sr1\n"
> -"	depd	%%r0,63,3,%3\n"
> -"1:	ldd	0(%%sr1,%3),%0\n"
> -"2:	ldd	8(%%sr1,%3),%%r20\n"
> -"	subi	64,%%r19,%%r19\n"
> -"	mtsar	%%r19\n"
> -"	shrpd	%0,%%r20,%%sar,%0\n"
> +"	depd,z	%4,60,3,%2\n"		/* shift=(ofs&7)*8 */
> +"	mtsp	%5, %%sr1\n"
> +"	depd	%%r0,63,3,%4\n"
> +"1:	ldd	0(%%sr1,%4),%0\n"
> +"2:	ldd	8(%%sr1,%4),%3\n"
> +"	subi	64,%2,%2\n"
> +"	mtsar	%2\n"
> +"	shrpd	%0,%3,%%sar,%0\n"
>  "3:	\n"
>  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%1")
>  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%1")
> -	: "=r" (val), "+r" (ret)
> -	: "0" (val), "r" (saddr), "r" (regs->isr)
> -	: "r19", "r20" );
> +	: "+r" (val), "+r" (ret), "=&r" (shift), "=&r" (temp1)
> +	: "r" (saddr), "r" (regs->isr) );

It looks like something went wrong when this patch was applied. It is now

+"      depd,z  %4,60,3,%3\n"           /* shift=(ofs&7)*8 */
..
+       : "+r" (val), "+r" (ret), "+r" (saddr), "=&r" (shift), "=&r" (temp1)
+       : "r" (regs->isr) );

meaning saddr is now %2, but the depd,z instruction
still assumes it is %4. Unfortunately this results in a crash
when trying to boot linux-next on parisc64.

The patch below on top of linux-next fixes the problem for me.

Guenter

---
iff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
index 31974eddedc9..a8e75e5b884a 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -181,7 +181,7 @@ static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)

 #ifdef CONFIG_64BIT
        __asm__ __volatile__  (
-"      depd,z  %4,60,3,%3\n"           /* shift=(ofs&7)*8 */
+"      depd,z  %2,60,3,%3\n"           /* shift=(ofs&7)*8 */
 "      mtsp    %5, %%sr1\n"
 "      depd    %%r0,63,3,%2\n"
 "1:    ldd     0(%%sr1,%2),%0\n"

