Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD87696E9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjGaM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjGaM6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:58:16 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFE5E78;
        Mon, 31 Jul 2023 05:58:12 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0A1F5201B8;
        Mon, 31 Jul 2023 14:58:09 +0200 (CEST)
Date:   Mon, 31 Jul 2023 14:58:08 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     David Wronek <davidwronek@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org
Subject: Re: [PATCH v4 0/7] Add initial support for SM7125 and Xiaomi SM7125
 platform
Message-ID: <kzdqrhzegfvon6o4xzlqrabhrx432qmqv55r5vp6v5cpy7oyip@d5bbegprhnrq>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>, 
        David Wronek <davidwronek@gmail.com>, Andy Gross <agross@kernel.org>, 
        Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
        Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
        Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
        Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
        linux-clk@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
        phone-devel@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
References: <20230723190725.1619193-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723190725.1619193-1-davidwronek@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-23 21:05:01, David Wronek wrote:
> This series introduces support for the Qualcomm SM7125 SoC and the
> Xiaomi SM7125 platform.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
> Changes in v2:
> - Allow qcom,board-id and qcom,msm-id properties
> - Use QCOM_SCM_VMID_MSS_MSA definition
> - Change initial regulator modes from LPM to HPM
> - Move status to the bottom of nodes
> - Fix up PM6150 interrupts
> - Move clk patch to beginning of series
> - Fix up copyright
> - Take ownership of all commits with permission
> - Link to v1: https://lore.kernel.org/all/20230704163848.169853-2-davidwronek@gmail.com/
> 
> Changes in v3:
> - Disable pm6150 rtc by default
> - Fix wrong pm8150l PMIC in joyeuse dts
> - Link to v2: https://lore.kernel.org/all/20230706124339.134272-1-davidwronek@gmail.com/
> 
> Changes in v4:
> - Fix key-vol-down node name
> - Link to v3: https://lore.kernel.org/all/20230715091932.161507-1-davidwronek@gmail.com/
> 
> ---
> David Wronek (7):
>   clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
>   dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
>   dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
>   soc: qcom: socinfo: Add SoC ID for SM7125
>   arm64: dts: qcom: pm6150: Add resin and rtc nodes
>   arm64: dts: qcom: Add SM7125 device tree
>   arm64: dts: qcom: Add support for the Xiaomi SM7125 platform
> 
>  .../devicetree/bindings/arm/qcom.yaml         |   7 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  arch/arm64/boot/dts/qcom/pm6150.dtsi          |  16 +
>  .../boot/dts/qcom/sm7125-xiaomi-joyeuse.dts   |  16 +
>  .../boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi  | 423 ++++++++++++++++++

As brought up on IRC, making it official review by reposting it here on
the lists: Since mi+atoll seems to be a community made-up name, perhaps
this file should just be named sm7125-xiomi-common.dtsi, matching
similar Xiaomi and OnePlus devices with shared DTSI?

Otherwise, just like Sony devices where an official board name _is
known_ the device DTS file should have been named
sm7125-xiaomi-miatoll-joyeuse.dts instead?

- Marijn

>  arch/arm64/boot/dts/qcom/sm7125.dtsi          |  16 +
>  drivers/clk/qcom/gcc-sc7180.c                 |   1 +
>  drivers/soc/qcom/socinfo.c                    |   1 +
>  include/dt-bindings/arm/qcom,ids.h            |   1 +
>  9 files changed, 482 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi
> 
> -- 
> 2.41.0
> 
