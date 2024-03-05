Return-Path: <linux-kernel+bounces-91596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB7871413
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F406A283359
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905E29437;
	Tue,  5 Mar 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HKyllNPx"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3082941B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607826; cv=none; b=OLVZ6CCm8DEYz1DkDXqNs6cGbDHWhi2qozZ2/6j0CL7tgB4TPNYx07JC/3kcfhkHRaEYyQ0lzDbDoxWrET9EJUztRA9cfzii6B6EyatDHP8A6pJhXtXv+pzwPSqQ8sJiPtEMnwk6b7bQfKcMfdo+mpS0kGZ6B2kvL7f8KqoYCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607826; c=relaxed/simple;
	bh=jeP7yg03z/TtSAn/5mkkxNPbmXMp4hRVJ5K3zTplORI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX4E7tX+e+zM6m4U4kdGfZyleOeP0ItujOVG0U6BZvCepzG/0UyngPeL9RWtrBu4GQNkHLAIihSn51vnzIQYu0/PK+OcQBO5+RFmSs1aHF2PMoU9VheXcFWRaNhsavCK/YoX1Tz7xGc6OJuSvbI7qN+D3CqaFbCKqXQdQnhQ8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HKyllNPx; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512e39226efso5129773e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 19:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709607822; x=1710212622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeP7yg03z/TtSAn/5mkkxNPbmXMp4hRVJ5K3zTplORI=;
        b=HKyllNPxwzmL+ZZDWf30oH1GUBln58jGMWyd4ynQfDA762c3RVQ+YoTEz9bwKdLvwV
         jN8AoACX8sIgt8+do9rb7d3mmlZYvs8xMMlkYk0JeCmhtdmtuY9Jndq5vMKyyyucbmuy
         JC9/1W92yhOb+1/hYPiwu0xaRQesyc5uau9ZCesgJLP+2GB2AmGW7IZfLsTd0OTkztNm
         Orp8nYa4LpX9z2GdE2i8a0BL/JiUJJiEExy2rDGONQ/w4lwBSZZYBlE48bAQCkSH9Ck9
         3AU+PBHdmSLzx+/xXSNL7yfKh4v7e2rYI84M1/9RJVAUXSsSP8059uW9AkRK5eHRJQgx
         90Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709607822; x=1710212622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeP7yg03z/TtSAn/5mkkxNPbmXMp4hRVJ5K3zTplORI=;
        b=FkL5xCAflDgef0giM/aLHNU4F/OgYViZWh+RA5jJA7UQpMyZ9Xo0PihUcgnxCAwrIw
         nZPhDx6wHG/Xk6shUtR7b7evSZItHBYrj4i1HbUSbt9yO23Bo5sxpi3ueb0Z9/zfVeIQ
         NvRvXnmVt4cB3CUNPR/1cWT27UmEl1wvlL8zT138uLJeqhz11igjBZBzki7eKk2PW+jC
         4aaHBLDpqvAEUBJvGvpfwKlntSlkPOdhtyDsBWsXID3IXjGYJeggoRHWMWQYiRypX3B5
         xLKaeREA4hJGzM2EXEfOX/DwKa4Pb6jExczsoGZxaPe9iWjGd5ZMH8RwNRejsiq+b8fp
         +Naw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ahLCKS4p5hS8K89EnGtB1R2eDg7h+Ee6u5q8hzR9NC+I4ltXLJN3ay1MlLNi5cEOJSJb1LKQYEe4Td8W9kX2qlpjbmPkuimYlBsq
X-Gm-Message-State: AOJu0Yz/NydRvB5eUdk760OWKsSJbMT+edi6NL4WVv0I+GsWfunDUaW8
	7EwK4cY0zpQ3N2gFKCwZ2oF6lD8VfjJWYB1W3VwBzFkkGkngue2fXwZJXtGawMBOedhpiopuYRL
	Yjo8ErnHke6KhfMsJhCw9fnF1S9NVTcFcQZWeXg==
X-Google-Smtp-Source: AGHT+IFPXo6a34SIvWl7lw7N7W4+IchbD08putpSxKw58/8CLAWWz2yNLnjUOFdz0I/fYG+Hmoz7mGxMqGuepuD1+8g=
X-Received: by 2002:ac2:54bb:0:b0:513:1cfb:a848 with SMTP id
 w27-20020ac254bb000000b005131cfba848mr325931lfk.33.1709607822218; Mon, 04 Mar
 2024 19:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229121056.203419-1-alexghiti@rivosinc.com>
 <20240229121056.203419-3-alexghiti@rivosinc.com> <20240304-makeshift-bakeshop-26c9611de1a3@spud>
 <87msrdzqxi.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87msrdzqxi.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 5 Mar 2024 08:33:30 +0530
Message-ID: <CAK9=C2Xjgr9_H-sHkmAAc95dAm2jd+_dxLUxSM3RM3NrQJFKGQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Fix text patching when IPI are used
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrea Parri <andrea@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrea Parri <parri.andrea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:54=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Conor Dooley <conor@kernel.org> writes:
>
> > On Thu, Feb 29, 2024 at 01:10:56PM +0100, Alexandre Ghiti wrote:
> >> For now, we use stop_machine() to patch the text and when we use IPIs =
for
> >> remote icache flushes (which is emitted in patch_text_nosync()), the s=
ystem
> >> hangs.
> >>
> >> So instead, make sure every CPU executes the stop_machine() patching
> >> function and emit a local icache flush there.
> >>
> >> Co-developed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
> >
> > What commit does this fix?
>
> Hmm. The bug is exposed when the AIA IPI are introduced, and used
> (instead of the firmware-based).
>
> I'm not sure this is something we'd like backported, but rather a
> prerequisite to AIA.
>
> @Anup @Alex WDYT?
>

The current text patching never considered IPIs being injected
directly in S-mode from hart to another so we are seeing this
issue now with AIA IPIs.

We certainly don't need to backport this fix since it's more
of a preparatory fix for AIA IPIs.

Regards,
Anup

