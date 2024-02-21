Return-Path: <linux-kernel+bounces-74841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C438F85DD20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B65FB25C74
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C27E78F;
	Wed, 21 Feb 2024 14:01:23 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE969317;
	Wed, 21 Feb 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524083; cv=none; b=I1XoT6Ei73rt+ujTprIfxSjYf2dT44Y6MISfiKAQ0B2WugXk5Cq8fzTWwE4EybnE32W0BgVJPzDrpsmG9m6pZ8rjNq58toldWQEe5S4hhIZpf8xqJNMvErxW76rRa2PE4/LgqlzzV++f5xbgG5UQLZuTVbIdHK95gwcckqrnRVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524083; c=relaxed/simple;
	bh=kRcg80C9ZBnGxT3M1EqCIXl7ZKMB3xgmsA40US7huBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKEmEnhZZFh8cckWjPF8j8EYhSULnAp4V00WLmFhTtWLVY3j+CpVW6SUC/WuZL/jdLM+VxPMfziFnlPdJTwxXH3ma8lG99EpvM1wdtXOlNgvjPcofbk9Pjq2zrJnFPdiC1wgYGdcSmlbRlKOt3nB7M9BMTeHT+zKwtkNUaNT/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6084165494eso29307117b3.1;
        Wed, 21 Feb 2024 06:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708524080; x=1709128880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9FiLXtIjbGeAO1H/0j8/WW2xG7E//rPhnJ7T73444k=;
        b=FHaEsKUYQBnYt/OEPrxcDaAk4rOZwt6ywjHndVOL2SxUU+qMZWJGOwlFaoV1jSaf0z
         Thon7++12H4iQigjCJZp5stGC12qhVHB0RkoF0eXSvdURCUQwaMHHQ8zXvQ7RHJxT/Z1
         KoC87o5n9xj6s5+n12G+4AFu2t/N1fpi74d0XtlfyzqB7WdtkC+OVC27abB+Ywh6i1d7
         ep24HRr3+xtMpLAFTzR1TJiiGrZPRZO900I+Q9mI9utf8RBiaqpTYbdAvPjsoYVUqXnF
         zL6HI81XbzfSSPMN7iDSBnINbs3r2RUBmE7PMF2z7Y+PvrdSo73/6sASqSPTnbDhSzPj
         u3gA==
X-Forwarded-Encrypted: i=1; AJvYcCXH5b+oveCnimoK/uzNOvWI9V4nIRpe846VdXO8X7or+ez1GeEIIqtgtgXNx48NIUIBXwq2+Q4yc5lds8SL+YN8D50gN5mOISKCDoONpCbuKfbYWkKZRnVu5DczGiEm8/TaGmT2ITIlHQ==
X-Gm-Message-State: AOJu0Yx+bj4lzXQ91xwJxqNsX1Lx4vE0P3GYH3EcPPYt/i3mCKczP4+e
	oBLnPgHjKEoqkHDXOH8v7R3IAlFQo9nnMiOQdc/Z4g6zy4jl5x+nzfqd8HPnOPs=
X-Google-Smtp-Source: AGHT+IFdxq7G7y2+kIw5H63yt72Au/aHPV58ZLfIA8JxnI6vUKhwDxbsNfXxCsbXCFhFzJ7vrfZdXw==
X-Received: by 2002:a0d:d8c6:0:b0:608:835a:27b0 with SMTP id a189-20020a0dd8c6000000b00608835a27b0mr1310351ywe.8.1708524079840;
        Wed, 21 Feb 2024 06:01:19 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id g65-20020a815244000000b0060853853a55sm1048575ywb.144.2024.02.21.06.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:01:19 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60818d338bfso37380147b3.0;
        Wed, 21 Feb 2024 06:01:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSadV/D1jxBEzkOG7SXeRZ3+z0Jzv+DB/3muxI1deRZhzHlrwqOjez81c2+MFmBsCAD/Zg+/oe7KasFjV0TmjBWrB29D4MTvU+hVPyQy3iBYjqr3HZdOrn8hf2PT2Dh61lRgkleb73iA==
X-Received: by 2002:a05:690c:398:b0:608:4cee:e71f with SMTP id
 bh24-20020a05690c039800b006084ceee71fmr8199292ywb.32.1708524073407; Wed, 21
 Feb 2024 06:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092826.748e70c4@canb.auug.org.au> <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
In-Reply-To: <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2024 15:01:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXrxC6mydJ3MO5WurqE4uXbF+XBaoBe_9Sht9DotXxoDA@mail.gmail.com>
Message-ID: <CAMuHMdXrxC6mydJ3MO5WurqE4uXbF+XBaoBe_9Sht9DotXxoDA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
To: Rob Herring <robh@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, 
	ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:54=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Tue, Feb 20, 2024 at 3:28=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> > After merging the arm-soc-fixes tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >
> > arch/arm/boot/dts/renesas/r8a7790-lager.dts:444.11-458.5: Warning (inte=
rrupt_provider): /i2c-mux4/pmic@58: Missing '#interrupt-cells' in interrupt=
 provider
> > arch/arm/boot/dts/renesas/r8a7790-lager.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7792-blanche.dts:376.10-392.4: Warning (in=
terrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in=
 interrupt provider
> > arch/arm/boot/dts/renesas/r8a7792-blanche.dtb: Warning (interrupt_map):=
 Failed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7790-stout.dts:344.10-362.4: Warning (inte=
rrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in i=
nterrupt provider
> > arch/arm/boot/dts/renesas/r8a7790-stout.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7791-koelsch.dts:816.10-830.4: Warning (in=
terrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in=
 interrupt provider
> > arch/arm/boot/dts/renesas/r8a7791-koelsch.dtb: Warning (interrupt_map):=
 Failed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7791-porter.dts:410.10-420.4: Warning (int=
errupt_provider): /soc/i2c@e60b0000/pmic@5a: Missing '#interrupt-cells' in =
interrupt provider
> > arch/arm/boot/dts/renesas/r8a7791-porter.dtb: Warning (interrupt_map): =
Failed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7794-alt.dts:450.10-464.4: Warning (interr=
upt_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in int=
errupt provider
> > arch/arm/boot/dts/renesas/r8a7794-alt.dtb: Warning (interrupt_map): Fai=
led prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7794-silk.dts:436.10-454.4: Warning (inter=
rupt_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in in=
terrupt provider
> > arch/arm/boot/dts/renesas/r8a7794-silk.dtb: Warning (interrupt_map): Fa=
iled prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7793-gose.dts:756.10-770.4: Warning (inter=
rupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in in=
terrupt provider
> > arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_map): Fa=
iled prerequisite 'interrupt_provider'
> >
> > Introduced/exposed by commit
> >
> >   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
> >
> > I guess you missed some :-(
>
> No, Geert separately posted fixes for already.

Indeed, cfr. commit b4f97d1b5aeb6166
("ARM: dts: renesas: rcar-gen2: Add missing #interrupt-cells
to DA9063 nodes") in renesas-next (next-20240220 and later).
But that commit is not part of arm-soc-fixes.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

