Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F47D78ED33
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbjHaMeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjHaMeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:34:20 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F496CDD
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:34:17 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d7820f9449bso555060276.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693485256; x=1694090056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C40f3DUoPo3gJsTKxhxSJrYNVhaMXcBmegCE2EfQH5A=;
        b=dSXwBMO5YtC6q8FeuXteOzHn2MSoycarwDrWgsUtWD4nwtfTJX/wuzlLkaBLRKlrAW
         WbbofUrzSPUFRQrbiMHxS+ERRuVTGpddZv1uXtrt+PX8MCJowcgKma3rIAAbQIy8oS0x
         Q25K7ZTLmiZJYduE6ewDlJJivESY5dsDijHwndI0rpofmLnKhgATo5ortqGZjIHbF8qc
         6ag4cXIFstXHNfFdHcg5yJSZi8FW8oOtjR21Xo6EmsWnSl246xqURn+fDy/fhZZr0xdz
         JB99oL6vNj0PC9V/2F02OFfcY3gQJxwwoUmZdbhYcSzRwmU+pKu/99tlchKb3v1vasim
         eueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693485256; x=1694090056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C40f3DUoPo3gJsTKxhxSJrYNVhaMXcBmegCE2EfQH5A=;
        b=Fpv1vFLTQilplwQ2YLetsgDd4pSKJLOC4jVCnYvRetPe/29ovkM/O8hSbbwxB4XdYB
         lo012lxbGLX5vmc4fMTQXjnw0VMzpLNY9oISProXmMBbrz5w6oj9+sWNFW/aZarpiA3n
         cn9WLWp1SoTh2vwZQjHrgtljT5p0AERZCgwXlSctdxF6zw79jvL2AAJD7u0wtLyCbL3M
         5yHCMDSlnydx2mo0H3naB6pGtPemHX+W9hnQf8SmcF6zm8W0qTM/CHZuwrCgS+aMbRlg
         NGVOiJevHkzSk67yAtJGZXTBhCIJn3Jcpr0SlXtCBj8XXtRrLvw4+SP2l0P8dgLY/5RW
         rWbA==
X-Gm-Message-State: AOJu0Yz8ZsS0RUptiOUoktKQx04qjvHgrUmkEQ81HaWlNqLRYzzFsC1+
        vS+zkNo1tpwSFBECWndBgh/IbZRU0Ybmi+9XItz10A==
X-Google-Smtp-Source: AGHT+IGNzttzOCm+rkPjq+eGj1cyifmZPjni+dDxUsvO/jegctR83ayV/AWgvekHFloDQPa7nhRiUyF46+koWaPL9UM=
X-Received: by 2002:a25:b323:0:b0:d7a:d716:233c with SMTP id
 l35-20020a25b323000000b00d7ad716233cmr5124847ybj.41.1693485256548; Thu, 31
 Aug 2023 05:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
 <20230829135818.2219438-2-quic_ipkumar@quicinc.com> <CAA8EJpqA-poJ9=XKJa2s=yZUGbBbgOqgiDC-q9skJzBqLux84g@mail.gmail.com>
 <73879012-581d-47fb-b741-577c90b31dfb@quicinc.com> <CAA8EJpr3PJtvyYKRPqT=hO4sUd4oOjTvOjD3kOqffbjzHdByAw@mail.gmail.com>
 <4e9a43c5-43ec-4a07-9053-366a517f5c54@quicinc.com>
In-Reply-To: <4e9a43c5-43ec-4a07-9053-366a517f5c54@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 15:34:05 +0300
Message-ID: <CAA8EJpofAM4deqg1H_WSh2uJavTEXQC5x=26P1FLAUgJcT7yOg@mail.gmail.com>
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

On Thu, 31 Aug 2023 at 15:30, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
>
> On 8/31/2023 5:47 PM, Dmitry Baryshkov wrote:
> > On Thu, 31 Aug 2023 at 14:54, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
> >>
> >> On 8/29/2023 7:49 PM, Dmitry Baryshkov wrote:
> >>> On Tue, 29 Aug 2023 at 16:59, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
> >>>> UNIPHY / Combo PHY used on various qualcomm SoC's are very similar to
> >>>> ipq4019 PHY. Hence renaming this dt-binding to uniphy dt-binding and
> >>>> can be used for other qualcomm SoCs which are having similar UNIPHY.
> >>>>
> >>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> >>>> ---
> >>>>    .../phy/{qcom-usb-ipq4019-phy.yaml => qcom,uniphy.yaml}  | 9 +++++++--
> >>>>    1 file changed, 7 insertions(+), 2 deletions(-)
> >>>>    rename Documentation/devicetree/bindings/phy/{qcom-usb-ipq4019-phy.yaml => qcom,uniphy.yaml} (78%)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
> >>>> similarity index 78%
> >>>> rename from Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
> >>>> rename to Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
> >>>> index 09c614952fea..cbe2cc820009 100644
> >>>> --- a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
> >>>> +++ b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
> >>>> @@ -1,13 +1,18 @@
> >>>>    # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>>    %YAML 1.2
> >>>>    ---
> >>>> -$id: http://devicetree.org/schemas/phy/qcom-usb-ipq4019-phy.yaml#
> >>>> +$id: http://devicetree.org/schemas/phy/qcom,uniphy.yaml#
> >>>>    $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>
> >>>> -title: Qualcom IPQ40xx Dakota HS/SS USB PHY
> >>>> +title: Qualcomm UNIPHY
> >>> We know that UNIPHY was a common design / IP block used for APQ8064
> >>> SATA and MSM8974 DSI and HDMI PHYs. Is this the same design, or was
> >>> the name reused by the Qualcomm for some other PHYs?
> >>> Several latest generations have USB QMP PHYs which are called 'uni-phy'.
> >> This PHY is build on top of QCA Uniphy 22ull. A combo PHY used between
> >> USB Gen3 / PCIe Gen3 controller.
> >> It is different from USB QMP PHYs.
> > So we have now three different items called Qualcomm uniphy. Could you
> > please add some distinctive name?
> There is one more target called IPQ5018 which is also having similar USB
> PHY built on top of
> Uniphy 28nm LP. That also can leverage this upcoming IPQ5332 USB PHY
> driver. Considering that,
> given a common name 'uniphy'.

Just to verify, do we mean the same thing, when speaking about the
28nm LP UNIPHY?
I was referencing the apq8064 SATA and msm8974 HDMI / DSI PHYs. See [1] and [2].

[1] https://patchwork.freedesktop.org/patch/544131/?series=118210&rev=2
[2] https://patchwork.freedesktop.org/patch/544125/?series=118210&rev=2

>
> - Praveenkumar
> >
> >> - Praveenkumar
> >>>>    maintainers:
> >>>>      - Robert Marko <robert.marko@sartura.hr>
> >>>> +  - Praveenkumar I <quic_ipkumar@quicinc.com>
> >>>> +
> >>>> +description:
> >>>> +  UNIPHY / COMBO PHY supports physical layer functionality for USB and PCIe on
> >>>> +  Qualcomm chipsets.
> >>>>
> >>>>    properties:
> >>>>      compatible:
> >>>> --
> >>>> 2.34.1
> >>>>
> >
> >



-- 
With best wishes
Dmitry
