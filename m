Return-Path: <linux-kernel+bounces-97147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376DA876617
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4388B1C2194A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6383FBBF;
	Fri,  8 Mar 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXDZfQWz"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7FF3DBBF;
	Fri,  8 Mar 2024 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907197; cv=none; b=F9J4g0rT/k0X41ORXMZzvnV0yY4uV9xFiAKqn2k7Ky+/lfP2J/dRLbETEkMhhC9TYegQpzXDWOqTmqhD0YpDMCJC5iHvYAYDdE6BZtsHpLbPl6SEp/lzYiGowXUGAtMhApnJfosl47nerkPVdtPeahsDSlfnHdMRNp5Vlngo0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907197; c=relaxed/simple;
	bh=TNAmhFzSeaD6wR6KJ/UAf/8iGn+xyB1175NpyMI2DQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiwdQOOXI1LYKElzv0xwwvoMszduA1b5gWZ8d8cPw6euvnGMIEW8vOn40+S2oU32OoMYIAe6ToKV+t8O+ACxBR7AvXU4s4oVvt5piw0A0Cp7kU7i4VzA5KOK4C8rCw3y4GrQeUi4unT9CNAN8S2hYhKw9VqDmmkqqEOO2C1DWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXDZfQWz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512ed314881so2029132e87.2;
        Fri, 08 Mar 2024 06:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709907194; x=1710511994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TNAmhFzSeaD6wR6KJ/UAf/8iGn+xyB1175NpyMI2DQU=;
        b=OXDZfQWz2itWTN3kgtSyQUlI1ICxfmUBHnlYXXLoo6GiiAug2XvRF1zD3ulsuZNw3/
         iqaGRKb6FU3q9Ayz8BpuaPvt1Ienqeryx/so52qMT1LacSOEjhBO95ym/DnHOceA1I+/
         Awq08mTYa8pDJIto5xszUF13y3UpKGYzU69WMrqekgRhhl+O4dl4+GXJM7dawjBGij/M
         RGBJFnaDroqA4vdLjsXQCsuYK6EAxcq5YzAV5Ii6+E24m4BZgRzhnZzGaMFS6DzZJepS
         qjm7lPuKEDzbCXCx3Z3T/dEY5P+3p/E1hJxb4sfyQRuZhgMK/BF2ys9PMc3ZZxVefldy
         yxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907194; x=1710511994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNAmhFzSeaD6wR6KJ/UAf/8iGn+xyB1175NpyMI2DQU=;
        b=eas/bZ/7JJUQBcPoAE7D0iFU2aAxE+Myr+L9ttqaDdL0IaPQVNySEM+gqNr/TdS/qP
         6v78qLDcYy/hOUoEeJYFdBaVQyPnT2vUYCKf89qRwv57IErc/Q+n0t4HT4yEKoeB+bvR
         NlXfdleEoIDAfXxGNlvVgCM92Ey5ZkJQv4wrfV2SNTMsIqXMlyfVBq9q4nNC/XY4mHx2
         9sA1vLrCnzgZM4O6BoVJZmg4+r9cZPCvyIT/GJtuiRaSnT63bywoJLmDCMjPja88b+lF
         VRujQfiErHkpu4+im99xVUCjLnBXd+UefjRQymG4DPZAZC8eON85GoB7BlnZoLpGfIv+
         9vSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV04dtsw9YuV8HZ/iNazD315DWjQkUeDmituA8MyBLpe5oGBjCkpqbOuo2TKXJYWyAcjQu8E96H2bEduv20471tk98NmgLVweaIPY7TBJMEFU/YtigIpcENzdauWxBULuS+kSSOCbK3O2GEfkGIicwd
X-Gm-Message-State: AOJu0Yy7ygE7EFFIgp+qrSrHTnHxZlzP0ZonB3zRPTYSd+XGEcdqyhRN
	26RVcJOLE5EPZmlWfqFCWk8PfNQV3n1FZ/qXjG0ZCKPHSfBK2CdSZARLTiJPgS2Gl9appAVfKSl
	lQH5lFLteqxVN5NmJAxkXsIPOYnA=
X-Google-Smtp-Source: AGHT+IEnpibiq1oTffEeY4LuZ+IiCvylw5bnXg1+82BI68jyD2wQItjBXAeOd2L90D++pDldD8hIGtGaEgQPFmXHTDw=
X-Received: by 2002:a05:6512:3584:b0:513:8102:1a1e with SMTP id
 m4-20020a056512358400b0051381021a1emr2786397lfr.50.1709907193455; Fri, 08 Mar
 2024 06:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306165904.108141-1-puranjay12@gmail.com> <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <CANk7y0gbQdYw0V+CEv-z8wFGXnki8KSn4c8+i0iZ1UFNCg7wJQ@mail.gmail.com> <CABgGipUJU_joVOjPi4WZ4JJM72zaSrCA1QUAaP8hob3+LXkS0g@mail.gmail.com>
In-Reply-To: <CABgGipUJU_joVOjPi4WZ4JJM72zaSrCA1QUAaP8hob3+LXkS0g@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 8 Mar 2024 15:13:02 +0100
Message-ID: <CANk7y0hdntnN8x8keDvbQPfr1LLJwRSH5BX0dyC1tvL94sqn7A@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: Andy Chiu <andy.chiu@sifive.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Guo Ren <guoren@kernel.org>, 
	Ley Foon Tan <leyfoon.tan@starfivetech.com>, Deepak Gupta <debug@rivosinc.com>, 
	Sia Jee Heng <jeeheng.sia@starfivetech.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Song Shuai <suagrfillet@gmail.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,


> >
> > I don't think implementing direct calls over call ops is fruitful for
> > RISC-V because once
> > the auipc/jalr can be patched atomically, the direct call trampoline
> > is always reachable.
>
> Yes, the auipc/jalr instruction pair can be patched atomically just as
> long as their size is naturally aligned on. However, we cannot prevent
> 2 instructions from being fetched atomically :P
>
> > Solving the atomic text patching problem would be fun!! I am eager to
> > see how it will be
> > solved.
>
> I have a patch series to solve the atomic code patching issue, which I
> am about to respin [1]. The idea is to solve it with yet another layer
> of indirection. We add a 8-B aligned space at each function entry. The
> space is a pointer to the ftrace entry. During boot, each function
> entry code is updated to perform a load and then take the jump from
> the 8-B space. When ftrace is disabled, we patch the first 4B-aligned
> instruction to a jump so as to skip the ftrace entry.
>
> We are still discussing with Alex to see if we have a better way to do
> it. If not then I'd update the patchset and re-send it. There's a
> pending improvement in the series to reduce complexity. The 8-B
> aligned space can be added before the function entry (just like your
> patch).

I briefly looked at the series and it looks promising. It looks similar to
how BPF programs jump to trampolines on ARM64. If the choice has to
be made about keeping the 8-B aligned space below or above the
function entry and both choices are viable then I would prefer keeping
the 8-B space below the function entry.

I am saying this because when nops are added above the function entry
clang's kcfi[1] doesn't work properly.

Thanks,
Puranjay

[1] https://clang.llvm.org/docs/ControlFlowIntegrity.html#fsanitize-kcfi

