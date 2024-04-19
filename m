Return-Path: <linux-kernel+bounces-151590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2C8AB0CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9ADE1C2153A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389C612AAFD;
	Fri, 19 Apr 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJYuwsrh"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1EB661;
	Fri, 19 Apr 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537160; cv=none; b=CYgmg1MGXtBL7Y89pOepa8XAfOeFtKUMW2e/djIceK0YQpRiZsTJpn73GFplaJ7IxpjllZVQte6mrL6+wWxzkX/tpt6mp1kng4+NtTrzVs28qYvKtLVB4OLXySmBNLJmtbH7FJs/96kwuMgATRfc5BIKVFI/Sa5iXOjIQt1FMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537160; c=relaxed/simple;
	bh=wpubB5RGGs+N9oSpYbdeFOjJ3Vm/Rrf9Ev30ZPMU4sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKOjevaJe1tXiMI1I+2eMlG70RtsznmSc+hU6ju+EgIB9CZQmpglXEc5PlRev/ocbAbT2Ev3uK5uqOARFDhibYEcIG+7KNBMtZjxAeMaCfHO6CgSrSjEtGzpliwxUAC1QWqK9gpufoP9wzSnzRmxQJ24PYa7buLuNiAXZM3YsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJYuwsrh; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a519ac18b3so1615364a91.2;
        Fri, 19 Apr 2024 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713537158; x=1714141958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpubB5RGGs+N9oSpYbdeFOjJ3Vm/Rrf9Ev30ZPMU4sA=;
        b=mJYuwsrhumsgrR9fTeyWJbnBfOZhyqMgnpc5z+cWVpME/rMUgfSl1die1CkXgDmTGC
         RStUXdkoUKlfxP1ENaZVBDPEePW8dPYVgmEXmjN12+S2aUtzrwNqH6VaRTCKp1L4MDVd
         +e7UmTI61b440wjpE3svaEqxmEjtaot9qxksXBFOf3yAXhra2ys8F0ivWrCHjqUm+Du6
         KDWKbBUk6qWZwEOcIwOnHNnD/mTHi8q190vumOMc95MsxzTHrDkqtqWZJCsNTzT8tp8M
         0vIL2ALIjH/X8ZWEkqJAfifxc5qMp8XhO2sATMi5Xoy7sWvSRAtzIUbUud7Wr/4jYpxB
         NjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713537158; x=1714141958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpubB5RGGs+N9oSpYbdeFOjJ3Vm/Rrf9Ev30ZPMU4sA=;
        b=DjrCv0gyiqa0bQF8495ZAIUhzRIx5KZ9OBX8f/O74bwFERPaUJXhvSPDaGtHjGeTGD
         A7jeqqiSpcR7lyT8kigggbVuvTFYpjnZ4NuXizKtiVrX7bofYpEwl82ZcAq1DG/HRxp1
         xloR3mXEPw5iV5gMGPLXmra2/eVC33I/FwGWvdoLM9DZxxVhvs5awgjOf4CyoVYse33N
         15peCrVqMPJMl/9taCQhRmHdBfeCXwPrxmA6XxjwWtg6ILFss/Y8T7vlVtOcAP2IPn3R
         1+S8TIZSj9qj0iHnOp3g3+SA05okhYcLF7BG3hf/e7tQdhf4OgnOit88jcfuu3SD3BJg
         M4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW94sK8apuHqZzPxRsteK5nV/gnymRNPBHLGsWXuFQATTlOlUZXQ9Px43KzBqPopRtLuApdZTWpXloWo1MkZxIqyxj5NhMASysnjH1IW6slckTKD8IaCfkojsmd0I/MreH5j2foDIwATS6j48Vw4KCd14SJjC3ZuaJsBF0MudGUiy6SC6Lsvw==
X-Gm-Message-State: AOJu0YwYhvARA5pUjYBcz7jkjij15qScGlX/e5SauMzdj2WcqZuXwz3n
	YO3VQZrNHr3rQ8vvim8aSDTWeIXLiH5qnMpM/hxzL1kJXgTLjcFgP59zsjlCm/Q0yElwlgJHaJp
	it0mMx2uCldCpfqoFEPwpJIoF1T4=
X-Google-Smtp-Source: AGHT+IGx6hIS3g+ara6O42TicQaaFPwEmS+NsYEwehh6Rjx1ecg93nnhIbYtQVpE31PFXzePbkZG7q7XQx/qyxbn/Ao=
X-Received: by 2002:a17:90b:1651:b0:2a5:99e6:45a with SMTP id
 il17-20020a17090b165100b002a599e6045amr2284524pjb.29.1713537158490; Fri, 19
 Apr 2024 07:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419124506.1531035-1-rilian.la.te@ya.ru> <20240419124506.1531035-3-rilian.la.te@ya.ru>
 <20240419-glue-pyramid-584728c0076a@spud> <CAF1WSuy4OJVTU5VJdn23BSw4aTAq7i8UQ416V7BxveuQ+5=-1w@mail.gmail.com>
 <dc6573ba-37cb-4394-9a89-16b6f8caa7ad@kernel.org>
In-Reply-To: <dc6573ba-37cb-4394-9a89-16b6f8caa7ad@kernel.org>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Fri, 19 Apr 2024 17:34:44 +0300
Message-ID: <CAF1WSuzVLrsYt6+CyMHJuRbuXNEy2XnWhbHkcPHT3xXpB3Yh-Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Konstantin Pugin <rilian.la.te@ya.ru>, 
	Vladimir Zapolskiy <vz@mleia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:24=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/04/2024 16:17, Konstantin P. wrote:
> > On Fri, Apr 19, 2024 at 5:08=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> >>
> >> On Fri, Apr 19, 2024 at 03:45:02PM +0300, Konstantin Pugin wrote:
> >>> From: Konstantin Pugin <ria.freelander@gmail.com>
> >>>
> >>> Add EXAR XR20M1172 UART compatible line into devicetree documentation=
.
> >>
> >> What you're doing is obvious from the diff, why this exar device is
> >> related to the nxp devices is what should be mentioned here.
> >>
> >> Thanks,
> >> Conor.
> >
> > It is already mentioned in cover letter and in previous patches in the
> > series. Do I need to repeat it in DTS patch?
> > If so, I will do it.
> >
> > Citation from my cover letter:
> >
> > EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> > it has additional register which can change UART multiplier
> > to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
> > flag to guard access to its specific DLD register. It seems than
> > other EXAR SPI UART modules also have this register, but I tested
> > only XR20M1172.
> > Yes, in datasheet this register is called "DLD - Divisor Fractional"
> > or "DLD - Divisor Fractional Register", calling depends on datasheet
> > version.
>
> Commits must stand on their own. Cover letter is not merged. This is the
> place where you add new hardware, so here you describe and explain the
> hardware.

It is also described in patch 3 in the series. I need to repeat this
description in patch 2 too?

Cite from patch 3:

XR20M1172 register set is mostly compatible with SC16IS762, but it has
a support for additional division rates of UART with special DLD register.

> Best regards,
> Krzysztof
>

