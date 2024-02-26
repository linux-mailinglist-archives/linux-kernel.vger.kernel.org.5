Return-Path: <linux-kernel+bounces-81776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBDC8679FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3DA1C2A65F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E888712FB3C;
	Mon, 26 Feb 2024 15:15:13 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85B129A67;
	Mon, 26 Feb 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960513; cv=none; b=aohE1ah+DjhTryGJKFGq/d/xJbXuVR1Qv4+lp+OaVNoCPpls/3zHvbrrZos9ZKYdQcl4dgVgdLVYmjf5wf0Qma+RuHY5Pt7L81uZArpC6zUI1AHelizKOcnKDNrl5ebshPP2O0M+vKSZwgoW2f9p0hf3ay1ylkGd6MXHplRUeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960513; c=relaxed/simple;
	bh=RNN19LEMfU8oavS/hFJ6FgDDa769rf1/Lj0QRHGTGIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNDZxtyR2vXWE8amxs65UQx5OHm/OaPXm7krwPOSDk7vLNIjtF6WCPE6KpdOhcZ0GBXcvzUQ/rzhB2BwDw0sK4KK7qHTWk2f/dMORrd6wuF4g01j9Qe2Mjl375VL3AaVWqlTH0JaRNRA/zaZBZBlO5REeR45f164DhaBc8pc3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbbc6bcc78so2457590b6e.1;
        Mon, 26 Feb 2024 07:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708960509; x=1709565309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlIeJulIzsSVjK0Qpn95Yls8PTKvg3w46WPM+nPUG/c=;
        b=GUyV3bzxbcj5I4IeeKMsk5QwFx9Ly8DjMJrB3QN5k0YCfJVSrMu3E6WMCEHpsdsgbI
         ALsGiVblJkN+KlXeaKs3vwYz6+l8C69L7/YMFfzBfcVHiu12kYuyAElDkyqrG+FrWUwF
         ZHmUxp2zkuyCHmcFrnHLlkJzGuexZi+tQHhBi2UNd6LQ5E/aDjvj5NJwpWXbbI3nMKK7
         tY27hweeB0iFeNZzJpYNX63ivvJrCHJ9fN+jqtKyd0aEgNWXLYy1B71AjPEc4Rt9cfbl
         597N41UoYrQv2uYRB9GuM+qLYjEsIULn908Qmp8Mu2TeFQ1N4aeollfZzeDusbnqPQuL
         qFgg==
X-Forwarded-Encrypted: i=1; AJvYcCXrFDi7PiRjEOV3+zk+IhqfA5vMMSoZgabya0tOmyDkaU8Fluysavr2i8EuUITqsB+PBXr1LQpOLylRPQeEQenpFAmCsn06vWRKy6akift5Usf82RPd2A98ctYom/u963/PiNmUX42zaOH9PPZOIUY7cKba9jegQw9uq00SFJhXiTzPAnDaAC5WZhi+
X-Gm-Message-State: AOJu0Yw59N3O9t2NR6kxlj4xeCONP8xdKdrqZFZL8e0NGGYOc74VlDUl
	Hp7QEtOYgWuEBghzeU1dsgMjD58E8WP9zTLUIdDcCRAwars3369M2tlAlHr6n9E=
X-Google-Smtp-Source: AGHT+IHPAMOAL6ln5UwGo/zTXXw0VYJvOh2mwq6G6oMliRSTmz+IbB7gsRaOYHCIqDkVaSUP3sslmQ==
X-Received: by 2002:a05:6808:1a04:b0:3c1:aa84:6c4e with SMTP id bk4-20020a0568081a0400b003c1aa846c4emr717205oib.32.1708960509408;
        Mon, 26 Feb 2024 07:15:09 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id kf17-20020a05622a2a9100b0042c1ce79b4bsm2550581qtb.50.2024.02.26.07.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:15:08 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso3183296276.3;
        Mon, 26 Feb 2024 07:15:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1sQNhfz+82LjiYsADSNGz9fozJoDVYDCvFX1vTRBogiX66JzUXPgzrSU9QirWGrdLkLaYstYwFlHSrMOFIqNFdQwoLmd/n+S1fRkH72oJ1TWcNL0IjGWn9L3kUzx9MhZT7B/Pzj8MLrLBvg1SAdN/mVGWw+XGwqAg+Jsug2TLnrA2OW8ZI6TT4NYf
X-Received: by 2002:a25:ae99:0:b0:dcc:4cdc:e98f with SMTP id
 b25-20020a25ae99000000b00dcc4cdce98fmr4795296ybj.34.1708960507928; Mon, 26
 Feb 2024 07:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240219160912.1206647-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV3eVTek9sYwXbqu98ta8wx197GMc-k3q1RZRb8ar=jFg@mail.gmail.com> <CA+V-a8uNaRL7wE0SmwmiCq3o798-2Kd-fegKJ2Tep5mZuS2O2w@mail.gmail.com>
In-Reply-To: <CA+V-a8uNaRL7wE0SmwmiCq3o798-2Kd-fegKJ2Tep5mZuS2O2w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 16:14:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWwn2nVx=vebT+Egas+b_dt7d28eN_ykrA+ckZ2GPuXHQ@mail.gmail.com>
Message-ID: <CAMuHMdWwn2nVx=vebT+Egas+b_dt7d28eN_ykrA+ckZ2GPuXHQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: arm: renesas: Document Renesas RZ/V2H{P}
 System Controller
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Mon, Feb 26, 2024 at 3:01=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Feb 26, 2024 at 1:41=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Mon, Feb 19, 2024 at 5:10=E2=80=AFPM Prabhakar <prabhakar.csengg@gma=
il.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057=
-sys.yaml
> > > +  clocks:
> > > +    items:
> > > +      - description: Clock from external oscillator
> >
> > Isn't this SYS_0_PCLK inside the CPG?
> >
> As per the block diagram (figure 4.4-3), if we follow the clock source
> for SYS it traces back to 24MHz Oscillator. Let me know how you want
> me to describe this please.

Yes, that is the diagram I was looking at.
MAIN OSC 24 MHz -> MAINCLK -> SYS_0_PCLK.

MAIN OSC 24 MHz is a clock input to the CPG.
MAINCLK is a CPG internal core clock.
SYS_0_PCLK is a CPG clock output, serving as the SYS module clock.

I think the standard "maxItems: 1" would be fine, and no description
is needed.

> > > +
> > > +  resets:
> > > +    items:
> > > +      - description: SYS_0_PRESETN reset signal

Same here.

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

