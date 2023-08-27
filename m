Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0323A789FFA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjH0Pbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 11:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjH0PbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 11:31:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71CFEC;
        Sun, 27 Aug 2023 08:31:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso35573751fa.0;
        Sun, 27 Aug 2023 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693150262; x=1693755062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5hyLyH0mDfFi9IsH9oag3TfSy1UdIPJs5zbsS8pbums=;
        b=AEPXDMd65P5w9MhuYTMXNw/oNh1MH+G3kvUYmhSNKjYQ6PPs/uak9/dvRsscbxKz1d
         wq+Pzk2vT3zCAUW01km2yt2FeqVjpXEjxB86/PRFh4yXicGJUuKlD8+QcH3Kkh7k244C
         nu/y5AmrkbrQU304zW0ELTvnKCtpQsQwhfjL/hJ72n5/OSkRErJPURaO8G0NOwrM13Qi
         cOtRqomWqZ5cgBHN1Gg693C37w7lg6MOOPXuWm4TZiCLdK4SpKqWI/8oqTgAN67G5sgs
         UjgFz6U6160lBnlVtwGIppBsQZDV5ft4XHDbBincOGdIvCMVRmRPN8Kz+6HLrXAR8ERy
         6CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693150262; x=1693755062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hyLyH0mDfFi9IsH9oag3TfSy1UdIPJs5zbsS8pbums=;
        b=UQ8hTRhc4ldJfeajg/9k62SKAOOQGgkJFPZ2c6tWgJYZSayzKDDWhPSklZKRpo0u5N
         hpaWHeOL5ioGpD8CoqOScZVJc67fsCo2Oc7PV0Zha1isbY6iiqUC+1W51iTJ7RCaSAaA
         UHW4+jzb+TuJj1RRNBUWwHP1JHGvjvqfFlB8r8ydGZs3Ou3NUEIpYZSPQfPDR1+vSjVn
         mfb2ciWB4EuEgHPTQwbp4ocgfxlTsBOfzkuxGB2qK/LvT7q81ZL/v7pRzcvGJGJaE8i+
         yaOhyXEkyph7lsDOUOwhC5ri/nQTV+jm4Lm4ONqXwRQAxVJtXZDzpXCUmONmuSg+OA8H
         yUkg==
X-Gm-Message-State: AOJu0YzOuv8mrEEmJx0yTfYM+SEv75gNy0mqwg+Zr5qt/D2jKQ6pQGsr
        blkn9M11BvnjNz4jQkwAi3cuJIu/pTo+WAFUcSE=
X-Google-Smtp-Source: AGHT+IF6eeXSWjOmnwZg2jdWMWE1Ex1wqBTTysga0NQqKbYF8K8PfP948uHtG9/R94LZTmUbc5D2S+UonoeAAfteX0E=
X-Received: by 2002:a2e:b5d9:0:b0:2bc:fce1:54d3 with SMTP id
 g25-20020a2eb5d9000000b002bcfce154d3mr2932915ljn.41.1693150261834; Sun, 27
 Aug 2023 08:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230809185722.248787-1-tmaimon77@gmail.com> <20230809185722.248787-2-tmaimon77@gmail.com>
 <20230821170941.GA1915730-robh@kernel.org> <CAP6Zq1i+P8Jh2_G9gJMdtCKcVF6m9vkWAP5rJXBCJ1aNfc2Bvw@mail.gmail.com>
 <53987f0f-dfda-3572-1545-755072328be4@linaro.org>
In-Reply-To: <53987f0f-dfda-3572-1545-755072328be4@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 27 Aug 2023 18:30:50 +0300
Message-ID: <CAP6Zq1gcWHXUL=uuzkYkJ6VWwoS-9G_aEK2HizfAWr6oZZdzWQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl
 and GPIO documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linus.walleij@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your comment

On Sun, 27 Aug 2023 at 14:13, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/08/2023 11:44, Tomer Maimon wrote:
> >>> +      pinctrl: pinctrl@f0800260 {
> >>> +        compatible = "nuvoton,npcm845-pinctrl";
> >>> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> >>> +        #address-cells = <1>;
> >>> +        #size-cells = <1>;
> >>> +        nuvoton,sysgcr = <&gcr>;
> >>> +
> >>> +        gpio0: gpio@f0010000 {
> >>
> >> unit-address should be 0.
> >>
> >> Otherwise,
> > The unit-address is correct f0010000
>
> Then how does it pass W=1 builds? How unit address can be f0010000 but
> reg is 0? Really...
Maybe because the ranges are ranges = <0x0 0x0 0xf0010000 0x8000>?
I didn't get any warning regarding the unit-address
bash-4.2$ make ARCH=arm64 dt_binding_check W=1
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
  DTEX    Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.example.dts
  DTC_CHK Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.example.dtb
bash-4.2$ dt-mk-schema -V
2023.7
>
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >>
> >>> +          gpio-controller;
> >>> +          #gpio-cells = <2>;
> >>> +          reg = <0x0 0xB0>;
> >
> > Thanks,
> >
> > Tomer
>
> Best regards,
> Krzysztof
>

Best regards,

Tomer
