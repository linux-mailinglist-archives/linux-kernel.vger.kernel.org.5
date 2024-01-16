Return-Path: <linux-kernel+bounces-27727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A521182F4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD07B22E73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C3B1CFAF;
	Tue, 16 Jan 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSLLEeq8"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DFF1CF98;
	Tue, 16 Jan 2024 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431760; cv=none; b=Ab7dZKoSMNYgjo1POXtrK9CnmGWcEj8kQjgn46Q04+TnqJYLATDUvl+7R6vOrDul2T+0IPg8ylHizptcLxwEcwiYMtvXHJDdOitKwNxM5c9xpkizFwfyVik1irKy478EO3H2NeATPp62MBDqJ2v1WDHRAG6rMBNCU7coYa2u7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431760; c=relaxed/simple;
	bh=M3WCsGftyWTyt8j4loJf7tAcRbNNPvT6iGKnr/fU//o=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=qqLpMOTj98MePb0nDEiMYfgsNkSIwNeVbTrtZd8VWRjru7qvaZ7FA3K1JnhlFY91vawxAtnjrXL+VWSsNij6Qe9r0bnIsn+YCSpUy+OatS11mY44Q4a71m37KUWzBPKu6SVabso7afM3f+k3o/WPIlEqCMr9zW6db5qLeLNH1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSLLEeq8; arc=none smtp.client-ip=209.85.219.174
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dafe04717baso8061386276.1;
        Tue, 16 Jan 2024 11:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705431758; x=1706036558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=37BvvneH+DlLoR6euXvYtraItFx+5QgIxfiDUnEo3GE=;
        b=OSLLEeq8OFRjxSLIR2yXNEaL07KcpA9pyV41Etxuay3+BRXZutVpieaewy+Ea6Nq+R
         ClWAaYw7ly0953pSwPCvdO8948cj54iVnLEQDlANs3MO8d5gCkBwVniqIfQ1wi6KM4j/
         gAHQn1Weu8dRbv5m56yzohpKEF/slyNcZALkwndUUxgHXVgo1jaRo4kw6v/dRpaTuhhY
         6+CbpWTMxWv3fPwKrz+YMbleCl+5Yd/C0+qihw71LB3JR/F7yaGPOqUlyI2dpK1vtUZG
         2xmMAz6sQrbGIGdhlXbHKQydQQjTaIqV913qdDLizVmxEPlxZG0V90xdTx6pgje/tAkq
         4/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431758; x=1706036558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37BvvneH+DlLoR6euXvYtraItFx+5QgIxfiDUnEo3GE=;
        b=jwoQ0ANypGD++zHwDKkhkaeeeeOJOwK0I+TRbnQVMkyVeUKIcYIiy22y+rn/RFvR8O
         U6ljrjuR01/wJm06tijsqi+sa/sjSrekhIf6kRRumNS8Atqv9LkiVns/XNlJiHA7K512
         eMF3zNQMoqXNDVhQru70ngiNTkSDvM8gI03Q7EkFrg4fXLLGjtH3Q6oqapZObrMEFXub
         MbQ9oyejPxyGDrxpCeN0kyh2OBAtFvjeNEnNrphdG1mK+Xgiw/doGNlox0oM6LNe2WSb
         cX681eaW6Wxtv9J45Qqjn46G9tl67F50qBledb+y2JJdC7ogQSygV1mW0c1YFDKdn1FD
         ayAQ==
X-Gm-Message-State: AOJu0Yxv10pquMG79F2kgUWoFuRsaIPOMDz5Opt4UQi8yesFfpos0H4s
	i+0dDeyX28Ja37bzLxk9d9KPG7AETQBA2HZ5CUA=
X-Google-Smtp-Source: AGHT+IF0aqNvzRI/TFPNIdSK5alOC8kbE6Zw7zw8xF650MhjRhQkjA0VEk6REdgO7WZuhmD2VIeoUxHhurXZEoeur8E=
X-Received: by 2002:a25:938d:0:b0:db5:5020:518a with SMTP id
 a13-20020a25938d000000b00db55020518amr4061693ybm.4.1705431757056; Tue, 16 Jan
 2024 11:02:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-5-tmaimon77@gmail.com>
 <98eaac00-1e3d-4c27-89f5-0b6ec0fcb710@linaro.org>
In-Reply-To: <98eaac00-1e3d-4c27-89f5-0b6ec0fcb710@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 16 Jan 2024 21:02:25 +0200
Message-ID: <CAP6Zq1hxTgJWtem4Y4_4Hv1ojy5edzGXeBGhh_gzyM4Kewsbeg@mail.gmail.com>
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

Thanks for your comments.

Sorry for the long explanation but I think it is necessary.

In the NPCM8XX SoC, the reset and the clock register modules are
scrambled in the same memory register region.
The NPCM8XX Clock driver is still in the upstream process (for a long
time) but the NPCM8XX reset driver is already upstreamed.

One of the main comments in the NPCM8XX Clock driver upstream process
is that the clock register is mixed with the reset register and
therefore we can't map (ioremap) the clock register
region because is already mapped by the reset module, therefore we
decided to use an external syscon to handle the clock and the reset
registers driver.

 I highly appreciate your guidance on this topic.

On Wed, 10 Jan 2024 at 22:59, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/01/2024 14:54, Tomer Maimon wrote:
> > A nuvoton,*-clk-rst node is present in nuvoton-common-npcm7xx.dtsi and
> > will be added to nuvoton-common-npcm8xx.dtsi. It is necessary for the
> > NPCM7xx and NPCM8xx clock and reset drivers, and may later be used to
> > retrieve SoC model and version information.
> >
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>
> > This patch adds a binding to describe this node.
>
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
>
> How possibly could it be v22 if there is:
> 1. No changelog
> 2. No previous submissions
> ?
Should the dt-binding and dts patches be a part of the clock patch set
(this is why it's V22) or should I open a new patch set?
>
> NAK, it's something completely new without any explanation.
>
> Limited review follows.
>
>
> >  .../soc/nuvoton/nuvoton,npcm-clk-rst.yaml     | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
> > new file mode 100644
> > index 000000000000..dfec64a8eb26
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-clk-rst.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Clock and reset registers block in Nuvoton SoCs
>
> This is vague. Any block? All blocks? Your SoC has only one block? I
> doubt, although possible.
>
> Anyway, clocks go to clock directory, not to soc! We've been here and
> you already received that feedback.
Since one region handles the reset and the clock registers shouldn't I
add the dt-binding to the SoC like the GCR and not to the clock
directory?
https://elixir.bootlin.com/linux/v6.7/source/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-gcr.yaml
>
>
> > +
> > +maintainers:
> > +  - Tomer Maimon <tmaimon77@gmail.com>
> > +
> > +description:
> > +  The clock and reset registers are a registers block in Nuvoton SoCs that
> > +  handle both reset and clock functionality.
>
> That's still vague. Say something useful.
Will describe more
>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - nuvoton,npcm750-clk-rst
> > +          - nuvoton,npcm845-clk-rst
> > +      - const: syscon
> > +      - const: simple-mfd
>
> No, it's not a syscon and not a simple-mfd. You just said it is clock
Yes, I understand the syscon node represents a register region
containing a set of miscellaneous registers, but as explain above it
is quite the case here.
I will remove the simple-mfd.
> provider and reset controller. Thus missing clock cells and reset cells.
The reset cell and clock cell found at the clock and reset dt-binding,
is it enough?
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties:
> > +  type: object
>
> No, instead:
> additionalProperties: false
O.K.
>
> > +
> > +examples:
> > +  - |
> > +    clk_rst: syscon@801000 {
I should use syscon no? if no what should I use?
>
> Suddenly a syscon?
>
> Drop unused label.
>
> > +      compatible = "nuvoton,npcm750-clk-rst", "syscon", "simple-mfd";
> > +      reg = <0x801000 0x6C>;
>
> Only lowercase hex.
>
> You just sent some v22 of something new, making all the mistakes from
> the past submissions for which you received feedback.
> > +    };
>
> Best regards,
> Krzysztof
>

Thanks a lot!

Tomer

