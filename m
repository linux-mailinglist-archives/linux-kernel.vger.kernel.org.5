Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA81F78C52C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbjH2NZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbjH2NYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:24:37 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EDCCE7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:24:23 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d743a5fe05aso4125631276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693315459; x=1693920259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQGcrjC3KtXL/WdFtDZEft3OUinDXOscuAhMHuzeiG0=;
        b=MRRc3FrpPp6z8OWaDouOk4Mv0t8kEKCeV3hlFg4S1OX8fFXm2Gc2I/gSPjEXpWm+2d
         woaAzzTC2Xz753IcYVfjcMXvwmMg9Duzim6HpodfR3F52c/LJLGlooCeCFoB0t7Fuqrr
         e1Vv0pZK9jvgBRP0kVvQCzIunQ7UVmqvwsR0klCR2iyzjIGd8T8yg7AxJJ1dmk5JyJ0Z
         I6C1HO+Uot+CbNsNFW/wFUjri74/K+Cfojf+aOPBC0Mfiv8L3QigzLC6CCQ/YQoZvV9W
         vn95jm90vQ7GcZUKQ5Z1gO7pA7ZygzmSpWjCukGmfdUKv8DkiePPRVAEJ7JkL3zKcHB7
         IT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693315459; x=1693920259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQGcrjC3KtXL/WdFtDZEft3OUinDXOscuAhMHuzeiG0=;
        b=VAPG7ld0KQtKY16aCIYgFWTU1lBY6DFa50oCGxxny97/RTp6N4I6/0uxRTySPZ4adQ
         BQXGFkBuCfIWqTnfIDsMqO09H9ika34gKRCjxAEB0m6lgFi84MLy3x1Dy9XLy7iQmeTn
         oUdqv+JZUm+piCXtdWztIFAl0dP442uT7Bhx0Em3zbN6N4rktnKAcZIZDZn/sxjZH/AL
         LH+1XaWN3Wy+uoJNz5sMMvCYZTfYGycFMhlFZ2ZJrTDgBMd5PS5CVH+jUrnyXSqhMCIj
         oisfOS0mnptz+cDxZDdL24XTPtj2t83N47i0X+xFn2AfltODUTpwi7fHED+swTLdcXWK
         rVYA==
X-Gm-Message-State: AOJu0Ywe8s9DgBEKWQupBec/qAyZEJotuKXKEuZhwbEAeHt7R0oD2n7x
        PfD4reXrb7E3JZdy7VNxHngXX07f3CJ7VCNlTpxtIQ==
X-Google-Smtp-Source: AGHT+IE8owYc6+9kqyx/gI4M2g1vQve6zIM5p0WJ9SO8njujPD7jZlPj2/YwIdTXyS/qP/5rwINWbpRO+JF/REs12PE=
X-Received: by 2002:a5b:dc3:0:b0:d62:bc43:426e with SMTP id
 t3-20020a5b0dc3000000b00d62bc43426emr27235931ybr.43.1693315458586; Tue, 29
 Aug 2023 06:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-7-bartosz.golaszewski@linaro.org> <8b7bada9-3898-1b60-3dea-766a760412f7@linaro.org>
In-Reply-To: <8b7bada9-3898-1b60-3dea-766a760412f7@linaro.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 29 Aug 2023 15:24:07 +0200
Message-ID: <CACMJSetObp0k312DmqhTCkw7jsf05OHX1yxbyYj+sVfbtwRcVQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] firmware: qcom-shm-bridge: new driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 10:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/08/2023 21:25, Bartosz Golaszewski wrote:
> > This module is a platform driver that also exposes an interface for
> > kernel users to allocate blocks of memory shared with the trustzone.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/firmware/Kconfig                 |   8 +
> >  drivers/firmware/Makefile                |   1 +
> >  drivers/firmware/qcom-shm-bridge.c       | 452 +++++++++++++++++++++++
> >  include/linux/firmware/qcom/shm-bridge.h |  32 ++
> >  4 files changed, 493 insertions(+)
> >  create mode 100644 drivers/firmware/qcom-shm-bridge.c
> >  create mode 100644 include/linux/firmware/qcom/shm-bridge.h
> >
>
> ...
>
> > +/**
> > + * qcom_shm_bridge_to_phys_addr - Translate address from virtual to physical.
> > + *
> > + * @vaddr: Virtual address to translate.
> > + *
> > + * Return:
> > + * Physical address corresponding to 'vaddr'.
> > + */
> > +phys_addr_t qcom_shm_bridge_to_phys_addr(void *vaddr)
> > +{
> > +     struct qcom_shm_bridge_chunk *chunk;
> > +     struct qcom_shm_bridge_pool *pool;
> > +
> > +     guard(spinlock_irqsave)(&qcom_shm_bridge_chunks_lock);
> > +
> > +     chunk = radix_tree_lookup(&qcom_shm_bridge_chunks,
> > +                               (unsigned long)vaddr);
> > +     if (!chunk)
> > +             return 0;
> > +
> > +     pool = chunk->parent;
> > +
> > +     guard(spinlock_irqsave)(&pool->lock);
>
> Why both locks are spinlocks? The locks are used quite a lot.

I'm not sure what to answer. The first one protects the global chunk
mapping stored in the radix tree. The second one protects a single
memory pool from concurrent access. Both can be modified from any
context, hence spinlocks.

>
> > +
> > +     return gen_pool_virt_to_phys(pool->genpool, (unsigned long)vaddr);
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_shm_bridge_to_phys_addr);
> > +
> > +static int qcom_shm_bridge_probe(struct platform_device *pdev)
> > +{
> > +     struct qcom_shm_bridge_pool *default_pool;
> > +     struct device *dev = &pdev->dev;
> > +     int ret;
> > +
> > +     /*
> > +      * We need to wait for the SCM device to be created and bound to the
> > +      * SCM driver.
> > +      */
> > +     if (!qcom_scm_is_available())
> > +             return -EPROBE_DEFER;
>
> I think we miss here (and in all other drivers) device links to qcm.
>

Well, SCM, once probed, cannot be unbound. What would device links
guarantee above that?

> > +
> > +     ret = qcom_scm_enable_shm_bridge();
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                                  "Failed to enable the SHM bridge\n");
> > +
> > +     default_pool = qcom_shm_bridge_pool_new_for_dev(
> > +                             dev, qcom_shm_bridge_default_pool_size);
> > +     if (IS_ERR(default_pool))
> > +             return dev_err_probe(dev, PTR_ERR(default_pool),
> > +                                  "Failed to create the default SHM Bridge pool\n");
> > +
> > +     WRITE_ONCE(qcom_shm_bridge_default_pool, default_pool);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id qcom_shm_bridge_of_match[] = {
> > +     { .compatible = "qcom,shm-bridge", },
> > +     { }
> > +};
> > +
> > +static struct platform_driver qcom_shm_bridge_driver = {
> > +     .driver = {
> > +             .name = "qcom-shm-bridge",
> > +             .of_match_table = qcom_shm_bridge_of_match,
> > +             /*
> > +              * Once enabled, the SHM Bridge feature cannot be disabled so
> > +              * there's no reason to ever unbind the driver.
> > +              */
> > +             .suppress_bind_attrs = true,
> > +     },
> > +     .probe = qcom_shm_bridge_probe,
> > +};
> > +
> > +static int __init qcom_shm_bridge_init(void)
> > +{
> > +     return platform_driver_register(&qcom_shm_bridge_driver);
> > +}
> > +subsys_initcall(qcom_shm_bridge_init);
>
> Why this is part of subsystem? Should be rather device_initcall... or
> simply module (and a tristate).
>

We want it to get up as soon as possible (right after SCM, because SCM
is the first user).

Bartosz

> Best regards,
> Krzysztof
>
