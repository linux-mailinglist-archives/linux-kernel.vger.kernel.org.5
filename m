Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399E980A1C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573647AbjLHLE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjLHLEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:04:24 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0395F1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:04:29 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so2097287276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702033469; x=1702638269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmWSiLFpH5ilop9PgBwEvCl5zyYcl/sRlYRMt6cwB08=;
        b=O6pwzduEgfLIEYMWLFQAi2lxdt0lTx/zb4zr52eBLiWuoFV8V7WptdD3WuIgGxovL9
         wZz9hJJaBbMyJhAFNhr0QBV0T6X1Cc0YHHhqP5fO2zCVkB4Lr3BT8WRAqhr+uiUj4pI2
         LOGvvicm1RnWfcWW+0UEAtikHmBFdhM6GPbxjeRU9x1DZ6oovsQ3zRl2xWYeCk5G1YeF
         hVz3QpurKLy1fUVXizgdpJ4qUs+3aJ/55waeN8GESHBAMejfah1nPPOl/d2CKdD97/kI
         vjgeenHJ0GECd2EcR44Nn0cDL4yZeL6lwx1f9uzxjYu7Dn1L1cvet9gjuJKQOsVxDjh4
         P0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033469; x=1702638269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmWSiLFpH5ilop9PgBwEvCl5zyYcl/sRlYRMt6cwB08=;
        b=rUQTDT5rGNBTcF67p+qQizXwiiy4ihx2b9ZOjtKVhjTAnixDxu6WlpmmctgVducWjc
         oVNuAkpcBVcz/CyDwbldXVx5NLjMqHZQHomeT6Gf9DI1y+8I0TLXKQSpxRvcGQtsNhL0
         I6ICJZDiLXFDdEWgwhBIK/niULmGWoTFUIr4jfOYVA9hsv0f/sAmB5nltnliYyzvuntw
         vG2UVZ/ECVt7XoVgQePljMmgMTz1HJ8wqeLwaQGtKpqxT8nb/urVlpcTHZeWbinXcBEO
         YF0GOWX7m4PlwOlfjCN23mO6mD41ZelI39r5Aul1HoAw0rasuzIvjEsmtUR1wqAO4j6V
         GeMA==
X-Gm-Message-State: AOJu0YwamyBDXzdU0sYBUouPlNmyIDm7RAxCHq3iJorXa7MAlJpU1XOl
        O6heqVhMHEJNVeUf18/wGOmJ1Wr8dx+A++p1FZmHuA==
X-Google-Smtp-Source: AGHT+IGCB8quVSHKY0fmnpid8nxEPOPtVtmvqpR1rpFARtS3Ovn3+gVCYD81mAQa7wkJ4TWtjHLTA0qrGC8SKmGeTt4=
X-Received: by 2002:a81:4312:0:b0:5da:2235:493 with SMTP id
 q18-20020a814312000000b005da22350493mr3478692ywa.10.1702033469187; Fri, 08
 Dec 2023 03:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-edp-x1e80100-v3-0-576fc4e9559d@linaro.org>
 <20231122-phy-qualcomm-edp-x1e80100-v3-2-576fc4e9559d@linaro.org>
 <b6d3928c-75ba-47a3-93fc-a60729be2e35@linaro.org> <545d3ace-66e5-4470-b3a4-cbdac5ae473d@linaro.org>
 <ab7223a2-9f3f-4c9c-ab97-31512e7a0123@linaro.org>
In-Reply-To: <ab7223a2-9f3f-4c9c-ab97-31512e7a0123@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:04:18 +0200
Message-ID: <CAA8EJpoboN85bLiayXJgn5iwh+Gn0OtK0aZ26ZJu9H3xkTT2Tw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 09:47, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/12/2023 20:16, Konrad Dybcio wrote:
> >
> >
> > On 12/7/23 17:51, Krzysztof Kozlowski wrote:
> >
> > [...]
> >
> >>> +allOf:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - qcom,x1e80100-dp-phy
> >>> +    then:
> >>> +      properties:
> >>> +        phy-type:
> >>> +          description: DP (default) or eDP type
> >>
> >> Properties must be defined in top-level "properties:" block. In
> >> allOf:if:then you only disallow them for other variants.
> >>
> >>> +          enum: [ 6, 13 ]
> >>> +          default: 6
> >>
> >> Anyway, I was thinking this should be rather argument to phy-cells.
> > I'm not sure I'm for this, because the results would be:
> >
> > --- device.dts ---
> > &dp_controller0 {
> >      phys = <&dp_phy0 PHY_EDP>;
> > };
> >
> > &dp_controller1 {
> >      phys = <&dp_phy1 PHY_DP>;
> > };
> > ------------------
> >
> > as opposed to:
> >
> > --- device.dts ---
> > &dp_phy0 {
> >      phy-type <PHY_EDP>;
> > };
> >
> > &dp_phy1 {
> >      phy-type = <PHY_DP>;
> > };
> > ------------------
>
> Which is exactly what I proposed/wanted to see.
>
> >
> > i.e., we would be saying "this board is connected to this phy
> > instead" vs "this phy is of this type on this board".
> >
> > While none of them really fit the "same hw, different config"
> > situation, I'd vote for the latter one being closer to the
> > truth
>
> Then maybe I miss the bigger picture, but commit msg clearly says:
> "multiple PHYs that can work in both eDP or DP mode"
>
> If this is not the case, describe the hardware correctly in the commit
> msg, so people will not ask stupid questions...

There are multiple PHYs (each of them at its own address space). Each
of the PHYs in question can be used either for the DisplayPort output
(directly or through the USB-C) or to drive the eDP panel.

Same applies to the displayport-controller. It can either drive the DP
or eDP output, hardware-wise it is the same.

-- 
With best wishes
Dmitry
