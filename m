Return-Path: <linux-kernel+bounces-37103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7441D83AB91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2466A283239
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBDD7C0A2;
	Wed, 24 Jan 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVe8o4fW"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B77C080;
	Wed, 24 Jan 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106076; cv=none; b=bQBFs5nJwGJoqlcNZ7o69fT8JLSstFTYyA1wpjrWymbm+rSYmnt3IzGMG7IHtqWqX95viBHOiGtO9rI7MtM9X1KbeMXjQVOVQxn7Aj6tuIsGNbWx0hP/7Q8AGr+LkmGUUJXmkwvGmLciCjRpnegSbGRvLbnza9DvjUYRs2dgN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106076; c=relaxed/simple;
	bh=pIEQrV7YkLmxvf9BPqUxV9ppKqXNP8VSag1ofZSmIiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKFaTEh8ltw5h30R0ZUj2IX4OM4AZvOHbnbyfzf17mEwHeiPy4LEqhyPoa2WIwHT5BYp9TvqaA0Uesj91nf0j8TyYxdLs7sxNafFCUVOifjL3OGUmmg0Sws5vdrQHblWatmnOCHFvrLa0MonFRtB2Rw0qTfg4JrgDpo0Dc1Cvg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVe8o4fW; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ffcb478512so27456607b3.0;
        Wed, 24 Jan 2024 06:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706106074; x=1706710874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n+eJ9kOA+fKdqQFTp/IZGzCU4ik0my7sRIdeyMGzakc=;
        b=dVe8o4fWBfxkpbd96N3Q3dIObEGgFC98ymmy8HDrezNEF2b5SQ+20IMveIwf+FAckV
         LUU+ErNblAePmAFYYQfFjoxHeVPIaZscb8WGuACjoiGlJIvzbbgNqcuAMVtUCXvQ+wsx
         5Qggl33QoL4EULDNmCv4NoPA0yCklOIXA6ndPrdUzPNHWy7KppFn6wFH11b8t9sJBK5/
         oiqhnk/SLXwfN9900pzeOGO7SsutafRUeCELkVyqdsP6IqKFcOVKwuMigoSyi6pg1g4P
         3CySznLascnYghgTQYYZ1+VvAHY2JDNavewed46aIB1MnWbHpwPmE13bHKTnbQUBzv4V
         aDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106074; x=1706710874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+eJ9kOA+fKdqQFTp/IZGzCU4ik0my7sRIdeyMGzakc=;
        b=Y+M1stVqT1Erv41eNJeshFoCROhAae5x95fOxMxjhSMYD2iuQOhipqG1iWOSMO1hwo
         ZURWiWRgBxdILgJ/QD7GGYXXd3aLHQ/P0PioW5d72TFQm6h4Jz6z6owx8XORzS4OeUEl
         aXJv686j5xiWqqwH8T2n7WlHe97CZwVInbPrufKV3LMZE3RW9JsFouXfihfLjBYx+yYN
         nxjvDD03M5VlAkvx27TIBxEI0yWoXDCSAZIFhoruZR5qvLjeegdkU4A5lqFPcHsnw9SH
         GvZW6sMkxQ73j1QPbRo/vsxHxAdA3lWl1nVgd7/L0uAJTtomqJma2p5tlzKP4QHDU9qi
         Gjxg==
X-Gm-Message-State: AOJu0YyBti3IWKtmkixIAj90avywqWJMRQORawrCfytj+IL+oEJtWWRb
	fOwBV88BqwG6A6pwiRK63/qs+Odmig1rGLllX+FROz8YBiFf167JDJvSUv6AWBmR++KTf7m2yA3
	a+TCUccT1MQ4ykV7GwuKWfclGDtEW+ckwN/w=
X-Google-Smtp-Source: AGHT+IGfADtmx4YW5vcoMDveqNIj7c/ID9sgjgKC9nFbRYrQvzqyn0p5tcxcsh0kEKgzGNW/7opa2Ptbh1eAeazzpj8=
X-Received: by 2002:a0d:c2c6:0:b0:5ff:8e30:68a7 with SMTP id
 e189-20020a0dc2c6000000b005ff8e3068a7mr561175ywd.12.1706106074234; Wed, 24
 Jan 2024 06:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-5-tmaimon77@gmail.com>
 <98eaac00-1e3d-4c27-89f5-0b6ec0fcb710@linaro.org> <CAP6Zq1hxTgJWtem4Y4_4Hv1ojy5edzGXeBGhh_gzyM4Kewsbeg@mail.gmail.com>
 <64a35c38-38e4-486f-8a07-4aee1d14e05a@linaro.org> <CAP6Zq1jhy0GUtoO3=m-PHD3WCertSvAg+G7iygiRkWvjzfwSpQ@mail.gmail.com>
In-Reply-To: <CAP6Zq1jhy0GUtoO3=m-PHD3WCertSvAg+G7iygiRkWvjzfwSpQ@mail.gmail.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 24 Jan 2024 16:21:02 +0200
Message-ID: <CAP6Zq1j0-zZvpKRc4T_DPOo=7bewc9u-5NuM48e0Akvrd0KLLQ@mail.gmail.com>
Subject: Re: [PATCH v22 4/8] dt-bindings: soc: nuvoton: add binding for clock
 and reset registers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,


On Mon, 22 Jan 2024 at 19:14, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Krzysztof,
>
> Thanks for your comment
>
> On Tue, 16 Jan 2024 at 22:37, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 16/01/2024 20:02, Tomer Maimon wrote:
> > > Hi Krzysztof,
> > >
> > > Thanks for your comments.
> > >
> > > Sorry for the long explanation but I think it is necessary.
> > >
> > > In the NPCM8XX SoC, the reset and the clock register modules are
> > > scrambled in the same memory register region.
> > > The NPCM8XX Clock driver is still in the upstream process (for a long
> > > time) but the NPCM8XX reset driver is already upstreamed.
> > >
> > > One of the main comments in the NPCM8XX Clock driver upstream process
> > > is that the clock register is mixed with the reset register and
> > > therefore we can't map (ioremap) the clock register
> > > region because is already mapped by the reset module, therefore we
> > > decided to use an external syscon to handle the clock and the reset
> > > registers driver.
> > >
> > >  I highly appreciate your guidance on this topic.
> >
> > Linux deals with it easily, that's why we have regmaps. What's the
> > problem exactly?
> This is exactly what is done in the submitted clock driver.
> >
> > >
> > > On Wed, 10 Jan 2024 at 22:59, Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 08/01/2024 14:54, Tomer Maimon wrote:
> > >>> A nuvoton,*-clk-rst node is present in nuvoton-common-npcm7xx.dtsi and
> > >>> will be added to nuvoton-common-npcm8xx.dtsi. It is necessary for the
> > >>> NPCM7xx and NPCM8xx clock and reset drivers, and may later be used to
> > >>> retrieve SoC model and version information.
> > >>>
> > >>
> > >> A nit, subject: drop second/last, redundant "bindings". The
> > >> "dt-bindings" prefix is already stating that these are bindings.
> > >> See also:
> > >> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> > >>
> > >>> This patch adds a binding to describe this node.
> > >>
> > >> Please do not use "This commit/patch/change", but imperative mood. See
> > >> longer explanation here:
> > >> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> > >>
> > >>>
> > >>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > >>> ---
> > >>
> > >> How possibly could it be v22 if there is:
> > >> 1. No changelog
> > >> 2. No previous submissions
> > >> ?
> > > Should the dt-binding and dts patches be a part of the clock patch set
> > > (this is why it's V22) or should I open a new patch set?
> >
> > You should explain what is happening here. That's why you have changelog
> > for.
> Will explain it better in the cover letter in the change log.
> >
> > >>
> > >> NAK, it's something completely new without any explanation.
> > >>
> > >> Limited review follows.
> > >>
> > >>
> > >>>  .../soc/nuvoton/nuvoton,npcm-clk-rst.yaml     | 40 +++++++++++++++++++
> > >>>  1 file changed, 40 insertions(+)
> > >>>  create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
> > >>> new file mode 100644
> > >>> index 000000000000..dfec64a8eb26
> > >>> --- /dev/null
> > >>> +++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
> > >>> @@ -0,0 +1,40 @@
> > >>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > >>> +%YAML 1.2
> > >>> +---
> > >>> +$id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-clk-rst.yaml#
> > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>> +
> > >>> +title: Clock and reset registers block in Nuvoton SoCs
> > >>
> > >> This is vague. Any block? All blocks? Your SoC has only one block? I
> > >> doubt, although possible.
> > >>
> > >> Anyway, clocks go to clock directory, not to soc! We've been here and
> > >> you already received that feedback.
> > > Since one region handles the reset and the clock registers shouldn't I
> > > add the dt-binding to the SoC like the GCR and not to the clock
> >
> > No, soc is not a dumping ground..
> Maybe I do not need to add dt binding document for the clock and reset
> syscon but handle the registers as follows in the dtsi.
>
>                 sysctrl: system-controller@f0801000 {
>                         compatible = "syscon", "simple-mfd";
>                         reg = <0x0 0xf0801000 0x0 0x1000>;
>
>                         rstc: reset-controller {
>                                 compatible = "nuvoton,npcm845-reset";
>                                 #reset-cells = <2>;
>                                 nuvoton,sysgcr = <&gcr>;
>                         };
>
>                         clk: clock-controller {
>                                 compatible = "nuvoton,npcm845-clk";
>                                 #clock-cells = <1>;
>                                 clocks = <&refclk>;
>                                 clock-names = "refclk";
>                         };
>                 };
>
> is it acceptable?
Appreciate for your advice on the question above.
> >
> > > directory?
> > > https://elixir.bootlin.com/linux/v6.7/source/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-gcr.yaml
> >
> > Choose the main feature of the block - either clock controller or reset
> > controller - and put it there.
> >
> > >>
> > >>
> > >>> +
> > >>> +maintainers:
> > >>> +  - Tomer Maimon <tmaimon77@gmail.com>
> > >>> +
> > >>> +description:
> > >>> +  The clock and reset registers are a registers block in Nuvoton SoCs that
> > >>> +  handle both reset and clock functionality.
> > >>
> > >> That's still vague. Say something useful.
> > > Will describe more
> > >>
> > >>> +
> > >>> +properties:
> > >>> +  compatible:
> > >>> +    items:
> > >>> +      - enum:
> > >>> +          - nuvoton,npcm750-clk-rst
> > >>> +          - nuvoton,npcm845-clk-rst
> > >>> +      - const: syscon
> > >>> +      - const: simple-mfd
> > >>
> > >> No, it's not a syscon and not a simple-mfd. You just said it is clock
> > > Yes, I understand the syscon node represents a register region
> > > containing a set of miscellaneous registers, but as explain above it
> > > is quite the case here.
> >
> > Nothing in this patch was telling this.
> >
> > > I will remove the simple-mfd.
> > >> provider and reset controller. Thus missing clock cells and reset cells.
> > > The reset cell and clock cell found at the clock and reset dt-binding,
> > > is it enough?
> >
> > This is the reset and clock binding, isn't it? You called it (your title):
> > "Clock and reset registers block in Nuvoton SoCs"
> >
> >
> >
> >
> > Best regards,
> > Krzysztof
> >
>
> Best regards,
>
> Tomer

Best regards,

Tomer

