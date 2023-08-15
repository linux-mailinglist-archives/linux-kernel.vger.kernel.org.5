Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5C77CF58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbjHOPjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbjHOPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:38:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D928F1986;
        Tue, 15 Aug 2023 08:38:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bdc243d62bso22474325ad.3;
        Tue, 15 Aug 2023 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692113927; x=1692718727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oPVA47bevwgKTndnRmaH+7HpYMRSlD2dI+EPjmMsVKY=;
        b=aG+N74rQXAjtpCKcHyWJdAeEtS20suYrX9q+zGyM6UQ/Nhp022HuVxaqetnKAE8hua
         nUB3hFKMnfz0r+ltmhK8S7I8CLRuRPnNmgidsRCYK/2hLLaIGM5MRnLBMGUsMYlslkvr
         xT23sB4D6CR5/ewPA7hDzYQ4b1sWoJtDy2FMn+dFgG3KLovi93MGxvziJDV8JcAlXgmd
         6BYUwVymM3U9d1eXuNjyTssD5YJB1tWRnaLw37SvSBTJ//OyQ/NKpNmwdqQJhwxyAq5G
         doh5ZvyiiFmetTw+NYJ1ouhlyhV/vT/sUQzV6fsQJfzSZ4haz9OMhqjj0SmTxXaLCuTJ
         PrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692113927; x=1692718727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPVA47bevwgKTndnRmaH+7HpYMRSlD2dI+EPjmMsVKY=;
        b=Ri9EDgwKginoLS7Y1vDHCl2pYljct54UkOnjS+taDPJMc+Qb25U7dE/x4q+yzoa0U9
         H3tqslxPJ/mOe93GJ/vISG2g0M1PhNbgZktC6MNleKxb3OMXGNeFXmBBW5KXvM3HCN0i
         SbVhlnwp0V5fX2ndo9O6P7Sl6wnKkmeQogoXaI4wLpz1xqM1bhUCLnweCE+gpvul9QNE
         4RmGg7jFWtyrl5yFEj89zGMltJUBd6FEZYogi90K79Rif/rO69UWRENL+kphqT1oMVM5
         F8+qyuYYDjPXNig/hY9kw8UUj3O1/71PTve626cd50JmUlv/T0FNd44g+S/o441tA9eS
         ufEQ==
X-Gm-Message-State: AOJu0YxzgQjcx/8JVwUVZxsS0jyhGez+ckDx74jlSmv8cTB92Y1D4W07
        C8pLGqf/Q7s4s1XXAV2WvNqaOsLR1EE6JzVe+O4=
X-Google-Smtp-Source: AGHT+IHlydyjtSV8QiF0UBTRISSH4+kZdt0Y9kwaL5fvh+plBjEHnzegcQyHd2HIPS3NUEbTNHwU/HA/mqplLmLyExs=
X-Received: by 2002:a17:90b:23c7:b0:269:1c2:f5c7 with SMTP id
 md7-20020a17090b23c700b0026901c2f5c7mr9651653pjb.21.1692113927155; Tue, 15
 Aug 2023 08:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230815141908.1084893-1-robimarko@gmail.com> <20230815141908.1084893-2-robimarko@gmail.com>
 <3174c398-a19a-3b59-c2fc-3ec9a5e1a9df@linaro.org>
In-Reply-To: <3174c398-a19a-3b59-c2fc-3ec9a5e1a9df@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 15 Aug 2023 17:38:36 +0200
Message-ID: <CAOX2RU6HYBzhh0TBdsFj5AJPwqdv2xQ=XsA=L-BaCwNUxTx2Vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5018: add WDT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 at 16:40, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/08/2023 16:17, Robert Marko wrote:
> > Add the required DT node for WDT operation.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > index 3285c86824cf..168322bfb11c 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > @@ -182,6 +182,13 @@ v2m1: v2m@1000 {
> >                       };
> >               };
> >
> > +             watchdog: watchdog@b017000 {
> > +                     compatible = "qcom,apss-wdt-ipq5018", "qcom,kpss-wdt";
> > +                     interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
>
> I think all GIC_SPI interrupts are level high.

They are most probably using GIC-500 which supports rising edge or
active high interrupts.
Both the older GIC-400 and newer GIC-600 also support the same.

Vendor DTS indicates this level, IPQ8074 and IPQ6018 which use the
same core, and it
seems the same WDT IP use the rising edge IRQ.

>
> > +                     reg = <0x0b017000 0x40>;
>
> Keep the reg as second property.

Ok,
will do.

Regards,
Robert
>
> > +                     clocks = <&sleep_clk>;
> > +             };
>
> Best regards,
> Krzysztof
>
