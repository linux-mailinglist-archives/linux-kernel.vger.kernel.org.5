Return-Path: <linux-kernel+bounces-44510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51D184230B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2809283F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC3B679E1;
	Tue, 30 Jan 2024 11:28:41 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3FD66B4C;
	Tue, 30 Jan 2024 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614121; cv=none; b=fXYPFHk5rt7oFeKKhLfcF6ST02nVBSHBHx42k1kfoj068LWIpjbOqTivuVIVgGGCuO5ESLmxMkzfJ+hviDq1d/RztgiZkomgwH5SORWcHBYeMI2QHqKQsg3bDHR4EgboZ5XPUv5EVKcRFbD7Fo+zih50iyU5MPJjJK4mv9QKgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614121; c=relaxed/simple;
	bh=1aI1fPeO95MbVGGpdfdHLRoDLvte8kEVgs8+Byqu/7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjaXu5CfXbxh2bMnuf9/j3ibXEQiE+UpDUb1Ibzqgvb5uUYx0K1qf3SCmu2q6Gt+oBLa0eSAfpjKxQs4BsDflG0fYLugADMNZ/TDq38SpMFxkmyie7JuXWohqtOBTFvvRwW3lsf7rPraiihK6uiJzf+IjTtmXQgeQkHUVR4p7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso4716376276.3;
        Tue, 30 Jan 2024 03:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614118; x=1707218918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W54hXGwyrXiKIUUpJUiH2UqyDwulWdbv5HbLIOlRE2U=;
        b=vGzhvFGmVdAj7vQ+M0Udw2ehd+MQrnkYg6+SD34pitIQmmif9ukA07ky7Ub+/jmT3I
         D0Gc/zKkQgu2Csm7+GgVgEMUV92/z2qvE2kspXlAdXQ1bUMRvLgaMky6ibaoG+Ardb4K
         JhUxUsTrdzWi5opbwM881Bly1OiFNhMCQKJE2XEFzvljAsa1uNfDeyJXmLflDNaR6nh0
         rsWGSTv0znFE8SLJX6UUl0o6vmYGfGfO/WjR8qo8R/NPTQLDPQ0zR4pQA26oRfsKnbLI
         4Opj2LAxH80MWiLgSlRj3Jp2kdFjy/csU6qEqUQsYFp4boS9O+mJsbEXNeL47O6KxPrg
         HSJA==
X-Gm-Message-State: AOJu0YxDjXJMDy4ZKHyC5UUr5KujkcTfrWvqg85egnXyYA9y/FDVasvo
	cybOfSkP5USQa2WHua3rVN5OJzc6Cu9CUf8vq3I7GlqgoN5n1j3pP+HXynITVcE=
X-Google-Smtp-Source: AGHT+IECMtMhJ1NiGMXLWVON8J4JXLu/ww1XWP1ZrNRmrV57D2Zu9XtmD21gTeYvm7/cXt/jdLIlHQ==
X-Received: by 2002:a25:9b44:0:b0:dc6:9c4f:9e7f with SMTP id u4-20020a259b44000000b00dc69c4f9e7fmr1249661ybo.18.1706614118478;
        Tue, 30 Jan 2024 03:28:38 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id o12-20020a25810c000000b00dbdaf5980cesm2846574ybk.35.2024.01.30.03.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:28:38 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-603e7d19725so16326487b3.0;
        Tue, 30 Jan 2024 03:28:38 -0800 (PST)
X-Received: by 2002:a81:be03:0:b0:5ff:a3df:9ba4 with SMTP id
 i3-20020a81be03000000b005ffa3df9ba4mr7021538ywn.48.1706614117959; Tue, 30 Jan
 2024 03:28:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240129151618.90922-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240129151618.90922-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 12:28:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOWw9jQytipok-BM2yThJgtpaJte-ksjF1VuDmxHhmJg@mail.gmail.com>
Message-ID: <CAMuHMdVOWw9jQytipok-BM2yThJgtpaJte-ksjF1VuDmxHhmJg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: renesas: r9a07g043: Move interrupt-parent
 property to common DTSI
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
> Now that we have added support for IRQC to both RZ/Five and RZ/G2UL SoCs
> we can move the interrupt-parent for pinctrl node back to the common
> shared r9a07g043.dtsi file.
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

