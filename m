Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4FD789616
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjHZKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHZKte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:49:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500B22110
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:49:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bce552508fso25598271fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693046968; x=1693651768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lqvr23FFPcSYnIDpllCI1BC3DDx5xJk3OtR+XX356M=;
        b=N4vJ31QHqX29zQIF3aRtNRkG0Ej+UlHAuJd7uWGxtfs031GO0FYTcpsTzNBq7BFTEz
         15uHbNDQesdgQa6cmffmeSAQXGBr/uH6JgyoMXVynmh3mN2NBSo0nixe1xUAwOBmHd1b
         qkZrFXWSUYGJjOn2sfOiNxyWvVFhtrjjIn0/IQdMF8wjh1BEWOqr60kqOPs6mM6Ve+6Q
         VUK2bBXh2IwngoWdgT68iqMcW8qMGgRRn4FLsAbVtW9yZ9SqTAdumghQl61LFqk1xE8x
         E5a/l/aaZI544mXSYrV+dMNCtbp/jXRnvjy34B5G+03ZiyJAqgYyjWRsVOGgRRxckbph
         tn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693046968; x=1693651768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lqvr23FFPcSYnIDpllCI1BC3DDx5xJk3OtR+XX356M=;
        b=NnOXYDEM/Pd8Nz6QAxItuz7npPs5v/CM46DEf+YGzoGDhn0NZ/w6BPfgqW1bAL3jKE
         uPfV348cF/9jZY1TbyUHh7ebQEsA6YewYd1fTVRe+1Ph4b46ey1NCdOKa5RaXB5/SKek
         L5iY8m0qmgYz+7TxXwqW9vL7cSqLUU35cCbDTNot1L5RbTV9QuD6kZa+1zrDBBZPT6AS
         9NyDks7DCskERb/qfp3VUggxL4KuCGmNub0kP5Z6hnZEeSfULxS71ANUJeZqFG8OKkl+
         VgwEjRpSr/DEBTA5aZfes5Mxpyo6Ey+9df4scyOwvfes8YT6aYVi982GEHy+ETJsq7cK
         CQbw==
X-Gm-Message-State: AOJu0Yw5INgJaY/+KCapht/q1WteysR6ITl+DWMtX5xCVTSion+682H5
        cJuEYZxTo9wDIWgczZmA8LUi9Q==
X-Google-Smtp-Source: AGHT+IFzZwrpN2SUzyqWq4RHjYYCjMwR4/3kpyqzubM8/jmF8NrOBbpauF53K3ZZJa2GchZZ2/evTw==
X-Received: by 2002:a2e:a4b4:0:b0:2bc:feb6:6da4 with SMTP id g20-20020a2ea4b4000000b002bcfeb66da4mr1144871ljm.33.1693046968423;
        Sat, 26 Aug 2023 03:49:28 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id v3-20020a2e9f43000000b002b6e15ccf88sm733615ljk.135.2023.08.26.03.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 03:49:28 -0700 (PDT)
Message-ID: <f9df2e02-9fae-4e16-9412-d378ef168903@linaro.org>
Date:   Sat, 26 Aug 2023 12:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: misc: eud: Fix missing IRQ check in eud_probe()
Content-Language: en-US
To:     Zhang Shurong <zhang_shurong@foxmail.com>,
        quic_schowdhu@quicinc.com
Cc:     agross@kernel.org, andersson@kernel.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_C40B301A0F71853A540809BE1BB85AB12D07@qq.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <tencent_C40B301A0F71853A540809BE1BB85AB12D07@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.2023 12:47, Zhang Shurong wrote:
> This func misses checking for platform_get_irq()'s call and may passes the
> negative error codes to request_irq(), which takes unsigned IRQ #,
> causing it to fail with -EINVAL, overriding an original error code.
> 
> Fix this by stop calling request_irq() with invalid IRQ #s.
> 
> Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded USB Debugger(EUD)")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/usb/misc/qcom_eud.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> index 7f371ea1248c..b33c615a2037 100644
> --- a/drivers/usb/misc/qcom_eud.c
> +++ b/drivers/usb/misc/qcom_eud.c
> @@ -204,7 +204,12 @@ static int eud_probe(struct platform_device *pdev)
>  	if (IS_ERR(chip->mode_mgr))
>  		return PTR_ERR(chip->mode_mgr);
>  
> -	chip->irq = platform_get_irq(pdev, 0);
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->irq = ret;chip->irq = plat..
if (chip->irq < 0)
	return chip->irq

?

Konrad
