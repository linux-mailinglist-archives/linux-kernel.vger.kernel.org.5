Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC97F28E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjKUJ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjKUJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:26:43 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307FE1737
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:26:03 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5c9cdc78c37so19760147b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700558762; x=1701163562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aAmGxGkbN4emVuxJ9V8j1fYzlqaJg99Z9eieGlDghe8=;
        b=BfDyY4/EyX2h1Puuik3SLhv79IUgQYhpzy+txcVo8lSmuthjjhNs/5rvPIi0vSlUL5
         fFEp++QTUmv0yRG+ZFXJTFBuFs9Yhm3rdrbTSzxFwkC9/K2I5IUPLCizPJS6Rue3UhQM
         ZEatsbxch23cRmmEGmTRZAVxRz/1rfknu/saumvYHSgLcDntlUZPs/XmvpCIFCE/mLA4
         pcQOVZYCXUNaXXrzINTGZ88qD5hEpI5qPSYa9A7MErbhyjKc+kH9Vucg0A6ByWDUAbYe
         QY0YhFIMmsYHH+Zt+FKkikDX8Ai4IMVYDSybunfvCqQpx17wdj8ViDScTvK6Owco7890
         Im6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700558762; x=1701163562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAmGxGkbN4emVuxJ9V8j1fYzlqaJg99Z9eieGlDghe8=;
        b=lpTngpsLhEgVIuyU3eEFbwSanw4RmyWdN2fVXxmxmTlouLBoq/b5wlSztDGfftxr+o
         ggX7LdUBQOTPYUOmQGIhOl25fnuet1n1og47r4hlO65TmyJJi0ELWMPzdexG6MSwZbr+
         NFT76WPAolSOJVuiZIzyxWQ40mqa2SFXbIlBdZ1h/j5WmwOpbbDyKMAugJ2KUN5DOf0V
         tdK5KAmPqJPLPih/LLbYxJ4iCeaWecvIux+cTooIEvWdBedAesPtPlcGl3xHWb9UrlkK
         aivQpTkvFvOxzCflBcCLhXbGM9hOupCO6YH7KMAc0fRCshMpyYTd1febSp5IhAjzC+4K
         CoCQ==
X-Gm-Message-State: AOJu0YzDcLmtjQ4mnir3y6CcOz7+Z0FHS9LeDIY/2oRgTdw3vc00KJkp
        xQlxMGBJff9iVO/V6Wm6/7TvMCGpg3hx/0M7LPdkRA==
X-Google-Smtp-Source: AGHT+IGDpZOujTVErxg8YRP1eiMChk1yVTqch6viH8ATBRlzMnxRNt6WwTrGQpK1/d7L0Ilf7fXU1J53n5NPS6xRjqo=
X-Received: by 2002:a81:5fc2:0:b0:5c6:9488:4c99 with SMTP id
 t185-20020a815fc2000000b005c694884c99mr8361218ywb.18.1700558762286; Tue, 21
 Nov 2023 01:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20231120132118.30473-1-brgl@bgdev.pl> <20231120132118.30473-3-brgl@bgdev.pl>
 <6e189833-b76b-030f-482e-d13e0d6d131a@quicinc.com>
In-Reply-To: <6e189833-b76b-030f-482e-d13e0d6d131a@quicinc.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 21 Nov 2023 10:25:51 +0100
Message-ID: <CACMJSesJhkmLdoS0F3t+B-WMXRky0mHp=_2ho_Lb_GvfdJ7y9g@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 02/12] firmware: qcom: scm: enable the TZ mem allocator
To:     Prasad Sodagudi <quic_psodagud@quicinc.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com
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

On Tue, 21 Nov 2023 at 07:35, Prasad Sodagudi <quic_psodagud@quicinc.com> wrote:
>
>
> On 11/20/2023 5:21 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Select the TrustZone memory allocator in Kconfig and create a pool of
> > memory shareable with the TrustZone when probing the SCM driver.
> >
> > This will allow a gradual conversion of all relevant SCM calls to using
> > the dedicated allocator.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> > ---
> >   drivers/firmware/qcom/Kconfig    |  1 +
> >   drivers/firmware/qcom/qcom_scm.c | 16 ++++++++++++++++
> >   2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> > index b80269a28224..237da40de832 100644
> > --- a/drivers/firmware/qcom/Kconfig
> > +++ b/drivers/firmware/qcom/Kconfig
> > @@ -7,6 +7,7 @@
> >   menu "Qualcomm firmware drivers"
> >
> >   config QCOM_SCM
> > +     select QCOM_TZMEM
> >       tristate
> >
> >   config QCOM_TZMEM
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 520de9b5633a..0d4c028be0c1 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -8,8 +8,10 @@
> >   #include <linux/completion.h>
> >   #include <linux/cpumask.h>
> >   #include <linux/dma-mapping.h>
> > +#include <linux/err.h>
> >   #include <linux/export.h>
> >   #include <linux/firmware/qcom/qcom_scm.h>
> > +#include <linux/firmware/qcom/qcom_tzmem.h>
> >   #include <linux/init.h>
> >   #include <linux/interconnect.h>
> >   #include <linux/interrupt.h>
> > @@ -20,9 +22,11 @@
> >   #include <linux/of_platform.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/reset-controller.h>
> > +#include <linux/sizes.h>
> >   #include <linux/types.h>
> >
> >   #include "qcom_scm.h"
> > +#include "qcom_tzmem.h"
> >
> >   static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
> >   module_param(download_mode, bool, 0);
> > @@ -41,6 +45,8 @@ struct qcom_scm {
> >       int scm_vote_count;
> >
> >       u64 dload_mode_addr;
> > +
> > +     struct qcom_tzmem_pool *mempool;
> >   };
> >
> >   struct qcom_scm_current_perm_info {
> > @@ -1887,6 +1893,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
> >       if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
> >               qcom_scm_disable_sdi();
> >
> > +     ret = qcom_tzmem_enable(__scm->dev);
> > +     if (ret)
> > +             return dev_err_probe(__scm->dev, ret,
> > +                                  "Failed to enable the TrustZone memory allocator\n");
>
> Based on my knowledge shmbridge is supported from sm8250 SoC in the
> firmware.
>
> sdm845 and couple of other targets may not have support shmbridge
> support and probe will be fail for these targets right?
>

We check the availability of the SHM Bridge calls on the platform at
run-time before enabling it. We'll simply fall-back to not using SHM
bridge in this case.

Bart

> > +
> > +     __scm->mempool = devm_qcom_tzmem_pool_new(__scm->dev, SZ_256K);
> > +     if (IS_ERR(__scm->mempool))
> > +             return dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
> > +                                  "Failed to create the SCM memory pool\n");
> > +
> >       /*
> >        * Initialize the QSEECOM interface.
> >        *
