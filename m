Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FAA7C9550
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjJNQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjJNQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:16:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C4AA2;
        Sat, 14 Oct 2023 09:16:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA56AC433C8;
        Sat, 14 Oct 2023 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697300166;
        bh=bloyWWM50cgSdXW/M/ONp1t9BKdvFll8JAVkflss0qk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X1EmAge9ScIen7JtkLBWghNUQoZoy6NrdY9FNXqGPKimSOb8r1kTs7tfdeHZNPfu/
         RNDhoI+VmRsexi0e0SXt+tc9EIjIPw60d/r6XV28LspIuwRUvGBI3kd8QaKzeGm5xO
         hc/5VkpxH39bziNl07SEOdU0vq5RzDq1C+FQf1b2uytuIYtSFAbraSQ6PvaYPMD+Pn
         fDZIA1nVe7FPGRpjsmAY+UsrMBb+u1HJKuhcDz0z/XmCgGRHTvAA2+eIWNZkz3ZVvN
         EKkF8OvaUP1rPC18c8k7C6IkJHXQOQepCuXFEWq/hN9YlRf09M9E5jQs+JwqPpkXfK
         ACSuaD8wHHS9w==
Date:   Sat, 14 Oct 2023 17:16:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: Add PM7325 PMIC7 ADC bindings
Message-ID: <20231014171619.7b7ea921@jic23-huawei>
In-Reply-To: <20231013-fp5-thermals-v1-1-f14df01922e6@fairphone.com>
References: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
        <20231013-fp5-thermals-v1-1-f14df01922e6@fairphone.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 10:09:53 +0200
Luca Weiss <luca.weiss@fairphone.com> wrote:

> Add the defines for the ADC channels found on the PM7325. The list is
> taken from downstream msm-5.4 and adjusted for mainline.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

I assume this will go with the dts changes that use it.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h | 69 +++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h b/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
> new file mode 100644
> index 000000000000..96908014e09e
> --- /dev/null
> +++ b/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020 The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM7325_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_PM7325_H
> +
> +#ifndef PM7325_SID
> +#define PM7325_SID					1
> +#endif
> +
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +
> +/* ADC channels for PM7325_ADC for PMIC7 */
> +#define PM7325_ADC7_REF_GND			(PM7325_SID << 8 | ADC7_REF_GND)
> +#define PM7325_ADC7_1P25VREF			(PM7325_SID << 8 | ADC7_1P25VREF)
> +#define PM7325_ADC7_VREF_VADC			(PM7325_SID << 8 | ADC7_VREF_VADC)
> +#define PM7325_ADC7_DIE_TEMP			(PM7325_SID << 8 | ADC7_DIE_TEMP)
> +
> +#define PM7325_ADC7_AMUX_THM1			(PM7325_SID << 8 | ADC7_AMUX_THM1)
> +#define PM7325_ADC7_AMUX_THM2			(PM7325_SID << 8 | ADC7_AMUX_THM2)
> +#define PM7325_ADC7_AMUX_THM3			(PM7325_SID << 8 | ADC7_AMUX_THM3)
> +#define PM7325_ADC7_AMUX_THM4			(PM7325_SID << 8 | ADC7_AMUX_THM4)
> +#define PM7325_ADC7_AMUX_THM5			(PM7325_SID << 8 | ADC7_AMUX_THM5)
> +#define PM7325_ADC7_GPIO1			(PM7325_SID << 8 | ADC7_GPIO1)
> +#define PM7325_ADC7_GPIO2			(PM7325_SID << 8 | ADC7_GPIO2)
> +#define PM7325_ADC7_GPIO3			(PM7325_SID << 8 | ADC7_GPIO3)
> +#define PM7325_ADC7_GPIO4			(PM7325_SID << 8 | ADC7_GPIO4)
> +
> +/* 30k pull-up1 */
> +#define PM7325_ADC7_AMUX_THM1_30K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM1_30K_PU)
> +#define PM7325_ADC7_AMUX_THM2_30K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM2_30K_PU)
> +#define PM7325_ADC7_AMUX_THM3_30K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM3_30K_PU)
> +#define PM7325_ADC7_AMUX_THM4_30K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM4_30K_PU)
> +#define PM7325_ADC7_AMUX_THM5_30K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM5_30K_PU)
> +#define PM7325_ADC7_GPIO1_30K_PU		(PM7325_SID << 8 | ADC7_GPIO1_30K_PU)
> +#define PM7325_ADC7_GPIO2_30K_PU		(PM7325_SID << 8 | ADC7_GPIO2_30K_PU)
> +#define PM7325_ADC7_GPIO3_30K_PU		(PM7325_SID << 8 | ADC7_GPIO3_30K_PU)
> +#define PM7325_ADC7_GPIO4_30K_PU		(PM7325_SID << 8 | ADC7_GPIO4_30K_PU)
> +
> +/* 100k pull-up2 */
> +#define PM7325_ADC7_AMUX_THM1_100K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM1_100K_PU)
> +#define PM7325_ADC7_AMUX_THM2_100K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM2_100K_PU)
> +#define PM7325_ADC7_AMUX_THM3_100K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM3_100K_PU)
> +#define PM7325_ADC7_AMUX_THM4_100K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM4_100K_PU)
> +#define PM7325_ADC7_AMUX_THM5_100K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM5_100K_PU)
> +#define PM7325_ADC7_GPIO1_100K_PU		(PM7325_SID << 8 | ADC7_GPIO1_100K_PU)
> +#define PM7325_ADC7_GPIO2_100K_PU		(PM7325_SID << 8 | ADC7_GPIO2_100K_PU)
> +#define PM7325_ADC7_GPIO3_100K_PU		(PM7325_SID << 8 | ADC7_GPIO3_100K_PU)
> +#define PM7325_ADC7_GPIO4_100K_PU		(PM7325_SID << 8 | ADC7_GPIO4_100K_PU)
> +
> +/* 400k pull-up3 */
> +#define PM7325_ADC7_AMUX_THM1_400K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM1_400K_PU)
> +#define PM7325_ADC7_AMUX_THM2_400K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM2_400K_PU)
> +#define PM7325_ADC7_AMUX_THM3_400K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM3_400K_PU)
> +#define PM7325_ADC7_AMUX_THM4_400K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM4_400K_PU)
> +#define PM7325_ADC7_AMUX_THM5_400K_PU		(PM7325_SID << 8 | ADC7_AMUX_THM5_400K_PU)
> +#define PM7325_ADC7_GPIO1_400K_PU		(PM7325_SID << 8 | ADC7_GPIO1_400K_PU)
> +#define PM7325_ADC7_GPIO2_400K_PU		(PM7325_SID << 8 | ADC7_GPIO2_400K_PU)
> +#define PM7325_ADC7_GPIO3_400K_PU		(PM7325_SID << 8 | ADC7_GPIO3_400K_PU)
> +#define PM7325_ADC7_GPIO4_400K_PU		(PM7325_SID << 8 | ADC7_GPIO4_400K_PU)
> +
> +/* 1/3 Divider */
> +#define PM7325_ADC7_GPIO4_DIV3			(PM7325_SID << 8 | ADC7_GPIO4_DIV3)
> +
> +#define PM7325_ADC7_VPH_PWR			(PM7325_SID << 8 | ADC7_VPH_PWR)
> +
> +#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM7325_H */
> 

