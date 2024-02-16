Return-Path: <linux-kernel+bounces-68694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C7857E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448CB28A7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E383312C7EE;
	Fri, 16 Feb 2024 14:04:13 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067712A17B;
	Fri, 16 Feb 2024 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092253; cv=none; b=VdcCa5yZiVXpBrlSKKoKNtlVDPRwz/rcwT8Cyo8yUrJH2kJG/3oNqeyEAKcRyF6yca92fVrseEsaxb6ecLzLd1QLL0+nkA6hiILcobZJ8IRdcwX2tGCJScT5Z9nsLXnigNwQGAFh9QLBF1MMPPi7zLEqLeQwLV4WULEDpLcXE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092253; c=relaxed/simple;
	bh=12zN7Qg2kVjhNu95ot7qys1hfnb+2xtPYQ/UbTrITdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M65082UiFYYtX8Sxc2GCxNA+F3sRK+eA7Eag6+ByD6DLw8RV10LwbGaS8URhK7FYPjlCpwovR0VTLp9ynM3Tq8jybPeCgZeo4iSLKhXeJD/7ScClLXXJxc8iKjIcK1NqHwfx83MlSFFr7Ea5cQVLIahg2snb0sLbTTTxIvB0QqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc236729a2bso1873943276.0;
        Fri, 16 Feb 2024 06:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092250; x=1708697050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+E6x9e4jEwIHXezfBq1PxKT3ziilTvOsAUwZ4pRf2+s=;
        b=sUjQaAzHKMftS/QWfHhYwt3KBsB2YOFdox2pSWl5va6bLeWBTRHQEHwNTJMdwfirtn
         KG+iltPRkf71K8V/8sr9Z23KoAK0zff1EXNPhltSy2mTVuNw+WIZU7utxVgN1uRM8unW
         lUIE5jek8xalduc9xHmCjAPxGriFzD4U+oLhUo1EYr6huE16d/vG/L9Ba/oddV5Hpxiz
         QkcPJUfiBxfvufqDYRM0t1+pNFdBiOsbCbR5+z1rvaz3t6Ewf4ziQx3i//poVZb7+RFh
         4Hoi0lK0SQjRiCy6o4F9VFIghnPdhSOv71j1sndAe1uF5EQ8DsJZPoEJqS5cwzCm/wxV
         jXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWctbIhgiJIBwkrTz17o2cjw5jkbzAWsBSMkFY8UkCSCywiBHIDKMR7SSL6+Fom5KVVVKeImh11d+1q6r55xpw68VK4ZEOCyJyQLr15J7I4r3PGap0n1iKFjjF6MT/JD6olbGVeingVy9tFIFH1sxIhXUVNditIrtWSYZxKAxP8T781xKXDnT75tWgsYt2S0glhUyy4b6ljhytsEQyD9yq8Ycoi4CvQ
X-Gm-Message-State: AOJu0Yzv8isdrqZEsDTLsf6Q2XlN2BHqtwXXIEviyo25U+XnSVYE6iaM
	j0J11QuqFt+F+6gLV+63kAW5qw22mJYi9+d3R47FBmdQmiXTNXHaubsB9e8zwqo=
X-Google-Smtp-Source: AGHT+IHNpb+jbIf242SvZ9zCWmn6VUIkpqHG+IQS56Xr8+gYMA0qfjLQZ7MHltxxu5LRbh/QYHH0oA==
X-Received: by 2002:a81:6d04:0:b0:607:c7a5:d1af with SMTP id i4-20020a816d04000000b00607c7a5d1afmr5208308ywc.16.1708092250467;
        Fri, 16 Feb 2024 06:04:10 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id k131-20020a816f89000000b0060785627769sm350303ywc.96.2024.02.16.06.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:04:10 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso2000386276.1;
        Fri, 16 Feb 2024 06:04:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCWUPfzOw+fn2Gw1qTuh53h5/BYU9YSzPKaCnKutXwhL1dceSvTYWxwTFJyz4WQssqXNWzWjOJYGfnVzXou7h8rKIcbuAREjr1zKPrUN52tV7xOPrXIb3XKZ6CGIoFBPkmDrAu2ffbPXQEo1wkopWZaJUTIwPkWDI2knHR7bkbsa1KrVAoUkawu6ysBMLXJJ2szPoBScmCQnr/Q2dxlicLnJ2YdWo+
X-Received: by 2002:a25:d3c7:0:b0:dc6:d2b0:95cb with SMTP id
 e190-20020a25d3c7000000b00dc6d2b095cbmr5114614ybf.57.1708092250077; Fri, 16
 Feb 2024 06:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-6-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:03:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbCYfaM6Zi5AZhj+yc8vySFdCDFF3x1rgbV9Y5xh4LSA@mail.gmail.com>
Message-ID: <CAMuHMdVbCYfaM6Zi5AZhj+yc8vySFdCDFF3x1rgbV9Y5xh4LSA@mail.gmail.com>
Subject: Re: [PATCH 05/17] dt-bindings: clock: r9a09g011-cpg: Add always-on
 power domain IDs
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

On Thu, Feb 8, 2024 at 1:43=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add always-on power domain ID for RZ/V2M (R9A09G011) SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/include/dt-bindings/clock/r9a09g011-cpg.h
> +++ b/include/dt-bindings/clock/r9a09g011-cpg.h
> @@ -349,4 +349,7 @@
>  #define R9A09G011_DDI_RESET            93
>  #define R9A09G011_DDI_RESETN_APB       94
>
> +/* Power domain IDs. */
> +#define R9A09G011_PD_ALWAYS_ON         0

RZ/V2M has many more power domains, but they are not controlled through
CPG_BUS_*_MSTOP registers, but by the Internal Power Domain Controller
(PMC).

> +
>  #endif /* __DT_BINDINGS_CLOCK_R9A09G011_CPG_H__ */

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

