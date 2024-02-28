Return-Path: <linux-kernel+bounces-84928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D365886ADCC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1CC292BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606A159573;
	Wed, 28 Feb 2024 11:34:18 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506EB1419A6;
	Wed, 28 Feb 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120058; cv=none; b=SEeUfIPU472aM3NB2A4DoyeFwGvb1VooOhzDR5hAxuu4xAavu/dLQHgzGlexAW1fixLK9P3SXeDcN3Uv6VYHtCosLdLOFnCRX7SYIh4h2HeQ8Isftkt5DbfIBuNZ+3CgrWxhKFPBblVhu+lmiv9DSZeY6WpKHs8xjqY61gxvZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120058; c=relaxed/simple;
	bh=PSSUd6jiJEORGZVGHxrlqmuAQ5ySNoun2MHPYJ8nQ7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPCQptwF1/CTInZJuc0gCx+PYDUqLaYp70oOO/4uSG0b7WltNmdmHYI47SAIVp+nwLIcVF5/QIEQvNKzEHrNgJLtif7v6/6l4LIeuxo/tx4PfpohGm+gp0e7ayyaJ/UryHI0UcGRquB7PRrydaWEMV4HUnzpJWvAk+iWkMQSxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607eefeea90so7350447b3.1;
        Wed, 28 Feb 2024 03:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709120055; x=1709724855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEjNIZOWrswOTOk/Ox7ks9vSTyMnw1dW/SS6bLeSUO0=;
        b=P/g4FGqm5m55IOQfeZGAtV2q20RGKhlx20oR/jl/fALdly+UWQwkk/if12d0QnA89T
         TKXLPT65qT36gEhItfEOG+csm9yRpmQC9hsz1sdSayi7d8fk6kEt1hhw7IDlady2k//S
         bBJ25IoDlhh930+j/NxJF/p5asZ+VzmOYE0xTbgXiydNJi41m3K+xuGX4hLuoESQbz9+
         brHgyH74bCTWRQzQRcKVc7KROgcfPz+Qwg7Nj7Uyw59QF+BJZ2xjtMhyGa6wV9WBeggn
         JQP+HTalg6wNWyFDjR37JbEj4rF19eJV/+J74t+jUqvtZutJblEs+CHHLAgWIOs1B0Pk
         mzTw==
X-Forwarded-Encrypted: i=1; AJvYcCVaX9J5SjbHSO2+ZzsX/2SlZIXdj9FUVfMpyd2kYQtZTzgm4ssjpTxwWIR9Y4zjaRUnMKoZ8Ao9g+DsqcKHde6PgqtAKhNTMecnKGYSxAfTTmBWn0bWrlPJPDhsodbVJ+ppvOzUxSjRo0vkLG/lac4g5AEiBo9fCY6e9gxugFlyBRwpPbW3dMEg2cMa
X-Gm-Message-State: AOJu0Yw3WaUnzfeewN4s/7TJrEI13i5yEuLUPeSAFKrx2PeK4aXB60hm
	oTnTxuTFij8tSRwWci6bk+kJF7gpcwQF1M20v8fleG9bpEbBFxuiaN0VN7EupobsLQ==
X-Google-Smtp-Source: AGHT+IGdDSvUhKVVCRZtoEaoAYbacM+C8nYRbI1o9nzytn/7bO4FMsZ3ogpGBo2CvmFco5LmAASVhg==
X-Received: by 2002:a81:4fc4:0:b0:608:2b1:d6c with SMTP id d187-20020a814fc4000000b0060802b10d6cmr1368219ywb.19.1709120054736;
        Wed, 28 Feb 2024 03:34:14 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id o11-20020a81de4b000000b006040d34e58csm2283627ywl.74.2024.02.28.03.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 03:34:14 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so767759276.0;
        Wed, 28 Feb 2024 03:34:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7L1JmRjX5OkAhGmnhuH9c7p7K7ZDpSiqU3OiI3FsW32ESVC5oAiRnH/xz5ZxHFRsKtjB0/zT+zjhe/jXzyyOWTt4ovJMb0nhatLcobfECa4a6TGL5UDZz/6YXCy7XwamfrAo4XlxdckSe/kXGh8VNNbv87Jcv/tMofB8Rdsu0NZfan2Xb512X9fyk
X-Received: by 2002:a25:8510:0:b0:dcf:bfb1:ead3 with SMTP id
 w16-20020a258510000000b00dcfbfb1ead3mr1104627ybk.1.1709120054382; Wed, 28 Feb
 2024 03:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240227232531.218159-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240227232531.218159-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2024 12:34:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVD3DoFnTO_2a-UAoDQvRTd9CBdA62KG0ye9Gpwbi9G0w@mail.gmail.com>
Message-ID: <CAMuHMdVD3DoFnTO_2a-UAoDQvRTd9CBdA62KG0ye9Gpwbi9G0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: renesas: Document Renesas
 RZ/V2H(P) System Controller
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:26=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add DT binding documentation for System Controller (SYS) found on
> RZ/V2H(P) ("R9A09G057") SoC's.
>
> SYS block contains the SYS_LSI_DEVID register which can be used to
> retrieve SoC version information.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v1 -> v2
> - Dropped extal_clk node from example
> - Replaced RZ/V2H{P} -> RZ/V2H(P)
> - Dropped description for clocks & resets properties
> - used <cpg 1> for clocks in example node

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.10, ...

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys=
yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/renesas/renesas,r9a09g057-sys.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/V2H(P) System Controller (SYS)
> +
> +maintainers:
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +description:

with "|" added.

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

