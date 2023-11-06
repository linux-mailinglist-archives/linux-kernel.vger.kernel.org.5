Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9CD7E2FDD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjKFWcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjKFWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:32:16 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3FE1BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:32:13 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a90d6ab962so58827237b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699309932; x=1699914732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vS8c68PwDjZrnN8E2boHHmWYxJEzqCnb24kWpDMw6E8=;
        b=S75mCdalLoHkybIiSMWtuFGYwLKtR9guRCGLeQhwE2ru2kC3GA9RdxKTLt1uEzcis+
         gwsmjyzo4khfva/4D/0AYoPQXLISwXXs3is19rXLNXAENc2SOqFBz2lzYWf2Mqib7UXr
         xHNK2UfqGYEqO/dk5yXXVjjzeGyPwV/vU1cXUVt+8RKgL4c39F3fDsyiDlK85V9/3GLK
         kI+y++XhX6ZznJ65e6PUtSMK008wgSpKKHHrmSWA1Zp6xy33VRGhcOI42kSu+bvbDW0i
         aMLFEvNWjf235MYn4ZE6Cpaedn1m9Mgs6y16gC+xrP2k6z+9MEzBDShZc/Iqs5HRDguZ
         oyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699309932; x=1699914732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vS8c68PwDjZrnN8E2boHHmWYxJEzqCnb24kWpDMw6E8=;
        b=U3uRPCMjqKRzihAgHaNnpwPnq7nJd0BsXvmRf7my8e8e12C/eiKAHzigbGRfe+amy7
         aQGVsWEPExXPnQogWEx9YGb38sSXG0OlhBcbG1LTJR404Z21hkVnd/ldHLsOurGUVMT4
         DQBWrZMZ7JwPVTcaiY5rwi5Atb1LhLjxY/OunmfC5XOamZXx1VboM9dJFdKbcUObVxkd
         BMU44uMdv3w/2SnhQ2/XKvtxw2+BKX7E32M+xwneqIdWxe3kTyn46UXW4/ujIPd4C7qh
         bpI0TGQCXGxsdXKqJnceHapYyYlNqXFUpaTdeqNgEdiKl/yEsQ0+0RO5yhGr5ktATVR2
         gZBA==
X-Gm-Message-State: AOJu0YxcboubsPWFGbhJxu07BA8rETs96tJQ6Tci4/j7OOce9ZpRqJS4
        bd+8gaHjCaK8SidKh3izT93gH71Er4G0pg4ft4Q1GA==
X-Google-Smtp-Source: AGHT+IEkfcFDjRMb51eVMXIsoxg+oNYwQThokby7Lk/bHzE7TTbyMrHrz9hxP5reF14igeHX+vIX1BenSnXNUlcnUGE=
X-Received: by 2002:a25:e702:0:b0:d43:a84f:a6aa with SMTP id
 e2-20020a25e702000000b00d43a84fa6aamr28064010ybh.39.1699309932551; Mon, 06
 Nov 2023 14:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20231103184655.23555-1-quic_kbajaj@quicinc.com>
 <20231103184655.23555-3-quic_kbajaj@quicinc.com> <CAA8EJprNyu0r_mV9hbKA1fSvoEvTHuk5umxU8H64Voj_cnZcFQ@mail.gmail.com>
 <1830fc44-7bac-4db5-af59-112410d73a64@linaro.org> <af05dbdb-21bf-34f0-e9b3-9f6b9a0c3115@quicinc.com>
 <CAA8EJpq89g9EeyKcogU+Mt9ie6Bk-rmgi=GqyycYBm_291i1Bw@mail.gmail.com> <d5492e4d-6c70-7d6c-3f5b-a0b5d9266ab0@quicinc.com>
In-Reply-To: <d5492e4d-6c70-7d6c-3f5b-a0b5d9266ab0@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 00:32:01 +0200
Message-ID: <CAA8EJpr+8MSEHbziTJhhnkeFhPemRARL_bpWEvHmVvAcbp++Cw@mail.gmail.com>
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

On Mon, 6 Nov 2023 at 16:46, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
>
>
> On 11/6/2023 5:24 PM, Dmitry Baryshkov wrote:
> > On Mon, 6 Nov 2023 at 13:41, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> >>
> >>
> >> On 11/5/2023 6:38 PM, Krzysztof Kozlowski wrote:
> >>> On 03/11/2023 23:22, Dmitry Baryshkov wrote:
> >>>> On Fri, 3 Nov 2023 at 20:49, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
> >>>>>
> >>>>> Add qcm6490 devicetree file for QCM6490 IDP and QCM6490 RB3
> >>>>> platform. QCM6490 is derived from SC7280 meant for various
> >>>>> form factor including IoT.
> >>>>>
> >>>>> Supported features are, as of now:
> >>>>> * Debug UART
> >>>>> * eMMC (only in IDP)
> >>>>> * USB
> >>>>>
> >>>
> >>> ...
> >>>
> >>>>> +
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi b/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi
> >>>>> new file mode 100644
> >>>>> index 000000000000..01adc97789d0
> >>>>> --- /dev/null
> >>>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi
> >>>>
> >>>> I have mixed feelings towards this file. Usually we add such 'common'
> >>>> files only for the phone platforms where most of the devices are
> >>>> common.
> >>>> Do you expect that IDP and RB3 will have a lot of common code other
> >>>> than these regulator settings?
> >>>
> >>> I agree here. What exactly is common in the real hardware between IDP
> >>> and RB3? Commit msg does not explain it, so I do not see enough
> >>> justification for common file. Just because some DTS looks similar for
> >>> different hardware does not mean you should creat common file.
> >>
> >> @Dmitry/@Krzysztof,
> >>
> >> Thank you for reviewing the RFC, we wanted to continue the
> >> suggestion/discussion given on [1] , where we discussed that this
> >> qcm6490 is going to be targeted for IOT segment and will have different
> >> memory map and it is going to use some of co-processors like adsp/cdsp
> >> which chrome does not use.
> >>
> >> So to your question what is common between RB3 and IDP, mostly they will
> >> share common memory map(similar to [2]) and regulator settings and both
> >> will use adsp/cdsp etc., we will be posting the memory map changes as
> >> well in coming weeks once this RFC is acked.
> >
> > Is the memory map going to be the same as the one used on Fairphone5?
>
> No, Fairphone5 looks to be using chrome memory map and i suggested
> here to move them into sc7280.dtsi
>
> https://lore.kernel.org/lkml/d5d53346-ca3b-986a-e104-d87c37115b62@quicinc.com/
>
> >
> > Are ADSP and CDSP physically present on sc7280?
>
> Yes, they are present but not used.

So ADSP and CDSP should go into sc7280.dtsi. They will anyway have
status = "disabled";

>
> >
> > I think that your goal should be to:
> > - populate missing device in sc7280.dtsi
> > - maybe add qcm6490.dtsi which defines SoC-level common data (e.g. memory map)
> > - push the rest to board files.
>
> Agree to all of the point.
> We started with the same thought at[3] but it got lost in discussion
> due to its differentiation with mobile counter part(fairphone) which
> follow chrome memory map and hence we came up with qcm6490-iot-common.
> Do you think, qcm6490-iot.dtsi should be good ?

No. DT describes hardware, and -iot is not a hardware abstraction / unification.
If you consider your memory map to be generic for the qcm6490 (and FP5
being the only exception), add it to the qcm6490.dtsi (and let FP5
override it, like some of the phones do). If it can not be considered
generic for the SoC, then you have no other choice than to replicate
it to all board files.

>
> [3]
> https://lore.kernel.org/linux-arm-msm/20231003175456.14774-3-quic_kbajaj@quicinc.com/
>
> -Mukesh
> >
> > I don't think that putting regulators to the common file is a good
> > idea. Platforms will further change and limit voltage limits and
> > modes, so they usually go to the board file.
> >
> >>
> >>
> >> Thanks,
> >> Mukesh
> >>
> >> [1]
> >> https://lore.kernel.org/linux-arm-msm/d97ebf74-ad03-86d6-b826-b57be209b9e2@quicinc.com/
> >>
> >> [2]
> >> commit 90c856602e0346ce9ff234062e86a198d71fa723
> >> Author: Douglas Anderson <dianders@chromium.org>
> >> Date:   Tue Jan 25 14:44:20 2022 -0800
> >>
> >>       arm64: dts: qcom: sc7280: Factor out Chrome common fragment
> >>
> >>       This factors out a device tree fragment from some sc7280 device
> >>       trees. It represents the device tree bits that should be included for
> >>       "Chrome" based sc7280 boards. On these boards the bootloader (Coreboot
> >>       + Depthcharge) configures things slightly different than the
> >>       bootloader that Qualcomm provides. The modem firmware on these boards
> >>       also works differently than on other Qulacomm products and thus the
> >>       reserved memory map needs to be adjusted.
> >>
> >>       NOTES:
> >>       - This is _not_ quite a no-op change. The "herobrine" and "idp"
> >>         fragments here were different and it looks like someone simply
> >>         forgot to update the herobrine version. This updates a few numbers
> >>         to match IDP. This will also cause the `pmk8350_pon` to be disabled
> >>         on idp/crd, which I belive is a correct change.
> >>       - At the moment this assumes LTE skus. Once it's clearer how WiFi SKUs
> >>         will work (how much of the memory map they can reclaim) we may add
> >>         an extra fragment that will rejigger one way or the other.
> >>
> >>       Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>       Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> >>       Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> >>       Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>       Link:
> >> https://lore.kernel.org/r/20220125144316.v2.3.Iac012fa8d727be46448d47027a1813ea716423ce@changeid
> >>
> >>
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry
