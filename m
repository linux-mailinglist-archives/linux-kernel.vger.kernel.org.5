Return-Path: <linux-kernel+bounces-81520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B78F867706
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAB21C298C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF07312BF04;
	Mon, 26 Feb 2024 13:43:25 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103B1292F8;
	Mon, 26 Feb 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955005; cv=none; b=eXIUb9jU1GA30AJU28VPHocszSNsWfwiU0lQlSe8DQXC6YNDZezSBv0ZhV7HS20aweCedfIz8n+jMNtTsxRNBJ4JEq2T1gkBPrYqfZRdjfB2qYQ3OAqqC9TL0pzUPMaq3YqO7nokuq8DArVVjAmjLHRoBCtUZ/pTIJfeptyKeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955005; c=relaxed/simple;
	bh=RMaMDukZMXIW30ZqzDmi4oK3iGTbNQKGJKlL9l2GVQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frRPHNLftysQx6zC1jaeMSHNYEq9i56sXgZ3H6mQAdBWH0+3DcLyTAlOPIry36+lR7CuqxS1WLvgTUQyBOLF1CT/axrSK6Acsf2ltU2IHifTNGLgfOCRxL4leTWlJjP43qH8WVvID7Ae6W9Mj5lBuP0el8yrLoOLthcFxJAf7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607cd210962so26950017b3.2;
        Mon, 26 Feb 2024 05:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955002; x=1709559802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXbzNzxD2QvcR43SQYn2w2MSviNt6l1t3053K4P2pIQ=;
        b=hjkcM6Qgnx/aaaUvS6ElXztbjsWisBWxgsHxoW2PcJPKuz7AS/cQpdTcBgGzmT3J6W
         bSn1ofHts+08DKYlVkBaArihxh2/1ZpcGlqkt0ZcUC7C+mqQaK1C3iLSwpoPvbIgzsEs
         jMYY+D8QPuV5xgKs1xM9bIeZzcuTUYv+aVVUWlTdvsBS9/esi8vuDn5Wq03dXvi7K0H4
         TO0Me29ghyPtVf+HSwJAjFMpgCzsu0rNa0JkDZ/3N+cLrTDXV2f10O8DcBS/2tsjPFWl
         4/s5Av9DLi2yqCPnqHMeszfC/VffxChMOTiQvmC2knOqYLsY/k4WyW77SXA8adLb9IE+
         OTUg==
X-Forwarded-Encrypted: i=1; AJvYcCVBUOYjyhwbVYf79/G+7pvSJjMwvjeVLagvET8X2FTJKaqHNZniQXeAThmNtOntzlsABn6Tnlmt0L8+AvmOfgtpPZQZwph8m01yJFCtQ7XWLlHubHAjXEOxkamwsj/2rlI0QG38zSwYtiXrM4RzSjuSQJCWyecz6TaDUXDMrD71cbWgP6j2+Bgg1bs+
X-Gm-Message-State: AOJu0YzxOU+n2J51lPU12xOI10VJvwocV/4FUEVUjbiAsGVg17R2R+Hd
	Rr8Jt8zzS1fyFrnylq+DI27ieB2LIY4xRP6cYhXO/fMN10EwQdjl28GWm3F5FBg=
X-Google-Smtp-Source: AGHT+IHPulmOMgEVSacKsv2Hgevjf2BdDKfoxLi5ZoioPhyBw/bYwiVTRO5hB92ZZ70OQntZqYajLA==
X-Received: by 2002:a25:d80f:0:b0:dc6:cbb9:e with SMTP id p15-20020a25d80f000000b00dc6cbb9000emr4826148ybg.41.1708955002369;
        Mon, 26 Feb 2024 05:43:22 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id m187-20020a2526c4000000b00dc73705ec59sm961990ybm.0.2024.02.26.05.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 05:43:21 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609018048c3so7352377b3.3;
        Mon, 26 Feb 2024 05:43:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXnEDi1r4QoNDNDiaBZcm7UYYQi2q1JwgDkZCk0K+J1MIOT717lJwerbJEJE4pK6teKDaIs7qzUDnld6d4ah4V6+Ov6OecYAnsh+ut4SNmGzU7FdniHj5x609f6KOHbXv5Q61/6imn3N0b0vbD3XoSZdeyyHEc1eijqmojMX3mYqZ6o8N8Xkq1Fgml
X-Received: by 2002:a05:6902:285:b0:dcd:2ecf:4c64 with SMTP id
 v5-20020a056902028500b00dcd2ecf4c64mr4437356ybh.34.1708955000837; Mon, 26 Feb
 2024 05:43:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240219160912.1206647-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240219160912.1206647-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 14:43:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAFJPN6KQuHRi1A=FQ=FunjLS6FG3r2K5T9V0C4BF-Sg@mail.gmail.com>
Message-ID: <CAMuHMdXAFJPN6KQuHRi1A=FQ=FunjLS6FG3r2K5T9V0C4BF-Sg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: defconfig: Enable R9A09G057 SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 5:10=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable support for the Renesas RZ/V2H (R9A09G057) SoC in the ARM64
> defconfig.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

