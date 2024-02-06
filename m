Return-Path: <linux-kernel+bounces-55619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADAC84BF0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA9B283627
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA471B94A;
	Tue,  6 Feb 2024 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOAIBZD+"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C031B942;
	Tue,  6 Feb 2024 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707253857; cv=none; b=YjzoRWgywyt0wrleupCxul7bgvdXug+0wqyWpzkN8w9CjmKXSqHOFJb58bQ4z2sNekyYUB6XZw8sozxcz+jRRKv+blci5v3/L7yxqmcszK+xU2lhIdlRZe2Qvm9dmgLSJ500i7ETxyyc366AKQdlixqI4xSXSbuiq9KgIwpmCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707253857; c=relaxed/simple;
	bh=MwlTw10rPAhB4gGj/ejIVT9F0dRB9CnZoireiK4aYIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayPpRu3ifU1IZKgnQl9lBdo7H5uribWFXVefrhJ2+/6dGVuGbN8NcINs0ZAq0Q6OKqGjOsHzocoMoDeYLR6b5pQaZE/ySHXsCCp3+Eu6I+/N1wJ4x9VodPdCPwYI6dohY2IGx7CPZlCFV1PnSfhcL4US6vWRQHkAaZYSqz5DwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOAIBZD+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60484b96cd7so5331997b3.2;
        Tue, 06 Feb 2024 13:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707253855; x=1707858655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO1bsPmumajuKPIDkj+daq+YcseSKA2zflG+/ZF7sf0=;
        b=JOAIBZD+8Con3xj7qyYFEsyX6TCl0LuMVfaspXUuT7/oo+0TTQnkO69iTkt20vOnz3
         kAe0xN1oTKTTE1KQmULyHKug5+vIPseXo8rT4mus/REa+YM7xvPeeVE3tpQ/keGOxR5o
         v1hwrkHGr6sjCy00Edh7pPf+gw4ot0Xf+MIes6KZiqT+W8J98iAUYNW20TqRYxrJNXeC
         2NXKKHA31gyaDCq45k+mSs2MFgfeH2EQm0PQM70+pHq8BYUTScClcu/bEITen2nH64hn
         l9VsE6k+CaiOFOnM/NVgdfUHFG8sE4WBTU2Vc2Ig1G3HRdK/bluc9/ofwuGsKJsYcMyO
         NBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707253855; x=1707858655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SO1bsPmumajuKPIDkj+daq+YcseSKA2zflG+/ZF7sf0=;
        b=WLziR96sZiwMdmPnAcCWMNlKDD5PJp9sc48EJiSezQC03xpaOJDa4Bo5Lnwi/qdYeA
         LiOR1q4JjqxEMguFSGX5zpC1EZxiVT7iLz1z7ulldy+lcmXiaJq7ZvemX7u7HlY9/6eR
         7GLpktTKd8nBcLWumnrIyRqSnWny5BVqD7AFuJhxrI9xvRDGEADyakjOwjEi8E1V6wtl
         dtLAtBTEF2jtxKro50oKd/qJhe35Qh/CY0LkvQ3LVW+QUMHhoFZzOQEXzSfYCpnvVIlE
         r65nkf1d0dBBi71O1Rs6qUsJvnxcnXzjV2yRMutQOm4SKa1SyMIncRbUMB1NTR34qcBu
         3TpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL9AbBtYnnWYo8BN0AGxJJ47xiZj1cRurM1bescMEa9nKiKSM+Z7nT8FBuUbDMSZDOt/87/qnsa94s28yrusbEGTX1tf4yUCGpGKJTyIrEih32X35BgwxUS1sY3+vxktOFDHpp25c1yfmcJKekV3w=
X-Gm-Message-State: AOJu0YyJ7KmGn4WEwV7QFPjWNBvOr/9tKJdBb2chiXBVHyV4tYpEtVfk
	u3v86PisnjTlAeR64ktNzQDucb6EYf+D7HnsnsJ+29Kk3UeIyzh+LcPaC5k3BudyirsLH7T1bwj
	Sa/32x41IlKXb2ojlXjQRYPcVyLN8aJOOc5Q=
X-Google-Smtp-Source: AGHT+IHPzYUv7iG2mfe+GTxvQSrf4VQlKX9EmjPIaOqM80iPhazir8BocNTo5U/vWuLLZdWiljVwO39KLm8tqsnwS9k=
X-Received: by 2002:a0d:dd51:0:b0:5ec:aaf8:39bd with SMTP id
 g78-20020a0ddd51000000b005ecaaf839bdmr2990858ywe.36.1707253854582; Tue, 06
 Feb 2024 13:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205105030.8698-14-xin3.li@intel.com> <170673569232.398.15041548048531772130.tip-bot2@tip-bot2>
 <2A59D51B-0AA0-4DFC-9957-67CC0C9E37B3@zytor.com> <8f260a93-08f3-48af-81e5-8ee53246e262@zytor.com>
 <D64A7458-15DD-4B92-975A-9E4ABD96CAE2@zytor.com>
In-Reply-To: <D64A7458-15DD-4B92-975A-9E4ABD96CAE2@zytor.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Tue, 6 Feb 2024 13:10:18 -0800
Message-ID: <CAMe9rOog8r_qR1PBb-W3G+ma5zUX+YDeR3QnuE-xU3mL_=ywSg@mail.gmail.com>
Subject: Re: [tip: x86/fred] x86/ptrace: Cleanup the definition of the pt_regs structure
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, 
	tip-bot2 for Xin Li <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Shan Kang <shan.kang@intel.com>, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:45=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On February 6, 2024 11:04:13 AM PST, Xin Li <xin@zytor.com> wrote:
> >On 2/3/2024 3:52 PM, H. Peter Anvin wrote:
> >> On January 31, 2024 1:14:52 PM PST, tip-bot2 for Xin Li <tip-bot2@linu=
tronix.de> wrote:
> >>> The following commit has been merged into the x86/fred branch of tip:
> >>>
> >>> Commit-ID:     ee63291aa8287cb7ded767d340155fe8681fc075
> >>> Gitweb:        https://git.kernel.org/tip/ee63291aa8287cb7ded767d3401=
55fe8681fc075
> >>> Author:        Xin Li <xin3.li@intel.com>
> >>> AuthorDate:    Tue, 05 Dec 2023 02:50:02 -08:00
> >>> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> >>> CommitterDate: Wed, 31 Jan 2024 22:01:13 +01:00
> >>>
> >>> x86/ptrace: Cleanup the definition of the pt_regs structure
> >>>
> >>> struct pt_regs is hard to read because the member or section related
> >>> comments are not aligned with the members.
> >>>
> >>> The 'cs' and 'ss' members of pt_regs are type of 'unsigned long' whil=
e
> >>> in reality they are only 16-bit wide. This works so far as the
> >>> remaining space is unused, but FRED will use the remaining bits for
> >>> other purposes.
> >>>
> >>> To prepare for FRED:
> >>>
> >>>   - Cleanup the formatting
> >>>   - Convert 'cs' and 'ss' to u16 and embed them into an union
> >>>     with a u64
> >>>   - Fixup the related printk() format strings
> >>>
> >>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> >>> Originally-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> >>> Signed-off-by: Xin Li <xin3.li@intel.com>
> >>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> >>> Tested-by: Shan Kang <shan.kang@intel.com>
> >>> Link: https://lore.kernel.org/r/20231205105030.8698-14-xin3.li@intel.=
com
> >
> >[...]
> >
> >>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_6=
4.c
> >>> index 33b2687..0f78b58 100644
> >>> --- a/arch/x86/kernel/process_64.c
> >>> +++ b/arch/x86/kernel/process_64.c
> >>> @@ -117,7 +117,7 @@ void __show_regs(struct pt_regs *regs, enum show_=
regs_mode mode,
> >>>
> >>>     printk("%sFS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
> >>>            log_lvl, fs, fsindex, gs, gsindex, shadowgs);
> >>> -   printk("%sCS:  %04lx DS: %04x ES: %04x CR0: %016lx\n",
> >>> +   printk("%sCS:  %04x DS: %04x ES: %04x CR0: %016lx\n",
> >>>             log_lvl, regs->cs, ds, es, cr0);
> >>>     printk("%sCR2: %016lx CR3: %016lx CR4: %016lx\n",
> >>>             log_lvl, cr2, cr3, cr4);
> >>
> >> Incidentally, the comment about callee-saved registers is long since b=
oth obsolete and is now outright wrong.
> >>
> >> The next version of gcc (14 I think) will have an attribute to turn of=
f saving registers which we can use for top-level C functions.

__attribute__((no_callee_saved_registers))) has been added to GCC 14.

> >
> >Forgive my ignorance, do we have an official definition for "top-level C=
 functions"?
> >
> >Thanks!
> >    Xin
> >
>
> (Adding H.J., who did the gcc implementation of __attribute__((no_callee_=
saved_registers))).
>
> The top level C functions are the ones whose stack frame are immediately =
below the exception/syscall frame, i.e. the C function called from the entr=
y assembly code and functions tailcalled from those (unless they set up a s=
tack frame for things like memory structures passed to the called function.=
)
>
> Note that the implementation should properly handle the case when calling=
 these functions from C (accidentally, or because it is a rare case that ca=
n be validly pessimized.)

GCC 14 should handle it properly.  If not, please open a GCC bug.


--=20
H.J.

