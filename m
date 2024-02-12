Return-Path: <linux-kernel+bounces-61976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87F851962
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DED31F2291D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563AC3D55F;
	Mon, 12 Feb 2024 16:29:35 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF923D0A0;
	Mon, 12 Feb 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755374; cv=none; b=tbK5yJ0cTRPqxaT8wmV2IdeY1FGlnhvdAdRxR2BG/YnFCxUTHYp5yT32lFLUHXJym24VyHkaINARuEWnqsEoDargyV2XxNopEjL3K69Pbvzg6v7YW6t29dDLfl/G1uKdzRJVuGbrNs7PIFW1x5MwAW2v67XoDguvI9nOttj4QSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755374; c=relaxed/simple;
	bh=kjdYXtW0dzh6kTs3nxWBA75lsnQ4hvAZA7R0V3EAhzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgT2A8CWdQvT2z+jSYFU+EJjsAk9tO+78yWqR6MjUtOqaBQytu+BBGCL4J4LHS/uHirDyhLTAqma74PWfZVeX5Wu+lV+oUkAqX8ep9J1EgWEixWUirzSQMsyE6i12SrKCcKcdy3Z/g2447nchHcbehNPv6IPt07j6fxTn2LVJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6077a99bbf1so2085377b3.1;
        Mon, 12 Feb 2024 08:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707755372; x=1708360172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMMgeYKVED6CfJxdYuAOnKZRGq8dCY2fP6QlD7Y2V8w=;
        b=WnKNZgOWu+ZAsyh7WwBewsMRP+Z7Ww70c8pzJdPKoatHwBhVgDoCHDbvVIiUHcBAqX
         6mHzS6niGQbQ++pqWcUYEfELQ5cCfa7ljXwZvr2kyF3aeB8z/IDejDJyeYwrAIubmUZ+
         yzFdOGBMcy8hn60+Gpre0SaDBTYfa5dbPBYv9hAHec313RbyZVpm4xQnkBnm82c+gfYV
         vjdnMcHZ8Y0+Xcmjc7nbnJ1yeAQhrv5+DqyvZtSHB0aMGrzgyFsmbMYJkq4jqkaWFaRn
         OE3o37fdr8v8iPRdGHvKRp287GvMezAQfCOxAwSavyeYL+1F7ykVrTa/uDHs8aq48Z6p
         OyvQ==
X-Gm-Message-State: AOJu0YzZypynNYmWVpKhIkhF6gvfjqm2it3z+IQBOEnG1oLH+BnBWmsb
	BT4AQfkleKZizCK+HIUhRe1CiZLsgApdyShWl2sA853vxopywVHVGO7BghjJqrc=
X-Google-Smtp-Source: AGHT+IHsCTOPigxmrLnHkTh/5Ei/TmYTJR75lDJ1kLoJFjZBTe5Tl6zFSmDP60WZvNNR5CYpmsfBNQ==
X-Received: by 2002:a81:a0c1:0:b0:604:1f23:284b with SMTP id x184-20020a81a0c1000000b006041f23284bmr6880ywg.11.1707755371963;
        Mon, 12 Feb 2024 08:29:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXo/3aaRhyjsbei87Q8i2t9ZTisTVWPHgOBJlmwk5kRN+6LrH7N88UtbLxdC1dSPfmY1GXNN/fmdGp6mgdRIXeLQbZm6S3N3O2lvRuSUmlkvJL/qtTE/u+ovacD8A5stMZoCSfIAs+SfNuk9deTh52/L+nLe3LzdcTZGbs2EsT4G00ReMt/y48nPMYQ
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id ee4-20020a05690c288400b0060778320f39sm101511ywb.1.2024.02.12.08.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 08:29:31 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so3607432276.0;
        Mon, 12 Feb 2024 08:29:31 -0800 (PST)
X-Received: by 2002:a05:6902:cc3:b0:dc2:5512:b6d9 with SMTP id
 cq3-20020a0569020cc300b00dc25512b6d9mr6182ybb.12.1707755371673; Mon, 12 Feb
 2024 08:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205144421.51195-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240205144421.51195-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240205144421.51195-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 17:29:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWvOH7W_h9uvC1fdRjpneJapNsOFb8k96Et2iCgBGabAw@mail.gmail.com>
Message-ID: <CAMuHMdWvOH7W_h9uvC1fdRjpneJapNsOFb8k96Et2iCgBGabAw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: r9a08g045: Add missing
 interrupts of IRQC node
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:44=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.co=
m> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The IRQC block on RZ/G3S ("R9A08G045") SoC supports ECCRAM error
> interrupts too, add those missing interrupts in the IRQC node.
>
> Fixes: 837918aa3fdd ("arm64: dts: renesas: r9a08g045: Add IA55 interrupt =
controller node")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.9, once the DT bindings have
been accepted.

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

