Return-Path: <linux-kernel+bounces-44986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25418429FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE85928364B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EBE128395;
	Tue, 30 Jan 2024 16:51:30 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD6823AA;
	Tue, 30 Jan 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633490; cv=none; b=c8/3HazJcFJJD/v3gOvH0N/YSgSaRaEBqW0K/8PDfNP0Z/28MMm3sh69O/1k0GnjnuMG/HrmXrm0aRtsupi9zn5bv3TteLmR8SrqykAVf2Gs1XgEYQC3Vsw3WhD/u4xWkwMl/QAOPdDfVoamr3FKSxISqy7Kycg89CzXfLjvUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633490; c=relaxed/simple;
	bh=0zXEGBe3rQJRJDJY4/A0JzycUKo8LnyAQtgIFKQ5uxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7wV68dvk25aPJLbiN5610YrCNOVN+cej1Htt2t1zx594M9uYHn+q9rtwHHpSJgqfOSKPRKsf6HNbzITAoYTnYjdS9+1AyHLs0rs3n+DgqOONMXrRa2tuqApGbCqwHMpgXfMHPaxeRNIPuN8k6VOKlTs8xZ5znLVroaJ0z7u7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-206689895bfso2531037fac.1;
        Tue, 30 Jan 2024 08:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706633487; x=1707238287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlXDkIv8FQPmQiZACdJ6n4cEenWV3IxjFKgRVnotTlw=;
        b=WoKr5MbEqSYdtezlBfhDDDYnSAczTNjpcvGzXtt84QGoJVdm+EezcsLfzMuEcO5cSQ
         UfXlsxA15Ms48Nd70qo2Ld5Z9OwELhMtbDP6RSol4z43KxOs5bm3e4fr1DlP6n1fPOLr
         +bg1S8YcXzp27Xvi7hKkWnq+2SeA6VBsmyjIfNQGjSCY2ThbqdSf5rC0BJNFtstRoYLv
         cGZbWObm7N8ABrMCmyTCEuQRONALgNyNsv8PJiKMszlHlqYRO9uSndQ14wcOFIcNgXTq
         MrOLfpu48iS30B0YFCNey/pgiFlLSnit+TZKt98WOPMHncvAyUTJyw/igOJZ9e6dv1O6
         K0tA==
X-Gm-Message-State: AOJu0YxlYTtyTewH8vVhG9zU5gtbf5urg1SG0FrSO1wGChuyjTd8FUzt
	7liE4nhureF4Q1Wipve/1gJJSiSvbpIwK0RaFM+qR65ek3ZV5TJp10hN3H7XXLc=
X-Google-Smtp-Source: AGHT+IEK1O3EQD0WgpQ495P+a9PyCS3vV3DXDRSHWuuwOHNYtYmcaDgtEv92zz+A/LnIx7H7lG6VEQ==
X-Received: by 2002:a05:6870:3c16:b0:218:45ca:ff78 with SMTP id gk22-20020a0568703c1600b0021845caff78mr7042228oab.18.1706633487436;
        Tue, 30 Jan 2024 08:51:27 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id ry11-20020a056871208b00b002149bb5d09asm2596541oab.56.2024.01.30.08.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:51:26 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e13c6e6093so589415a34.1;
        Tue, 30 Jan 2024 08:51:26 -0800 (PST)
X-Received: by 2002:a05:6359:c24:b0:176:915a:c7b7 with SMTP id
 gn36-20020a0563590c2400b00176915ac7b7mr4654489rwb.31.1706633486345; Tue, 30
 Jan 2024 08:51:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com> <20240122111115.2861835-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240122111115.2861835-10-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 17:51:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUmp4ndAk5emKEj_NxwpKH3A5HG+B4gO4CPGxRvgJzXQg@mail.gmail.com>
Message-ID: <CAMuHMdUmp4ndAk5emKEj_NxwpKH3A5HG+B4gO4CPGxRvgJzXQg@mail.gmail.com>
Subject: Re: [PATCH 09/10] arm64: dts: renesas: r9a08g045: Add watchdog node
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:11=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add the DT node for the watchdog IP accessible by Cortex-A of RZ/G3S
> SoC (R9108G045).
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.9.

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

