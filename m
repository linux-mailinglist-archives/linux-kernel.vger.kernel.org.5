Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2530F7E2082
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjKFLzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjKFLzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:55:08 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B89EDB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:55:05 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5b499b18b28so52411717b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 03:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699271704; x=1699876504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0lvjeJMZ5Z3vzScyAhd0JNzf6RjNdiewooYz+s8E+Mo=;
        b=IxG8Zu4w5kG0OGqDQcEdggmwT4vP6Cm5BoFips/TLwicbfYV3tWCOK5ccoZH15ZhnQ
         DsMvXsU+Y6NWDb6jGcpFErkL5pXsIjWokJwDnaLU/89DMLLOV2CrzubYkOOxnxwuJ5ug
         mIg+qEzkAALxcwP97iWQNGQSVMoJx/0tWFT3q4WkqSIUCC6u/BT3uGUb0ElgO+sD6DJR
         q/acNhBPsVa6zFcJ5+hCpacjI2ZU6kxXt3O1f4Iich3F2daFP5H4grYNl6GQJd7l6Ojj
         kBJk05Le8TRpKUH020PT0oCcfK4UeAQeXKBTLVHO4e/GhOBi47tHNvwURXjonQkjdpil
         CvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699271704; x=1699876504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lvjeJMZ5Z3vzScyAhd0JNzf6RjNdiewooYz+s8E+Mo=;
        b=jdCVG1WHbNDQcI9jUxNnusG67pS99HtzISu1s0rKoYdwvVTjYwuZ3nXZGBsO57Ir8G
         PtFcXyqoHt5doJX487T3KNNPWr1XqJIQ0Er+RiazgClftg25+Nc/9mt/i4IlY+huF/8l
         p+xKzJNyULtn5kqsw64/AhRKPuYLrnmRSvasqlGneScqs9fQ2PKFkacBc/HFhCt4enM9
         6UB9WCfeodYRsANuqIe3xemz9GLjb/fKJFGai0L1ksqdRCW1wuG0+z/jq+YommGKf91q
         OA9dRVDM0UyvRtguGD4ZxOGlzISvCknc/KJt+mJiA3iGufRoEnWuFx6Vh4KYpd6S7xsc
         N8jw==
X-Gm-Message-State: AOJu0YwWioC1CZU0HJQDrC63Xgt2wVv1a2UZKZaDrxhxLMuwt0m0sb1F
        Mm1VBkWibMs4TB2x40Bt6rlynS2ZXOq9EeWSNO1xFQ==
X-Google-Smtp-Source: AGHT+IFrUdolTDqB2qWVKUbHuQAih3w13pnTWXfUwjZW6gMNyXVS9vqD2MJyPXUfRGJsFfWDUDOyEH1iAEkw6Gph070=
X-Received: by 2002:a0d:ebc5:0:b0:5a7:aa54:42b1 with SMTP id
 u188-20020a0debc5000000b005a7aa5442b1mr10277254ywe.28.1699271704503; Mon, 06
 Nov 2023 03:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20231103184655.23555-1-quic_kbajaj@quicinc.com>
 <20231103184655.23555-3-quic_kbajaj@quicinc.com> <CAA8EJprNyu0r_mV9hbKA1fSvoEvTHuk5umxU8H64Voj_cnZcFQ@mail.gmail.com>
 <1830fc44-7bac-4db5-af59-112410d73a64@linaro.org> <af05dbdb-21bf-34f0-e9b3-9f6b9a0c3115@quicinc.com>
In-Reply-To: <af05dbdb-21bf-34f0-e9b3-9f6b9a0c3115@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 6 Nov 2023 13:54:52 +0200
Message-ID: <CAA8EJpq89g9EeyKcogU+Mt9ie6Bk-rmgi=GqyycYBm_291i1Bw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 idp and
 rb3 board
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nainmeht@quicinc.com
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

On Mon, 6 Nov 2023 at 13:41, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
>
> On 11/5/2023 6:38 PM, Krzysztof Kozlowski wrote:
> > On 03/11/2023 23:22, Dmitry Baryshkov wrote:
> >> On Fri, 3 Nov 2023 at 20:49, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
> >>>
> >>> Add qcm6490 devicetree file for QCM6490 IDP and QCM6490 RB3
> >>> platform. QCM6490 is derived from SC7280 meant for various
> >>> form factor including IoT.
> >>>
> >>> Supported features are, as of now:
> >>> * Debug UART
> >>> * eMMC (only in IDP)
> >>> * USB
> >>>
> >
> > ...
> >
> >>> +
> >>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi b/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi
> >>> new file mode 100644
> >>> index 000000000000..01adc97789d0
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi
> >>
> >> I have mixed feelings towards this file. Usually we add such 'common'
> >> files only for the phone platforms where most of the devices are
> >> common.
> >> Do you expect that IDP and RB3 will have a lot of common code other
> >> than these regulator settings?
> >
> > I agree here. What exactly is common in the real hardware between IDP
> > and RB3? Commit msg does not explain it, so I do not see enough
> > justification for common file. Just because some DTS looks similar for
> > different hardware does not mean you should creat common file.
>
> @Dmitry/@Krzysztof,
>
> Thank you for reviewing the RFC, we wanted to continue the
> suggestion/discussion given on [1] , where we discussed that this
> qcm6490 is going to be targeted for IOT segment and will have different
> memory map and it is going to use some of co-processors like adsp/cdsp
> which chrome does not use.
>
> So to your question what is common between RB3 and IDP, mostly they will
> share common memory map(similar to [2]) and regulator settings and both
> will use adsp/cdsp etc., we will be posting the memory map changes as
> well in coming weeks once this RFC is acked.

Is the memory map going to be the same as the one used on Fairphone5?

Are ADSP and CDSP physically present on sc7280?

I think that your goal should be to:
- populate missing device in sc7280.dtsi
- maybe add qcm6490.dtsi which defines SoC-level common data (e.g. memory map)
- push the rest to board files.

I don't think that putting regulators to the common file is a good
idea. Platforms will further change and limit voltage limits and
modes, so they usually go to the board file.

>
>
> Thanks,
> Mukesh
>
> [1]
> https://lore.kernel.org/linux-arm-msm/d97ebf74-ad03-86d6-b826-b57be209b9e2@quicinc.com/
>
> [2]
> commit 90c856602e0346ce9ff234062e86a198d71fa723
> Author: Douglas Anderson <dianders@chromium.org>
> Date:   Tue Jan 25 14:44:20 2022 -0800
>
>      arm64: dts: qcom: sc7280: Factor out Chrome common fragment
>
>      This factors out a device tree fragment from some sc7280 device
>      trees. It represents the device tree bits that should be included for
>      "Chrome" based sc7280 boards. On these boards the bootloader (Coreboot
>      + Depthcharge) configures things slightly different than the
>      bootloader that Qualcomm provides. The modem firmware on these boards
>      also works differently than on other Qulacomm products and thus the
>      reserved memory map needs to be adjusted.
>
>      NOTES:
>      - This is _not_ quite a no-op change. The "herobrine" and "idp"
>        fragments here were different and it looks like someone simply
>        forgot to update the herobrine version. This updates a few numbers
>        to match IDP. This will also cause the `pmk8350_pon` to be disabled
>        on idp/crd, which I belive is a correct change.
>      - At the moment this assumes LTE skus. Once it's clearer how WiFi SKUs
>        will work (how much of the memory map they can reclaim) we may add
>        an extra fragment that will rejigger one way or the other.
>
>      Signed-off-by: Douglas Anderson <dianders@chromium.org>
>      Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>      Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>      Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>      Link:
> https://lore.kernel.org/r/20220125144316.v2.3.Iac012fa8d727be46448d47027a1813ea716423ce@changeid
>
>
> >
> > Best regards,
> > Krzysztof
> >



-- 
With best wishes
Dmitry
