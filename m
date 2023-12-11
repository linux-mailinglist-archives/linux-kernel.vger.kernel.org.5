Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34B980D459
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbjLKRpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKRpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:45:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241F9D6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:45:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C71C433C8;
        Mon, 11 Dec 2023 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702316756;
        bh=O7wjFCJQlMWHBmegNZT1hxTWnkBth0ZVbCZUnv29/lw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=siz1Izml3pxtqg7z6WiQUs5+dXCMkv1u/VDIhoWyfA4LlmfO8X334fiSq4xlsydzW
         kgmseEhhpvnpyEudgGwmIgDWQRZ5m0i/280tEYjQbGTmV0wAgjlH9GnveMzhhnxen0
         P4gxfzYlUJjbTGVTFB2BM8d2+3uvcQ8uoUsLRCR35eeE7SyZtl3h+4m6ZiFaXv9ZPM
         MYfOIlIznWeUlNcubiLjOgonzXjRhN5h+JS531Tu7mdGHwywfQ+GZ995nwaHNTp7Zf
         Y6jLp2JUq+tu/J/6RI2bNB752rH9PGqSILroGKdZ8q+66GCWDEQ0FhIKD0m10rsgGw
         5ndum0w0LRS+A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c9f099cf3aso71215661fa.1;
        Mon, 11 Dec 2023 09:45:56 -0800 (PST)
X-Gm-Message-State: AOJu0Yxitm9euZwgLpT1HLyi3PkNWQ9wdpreiG53XOmgi5T0r7b2Al4P
        +2LmVhIs2f216C/fCV2A1Vz/Pf/aPl25RIh89w==
X-Google-Smtp-Source: AGHT+IGAdABMDRq4vTTJBpK5U/6vD+zrpbpPPjjj1jukQ1ZAJnbCUkfAC9Da5KG1CLO16tfEBQkodtzt3t8iWp163mg=
X-Received: by 2002:ac2:4d91:0:b0:50b:f87a:66a9 with SMTP id
 g17-20020ac24d91000000b0050bf87a66a9mr2390805lfe.110.1702316754903; Mon, 11
 Dec 2023 09:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20231206-icc-msm8909-v1-0-fe0dd632beff@kernkonzept.com> <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
In-Reply-To: <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Dec 2023 11:45:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL0wxBRE7umsD3CXaskcrK7Pp7y2POaUNWAxGqeSc0tgQ@mail.gmail.com>
Message-ID: <CAL_JsqL0wxBRE7umsD3CXaskcrK7Pp7y2POaUNWAxGqeSc0tgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add MSM8909 interconnect provider driver
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 8:35=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@kernkonzept.com> wrote:
>
> From: Adam Skladowski <a39.skl@gmail.com>
>
> Add driver for interconnect busses found in MSM8909 based platforms.
> The topology consists of three NoCs that are partially controlled by a
> RPM processor.
>
> In the downstream/vendor kernel from Qualcomm there is an additional
> "mm-snoc". However, it doesn't have a separate RPM clock assigned. It
> looks like this is actually the same NoC in hardware and the "mm-snoc"
> was only defined to assign a different "qcom,util-fact". In mainline we
> can represent this by assigning the equivalent "ab_coeff" to all the
> nodes that are part of "mm-snoc" downstream.
>
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> [Stephan: Drop separate mm-snoc that exists downstream since it's
>  actually the same NoC as SNoC in hardware, add qos_offset for BIMC,
>  add ab_coeff for mm-snoc nodes and BIMC]
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>  drivers/interconnect/qcom/Kconfig   |    9 +
>  drivers/interconnect/qcom/Makefile  |    2 +
>  drivers/interconnect/qcom/msm8909.c | 1329 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 1340 insertions(+)
>
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qco=
m/Kconfig
> index 4d15ce2dab16..ad03182b0587 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -8,6 +8,15 @@ config INTERCONNECT_QCOM
>  config INTERCONNECT_QCOM_BCM_VOTER
>         tristate
>
> +config INTERCONNECT_QCOM_MSM8909
> +       tristate "Qualcomm MSM8909 interconnect driver"
> +       depends on INTERCONNECT_QCOM
> +       depends on QCOM_SMD_RPM
> +       select INTERCONNECT_QCOM_SMD_RPM
> +       help
> +         This is a driver for the Qualcomm Network-on-Chip on msm8909-ba=
sed
> +         platforms.
> +
>  config INTERCONNECT_QCOM_MSM8916
>         tristate "Qualcomm MSM8916 interconnect driver"
>         depends on INTERCONNECT_QCOM
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qc=
om/Makefile
> index 3a8a6ef67543..69eaddccd4f1 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM) +=3D interconnect_qcom.o
>
>  interconnect_qcom-y                    :=3D icc-common.o
>  icc-bcm-voter-objs                     :=3D bcm-voter.o
> +qnoc-msm8909-objs                      :=3D msm8909.o
>  qnoc-msm8916-objs                      :=3D msm8916.o
>  qnoc-msm8939-objs                      :=3D msm8939.o
>  qnoc-msm8974-objs                      :=3D msm8974.o
> @@ -35,6 +36,7 @@ qnoc-x1e80100-objs                    :=3D x1e80100.o
>  icc-smd-rpm-objs                       :=3D smd-rpm.o icc-rpm.o icc-rpm-=
clocks.o
>
>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) +=3D icc-bcm-voter.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_MSM8909) +=3D qnoc-msm8909.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) +=3D qnoc-msm8916.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8939) +=3D qnoc-msm8939.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) +=3D qnoc-msm8974.o
> diff --git a/drivers/interconnect/qcom/msm8909.c b/drivers/interconnect/q=
com/msm8909.c
> new file mode 100644
> index 000000000000..81335476aa51
> --- /dev/null
> +++ b/drivers/interconnect/qcom/msm8909.c
> @@ -0,0 +1,1329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/io.h>
> +#include <linux/module.h>

> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>

You probably don't need these 2 headers and the implicit includes it
makes are dropped now in linux-next. Please check what you actually
need and make them explicit.

Rob
