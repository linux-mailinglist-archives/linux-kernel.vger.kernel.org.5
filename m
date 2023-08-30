Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E5678DF86
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbjH3TFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244394AbjH3NJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:09:25 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12ED124
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:09:22 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5920efd91c7so61813117b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693400962; x=1694005762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DwGoXvc98B29/NZ2z5FtlBwDc8c/5Vn6sQFUBsFMehM=;
        b=jEmWvMQfYFnlzffDbxw5mXgyneUOyH70keUaWNiIHj4/9Q58xqaMaqHuj8xInc9GT/
         txcoWC41ahEz+MPy7pLi0CoV3OKBMsGxItXcWKHMzDXhCmhk4FHOThVWONJYrADxxa3u
         2VriFRu+2Yd5xs4StT6q7CzF+Wxe+nqaWIPbGL9hRl004uZPBHoM4f9tCoM73869oJNS
         +wmh9dQy0rWd64mvmOUSOWN46YevkHhCD+L46mOMH7DeFDGabY5xGyV8tVeA23IM6vs3
         UTJxmaoowxc2SxCW8nqng78RKBgi7P4IAqK2+W4uUExWA4gj7K+gcIncJqool447XREa
         Vf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400962; x=1694005762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwGoXvc98B29/NZ2z5FtlBwDc8c/5Vn6sQFUBsFMehM=;
        b=SJ4hOZK28lJJw+7Hq6pYkghU0gr+lqDXFUKxKI5uIOYJV1s/4XGLvjFsx+fP/b8N5c
         lRSgb/ZZWFmhua2nIFSHLBjAtCkKkE7e1GRZU09syGlFnsGlsxIjHokeLtoFPyeM7bhD
         VrLJwPFPYAqMEBLB9Ke6v6VqizY4L6KJAY2vDkEX7IizwRwfM5+M/NdzRmfHaqUF+opq
         Z7dM9NAGzs6AjPZLbxvWNiKYij9K1w5Op3sjGCrYDIyYkPhpNxEk0ORH0wZXm6czrFsF
         wFKy1ZgKoOByZMv1l+jh2AoeLqTpuRBHp5Hr8swsxFy1nYg5OGPZR9Y4DTovlExSSHYC
         TL1A==
X-Gm-Message-State: AOJu0YzzS0t8iQNhU85BDRmPBwrLQlb37OBR93+NLGxHZSxrbR+vC3Rz
        FPVC33H1Z+bEdGtVj1LZ5c80xKUH73zvZUw41iigSA==
X-Google-Smtp-Source: AGHT+IGm+kjClWgL76JeczMmO+h3IT4TxeT/7KWlbDA9G2smzM8OdYQu3wjRGDyP5zdSFFunQHUHMzAcTQEhKJc2RH4=
X-Received: by 2002:a25:3201:0:b0:d11:205f:c55 with SMTP id
 y1-20020a253201000000b00d11205f0c55mr2070828yby.4.1693400961971; Wed, 30 Aug
 2023 06:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-7-bartosz.golaszewski@linaro.org> <8b7bada9-3898-1b60-3dea-766a760412f7@linaro.org>
 <CACMJSetObp0k312DmqhTCkw7jsf05OHX1yxbyYj+sVfbtwRcVQ@mail.gmail.com> <86bb50fd-72f3-7c76-c4fe-f8e4765e33d5@linaro.org>
In-Reply-To: <86bb50fd-72f3-7c76-c4fe-f8e4765e33d5@linaro.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Wed, 30 Aug 2023 15:09:10 +0200
Message-ID: <CACMJSes9Lwgh+xSDQo4KQhOHdcLigYgi=scFTeCtiqKFt1QNnw@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 18:47, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/08/2023 15:24, Bartosz Golaszewski wrote:
> >>> +phys_addr_t qcom_shm_bridge_to_phys_addr(void *vaddr)
> >>> +{
> >>> +     struct qcom_shm_bridge_chunk *chunk;
> >>> +     struct qcom_shm_bridge_pool *pool;
> >>> +
> >>> +     guard(spinlock_irqsave)(&qcom_shm_bridge_chunks_lock);
> >>> +
> >>> +     chunk = radix_tree_lookup(&qcom_shm_bridge_chunks,
> >>> +                               (unsigned long)vaddr);
> >>> +     if (!chunk)
> >>> +             return 0;
> >>> +
> >>> +     pool = chunk->parent;
> >>> +
> >>> +     guard(spinlock_irqsave)(&pool->lock);
> >>
> >> Why both locks are spinlocks? The locks are used quite a lot.
> >
> > I'm not sure what to answer. The first one protects the global chunk
> > mapping stored in the radix tree. The second one protects a single
> > memory pool from concurrent access. Both can be modified from any
> > context, hence spinlocks.
>
> Not much PREEMPT friendly, although indeed protected code is small. At
> least here, I did not check other places.
>
> >
> >>
> >>> +
> >>> +     return gen_pool_virt_to_phys(pool->genpool, (unsigned long)vaddr);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(qcom_shm_bridge_to_phys_addr);
> >>> +
> >>> +static int qcom_shm_bridge_probe(struct platform_device *pdev)
> >>> +{
> >>> +     struct qcom_shm_bridge_pool *default_pool;
> >>> +     struct device *dev = &pdev->dev;
> >>> +     int ret;
> >>> +
> >>> +     /*
> >>> +      * We need to wait for the SCM device to be created and bound to the
> >>> +      * SCM driver.
> >>> +      */
> >>> +     if (!qcom_scm_is_available())
> >>> +             return -EPROBE_DEFER;
> >>
> >> I think we miss here (and in all other drivers) device links to qcm.
> >>
> >
> > Well, SCM, once probed, cannot be unbound. What would device links
> > guarantee above that?
>
> Runtime PM, probe ordering (dependencies) detection.
>

Shouldn't we cross that bridge when we get there? SCM has no support
for runtime PM. Probe ordering is quite well handled with a simple
probe deferral. This is also not a parent-child relationship. SHM
Bridge calls into the trustzone using SCM, but SCM is also a user of
SHM Bridge.

> >
> >>> +
> >>> +     ret = qcom_scm_enable_shm_bridge();
> >>> +     if (ret)
> >>> +             return dev_err_probe(dev, ret,
> >>> +                                  "Failed to enable the SHM bridge\n");
> >>> +
> >>> +     default_pool = qcom_shm_bridge_pool_new_for_dev(
> >>> +                             dev, qcom_shm_bridge_default_pool_size);
> >>> +     if (IS_ERR(default_pool))
> >>> +             return dev_err_probe(dev, PTR_ERR(default_pool),
> >>> +                                  "Failed to create the default SHM Bridge pool\n");
> >>> +
> >>> +     WRITE_ONCE(qcom_shm_bridge_default_pool, default_pool);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static const struct of_device_id qcom_shm_bridge_of_match[] = {
> >>> +     { .compatible = "qcom,shm-bridge", },
> >>> +     { }
> >>> +};
> >>> +
> >>> +static struct platform_driver qcom_shm_bridge_driver = {
> >>> +     .driver = {
> >>> +             .name = "qcom-shm-bridge",
> >>> +             .of_match_table = qcom_shm_bridge_of_match,
> >>> +             /*
> >>> +              * Once enabled, the SHM Bridge feature cannot be disabled so
> >>> +              * there's no reason to ever unbind the driver.
> >>> +              */
> >>> +             .suppress_bind_attrs = true,
> >>> +     },
> >>> +     .probe = qcom_shm_bridge_probe,
> >>> +};
> >>> +
> >>> +static int __init qcom_shm_bridge_init(void)
> >>> +{
> >>> +     return platform_driver_register(&qcom_shm_bridge_driver);
> >>> +}
> >>> +subsys_initcall(qcom_shm_bridge_init);
> >>
> >> Why this is part of subsystem? Should be rather device_initcall... or
> >> simply module (and a tristate).
> >>
> >
> > We want it to get up as soon as possible (right after SCM, because SCM
> > is the first user).
>
> Then probably should be populated/spawned by SCM.
>

I really prefer probe deferral over one platform driver creating
platform devices for another. The device is on the DT, let's let OF
populate it as it should.

Bart
