Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2831779987
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjHKVgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbjHKVgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:36:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F6C2684;
        Fri, 11 Aug 2023 14:35:59 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26837895fc8so1511145a91.0;
        Fri, 11 Aug 2023 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691789759; x=1692394559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVN34/L0LXPAOlvoezQh0dWRI1UDqihyAQoFEN/Tp9A=;
        b=X6w6KfJVsxFhcpOsyqAcq6NFck5JZAtmFXcpoBCKW+LibzELL03+4FRRnxABYR/INA
         w+beJrqDQvBOs0H/UhPOY2C4j67uv2tJ9dGzreUuBFyZTWOvEiQWdrDCGV35t4xJ98BU
         z7ciw/evfhALpBh7xrtkh4rsLHgWVdQBvgpABWs7pBc75yL/KTTodRdQwVkqUqYYzAoG
         8IvnPIdido8PrPgeO6olFGteP2VQ6FqCMDM8CrJGF1LzHaG3Cy5D7ZWz9ip7bXs2GVfO
         HRkIOE+BtU2IRBtWXJ1S5G05rYFNlW/uZBaxAI+ncWsd+n6PIU0hWaaLA7rjPlzPGXdn
         53TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789759; x=1692394559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVN34/L0LXPAOlvoezQh0dWRI1UDqihyAQoFEN/Tp9A=;
        b=NBQeOZBtMbte/MOffhAKbtB3mO8frQgrNeEkmF5dVANJbjB/tOylhu5SV3Hvumm/ih
         g/ps2deLIQbKVcFitflIIXgT1fy3etfkvtYtrqOpoewxV6HQTqzaMd8VJHiErYCf+3AT
         wdwsM5elNnWu0TOd1LajMapbn519WfPnVqtQGsPVzFBMr1eQOzB+azYDiXmRbX221xNs
         Yxs8yzhxkVBpH9VZBUzMtMjxP548atWKhdfH4E6yHRBMqaB0iVz8HyDbvxE4/ZBMP+Bk
         ucATIHnR0+igpSs0SBavLNDYNeDxU6H/Eb4jNh2ntFYHrieHSY+2Mkg3rhfWBTeuSVBC
         on5w==
X-Gm-Message-State: AOJu0YwxDoSolksJnc93zmst6d08iB2v2+ZpBmp4NA2h68nD4Icn5guK
        iMntd/j74+NsiEPNRyM8B+0b1iR3vbFAiwxu2np42cw69HY=
X-Google-Smtp-Source: AGHT+IGP7ETMNL5/fx8NrUEj9nsm/2+lZEWtjE3KT7NkQDyuTMP21kHUQCwxvpSna6GErct0hMvMsIBjidU0Y4sPIpc=
X-Received: by 2002:a17:90a:8b11:b0:26b:17ef:7365 with SMTP id
 y17-20020a17090a8b1100b0026b17ef7365mr1932201pjn.48.1691789758869; Fri, 11
 Aug 2023 14:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230811210142.403160-1-robimarko@gmail.com> <20230811210142.403160-2-robimarko@gmail.com>
 <4c96210b-4567-4cb5-80bb-7adca6c5f124@linaro.org>
In-Reply-To: <4c96210b-4567-4cb5-80bb-7adca6c5f124@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 11 Aug 2023 23:35:47 +0200
Message-ID: <CAOX2RU6X0Tww4UkTKVfc=PLY=RKVJdsm+gomytT0vOydTF+Hnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node
 with bindings
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 23:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 11.08.2023 23:01, Robert Marko wrote:
> > Rename the SPI-NOR node to flash@0, remove #address-cells and #size-cells
> > as they should be under the partitions subnode and use the generic
> > jedec,spi-nor compatible.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> You can also do "nandmanufacturer,mx25l25635e", "jedec,spi-nor"

Hi,
I grepped the vendor U-Boot to make sure it's not being triggered off
the mx25l25635e
compatible but the only hit is the IC support itself.
MX25L25635 was just the original NOR IC Qualcomm used on the board so
to me it made
most sense to just use the JEDEC compatible as NOR itself is JEDEC NOR
compatible.

Regards,
Robert
>
> Konrad
>
> >  arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> > index 0714616c9e45..f7ac8f9d0b6f 100644
> > --- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> > +++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> > @@ -75,11 +75,9 @@ &blsp1_spi1 {
> >       status = "okay";
> >       cs-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
> >
> > -     mx25l25635e@0 {
> > -             #address-cells = <1>;
> > -             #size-cells = <1>;
> > +     flash@0 {
> >               reg = <0>;
> > -             compatible = "mx25l25635e";
> > +             compatible = "jedec,spi-nor";
> >               spi-max-frequency = <24000000>;
> >       };
> >  };
