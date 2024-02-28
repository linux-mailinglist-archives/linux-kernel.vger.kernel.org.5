Return-Path: <linux-kernel+bounces-84787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C108F86AB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E921C23FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94636124;
	Wed, 28 Feb 2024 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG9h3AQj"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5192E84B;
	Wed, 28 Feb 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113455; cv=none; b=I5GKu2qytsGcCQqeW3jMbUBaY2TuEqk8cEClYMiqBsROUDiM5HOOj9pwjbFaLB18sn9xhHLloyrCw/xrVdsWAZFvwM0rS+HGwAi+KasiOKiSWHpNXcDVHpJXZSp0MG3uVQAGyIsFbQU2IWgxyp3kUECHpOzYMothOJSrmuEOAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113455; c=relaxed/simple;
	bh=lRVKIKjBIcOPEo6Xr+dAqUMb9zwLpThSLnQ3kHz+dUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjaoWpSXN4t0/xt6q5iSSd7gNHOhfoGkvq3E3i6Rgpai50nBGXrF7cKnowwII5RsP7PffcwlQB/b3PGk/1SxyrcPBnRYUCHyJSTvhiX0HOtmnJ+R+KeMmJDOdOH9LlG+WJPjUJl53KZ1p1q8zPwSpMKRq8P9A4eAdzEzUg+ovic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG9h3AQj; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d332d0db9cso338870e0c.3;
        Wed, 28 Feb 2024 01:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113453; x=1709718253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EigGEravrSBB3kVIXSapPAOk2V/j1XFYrgJgPBVd5DA=;
        b=LG9h3AQjKM9qUE6XJW8WtaoVHgGHYV3okpaiNJgUUiWg6beR2qYC2T0es+bZDRnzoW
         6iWiTnAMW5r87CTB4aL4TgmFudW0kz0a3veCrUOqzU7glazC4PsfM1dGs7cZpVBjUskN
         lh6H7QolnRkCE9nbGVFVL6vKCDzcICvS4+UgZZTgccglxp/P7gfk+jinjbFSL5P0TQYv
         Y+Jxt+oxCGiaih1E6CbohVx51EO1KQwHteXQ+loi7n51LtjqJyslpTNROfY4IqiCEQvb
         glrG/NOSwz3MdXcD1Eb17LFdvXL7qLNKUUIainYWm1BnOTSvF6Sl36imJk+0BMB+L22Z
         9lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113453; x=1709718253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EigGEravrSBB3kVIXSapPAOk2V/j1XFYrgJgPBVd5DA=;
        b=g1g+9fVnhF7MzLGTVCwYs61uZwIAeL8E97gE7vJX2h5LztlAC4I/ugpp14ExN4cTuL
         PUG4tJNYdn9SuL9gt3HBXvk61wAuFAHLMvsU20ZCGgA9KmWTdpkodDFL5KBXx0hTrKcb
         AnEcRNuXDpz/WYBflDb7+AbC8nKS1F+g11jMYlQS2WoGHy+1qVUIhvHGkGh94QGgqa55
         FddhzppnK6AkmVaixcmiNZ3KW2a9IA2QGHpRH+cY8mZ2HJ1Bkco8IljB86RMxBcmdYhc
         x/peqDpD88hU+fSPcli0YdqOR9bOnteziN/1LRdI4a6Yb5oIcY9oXimLyoE6jByQVnIy
         TRfw==
X-Forwarded-Encrypted: i=1; AJvYcCVNlszEXQaStDl1itHLLl5TaKt/1i051FO+RIPsyld/hem/MnXwZcdBANZYgex93HRDPbViXoAfF6+KMqHvUtp7dNNJpHBVLIPYcBqJKwUxvYwc6ZIna3+LIguQgPLmk/YLt7tYILXmPp1iaEMZIUGdfNpLIaUlsXI37UIeA2xogYNJ1PL1T8mvQ3X4
X-Gm-Message-State: AOJu0YxPSwANih7wYe2mptoOxv423imVc9l37p0pbUvdMkbjK8Eo7E4k
	ehXSCmC17VkoZoJmZFDuc/wGxL7evDk81FnBS8AujedTDAgpILav5FlxKpqOlAxdoEhLREalPci
	0NdMj8quoGeRPwypaIy2McmIA6/FTdMMU
X-Google-Smtp-Source: AGHT+IHe2DUCCldJvUgC7hikB8+SCQ+sM3Oqi3/DV8PYhNOgZo6s01p0sEz3T8mp/3aAJxXtjzhExGxpJ4FIl3IIGyM=
X-Received: by 2002:a1f:e401:0:b0:4d3:37d1:5a70 with SMTP id
 b1-20020a1fe401000000b004d337d15a70mr2313505vkh.7.1709113453037; Wed, 28 Feb
 2024 01:44:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240227232531.218159-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <8e4e05f9-5bd1-4f31-a2ae-fc1567405c11@linaro.org>
In-Reply-To: <8e4e05f9-5bd1-4f31-a2ae-fc1567405c11@linaro.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 28 Feb 2024 09:43:22 +0000
Message-ID: <CA+V-a8vSCif-JXGFtn9k-JRBsV3sKH4YoGJzQbum0DV1JS5hmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: renesas: Document Renesas
 RZ/V2H(P) System Controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the review.

On Wed, Feb 28, 2024 at 7:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/02/2024 00:25, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add DT binding documentation for System Controller (SYS) found on
> > RZ/V2H(P) ("R9A09G057") SoC's.
> >
> > SYS block contains the SYS_LSI_DEVID register which can be used to
> > retrieve SoC version information.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> > v1 -> v2
> > - Dropped extal_clk node from example
> > - Replaced RZ/V2H{P} -> RZ/V2H(P)
> > - Dropped description for clocks & resets properties
> > - used <cpg 1> for clocks in example node
> > ---
> >  .../soc/renesas/renesas,r9a09g057-sys.yaml    | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/renesas/renes=
as,r9a09g057-sys.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,r9a0=
9g057-sys.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a0=
9g057-sys.yaml
> > new file mode 100644
> > index 000000000000..72bf8e733dcd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-s=
ys.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/renesas/renesas,r9a09g057-sys.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/V2H(P) System Controller (SYS)
> > +
> > +maintainers:
> > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> > +
> > +description:
>
> You need | to preserve formatting
>
Sure I will add "|". On that note some bindings have "|+" and some "|"
what is the preferred one?

Cheers,
Prabhakar

