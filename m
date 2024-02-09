Return-Path: <linux-kernel+bounces-58987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2571484EF6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE20D1F26340
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BF85227;
	Fri,  9 Feb 2024 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkoUgrLR"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817DAD304;
	Fri,  9 Feb 2024 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707449801; cv=none; b=EghTdBhos9dNvZK34Rf8igfUuXvTeYG5Tezq9p65DjOi9SaZHMnRDksAM03xnyCnddPynimIaSyK5BkOOIhqzrrJUUk2+mszEy1W212WLVJeUxy+az+40y+NwC7A69Zu2YONT7Iwdlth517Goo7WFdHfC6mh8hJ/xkxpsfiBwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707449801; c=relaxed/simple;
	bh=9Pd/zVI4AlseGYVYBj1em+PmDKpn2I85NAEXji708IA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XuNF5AIzAmPk0L3toR8EIdMsbCw2QNEcA1ZkUfZWRrNcWnF7M+pUzAX1B6uKobRzkA8aYMq956pGwYz+ekmBPnMQS2ZGCQUlhat52I8QP1TkYHXRBgBzv++EVYmPPo091exETqe7cNJoUThMFOZVcAhPyp5AICqRmwGQJ1GOTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkoUgrLR; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2185d368211so256920fac.3;
        Thu, 08 Feb 2024 19:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707449799; x=1708054599; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/itS1zlRQa0W3X3/sboV32WQE3hhCFnyF3AvCEPNz88=;
        b=GkoUgrLRPzCCEgB5bSVWTiaMyNs4D0vpZLZBQLvWfoaJbIk1oYRm0coe4tBp1vvd9b
         2UOcy6EeimiZg8Vi/vFPTxGXTTXVlkigY+g9GjCOncF8NQAu6IJCde+t6MsW0GxbH38O
         Lpea40DSBNBtKjdMrLXjKohfhdGdxvva6sjaUZ95Or4B143dG4b9G5mGukULyVLMySIg
         pxem5lFiABmdifhNWFg+l3ISwsJJIXI0mduJozVWWIhBRjhSM3KcPEDEXoiQGoOTUool
         /EDF/nVWoLM3Bwur55BNED3woPA80jj8tWTUSMaBZB9oR6+JT5wY+lYwK0uixDBU9dhY
         FvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707449799; x=1708054599;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/itS1zlRQa0W3X3/sboV32WQE3hhCFnyF3AvCEPNz88=;
        b=UYYVdiIYqOeVwps0PznrBj9pOJ9WOb+Z2UYyHONfG4ETXuclgS5EZjUjA0pZRqMYvJ
         E+iGiY0MD+q5T3U1D8j1s6sHDNI9tQp8PFK/kD2/ZTfPuejIiKHR2r0kKANqTnN0uqH3
         zmJ3Ez7hEeTRWfDS+jaOZ1h1Y8fdTq+P1Ll41FTo6lej36Vo+gPwPOWA1crpOa6zk2xy
         D4cKHQptZhQk1NvAiE2BBI6dlylyaSiV/JpdCgSk5XFohb/P4zH9+4q4eKkDuw63C5UB
         YNFu9i+WZ1UkoivElhicVKYEeiP/NfyeJiBCbM6SkEZ75hDXnMPY5FTe+bZqMfKzCvgF
         YesA==
X-Forwarded-Encrypted: i=1; AJvYcCVnUZ8o/6d91OYqkEu0CEVPYUjlAIajbH9loORN7p8SEYi6Nx2jLf9BF8wtF+0fuMOh+LjUt4T2yAco+WZbOuCVLrBEdkD60xlxbA==
X-Gm-Message-State: AOJu0YwkdnsZGbHYi3JBhFpnGD83ZcqIP+dZhcDmLxQxqWW+HHtqKJJJ
	IUhKQsGfGoqp1YSS3VtBmkTVttGfqZekVWpifqu030YeN3gFYzDK
X-Google-Smtp-Source: AGHT+IHl8GUTEq19JX8rNakjtBooH2UQnSMTKMAdjpPRY1T5Xru1ViOiNvOAzZ4u6IoQKt0Lx5+MOg==
X-Received: by 2002:a05:6870:65ab:b0:214:b6dd:39bf with SMTP id fp43-20020a05687065ab00b00214b6dd39bfmr461789oab.36.1707449799564;
        Thu, 08 Feb 2024 19:36:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzaoBX89atdTx3Ru9rswKCpcVDpsh2nyN0T4awqFq6gzK94W2ss1uMZjRJHSZK7vrjOiQkrZj52tD+vUCmqUeGodzRxejsp8X/azn9FqlEG6j8ZJ8H/TmUOt/oj1sNTByt2U2MVyeGF9wcLax4Yq7SpXHnrQ1oARRNmP9uvM4iNUbH7xWrnFTudD/OjWnYMg61/z8lw8pDgMR+rxilBi+LT6UxSSodwiQ956rSB1ItdL71fc0JYGCzMCGVktuFR9KLClnfD+LG6G5k
Received: from localhost ([1.146.65.44])
        by smtp.gmail.com with ESMTPSA id r16-20020a63e510000000b005dc36279d6dsm618997pgh.73.2024.02.08.19.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 19:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Feb 2024 13:36:33 +1000
Message-Id: <CZ08FQE70OVJ.397UJ8KZ89BC4@wheely>
Cc: <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 3/5] s390/vtime: remove unused
 __ARCH_HAS_VTIME_TASK_SWITCH leftover
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik"
 <gor@linux.ibm.com>
X-Mailer: aerc 0.15.2
References: <cover.1707422448.git.agordeev@linux.ibm.com>
 <2fcc4503851ef7cbb6106ba6706179605b7449fd.1707422448.git.agordeev@linux.ibm.com>
In-Reply-To: <2fcc4503851ef7cbb6106ba6706179605b7449fd.1707422448.git.agordeev@linux.ibm.com>

On Fri Feb 9, 2024 at 6:15 AM AEST, Alexander Gordeev wrote:
> __ARCH_HAS_VTIME_TASK_SWITCH macro is not used anymore.

.. but for benefit of patchwork if you decide to keep them
apart

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/include/asm/vtime.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.=
h
> index fe17e448c0c5..561c91c1a87c 100644
> --- a/arch/s390/include/asm/vtime.h
> +++ b/arch/s390/include/asm/vtime.h
> @@ -2,8 +2,6 @@
>  #ifndef _S390_VTIME_H
>  #define _S390_VTIME_H
> =20
> -#define __ARCH_HAS_VTIME_TASK_SWITCH
> -
>  static inline void update_timer_sys(void)
>  {
>  	S390_lowcore.system_timer +=3D S390_lowcore.last_update_timer - S390_lo=
wcore.exit_timer;


