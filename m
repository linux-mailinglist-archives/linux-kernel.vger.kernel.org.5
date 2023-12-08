Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622A380A429
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573789AbjLHNJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjLHNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:09:36 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1A41723
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:09:41 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-dbc4df9fb11so859233276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702040981; x=1702645781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9LGacmcIHoUBXEI5ozVl+HOy1oDLjhGzrBNeMtvAN8A=;
        b=LoCAaWSF8yLQ9kVM5NCnE/QXwlq1gRd05U5DWPBy0Amit8kFcpgkZhF9VnefvMR/XY
         fLPThnovmbcpiQ2J5gbx3dcoNRcIGggQ1l3y93A2Fq9r4f7sPQGxex0vKnlb0vcaR0tb
         OprFVFyz1xPKf73YV8NoRTIJ98FHmSejlfGZ54MAT3mukf+Qcv58ma52tk+xSE1JYQ1v
         UwSambp5P9cRBkfEBsRpcgVoxp1IvHqQ+4+Z2Ez16buggGVXHYbzJJrFgXod3sAlAXk1
         QmOjRJspfCjM/dSlcMJ0o/GRZzyLJjqdkXFy4cmZ8ht8o8g7zDbLf963F2A1nfjpXqbF
         DSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702040981; x=1702645781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LGacmcIHoUBXEI5ozVl+HOy1oDLjhGzrBNeMtvAN8A=;
        b=P2y6g2a7beckYI3xyYn5XN27eGrqtw1nGpeBO//GnSxTKIWYFBJXHT1j+yw6fkN1sQ
         0QRCZalK6YgbP/tCOcHAryj4Kf669DiXzsDU6cH1e9HTL+blibROz4bhjzi6JEMZ41Fv
         OfYC/6sbwOWA1BxliLCBE13GZTg/dfROb/fWL2q7AiUnbKJWzDuDFduaIxYLfeFDuYBB
         tyiFIHvAqVAzGlWU+EkKFIwigpI5fEXDLLlxeltpuWv64T9YnVRJwvJu1WFbg5Pvl+4D
         NrKZXTxgwLNJxQ+SuKw6hwjyvAZtEdNY0ykHtWMYF4IdUXCpXCNRJwvcFMtso4Ib53Q4
         kaUw==
X-Gm-Message-State: AOJu0Yy+G6acJVKcgGKShsip9nyaBGtxU9UVk1S1Y/HnEBezh0tbYfo1
        apIw2xLGYkMxOYBXIkzJ3tZL6vKzy/0bovgha+FenA==
X-Google-Smtp-Source: AGHT+IFcz1TMb/FbYR1pHalLsvmxDPmXYW2foZedR2lu/jYaHLKXoqS0Df6ZyEAz4BqzcPrk+GlvLoXpcBivch69Ws4=
X-Received: by 2002:a25:381:0:b0:d9a:dfd2:cce3 with SMTP id
 123-20020a250381000000b00d9adfd2cce3mr3650992ybd.58.1702040980913; Fri, 08
 Dec 2023 05:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-edp-x1e80100-v3-0-576fc4e9559d@linaro.org>
 <20231122-phy-qualcomm-edp-x1e80100-v3-2-576fc4e9559d@linaro.org>
 <b6d3928c-75ba-47a3-93fc-a60729be2e35@linaro.org> <545d3ace-66e5-4470-b3a4-cbdac5ae473d@linaro.org>
 <ab7223a2-9f3f-4c9c-ab97-31512e7a0123@linaro.org> <CAA8EJpoboN85bLiayXJgn5iwh+Gn0OtK0aZ26ZJu9H3xkTT2Tw@mail.gmail.com>
 <d9d27fa4-6ede-4958-b717-db425be61068@linaro.org> <CAA8EJpq7dB+45fiq2WmkMmSO7KszY0Et_t1gZ9ZvfsSxftpm8g@mail.gmail.com>
 <d885928d-035b-4abd-890b-c9626b925d76@linaro.org> <CAA8EJpr+C23evpRWMHatF6ChNvr3G-sAuXOi4e-7Tix23JV=Fg@mail.gmail.com>
 <29d7c97f-cc98-4f67-9bdc-3005796180c9@linaro.org>
In-Reply-To: <29d7c97f-cc98-4f67-9bdc-3005796180c9@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 15:09:29 +0200
Message-ID: <CAA8EJprU8AW3D77zv0qc-ANnjWw+c-Z9Nx2nA+ZF6bqEFh3+=A@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 14:47, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/12/2023 13:35, Dmitry Baryshkov wrote:
> >>>>> Same applies to the displayport-controller. It can either drive the DP
> >>>>> or eDP output, hardware-wise it is the same.
> >>>>
> >>>> Therefore what I proposed was correct - the block which uses the phy
> >>>> configures its mode. Because this part:
> >>>>   "this phy is of this type on this board".
> >>>> is not true. The phy is both types.
> >>>
> >>> But hopefully you don't mean using #phy-cells here. There are no
> >>> sub-PHYs or anything like that.
> >>
> >> I am exactly talking about phy-cells. Look at first example from Abel's
> >> code.
> >
> > I always had an impression that #foo-cells means that there are
> > different units within the major handler. I.e. #clock-cells mean that
> > there are several different clocks, #reset-cells mean that there are
> > several resets, etc.
> > Ok, maybe this is not a perfect description. We need cells to identify
> > a particular instance within the major block. Maybe that sounds more
> > correct.
>
> No, the cells have also meaning of additional arguments. See usage of
> phy-type (not the one here, but the correct one) and PWMs.

phy-type being used for the 7nm DSI PHY, where it specify exactly the
same thing: whether the connected device uses D-PHY or C-PHY modes of
the PHY.
cdns,phy-type - selecs between PCIe, DP, USB3 or other modes of the PHY
ti/emif.txt: phy-type specifies which PHY is attached / used in the controller
xlnx,phy-type: deprecated in favour of phy-mode, selects MII mode for the PHY
marvell,xenon-phy-type: I _think_ this specifies the actual PHY
attached to the controller in hardware.

> > For the USB+DP PHY we use #phy-cells to select between USB3 and DP
> > PHYs. But for these PHYs we do not have sub-devices, sub-blocks, etc.
> > There is a single PHY which works in either of the modes.
>
> Is it different than case here?

Hmm, I was not clear enough.

USB+DP = two different PHYs in the same hardware block.
DP-eDP = single PHY, working in one of the modes.

>
> >
> > Last, but not least, using #phy-cells in this way would create
> > asymmetry with all the other PHYs (and especially other QMP PHYs)
> > present on these platforms.
>
> OK. Is phy-type not something different?

No. It doesn't redefine what we already have for other QMP PHYs, it
defines new property.

>
> >
> > If you feel that phy-type is not an appropriate solution, I'd vote for
> > not having the type in DT at all, letting the DP controller determine
> > the proper mode on its own.
>
> Can we do it? That's BTW the best option.

That's a good question. We have separate -dp and -edp compatibles for
the DP controller, but I think those also should go, at least for
newer platforms. And the reason is the same, there is a single
hardware block, just two modes of operation. See mdss_dp3 in the
X13s's DT file.

I had a thought of using aux-bus presence to determine whether the
controller is working in the DP or eDP modes. But this might need
additional care for older DT files.

-- 
With best wishes
Dmitry
