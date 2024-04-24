Return-Path: <linux-kernel+bounces-156952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE48B0ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAAA1F231B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76415CD4A;
	Wed, 24 Apr 2024 13:24:53 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641C15B57E;
	Wed, 24 Apr 2024 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965093; cv=none; b=Gt3d9qHyi48L6wSLmp5ZJg8yXFwE1/RTet3dLTMU60HUXcDW9DqY46220b0afe8pgxVptquRNWvqJ2rCho+9K1mFvye5oYM55qxTeaWWJPxIfEPNHKBuTeFGMNbloEVCSrg4bN+6qclfa/FYETAaX3tJMfsfWPe4+XKOLaLD0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965093; c=relaxed/simple;
	bh=8nSpm7d+EszE3CIUChwqBFG5Zc2nEDoIt/NW+sy6Ky8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETX0Ih8q3DYuutbiWmAyU9ZoAJSxEMirVfolF4dH7SG98krUEUoO8g26NkwpAKumE9YphT9f+mOX64bUUBdQXeVZTkWnCvYsyZP4TL+JY236EKyTti0UjXm+i8utTi2ppQbZJ0d1ccZHsCpTNI3w/2ToWERwyKVQmaFvLaYAT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-617cd7bd929so71735667b3.3;
        Wed, 24 Apr 2024 06:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965090; x=1714569890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51puU55Boep6afXIofcFUmMmV+ZDqAsVB5VCzE6Soos=;
        b=gVh2Q19QZxkE3Rv46f+eGxshgQByeYmfk9we4yh1aDVf/tnKwPgjbP1WQQtEz5yDcW
         7/y3eV29GN3JsEsR1vZBV0KuuNbsicj0aSl6B7+FMsgm7WZPFdLq97HecCF6jaOtr8DD
         tPBgMf1SGr0ILoJUh2sZcUAdVjareuVvWoOFCaC8Hceu0Ayew9covjixGzmy3fqPmhxT
         cGrUrz2tqbjHrAYEZwRXrpFwYilDoe+Gz6xwCVgK5qyBaZjLYWFuUzLHB1oB+AamOtXw
         ioqJhhKoiU/QcXggoLIHK6rZU5XO1Qfhq32NhGwxTYqIyXNXWTErumPk/aep3pNux4ew
         tZng==
X-Forwarded-Encrypted: i=1; AJvYcCVn6qBQyknDR8KmZFWub72L/8zxRb4qjXVCBdFbLwTrOWyy3vyBD6UomTM3769pm515RpemBFDEiLlhwg9VeEw73rhuu/YQoiU51Bb3ZPPvps4V7rOM4vV7rRx45BVzbuoplK3ktQ4ByAhJp4qBLt3fRqc5Wq8nj7BvCfNkViDsV1ij0vaSkKKB1Qtb
X-Gm-Message-State: AOJu0Yz/clEqJM/Pgetd9evGl/F/SqSH7e7WKMQ9fqiwo8TNNpmlOezM
	YrWwZO0JhMiMp+JU++dGafOPxJ/P0hXnxY5SyvCBfCt2Pay5xxhM+Haj/zG9
X-Google-Smtp-Source: AGHT+IGg+QUbIiGMOqaoITdcCaCCEQE4L980zRDOVEEGiMJIAAQ8PPAUcXL/EDLKZJ3hoIK87LDBMQ==
X-Received: by 2002:a05:690c:f12:b0:61b:3304:ce04 with SMTP id dc18-20020a05690c0f1200b0061b3304ce04mr3137328ywb.34.1713965090336;
        Wed, 24 Apr 2024 06:24:50 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id x135-20020a0dd58d000000b006186a9d32b0sm3010003ywd.43.2024.04.24.06.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:24:50 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de4665b4969so7032902276.2;
        Wed, 24 Apr 2024 06:24:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqDxsUjzBl5NDYfu2VvC2j4DizMU8s/S69QkJI0Az0jwYvLtQg0uoC/Byi7OQUOd6xQP+8cNkIhP6TYItxKv87rhI7EBCE8OicaeDxJi+sDtqtdD5LXX6Ufuq6dGVfoz0yJMcdh/dfdRcMjjXB9xld1ADT9sLwoyI2AXGFBD2rRMxiGOIRStPCaEBj
X-Received: by 2002:a25:295:0:b0:de5:4bb4:25b9 with SMTP id
 143-20020a250295000000b00de54bb425b9mr2790709ybc.12.1713965089779; Wed, 24
 Apr 2024 06:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417114132.6605-1-paul.barker.ct@bp.renesas.com> <CAMuHMdWq2y0ELZpj38TZLequjB_=5_1VQe-1XCBjTLmW86xjog@mail.gmail.com>
In-Reply-To: <CAMuHMdWq2y0ELZpj38TZLequjB_=5_1VQe-1XCBjTLmW86xjog@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 15:24:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRwCZeuR9mBcHX4APo43u9F=BhsW9g6vJqk_9UNVhuLA@mail.gmail.com>
Message-ID: <CAMuHMdXRwCZeuR9mBcHX4APo43u9F=BhsW9g6vJqk_9UNVhuLA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Limit 2.5V power supply to
 Ethernet interfaces
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:24=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, Apr 17, 2024 at 1:41=E2=80=AFPM Paul Barker
> <paul.barker.ct@bp.renesas.com> wrote:
> > The RZ/G3S SoC supports configurable supply voltages for several of its
> > I/O interfaces. All of these interfaces support both 1.8V and 3.3V
> > supplies, but only the Ethernet and XSPI interfaces support a 2.5V
> > supply.
> >
> > Voltage selection for the XSPI interface is not yet supported, so this
> > leaves only the Ethernet interfaces currently supporting selection of a
> > 2.5V supply. So we need to return an error if there is an attempt to
> > select a 2.5V supply for any non-Ethernet interface.
> >
> > Fixes: 51996952b8b5 ("pinctrl: renesas: rzg2l: Add support to select po=
wer source for Ethernet pins")
> > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-clk for v6.10.

renesas-pinctrl, of course ;-)

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

