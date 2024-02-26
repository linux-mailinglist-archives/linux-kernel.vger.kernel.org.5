Return-Path: <linux-kernel+bounces-81366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAC18674E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA157286B19
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817506087D;
	Mon, 26 Feb 2024 12:28:33 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F65604C5;
	Mon, 26 Feb 2024 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950513; cv=none; b=u4f6SC9rD3sHw93t/UVjSkU+MTc6v2oeSDTr7fw2hmmBmTxVpOuZbNjbWkuyoOUIRzSWf7Epn/QXb4DQ0GecrAoN835WkbBZFj2OD7Q0MKw9arxLIhM4Zd8PWXQb/qKvbD7h3PDve0Xx78VHwmMlDN5GAdku8ZS+RoHK0hW/wng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950513; c=relaxed/simple;
	bh=/5+1JvA8PcmHAUYXDe4zLh4GBZ4EEJwzWsb0OhWS0Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2Et/HW7PahrsaiFYwnCYdWCUgbx+6qToCJFhN8mPZ5Pw8TVdRZnJowxrcDymlH83FdPhMwCmW+u8+odJbkvprDm4M4q0Q9UMVXWkeA1XDkLKWte3iFw8z+RAjxVwof5VZgw1binXRJd3X9kgjDMafIcwjIjmB3Sq90I/XRZ/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso3171654276.1;
        Mon, 26 Feb 2024 04:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950510; x=1709555310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA4QNksb22erWBRN6uBbo69xHUrtQuWcgavfHO0o/70=;
        b=kn8ZBX62ofZ/pVhPChHmrU+PGM5aIWmNK7YOOQpg/2bvjRK9P75Khec861ABmIiCZ2
         kb01nxKsT90nsGr4xXydjUPl9WHvJ5xarOC8V/qowyLiu4+XetBGUu42dWpOPi3nOYQq
         18J5VWWjAeZqmZOzh5nNroYujQZU22KcJu7wreroY7wdOVWWy2M6V112hFAe1ef0EXcD
         bWa7Vkw+Kc823zHw1G9b2JwF1aBV402+XI4q+Seq6W3IdsWQS9IboTMng1ootjc4cFQX
         Ev3k37mpJuU+FZoNqEOVrJ+aEej2cwcQvcGxHOxaDFClyt9Khg2Sv2A1FGge9VhEDWI2
         j6CA==
X-Forwarded-Encrypted: i=1; AJvYcCW0bVepzR1th55DzrCJa7tlYp8YqI81EcCU6OafbbZamWDDSxSwZDmVhVIWiw0U19XgqPsBKZhOoAezRwyO7crYF1+jGgzjVCbKRgbseQT4Fa5kVgH2Yv+SMNAdkbaY+PQ2Rqd9OxRSXNi1MDTGdJXHQGuLpiYqPBKTbCxG4zXb5HSgYqDAUe83BTYJrPt4SMAC/BPIcdvhfZdPn5kv7w1k8vzZZDBWyhkVRUl6uQ==
X-Gm-Message-State: AOJu0YxpKwzqYDLEPSajwpL4Zc473BmLuu4wzYiQS1Tz6ctBgItMXHj1
	eqKF3cNSJKpgVUaoQRZz2eRsVnHBZHp7pO3EMiwcH+ir8Tmj02oPdvhTBmxt2Ew=
X-Google-Smtp-Source: AGHT+IHuFw8w+R/QcggjrOWYTSDAtHV+Dj8tXbWYhGk6gVshmOzukU8AeQSKKZ1ug61au3b/Ab9b2g==
X-Received: by 2002:a25:6607:0:b0:dc2:7018:806d with SMTP id a7-20020a256607000000b00dc27018806dmr4124422ybc.16.1708950510353;
        Mon, 26 Feb 2024 04:28:30 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id x6-20020a2584c6000000b00dcbce4abc32sm871973ybm.36.2024.02.26.04.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 04:28:30 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60893d33269so29230267b3.1;
        Mon, 26 Feb 2024 04:28:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIfhZpPGsecYFTeV0GlBCxFwxWBhSEO733uJGpoX85qfXtJ6x/0lzGQspZSVGYCC2e4DDnBr6dbUt8RzV/G599trg7/JmJXw4wKfBEgOCksiUdLV4FHpYSwI/wNC22nzH4jKDLgqKeGIopmVzgn2PpWcRdZ29YETj8fDBdBCvK1Yn7+JfreTYx0dtg+uLaGCDG0aTh5HNNLNtGxo7fNgGcsFaPeBB3numaMu0+Wg==
X-Received: by 2002:a25:ce11:0:b0:dc6:d7de:5b29 with SMTP id
 x17-20020a25ce11000000b00dc6d7de5b29mr4889354ybe.10.1708950510084; Mon, 26
 Feb 2024 04:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222083946.3977135-1-peterlin@andestech.com> <20240222083946.3977135-10-peterlin@andestech.com>
In-Reply-To: <20240222083946.3977135-10-peterlin@andestech.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 13:28:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV7f_R-_OiP-18rQATVdnS-1yo_kT++O=e1KuUSfeiygw@mail.gmail.com>
Message-ID: <CAMuHMdV7f_R-_OiP-18rQATVdnS-1yo_kT++O=e1KuUSfeiygw@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] riscv: dts: renesas: Add Andes PMU extension for r9a07g043f
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	alexander.shishkin@linux.intel.com, andre.przywara@arm.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org, 
	conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org, 
	devicetree@vger.kernel.org, evan@rivosinc.com, geert+renesas@glider.be, 
	guoren@kernel.org, heiko@sntech.de, irogers@google.com, 
	jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com, 
	mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com, 
	namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	peterz@infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org, 
	sunilvl@ventanamicro.com, tglx@linutronix.de, tim609@andestech.com, 
	uwu@icenowy.me, wens@csie.org, will@kernel.org, inochiama@outlook.com, 
	unicorn_wang@outlook.com, wefu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:41=E2=80=AFAM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
> xandespmu stands for Andes Performance Monitor Unit extension.
> Based on the added Andes PMU ISA string, the SBI PMU driver
> will make use of the non-standard irq source.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes v1 -> v2:
>   - New patch
> Changes v2 -> v3:
>   - No change
> Changes v3 -> v4:
>   - No change
> Changes v4 -> v5:
>   - Include Geert's Reviewed-by
>   - Include Prabhakar's Reviewed/Tested-by
> Changes v5 -> v6:
>   - Include Conor's Acked-by
> Changes v6 -> v7:
>   - No change
> Changes v7 -> v8:
>   - No change
> Changes v8 -> v9:
>   - No change

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
so Palmer can pick it up with the rest of the series
(the Renesas tree merge window for v6.9 has closed)

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

