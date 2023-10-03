Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576727B6C7E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjJCO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbjJCOzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:55:53 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8AF19AE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:54:55 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59bebd5bdadso12539697b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696344894; x=1696949694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ssiq5+nUb5tk+njmXyusvMPmk3vvCvKa/6ALKcbA4us=;
        b=soM7zb3NrsuXZ8ePr4b8N7VXIOHEjshwQHVckcEX+IIzy0Zxer5OEUACmECvviNzNf
         1qBgtkQmkSQ1hAiC5dpMzMenwtcupQPGywtWU6UbJXlyeOosQ9Bulol/ZeSpHvog77re
         giFarXHIeQObEc7HYto4saN7kRDM0sJyLcBhyUbKX6anI11mgK33fk2WegLj520kFors
         lcIjz8uXj2lyYMoi0JftNyTS/za5FMcJ3YFSBk0stOsBI9umzXTn82/61Ct36IrfBozj
         foSA1osRyZfTKcJudaOP8gFgu6sNG/sYziOeQedzz6BOiwe3rv7HH1Pni9Tphr6H49/c
         OJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344894; x=1696949694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ssiq5+nUb5tk+njmXyusvMPmk3vvCvKa/6ALKcbA4us=;
        b=Zu74fujTZ2e/R9rZ/B69tZrznsvhERUx2gzvKdcgonqeiRXsl2K9XkIyZ5sgZPLbYO
         KSfkYTvIK4n0yVEa9Ya4Oz4hvRAgGF/HqEUJm2hnU1UghNQO3CLodEI47p6M3VnzKkMh
         P7zN8xJySgpe502rLLWi8ytJKPmKK0ocAAzLN0ZVJ/Pm6gOUR4bfl3sKjTrI8ldNUzPg
         +O6D/pHiiODTeJTpNFi3+oKGx3gGh6JWZ/ZYpIwTDch8nqeMaVSWG3s8hb6nUZ6KnN15
         1jAmZisQ8lTULB3kbgpZRpYLSLaBRmjMMNrdxIQPyMwVuAC3zN9/eXZoiin/ujn5zkAe
         d7fg==
X-Gm-Message-State: AOJu0YzQLkG3rr4AQ4q/7DIcwMQ4ipToeH1WOHidT/DbpUd+XBwETJAt
        WHWgdG6Tc45Otxo8nmIKr7WPnzHWyXT+MwmNYSBwng==
X-Google-Smtp-Source: AGHT+IE7Tm0+TOjAqbRf3K+J648pOlmhjcx6LMgVgwylE1FTXpvtTVrh5k3zwCUdGOKzzHN3/AU/Q/UGpVey3g+73X8=
X-Received: by 2002:a81:65d6:0:b0:589:f41c:bc63 with SMTP id
 z205-20020a8165d6000000b00589f41cbc63mr13912123ywb.39.1696344894263; Tue, 03
 Oct 2023 07:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-3-quic_ipkumar@quicinc.com> <412492d1-fcc9-481c-9d28-b208a644ba1d@linaro.org>
 <7975c638-29cf-45ce-9d76-b8a93d750eb7@quicinc.com>
In-Reply-To: <7975c638-29cf-45ce-9d76-b8a93d750eb7@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 3 Oct 2023 17:54:42 +0300
Message-ID: <CAA8EJprhQz_Tj0Bhv6zhGa7h37Ug-Fp6Tof9tNscTFyZzkbJvw@mail.gmail.com>
Subject: Re: [PATCH 2/8] phy: qcom: Introduce Super-Speed USB UNIPHY driver
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
        arnd@arndb.de, neil.armstrong@linaro.org, nfraprado@collabora.com,
        u-kumar1@ti.com, peng.fan@nxp.com, quic_wcheng@quicinc.com,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kathirav@quicinc.com,
        quic_nsekar@quicinc.com, quic_srichara@quicinc.com
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

On Tue, 3 Oct 2023 at 17:22, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
>
>
> On 9/30/2023 10:48 PM, Dmitry Baryshkov wrote:
> > On 29/09/2023 11:42, Praveenkumar I wrote:
> >> Adds Qualcomm 22ull Super-Speed USB UNIPHY driver support which
> >> is present in Qualcomm IPQ5332 SoC. This PHY is interfaced with
> >> SNPS DWC3 USB and SNPS DWC PCIe. Either one of the interface
> >> can use the it and selection is done via mux present in TCSR
> >> register. This driver selects the PHY for DWC3 USB and handles
> >> the reset, clocks and regulator.
> >>
> >> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> >> ---
> >>   drivers/phy/qualcomm/Kconfig               |  11 +
> >>   drivers/phy/qualcomm/Makefile              |   1 +
> >>   drivers/phy/qualcomm/phy-qcom-uniphy-usb.c | 322 +++++++++++++++++++++
> >>   3 files changed, 334 insertions(+)
> >>   create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
> >>
> >> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> >> index d891058b7c39..7257c8455c53 100644
> >> --- a/drivers/phy/qualcomm/Kconfig
> >> +++ b/drivers/phy/qualcomm/Kconfig
> >> @@ -154,6 +154,17 @@ config PHY_QCOM_M31_USB
> >>         management. This driver is required even for peripheral only or
> >>         host only mode configurations.
> >>   +config PHY_QCOM_UNIPHY_USB
> >> +    tristate "Qualcomm USB Super-Speed UNIPHY driver"
> >
> > Can we please have more specific driver name? As I wrote earlier,
> > there are two other (different) kinds of Qualcomm UNI PHY devices:
> > - DSI / HDMI UNIPHY on apq8064 / msm8974 / msm8960 (?)
> > - USB QMP UNI PHY drivers
> >
> > Adding a driver called UNIPHY, which is not related to those two kinds
> > sounds pretty confusing to me.
> This UNIPHY is different from above mentioned ones. This a custom
> version for 22nm on Qualcomm IPQ5332.
> Can we name the driver as phy-qcom-uniphy-usb-ss-22ull.c /
> phy-qcom-usb-ss-22ull.c ?

usb-ss-22ull sounds better. Or maybe usb-ipq-ss

> >
> >> +    depends on USB && (ARCH_QCOM || COMPILE_TEST)
> >> +    select GENERIC_PHY
> >> +    help
> >> +      Enable this to support the Qualcomm USB Super-Speed UNIPHY
> >> transceiver
> >> +      with DWC3 USB core. It handles PHY initialization, clock
> >> +      management required after resetting the hardware and power
> >> +      management. This driver is required even for peripheral only or
> >> +      host only mode configurations.
> >> +
> >>   config PHY_QCOM_USB_HS
> >>       tristate "Qualcomm USB HS PHY module"
> >>       depends on USB_ULPI_BUS
> >> diff --git a/drivers/phy/qualcomm/Makefile
> >> b/drivers/phy/qualcomm/Makefile
> >> index ffd609ac6233..c3e0112a7a70 100644
> >> --- a/drivers/phy/qualcomm/Makefile
> >> +++ b/drivers/phy/qualcomm/Makefile
> >> @@ -17,6 +17,7 @@ obj-$(CONFIG_PHY_QCOM_QMP_USB_LEGACY)    +=
> >> phy-qcom-qmp-usb-legacy.o
> >>   obj-$(CONFIG_PHY_QCOM_QUSB2)        += phy-qcom-qusb2.o
> >>   obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2)    += phy-qcom-snps-eusb2.o
> >>   obj-$(CONFIG_PHY_QCOM_EUSB2_REPEATER)    += phy-qcom-eusb2-repeater.o
> >> +obj-$(CONFIG_PHY_QCOM_UNIPHY_USB)    += phy-qcom-uniphy-usb.o
> >>   obj-$(CONFIG_PHY_QCOM_USB_HS)         += phy-qcom-usb-hs.o
> >>   obj-$(CONFIG_PHY_QCOM_USB_HSIC)     += phy-qcom-usb-hsic.o
> >>   obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)    += phy-qcom-usb-hs-28nm.o
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
> >> b/drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
> >> new file mode 100644
> >> index 000000000000..fdfc9c225995
> >> --- /dev/null
> >> +++ b/drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
> >
> > So, is it a USB PHY or UNI PHY (where I would expect that it handles
> > USB and PCIe?)
> It is a USB PHY and the PHY name is UNIPHY. Added the usb in the file
> name to differentiate it.
> >

-- 
With best wishes
Dmitry
