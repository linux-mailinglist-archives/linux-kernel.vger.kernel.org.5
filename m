Return-Path: <linux-kernel+bounces-72170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5110785B04F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEA21F2284C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FBF13ACC;
	Tue, 20 Feb 2024 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzvkrcv7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73BBFC19;
	Tue, 20 Feb 2024 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391709; cv=none; b=mGqlclNeekNfK+M24D/iVq40cJpTdQRPCfT6IsT7tOHSm7dl/BVstFQxLjzVUBAk5aGps7fq41ixOj4l1XcEZ+wT+/QKW7X9nPF8A+laMJC7vKDWOgxhSOPz1UhLXl/dbwSNvM7haaQsmIosP1APDykmROgQNill/czVsHvkX94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391709; c=relaxed/simple;
	bh=gRlACvq18RgH3+fWPOxkkUfB0U8xAoHtppyL5FDnKuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxlVAzp+fIp8B2aYzsKia1+WDjE6JtcGqZK41+8DX6SP/4UsjTmCGKN9TTdQL3PdkSQ3mbXgj38ScNfiFejbdrLXZZqVMvCsCnWf1/G5EA/NXcCQ8w6v48NW4FjPRPvTxrAPrCnH2fp8oe0+AmcSVox1xW8+FIgL9BtMv5hMn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzvkrcv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC46FC433A6;
	Tue, 20 Feb 2024 01:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708391708;
	bh=gRlACvq18RgH3+fWPOxkkUfB0U8xAoHtppyL5FDnKuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qzvkrcv7Y6I/ApWX7O7vOPeBl1rJSUDc4Vbe5uqu0wtQVVOHV/aPwJ7HNkQHvzjiK
	 XQhP6w+uf0UDZX2nqSSmIiE2RRZkD58a2qZn5dwMdth+hKUvBKNP6jZDsFJ4stLfcS
	 3MxIkpG1V4NeydmpQoaBkHmYEYEH9QTw0cOVARWFpXCI0LLO5NPKklYdNPMaUXLrM1
	 PCBgyIa6IKDFCpVxvHmQU6RxNmAqthmk4RzPhcjDN13CvL9e3wND51/apSaZ9dU1jO
	 TUl7ZcwQuD8rCzf4bt1N7R8g5cz4mMZOA9zVkh/uT0swvABuLhhKdIprcpC9rlEsB8
	 cO0WmxPRmqdIQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso5062171a12.2;
        Mon, 19 Feb 2024 17:15:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzBB4rXCYfRfoQ9FYhw4dM2IpANRNARQvrCg4Fzamr0vNa/ktlgykAvjrMmel90elAEG+W+vrA4JA/u2zgqytFNGl3gdyQCEWnmxlig/XrsM0BD7pxZ/THJQUdFrMDLx7cXp7xlInxEJd++eerhiCYpvfHCydG75OskoMQrnUFADEhRQ==
X-Gm-Message-State: AOJu0Yx9/r9kpIoci5M5pgw+3tQQj9zRD/H3LakrbjuGiPHlgPmyvc8n
	/5teL4OMaDxVGdIOOtBxUyirq3WtZSYtJCGa5fd6P3++9Lj3pbYiwKKBkKGTttRBisK+KfvX79h
	77Kn2ofi33mAur+4bdoLPHSSB22s=
X-Google-Smtp-Source: AGHT+IH4+9JBZnMWglIVAMrZKsqHw7pO9w1Rp9U87EJpKCF7PoBPr3pPgDcO6TDGwO0E8MKi2ReWPMx/pZWLWjuSas4=
X-Received: by 2002:aa7:d0d5:0:b0:564:a1e2:edd2 with SMTP id
 u21-20020aa7d0d5000000b00564a1e2edd2mr1785583edo.9.1708391707015; Mon, 19 Feb
 2024 17:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708223519.git.unicorn_wang@outlook.com> <aaad6e257a44e312cfbeb5a8ce84b8975cdc461e.1708223519.git.unicorn_wang@outlook.com>
In-Reply-To: <aaad6e257a44e312cfbeb5a8ce84b8975cdc461e.1708223519.git.unicorn_wang@outlook.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 20 Feb 2024 09:14:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTAz1p-hXF5YCz0Hz5c+QMuSv6BGNbwpYW6Nvez0N7g6g@mail.gmail.com>
Message-ID: <CAJF2gTTAz1p-hXF5YCz0Hz5c+QMuSv6BGNbwpYW6Nvez0N7g6g@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] dt-bindings: clock: sophgo: add pll clocks for SG2042
To: Chen Wang <unicornxw@gmail.com>
Cc: aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com, 
	robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com, 
	xiaoguang.xing@sophgo.com, jszhang@kernel.org, inochiama@outlook.com, 
	samuel.holland@sifive.com, Chen Wang <unicorn_wang@outlook.com>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 10:51=E2=80=AFAM Chen Wang <unicornxw@gmail.com> wr=
ote:
>
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Add bindings for the pll clocks for Sophgo SG2042.
>
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/clock/sophgo,sg2042-pll.yaml     | 45 +++++++++++++++++++
>  include/dt-bindings/clock/sophgo,sg2042-pll.h | 14 ++++++
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042=
-pll.yaml
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h
>
> diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.ya=
ml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
> new file mode 100644
> index 000000000000..b9af733e8a73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sophgo,sg2042-pll.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 PLL Clock Generator
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-pll
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Oscillator(Clock Generation IC) for Main/Fixed PLL =
(25 MHz)
> +      - description: Oscillator(Clock Generation IC) for DDR PLL 0 (25 M=
Hz)
> +      - description: Oscillator(Clock Generation IC) for DDR PLL 1 (25 M=
Hz)
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/sophgo,sg2042-pll.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@10000000 {
> +      compatible =3D "sophgo,sg2042-pll";
> +      reg =3D <0x10000000 0x10000>;
> +      clocks =3D <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
> +      #clock-cells =3D <1>;
> +    };
> diff --git a/include/dt-bindings/clock/sophgo,sg2042-pll.h b/include/dt-b=
indings/clock/sophgo,sg2042-pll.h
> new file mode 100644
> index 000000000000..2d519b3bf51c
> --- /dev/null
> +++ b/include/dt-bindings/clock/sophgo,sg2042-pll.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +/*
> + * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#ifndef __DT_BINDINGS_SOPHGO_SG2042_PLL_H__
> +#define __DT_BINDINGS_SOPHGO_SG2042_PLL_H__
> +
> +#define MPLL_CLK                       0
> +#define FPLL_CLK                       1
> +#define DPLL0_CLK                      2
> +#define DPLL1_CLK                      3
> +
> +#endif /* __DT_BINDINGS_SOPHGO_SG2042_PLL_H__ */
> --
> 2.25.1
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

