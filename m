Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227E27BD4A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345436AbjJIHtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbjJIHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:49:48 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CC8BA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 00:49:46 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a507c72d3eso51530157b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696837785; x=1697442585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1ko/afzrWnMuyW/Fvu3x6fDGqrMr7gR5Lx33eCGSQM=;
        b=Zv7myjY1qI0oki8mYuHDjtQuBLLyQSHxaUQ8dN5QWky9HX+3RZ22EDrfphjAvlgkDl
         UqAFHQJhm15YSuvFaOcVpIa5Xt5WPPqcx1ooUMuB9yK2RtS5OxfahRBveB00fr0thRQS
         5CnYE6uTDnS4YMJUOahBQmR/9GuMyYu45XLq8nGM/jG0vWQHHWDFSvVHv6OscLsgpvfp
         WT4GwLc2+YP0gcQWoOuI7fcSW5lGBG4ex3h9/SjI5M+c0p7MRSwWRfP1uIcIOGKHYzcI
         qsyQIcSwMPXRco1hUIqnmsNFrHWR5NXJQrik+Mqc2AAeFeO6MJ7HpkZpEcBqNtn4cHQd
         sCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696837785; x=1697442585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1ko/afzrWnMuyW/Fvu3x6fDGqrMr7gR5Lx33eCGSQM=;
        b=HxJ5qIs544walJq0auOrUwseEhvb2DYx9eyO/1TQAjGDdn02NZLTzx2EOcTctqgdPx
         shuF8RUQ/U4KI9U6PxFCdiIq3gZ+tT+jw6B9QunwpeZEiu5u1EWWIz9tmT97yt9MSbXJ
         PNelaZ2VwWq+wKAfPYdiOr9JWCs4sq3k2Ndzu9behSrTq7Dsi+KZFs9803PLv+0uWIwz
         qb1lvwdahFzjAMSVJuo6wPF3uAvEEBa+pOfGWuN+ZontPHQUlqOyGwZt3TFIr6mJgYD/
         2ZLST57HGGRNSfBs+M6FhCUZFO7rURtOoSgI9j2uKxKRAK/alQL8ZnfnPoetKtNMeeKq
         biSA==
X-Gm-Message-State: AOJu0YwhKwQHt8cg4/kzavtiX9bqf+2iREMcFJyYS4M4pU3PiUxgoJhr
        H+0J0QzwqZmjMOCrKbbuMLgYU3CwkiLgOC/JJttIQw==
X-Google-Smtp-Source: AGHT+IHsupyu181Ia+vdd7fdRv7eb6zYr4ocWpBgNFI7cCk4vzRoxo6eT6JrRJMme2aG2jFn2xZP6LOfhyt1pOjFf28=
X-Received: by 2002:a81:5404:0:b0:589:fad6:c17c with SMTP id
 i4-20020a815404000000b00589fad6c17cmr14152075ywb.45.1696837785383; Mon, 09
 Oct 2023 00:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org> <20231006132346.GA3426353-robh@kernel.org>
In-Reply-To: <20231006132346.GA3426353-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Oct 2023 09:49:33 +0200
Message-ID: <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
To:     Rob Herring <robh@kernel.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 3:23=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
> On Thu, Oct 05, 2023 at 11:58:43AM +0900, AKASHI Takahiro wrote:

> > A dt binding for pin controller based generic gpio driver is defined in
> > this commit. One usable device is Arm's SCMI.
>
> You don't need a "generic" binding to have a generic driver. Keep the
> binding specific and then decide in the OS to whether to use a generic
> or specific driver. That decision could change over time, but the
> binding can't. For example, see simple-panel.

What you say is true for simple-panel (a word like "simple" should
always cause red flags).

This case is more like mfd/syscon.yaml, where the singular
compatible =3D "syscon"; is in widespread use:

$ git grep 'compatible =3D \"syscon\";' |wc -l
50

I would accept adding a tuple compatible if you insist, so:

compatible =3D "foo-silicon", "pin-contro-gpio";

One case will be something like:

compatible =3D "optee-scmi-pin-control", "pin-control-gpio";

In this case I happen to know that we have the problem of
this being standardization work ahead of implementation on
actual hardware, and that is driven by the will known firmware
ambition to be completely abstract. It is supposed to sit on
top of pin control, or as part of pin control. Which leads me to
this thing (which I didn't think of before...)

> +    gpio0: gpio@0 {
> +        compatible =3D "pin-control-gpio";
> +        gpio-controller;
> +        #gpio-cells =3D <2>;
> +        gpio-ranges =3D <&scmi_pinctrl 0 10 5>,
> +                      <&scmi_pinctrl 5 0 0>;
> +        gpio-ranges-group-names =3D "",
> +                                  "pinmux_gpio";
> +    };

Maybe we should require that the pin-control-gpio node actually
be *inside* the pin control node, in this case whatever the label
&scmi_pinctrl is pointing to?

We can probably mandate that this has to be inside a pin controller
since it is a first.

Yours,
Linus Walleij
