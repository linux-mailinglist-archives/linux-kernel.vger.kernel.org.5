Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A22878277B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjHULAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHULAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:00:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E4DB;
        Mon, 21 Aug 2023 04:00:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-525656acf4bso4077385a12.0;
        Mon, 21 Aug 2023 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692615620; x=1693220420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGlPkN5vR6/cXafRltT2qDHXCkNMNiZanfUv1AGHWHA=;
        b=cX28qcpIpFYdPtU2I6lF4if5HSOmOSyw06W7Tg050kD8WyF6yNDeNL6Giqf5ThEeC6
         e+CybgtXogLy1uRbi3c2NTFpPb5+3FW9KLQrNffSu/E6SPRzwYDMuY8Fcl1jjelnB6hR
         DFLIIRXbErUnGoMwvNH+BRWPPrt5r9E6jM637DJfAtF+pSo1wfQjUyTd81EER2Kqzowt
         TA7gQR12TEiAhwSKfUZf+PY/xsazKqKfnuidzBMw5rdtX+ubvcts6oeOoiLv40ADR5w1
         8j4LyLq3ky5XjGj+mflB7wCBqjeEGJ+gL9SxRArHrORVqCi6+T+FsZz6eM8gLMUsgGzV
         bG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692615620; x=1693220420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGlPkN5vR6/cXafRltT2qDHXCkNMNiZanfUv1AGHWHA=;
        b=TmKumA7K2KnXcypxvBwn0I7eQf9Ol93IaCbok9WkpeVssrezKCFHkH/W0l2BHKMHJV
         GACnAv9N0CuT7N+d2AZhwzP2fglIE/5bX982WZtFC6E3HGrOVZQnPRgKeJYC9+uRujEZ
         aihHuQ8bAT87abz/jSrce3H8x2fYAC9ef1qYSihUCkzzmCB2w52htYplM7Z6L97GZjsV
         +bzxZ7Qq8cOeB5JbTDoi/RDZAFUkKNgIcWIksvYZZw2/ObP0dvwp3tQEyHXgY+PeuA4k
         FzjxPOuZOBk6UOGNFIdp/K/ZMC1Rl4y1hcQ0khAYkZ1q0Izxz29DW7kOs+W2San+bOOx
         ck0Q==
X-Gm-Message-State: AOJu0YyUr2FA1HGJIhHk/2bAleSwJUj1WeCCciSJLpr9lEI4tTYiTx/O
        ielDl0YB8GSlilTvCux7bDgCXVjNoj7veFWJI98=
X-Google-Smtp-Source: AGHT+IG+XWmQXevDO4t9KhuUGEuXpHar0oV8iglmHHAb/6YvZIzsSvu2qUz631d6EAz7jMsg2rQMSqh3+Q8bPUyHvoE=
X-Received: by 2002:a17:906:1dd:b0:99b:dd1d:bc58 with SMTP id
 29-20020a17090601dd00b0099bdd1dbc58mr5612591ejj.41.1692615620275; Mon, 21 Aug
 2023 04:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-2-keguang.zhang@gmail.com> <a9a7b65c-ef0b-9f66-b197-548733728d44@linaro.org>
In-Reply-To: <a9a7b65c-ef0b-9f66-b197-548733728d44@linaro.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 21 Aug 2023 19:00:03 +0800
Message-ID: <CAJhJPsXEf0Yuxasq24X=x_JtUJZrNC1aowfeuu9QM2kz+A=asQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: syscon: Add compatibles for
 Loongson-1 syscon
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 10:23=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/08/2023 13:13, Keguang Zhang wrote:
> > Add Loongson LS1B and LS1C compatibles for system controller.
>
> I asked not to use the same compatible for different blocks. Compatible
> is dwmac, but are you still going to use for other blocks? Please write
> proper description of the hardware.
>
Sorry. I didn't make myself clear.
The SoC only has one syscon with two registers.
And Each register contains settings for multiple devices.
Besides DWMAC, this syscon will be used for other devices.
Should I keep using loongson,ls1b-syscon/loongson,ls1c-syscon?


> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V1 -> V2: Make the syscon compatibles more specific
> >
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Docume=
ntation/devicetree/bindings/mfd/syscon.yaml
> > index 8103154bbb52..d701fff02abe 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -49,6 +49,8 @@ properties:
> >                - hisilicon,peri-subctrl
> >                - hpe,gxp-sysreg
> >                - intel,lgm-syscon
> > +              - loongson,ls1b-dwmac-syscon
> > +              - loongson,ls1c-dwmac-syscon
>
>
> Best regards,
> Krzysztof
>


--
Best regards,

Keguang Zhang
