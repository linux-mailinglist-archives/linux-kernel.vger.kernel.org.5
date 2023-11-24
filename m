Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519EF7F74EB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjKXN1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjKXN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:26:58 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB51700
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54b0073d50fso628014a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700832407; x=1701437207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwuDyNmwe2HOUNP9GGokIwQTeoj8kz9tPg5AhGzHxQ8=;
        b=K2rDE26epHtfpdDLJa22zQnJrb5c/TFORYDENHKCyh0p52+IeHub/HROuiDcNsux47
         kEWPWCpPfe9FuRFCx8DyF3qyaYYyvyDKwsNwc87iO3apNpcCbibYzIEYPSTFCJu2ppO4
         tckM+rk7fTwpS4OrnPfa8hKdAg4+UDIU5HrQCZ6sJK+VAFIpmQ/2j63y9nWqMWShKlmJ
         m34z6MjmxLnrhLs7EgQLVxdQcCkc9mDyxgV44Yr8TMvOv+IDMs0BFxboKMTlD6sbYVoZ
         7hHmOE9rEMIkgi3tbYN6UCr/hzzNuxEhrYKraHBc7Jz3X8qtxCSozBPo9C6pAAU6wnbW
         v7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700832407; x=1701437207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwuDyNmwe2HOUNP9GGokIwQTeoj8kz9tPg5AhGzHxQ8=;
        b=h/7WTrixJxRL9CHOk5kiWAvqEf3Ex96f+4l4ypUhxE8zaiox1ArhEB9VLU4NkAmy9X
         vIOYnc0R0Je9vJeVUnIohKgYs85yi1vLUuGADO5Z3YSF/GNVaxs8voNAis3/7GWd45Ak
         cmI+5Lr6l+ohQmfFW5FJTmyalW/0fMTj+fsvt22aji8W7Gie5yrZMn+zh2EbMU3aZBxm
         P9RBceiuVrzjpD5mvIqNHhiMWUE6VCLKGet7Ghl1YqAWAGFw+WnmZH+bvTlWfkyhlmCi
         NLUCsxCbX1GOWra5PHizz0e3wDoPEUx6C3xQEV3J75/DHs2EWWDIYgRceUnIMchFjMi5
         oWgg==
X-Gm-Message-State: AOJu0Yy9gh6qFDOt7yGp4J71j7+9dwkNnQKhreWHB5O3eB+/u3r66Ktl
        sOx+AQRZNArqo6Dc0ZuAYxXqHQ==
X-Google-Smtp-Source: AGHT+IGt6Iyx/ncFYNDioG0URqFusSm9WUYtc6vL9hOsBQ1Y4HVpwyElplFqw/g5MupxscZikESIVw==
X-Received: by 2002:a50:8d03:0:b0:548:656c:5371 with SMTP id s3-20020a508d03000000b00548656c5371mr2507607eds.16.1700832407235;
        Fri, 24 Nov 2023 05:26:47 -0800 (PST)
Received: from [192.168.86.103] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o26-20020a056402039a00b005487c48d9ebsm1793399edv.57.2023.11.24.05.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:26:46 -0800 (PST)
Message-ID: <3b26b0fc-e2fd-4f9a-a745-43f40c513812@linaro.org>
Date:   Fri, 24 Nov 2023 13:26:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] misc: fastrpc: Capture kernel and DSP performance
 counters
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20231121094844.5764-1-quic_ekangupt@quicinc.com>
 <20231121094844.5764-4-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231121094844.5764-4-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/11/2023 09:48, Ekansh Gupta wrote:
> Add support to capture kernel performance counters for different
> kernel level operations. These counters collects the information
> for remote call and copies the information to a buffer shared
> by user.
> 
> Collection of DSP performance counters is also added as part of
> this change. DSP updates the performance information in the
> metadata which is then copied to a buffer passed by the user.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
> Changes in v2:
>    - Fixed compile time warnings
> Changes in v3:
>    - Squashed commits to get proper patch series
> Changes in v7:
>    - Rebase the patch to latest kernel version
> 
>   drivers/misc/fastrpc.c      | 141 ++++++++++++++++++++++++++++++++++--
>   include/uapi/misc/fastrpc.h |  14 ++++
>   2 files changed, 147 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.cin:sent 
> index 55f126c779cb..cbcac0b3d09b 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -19,6 +19,7 @@
>   #include <linux/rpmsg.h>
>   #include <linux/scatterlist.h>
>   #include <linux/slab.h>
> +#include <linux/delay.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   #include <uapi/misc/fastrpc.h>
>   #include <linux/of_reserved_mem.h>
> @@ -33,6 +34,8 @@
>   #define FASTRPC_ALIGN		128
>   #define FASTRPC_MAX_FDLIST	16
>   #define FASTRPC_MAX_CRCLIST	64
> +#define FASTRPC_KERNEL_PERF_LIST (PERF_KEY_MAX)
> +#define FASTRPC_DSP_PERF_LIST 12
>   #define FASTRPC_PHYS(p)	((p) & 0xffffffff)
>   #define FASTRPC_CTX_MAX (256)
>   #define FASTRPC_INIT_HANDLE	1
> @@ -105,6 +108,27 @@
>   
>   #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>   
> +#define PERF_END ((void)0)
> +
> +#define PERF(enb, cnt, ff) \
> +	{\
> +		struct timespec64 startT = {0};\
> +		uint64_t *counter = cnt;\
> +		if (enb && counter) {\
> +			ktime_get_real_ts64(&startT);\
> +		} \
> +		ff ;\
> +		if (enb && counter) {\
> +			*counter += getnstimediff(&startT);\
> +		} \
> +	}
> +
> +#define GET_COUNTER(perf_ptr, offset)  \
> +	(perf_ptr != NULL ?\
> +		(((offset >= 0) && (offset < PERF_KEY_MAX)) ?\
> +			(uint64_t *)(perf_ptr + offset)\
> +				: (uint64_t *)NULL) : (uint64_t *)NULL)
> +
>   static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
>   						"sdsp", "cdsp"};
>   struct fastrpc_phy_page {
> @@ -228,6 +252,19 @@ struct fastrpc_map {
>   	struct kref refcount;
>   };
>   
> +struct fastrpc_perf {
> +	u64 count;
> +	u64 flush;
> +	u64 map;
> +	u64 copy;
> +	u64 link;
> +	u64 getargs;
> +	u64 putargs;
> +	u64 invargs;
> +	u64 invoke;
> +	u64 tid;
> +};
> +
>   struct fastrpc_invoke_ctx {
>   	int nscalars;
>   	int nbufs;
> @@ -236,6 +273,8 @@ struct fastrpc_invoke_ctx {
>   	int tgid;
>   	u32 sc;
>   	u32 *crc;
> +	u64 *perf_kernel;
> +	u64 *perf_dsp;
>   	u64 ctxid;
>   	u64 msg_sz;
>   	struct kref refcount;
> @@ -250,6 +289,7 @@ struct fastrpc_invoke_ctx {
>   	struct fastrpc_invoke_args *args;
>   	struct fastrpc_buf_overlap *olaps;
>   	struct fastrpc_channel_ctx *cctx;
> +	struct fastrpc_perf *perf;
>   };
>   
>   struct fastrpc_session_ctx {
> @@ -299,6 +339,7 @@ struct fastrpc_user {
>   	struct fastrpc_session_ctx *sctx;
>   	struct fastrpc_buf *init_mem;
>   
> +	u32 profile;
>   	int tgid;
>   	int pd;
>   	bool is_secure_dev;
> @@ -308,6 +349,17 @@ struct fastrpc_user {
>   	struct mutex mutex;
>   };
>   
> +static inline int64_t getnstimediff(struct timespec64 *start)
> +{
> +	int64_t ns;
> +	struct timespec64 ts, b;
> +
> +	ktime_get_real_ts64(&ts);
> +	b = timespec64_sub(ts, *start);
> +	ns = timespec64_to_ns(&b);
> +	return ns;
> +}
> +
>   static void fastrpc_free_map(struct kref *ref)
>   {
>   	struct fastrpc_map *map;
> @@ -493,6 +545,9 @@ static void fastrpc_context_free(struct kref *ref)
>   	if (ctx->buf)
>   		fastrpc_buf_free(ctx->buf);
>   
> +	if (ctx->fl->profile)
> +		kfree(ctx->perf);
> +
>   	spin_lock_irqsave(&cctx->lock, flags);
>   	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
>   	spin_unlock_irqrestore(&cctx->lock, flags);
> @@ -612,6 +667,14 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>   	fastrpc_channel_ctx_get(cctx);
>   
>   	ctx->crc = (u32 *)(uintptr_t)invoke->crc;
> +	ctx->perf_dsp = (u64 *)(uintptr_t)invoke->perf_dsp;
> +	ctx->perf_kernel = (u64 *)(uintptr_t)invoke->perf_kernel;
> +	if (ctx->fl->profile) {
> +		ctx->perf = kzalloc(sizeof(*(ctx->perf)), GFP_KERNEL);
> +		if (!ctx->perf)
> +			return ERR_PTR(-ENOMEM);
> +		ctx->perf->tid = ctx->fl->tgid;
> +	}
>   	ctx->sc = sc;
>   	ctx->retval = -1;
>   	ctx->pid = current->pid;
> @@ -875,7 +938,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
>   		sizeof(struct fastrpc_invoke_buf) +
>   		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
>   		sizeof(u64) * FASTRPC_MAX_FDLIST +
> -		sizeof(u32) * FASTRPC_MAX_CRCLIST;
> +		sizeof(u32) * FASTRPC_MAX_CRCLIST +
> +		sizeof(u32) + sizeof(u64) * FASTRPC_DSP_PERF_LIST;
>   
>   	return size;
>   }
> @@ -942,16 +1006,22 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>   	int inbufs, i, oix, err = 0;
>   	u64 len, rlen, pkt_size;
>   	u64 pg_start, pg_end;
> +	u64 *perf_counter = NULL;
>   	uintptr_t args;
>   	int metalen;
>   
> +	if (ctx->fl->profile)
> +		perf_counter = (u64 *)ctx->perf + PERF_COUNT;
> +
>   	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
>   	metalen = fastrpc_get_meta_size(ctx);
>   	pkt_size = fastrpc_get_payload_size(ctx, metalen);
>   
> +	PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_MAP),
>   	err = fastrpc_create_maps(ctx);
>   	if (err)
>   		return err;
> +	PERF_END);
>   
>   	ctx->msg_sz = pkt_size;
>   
> @@ -984,6 +1054,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>   		if (ctx->maps[i]) {
>   			struct vm_area_struct *vma = NULL;
>   
> +			PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_MAP),
>   			rpra[i].buf.pv = (u64) ctx->args[i].ptr;
>   			pages[i].addr = ctx->maps[i]->phys;
>   
> @@ -998,9 +1069,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>   			pg_end = ((ctx->args[i].ptr + len - 1) & PAGE_MASK) >>
>   				  PAGE_SHIFT;
>   			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
> -
> +			PERF_END);
>   		} else {
> -
> +			PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_COPY),
>   			if (ctx->olaps[oix].offset == 0) {
>   				rlen -= ALIGN(args, FASTRPC_ALIGN) - args;
>   				args = ALIGN(args, FASTRPC_ALIGN);
> @@ -1022,12 +1093,14 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>   			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
>   			args = args + mlen;
>   			rlen -= mlen;
> +			PERF_END);
>   		}
>   
>   		if (i < inbufs && !ctx->maps[i]) {
>   			void *dst = (void *)(uintptr_t)rpra[i].buf.pv;
>   			void *src = (void *)(uintptr_t)ctx->args[i].ptr;
>   
> +			PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_COPY),
>   			if (!kernel) {
>   				if (copy_from_user(dst, (void __user *)src,
>   						   len)) {
> @@ -1037,6 +1110,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>   			} else {
>   				memcpy(dst, src, len);
>   			}
> +			PERF_END);
>   		}
>   	}
>   
> @@ -1067,9 +1141,9 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   	struct fastrpc_map *mmap = NULL;
>   	struct fastrpc_invoke_buf *list;
>   	struct fastrpc_phy_page *pages;
> -	u64 *fdlist;
> -	u32 *crclist;
> -	int i, inbufs, outbufs, handles;
> +	u64 *fdlist, *perf_dsp_list;
> +	u32 *crclist, *poll;
> +	int i, inbufs, outbufs, handles, perferr;
>   
>   	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
>   	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
> @@ -1078,6 +1152,8 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   	pages = fastrpc_phy_page_start(list, ctx->nscalars);
>   	fdlist = (u64 *)(pages + inbufs + outbufs + handles);
>   	crclist = (u32 *)(fdlist + FASTRPC_MAX_FDLIST);
> +	poll = (u32 *)(crclist + FASTRPC_MAX_CRCLIST);
> +	perf_dsp_list = (u64 *)(poll + 1);
>   
>   	for (i = inbufs; i < ctx->nbufs; ++i) {
>   		if (!ctx->maps[i]) {
> @@ -1103,8 +1179,16 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   	}
>   
>   	if (ctx->crc && crclist && rpra) {
> -		if (copy_to_user((void __user *)ctx->crc, crclist, FASTRPC_MAX_CRCLIST * sizeof(u32)))
> +		if (copy_to_user((void __user *)ctx->crc, crclist,
> +					FASTRPC_MAX_CRCLIST * sizeof(u32))) {
>   			return -EFAULT;
> +		}
> +	}
> +	if (ctx->perf_dsp && perf_dsp_list) {
> +		perferr = copy_to_user((void __user *)ctx->perf_dsp,
> +				perf_dsp_list, FASTRPC_DSP_PERF_LIST * sizeof(u64));
> +		if (perferr)
> +			dev_info(fl->sctx->dev, "Warning: failed to copy perf data %d\n", perferr);
>   	}
>   	return 0;
>   }
> @@ -1141,6 +1225,21 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
>   
>   }
>   
> +static void fastrpc_update_invoke_count(u32 handle, u64 *perf_counter,
> +					struct timespec64 *invoket)
> +{
> +	u64 *invcount, *count;
> +
> +	invcount = GET_COUNTER(perf_counter, PERF_INVOKE);
> +	if (invcount)
> +		*invcount += getnstimediff(invoket);
> +
> +	count = GET_COUNTER(perf_counter, PERF_COUNT);
> +	if (count)
> +		*count += 1;
> +}
> +
> +
>   static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   				   struct fastrpc_enhanced_invoke *invoke)
>   {
> @@ -1148,7 +1247,12 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   	struct fastrpc_buf *buf, *b;
>   	struct fastrpc_invoke *inv = &invoke->inv;
>   	u32 handle, sc;
> -	int err = 0;
> +	u64 *perf_counter = NULL;
> +	int err = 0, perferr = 0;
> +	struct timespec64 invoket = {0};
> +
> +	if (fl->profile)
> +		ktime_get_real_ts64(&invoket);
>   
>   	if (!fl->sctx)
>   		return -EINVAL;
> @@ -1167,16 +1271,22 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   	if (IS_ERR(ctx))
>   		return PTR_ERR(ctx);
>   
> +	if (fl->profile)
> +		perf_counter = (u64 *)ctx->perf + PERF_COUNT;
> +	PERF(fl->profile, GET_COUNTER(perf_counter, PERF_GETARGS),
>   	err = fastrpc_get_args(kernel, ctx);
>   	if (err)
>   		goto bail;
> +	PERF_END);
>   
>   	/* make sure that all CPU memory writes are seen by DSP */
>   	dma_wmb();
> +	PERF(fl->profile, GET_COUNTER(perf_counter, PERF_LINK),
>   	/* Send invoke buffer to remote dsp */
>   	err = fastrpc_invoke_send(fl->sctx, ctx, kernel, handle);
>   	if (err)
>   		goto bail;
> +	PERF_END);
>   
>   	if (kernel) {
>   		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
> @@ -1190,10 +1300,12 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   
>   	/* make sure that all memory writes by DSP are seen by CPU */
>   	dma_rmb();
> +	PERF(fl->profile, GET_COUNTER(perf_counter, PERF_PUTARGS),
>   	/* populate all the output buffers with results */
>   	err = fastrpc_put_args(ctx, kernel);
>   	if (err)
>   		goto bail;
> +	PERF_END);
>   
>   	/* Check the response from remote dsp */
>   	err = ctx->retval;
> @@ -1214,6 +1326,15 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   			list_del(&buf->node);
>   			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
>   		}
> +	} else if (ctx) {
> +		if (fl->profile && !err)
> +			fastrpc_update_invoke_count(handle, perf_counter, &invoket);
> +		if (fl->profile && ctx->perf && ctx->perf_kernel) {
> +			perferr = copy_to_user((void __user *)ctx->perf_kernel,
> +						ctx->perf, FASTRPC_KERNEL_PERF_LIST * sizeof(u64));
> +			if (perferr)
> +				dev_info(fl->sctx->dev, "Warning: failed to copy perf data %d\n", perferr);
> +		}
>   	}
>   
>   	if (err)
> @@ -1712,6 +1833,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
>   	struct fastrpc_invoke_args *args = NULL;
>   	struct fastrpc_ioctl_multimode_invoke invoke;
>   	u32 nscalars;
> +	u64 *perf_kernel;
>   	int err, i;
>   
>   	if (copy_from_user(&invoke, argp, sizeof(invoke)))
> @@ -1746,6 +1868,9 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
>   				return -EFAULT;
>   			}
>   		}
> +		perf_kernel = (u64 *)(uintptr_t)einv.perf_kernel;
> +		if (perf_kernel)
> +			fl->profile = true;
>   		einv.inv.args = (__u64)args;
>   		err = fastrpc_internal_invoke(fl, false, &einv);
>   		kfree(args);
> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
> index 45c15be1de58..074675ee646f 100644
> --- a/include/uapi/misc/fastrpc.h
> +++ b/include/uapi/misc/fastrpc.h
> @@ -166,4 +166,18 @@ struct fastrpc_ioctl_capability {
>   	__u32 reserved[4];
>   };
>   
> +enum fastrpc_perfkeys {
> +	PERF_COUNT = 0,
> +	PERF_RESERVED1 = 1,

why reserved in middle of ranges? if you know already pl add the proper 
name for it.

> +	PERF_MAP = 2,
> +	PERF_COPY = 3,
> +	PERF_LINK = 4,
> +	PERF_GETARGS = 5,
> +	PERF_PUTARGS = 6,
> +	PERF_RESERVED2 = 7,
> +	PERF_INVOKE = 8,
> +	PERF_RESERVED3 = 9,
> +	PERF_KEY_MAX = 10,
> +};
> +
>   #endif /* __QCOM_FASTRPC_H__ */
