Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5C78ECEA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjHaMRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbjHaMRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:17:41 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E30E43
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:17:36 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d71dd633f33so507420276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693484256; x=1694089056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=syEaiGRaVm11lR8QqvtDQo4Ok8f3C/t2r9+YRLItERc=;
        b=pZcTADXCDuw5EBW1Vgzg5TIyDzWZ+RYpHck0uiS/vJeYNzLKzWzpC1y4C3JpY/9dzO
         EH2VmaGxcEJjY+E3H3ajWJ7MhdYDa6KoNp0Yubf93Gd9vd0ZZKb0564HR0Z9+koRoGC5
         /fhjmlkxWOR+KsQZKwhGGzrK6DgkK2TPuNh4TLvjrzV22bXOdET+/Dls9HWfblZZDkeh
         b4+IotAcBUIc5jdwJftCG1Bo+oAfFZfz/LOzmJ2+7dtf5/+5DzqipYAo3PHMrDIvN5hf
         DQhz878qCjA5d/4Np5Yt0tV/TFBhwrlcx5Pe1ybyyh2wghjJ59ATy8MmBAnDBtq/qQyo
         Ptbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484256; x=1694089056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syEaiGRaVm11lR8QqvtDQo4Ok8f3C/t2r9+YRLItERc=;
        b=RoDSzTy+pszjtRgquveV7HHw1QnwzDHWU/eYCXQfmS2h6nY7jmP5hYS+H7eeedil9l
         /mX73orPvdaM9uLRVEHrvR634rVILEd3trsI9YQwL9iuekt3I3m7xKXHwMc1psXEtCvI
         kN3eqI7qb12qZrC1gkvfDNe1ecYSyJtiA7AwWTxrgbo0Oj2MbwgZKFcM4q5amuidZKmA
         rVq0DlerPDRDQdeJJGCEdNDjnl8SSUnd9jcEzx84yibjH0GaPoxM5dSeboa474dn3EB4
         2piRGfGAttQ0u9VEhNidxB7F/Ne90GPPcGane2BO/+1UwYvnW/a4HQ2rI5zgsjAPRpWH
         LgVw==
X-Gm-Message-State: AOJu0Yym/9Vvx3mSxFnIE3jUhP7Wc3jBu09qkYuyM7+qoiyjiBCcPcEN
        Kkk536G9nE9LuyZla/189rc+IBin12/xO9IAAMgzGQ==
X-Google-Smtp-Source: AGHT+IFg5anB1ArsDySQKwtDJpRsJZ5RNiqtpgRDMHHYYb/fTbUQqkb583dYAPLDAwMgVlZ2vMo5v7cfP0nFlXNf1hM=
X-Received: by 2002:a25:d246:0:b0:d0d:102c:78a8 with SMTP id
 j67-20020a25d246000000b00d0d102c78a8mr4753173ybg.31.1693484255908; Thu, 31
 Aug 2023 05:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
 <20230829135818.2219438-2-quic_ipkumar@quicinc.com> <CAA8EJpqA-poJ9=XKJa2s=yZUGbBbgOqgiDC-q9skJzBqLux84g@mail.gmail.com>
 <73879012-581d-47fb-b741-577c90b31dfb@quicinc.com>
In-Reply-To: <73879012-581d-47fb-b741-577c90b31dfb@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 15:17:24 +0300
Message-ID: <CAA8EJpr3PJtvyYKRPqT=hO4sUd4oOjTvOjD3kOqffbjzHdByAw@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: phy: qcom,uniphy: Rename ipq4019 usb PHY
 to UNIPHY
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     robert.marko@sartura.hr, luka.perkov@sartura.hr, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, nfraprado@collabora.com, rafal@milecki.pl,
        peng.fan@nxp.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 14:54, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
>
> On 8/29/2023 7:49 PM, Dmitry Baryshkov wrote:
> > On Tue, 29 Aug 2023 at 16:59, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
> >> UNIPHY / Combo PHY used on various qualcomm SoC's are very similar to
> >> ipq4019 PHY. Hence renaming this dt-binding to uniphy dt-binding and
> >> can be used for other qualcomm SoCs which are having similar UNIPHY.
> >>
> >> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> >> ---
> >>   .../phy/{qcom-usb-ipq4019-phy.yaml => qcom,uniphy.yaml}  | 9 +++++++--
> >>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>   rename Documentation/devicetree/bindings/phy/{qcom-usb-ipq4019-phy.yaml => qcom,uniphy.yaml} (78%)
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
> >> similarity index 78%
> >> rename from Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
> >> rename to Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
> >> index 09c614952fea..cbe2cc820009 100644
> >> --- a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
> >> +++ b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
> >> @@ -1,13 +1,18 @@
> >>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>   %YAML 1.2
> >>   ---
> >> -$id: http://devicetree.org/schemas/phy/qcom-usb-ipq4019-phy.yaml#
> >> +$id: http://devicetree.org/schemas/phy/qcom,uniphy.yaml#
> >>   $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>
> >> -title: Qualcom IPQ40xx Dakota HS/SS USB PHY
> >> +title: Qualcomm UNIPHY
> > We know that UNIPHY was a common design / IP block used for APQ8064
> > SATA and MSM8974 DSI and HDMI PHYs. Is this the same design, or was
> > the name reused by the Qualcomm for some other PHYs?
> > Several latest generations have USB QMP PHYs which are called 'uni-phy'.
> This PHY is build on top of QCA Uniphy 22ull. A combo PHY used between
> USB Gen3 / PCIe Gen3 controller.
> It is different from USB QMP PHYs.

So we have now three different items called Qualcomm uniphy. Could you
please add some distinctive name?

>
> - Praveenkumar
> >>   maintainers:
> >>     - Robert Marko <robert.marko@sartura.hr>
> >> +  - Praveenkumar I <quic_ipkumar@quicinc.com>
> >> +
> >> +description:
> >> +  UNIPHY / COMBO PHY supports physical layer functionality for USB and PCIe on
> >> +  Qualcomm chipsets.
> >>
> >>   properties:
> >>     compatible:
> >> --
> >> 2.34.1
> >>
> >



-- 
With best wishes
Dmitry
