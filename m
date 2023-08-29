Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43678C9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjH2Qrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbjH2Qru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:47:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D2E1B1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:47:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so6009008a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693327662; x=1693932462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CoICQnZ+/1yj9HsG6bu1Mx//y76k4Gd6Az5IWEzBVsk=;
        b=GEMf1a3hbMdzkFCzmgPFzxmDuDy2nBq+Wld2OrIq8yT2i6K6bBpv5XTEFsoJcciz+Q
         xPNhQRY2Sv6QXeTo/TnBbflcISdgsMb+CEGhAC2zJgx1ADDcncM7o74UBLq4QJxQeTWd
         eMEzFa0xOj2l7OvPR2A+3KlzrcOu2LV5qTqCS89y4JIBi2fBumornF6eyQ0klERsmt6e
         8fCo36Tq1m2N3Lq0JsNasrheWt20yG7VHrWLVAA0ERjL0HY2mOapSanDyAkDSLgTHSdg
         q7B69XhmJy6wabwpyNDNi3qnm63ZcC4IvY08xUxlPemjzh6kxW0SAPAwBIv4nBMCW8R3
         nAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693327662; x=1693932462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CoICQnZ+/1yj9HsG6bu1Mx//y76k4Gd6Az5IWEzBVsk=;
        b=QoPekQ5P4AbYaT+a6vHEuwwA5Pp5rjx6nhB7S2rJr2tH2YL4tQuJECqUNGwajcuORb
         69INcy3srBZwpKUvaCRyV2CclJt9y7gddr4dxkvzBwlcPZla34tKKRJHtnjHE8ukRkMp
         T305+4Jm4Fm4ECh9ugEJeSSEcIlCP+gKMxX1j7VhS5kqTTWEE7zwcFhLgRIEpgXZqZjw
         ZCAsj7tk3Zb1MpFbHcOfWDM9P+pJukmk+d/T3hieXVuHJEKfKm2uShBodDxFgKqXeigs
         4Ja/zNwjBzg/Hu8TNSM4C4rDLPUdU4I7cl62Ygve86l6mkljE1OMBFTCM5L7/yghcHFN
         UGWg==
X-Gm-Message-State: AOJu0YxAc9VZI+8dYgsPKK+cVg4YMs9JAGrmL0Y2bWXHPhD8PH9XQ/F3
        nXpY564fOna0cf9FzQkRR5+1CQ==
X-Google-Smtp-Source: AGHT+IEYq4lgF8fnv6SKXO4z5kBvC6yirtahECpFE2Y6m+eLtciH/SLFVGyGqPSQ8n7gRtpWgPXtDg==
X-Received: by 2002:aa7:ccc9:0:b0:51e:362d:b172 with SMTP id y9-20020aa7ccc9000000b0051e362db172mr21105256edt.32.1693327662667;
        Tue, 29 Aug 2023 09:47:42 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b0052228721f84sm5881691eds.77.2023.08.29.09.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:47:42 -0700 (PDT)
Message-ID: <86bb50fd-72f3-7c76-c4fe-f8e4765e33d5@linaro.org>
Date:   Tue, 29 Aug 2023 18:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 06/11] firmware: qcom-shm-bridge: new driver
Content-Language: en-US
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-7-bartosz.golaszewski@linaro.org>
 <8b7bada9-3898-1b60-3dea-766a760412f7@linaro.org>
 <CACMJSetObp0k312DmqhTCkw7jsf05OHX1yxbyYj+sVfbtwRcVQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACMJSetObp0k312DmqhTCkw7jsf05OHX1yxbyYj+sVfbtwRcVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 15:24, Bartosz Golaszewski wrote:
>>> +phys_addr_t qcom_shm_bridge_to_phys_addr(void *vaddr)
>>> +{
>>> +     struct qcom_shm_bridge_chunk *chunk;
>>> +     struct qcom_shm_bridge_pool *pool;
>>> +
>>> +     guard(spinlock_irqsave)(&qcom_shm_bridge_chunks_lock);
>>> +
>>> +     chunk = radix_tree_lookup(&qcom_shm_bridge_chunks,
>>> +                               (unsigned long)vaddr);
>>> +     if (!chunk)
>>> +             return 0;
>>> +
>>> +     pool = chunk->parent;
>>> +
>>> +     guard(spinlock_irqsave)(&pool->lock);
>>
>> Why both locks are spinlocks? The locks are used quite a lot.
> 
> I'm not sure what to answer. The first one protects the global chunk
> mapping stored in the radix tree. The second one protects a single
> memory pool from concurrent access. Both can be modified from any
> context, hence spinlocks.

Not much PREEMPT friendly, although indeed protected code is small. At
least here, I did not check other places.

> 
>>
>>> +
>>> +     return gen_pool_virt_to_phys(pool->genpool, (unsigned long)vaddr);
>>> +}
>>> +EXPORT_SYMBOL_GPL(qcom_shm_bridge_to_phys_addr);
>>> +
>>> +static int qcom_shm_bridge_probe(struct platform_device *pdev)
>>> +{
>>> +     struct qcom_shm_bridge_pool *default_pool;
>>> +     struct device *dev = &pdev->dev;
>>> +     int ret;
>>> +
>>> +     /*
>>> +      * We need to wait for the SCM device to be created and bound to the
>>> +      * SCM driver.
>>> +      */
>>> +     if (!qcom_scm_is_available())
>>> +             return -EPROBE_DEFER;
>>
>> I think we miss here (and in all other drivers) device links to qcm.
>>
> 
> Well, SCM, once probed, cannot be unbound. What would device links
> guarantee above that?

Runtime PM, probe ordering (dependencies) detection.

> 
>>> +
>>> +     ret = qcom_scm_enable_shm_bridge();
>>> +     if (ret)
>>> +             return dev_err_probe(dev, ret,
>>> +                                  "Failed to enable the SHM bridge\n");
>>> +
>>> +     default_pool = qcom_shm_bridge_pool_new_for_dev(
>>> +                             dev, qcom_shm_bridge_default_pool_size);
>>> +     if (IS_ERR(default_pool))
>>> +             return dev_err_probe(dev, PTR_ERR(default_pool),
>>> +                                  "Failed to create the default SHM Bridge pool\n");
>>> +
>>> +     WRITE_ONCE(qcom_shm_bridge_default_pool, default_pool);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct of_device_id qcom_shm_bridge_of_match[] = {
>>> +     { .compatible = "qcom,shm-bridge", },
>>> +     { }
>>> +};
>>> +
>>> +static struct platform_driver qcom_shm_bridge_driver = {
>>> +     .driver = {
>>> +             .name = "qcom-shm-bridge",
>>> +             .of_match_table = qcom_shm_bridge_of_match,
>>> +             /*
>>> +              * Once enabled, the SHM Bridge feature cannot be disabled so
>>> +              * there's no reason to ever unbind the driver.
>>> +              */
>>> +             .suppress_bind_attrs = true,
>>> +     },
>>> +     .probe = qcom_shm_bridge_probe,
>>> +};
>>> +
>>> +static int __init qcom_shm_bridge_init(void)
>>> +{
>>> +     return platform_driver_register(&qcom_shm_bridge_driver);
>>> +}
>>> +subsys_initcall(qcom_shm_bridge_init);
>>
>> Why this is part of subsystem? Should be rather device_initcall... or
>> simply module (and a tristate).
>>
> 
> We want it to get up as soon as possible (right after SCM, because SCM
> is the first user).

Then probably should be populated/spawned by SCM.

Best regards,
Krzysztof

