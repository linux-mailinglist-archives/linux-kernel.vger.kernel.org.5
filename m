Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02347670EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjG1Pri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjG1Prg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:47:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EF32682
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:47:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso24149935e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690559254; x=1691164054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vniulgCtDIdUIvnIccMpgA9x3SypggA9fCUj3ZHUHOM=;
        b=b+kdZ7Wt8Lqy6q7t5MyFibzfmHYKudxurnjLWpoxocflQ2wRjYFiW4Kb9zP0b3dfnt
         BPIHboWdbm1dMHOt7kRRuGbSiPm1YBQmSLuxMdsFpAjezkQaxwmiuazSzcV+apIN3gzx
         RJfVCG1UCcr6OYu5VX5m2B+LKdkBE+jHlY6y3eTLBDnyQic3lUIthQCwqbPpTB9+vV4J
         /iuHQ7vmPfnNDg6u0rFcctoOefoxIpv+datbexus1XoZzEd4kqR48spUiElhjGdNuVCp
         dMNvS0v8yZdQYlT3qpGGNrtbraWUBdyDiSWXv72FbuFRiEBVkdca1E6rQ5PPhHjq7Ylg
         o5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559254; x=1691164054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vniulgCtDIdUIvnIccMpgA9x3SypggA9fCUj3ZHUHOM=;
        b=k2R8yNtikDMKxGJvD/4R2/NDt7QRDP+haPQrmIav7INymb/4zjmAwJpsknYQNeNnCk
         r0oc5pXCuKvIOhix395Pf/IIXf/RnqX0l4ur5SGhGkxsTtVFaevOdxxqDNyWkTiWNjZ2
         FoIJD7IbxHt8tkXSWK0w+b9DVsfub7sJTXe63Hs2uK9Lrz1PPfaDuiabdakj/GpmlIGZ
         uUqS8xI2wkplihzYVQUrBfLzGTcVw+dqGhzENg4zcvlhdILqXFByzuLBDlH7jVvLPkHI
         KkL6JA2x1Pqpk2nMzZ2PIoDbBzqHsVZxeoNfVGR01i1gjlkINyqmxSHjx9hJ9BQJyDeY
         ItYQ==
X-Gm-Message-State: ABy/qLas55txFr5JsngjG/Isz942aCUfp/MZLX/8tT5zXFQ+/tEqX/RX
        Q+xj7iZidWtTZlL5vOZLq2G3yw==
X-Google-Smtp-Source: APBJJlGoRcjX6K8sqXdBFAYVkHav89EHvDlqdHFLlFsCPwdltujh0lQJPtvJosfs82qOmCOA7/Jw8Q==
X-Received: by 2002:adf:e442:0:b0:314:4a15:e557 with SMTP id t2-20020adfe442000000b003144a15e557mr2127036wrm.5.1690559253732;
        Fri, 28 Jul 2023 08:47:33 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003fa95f328afsm1816696wmi.29.2023.07.28.08.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 08:47:33 -0700 (PDT)
Message-ID: <1d640aca-761e-602e-1de4-e34c8184d53d@linaro.org>
Date:   Fri, 28 Jul 2023 16:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/33] iris: vidc: define video core and instance context
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-7-git-send-email-quic_vgarodia@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1690550624-14642-7-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 14:23, Vikash Garodia wrote:
> +#define call_iris_op(d, op, ...)			\
> +	(((d) && (d)->iris_ops && (d)->iris_ops->op) ? \
> +	((d)->iris_ops->op(__VA_ARGS__)) : 0)
> +
> +struct msm_vidc_iris_ops {
> +	int (*boot_firmware)(struct msm_vidc_core *core);
> +	int (*raise_interrupt)(struct msm_vidc_core *core);
> +	int (*clear_interrupt)(struct msm_vidc_core *core);
> +	int (*prepare_pc)(struct msm_vidc_core *core);
> +	int (*power_on)(struct msm_vidc_core *core);
> +	int (*power_off)(struct msm_vidc_core *core);
> +	int (*watchdog)(struct msm_vidc_core *core, u32 intr_status);
> +};

So I don't see how this code supports booting the venus firmware, is 
that not required on 8550 ?

I've applied the full patchset to -next

We don't appear to have enumerated callbacks for booting, clearing 
interrupts..

grep -r clear_interrupt drivers/media/platform/qcom/iris/vidc/src/*
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c: 
call_iris_op(core, clear_interrupt, core);

grep -r boot_firmware drivers/media/platform/qcom/iris/vidc/src/*
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:	rc = 
call_iris_op(core, boot_firmware, core);
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:	rc = 
call_iris_op(core, boot_firmware, core);

There is dead code @ raise_interrupt..

grep -r raise_interrupt drivers/media/platform/qcom/iris/vidc/src/*
drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c:	 
call_iris_op(core, raise_interrupt, core);
drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c:		 
//call_iris_op(core, raise_interrupt, core);
drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c:		 
//call_iris_op(core, raise_interrupt, core);

grep -r clear_interrupt drivers/media/platform/qcom/iris/vidc/src/*
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c: 
call_iris_op(core, clear_interrupt, core);

grep -r prepare_pc drivers/media/platform/qcom/iris/vidc/src/*
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:int 
__prepare_pc(struct msm_vidc_core *core)
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:	rc = 
call_iris_op(core, prepare_pc, core);


Here we have an admixture of the new name "Iris" with the old name "venus"

grep -r power_on drivers/media/platform/qcom/iris/vidc/src/*
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:static int 
__venus_power_on(struct msm_vidc_core *core)
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:	rc = 
call_iris_op(core, power_on, core);
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:	rc = 
__venus_power_on(core);
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:		goto 
err_venus_power_on;
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:err_venus_power_on:
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:	rc = 
__venus_power_on(core);

grep -r power_off drivers/media/platform/qcom/iris/vidc/src/*
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:		goto skip_power_off;
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:skip_power_off:
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:static int 
__venus_power_off(struct msm_vidc_core *core)
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:	rc = 
call_iris_op(core, power_off, core);
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c: 
__venus_power_off(core);
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c: 
__venus_power_off(core);
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c: 
__venus_power_off(core);
drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c: 
__venus_power_off(core);

Lending credence to the argument we could incorporate all of some of the 
is logic in the existing venus driver.

---
bod
