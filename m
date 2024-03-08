Return-Path: <linux-kernel+bounces-97162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F0A876648
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD527B222D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C224CE05;
	Fri,  8 Mar 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjBSLsI+"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5323772;
	Fri,  8 Mar 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907751; cv=none; b=CncO3FKXbc/BrBYhnxAZIZtqbgZbBlTbSALOrLW2v1uhxbie5rciukOOo6PYgiKAkv/HUDbk0fs1mYsjCietOjNjprC2iuakRWzklnM9zU4CciqJiPxFWulU+pUDY4B/rFD4/2TRr9gn5W4JneCTp53oLMtpx7qAd4L8NrDvqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907751; c=relaxed/simple;
	bh=ojcrxVImzaAPTIc4pyg/lucaOPEu+fy//Huzchcs5ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snqIk7lzdN6AXTlRvr9lkTzBWVbgyY/H70GBFCg2XMkRcTDlHaoviTtacg/XarNhNp9tbPH+JjRPLfLU12pdUGGs4v/BxCTHQgcJohobRBfb14UPToFwY5zRBcxTzD1N0k+6JXYJenp9N4lM3gl9t67lbrWF1s9CPy6j1smRmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjBSLsI+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso1243112e87.0;
        Fri, 08 Mar 2024 06:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709907748; x=1710512548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojcrxVImzaAPTIc4pyg/lucaOPEu+fy//Huzchcs5ZA=;
        b=BjBSLsI+AcaY8seiqJ8sI1pyztq5kaxzDOHRdaAeFwTCHLfLWX1f6aN3bKXNO2wVN+
         IvGkXcD0a4T+sSQ5SUq62OgbrvMzckM2WsVYWbPrS12dLWyhbUVD4lufggUd+F9moWs7
         qpMVq6R6gI8SfOA32WSAZdTX9vxWLvGcWPPMdD4Y6gJKOQd9enFSBhNP4iI9qcBjjPun
         1F5VAWCNfBu7TP3a6j1C2d5RoRg6mU50SdIGs5z4QuXUThlF25f3U6JecpPvwWK9stBw
         wxwwQg1XWzqiy68uNtdkw4NyZtvN/2EGypkyGN7A5mhgFhoCwEh1lXAp3Ucfv3fB08e0
         W0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907748; x=1710512548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojcrxVImzaAPTIc4pyg/lucaOPEu+fy//Huzchcs5ZA=;
        b=sVU+lKuUKSikfYePQpvmoBOjDsn3AYZoTazZX/sVijim4t1IHQhy1T91T6Yk3kJ42Z
         kP0b8Q+SLYTkbsgoRv1i5GWndAbZGqlnnKeg7aW4h/oFsoCxeXRM0lu2IqN3el21B5wk
         V/by43T3+AkrmUqlkYnGalykmuaNHHaLBXN2ArGVuXYwGOb4iWkQn1yBgnvnT6+OS3Lx
         diQWCfqfhchZgZ6yUkC56MWeidZtpqYtD9nhjmeNCzgkok5+x2gKuZ1+NXnDCn/pI5Fb
         lGrhe8tNax0/or3nQoRyzCvTeVpU7s5elC8ZcbcnCGOFXzzdfJciL09N9jWh3pPsLBui
         9BUw==
X-Forwarded-Encrypted: i=1; AJvYcCWx0Mb8HlmO00qBYfqFQ7uPMMr4uG5Iu9GQ5+vS/8LJgBPXnNU+guAqRE+HWMIUT7+1Qotta0uF/JS1OgWypFkuDoAsbhfWX++dyIQj49YvSKwlLl+L9+AHs1cJ0Y+jvscVuPJYyt1ngS6/EHmAOqBZ
X-Gm-Message-State: AOJu0YwdCNNNJAYEMXquFHSyLrocMbGPQkjT4A+SjmYwf+R8kqKu4ekU
	9jCwswSZ00puJ3Ntr4Z0x+pnvEGOG2Vc8BKMTiBxj21/j+KuVyOO78IKosRg05Gxg2dDDqYVDvD
	BWPk7ZNiHhN+9MplsyxfqxkeiBu4=
X-Google-Smtp-Source: AGHT+IHlNDCalmvWgglhccE8n0ysn68+ehYyI7316Fj/AoLgfLAbgPA0wvzexIBL9XUfgexyKtAVjsk3+IrB9O32rrc=
X-Received: by 2002:a05:6512:743:b0:513:1f44:7cf6 with SMTP id
 c3-20020a056512074300b005131f447cf6mr3255371lfs.64.1709907747997; Fri, 08 Mar
 2024 06:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306165904.108141-1-puranjay12@gmail.com> <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <CANk7y0gbQdYw0V+CEv-z8wFGXnki8KSn4c8+i0iZ1UFNCg7wJQ@mail.gmail.com> <87jzmdowp4.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87jzmdowp4.fsf@all.your.base.are.belong.to.us>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 8 Mar 2024 15:22:17 +0100
Message-ID: <CANk7y0jpKb8XUycKxHbsrJGEWcTvVDYFjM+A2VUe0JeZ2Y-Zbw@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
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
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B6rn,

On Fri, Mar 8, 2024 at 11:16=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
> >
> > If I remember from Steven's talk, x86 uses dynamically allocated trampo=
lines
> > for per callsite tracers, would CALL_OPS provide better performance tha=
n that?
>
> Probably not, and it was really a tongue-in-cheek comment -- nothing I
> encourage you to do!
>
> Now, I think a better approach for RISC-V would be implementing what x86
> has (arch_ftrace_update_trampoline()), rather than CALL_OPS for RISC-V.
>
> Thoughts?

I am going to spin some patches for implementing
arch_ftrace_update_trampoline() for
RISC-V, then we can compare the two approaches and see which is
better. But I agree
that arch_ftrace_update_trampoline() is a better approach given that
we can jump anywhere
with auipc/jalr.

Thanks,
Puranjay

