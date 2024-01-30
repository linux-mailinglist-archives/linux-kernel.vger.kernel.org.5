Return-Path: <linux-kernel+bounces-44513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30639842317
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA49E1F2B081
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933E96775E;
	Tue, 30 Jan 2024 11:30:36 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC6466B5B;
	Tue, 30 Jan 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614236; cv=none; b=czSbpQ6s1w+OcII2dDmnHcKfHNTk6a2ED/fnkTxaR9N+3EF3F9YmLEfVT3iBycLoqB4v0qnmuef4+MemVKRgf+EvWbqyXsQFgsXZDS9XwY1bYN3eiPujrZ7kR+QolMJrfzyt7YOMaSjqKpOQssyexB8R8Sj5KINJQ5pvZNbOWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614236; c=relaxed/simple;
	bh=aPwVSdgNb2lpDjxd5+qOm/0CKHj0VgtsG12CFe8DFSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM/+cRjiVVx8bxtmd3fxJqriiwwavALg7nogWXs6wtt59+CoGHRhnM2vLjjeeo82PtVTbUuBquff06790FRvjyAgNIubTAunoPkAaY+9yagVCk34mf6GlJLyRBLHR0OdITgmyaFoe29k4Oz3+19muYK927LDyIDifiMbYot19NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff7a8b5e61so35940347b3.2;
        Tue, 30 Jan 2024 03:30:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614233; x=1707219033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jUIV76EfqiSCLTOlQ3xpsNr/TvqMGBmwC/ORazdxeY=;
        b=i7/ahYAAXHRobtTNdtQr8jbarcgJqm6WZm8BTPSfWc7LziNlkYD+Mjz/+NSB9wjbf4
         EAGqaHT9k/yt6W3kpfCFXCfQU+0lZNX0FZs/SKEXePmP66rUt1QU+xTW72uZ6a7FEMI0
         aoyc71ubmvjiM3d5sEsv1IoW4vgNEm1wwG+bZgjxk/BfaSBZP6iNtTgtKhm+BYJjxXLQ
         r9zsrA/YdptxkmDC58GzyTaT1qcWyEa9jh5af1WbPdCvnLWya4FN+5bCH5R5G5KfTlXA
         tkSoXMKgSTNMegSk3X5c86PlcC8KFF1tgVg9H+KphB9etWligqCKy26uMgB95IV6fSgG
         iG1g==
X-Gm-Message-State: AOJu0YwXZ+PO65maBD5J3uiuMfhWRxV/guznQA8rBjt9HocHfDLjT0zM
	hM+bGPtf0+yKgMKyJ3Rv+xFxA9vZqt2QaMgAzfo5BQtP/mKxMsce0ho3xpR6ba4=
X-Google-Smtp-Source: AGHT+IE0hsCBR+luoDJu9Adz5yctBeT2ENjb0RIa0H0x2PlwQnlP3M1CLf+nNcxfRVdX3f7AY4setQ==
X-Received: by 2002:a81:431b:0:b0:5e7:ae43:e90f with SMTP id q27-20020a81431b000000b005e7ae43e90fmr5343520ywa.3.1706614233384;
        Tue, 30 Jan 2024 03:30:33 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id d142-20020a0ddb94000000b005e7d8d6e446sm3173958ywe.93.2024.01.30.03.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:30:33 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-602d0126e80so35786117b3.3;
        Tue, 30 Jan 2024 03:30:33 -0800 (PST)
X-Received: by 2002:a81:af21:0:b0:600:2710:1e51 with SMTP id
 n33-20020a81af21000000b0060027101e51mr5585278ywh.13.1706614232794; Tue, 30
 Jan 2024 03:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240129151618.90922-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240129151618.90922-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 12:30:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAuvR55NZtq-0N32kh-W9X5V30mA4bzkqER=kGdsb_eA@mail.gmail.com>
Message-ID: <CAMuHMdXAuvR55NZtq-0N32kh-W9X5V30mA4bzkqER=kGdsb_eA@mail.gmail.com>
Subject: Re: [PATCH 5/5] riscv: dts: renesas: rzfive-smarc-som: Drop deleting
 interrupt properties from ETH0/1 nodes
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 4:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Now that we have enabled IRQC support for RZ/Five SoC switch to interrupt
> mode for ethernet0/1 PHYs instead of polling mode.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

