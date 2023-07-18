Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2761B757193
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGRCHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGRCHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:07:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE0E6C;
        Mon, 17 Jul 2023 19:07:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2632336f75fso3541524a91.3;
        Mon, 17 Jul 2023 19:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689646041; x=1692238041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U12thfBC/uhau1XBUrL7dHLjdhbT2BBv6HBHyUCow2Q=;
        b=FIFhiEruPtPW4fpcHerFnM562imVfAkWeAQHJQ+nWzK8MukPrmywDxIwaKCjorMrA8
         pH7fHLfTjspA+2vZSzMzskxDyxqFp2nPahCMWN7G1kMe/F/0Jk5qmlj/selw97TeQSIK
         0PXJD8K9A3cAu3eWJAb72uS1Q+vdkJX8FQKRKK0Q0hzdlDosk97LoA2gCxi/kNqMYT2u
         85INxYrmLM7/pr2caYdVpzI5SRvHrGS/Sy/eF7+9eX48l39pLdutPfqVUg3GdAoIA/Y7
         XYTT/lzq8+wAjcpBVsEL0m8XOBrgVqG0NRhU4r+bBogMeBlOcHasJBeimW/doOxYKKa+
         mOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689646041; x=1692238041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U12thfBC/uhau1XBUrL7dHLjdhbT2BBv6HBHyUCow2Q=;
        b=M4xcFuembH77y72Hr6HUCrcApjyDwrXHgJPILwplJV/zw406rZ0Vik8Ao7S6VvUPq0
         AUj6/VCn7lWFk653tQZs+6OkeZw61X9Y6l0kiZ7+QPuuPucTfK96+O7SfOTy+Sgpr1pK
         JgBrWbQBqnrP+QbSErbpRBsgB2xfnZjFVbh5dfvBOhklOqWcnlJOyuaELiz/F+jptOM1
         03SvyAPDpPUyz0yxyPptsd+TrJF+hGpHO03HL9UB2jaYHj1+NVogMk2cTOBcQN+xLPCW
         Tvy4Uq6CRYt0pgRLIFxcw3DwGL+phETJhFBR2S8vVT+wTlukaJ1ZTXLBRs3rSCa+bmHm
         NwDg==
X-Gm-Message-State: ABy/qLaY3T8yFm7jo3ZG5rxCKQicqs73NV0D4CBVqH4FPJ6pZ9/PPA2U
        sWTtWHepoL7fZGhbZvpjFcAt77Z+Y6tT7QUzaNj6ogny0ddw7dCF
X-Google-Smtp-Source: APBJJlE4ggLUXz6GDz5oqyoEaApEU+dMXR1SEDF/XWg9+xG+KK4aKhRKk0FRtBZ+wJXeVBb7Slj+IISsXIjPHmi5+PY=
X-Received: by 2002:a17:90a:bf10:b0:263:f643:4bd3 with SMTP id
 c16-20020a17090abf1000b00263f6434bd3mr11918894pjs.27.1689646041008; Mon, 17
 Jul 2023 19:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAKohO550=Nq3HvGj_4_CxBHxBv+HjXQpBOHC9jZAGPgyseX=bA@mail.gmail.com>
In-Reply-To: <CAKohO550=Nq3HvGj_4_CxBHxBv+HjXQpBOHC9jZAGPgyseX=bA@mail.gmail.com>
From:   Chih-Jen Hung <kobedylan@gmail.com>
Date:   Tue, 18 Jul 2023 10:07:10 +0800
Message-ID: <CAKohO56am94Rf5YyEFXaye6=R+Z7bdrQT5G1KaLH+0xrUU=tfQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: clock: ast2600: Add I3C and MAC reset definitions
To:     Conor Dooley <conor@kernel.org>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Chih-Jen Hung <kobedylan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chih-Jen Hung <kobedylan@gmail.com> =E6=96=BC 2023=E5=B9=B47=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=889:59=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Jul 17, 2023 at 02:58:58PM +0800, Dylan Hung wrote:
>
> Add reset definitions of AST2600 I3C and MAC controllers.
>
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> ---
>   include/dt-bindings/clock/ast2600-clock.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
>
> What changed compared to v1?
> Are there any users of the additional resets (eg, in a dts somewhere)?
>
> Thanks,
> Conor.

An existing macro, ASPEED_RESET_I3C_DMA, was removed in V1. However,
considering that this macro may be used somewhere, I have decided to
add it back in V2. I will ensure to include the changelog in V3.

>
>
> diff --git a/include/dt-bindings/clock/ast2600-clock.h
> b/include/dt-bindings/clock/ast2600-clock.h
> index e149eee61588..712782177c90 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -90,7 +90,19 @@
>   /* Only list resets here that are not part of a clock gate + reset pair=
 */
>   #define ASPEED_RESET_ADC 55
>   #define ASPEED_RESET_JTAG_MASTER2 54
> +
> +#define ASPEED_RESET_MAC4 53
> +#define ASPEED_RESET_MAC3 52
> +
> +#define ASPEED_RESET_I3C5 45
> +#define ASPEED_RESET_I3C4 44
> +#define ASPEED_RESET_I3C3 43
> +#define ASPEED_RESET_I3C2 42
> +#define ASPEED_RESET_I3C1 41
> +#define ASPEED_RESET_I3C0 40
> +#define ASPEED_RESET_I3C 39
>   #define ASPEED_RESET_I3C_DMA 39

This is the macro I added back in V2. There is no reset-line hardware
available for `ASPEED_RESET_I3C_DMA`, so I have added a new macro to
provide a better representation of the hardware design. I will include
the explanation in the commit message of V3.

> +
>   #define ASPEED_RESET_PWM 37
>   #define ASPEED_RESET_PECI 36
>   #define ASPEED_RESET_MII 35
> --
> 2.25.1
