Return-Path: <linux-kernel+bounces-25140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C71E82C860
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82FD2863FC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86BF4F1;
	Sat, 13 Jan 2024 00:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="i7j9h0iC"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE97F503
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso82225451fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1705105928; x=1705710728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzga2b4T8jG3LT+m5ymrl6IfG+dETUDO8ivjxyijZE0=;
        b=i7j9h0iCFz/eSF0SJWrQi+uIUyPIqa86NfX4XoV/u/5WyOfAsrJcb1StnweUlvTyr2
         ZQIt9OYjTt30604dsGrCmrb+ILnk4wPE3bxReZzJJgPO4sLAABJh+80nWbK4cwUW0c1Z
         Xs5k2/sGJCF2skjiLZM0i1Ewa/3d7F1g3FvDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105928; x=1705710728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzga2b4T8jG3LT+m5ymrl6IfG+dETUDO8ivjxyijZE0=;
        b=MsDEJT3R6DDWN7aN5i2vpxsNnhdfhojYhm8k3cgkA+wXWTdKutWocqvUFJgUo11g1f
         2sexD/W2dyFHlbV2Q2qAFZIzWd0LkeU5OKst24u3L8Cgbdn995YQmH2jK/EdDoDezavr
         edmM9AhoB64YAsHUM5vy6Z80jJpVaiac7jjqztnhmYDIGW1PlIhQlg8nQ865gTU0N4mr
         fAhfu45YkzwkwPjYSY9GjL/s/BqDNz+HPgWcWpJ7T4v9ZKvLHsO86/5Cvmpypfdqc1YG
         T6LyrZmr114Qj0lZ6vpYc3/PVYfZN15bmw3IeoBq4koAomgvEKV3mG0W4134GV6pq/e7
         mT8g==
X-Gm-Message-State: AOJu0Yx4x687aobj9YSeohKYo8AgQVY+HqzFn+bpfuFA2q0tIsKGCP7q
	rGdZC3WdjOySP3i8zuhyqwwc1WxVcFL3im+v394MHHXWO8+R
X-Google-Smtp-Source: AGHT+IFYVmL/8V0hnK36wD0F+Tj56+5iO0c+zitkdAxQYpkX5w2AMpz8U0JxqKR9numdiRkolOnOQ4vwuN8VuMQU6Xw=
X-Received: by 2002:a2e:b619:0:b0:2cc:68f0:c10d with SMTP id
 r25-20020a2eb619000000b002cc68f0c10dmr1029870ljn.34.1705105927728; Fri, 12
 Jan 2024 16:32:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110073917.2398826-1-peterlin@andestech.com>
 <20240110073917.2398826-5-peterlin@andestech.com> <CAOnJCUJ0fN5=+b4jDx+NPqUwgwGKuBNYt7d86dXYNyjzUYFAWQ@mail.gmail.com>
 <20240113-sensuous-scraggly-dee35f3e213f@spud>
In-Reply-To: <20240113-sensuous-scraggly-dee35f3e213f@spud>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 12 Jan 2024 16:31:56 -0800
Message-ID: <CAOnJCU+JjcpH0t3kGcdM4hjj-di9UKWwtaEpMdwQmOQSnEtKJg@mail.gmail.com>
Subject: Re: [PATCH v7 04/16] dt-bindings: riscv: Add Andes interrupt
 controller compatible string
To: Conor Dooley <conor@kernel.org>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, alexander.shishkin@linux.intel.com, 
	andre.przywara@arm.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	conor+dt@kernel.org, conor.dooley@microchip.com, devicetree@vger.kernel.org, 
	dminus@andestech.com, evan@rivosinc.com, geert+renesas@glider.be, 
	guoren@kernel.org, heiko@sntech.de, irogers@google.com, 
	jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com, 
	mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com, 
	namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	peterz@infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org, 
	sunilvl@ventanamicro.com, tglx@linutronix.de, tim609@andestech.com, 
	uwu@icenowy.me, wens@csie.org, will@kernel.org, ycliang@andestech.com, 
	inochiama@outlook.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, 
	wefu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 4:19=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Jan 12, 2024 at 03:50:15PM -0800, Atish Patra wrote:
> > On Tue, Jan 9, 2024 at 11:40=E2=80=AFPM Yu Chien Peter Lin
> > <peterlin@andestech.com> wrote:
> > >
> > > Add "andestech,cpu-intc" compatible string to indicate that
> > > Andes specific local interrupt is supported on the core,
> > > e.g. AX45MP cores have 3 types of non-standard local interrupt
> > > which can be handled in supervisor mode:
> > >
> >
> > PATCH1 in this series renames everything from ANDESTECH to ANDES to be
> > consistent.
> > Here you are adding DT binding with "andestech". Is there any
> > fundamental difference between these two to demand
> > this change ?
>
> This one is the vendor prefix and the company has been assigned
> "andestech" and they're not getting a second one. The rename of the

Thanks for the clarification.

> variables is a bit gratuitous tbf.
>

I felt the same.

> Cheers,
> Conor.
>
> > FYI: I don't mind either way as I don't have skin in the game. Just
> > something I noticed while reviewing the series.
> >
> > > - Slave port ECC error interrupt
> > > - Bus write transaction error interrupt
> > > - Performance monitor overflow interrupt
> > >
> > > These interrupts are enabled/disabled via a custom register
> > > SLIE instead of the standard interrupt enable register SIE.
> > >
> > > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > Changes v1 -> v2:
> > >   - New patch
> > > Changes v2 -> v3:
> > >   - Updated commit message
> > >   - Fixed possible compatibles for Andes INTC
> > > Changes v3 -> v4:
> > >   - Add const entry instead of enum (Suggested by Conor)
> > > Changes v4 -> v5:
> > >   - Include Conor's Acked-by
> > >   - Include Prabhakar's Reviewed-by
> > > Changes v5 -> v6:
> > >   - No change
> > > Changes v6 -> v7:
> > >   - No change
> > > ---
> > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Docu=
mentation/devicetree/bindings/riscv/cpus.yaml
> > > index 23646b684ea2..33c2b620a59f 100644
> > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > @@ -101,7 +101,11 @@ properties:
> > >          const: 1
> > >
> > >        compatible:
> > > -        const: riscv,cpu-intc
> > > +        oneOf:
> > > +          - items:
> > > +              - const: andestech,cpu-intc
> > > +              - const: riscv,cpu-intc
> > > +          - const: riscv,cpu-intc
> > >
> > >        interrupt-controller: true
> > >
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Regards,
> > Atish



--=20
Regards,
Atish

