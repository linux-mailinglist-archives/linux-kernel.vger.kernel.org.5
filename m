Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AABA768C85
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGaHBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjGaHBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:01:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C9187
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:01:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1419250a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690786861; x=1691391661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IojnIhTxwDoiGRw6GG+eJSBPl+3xl09aBo0KzjuVzS0=;
        b=oLm22SxCaphI5C9ydJ7XHKfuqylUyeM1W6tZyJW0BOAFrz7UdMUfqoRNQYY4qlFF2h
         nvxwBTiC7oAhyoq7sBryMh1IeFP+NBhkta+oKZm4e1a4S9LSZGSria3+spRv5DEcpJ4M
         /K8jay5Rmupd6P5zhXwXyJmRQD5BvqwR3gjGAYxzKHVQKAqM/hI15sMRiLqYb6IMJK54
         VglqUvnB4KYCQl7/uVTFBZLWIQ9BSj39Bi//cBnwYK2FGlmV12iVOh+szC5glLZf9zz/
         j/N8+DSbzud3An7Gg2w5+Sms06TnvovZtLbW24Kth0ydtYRUJRq5wcFDoMwY6HMccXXn
         Sw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690786861; x=1691391661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IojnIhTxwDoiGRw6GG+eJSBPl+3xl09aBo0KzjuVzS0=;
        b=T4ahBQsZ3CcGruATHPhECajOR7vI+ten0vvWBEXMC9VgfDaN9k/pRFURf2sB1lgsvj
         StH/Xf23LqzqsVXUIwE7oKGinyCzAHaTkJ5NDQAqknuR9d1QEYKIQSzWbBRvvnflLBx0
         R2kUevydr/4Nj/WM2uq405vb8btxWupOXW2aFLxErDcpMJZ4jgoJyyNE6vFqCxenUvyj
         VhEptFj/POEdEUOMNt1nkuoWitcDcqZfn3vWbdLDqIYVAgj7wkgK/UvEbfeWOdqJ3tVR
         texClgnkyRX3hETcJPA47vo1jlVjeaL2REyf9znC5r7qBz245269f+Cv81C8FuBM2AVz
         8ojQ==
X-Gm-Message-State: ABy/qLbaEzZ5jrNZY+BPSG+8FIyxo4KnfcfLnpffg5ZkkrrcSybHhb9p
        eieZaLDzTcLRUqovDHRCbsoGRKRopRkIFrGLZ5w=
X-Google-Smtp-Source: APBJJlH3FTTDgMYbDFJtYuSq2IGsUBxUZNnUhWxs0tXcd+LbJGecLN+M+i5aP2q+etOOS7MVfh6UtA==
X-Received: by 2002:a05:6402:1a27:b0:522:45db:48e1 with SMTP id be7-20020a0564021a2700b0052245db48e1mr7521041edb.31.1690786841216;
        Mon, 31 Jul 2023 00:00:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id u18-20020aa7d0d2000000b0051e0f21c43fsm5128339edo.31.2023.07.31.00.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 00:00:40 -0700 (PDT)
Message-ID: <a037a8d3-9ba4-80ee-b34e-9a795ebb6e5b@linaro.org>
Date:   Mon, 31 Jul 2023 09:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 6/8] soc: qcom: socinfo: adjust the position of QDU1010
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731061325.26431-1-quic_tengfan@quicinc.com>
 <20230731061325.26431-7-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731061325.26431-7-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 08:13, Tengfei Fan wrote:
> Adjust the position of QDU1010, so that QDU1010 have
> same sequence with QCOM_ID_QDU1010 in bindings file.
> 
> Change-Id: I86d46eca55e877aaa1fd948db99b41ae138a3129

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

> ---
>  drivers/soc/qcom/socinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 4d49945b3a35..ad7699b401a8 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -405,8 +405,8 @@ static const struct soc_id soc_id[] = {
>  	{ qcom_board_id(SA8775P) },
>  	{ qcom_board_id(QRU1000) },
>  	{ qcom_board_id(QDU1000) },
> -	{ qcom_board_id(QDU1010) },
>  	{ qcom_board_id(IPQ5019) },

Same comment as on previous patch.

> +	{ qcom_board_id(QDU1010) },

Best regards,
Krzysztof

