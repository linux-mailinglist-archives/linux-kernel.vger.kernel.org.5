Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1635E7F7515
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345440AbjKXN3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjKXN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:28:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D39A26AD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so2609337a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700832466; x=1701437266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eokqNMXFjjI+HtrKv3iS9XiSFNSMnH+iWv/pd8rsZ+0=;
        b=x+c58fovJs0+ddYdpX0ZNQJZSK2jpLYbUZCarPirybFHxIey/GNxWpwEoVUCI9IUR1
         UIOBjQIhWNp3BB4P6+zMSD5U2b6GpLYvOfkcXATFowfhSqTB16paF17Doe3d6GYMAY9X
         PudmkDIhxvyPAlzGxZo+tAJPWzB6oJypnET+ZhDs2MYeSFBO9VdjFjxwA+Es0wbgCX4G
         hTIiLIJUSgblPMoqvwEKbChivCQiznMzhcJGEtd44ClhL0u86vT2D1ONceCtYgzQc71h
         Oi5SGhxMlMANuVrSIxRdHuy0/LE+2HryCNOyUQMCcvVKXkvGWKILwq3ZO4KIk8noVBXC
         RwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700832466; x=1701437266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eokqNMXFjjI+HtrKv3iS9XiSFNSMnH+iWv/pd8rsZ+0=;
        b=MmS446a/6/WLX+ofVjgJgCVefBBzIUp9yFimwZtEdUCMSQUQYnrC5+fsnmFRXsyRlN
         wJccmB7qnmpnhhzOfus+sILiOBX/MTMqcDT4cdrczWc+DXona3Atx6ZbWASi/qRMLByJ
         SxpKKU+PkeA6jFeSnCSggROpIVEsiNxXfGK6kzfHk2pkhzdpI8QCq4Gdpd49cEHbQkkC
         p9reAS/iEY8y3L1hq55v3hDoYcSUrj58VmS0ZTU0yjf2o0D8I9pTHtl9jioTdhB+L3C7
         xeEegLFaLi1SFTxliQ0tkjZ3WALBJGk5Qp76JLBI+LC43nk+zRQhTMHOkfI1nW0d6Li7
         kpcg==
X-Gm-Message-State: AOJu0Yz0OLT1eDAZtiue4N/adxtzamc5rFG3BgprAnR23eUHRO9DBQtm
        IxdfWD27RsvMlbh5RsxbiBSltA==
X-Google-Smtp-Source: AGHT+IEq8OZ3/eZ7t78xqzGs9+bIpttmgyxecpHKoHPPwDEykJFXIauwbyyIFRQe5zb0SKOadfNRhA==
X-Received: by 2002:aa7:dcc4:0:b0:54b:17c:d001 with SMTP id w4-20020aa7dcc4000000b0054b017cd001mr1169734edu.29.1700832466011;
        Fri, 24 Nov 2023 05:27:46 -0800 (PST)
Received: from [192.168.86.103] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o26-20020a056402039a00b005487c48d9ebsm1793399edv.57.2023.11.24.05.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:27:45 -0800 (PST)
Message-ID: <a2495939-0ad0-4b7c-8c77-618e79a1615c@linaro.org>
Date:   Fri, 24 Nov 2023 13:27:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] misc: fastrpc: Add early wakeup support for
 fastRPC driver
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20231121112454.12764-1-quic_ekangupt@quicinc.com>
 <20231121112454.12764-2-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231121112454.12764-2-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ekansh for the patch,

On 21/11/2023 11:24, Ekansh Gupta wrote:
> CPU wake up and context switch latency are significant in FastRPC
> overhead for remote calls. As part of this change, DSP sends early
> signal of completion to CPU and FastRPC driver detects early signal
> on the given context and starts polling on a memory for actual
> completion. Multiple different response flags are added to support
> DSP user early hint of approximate time of completion, early response
> from DSP user to wake up CPU and poll on memory for actual completion.
> Complete signal is also added which is sent by DSP user in case of
> timeout after early response is sent.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
> Changes in v3:
>    - Rebase the patch to latest kernel version
> 
>   drivers/misc/fastrpc.c | 265 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 252 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 8e77beb3a693..6b6ac3e3328d 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -106,6 +106,19 @@
>   #define USER_PD		(1)
>   #define SENSORS_PD	(2)
>   
> +#define FASTRPC_RSP_VERSION2 2
> +/* Early wake up poll completion number received from remoteproc */
> +#define FASTRPC_EARLY_WAKEUP_POLL (0xabbccdde)
> +/* timeout in us for polling until memory barrier */
> +#define FASTRPC_POLL_TIME_MEM_UPDATE (500)
> +/* timeout in us for busy polling after early response from remoteproc */
> +#define FASTRPC_POLL_TIME (4000)
> +/* timeout in us for polling completion signal after user early hint */
> +#define FASTRPC_USER_EARLY_HINT_TIMEOUT (500)

> +/* CPU feature information to DSP */

> +#define FASTRPC_CPUINFO_DEFAULT (0)
> +#define FASTRPC_CPUINFO_EARLY_WAKEUP (1)
> +
>   #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>   
>   #define PERF_END ((void)0)
> @@ -129,6 +142,15 @@
>   			(uint64_t *)(perf_ptr + offset)\
>   				: (uint64_t *)NULL) : (uint64_t *)NULL)
>   

Can you add some documentation to these flags.

> +enum fastrpc_response_flags {
> +	NORMAL_RESPONSE = 0,
> +	EARLY_RESPONSE = 1,
> +	USER_EARLY_SIGNAL = 2,
> +	COMPLETE_SIGNAL = 3,
> +	STATUS_RESPONSE = 4,
> +	POLL_MODE = 5,
> +};
> +
>   static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
>   						"sdsp", "cdsp"};
>   struct fastrpc_phy_page {
> @@ -206,6 +228,14 @@ struct fastrpc_invoke_rsp {
>   	int retval;		/* invoke return value */
>   };
>   
> +struct fastrpc_invoke_rspv2 {
> +	u64 ctx;		/* invoke caller context */
> +	int retval;		/* invoke return value */
> +	u32 flags;		/* early response flags */
> +	u32 early_wake_time;	/* user hint in us */
> +	u32 version;		/* version number */
> +};
> +
>   struct fastrpc_buf_overlap {
>   	u64 start;
>   	u64 end;
> @@ -272,11 +302,17 @@ struct fastrpc_invoke_ctx {
>   	int pid;
>   	int tgid;
>   	u32 sc;
> +	/* user hint of completion time in us */
> +	u32 early_wake_time;
>   	u32 *crc;
>   	u64 *perf_kernel;
>   	u64 *perf_dsp;
>   	u64 ctxid;
>   	u64 msg_sz;
> +	/* work done status flag */
> +	bool is_work_done;
> +	/* response flags from remote processor */
> +	enum fastrpc_response_flags rsp_flags;
>   	struct kref refcount;
>   	struct list_head node; /* list of ctxs */
>   	struct completion work;
> @@ -321,7 +357,9 @@ struct fastrpc_channel_ctx {
>   	struct list_head invoke_interrupted_mmaps;
>   	bool secure;
>   	bool unsigned_support;
> +	bool cpuinfo_status;
>   	u64 dma_mask;
> +	u64 cpuinfo_todsp;
>   };
>   
>   struct fastrpc_device {
> @@ -352,13 +390,21 @@ struct fastrpc_user {
>   	struct mutex mutex;
>   };
>   
> +struct fastrpc_ctrl_latency {
> +	u32 enable;	/* latency control enable */
> +	u32 latency;	/* latency request in us */
> +};
> +

What is this struct? am not seeing it used anywhere in this patch.


>   struct fastrpc_ctrl_smmu {
>   	u32 sharedcb;	/* Set to SMMU share context bank */
>   };
> 

>   struct fastrpc_internal_control {
>   	u32 req;
> -	struct fastrpc_ctrl_smmu smmu;
> +	union {
> +		struct fastrpc_ctrl_latency lp;
> +		struct fastrpc_ctrl_smmu smmu;
> +	};
>   };
>   
>   static inline int64_t getnstimediff(struct timespec64 *start)
> @@ -692,6 +738,8 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>   	ctx->pid = current->pid;
>   	ctx->tgid = user->tgid;
>   	ctx->cctx = cctx;
> +	ctx->rsp_flags = NORMAL_RESPONSE;
> +	ctx->is_work_done = false;
>   	init_completion(&ctx->work);
>   	INIT_WORK(&ctx->put_work, fastrpc_context_put_wq);
>   
> @@ -1302,6 +1350,115 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
>   
>   }
>   
> +static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx, u32 timeout)
> +{
> +	int err = -EIO, ii = 0, jj = 0;

variable naming is really odd.

> +	u32 sc = ctx->sc;
> +	struct fastrpc_invoke_buf *list;
> +	struct fastrpc_phy_page *pages;
> +	u64 *fdlist = NULL;
> +	u32 *crclist = NULL, *poll = NULL;
> +	unsigned int inbufs, outbufs, handles;
> +
> +	/* calculate poll memory location */
> +	inbufs = REMOTE_SCALARS_INBUFS(sc);
> +	outbufs = REMOTE_SCALARS_OUTBUFS(sc);
> +	handles = REMOTE_SCALARS_INHANDLES(sc) + REMOTE_SCALARS_OUTHANDLES(sc);
> +	list = fastrpc_invoke_buf_start(ctx->rpra, ctx->nscalars);
> +	pages = fastrpc_phy_page_start(list, ctx->nscalars);
> +	fdlist = (u64 *)(pages + inbufs + outbufs + handles);
> +	crclist = (u32 *)(fdlist + FASTRPC_MAX_FDLIST);
> +	poll = (u32 *)(crclist + FASTRPC_MAX_CRCLIST);
> +
> +	/* poll on memory for DSP response. Return failure on timeout */
> +	for (ii = 0, jj = 0; ii < timeout; ii++, jj++) {
> +		if (*poll == FASTRPC_EARLY_WAKEUP_POLL) {
> +			/* Remote processor sent early response */
> +			err = 0;
> +			break;
> +		}
> +		if (jj == FASTRPC_POLL_TIME_MEM_UPDATE) {
> +			/* Wait for DSP to finish updating poll memory */
> +			rmb();

Could you add a comment on why do we need this memory barrier here?
Can we use dma_rmb() ?


> +			jj = 0;
> +		}
> +		udelay(1);
> +	}
> +	return err;
> +}
> +
> +static inline int fastrpc_wait_for_response(struct fastrpc_invoke_ctx *ctx,
> +						u32 kernel)
> +{
> +	int interrupted = 0;
> +
> +	if (kernel)
> +		wait_for_completion(&ctx->work);
> +	else
> +		interrupted = wait_for_completion_interruptible(&ctx->work);
> +
> +	return interrupted;
> +}
> +
> +static void fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
> +			int *ptr_interrupted, u32 kernel)
> +{
> +	int err = 0, jj = 0;
unnecessary intializations.

> +	bool wait_resp = false;
> +	u32 wTimeout = FASTRPC_USER_EARLY_HINT_TIMEOUT;
> +	u32 wakeTime = ctx->early_wake_time;
> +
> +	do {
> +		switch (ctx->rsp_flags) {
> +		/* try polling on completion with timeout */
> +		case USER_EARLY_SIGNAL:
> +			/* try wait if completion time is less than timeout */
> +			/* disable preempt to avoid context switch latency */
pl use proper multi-line commenting style here.

> +			preempt_disable();
> +			jj = 0;
> +			wait_resp = false;
> +			for (; wakeTime < wTimeout && jj < wTimeout; jj++) {
> +				wait_resp = try_wait_for_completion(&ctx->work);
> +				if (wait_resp)
> +					break;
> +				udelay(1);
> +			}
> +			preempt_enable();
> +			if (!wait_resp) {
> +				*ptr_interrupted = fastrpc_wait_for_response(ctx, kernel);
> +				if (*ptr_interrupted || ctx->is_work_done)
> +					return;
> +			}
> +			break;
> +		/* busy poll on memory for actual job done */
> +		case EARLY_RESPONSE:
> +			err = poll_for_remote_response(ctx, FASTRPC_POLL_TIME);
> +			/* Mark job done if poll on memory successful */
> +			/* Wait for completion if poll on memory timeout */
> +			if (!err) {
> +				ctx->is_work_done = true;
> +				return;
> +			}
> +			if (!ctx->is_work_done) {
> +				*ptr_interrupted = fastrpc_wait_for_response(ctx, kernel);
> +				if (*ptr_interrupted || ctx->is_work_done)
> +					return;
> +			}
> +			break;
> +		case COMPLETE_SIGNAL:
> +		case NORMAL_RESPONSE:
> +			*ptr_interrupted = fastrpc_wait_for_response(ctx, kernel);
> +			if (*ptr_interrupted || ctx->is_work_done)
> +				return;
> +			break;
> +		default:
> +			*ptr_interrupted = -EBADR;
> +			dev_err(ctx->fl->sctx->dev, "unsupported response type:0x%x\n", ctx->rsp_flags);
> +			break;
> +		}
> +	} while (!ctx->is_work_done);
> +}
> +
>   static void fastrpc_update_invoke_count(u32 handle, u64 *perf_counter,
>   					struct timespec64 *invoket)
>   {
> @@ -1325,7 +1482,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   	struct fastrpc_invoke *inv = &invoke->inv;
>   	u32 handle, sc;
>   	u64 *perf_counter = NULL;
> -	int err = 0, perferr = 0;
> +	int err = 0, perferr = 0, interrupted = 0;
>   	struct timespec64 invoket = {0};
>   
>   	if (fl->profile)
> @@ -1374,15 +1531,18 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   	PERF_END);
>   
>   wait:
> -	if (kernel) {
> -		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
> -			err = -ETIMEDOUT;
> -	} else {
> -		err = wait_for_completion_interruptible(&ctx->work);
> +	fastrpc_wait_for_completion(ctx, &interrupted, kernel);
> +	if (interrupted != 0) {
> +		err = interrupted;
> +		goto bail;
>   	}
>   
> -	if (err)
> +	if (!ctx->is_work_done) {
> +		err = -ETIMEDOUT;
> +		dev_err(fl->sctx->dev, "Error: Invalid workdone state for handle 0x%x, sc 0x%x\n",
> +			handle, sc);
>   		goto bail;
> +	}
>   
>   	/* make sure that all memory writes by DSP are seen by CPU */
>   	dma_rmb();
> @@ -2056,6 +2216,36 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>   	return 0;
>   }
>   
> +static int fastrpc_send_cpuinfo_to_dsp(struct fastrpc_user *fl)
> +{
> +	int err = 0;
> +	u64 cpuinfo = 0;
> +	struct fastrpc_invoke_args args[1];
> +	struct fastrpc_enhanced_invoke ioctl;
> +
> +	if (!fl)
> +		return -EBADF;
> +
> +	cpuinfo = fl->cctx->cpuinfo_todsp;
> +	/* return success if already updated to remote processor */
> +	if (fl->cctx->cpuinfo_status)
> +		return 0;
> +
> +	args[0].ptr = (u64)(uintptr_t)&cpuinfo;
> +	args[0].length = sizeof(cpuinfo);
> +	args[0].fd = -1;
> +
> +	ioctl.inv.handle = FASTRPC_DSP_UTILITIES_HANDLE;
> +	ioctl.inv.sc = FASTRPC_SCALARS(1, 1, 0);
> +	ioctl.inv.args = (__u64)args;
> +
> +	err = fastrpc_internal_invoke(fl, true, &ioctl);
> +	if (!err)
> +		fl->cctx->cpuinfo_status = true;
> +
> +	return err;
> +}
> +
>   static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
>   {
>   	struct fastrpc_ioctl_capability cap = {0};
> @@ -2407,6 +2597,8 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
>   		break;
>   	case FASTRPC_IOCTL_INIT_ATTACH:
>   		err = fastrpc_init_attach(fl, ROOT_PD);
> +		if (!err)
> +			fastrpc_send_cpuinfo_to_dsp(fl);
>   		break;
>   	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
>   		err = fastrpc_init_attach(fl, SENSORS_PD);
> @@ -2627,6 +2819,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   		err = fastrpc_device_register(rdev, data, secure_dsp, domains[domain_id]);
>   		if (err)
>   			goto fdev_error;
> +		data->cpuinfo_todsp = FASTRPC_CPUINFO_DEFAULT;
>   		break;
>   	case CDSP_DOMAIN_ID:
>   		data->unsigned_support = true;
> @@ -2638,6 +2831,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   		err = fastrpc_device_register(rdev, data, false, domains[domain_id]);
>   		if (err)
>   			goto fdev_error;
> +		data->cpuinfo_todsp = FASTRPC_CPUINFO_EARLY_WAKEUP;
>   		break;
>   	default:
>   		err = -EINVAL;
> @@ -2680,10 +2874,12 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
>   	spin_lock(&user->lock);
>   	list_for_each_entry(ctx, &user->pending, node) {
>   		ctx->retval = -EPIPE;
> +		ctx->is_work_done = true;
>   		complete(&ctx->work);
>   	}
>   	list_for_each_entry(ctx, &user->interrupted, node) {
>   		ctx->retval = -EPIPE;
> +		ctx->is_work_done = true;
>   		complete(&ctx->work);
>   	}
>   	spin_unlock(&user->lock);
> @@ -2720,31 +2916,74 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   	fastrpc_channel_ctx_put(cctx);
>   }
>   
> +static void fastrpc_notify_user_ctx(struct fastrpc_invoke_ctx *ctx, int retval,
> +		u32 rsp_flags, u32 early_wake_time)
> +{
> +	ctx->retval = retval;
> +	ctx->rsp_flags = (enum fastrpc_response_flags)rsp_flags;
> +	switch (rsp_flags) {
> +	case NORMAL_RESPONSE:
> +	case COMPLETE_SIGNAL:
> +		/* normal and complete response with return value */
> +		ctx->is_work_done = true;
> +		complete(&ctx->work);
> +		break;
> +	case USER_EARLY_SIGNAL:
> +		/* user hint of approximate time of completion */
> +		ctx->early_wake_time = early_wake_time;
> +		break;
> +	case EARLY_RESPONSE:
> +		/* rpc framework early response with return value */
> +		complete(&ctx->work);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>   static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>   				  int len, void *priv, u32 addr)
>   {
>   	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
>   	struct fastrpc_invoke_rsp *rsp = data;
> +	struct fastrpc_invoke_rspv2 *rspv2 = NULL;
>   	struct fastrpc_invoke_ctx *ctx;
>   	unsigned long flags;
>   	unsigned long ctxid;
> +	u32 rsp_flags = 0;
> +	u32 early_wake_time = 0;
>   
>   	if (len < sizeof(*rsp))
>   		return -EINVAL;
>   
> +	if (len >= sizeof(*rspv2)) {
> +		rspv2 = data;
> +		if (rspv2) {
> +			early_wake_time = rspv2->early_wake_time;
> +			rsp_flags = rspv2->flags;
> +		}
> +	}
> +
>   	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
>   
>   	spin_lock_irqsave(&cctx->lock, flags);
>   	ctx = idr_find(&cctx->ctx_idr, ctxid);
> -	spin_unlock_irqrestore(&cctx->lock, flags);
>   
>   	if (!ctx) {
> -		dev_err(&rpdev->dev, "No context ID matches response\n");
> -		return -ENOENT;
> +		dev_info(&cctx->rpdev->dev, "Warning: No context ID matches response\n");
> +		spin_unlock_irqrestore(&cctx->lock, flags);
> +		return 0;
>   	}
>   
> -	ctx->retval = rsp->retval;
> -	complete(&ctx->work);
> +	if (rspv2) {
> +		if (rspv2->version != FASTRPC_RSP_VERSION2) {
> +			dev_err(&cctx->rpdev->dev, "Incorrect response version %d\n", rspv2->version);
> +			spin_unlock_irqrestore(&cctx->lock, flags);
> +			return -EINVAL;
> +		}
> +	}
> +	fastrpc_notify_user_ctx(ctx, rsp->retval, rsp_flags, early_wake_time);
> +	spin_unlock_irqrestore(&cctx->lock, flags);
>   
>   	/*
>   	 * The DMA buffer associated with the context cannot be freed in
