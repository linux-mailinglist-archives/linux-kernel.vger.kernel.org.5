Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE137A2099
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbjIOOPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjIOOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:15:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38521FDE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:15:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-986d8332f50so295314166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694787344; x=1695392144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuUTuDDHcrfwu3tRz2kGluXBFnBmv8teLBXU35uEseA=;
        b=kNCKBGujlE1GsTH31ZaEmBDelabqVFt0D8FxNkg/Kepthtqzjjrt1ITVa5RbwrCQKG
         F8qAoIHwWuCT+6XVuiBbFyHvRSGSsQ2xN+k3ormM8eBFuqZU4kdAVGGuvxsdt8vQ+qbU
         8dM6KVfQsIHbAH/bfMPuVjyxF2omlVNGjVh9rDWbXmMvQ9Pj5FtSKFOOXVs/j/Hkff3o
         1+KlF1su0A7XXmFFboxXhEcjrmdBMMCOSsAQZ+dA7mZ54Rzg7SiCxIXI6QgIAgvsdJwq
         126/1Cq48nnuJlutnI174rheBYI0XUhEdAJIJOcqxEbZiJ1St11Ii55eWZ4dPLHv9LLD
         gdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694787344; x=1695392144;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuUTuDDHcrfwu3tRz2kGluXBFnBmv8teLBXU35uEseA=;
        b=uUi1A5XTkYskq+uByujfbOJ5iSQiDEMpTf2ETVveyT/vCa5XYZVN8XucgnD4q62abD
         neSEByMSoqF+TFf0+XtHigdVT85m8kkPurV8pJ33YYBKp4xOvy/xPkYggry0eAg/9hfk
         +NLF3AVIAvtupSf4rvg3PCRt5QJkIR6dVGPf6aChIhaMGxjP4F6JSV+lE/rONj52kCYW
         K+jaLAzRNViSW9FoqvWa1sdHQpTXSltDoxH0OJAn4NvNz6rFMNi0o/YVyDwAjHiDyt5V
         6n1uO9VS6Px/G3KEo6e8udNTnqj3ARY0AvgRCfshPhCK0R9UtXT0/tHu8uzecQRSiVew
         kqRA==
X-Gm-Message-State: AOJu0YxR4V8YtfJKMfpzWz9XrUpXtKdoXyCMuTAOCiVNTm/6s4GntugY
        XJupBpcl370EEXNNnuV8MO7w+w==
X-Google-Smtp-Source: AGHT+IGcP0Ju/cLhIS2OiIItltvfio0Mm1/fg5b06nhaz9CSS6R2MjdkQoFqTZvECbYQhmrF1+CrSQ==
X-Received: by 2002:a17:906:8a62:b0:9a1:f6e0:12f4 with SMTP id hy2-20020a1709068a6200b009a1f6e012f4mr1426064ejc.15.1694787344108;
        Fri, 15 Sep 2023 07:15:44 -0700 (PDT)
Received: from [192.168.37.232] (178235177024.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.24])
        by smtp.gmail.com with ESMTPSA id z18-20020a1709067e5200b0099d798a6bb5sm2451895ejr.67.2023.09.15.07.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:15:43 -0700 (PDT)
Message-ID: <eff04c4e-a2b1-4664-bec1-cebc367a4ff4@linaro.org>
Date:   Fri, 15 Sep 2023 16:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 00/20] Venus cleanups
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
 <d8d80db6-7010-47c1-a068-f73fbcbc96a0@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <d8d80db6-7010-47c1-a068-f73fbcbc96a0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.2023 16:13, Bryan O'Donoghue wrote:
> On 11/09/2023 16:10, Konrad Dybcio wrote:
>> With the driver supporting multiple generations of hardware, some mold
>> has definitely grown over the code..
>>
>> This series attempts to amend this situation a bit by commonizing some
>> code paths and fixing some bugs while at it.
>>
>> Only tested on SM8250.
>>
>> Definitely needs testing on:
>>
>> - SDM845 with old bindings
>> - SDM845 with new bindings or 7180
>> - MSM8916
>> - MSM8996
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> Konrad Dybcio (20):
>>        media: venus: pm_helpers: Only set rate of the core clock in core_clks_enable
>>        media: venus: pm_helpers: Rename core_clks_get to venus_clks_get
>>        media: venus: pm_helpers: Add kerneldoc to venus_clks_get()
>>        media: venus: core: Set OPP clkname in a common code path
>>        media: venus: pm_helpers: Kill dead code
>>        media: venus: pm_helpers: Move reset acquisition to common code
>>        media: venus: pm_helpers: Use reset_bulk API
>>        media: venus: core: Constify all members of the resource struct
>>        media: venus: core: Deduplicate OPP genpd names
>>        media: venus: core: Get rid of vcodec_num
>>        media: venus: core: Drop cache properties in resource struct
>>        media: venus: core: Use GENMASK for dma_mask
>>        media: venus: core: Remove cp_start
>>        media: venus: pm_helpers: Commonize core_power
>>        media: venus: pm_helpers: Remove pm_ops->core_put
>>        media: venus: core: Define a pointer to core->res
>>        media: venus: pm_helpers: Simplify vcodec clock handling
>>        media: venus: pm_helpers: Commonize getting clocks and GenPDs
>>        media: venus: pm_helpers: Commonize vdec_get()
>>        media: venus: pm_helpers: Commonize venc_get()
>>
>>   drivers/media/platform/qcom/venus/core.c       | 138 ++++-------
>>   drivers/media/platform/qcom/venus/core.h       |  64 +++--
>>   drivers/media/platform/qcom/venus/firmware.c   |   3 +-
>>   drivers/media/platform/qcom/venus/hfi_venus.c  |   7 +-
>>   drivers/media/platform/qcom/venus/pm_helpers.c | 328 +++++++++----------------
>>   drivers/media/platform/qcom/venus/pm_helpers.h |  10 +-
>>   drivers/media/platform/qcom/venus/vdec.c       |   9 +-
>>   drivers/media/platform/qcom/venus/venc.c       |   9 +-
>>   8 files changed, 213 insertions(+), 355 deletions(-)
>> ---
>> base-commit: 7bc675554773f09d88101bf1ccfc8537dc7c0be9
>> change-id: 20230911-topic-mars-e60bb2269411
>>
>> Best regards,
> 
> b4 shazam 20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org
> Grabbing thread from lore.kernel.org/all/20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 27 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   [PATCH 1/20] media: venus: pm_helpers: Only set rate of the core clock in core_clks_enable
>   [PATCH 2/20] media: venus: pm_helpers: Rename core_clks_get to venus_clks_get
>   [PATCH 3/20] media: venus: pm_helpers: Add kerneldoc to venus_clks_get()
>   [PATCH 4/20] media: venus: core: Set OPP clkname in a common code path
>   [PATCH 5/20] media: venus: pm_helpers: Kill dead code
>   [PATCH 6/20] media: venus: pm_helpers: Move reset acquisition to common code
>   [PATCH 7/20] media: venus: pm_helpers: Use reset_bulk API
>   [PATCH 8/20] media: venus: core: Constify all members of the resource struct
>   [PATCH 9/20] media: venus: core: Deduplicate OPP genpd names
>   [PATCH 10/20] media: venus: core: Get rid of vcodec_num
>   [PATCH 11/20] media: venus: core: Drop cache properties in resource struct
>   [PATCH 12/20] media: venus: core: Use GENMASK for dma_mask
>   [PATCH 13/20] media: venus: core: Remove cp_start
>   [PATCH 14/20] media: venus: pm_helpers: Commonize core_power
>   [PATCH 15/20] media: venus: pm_helpers: Remove pm_ops->core_put
>   [PATCH 16/20] media: venus: core: Define a pointer to core->res
>   [PATCH 17/20] media: venus: pm_helpers: Simplify vcodec clock handling
>   [PATCH 18/20] media: venus: pm_helpers: Commonize getting clocks and GenPDs
>   [PATCH 19/20] media: venus: pm_helpers: Commonize vdec_get()
>   [PATCH 20/20] media: venus: pm_helpers: Commonize venc_get()
>   ---
>   ✗ No key: ed25519/konrad.dybcio@linaro.org
>   ---
>   NOTE: install dkimpy for DKIM signature verification
> ---
> Total patches: 20
> ---
>  Base: base-commit 7bc675554773f09d88101bf1ccfc8537dc7c0be9 not known, ignoring
> Applying: media: venus: pm_helpers: Only set rate of the core clock in core_clks_enable
> Applying: media: venus: pm_helpers: Rename core_clks_get to venus_clks_get
> Applying: media: venus: pm_helpers: Add kerneldoc to venus_clks_get()
> Applying: media: venus: core: Set OPP clkname in a common code path
> Applying: media: venus: pm_helpers: Kill dead code
> Applying: media: venus: pm_helpers: Move reset acquisition to common code
> Applying: media: venus: pm_helpers: Use reset_bulk API
> Applying: media: venus: core: Constify all members of the resource struct
> Applying: media: venus: core: Deduplicate OPP genpd names
> Applying: media: venus: core: Get rid of vcodec_num
> Applying: media: venus: core: Drop cache properties in resource struct
> Applying: media: venus: core: Use GENMASK for dma_mask
> Applying: media: venus: core: Remove cp_start
> Applying: media: venus: pm_helpers: Commonize core_power
> Applying: media: venus: pm_helpers: Remove pm_ops->core_put
> Applying: media: venus: core: Define a pointer to core->res
> Applying: media: venus: pm_helpers: Simplify vcodec clock handling
> Applying: media: venus: pm_helpers: Commonize getting clocks and GenPDs
> Applying: media: venus: pm_helpers: Commonize vdec_get()
> Applying: media: venus: pm_helpers: Commonize venc_get()
> 
>   MODPOST Module.symvers
> ^[[BERROR: modpost: "vcodec_clks_get" [drivers/media/platform/qcom/venus/venus-dec.ko] undefined!
> ERROR: modpost: "vcodec_clks_get" [drivers/media/platform/qcom/venus/venus-enc.ko] undefined!
> make[3]: *** [/home/deckard/Development/qualcomm/qlt-kernel/scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[2]: *** [/home/deckard/Development/qualcomm/qlt-kernel/Makefile:1865: modpost] Error 2
> make[1]: *** [/home/deckard/Development/qualcomm/qlt-kernel/Makefile:234: __sub-make] Error 2
Yeah I noticed after sending..

I have some fixups locally, see output of `b4 prep --compare-to v1`:

 1:  ef4effbdd61b =  1:  07193da8f8b2 media: venus: pm_helpers: Only set rate of the core clock in core_clks_enable
 2:  46a6466fff36 =  2:  c8598ffa711a media: venus: pm_helpers: Rename core_clks_get to venus_clks_get
 3:  733411cd167d =  3:  bcc0385fe8a3 media: venus: pm_helpers: Add kerneldoc to venus_clks_get()
 4:  42f089b8ee90 =  4:  181a2a4f7a4b media: venus: core: Set OPP clkname in a common code path
 5:  e0cd37c576cf =  5:  182ba8feb561 media: venus: pm_helpers: Kill dead code
 6:  232c32d813b8 =  6:  06fd32b2f112 media: venus: pm_helpers: Move reset acquisition to common code
 7:  0ab76762c149 =  7:  f0aaaca1fe70 media: venus: pm_helpers: Use reset_bulk API
 8:  e47564b87e77 =  8:  2ddb02b05d0f media: venus: core: Constify all members of the resource struct
 9:  c5e157de604e =  9:  918f3dc5f2f6 media: venus: core: Deduplicate OPP genpd names
10:  3500b515c0cb = 10:  ee194c584ce0 media: venus: core: Get rid of vcodec_num
11:  b179e47b6db6 ! 11:  81fa7517b057 media: venus: core: Drop cache properties in resource struct
    @@ drivers/media/platform/qcom/venus/core.h: struct venus_resources {
        const u32 cp_nonpixel_start;
     
      ## drivers/media/platform/qcom/venus/hfi_venus.c ##
    +@@ drivers/media/platform/qcom/venus/hfi_venus.c: static void venus_process_msg_sys_error(struct venus_hfi_device *hdev,
    + static irqreturn_t venus_isr_thread(struct venus_core *core)
    + {
    +   struct venus_hfi_device *hdev = to_hfi_priv(core);
    +-  const struct venus_resources *res;
    +   void *pkt;
    +   u32 msg_ret;
    + 
    +   if (!hdev)
    +           return IRQ_NONE;
    + 
    +-  res = hdev->core->res;
    +   pkt = hdev->pkt_buf;
    + 
    +-
    +   while (!venus_iface_msgq_read(hdev, pkt)) {
    +           msg_ret = hfi_process_msg_packet(core, pkt);
    +           switch (msg_ret) {
     @@ drivers/media/platform/qcom/venus/hfi_venus.c: static irqreturn_t venus_isr_thread(struct venus_core *core)
                        venus_process_msg_sys_error(hdev, pkt);
                        break;
12:  aa122db08d64 = 12:  8cf3d701f0b4 media: venus: core: Use GENMASK for dma_mask
13:  548235220fcd = 13:  3aa4f40a1818 media: venus: core: Remove cp_start
14:  9fd8a8515795 = 14:  7f65994f7c7c media: venus: pm_helpers: Commonize core_power
15:  09c778667817 = 15:  45c51bcaeb17 media: venus: pm_helpers: Remove pm_ops->core_put
16:  955470ceffa0 = 16:  63aba2146a15 media: venus: core: Define a pointer to core->res
17:  3a6fbeac1f5c = 17:  bafeb6dc5525 media: venus: pm_helpers: Simplify vcodec clock handling
18:  ee1234ce5c19 = 18:  e4500b65ff24 media: venus: pm_helpers: Commonize getting clocks and GenPDs
19:  155ca91c4ece ! 19:  8d86b33d0614 media: venus: pm_helpers: Commonize vdec_get()
    @@ drivers/media/platform/qcom/venus/pm_helpers.c: static int core_clks_set_rate(st
      {
        char buf[13] = { 0 }; /* vcodecX_core\0 */
      
    +@@ drivers/media/platform/qcom/venus/pm_helpers.c: static int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
    + 
    +   return 0;
    + }
    ++EXPORT_SYMBOL_GPL(vcodec_clks_get);
    + 
    + static int vcodec_clks_enable(struct venus_core *core, u8 id)
    + {
     @@ drivers/media/platform/qcom/venus/pm_helpers.c: vcodec_control_v3(struct venus_core *core, u32 session_type, bool enable)
                writel(1, ctrl);
      }


Konrad
