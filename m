Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854187B070F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjI0OhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjI0OhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:37:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90FCF3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:37:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a6190af24aso1421570866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695825433; x=1696430233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwpuJVrljR01ya7iLJlB/BxIx7PRZ9f1GPx1GjjrYe8=;
        b=CB0kSKGE1LEf7lyPFVIftsYidBeIRG1yeDQmvYKyO20zvDTiS12n4xm8fAwjADlR1a
         +TJKz0dP/ED81YOtWnVGoSMYsfE66PkkUg7wdQH+Lu0xKBY1zYAqLMqIhSO4D2G6sq7j
         Xj5NIY1QUNp473KujQ9xWKfODPcRafTNftvkBzNVqNKO4/ObAal5/RXuIFCpJLqcDXox
         lia5vEAdYtVNV2wcwjVpY15L8Ap41xn2o6uLv9kIc3vBeEG0bloAqCUnRQ4bw0INNdrK
         LUqq01ICG+zZ7UkFEzGxax5aiq2QUZPR/0fR/MfMHzwUoyURAObdxib6K+gnaYBs/QZq
         DJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695825433; x=1696430233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwpuJVrljR01ya7iLJlB/BxIx7PRZ9f1GPx1GjjrYe8=;
        b=NmNTGCTR5NNUPKDFgOMLdGIOocYz8r30VoPGPyeqYp82/s3wffckBTV2TS2/Z0VYp4
         jZeqQ0QAy55oQPAKP/OrJqUAt9BErAnN5JqEO0BJxaPNbYU3hy+NVj8WageKL4s9Us/O
         1x/5KdZ0drCMJ8uWmjp1DrGl9owvAoQiBd+38rqfMT4nuW+gazpFfaFYZE5H7G0bg8tI
         aGiUujiWLHX8LaE/FmxTchgxR10vaKE0dsys61OL6inL7JENAlBeq/otf0B1zjGaMTd4
         JYOYpOz4P9BR9dZdVBLrVJKD6SXMoSUf+hyhC6JqrlApEH9Q6T4QP4GV+OGiG8RjYKl2
         1cwg==
X-Gm-Message-State: AOJu0YxJ9UxZmXsHXGHMygQ0+wHxPOdv695Cg46pIN0oVDodxd91/pRY
        LNtNaeZFSwn0+qhlbLaHzS1G6g==
X-Google-Smtp-Source: AGHT+IE24BySFabmbygoup96UaV3lWsfthbehjSORDi1CarIOCzrFCMCEesG7lkPLlYbBFWt6f/70Q==
X-Received: by 2002:a17:907:7611:b0:9a1:bd53:b23 with SMTP id jx17-20020a170907761100b009a1bd530b23mr2067824ejc.14.1695825433013;
        Wed, 27 Sep 2023 07:37:13 -0700 (PDT)
Received: from pop-os.localdomain (81-231-61-187-no276.tbcn.telia.com. [81.231.61.187])
        by smtp.gmail.com with ESMTPSA id k8-20020a170906a38800b0099bc2d1429csm9411039ejz.72.2023.09.27.07.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:37:12 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:37:09 +0200
From:   Joakim Bech <joakim.bech@linaro.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, tjmercier@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jianjiao.zeng@mediatek.com,
        kuohong.wang@mediatek.com, Anan Sun <anan.sun@mediatek.com>
Subject: Re: [PATCH 6/9] dma-buf: heaps: mtk_sec_heap: Add tee service call
 for buffer allocating/freeing
Message-ID: <20230927143709.hrytde34trrdhpwf@pop-os.localdomain>
References: <20230911023038.30649-1-yong.wu@mediatek.com>
 <20230911023038.30649-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230911023038.30649-7-yong.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:30:35AM +0800, Yong Wu wrote:
> Add TEE service call for secure memory allocating/freeing.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/dma-buf/heaps/mtk_secure_heap.c | 69 ++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/heaps/mtk_secure_heap.c b/drivers/dma-buf/heaps/mtk_secure_heap.c
> index e3da33a3d083..14c2a16a7164 100644
> --- a/drivers/dma-buf/heaps/mtk_secure_heap.c
> +++ b/drivers/dma-buf/heaps/mtk_secure_heap.c
> @@ -17,6 +17,9 @@
>  
>  #define MTK_TEE_PARAM_NUM		4
>  
> +#define TZCMD_MEM_SECURECM_UNREF	7
> +#define TZCMD_MEM_SECURECM_ZALLOC	15
This is related to the discussion around UUID as well. These numbers
here are specific to the MediaTek TA. If we could make things more
generic, then these should probably be 0 and 1. 

I also find the naming a bit heavy, I think I'd suggest something like:
# define TEE_CMD_SECURE_HEAP_ZALLOC ...
and so on.

> +
>  /*
>   * MediaTek secure (chunk) memory type
>   *
> @@ -29,6 +32,8 @@ enum kree_mem_type {
The "kree" here, is that meant to indicate kernel REE? If yes, then I
guess that could be dropped since we know we're already in the kernel
context, perhaps instead name it something with "secure_heap_type"?

>  struct mtk_secure_heap_buffer {
>  	struct dma_heap		*heap;
>  	size_t			size;
> +
> +	u32			sec_handle;
>  };
>  
>  struct mtk_secure_heap {
> @@ -80,6 +85,63 @@ static int mtk_kree_secure_session_init(struct mtk_secure_heap *sec_heap)
>  	return ret;
>  }
>  
> +static int
> +mtk_sec_mem_tee_service_call(struct tee_context *tee_ctx, u32 session,
> +			     unsigned int command, struct tee_param *params)
> +{
> +	struct tee_ioctl_invoke_arg arg = {0};
> +	int ret;
> +
> +	arg.num_params = MTK_TEE_PARAM_NUM;
> +	arg.session = session;
> +	arg.func = command;
> +
> +	ret = tee_client_invoke_func(tee_ctx, &arg, params);
> +	if (ret < 0 || arg.ret) {
> +		pr_err("%s: cmd %d ret %d:%x.\n", __func__, command, ret, arg.ret);
> +		ret = -EOPNOTSUPP;
> +	}
> +	return ret;
> +}
Perhaps not relevant for this patch set, but since this function is just
a pure TEE call, I'm inclined to suggest that this could even be moved
out as a generic TEE function. I.e., something that could be used
elsewhere in the Linux kernel.

> +
> +static int mtk_sec_mem_allocate(struct mtk_secure_heap *sec_heap,
> +				struct mtk_secure_heap_buffer *sec_buf)
> +{
> +	struct tee_param params[MTK_TEE_PARAM_NUM] = {0};
> +	u32 mem_session = sec_heap->mem_session;
How about name it tee_session? Alternative ta_session? I think that
would better explain what it actually is.

> +	int ret;
> +
> +	params[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +	params[0].u.value.a = SZ_4K;			/* alignment */
> +	params[0].u.value.b = sec_heap->mem_type;	/* memory type */
> +	params[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +	params[1].u.value.a = sec_buf->size;
> +	params[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT;
> +
> +	/* Always request zeroed buffer */
> +	ret = mtk_sec_mem_tee_service_call(sec_heap->tee_ctx, mem_session,
> +					   TZCMD_MEM_SECURECM_ZALLOC, params);
> +	if (ret)
> +		return -ENOMEM;
> +
> +	sec_buf->sec_handle = params[2].u.value.a;
> +	return 0;
> +}
> +
> +static void mtk_sec_mem_release(struct mtk_secure_heap *sec_heap,
> +				struct mtk_secure_heap_buffer *sec_buf)
> +{
> +	struct tee_param params[MTK_TEE_PARAM_NUM] = {0};
> +	u32 mem_session = sec_heap->mem_session;
> +
> +	params[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +	params[0].u.value.a = sec_buf->sec_handle;
> +	params[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
Perhaps worth having a comment for params[1] explain why we need the
VALUE_OUTPUT here?

-- 
// Regards
Joakim

> +
> +	mtk_sec_mem_tee_service_call(sec_heap->tee_ctx, mem_session,
> +				     TZCMD_MEM_SECURECM_UNREF, params);
> +}
> +
>  static struct dma_buf *
>  mtk_sec_heap_allocate(struct dma_heap *heap, size_t size,
>  		      unsigned long fd_flags, unsigned long heap_flags)
> @@ -107,6 +169,9 @@ mtk_sec_heap_allocate(struct dma_heap *heap, size_t size,
>  	sec_buf->size = size;
>  	sec_buf->heap = heap;
>  
> +	ret = mtk_sec_mem_allocate(sec_heap, sec_buf);
> +	if (ret)
> +		goto err_free_buf;
>  	exp_info.exp_name = dma_heap_get_name(heap);
>  	exp_info.size = sec_buf->size;
>  	exp_info.flags = fd_flags;
> @@ -115,11 +180,13 @@ mtk_sec_heap_allocate(struct dma_heap *heap, size_t size,
>  	dmabuf = dma_buf_export(&exp_info);
>  	if (IS_ERR(dmabuf)) {
>  		ret = PTR_ERR(dmabuf);
> -		goto err_free_buf;
> +		goto err_free_sec_mem;
>  	}
>  
>  	return dmabuf;
>  
> +err_free_sec_mem:
> +	mtk_sec_mem_release(sec_heap, sec_buf);
>  err_free_buf:
>  	kfree(sec_buf);
>  	return ERR_PTR(ret);
> -- 
> 2.25.1
> 
