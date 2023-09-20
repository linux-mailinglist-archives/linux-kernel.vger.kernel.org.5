Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A02E7A89AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjITQnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjITQnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:43:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34CCCA;
        Wed, 20 Sep 2023 09:43:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969C7C433C8;
        Wed, 20 Sep 2023 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695228197;
        bh=yoeBHvv0QH4aSbA/oAFONsW054HHzRA0z4ZaijSOAlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LeV+LG/YDoC0+9+af/1a5Erov8uH1NXbRSMm0skLWpjY60cckKI6qu9LLr423DlEP
         K9uWquTpLB9RWPNiu+PmRd6A6Mb0VKcA915WtUdut1jLLMS/8eyXg829y3P6mcaiC7
         Aehjlj2/Oni844AAV0PBxeDuYsITbYl1HO60wwEDsBmJCQj/+WTO2/oGNgcUhgmxQB
         o81AtA3PFgJ7Byji5HpOfT1Fq00sSA1Gw10TXSdRbDL31DJ8TKge5lhRMjCZzDGEv+
         SfGvgaqrZC+AFTk01bLh1OHeh7WJhcIj9lGQaqkrmm/UE/4KW9fWboFvjzSf6ERia+
         XTrthmm7kDlfg==
Date:   Wed, 20 Sep 2023 09:47:24 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sridharan S N <quic_sridsn@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: ipq9574: add support for the
 RDP417 variant
Message-ID: <zn43mwjxnbpah2xnvsqpvzqthbksgrall7hkoh5ilosu4lmnwp@sf2dw7osdw2x>
References: <20230713152522.1063154-1-quic_sridsn@quicinc.com>
 <20230713152522.1063154-3-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713152522.1063154-3-quic_sridsn@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 08:55:22PM +0530, Sridharan S N wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 417 based on IPQ9574 family of SoC.
> 
> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>

Please spell out your name.

> ---
> changes in v2:
> 	- updated commit message.Moved dependency to change log
> 	  This patch depends on below patchset:
> 	  https://lore.kernel.org/lkml/20230713105909.14209-2-quic_anusha@quicinc.com/

I don't see a new version of this, perhaps I'm just missing it. Please
resubmit this, if it's still relevant.

Regards,
Bjorn

> 	
> 
>  arch/arm64/boot/dts/qcom/Makefile           |  1 +
>  arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 337abc4ceb17..9c30344d08c1 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp417.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp418.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts
> new file mode 100644
> index 000000000000..9a5d4c3db1f2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * IPQ9574 RDP417 board device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq9574-rdp-common.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL01-C1";
> +	compatible = "qcom,ipq9574-ap-al01-c1", "qcom,ipq9574";
> +};
> -- 
> 2.34.1
> 
