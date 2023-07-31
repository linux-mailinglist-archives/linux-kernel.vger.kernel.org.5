Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF4976A2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGaVdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGaVca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3F1BF9;
        Mon, 31 Jul 2023 14:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EE0D612E7;
        Mon, 31 Jul 2023 21:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60922C433C8;
        Mon, 31 Jul 2023 21:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690839082;
        bh=6lP5+Cei+2goByQ2ABFk3N4PaZH64I6jAOzydkz/QyY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LmcG8qXoZM2ed67Z2dFJogRdJ/NwHB+d/XWKqQWCUPkXA/QLPCj7qQN/emwgnK6fv
         3e+5rcn3qU6Ga7ddJiELPa9u6LLujs2Jmdl80RteHjjT2FikK72++qtRjXB2EOpRw2
         3/UTQ0/R40Pqekg/Kn4dOdB52rK9kGHfhAmsudslE7Jze7uhf8Zdxz+hJCL/VO5DXm
         7HNIaLER8ktQ0y7iDvKsxmIxHwb1/GpAI4AzdoS4x5g3ZIwvav6c9ZyMED6iwq6Zwy
         7y2LJTWdxLg3hQlJMgKysq0aJMKkGfVChen65n60N6ULzjLTxx64jIRgEO81cDDczo
         octOy7lLcJcOg==
Message-ID: <defaff1f-af76-8b02-8d23-534310be16bb@kernel.org>
Date:   Mon, 31 Jul 2023 23:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 24/33] iris: vidc: add debug files
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-25-git-send-email-quic_vgarodia@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1690550624-14642-25-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 15:23, Vikash Garodia wrote:
> this implements the debugging framework.

Your commit msgs are not helping to understand why do you need it and
what is this doing. Based on this commit description I would ask you to
drop most of this code as it looks useless. Extend the commit msg to
provide proper justification and list of features each unit provides.

Please do not use "This commit/patch", but imperative mood. See longer
explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  .../platform/qcom/iris/vidc/inc/msm_vidc_debug.h   | 186 +++++++
>  .../platform/qcom/iris/vidc/src/msm_vidc_debug.c   | 581 +++++++++++++++++++++
>  2 files changed, 767 insertions(+)
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_debug.h
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_debug.c
> 
> diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_debug.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_debug.h
> new file mode 100644
> index 0000000..ffced01
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_debug.h
> @@ -0,0 +1,186 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef __MSM_VIDC_DEBUG__
> +#define __MSM_VIDC_DEBUG__
> +
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/types.h>
> +
> +struct msm_vidc_core;
> +struct msm_vidc_inst;
> +
> +#ifndef VIDC_DBG_LABEL
> +#define VIDC_DBG_LABEL "msm_vidc"
> +#endif

Drop these three. Don't re-invent Linux kernel API.

> +
> +/* Allow only 6 prints/sec */
> +#define VIDC_DBG_SESSION_RATELIMIT_INTERVAL (1 * HZ)
> +#define VIDC_DBG_SESSION_RATELIMIT_BURST 6
> +
> +#define VIDC_DBG_TAG_INST VIDC_DBG_LABEL ": %4s: %s: "
> +#define VIDC_DBG_TAG_CORE VIDC_DBG_LABEL ": %4s: %08x: %s: "
> +#define FW_DBG_TAG VIDC_DBG_LABEL ": %6s: "
> +#define DEFAULT_SID ((u32)-1)
> +
> +#ifndef MSM_VIDC_EMPTY_BRACE
> +#define MSM_VIDC_EMPTY_BRACE {},

That's the funniest code I saw since some time.

> +#endif
> +
> +extern unsigned int msm_vidc_debug;

Nope.

> +extern unsigned int msm_fw_debug;

Nope.

> +extern bool msm_vidc_fw_dump;

Nope.

> +
> +/* do not modify the log message as it is used in test scripts */
> +#define FMT_STRING_SET_CTRL \
> +	"%s: state %s, name %s, id 0x%x value %d\n"
> +#define FMT_STRING_STATE_CHANGE \
> +	"%s: state changed to %s from %s\n"
> +#define FMT_STRING_MSG_SFR \
> +	"SFR Message from FW: %s\n"
> +#define FMT_STRING_FAULT_HANDLER \
> +	"%s: faulting address: %lx\n"
> +#define FMT_STRING_SET_CAP \
> +	"set cap: name: %24s, cap value: %#10x, hfi: %#10llx\n"
> +
> +/* To enable messages OR these values and
> + * echo the result to debugfs file.
> + *
> + * To enable all messages set msm_vidc_debug = 0x101F
> + */
> +
> +enum vidc_msg_prio_drv {
> +	VIDC_ERR        = 0x00000001,
> +	VIDC_HIGH       = 0x00000002,
> +	VIDC_LOW        = 0x00000004,
> +	VIDC_PERF       = 0x00000008,
> +	VIDC_PKT        = 0x00000010,
> +	VIDC_BUS        = 0x00000020,
> +	VIDC_STAT       = 0x00000040,
> +	VIDC_ENCODER    = 0x00000100,
> +	VIDC_DECODER    = 0x00000200,
> +	VIDC_PRINTK     = 0x10000000,
> +	VIDC_FTRACE     = 0x20000000,
> +};
> +
> +enum vidc_msg_prio_fw {
> +	FW_LOW          = 0x00000001,
> +	FW_MED          = 0x00000002,
> +	FW_HIGH         = 0x00000004,
> +	FW_ERROR        = 0x00000008,
> +	FW_FATAL        = 0x00000010,
> +	FW_PERF         = 0x00000020,
> +	FW_CACHE_LOW    = 0x00000100,
> +	FW_CACHE_MED    = 0x00000200,
> +	FW_CACHE_HIGH   = 0x00000400,
> +	FW_CACHE_ERROR  = 0x00000800,
> +	FW_CACHE_FATAL  = 0x00001000,
> +	FW_CACHE_PERF   = 0x00002000,
> +	FW_PRINTK       = 0x10000000,
> +	FW_FTRACE       = 0x20000000,
> +};
> +
> +#define DRV_LOG        (VIDC_ERR | VIDC_PRINTK)
> +#define DRV_LOGSHIFT   (0)
> +#define DRV_LOGMASK    (0x0FFFFFFF)
> +
> +#define FW_LOG         (FW_ERROR | FW_FATAL | FW_PRINTK)
> +#define FW_LOGSHIFT    (0)
> +#define FW_LOGMASK     (0x0FFFFFFF)
> +
> +#define dprintk_inst(__level, __level_str, inst, __fmt, ...) \
> +	do { \
> +		if (inst && (msm_vidc_debug & (__level))) { \
> +			pr_info(VIDC_DBG_TAG_INST __fmt, \
> +				__level_str, \
> +				inst->debug_str, \
> +				##__VA_ARGS__); \
> +		} \
> +	} while (0)
> +
> +#define i_vpr_e(inst, __fmt, ...) dprintk_inst(VIDC_ERR,  "err ", inst, __fmt, ##__VA_ARGS__)
> +#define i_vpr_i(inst, __fmt, ...) dprintk_inst(VIDC_HIGH, "high", inst, __fmt, ##__VA_ARGS__)
> +#define i_vpr_h(inst, __fmt, ...) dprintk_inst(VIDC_HIGH, "high", inst, __fmt, ##__VA_ARGS__)
> +#define i_vpr_l(inst, __fmt, ...) dprintk_inst(VIDC_LOW,  "low ", inst, __fmt, ##__VA_ARGS__)
> +#define i_vpr_p(inst, __fmt, ...) dprintk_inst(VIDC_PERF, "perf", inst, __fmt, ##__VA_ARGS__)
> +#define i_vpr_t(inst, __fmt, ...) dprintk_inst(VIDC_PKT,  "pkt ", inst, __fmt, ##__VA_ARGS__)
> +#define i_vpr_b(inst, __fmt, ...) dprintk_inst(VIDC_BUS,  "bus ", inst, __fmt, ##__VA_ARGS__)

NAK for entire interface. Please use standard debugging functions, not
pr_info for everything.

dev_dbg, dev_info, dev_warn, dev_err. Only these.


> +#define i_vpr_s(inst, __fmt, ...) dprintk_inst(VIDC_STAT, "stat", inst, __fmt, ##__VA_ARGS__)
> +
> +#define i_vpr_hp(inst, __fmt, ...) \
> +	dprintk_inst(VIDC_HIGH | VIDC_PERF, "high", inst, __fmt, ##__VA_ARGS__)
> +#define i_vpr_hs(inst, __fmt, ...) \
> +	dprintk_inst(VIDC_HIGH | VIDC_STAT, "stat", inst, __fmt, ##__VA_ARGS__)
> +> +#define dprintk_core(__level, __level_str, __fmt, ...) \

NAK

> +	do { \
> +		if (msm_vidc_debug & (__level)) { \
> +			pr_info(VIDC_DBG_TAG_CORE __fmt, \
> +				__level_str, \
> +				DEFAULT_SID, \
> +				"codec", \
> +				##__VA_ARGS__); \
> +		} \
> +	} while (0)
> +
> +#define d_vpr_e(__fmt, ...) dprintk_core(VIDC_ERR,  "err ", __fmt, ##__VA_ARGS__)
> +#define d_vpr_h(__fmt, ...) dprintk_core(VIDC_HIGH, "high", __fmt, ##__VA_ARGS__)
> +#define d_vpr_l(__fmt, ...) dprintk_core(VIDC_LOW,  "low ", __fmt, ##__VA_ARGS__)
> +#define d_vpr_p(__fmt, ...) dprintk_core(VIDC_PERF, "perf", __fmt, ##__VA_ARGS__)
> +#define d_vpr_t(__fmt, ...) dprintk_core(VIDC_PKT,  "pkt ", __fmt, ##__VA_ARGS__)
> +#define d_vpr_b(__fmt, ...) dprintk_core(VIDC_BUS,  "bus ", __fmt, ##__VA_ARGS__)
> +#define d_vpr_s(__fmt, ...) dprintk_core(VIDC_STAT, "stat", __fmt, ##__VA_ARGS__)
> +#define d_vpr_hs(__fmt, ...) \
> +	dprintk_core(VIDC_HIGH | VIDC_STAT, "high", __fmt, ##__VA_ARGS__)
> +
> +#define dprintk_ratelimit(__level, __level_str, __fmt, ...) \
> +	do { \
> +		if (msm_vidc_check_ratelimit()) { \
> +			dprintk_core(__level, __level_str, __fmt, ##__VA_ARGS__); \
> +		} \
> +	} while (0)
> +
> +#define dprintk_firmware(__level, __fmt, ...)	\
> +	do { \
> +		if ((msm_fw_debug & (__level)) & FW_PRINTK) { \
> +			pr_info(FW_DBG_TAG __fmt, \
> +				"fw", \
> +				##__VA_ARGS__); \
> +		} \
> +	} while (0)
> +
> +enum msm_vidc_debugfs_event {
> +	MSM_VIDC_DEBUGFS_EVENT_ETB,
> +	MSM_VIDC_DEBUGFS_EVENT_EBD,
> +	MSM_VIDC_DEBUGFS_EVENT_FTB,
> +	MSM_VIDC_DEBUGFS_EVENT_FBD,
> +};
> +
> +enum msm_vidc_bug_on_error {
> +	MSM_VIDC_BUG_ON_FATAL             = BIT(0),
> +	MSM_VIDC_BUG_ON_NOC               = BIT(1),
> +	MSM_VIDC_BUG_ON_WD_TIMEOUT        = BIT(2),
> +};
> +
> +struct dentry *msm_vidc_debugfs_init_drv(void);
> +struct dentry *msm_vidc_debugfs_init_core(struct msm_vidc_core *core);
> +struct dentry *msm_vidc_debugfs_init_inst(struct msm_vidc_inst *inst,
> +					  struct dentry *parent);
> +void msm_vidc_debugfs_deinit_inst(struct msm_vidc_inst *inst);
> +void msm_vidc_debugfs_update(struct msm_vidc_inst *inst,
> +			     enum msm_vidc_debugfs_event e);
> +int msm_vidc_check_ratelimit(void);
> +
> +static inline bool is_stats_enabled(void)
> +{
> +	return !!(msm_vidc_debug & VIDC_STAT);

...

> +struct dentry *msm_vidc_debugfs_init_core(struct msm_vidc_core *core)
> +{
> +	struct dentry *dir = NULL;
> +	char debugfs_name[MAX_DEBUGFS_NAME];
> +	struct dentry *parent;
> +
> +	if (!core->debugfs_parent) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		goto failed_create_dir;
> +	}
> +	parent = core->debugfs_parent;
> +
> +	snprintf(debugfs_name, MAX_DEBUGFS_NAME, "core");
> +	dir = debugfs_create_dir(debugfs_name, parent);
> +	if (IS_ERR_OR_NULL(dir)) {
> +		dir = NULL;
> +		d_vpr_e("Failed to create debugfs for msm_vidc\n");
> +		goto failed_create_dir;
> +	}
> +	if (!debugfs_create_file("info", 0444, dir, core, &core_info_fops)) {
> +		d_vpr_e("debugfs_create_file: fail\n");
> +		goto failed_create_dir;
> +	}
> +
> +	if (!debugfs_create_file("stats_delay_ms", 0644, dir, core, &stats_delay_fops)) {
> +		d_vpr_e("debugfs_create_file: fail\n");


What is this entire debugfs supposed to provide?



Best regards,
Krzysztof

