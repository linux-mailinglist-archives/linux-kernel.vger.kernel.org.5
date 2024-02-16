Return-Path: <linux-kernel+bounces-68709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD6857ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85321F2165B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B047612C80F;
	Fri, 16 Feb 2024 14:09:43 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC212C532;
	Fri, 16 Feb 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092583; cv=none; b=e+dUXg4txkHby2qrzdxm9lSqVUKZYzNVtOXjUlqjwXB43PbdwGp4lhhNswe7mZzD2aDg44Xjz3h/QdHatgVPRyxpJ2aSVhnUVZgpeZCe9ZJDHwg6Ppm22+4Iz6XPIgkzPGaygGzHSdkY47xsy2mqvAPi9L80aMq/b5I4GsDklbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092583; c=relaxed/simple;
	bh=d+jq1UHl4KnjCV5rmMiapLA/SGzlIA3WR8dxpIrYfbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzdLhbJqqtcqj7l4o6sSn/aYJxJpD2eiwnq7II7rheBNQ37/tPwwFBJywQXeuwc2cz0XnTBaQ1ChGxOhLv4999MaTd8gePjQIS+3y2XYKTHKrwozuLKlBYDxqXDYsazF/LflrZTgyDWhG7Qfce4aOr+rvkQ2d7Ma/jOdw3VIorM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c0496f494cso1912098b6e.1;
        Fri, 16 Feb 2024 06:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092578; x=1708697378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXpydOa1GZBXod51r6i4Y0/sHZuwIIC1LzAR83s7/AE=;
        b=cI/NSi+GhBl27AXCfvDcvz7Y6pA4YtLKhhumNIkIEYMahiKzZE8/xDlS5LwmbD3GOF
         tHEkLa1she1u+LE6RCn3Pc5iJecBSUZUpGdi30Tr/OAvVZmG31lzh52BfkYNPEl31/95
         Gqe+lYw2SsMyV8mqanPdAKKTjDIF/1YBVbBauv15JzeP02N1BNwQQxO6KMMBBTrIO3g2
         rTI8LGQ65qQ5slA7McjMSdSyMV6cjzRBPFipB+bZ5XkWbHbfWTcgQyahAIXoBWLJTAnv
         J5w2hNbu9/EvZLy8JWSxPdjZI20LfUBTWjZJfcGkJkDCijM0IfPGnEOI2d/Nlq4GIAmh
         KQyw==
X-Forwarded-Encrypted: i=1; AJvYcCXf1VBRq/hnxp59/Gwn6h9vbaaNLwTYoif86GdCRVglh0se3+QqhFsOv64ESGEhnyQgKjghg39BXyHTILa1mseak0yCkXVpn1+IbgghLEq2V4tpNAbM+nDgHlhpTCyY5x9i9GjK4gq2kIFjCesRoMDBp/P8p9cBsOkvG5vnNkRwEq69cx8jwaFJior+ajZnLqZ5XlYOnN4g2RVqwhWYDUUMQydPqKbM
X-Gm-Message-State: AOJu0YwZRKBdVFw+p6KBml3ZiIddMDj7s0QuAFyo9UH75c5cnsp98pEm
	U6jWzSjXYw3w+NBQLEqzJ4N3DTZ5fMi1XnAEc3p7YcRWgO9W3/PM0dMKRFz+Tpk=
X-Google-Smtp-Source: AGHT+IHYLhZBDM2c7KnFTh/RQADVXJkyetQo2W/vMV8tKcAnvHXpB+zlckgaROck9CConOHcjYXNpA==
X-Received: by 2002:a05:6808:209e:b0:3c0:3d8d:7f86 with SMTP id s30-20020a056808209e00b003c03d8d7f86mr6302099oiw.5.1708092578191;
        Fri, 16 Feb 2024 06:09:38 -0800 (PST)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id t14-20020a05680800ce00b003c13787306asm520620oic.56.2024.02.16.06.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:09:37 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59a87156cb8so649678eaf.2;
        Fri, 16 Feb 2024 06:09:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX75iAoPcJCKXT7CCaFpPGtb0Jj2JkpsHrtfyWt4L6I6q51SU25hDtPK/J6bQZyyYv4IsZc/d2KfjR1ZIWkGt/PYxMrAIrWSdfUluLZ2fRiR0FzTqKFbpJe5f3uxJlXOSI9/Ala0l4DNQRl6A4uIfu/H1qO2+cj5lyD82fkrpAMUziiOnGN4L8MA7aWxabDCl746hTuU/K3GtyrHFh3He2t05OsT2Um
X-Received: by 2002:a05:6358:63a2:b0:176:a071:5ce1 with SMTP id
 k34-20020a05635863a200b00176a0715ce1mr5968961rwh.27.1708092576933; Fri, 16
 Feb 2024 06:09:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-9-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:09:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=qpVCokRW1vGDS3_ZF3RE0nVcNi9URXMNS6bUtxqTZA@mail.gmail.com>
Message-ID: <CAMuHMdV=qpVCokRW1vGDS3_ZF3RE0nVcNi9URXMNS6bUtxqTZA@mail.gmail.com>
Subject: Re: [PATCH 08/17] clk: renesas: r9a07g043: Add initial support for
 power domains
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Instantiate always-on power domain for R9A07G043 SoC. At the moment, all
> the IPs are part of this domain.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

As not all IPs are part of the always-on domain, I'd rather defer this
until all domains are handled in the driver.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

