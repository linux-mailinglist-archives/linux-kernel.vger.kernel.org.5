Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9B76CEEA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHBNhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjHBNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:37:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10752690
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:37:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2bc2701bso15123905e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690983460; x=1691588260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vGRb18JT1B3IoPWFshCBAs1d3mrRij7dJ3Ogr4/w9Y=;
        b=ON2+EQ3hpjmmU3SIBE1+TMjLwgH3Im7aSKfMZ8W1/nyVJp7bEgvTb66ycR7e2pDovV
         Nr4e+ZY/fb5zqWv4W26AFk2aOyHJ+/TJaAqqgnW2RhbBGLp7MVCsodAXd/uY9vgKCx4H
         fGclw+npz0jJKdWrpJwTly+mo9MMaceV+qlFqFVdxfOGzuJSM6OlE93osB7R8G6EBHnN
         rfBNcvLZlQn/Or9/iDz3N8sv4QDDtjQf2TEnKj5K7jKE87dKM5PH6Um/8Spv+H6mzSPM
         Zwf+sQzBOmiGziDW2U0RRKqAFfP3CyvIIIFebHC8wAyQmDtCLJ0FORD707YxIZRFCosV
         9Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690983460; x=1691588260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vGRb18JT1B3IoPWFshCBAs1d3mrRij7dJ3Ogr4/w9Y=;
        b=U+Xw5dKHg7s6EcsmM0BAM1jym7L1VTcWAdpca6TA1gyrZ4ErHdVKMfQ6qQ2Q8cdO0I
         KiXkdJc7Lmw7kATgddTHRVWWYJsZrNNHuJeEBawve2bI6EFXEMZCBU2xMCZubrxl66dW
         vnLtPHoMZexdb+6/ij+dgxhLx15KROo7vwax4X7gs+Kl7PMzDgnkZqSCru3U2We7Fy8O
         /NaucbZ+XkG0QYeASl9JJIjj6m4azeTZetXV71c1DKH+uUsR3QrnQNr5mIKBy0VeakiP
         2hiEACj3eijIbx2Nx0tEzKuZZcakkrvXbdDe9TtSYlIbz2wdh1RDZD0wgfzWusfRNK2H
         UXZg==
X-Gm-Message-State: ABy/qLYnBhc9uJBMbbhLTyENy1lMziuu/s40OMUA2VKLv6wDmT3poD+j
        O0/DvYzo6pa8gyOGlEn7hYnbUQ==
X-Google-Smtp-Source: APBJJlE/NjGY+wFY7wdiY/lQ8FrZiSBeH3t9hUzmY/vT1xIxZGOmm8taQwuVA3w1OmG/ZD57pjHnuQ==
X-Received: by 2002:a7b:c4d9:0:b0:3fe:1a58:6203 with SMTP id g25-20020a7bc4d9000000b003fe1a586203mr4817498wmk.34.1690983460172;
        Wed, 02 Aug 2023 06:37:40 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k10-20020adff28a000000b00311299df211sm19117714wro.77.2023.08.02.06.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 06:37:39 -0700 (PDT)
Message-ID: <1dfd407d-2c75-0154-947a-3f1783017444@linaro.org>
Date:   Wed, 2 Aug 2023 14:37:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] misc: fastrpc: Pass proper scm arguments for static
 process init
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        stable <stable@kernel.org>
References: <1690952549-31819-1-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1690952549-31819-1-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2023 06:02, Ekansh Gupta wrote:
> Memory is allocated for dynamic loading when audio daemon is trying
> to attach to audioPD on DSP side. This memory is allocated from
> reserved CMA memory region and needs ownership assignment to
> new VMID in order to use it from audioPD.
> 
> In the current implementation, arguments are not correctly passed
> to the scm call which might result in failure of dynamic loading
> on audioPD. Added changes to pass correct arguments during daemon
> attach request.
> 
> Fixes: 	0871561055e6 ("misc: fastrpc: Add support for audiopd")
> Cc: stable <stable@kernel.org>
> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
> Changes in v2:
>    - Removed redundant code
> Changes in v3:
>    - Reuse channel context perms for source perms
> 
>   drivers/misc/fastrpc.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 30d4d04..5a1268f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1280,8 +1280,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   		if (fl->cctx->vmcount) {
>   			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
>   							(u64)fl->cctx->remote_heap->size,
> -							&fl->cctx->perms,
> -							fl->cctx->vmperms, fl->cctx->vmcount);
> +							&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);

this change does not look correct,  Looks totally like converting 
multiple lines to a single line.

--srini

>   			if (err) {
>   				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
>   					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
> @@ -1322,13 +1321,18 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   	return 0;
>   err_invoke:
>   	if (fl->cctx->vmcount) {
> -		struct qcom_scm_vmperm perm;
> +		u64 src_perms = 0;
> +		struct qcom_scm_vmperm dst_perms;
> +		u32 i;
>   
> -		perm.vmid = QCOM_SCM_VMID_HLOS;
> -		perm.perm = QCOM_SCM_PERM_RWX;
> +		for (i = 0; i < fl->cctx->vmcount; i++)
> +			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
> +
> +		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
> +		dst_perms.perm = QCOM_SCM_PERM_RWX;
>   		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
>   						(u64)fl->cctx->remote_heap->size,
> -						&fl->cctx->perms, &perm, 1);
> +						&src_perms, &dst_perms, 1);
>   		if (err)
>   			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
>   				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
