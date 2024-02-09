Return-Path: <linux-kernel+bounces-58984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E584EF62
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF78C1C24587
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6555224;
	Fri,  9 Feb 2024 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPeGJngs"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFC4C89;
	Fri,  9 Feb 2024 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707449307; cv=none; b=LaW8YNpDWgmV97TiQOR83/yDWTEdNpbRYkfQU/9XILem2QjJg+UOBjT7YmNDJwt6+rMP/nynFSAZnk/LX3A/agyoNsLFKOAkPEbmtISIiVskYQSQtW2AATJ6+/3XeDKFSjEJP10DWcWhEcr0lxbnf+hkjP4uW1skrDvAcIZX3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707449307; c=relaxed/simple;
	bh=CYznSO5r46Xg1mZpeUUaVzvXR91pHRON+4IkH9LSpEk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=PvnTx0YBtXuGFTrx1ch8oYPTsT+Ew/0/YoooD3YUGWmyRS1g4/awCE7R3SxDhheqkBtQUx2dKWbLIqxDtLqkzUhW4eqBQYqrA+pRsdCj/82Ss3j2ynjJr9CBbqRidk655JOZ+R7pUadczvSjhzMlIVexp0aRJ0nhsjIz2U5Cxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPeGJngs; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2191b085639so183742fac.0;
        Thu, 08 Feb 2024 19:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707449305; x=1708054105; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxzGG9tiVnG9eoQG9HjEplP7zHqtFTQIBWqH3c45mMU=;
        b=DPeGJngsUUFmjyzRm5OBIHdubFiSNU/K3vRFFXW6yAoeYInDSGl3fSzmgG88xjT+Hc
         JUVgjoglUQT76iZ1lIg5B6eaZlZeAEoa+FYexho6aS18a0p8RWDZmp/3JZag8Ds+UUac
         pGBg3h7g59jeeEAJ64+wZANOwZ9aSTa3kvqlYFRAhMQkqTTCeEPnrbTcM6Wb3nqrp5C5
         R9Ar7e6aCsSJTrBkpDXmIYaqIKqUJSVVLfS13nG2y1DbQqhe0+DkEj4wu9i9w2QtsAK4
         kod7bKQb97l0IodQBo71z48NGW0rpJQYEQaOjXkjrrxMNrhE2UNSRG6e8M/f/aGXwf4v
         L0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707449305; x=1708054105;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HxzGG9tiVnG9eoQG9HjEplP7zHqtFTQIBWqH3c45mMU=;
        b=vDr0GZYPjiW0wBVOuT9vTL7tyO0/TrehS09HSDkV3ruoTcdoqGi1OHsc30oK1ErULH
         kKTsqFFnsguanU+5bBe7xNBD+JT1oDXHXRBX4SpCq3MnXmE3e3HKGZ+GUiOVjdorEEKY
         HUJui/+v213uTUkU/ZyPA9a5MhYvp28FmPCG6wY/EgxbceN/wH5dR4/qWA1BWg2qXf/m
         +iI5at6afawFDTshwjtLaGY9uYQsyLnbc6B7JA8yOoHYPJlWNu23FBgiwaDvt+ywjuYJ
         vGhhGmLRxbv3Ge1WVsCAAxn2c6t9ijQZdPy9wEd4cPUpMSC42MBrEnZhILgLluJZdRXb
         mmQw==
X-Forwarded-Encrypted: i=1; AJvYcCVS5iRqYJcfVkn13eGm8+xWzrFK4xls2k7vVGboNLxgLmgopDsSCXUnUlm/DdnoqWby78waV511wQArTaYjtZAOCAq+O8bTF3ZjTw==
X-Gm-Message-State: AOJu0YysUeUkEbpuSyv1BGxw+Sy+T679zYWfy/bxwvatddnYlHWrOobV
	W1CHWMzLl5hxEDjNSuNp70FN2FU8SOxPBKtPJzf0HHGUg0li0mlT
X-Google-Smtp-Source: AGHT+IGJdYdAowW+FidRJBjJ5PRhE+P1LKYarWAESwpfBnD1uwZNpuEkdkLlM9TfbBRzyA0on78BAA==
X-Received: by 2002:a05:6870:c112:b0:219:42a8:5d83 with SMTP id f18-20020a056870c11200b0021942a85d83mr406135oad.3.1707449305032;
        Thu, 08 Feb 2024 19:28:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVULcZwPASQ+q6GP71T+MBtAqLWnLhugVfu4p8gmhSXuqNlEUODQuUxkyi2MEX6/l0cRKubC3JOSTZc0xPPaulE0+M39DBGhW9UnwmD7LC5KGv0u8vEQ3mmpVz4lm7Ai+truexjLt1afFD9ijiN9wUwMWdmN39tdsMwXPeMSUF7GPbHKsDiYREm6QPo5XKoOAh6LFvGDL3RMZClxq6HS6jVHV/2uHCugx+SDFEaASJB126BYDE4AH87u/Ipw0LeAGy1zpLjUdZLR6+h
Received: from localhost ([1.146.65.44])
        by smtp.gmail.com with ESMTPSA id m7-20020a654387000000b005dc389409c1sm475022pgp.93.2024.02.08.19.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 19:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Feb 2024 13:28:17 +1000
Message-Id: <CZ089ERGIDWI.14PQB4HD4F1NH@wheely>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik"
 <gor@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/5] sched/vtime: remove confusing
 arch_vtime_task_switch() declaration
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <cover.1707422448.git.agordeev@linux.ibm.com>
 <f5c88d9290bca3b280cfdd499c236a3c390af51b.1707422448.git.agordeev@linux.ibm.com>
In-Reply-To: <f5c88d9290bca3b280cfdd499c236a3c390af51b.1707422448.git.agordeev@linux.ibm.com>

On Fri Feb 9, 2024 at 6:15 AM AEST, Alexander Gordeev wrote:
> Callback arch_vtime_task_switch() is only defined when
> CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is selected. Yet, the
> function prototype forward declaration is present for
> CONFIG_VIRT_CPU_ACCOUNTING_GEN variant. Remove it.
>

And powerpc arch_vtime_task_switch is static inline too,
so this just confuses things.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  include/linux/vtime.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/vtime.h b/include/linux/vtime.h
> index 3684487d01e1..593466ceebed 100644
> --- a/include/linux/vtime.h
> +++ b/include/linux/vtime.h
> @@ -18,7 +18,6 @@ extern void vtime_account_idle(struct task_struct *tsk)=
;
>  #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
> =20
>  #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
> -extern void arch_vtime_task_switch(struct task_struct *tsk);
>  extern void vtime_user_enter(struct task_struct *tsk);
>  extern void vtime_user_exit(struct task_struct *tsk);
>  extern void vtime_guest_enter(struct task_struct *tsk);


