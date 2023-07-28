Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB73766AED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjG1KnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjG1KnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:43:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7DEE2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:43:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so21019245e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690540991; x=1691145791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qcpfuVCMGDrdLqRszLnxUe+cmtYNnFPz1CO5kAvPCs=;
        b=Kn6Eyadxs5TmmhGXwtb2w2a2hKu6nRGDFNi6ofLv7Xgs8evLF31c91xaW7GyFKUX7s
         jKu2Yyo5YVqCloaGb9MCzYdczP5wdQZCSkuGie0dZfEMrsyenb9T5+cxj6HhyQaoKyDX
         rEY4no0pvlXHpqS2QP1aKXenrorcxiyH805yfNxJj3h9k4IGxX9hcE5eOYzzesZ50e24
         VjLKT7Ae8gptBbuOzclb2NWFgYiLsWl0GEDPvpo7mZ7ujBDtU2Y35RtFTccvGvCJZgW2
         74uB+wM8alrGnGQdE0vEIWgIOACpboQ2q4S/qWPAzNgVRlqq+V4WLP6GWTjrwBgkA32r
         Q7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540991; x=1691145791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qcpfuVCMGDrdLqRszLnxUe+cmtYNnFPz1CO5kAvPCs=;
        b=TT+ofDdOyD4eDsTHtGKh3lxaR1SuoxZ+cH8VDjnvtCaP7+At2+sx7eR/e4ndMELCpZ
         0L6PCSp6NRsNlJtZfy91zrzyxMg6usQeYO76/fFBOk/0f22LPXEubqe/S6mD0FkVXg+/
         QBq7CME16VUJ2dnCgMri8sxZS7mK74bOQtWzSgNcXXrsoOtLN5XOGZfOvne9SoKKigig
         EzNtZqm2m9h8IgCLCAEQe2ChJjmloZtFvdIzL7YQIhcS28aIK6NGKXJyoczkiaRyLscY
         /97lJe5QA4XQE2uAHdrr1ruLvzRItZkToiPap6Sa5VACgRDkRk3kydCyOEdTcMYtKl5t
         WprA==
X-Gm-Message-State: ABy/qLYOGRr66eYSHvxAzOA7Cqqrkn5zIdlfB3uly4ts2uAKK7QG++PN
        mTpxVsnGwBWRpSqQCUwcuKjmTg==
X-Google-Smtp-Source: APBJJlEJ4WGtWvMTHhF0N6xAI1lu6JltQyIEQMdnAl9JSRk+TAhydjZrfGGMjQeFXtiuF+iigEWRLQ==
X-Received: by 2002:a7b:ce07:0:b0:3fe:e1e:5041 with SMTP id m7-20020a7bce07000000b003fe0e1e5041mr889214wmc.32.1690540991684;
        Fri, 28 Jul 2023 03:43:11 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id l14-20020a1c790e000000b003fbc9371193sm3897602wme.13.2023.07.28.03.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:43:11 -0700 (PDT)
Message-ID: <6a9cc326-06ea-dfce-6a48-043fd7ba0d50@linaro.org>
Date:   Fri, 28 Jul 2023 11:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] misc: fastrpc: Fix DSP capabilities request
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        stable <stable@kernel.org>
References: <1687328900-3039-1-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1687328900-3039-1-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/06/2023 07:28, Ekansh Gupta wrote:
> Incorrect remote arguments are getting passed when requesting for
> capabilities from DSP. Also there is no requirement to update the
> PD type as it might cause problems for any PD other than user PD.
> In addition to this, the collected capability information is not
> getting copied properly to user. Add changes to address these
> problems and get correct DSP capabilities.
> 
> Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
> Cc: stable <stable@kernel.org>
> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 30d4d04..776c596 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1693,9 +1693,8 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
>   	args[0].length = sizeof(dsp_attr_buf_len);
>   	args[0].fd = -1;
>   	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];

<--snip
> -	args[1].length = dsp_attr_buf_len;
> +	args[1].length = dsp_attr_buf_len * sizeof(uint32_t);
-->
>   	args[1].fd = -1;
> -	fl->pd = USER_PD;

this looks fine.
>   
>   	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
>   				       FASTRPC_SCALARS(0, 1, 1), args);
> @@ -1723,7 +1722,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>   	if (!dsp_attributes)
>   		return -ENOMEM;
>   

<-- snip
> -	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
> +	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);

-->
Before this change we passed a value which is already multipled now we 
pass a value that will be mulitplied inside fastrpc_get_info_from_dsp, 
both will work, but I dont see any value in doing this change.


>   	if (err == DSP_UNSUPPORTED_API) {
>   		dev_info(&cctx->rpdev->dev,
>   			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
> @@ -1776,7 +1775,7 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
>   	if (err)
>   		return err;
>   
> -	if (copy_to_user(argp, &cap.capability, sizeof(cap.capability)))
> +	if (copy_to_user(argp, &cap, sizeof(cap)))

Can you explain this change, and what is it fixing exactly?

--srini
>   		return -EFAULT;
>   
>   	return 0;
