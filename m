Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F080A364
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjLHMgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjLHMgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:36:44 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9394C198D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:36:48 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d3efc071e2so18326117b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 04:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702039008; x=1702643808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl14rNbix2kUzr/44N3YRDcJydiYUcssbsUy/Lxl2Z8=;
        b=XOfpj0vxlepbk0G6TFcUUXcXEywmHU2GDIJnhha/hYzdL2OueK2wQbOBCdBOiR2h9H
         DI6XJFGO133UJHu7mHxGqBMSntnC2Thto84DmkEHkuqLvYA8fUcFJQGS70TIH343u2q0
         tDJOeRYU9IDZPY6ob7fgpTjdIqpqyIc9Envf4uE0DEjhpZ/DsKch/VTSD7awleJgpSOt
         OG5TCyfQsez4hObwE1/3yBO9yUyRGBW2hld7jGnkttq6fSxV+rA9RR5tY0Kfguz6ulOZ
         KZ6hnM1tkx3FeAKugSneE2eScgnTnNEJDsoBrl0FUoXUt0V9ZO/lqoL0/fPIwskxm3SI
         aYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702039008; x=1702643808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kl14rNbix2kUzr/44N3YRDcJydiYUcssbsUy/Lxl2Z8=;
        b=dd2elzkVnY20NHYrO+cs/HdzFzv5jTsROr68FSU/rgXAneYanE/lQKs5ZcNxfyukt2
         0cpxTkz88feeOfgwkmIzpH5e0sKxJcLRJMoRpZasFmDC9uz1uO9ezjnusfiH4sDcZRSX
         wjrszCfvb9ZH3PY8ZXZB2khF2jxzBOd9ibbnwQTGBtspp7VRekmNFPodnS4zbWfJ86li
         t2L+NPVvU3l4GXPKWxpw0zbctop/3q9aNkxKGgStApxWryQbwXSsIMC0CI0ld9T4mP7R
         3nULbnjwcqTw8WYINqjPJncP+4yn2+ZMsckQQeLzbBc1Cx78f1Kg1F5b974pG0KvwR+D
         ySvg==
X-Gm-Message-State: AOJu0YzU6/rP46TkppWcB3xbr9hgHTdUoztz3s3zMUfNBPA4LXP1EIMv
        c6/KJzHotziZXCcUpdavicKbk/zRxuLWWx3ssF3IRQ==
X-Google-Smtp-Source: AGHT+IHy1Q9+E3f10R2PU3el+hjqwtKsVqfZDIhUgZWe8w1MbNoJfMJQ2xQDqxpqyqTpj4DJAI8bmmBSs7ObsVLSxWY=
X-Received: by 2002:a05:690c:fc3:b0:5d3:9f2d:658c with SMTP id
 dg3-20020a05690c0fc300b005d39f2d658cmr4498370ywb.24.1702039007771; Fri, 08
 Dec 2023 04:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
 <20231208105155.36097-3-krzysztof.kozlowski@linaro.org> <CAA8EJpqKM45=6R0fHjDjNWfZpR-QxRoJo-ioB-t-WT188jpqnA@mail.gmail.com>
 <cbf0b9a6-2752-4ab5-ab21-af28e87fc1e6@linaro.org>
In-Reply-To: <cbf0b9a6-2752-4ab5-ab21-af28e87fc1e6@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 14:36:36 +0200
Message-ID: <CAA8EJppBTVw5ZoVGCxx9LYu-1dtEPqiE-H6SMk+6BCDd4O_DSA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: qcom: correct clocks for SM8150
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 14:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/12/2023 12:09, Dmitry Baryshkov wrote:
> > On Fri, 8 Dec 2023 at 12:52, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> PCI node in Qualcomm SM8150 should have exactly 8 clocks, including the
> >> ref clock.
> >>
> >> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Please take the patch via PCI tree.
> >>
> >> Changes in v3:
> >> 1. New patch: Split from sc8180x change.
> >> 2. Add refclk as explained here:
> >>    https://lore.kernel.org/all/20231121065440.GB3315@thinkpad/
> >> ---
> >>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 26 +++++++++++++++++++
> >>  1 file changed, 26 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >> index 5214bf7a9045..a93ab3b54066 100644
> >> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >> @@ -559,6 +559,32 @@ allOf:
> >>            contains:
> >>              enum:
> >>                - qcom,pcie-sm8150
> >> +    then:
> >> +      properties:
> >> +        clocks:
> >> +          minItems: 8
> >> +          maxItems: 8
> >> +        clock-names:
> >> +          items:
> >> +            - const: pipe # PIPE clock
> >> +            - const: aux # Auxiliary clock
> >> +            - const: cfg # Configuration clock
> >> +            - const: bus_master # Master AXI clock
> >> +            - const: bus_slave # Slave AXI clock
> >> +            - const: slave_q2a # Slave Q2A clock
> >> +            - const: tbu # PCIe TBU clock
> >> +            - const: ref # REFERENCE clock
> >
> > Can we change the order of the tbu and ref clocks and fold this into
> > the sc810x case?
>
> I prefer not, because this is an ABI-concern and we are supposed to keep
> things stable.

Ack, fair enough.

-- 
With best wishes
Dmitry
