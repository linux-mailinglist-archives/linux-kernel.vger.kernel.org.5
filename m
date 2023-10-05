Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5097B9FBF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjJEO3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjJEO1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:27:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF9A240;
        Thu,  5 Oct 2023 02:12:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4064867903cso6733395e9.2;
        Thu, 05 Oct 2023 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696497153; x=1697101953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP0pc042qUQSPL3OpD/4Lvbv3aJsdJMyDgYbeSgql4g=;
        b=PIKYQ7j8I8L02UF+zKyqsExalrJ7G4GU4SvbFNrm1XgbGwbRxoIQvb+eQtNg1se5O2
         R/+eINnz+mvNQQVHN467Kw0rL0d/FL183O/epVQ3Ea5AiIG6Q1rgKjGuj/v+cIHYMVHz
         Jm36Yzn9KbAYP+OvwSMC6T+almAs2KCWMLphT+w4b/6HSyDG6QYp6w2JuFwHSLkkCTZo
         Ek5RAdMjlXHztr6G1BtQrdIH7GGAB/AIO/uheIXX3l20r6tHs20mfdO0QygfU/blUPlh
         XJlME4f0JJlhlMd++KJnDZk0SJjSKud5RGnKNBQhk898qhGX16adiaBR5/E6tqrWy0Rg
         34aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696497153; x=1697101953;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KP0pc042qUQSPL3OpD/4Lvbv3aJsdJMyDgYbeSgql4g=;
        b=lt3RJPiXH6LJmc/kphgfkh5whbRs6XWndc/NG6aImkp1PJej0onfOqsv+1GLN1OESe
         JVkhV0ZtK7D9tkD9X08Fs1pZiVzPbIjeikVTu1M1N8rj2mRiKOr7sb00AaE7N7sS+IYr
         pgAKQVLkbJIFbJFtkYENqce0Fa33O9Tnw7f0E0o+/BP9J6Rj9dgh+kl8dDxu9GBlFJZQ
         Ib3V4zfpJdYhGBAPjBaBk4yPBudDHFYBlYdoG+q7pyNnVyEkv4znTHaCw5ploXiZOgmV
         zmH9388lmCfdxfM8UHQR4GE9z/MWAQqy3xx5PAUnz5MyDzRDej5qRfX6Kqd7aqdUIAdt
         6H0A==
X-Gm-Message-State: AOJu0Yz4MZ7JqsUcXbY+vh0+DZti6lV1lanAFImzxYrC5743UIprO2Pn
        bFeBNEUT3GPDgrfF3R+RL54=
X-Google-Smtp-Source: AGHT+IH2W7hDeL1wkq3JWgO81DAp+hriGDli4ACMJ99sLnJI/m466JSxws9TxT8fh61MWmyN1ZwKYg==
X-Received: by 2002:adf:eac3:0:b0:322:dbc6:8cf7 with SMTP id o3-20020adfeac3000000b00322dbc68cf7mr4361473wrn.16.1696497153115;
        Thu, 05 Oct 2023 02:12:33 -0700 (PDT)
Received: from [10.126.144.131] (ufr-132-230-194-172.eduroam-nat.uni-freiburg.de. [132.230.194.172])
        by smtp.gmail.com with ESMTPSA id d7-20020adfe887000000b00326dd5486dcsm1302013wrm.107.2023.10.05.02.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 02:12:32 -0700 (PDT)
Message-ID: <ab49da90-d1bf-88d7-9fa2-c8c8882e23b6@gmail.com>
Date:   Thu, 5 Oct 2023 11:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 11/11] firmware: qcom: scm: enable SHM bridge
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230928092040.9420-1-brgl@bgdev.pl>
 <20230928092040.9420-12-brgl@bgdev.pl>
 <4ab66f17-4686-411f-b829-74eab3489568@gmail.com>
 <CAMRc=MebkzaLUtTn20V9f0FU1PbGrUGSHAJR+j3nVpc6wdJnsQ@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAMRc=MebkzaLUtTn20V9f0FU1PbGrUGSHAJR+j3nVpc6wdJnsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05/10/2023 um 09:12 schrieb Bartosz Golaszewski:
> On Thu, Oct 5, 2023 at 12:24 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> On 9/28/23 11:20, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Extens the SCM memory allocator with using the SHM Bridge feature if
>>> available on the platform. This makes the trustzone only use dedicated
>>> buffers for SCM calls. We map the entire SCM genpool as a bridge.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> This patch breaks something in early boot on my Surface Pro X (sc8180x).
>> Unfortunately I can't provide many details at the moment because the
>> only thing I can see are RCU stalls, and the traces from them are quite
>> useless.
>>
>> Without this patch, the rest of the series (with the fix you posted on
>> patch 6 applied) seems to work fine. Including both RFT qseecom patches.
>>
>> I plan to have a closer look at this once I have some more time though.
>>
> 
> Can it be the PAS image loading? This is something Andrew reported and
> I have it fixed for v3.

That is my current suspicion, but I haven't had the time to properly
check it yet.

Regards,
Max

> Bart
> 
>> Regards,
>> Max
>>
>>> ---
>>>    drivers/firmware/qcom/qcom_scm-mem.c | 42 ++++++++++++++++++++++++++--
>>>    1 file changed, 39 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/firmware/qcom/qcom_scm-mem.c b/drivers/firmware/qcom/qcom_scm-mem.c
>>> index eafecbe23770..12b12b15f46f 100644
>>> --- a/drivers/firmware/qcom/qcom_scm-mem.c
>>> +++ b/drivers/firmware/qcom/qcom_scm-mem.c
>>> @@ -16,6 +16,8 @@
>>>
>>>    #include "qcom_scm.h"
>>>
>>> +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
>>> +
>>>    static size_t qcom_scm_mem_pool_size = SZ_2M;
>>>    module_param_named(qcom_scm_mem_pool_size, qcom_scm_mem_pool_size,
>>>                   ulong, 0400);
>>> @@ -108,8 +110,24 @@ phys_addr_t qcom_scm_mem_to_phys(void *vaddr)
>>>        return chunk->paddr;
>>>    }
>>>
>>> +static int qcom_scm_mem_shm_bridge_create(void)
>>> +{
>>> +     uint64_t pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms;
>>> +
>>> +     ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
>>> +     pfn_and_ns_perm = (u64)qcom_scm_mem.pbase | ns_perms;
>>> +     ipfn_and_s_perm = (u64)qcom_scm_mem.pbase | ns_perms;
>>> +     size_and_flags = qcom_scm_mem.size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
>>> +
>>> +     return qcom_scm_create_shm_bridge(qcom_scm_mem.dev, pfn_and_ns_perm,
>>> +                                       ipfn_and_s_perm, size_and_flags,
>>> +                                       QCOM_SCM_VMID_HLOS);
>>> +}
>>> +
>>>    int qcom_scm_mem_enable(struct device *dev)
>>>    {
>>> +     int ret;
>>> +
>>>        INIT_RADIX_TREE(&qcom_scm_mem.chunks, GFP_ATOMIC);
>>>        spin_lock_init(&qcom_scm_mem.lock);
>>>        qcom_scm_mem.dev = dev;
>>> @@ -128,7 +146,25 @@ int qcom_scm_mem_enable(struct device *dev)
>>>
>>>        gen_pool_set_algo(qcom_scm_mem.pool, gen_pool_best_fit, NULL);
>>>
>>> -     return gen_pool_add_virt(qcom_scm_mem.pool,
>>> -                              (unsigned long)qcom_scm_mem.vbase,
>>> -                              qcom_scm_mem.pbase, qcom_scm_mem.size, -1);
>>> +     ret = gen_pool_add_virt(qcom_scm_mem.pool,
>>> +                             (unsigned long)qcom_scm_mem.vbase,
>>> +                             qcom_scm_mem.pbase, qcom_scm_mem.size, -1);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = qcom_scm_enable_shm_bridge();
>>> +     if (ret) {
>>> +             if (ret == EOPNOTSUPP)
>>> +                     dev_info(dev, "SHM Bridge not supported\n");
>>> +             else
>>> +                     return ret;
>>> +     } else {
>>> +             ret = qcom_scm_mem_shm_bridge_create();
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             dev_info(dev, "SHM Bridge enabled\n");
>>> +     }
>>> +
>>> +     return 0;
>>>    }
