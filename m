Return-Path: <linux-kernel+bounces-98592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30F2877C61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7893B2822AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886222318;
	Mon, 11 Mar 2024 09:15:09 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43437210FE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148508; cv=none; b=VlMxYAhRHUZjmoBiCppj/KJrlhMb+68B9DzZMpxp7KK6c4Hq5geXcIdoPsryZNENFGWI9/O01tKH8QeUgrFJLi+A/tlSVdy0FQ2UyYGY+Zlq/z7vxfCHdrMpn9ChB7WaFKdisy/lp9bly3vnpmbuky5KZvxzO3lgWR/0GOl7Gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148508; c=relaxed/simple;
	bh=QO/GNzNkf2YcryLx1EP1noGR45Eqf4Z0zlwExKfufq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtACpdCZx6B2qi3DDDK+tObsGRdlbIwhSWClI5Dsp730ATBKpGGaxY9FsLkB1cikHMhvcdMj/GKDfe8ZH7YcsdLbOuXWpOcvZywKOTGvP/C0iysiAJfJea37G4AX03SLiO48UIsHk+vC39uHpqoV517ALVP61woGSUKFnr4Piak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-609408d4b31so39263657b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148504; x=1710753304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Afomj2qqE2Ncus3hWAy0Jm8sIwQF0kbqpG+NUNMGeg4=;
        b=S487ArIEEEUGTha9Wc5VybAKbwQaf2gF6AQCl5DYdnGmpupcd7N8gwG+qbIrHRKtsO
         zfegvzUWNmAwokc4BsXOvK9gbJkVElJZ6qJMWMitUX6v3YvD4hKNfsF9DAanTda2thxN
         4CIVe3ivU4nVeuTUwtR0OgqfgSPuj+sAScgGryy1jjW6ZL4n34ZHV7GwmKyXIe254iXw
         8b65SlyCRMOsx55tG3GRKNWWm3H5zhV4Ffn3Ygavv4UIu1IwbX325dHhe4EEMPac+gzX
         PQSU8/7KZc6bNCoLqfydJHypo/m60WeWCInMKUBaJh6fNVDi2fSJX/KUMQ8s1hzuvLLw
         xwbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTSzHfi65zFjgXDP8M0UUGT+btEur/ueLtW3aLdzGqJN4zSmITnSZoWsNcoKpBdQInQouDLQ7WzvNna07GexZERGaP6YgItUybo2jA
X-Gm-Message-State: AOJu0Yy2m525SczqcGXh7UkCCbxnb54Xl924tckgdoWiL5ML7csU7Qky
	y1m4g5OqGRHx0PKfupgwsID+unyXcrC7GOVhR3giqkuyslpki0ySoUQLdEOCHxc=
X-Google-Smtp-Source: AGHT+IGrM7/YMRWaNQlh6267WbTSBuXUYzoPedg7sgvD5fFhGO0cXQPst/PZ0e+Rwv0npUYYsJwZFw==
X-Received: by 2002:a0d:fd85:0:b0:609:fd77:904a with SMTP id n127-20020a0dfd85000000b00609fd77904amr4626697ywf.49.1710148504030;
        Mon, 11 Mar 2024 02:15:04 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id bt9-20020a05690c072900b0060a20aae5ecsm922138ywb.28.2024.03.11.02.15.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:15:03 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso3918721276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:15:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnm9hCensd/dt6CjB68KV+FC4z2+PfrvfOTKBM0fs69K3LsEbg0bcgbeAItIf8x0MPO2oE+Y8QiyitJHbteSQGli2hlolG4RHPbCay
X-Received: by 2002:a25:9d85:0:b0:dcf:5be3:3ed4 with SMTP id
 v5-20020a259d85000000b00dcf5be33ed4mr3877372ybp.17.1710148502987; Mon, 11 Mar
 2024 02:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307151231.654025-1-liuyuntao12@huawei.com>
 <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com> <42892794-7668-4eb0-8d2f-c78ca0daf370@huawei.com>
 <2a90581c-f1df-4d6b-8f0b-8e7cbf150ed9@app.fastmail.com> <346e15e5-49e9-4a7f-b163-c3316225baab@huawei.com>
In-Reply-To: <346e15e5-49e9-4a7f-b163-c3316225baab@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Mar 2024 10:14:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKk9S9voKVPvO+xvn1zFW3FnKyVHQGDkC7b9Ynkcnvmw@mail.gmail.com>
Message-ID: <CAMuHMdXKk9S9voKVPvO+xvn1zFW3FnKyVHQGDkC7b9Ynkcnvmw@mail.gmail.com>
Subject: Re: [PATCH-next v2] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To: "liuyuntao (F)" <liuyuntao12@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Fangrui Song <maskray@google.com>, Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, 
	Mike Rapoport <rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuntao,

On Sat, Mar 9, 2024 at 2:24=E2=80=AFPM liuyuntao (F) <liuyuntao12@huawei.co=
m> wrote:
> On 2024/3/9 16:20, Arnd Bergmann wrote:
> > On Sat, Mar 9, 2024, at 07:14, liuyuntao (F) wrote:
> >> On 2024/3/8 21:15, Arnd Bergmann wrote:
> >>> On Thu, Mar 7, 2024, at 16:12, Yuntao Liu wrote:
> >>
> >> Thanks for the tests, CONFIG_LD_DEAD_CODE_DATA_ELIMINATION and
> >> CONFIG_TRIM_UNUSED_KSYMS do indeed result in a significant improvement=
.
> >> I found that arm32 still doesn't support CONFIG_LTO_CLANG. I've done
> >> some work on it, but without success. I'd like to learn more about the
> >> CONFIG_LTO_CLANG patch. Do you have any relevant links?
> >
> > I did not try to get it to boot and gave up when I did not see
> > any size improvement. I think there were previous attempts to
> > do it elsewhere, which I did not try to find.
> >
>
> I tested this patch, the size improvement was only about one
> ten-thousandth, and the compilation time had increased by about a quarter=
,
> and the kernel did not boot.
>
> Strangely, LTO has actually increased the compilation time
> significantly, which seems contrary to its purpose.

The purpose of LTO is to reduce code size. Doing so requires more
processing, hence the total build time increases.

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

