Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B887BC117
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjJFVVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjJFVVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:21:52 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CA3BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:21:50 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a22eaafd72so32202097b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 14:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696627309; x=1697232109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4ChuHX9Ob071qInr4wxaM7NUlx3XF/xti/7NEFhsNI=;
        b=zBiYODHO8iRYAeISS7f26r7ZuBxCdvXPXm+NtRC4ZjVC8nfl9M/NyOV9Lf/GKmCfeD
         ZANbY+EmwqeATqBEjIDiGqh+i7xe00FtJ+QFtf/twI8Qe7B7QP7/OYWaXQJTA6zewrVG
         x86eAhB8mRtDQ5765Dq1fdnconJNOk0nt/JJzgtNkCRVUpQHF+CVPQgq3fLY3b3hMtUn
         01w37Gt2v2sQimteaMEMcv++ATnsC4936fUY/GBpyqbHWK0HRJfbJu5fKLec/hDYQQPo
         ZzXX5KqOEhikY4dz3iPyxUMxblKb6IyKjBCVpNdmGmV9+k8B4hMSUzPPLI4tIiFBZTIG
         Kvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627309; x=1697232109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4ChuHX9Ob071qInr4wxaM7NUlx3XF/xti/7NEFhsNI=;
        b=M65YEr2J63MxwdfkhRWaA6CGrXUNNwQ9e/6ep6RlWO3Avk9gKnnd83I8R6jLy39VyM
         Oo/eAptC2FZ7rJ53X/1N1y61yPaOmfRHVVpvB856UsFr/7A9JnN9hyWf9f8FK1Ufd+dY
         W+lU9/eD0Fq/yQEDDNv5oPu1tnVie2jdI7oh8zpXAZAUyTTkAYr0UCQW7r3xhKQxpfUU
         IhoXGvX5dg6MYitPbnxcI6M7PZ/3MDjiL4e0nx7n7P9vuWJQMp3jopu1NmmU0VN5c7Ge
         tdLLKjjlohCiUMS+2F8FEHCDzYg6mu2ofwxkxpJ0/6EcQlh3JEW8g3u5eFcMI8DFgl/N
         Gs2g==
X-Gm-Message-State: AOJu0YyMawH+aaJn43ox6EjTa7p0AYr+WNf9mgCN6iLb0JMqSXVPX0xV
        +2wZy80sZ5TfQXCGaxqNTig69HJbECYVRyKQn85PTg==
X-Google-Smtp-Source: AGHT+IFu0Uz4vNYYVIAQ7YBqzeP3hYcW1lgde8NHhjHsjXqajig+fqhW8r8e0hxBb0+/iWjuHnkmRklr6+1ndbU3y5c=
X-Received: by 2002:a81:6c13:0:b0:576:93f1:d118 with SMTP id
 h19-20020a816c13000000b0057693f1d118mr9808606ywc.2.1696627309483; Fri, 06 Oct
 2023 14:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-6-quic_devipriy@quicinc.com> <CAA8EJpr+Wwgot-PDRtj-LVi79aD13B9WVREmjTXiR-8XEEx-rQ@mail.gmail.com>
 <652b55cc-87dd-46d1-e480-e25f5f22b8d8@quicinc.com> <a4c9baae-f328-22b5-48d7-fc7df0b62a79@quicinc.com>
 <CAA8EJpq0uawrOBHA8XHygEpGYF--HyxJWxKG44iiFdAZZz7O2w@mail.gmail.com>
 <45f96567-553c-9214-eb7e-c75c6e09d78b@quicinc.com> <65b030c6-6fab-53ea-2774-48698905dd96@quicinc.com>
 <CAA8EJprSw4MGQKh01mZ5x5rBcRpgD7t4ph2617RhpR2Qg5SB=g@mail.gmail.com> <43aee0f9-3a83-3b90-5e3d-13a935f41b47@quicinc.com>
In-Reply-To: <43aee0f9-3a83-3b90-5e3d-13a935f41b47@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 7 Oct 2023 00:21:37 +0300
Message-ID: <CAA8EJppabK8j9T40waMv=t-1aksXfqJibWuS41GhruzLhpatrg@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] clk: qcom: Add NSS clock Controller driver for IPQ9574
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, arnd@arndb.de, geert+renesas@glider.be,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        quic_saahtoma@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 at 12:56, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
>
>
> On 10/5/2023 12:49 PM, Dmitry Baryshkov wrote:
> > On Thu, 5 Oct 2023 at 09:26, Devi Priya <quic_devipriy@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 9/22/2023 5:31 PM, Devi Priya wrote:
> >>>
> >>>
> >>> On 9/20/2023 1:50 PM, Dmitry Baryshkov wrote:
> >>>> On Wed, 20 Sept 2023 at 09:39, Devi Priya <quic_devipriy@quicinc.com>
> >>>> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 9/12/2023 7:38 PM, Devi Priya wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 8/25/2023 5:14 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Fri, 25 Aug 2023 at 12:15, Devi Priya <quic_devipriy@quicinc.com>
> >>>>>>> wrote:
> >>>>>>>>
> >>>>>>>> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574
> >>>>>>>> based
> >>>>>>>> devices.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >>>>>>>> ---
> >>>>>>>>     Changes in V2:
> >>>>>>>>            - Added depends on ARM64 || COMPILE_TEST in Kconfig
> >>>>>>>>            - Added module_platform_driver
> >>>>>>>>            - Dropped patch [2/6] - clk: qcom: gcc-ipq9574: Mark nssnoc
> >>>>>>>> clocks as critical
> >>>>>>>>               & added pm_clk for nssnoc clocks
> >>>>>>>>            - Updated the uniphy clock names
> >>>>>>>>
> >>>>>>>>     drivers/clk/qcom/Kconfig         |    7 +
> >>>>>>>>     drivers/clk/qcom/Makefile        |    1 +
> >>>>>>>>     drivers/clk/qcom/nsscc-ipq9574.c | 3109
> >>>>>>>> ++++++++++++++++++++++++++++++
> >>>>>>>>     3 files changed, 3117 insertions(+)
> >>>>>>>>     create mode 100644 drivers/clk/qcom/nsscc-ipq9574.c
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> >>>>>>>> index bd9bfb11b328..3ecc11e2c8e3 100644
> >>>>>>>> --- a/drivers/clk/qcom/Kconfig
> >>>>>>>> +++ b/drivers/clk/qcom/Kconfig
> >>>>>>>> @@ -203,6 +203,13 @@ config IPQ_GCC_9574
> >>>>>>>>              i2c, USB, SD/eMMC, etc. Select this for the root clock
> >>>>>>>>              of ipq9574.
> >>>>>>>>
> >>>>>>>> +config IPQ_NSSCC_9574
> >>>>>>>> +       tristate "IPQ9574 NSS Clock Controller"
> >>>>>>>> +       depends on ARM64 || COMPILE_TEST
> >>>>>>>> +       depends on IPQ_GCC_9574
> >>>>>>>> +       help
> >>>>>>>> +         Support for NSS clock controller on ipq9574 devices.
> >>>>>>>> +
> >>>>>>>>     config MSM_GCC_8660
> >>>>>>>>            tristate "MSM8660 Global Clock Controller"
> >>>>>>>>            depends on ARM || COMPILE_TEST
> >>>>>>>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> >>>>>>>> index 4790c8cca426..3f084928962e 100644
> >>>>>>>> --- a/drivers/clk/qcom/Makefile
> >>>>>>>> +++ b/drivers/clk/qcom/Makefile
> >>>>>>>> @@ -30,6 +30,7 @@ obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
> >>>>>>>>     obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
> >>>>>>>>     obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
> >>>>>>>>     obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
> >>>>>>>> +obj-$(CONFIG_IPQ_NSSCC_9574)   += nsscc-ipq9574.o
> >>>>>>>>     obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
> >>>>>>>>     obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
> >>>>>>>>     obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
> >>>>>>>> diff --git a/drivers/clk/qcom/nsscc-ipq9574.c
> >>>>>>>> b/drivers/clk/qcom/nsscc-ipq9574.c
> >>>>>>>> new file mode 100644
> >>>>>>>> index 000000000000..65bdb449ae5f
> >>>>>>>> --- /dev/null
> >>>>>>>> +++ b/drivers/clk/qcom/nsscc-ipq9574.c
> >>>>>>>> @@ -0,0 +1,3109 @@
> >>>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>>>>> +/*
> >>>>>>>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> >>>>>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights
> >>>>>>>> reserved.
> >>>>>>>> + */
> >>>>>>>> +
> >>>>>>>> +#include <linux/clk-provider.h>
> >>>>>>>> +#include <linux/err.h>
> >>>>>>>> +#include <linux/kernel.h>
> >>>>>>>> +#include <linux/module.h>
> >>>>>>>> +#include <linux/of.h>
> >>>>>>>> +#include <linux/of_device.h>
> >>>>>>>> +#include <linux/regmap.h>
> >>>>>>>> +#include <linux/pm_clock.h>
> >>>>>>>> +#include <linux/pm_runtime.h>
> >>>>>>>> +
> >>>>>>>> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
> >>>>>>>> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
> >>>>>>>> +
> >>>>>>>> +#include "clk-alpha-pll.h"
> >>>>>>>> +#include "clk-branch.h"
> >>>>>>>> +#include "clk-pll.h"
> >>>>>>>> +#include "clk-rcg.h"
> >>>>>>>> +#include "clk-regmap.h"
> >>>>>>>> +#include "clk-regmap-divider.h"
> >>>>>>>> +#include "clk-regmap-mux.h"
> >>>>>>>> +#include "common.h"
> >>>>>>>> +#include "reset.h"
> >>>>>>>> +
> >>>>>>>> +/* Need to match the order of clocks in DT binding */
> >>>>>>>> +enum {
> >>>>>>>> +       DT_NSSNOC_NSSCC_CLK,
> >>>>>>>> +       DT_NSSNOC_SNOC_CLK,
> >>>>>>>> +       DT_NSSNOC_SNOC_1_CLK,
> >>>>>>>
> >>>>>>> Not using the index makes it seem that these clocks are not used,
> >>>>>>> until one scrolls down to pm_clks.
> >>>>>> Okay, got it
> >>>>>>>
> >>>>>>> BTW: The NSSNOC_SNOC clocks make it look like there is an interconnect
> >>>>>>> here (not a simple NIU).
> >>>>>>
> >>>>>> Hi Dmitry, We are exploring on the ICC driver. In the meantime to
> >>>>>> unblock PCIe/NSS changes getting merged, shall we use
> >>>>>> regmap_update_bits
> >>>>>> and turn on the critical NSSNOC clocks, ANOC & SNOC pcie clocks in the
> >>>>>> probe function of the gcc driver itself as like sm8550 driver to get
> >>>>>> the
> >>>>>> changes merged?
> >>>>>>
> >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/qcom/gcc-sm8550.c#n3347
> >>>>>
> >>>>> Hi Dmitry,
> >>>>> Just curious to know if we could send out the next series with the
> >>>>> proposed approach if that holds good.
> >>>>
> >>>> The answer really depends on the structure of your hardware. The issue
> >>>> is that once you commit the device bindings,you have to support them
> >>>> forever. So, if you commit the NSS clock support without interconnects
> >>>> in place, you have to keep this ANOC/SNOC/etc code forever, even after
> >>>> you land the interconnect. So I'd suggest landing the icc driver first
> >>>> (or at least implementing and sending to the mailing list), so that we
> >>>> can see how all these pieces fit together.
> >>>
> >>> Hi Dmitry,
> >>> Unlike MSM chipsets, IPQ chipsets does not have any use case wherein the
> >>> NOC clocks have to be scaled. So if these clocks can be enabled in the
> >>> probe, there is no need for an interconnect driver at all. The same
> >>> applies to both ipq9574 and ipq5332 SoCs.
> >>>
> >>
> >> Hi Dmitry,
> >> Just curious to know if we can go ahead with the proposed solution of
> >> enabling the NOC clocks in the probe as these clocks need not be scaled
> >> in IPQ chipsets & hence there would be no need for an ICC driver in
> >> ipq9574 & ipq5332 targets.
> >
> > In the probe of which driver?
> GCC driver of ipq9574 & ipq5332 targets.

Would you need to handle these clocks additionally in the
suspend/resume path? Will this increase the power consumption of the
board?

Generally, I'd say this looks like a bad idea. Consider all the
troubles we are undergoing now while sorting out the NIU clocks on RPM
and RPMH platforms.
So, unless you are 100% sure that this is a permanent solution (like
AHB clocks being always on), I'd kindly suggest implementing the NoC
attachment properly. In the end, other Qualcomm platforms use ICC
drivers, so by following this pattern we will have more common code
paths.

-- 
With best wishes
Dmitry
