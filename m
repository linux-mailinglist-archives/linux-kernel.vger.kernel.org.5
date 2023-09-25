Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B3A7ADD3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjIYQdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjIYQdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:33:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5BDFF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:33:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso35103815e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695659584; x=1696264384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wH2q4NDrTP0nkpBNjIpNRjV2lTawgN/pnwM9yGfrd4c=;
        b=l/uBWKQ4MymajoQwF2vMmr3xfpddhzyesAmLVswoU2/ywPK35T2FByRxE8JEhBeSjt
         peEB5x4NcuQsTc4e638WmUd+/pTcI5FEfsd/EtpyG1pN52Vy4z//p2o+XwaQDHkVp1TQ
         fWN28wlDukLeH30BoYQi3ecTaKGzq1JKUsBx7wFImazLEi5ONkKGK2CobaWELJy2Fdou
         /IuiHJjhDpz87Q0KhnAFP97vKGNYH0dK6T0deXdXNstB/Wdt3Ox0aH7KwISDmwRH2+Jc
         PJY1nTLlEgJtZ3OWa6IUSjcPIKXN8rjBOqxza2ikXsjxD/sy95now7C+NcxDoStF2bnF
         Gzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695659584; x=1696264384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wH2q4NDrTP0nkpBNjIpNRjV2lTawgN/pnwM9yGfrd4c=;
        b=c0FvznMB5wTuEnmOBRbZXrILKRE46Tm2W5Ir50FhfyvDITDsJur4VCUxktNMhSJkZN
         T014EoWf7f5PX7wp8cjmeznpX9drZvPY0FUTjsv8450SmBwW4hqXPzPimOrtU7Ii2McM
         FI0pOIGK/e6hdrpb2vG9X3Ch2NUZbhpCX3et8l/VTg4tDhPk575RSbyXW6HxRjST5pI6
         wAW0tdJ1q75Nt5OMnzNKtlKQ18hRQ9L1FmI1FE2SX+jRhbLsK4L1iAbZkh3nGlG/vxnb
         qzJT/r3QYCBn8K4ik1boafkNuN13Pu7FP10pYLNn4QeW6I/StEq7d29GNTWdYFPiWNSi
         LvNQ==
X-Gm-Message-State: AOJu0YyLlIYMFZ1ml3UU64eAWNNIolZDmCUL3mv4q2l9sq9Ff3B4MJII
        EjwsZ04onyg0RCROTwHWL2fGnQ==
X-Google-Smtp-Source: AGHT+IFpj/H8k5T91oUvMgi2o59IHxklRYgFKjGBIRq5HmF5ufoPZE96JMlpGweodhDYrrMQmOWItQ==
X-Received: by 2002:a05:600c:3658:b0:3f6:9634:c8d6 with SMTP id y24-20020a05600c365800b003f69634c8d6mr6183252wmq.18.1695659584104;
        Mon, 25 Sep 2023 09:33:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c0e1:63ab:648b:6287? ([2a05:6e02:1041:c10:c0e1:63ab:648b:6287])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c300900b003fe407ca05bsm11465024wmh.37.2023.09.25.09.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 09:33:03 -0700 (PDT)
Message-ID: <3c3ffe47-4812-1ef6-216c-6d9a7e57e296@linaro.org>
Date:   Mon, 25 Sep 2023 18:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 5/9] ACPI: thermal: Simplify critical and hot trips
 representation
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <3249479.aeNJFYEL58@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3249479.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 20:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the only piece of information regarding the critical and hot
> trips that needs to be stored in the driver's local data structures is
> whether or not these trips are valid, so drop all of the redundant
> information from there and adjust the code accordingly.
> 
> Among other things, this requires acpi_thermal_add() to be rearranged
> so as to obtain the critical trip temperature before populating the trip
> points table and for symmetry, the hot trip temperature is obtained
> earlier too.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

