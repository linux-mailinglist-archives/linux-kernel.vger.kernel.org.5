Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7B7F74E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjKXN0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKXN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:26:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17B10C6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54b07ba599eso387137a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700832394; x=1701437194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XG6ADxvx2SdIyRMBAz8RKdfu+PYmXUoQcvqXhk8eodM=;
        b=hVSHqaM/h1lXrC/Kj3GqLMk7Cwztp7Xhf6hCkTtPhmRGeRCuatrV65yZMRcFYkFe2m
         cidyH4bEfcW+K2Vb/HTfbhzblY1XWapBI4XsTLVg7X+YGf9blYF0Zik9W2Bv2hjx/Q3N
         NRg1pwyFA+YntR2HZOCDMIBCsM2SUBwK+A7zAvK4cq0QDQWmq9uPI82gxt6YTIDcNJie
         sL7p92JL5MKVHgXuzZKA5potKJtAIWZjRZ83boPQgSWy24ebojvbQRPHIm7hMqxJ4TUc
         vWZTkk8I1x/XXCjQP+kWIKZpvXsUMeOAlwIhZYSviosiBYZONhbmSCNJT9d9UotF3JsD
         edlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700832394; x=1701437194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XG6ADxvx2SdIyRMBAz8RKdfu+PYmXUoQcvqXhk8eodM=;
        b=udO5HusYyVESo6sVqrjqYwxWxI515WipLjX7CB//vTtIz/5gRvC2LlI+rqpxfb5OaR
         L5gtWIAZsRUqNf2wFwrF7+xBGBWyPdLHKYHTs87yEnGczE8hjQLdrKKwunyeGioYBmib
         u9NmcHzHPFX2VTWVxuOeNHhUXCZsT4znTe2N4KfsePz3XWaG0zLamTMgvKHOL+6Sper8
         YLYOQ3oheNR3w+9f3qzCWJByObkTiYp/DzXoGjxR4piE11Sn568j25WrwzzoV/8zb4K2
         gcOiKss7A1vNtkv6dirz0hUS4mnRxVHryIDHBRoWK9oUtmdVV1Iqms7u4DprCApTIS3e
         FX0g==
X-Gm-Message-State: AOJu0YzRWqPjee8tvgtelhfjVcWUnae3B3cFkULfr772hCovJWay9Ih9
        PWLi4rsYxMSSKZfjX3K8zqrkbS/nkKnzUrJxXlQ=
X-Google-Smtp-Source: AGHT+IGToWgMbWtNgAJ4UDGie72Pp8L21PKV0u4mYSlFioL3UdiJi/XQcPo7DTeHDymqZ1l/YeU9bA==
X-Received: by 2002:a50:ef11:0:b0:54b:f6:fb23 with SMTP id m17-20020a50ef11000000b0054b00f6fb23mr1174153eds.23.1700832393823;
        Fri, 24 Nov 2023 05:26:33 -0800 (PST)
Received: from [192.168.86.103] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o26-20020a056402039a00b005487c48d9ebsm1793399edv.57.2023.11.24.05.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:26:32 -0800 (PST)
Message-ID: <b56f7a00-f5e0-4cc7-ad04-33b4981e14b7@linaro.org>
Date:   Fri, 24 Nov 2023 13:26:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] misc: fastrpc: Add support to allocate shared
 context bank
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20231121094844.5764-1-quic_ekangupt@quicinc.com>
 <20231121094844.5764-6-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231121094844.5764-6-quic_ekangupt@quicinc.com>
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
>   static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
>   {
>   	struct fastrpc_enhanced_invoke einv;
>   	struct fastrpc_invoke_args *args = NULL;
>   	struct fastrpc_ioctl_multimode_invoke invoke;
> +	struct fastrpc_internal_control cp = {0};
>   	u32 nscalars;
>   	u64 *perf_kernel;
>   	int err, i;
> @@ -1938,6 +1975,12 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
>   		err = fastrpc_internal_invoke(fl, false, &einv);
>   		kfree(args);
>   		break;
> +	case FASTRPC_INVOKE_CONTROL:
> +		if (copy_from_user(&cp, (void __user *)(uintptr_t)invoke.invparam, sizeof(cp)))
> +			return  -EFAULT;

wow, this struct is not even exposed in a uapi header, how come 
userspace knows about this struct?

Every struct that userspace fills in needs to be part of the UAPI headers.


--srini

> +
> +		err = fastrpc_internal_control(fl, &cp);
> +		break;
>   	default:
>   		err = -ENOTTY;
>   		break;
> @@ -2440,6 +2483,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>   	if (sessions > 0) {
>   		struct fastrpc_session_ctx *dup_sess;
>   
> +		sess->sharedcb = true;
>   		for (i = 1; i < sessions; i++) {
