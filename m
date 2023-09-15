Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BE17A2093
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjIOONs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjIOONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:13:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7C81FC9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:13:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so25136825e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694787221; x=1695392021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6yZXoqtvOOS4qbu6sLA5FY9z1WwgeTbxy586H6k95M=;
        b=j84yIcWXOdKxU+LkEhNe7oxpoqjXsxtzJT9btQ8+YveAjK327mIwg4VBnGj3Ubq8YQ
         e+IupUeZPcvejcc504qaN2D8KOUMVzuxk9o9aj4dYfbHu86rtg0fh7uYvdp+iulw2iec
         PnURk7w92gv+t9/QEpv56dx0F2FRZgpOQdEj9gZlt/ou9gG6f9EeXdq4Dk78Ng21l1hI
         6ZWq4cAfrAgDyy4C1aIlbCdRTTZd0LF3kbigXBGLRBeoczMs8tsFQwMUC1oc3QyIFWqN
         P3zPsOAiknSqJxRy9zceWqPUZfkrOV1GSxyz2E+Ne1iEt13HSXiVWZswhGzp5nFEPjHc
         mZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694787221; x=1695392021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6yZXoqtvOOS4qbu6sLA5FY9z1WwgeTbxy586H6k95M=;
        b=iKzBdBEEVYtSzD8crs1/6Fswn5xg6ud1TYoN53YKhdijXXsbZ1i+sGKKBTmpCe25/e
         go9kGKmXCnilkNUz7JcryOWI+z9gEL20CmG1JL1gEeMaZSFzhBpIE9DU5fl5vY+fk6eW
         l4Ogmf9uL/KGRVzGU9BrQyy5CeMQ6DXkeA9jPg70rtR2bTFMviXAoQr873RIw1fVohlH
         oWLqrE3NVEgVym0ewskzhmxLXrJ8If6uX2mWOfQ9JBzSWbMLMpqPxJgYAWIv8uAVaiuG
         XyXlNHB4p1FKfBz+6or2mn0n5FvxNU2r4iG2YbmBB6wRtzkhfunZ3wUDuTdLOQZ1k4Ou
         +rxw==
X-Gm-Message-State: AOJu0YyOREb9GrrNa96iJtSbIcM4q4EcDY+NZ1IOzYgbFbUFOv0AVFhz
        OjXhBYmjoyMmLT33k5QQEXB9gQ==
X-Google-Smtp-Source: AGHT+IGNni64BZTGUnXlSAyqxyh5hPWg10T5R2V9mWZY4Z78EANoT4sztE+/HOPhH4TuL8+x2Y8k7A==
X-Received: by 2002:a05:600c:144:b0:401:b504:b6a0 with SMTP id w4-20020a05600c014400b00401b504b6a0mr2000348wmm.3.1694787220735;
        Fri, 15 Sep 2023 07:13:40 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p18-20020a1c7412000000b00401d6c0505csm4711631wmc.47.2023.09.15.07.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:13:40 -0700 (PDT)
Message-ID: <d8d80db6-7010-47c1-a068-f73fbcbc96a0@linaro.org>
Date:   Fri, 15 Sep 2023 15:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 00/20] Venus cleanups
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 16:10, Konrad Dybcio wrote:
> With the driver supporting multiple generations of hardware, some mold
> has definitely grown over the code..
> 
> This series attempts to amend this situation a bit by commonizing some
> code paths and fixing some bugs while at it.
> 
> Only tested on SM8250.
> 
> Definitely needs testing on:
> 
> - SDM845 with old bindings
> - SDM845 with new bindings or 7180
> - MSM8916
> - MSM8996
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (20):
>        media: venus: pm_helpers: Only set rate of the core clock in core_clks_enable
>        media: venus: pm_helpers: Rename core_clks_get to venus_clks_get
>        media: venus: pm_helpers: Add kerneldoc to venus_clks_get()
>        media: venus: core: Set OPP clkname in a common code path
>        media: venus: pm_helpers: Kill dead code
>        media: venus: pm_helpers: Move reset acquisition to common code
>        media: venus: pm_helpers: Use reset_bulk API
>        media: venus: core: Constify all members of the resource struct
>        media: venus: core: Deduplicate OPP genpd names
>        media: venus: core: Get rid of vcodec_num
>        media: venus: core: Drop cache properties in resource struct
>        media: venus: core: Use GENMASK for dma_mask
>        media: venus: core: Remove cp_start
>        media: venus: pm_helpers: Commonize core_power
>        media: venus: pm_helpers: Remove pm_ops->core_put
>        media: venus: core: Define a pointer to core->res
>        media: venus: pm_helpers: Simplify vcodec clock handling
>        media: venus: pm_helpers: Commonize getting clocks and GenPDs
>        media: venus: pm_helpers: Commonize vdec_get()
>        media: venus: pm_helpers: Commonize venc_get()
> 
>   drivers/media/platform/qcom/venus/core.c       | 138 ++++-------
>   drivers/media/platform/qcom/venus/core.h       |  64 +++--
>   drivers/media/platform/qcom/venus/firmware.c   |   3 +-
>   drivers/media/platform/qcom/venus/hfi_venus.c  |   7 +-
>   drivers/media/platform/qcom/venus/pm_helpers.c | 328 +++++++++----------------
>   drivers/media/platform/qcom/venus/pm_helpers.h |  10 +-
>   drivers/media/platform/qcom/venus/vdec.c       |   9 +-
>   drivers/media/platform/qcom/venus/venc.c       |   9 +-
>   8 files changed, 213 insertions(+), 355 deletions(-)
> ---
> base-commit: 7bc675554773f09d88101bf1ccfc8537dc7c0be9
> change-id: 20230911-topic-mars-e60bb2269411
> 
> Best regards,

b4 shazam 20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org
Grabbing thread from 
lore.kernel.org/all/20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 27 messages in the thread
Checking attestation on all messages, may take a moment...
---
   [PATCH 1/20] media: venus: pm_helpers: Only set rate of the core 
clock in core_clks_enable
   [PATCH 2/20] media: venus: pm_helpers: Rename core_clks_get to 
venus_clks_get
   [PATCH 3/20] media: venus: pm_helpers: Add kerneldoc to venus_clks_get()
   [PATCH 4/20] media: venus: core: Set OPP clkname in a common code path
   [PATCH 5/20] media: venus: pm_helpers: Kill dead code
   [PATCH 6/20] media: venus: pm_helpers: Move reset acquisition to 
common code
   [PATCH 7/20] media: venus: pm_helpers: Use reset_bulk API
   [PATCH 8/20] media: venus: core: Constify all members of the resource 
struct
   [PATCH 9/20] media: venus: core: Deduplicate OPP genpd names
   [PATCH 10/20] media: venus: core: Get rid of vcodec_num
   [PATCH 11/20] media: venus: core: Drop cache properties in resource 
struct
   [PATCH 12/20] media: venus: core: Use GENMASK for dma_mask
   [PATCH 13/20] media: venus: core: Remove cp_start
   [PATCH 14/20] media: venus: pm_helpers: Commonize core_power
   [PATCH 15/20] media: venus: pm_helpers: Remove pm_ops->core_put
   [PATCH 16/20] media: venus: core: Define a pointer to core->res
   [PATCH 17/20] media: venus: pm_helpers: Simplify vcodec clock handling
   [PATCH 18/20] media: venus: pm_helpers: Commonize getting clocks and 
GenPDs
   [PATCH 19/20] media: venus: pm_helpers: Commonize vdec_get()
   [PATCH 20/20] media: venus: pm_helpers: Commonize venc_get()
   ---
   ✗ No key: ed25519/konrad.dybcio@linaro.org
   ---
   NOTE: install dkimpy for DKIM signature verification
---
Total patches: 20
---
  Base: base-commit 7bc675554773f09d88101bf1ccfc8537dc7c0be9 not known, 
ignoring
Applying: media: venus: pm_helpers: Only set rate of the core clock in 
core_clks_enable
Applying: media: venus: pm_helpers: Rename core_clks_get to venus_clks_get
Applying: media: venus: pm_helpers: Add kerneldoc to venus_clks_get()
Applying: media: venus: core: Set OPP clkname in a common code path
Applying: media: venus: pm_helpers: Kill dead code
Applying: media: venus: pm_helpers: Move reset acquisition to common code
Applying: media: venus: pm_helpers: Use reset_bulk API
Applying: media: venus: core: Constify all members of the resource struct
Applying: media: venus: core: Deduplicate OPP genpd names
Applying: media: venus: core: Get rid of vcodec_num
Applying: media: venus: core: Drop cache properties in resource struct
Applying: media: venus: core: Use GENMASK for dma_mask
Applying: media: venus: core: Remove cp_start
Applying: media: venus: pm_helpers: Commonize core_power
Applying: media: venus: pm_helpers: Remove pm_ops->core_put
Applying: media: venus: core: Define a pointer to core->res
Applying: media: venus: pm_helpers: Simplify vcodec clock handling
Applying: media: venus: pm_helpers: Commonize getting clocks and GenPDs
Applying: media: venus: pm_helpers: Commonize vdec_get()
Applying: media: venus: pm_helpers: Commonize venc_get()

   MODPOST Module.symvers
^[[BERROR: modpost: "vcodec_clks_get" 
[drivers/media/platform/qcom/venus/venus-dec.ko] undefined!
ERROR: modpost: "vcodec_clks_get" 
[drivers/media/platform/qcom/venus/venus-enc.ko] undefined!
make[3]: *** 
[/home/deckard/Development/qualcomm/qlt-kernel/scripts/Makefile.modpost:145: 
Module.symvers] Error 1
make[2]: *** 
[/home/deckard/Development/qualcomm/qlt-kernel/Makefile:1865: modpost] 
Error 2
make[1]: *** 
[/home/deckard/Development/qualcomm/qlt-kernel/Makefile:234: __sub-make] 
Error 2

---
bod

