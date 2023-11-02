Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59377DF75E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376842AbjKBQHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjKBQHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:07:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CFB12E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:07:00 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a98517f3so1334068e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698941219; x=1699546019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8E6OeBpp2Nw5yhR7KvCSLiTOkbzsJNh7XdGehlNCap0=;
        b=w0kV1cxgdO6Q2demWTudaTzokyjn1ExUzSDzkEwkqdusoBP6MP95FESayN/+FXPN+o
         NvQwtP8N5n9c/g6VAXa9WPkptzmVIAkIhEpr1U93wkq8//1eRAezfKghABvsQ9sWU/Xb
         5jVmEnEwk8Gik39D46Pw7rXIzRnrF4aCb2YEz+ghgoNJ30gPx8xEqS6bY1cnCYA43keu
         yVHPufrV5Xd8jJe3kOIpFbkgv1W0qqS64v8KVZ8AcRnb6f/4ydUkYnHY+VGk1iv1mA7M
         FZ4w1IJFNChn/mQN+HbRilUC55qeF+av0KgnYkvJACARtqywU9B/3arNuDi3ZJ32MHpz
         YKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698941219; x=1699546019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8E6OeBpp2Nw5yhR7KvCSLiTOkbzsJNh7XdGehlNCap0=;
        b=Avji2+JIj2XXVmOZUW19mObdFQaGQHEgtmn7vOTIkUiYu3qVcaUWFf6u8Urd3YnHLK
         KTERU56E7CN9+jZcY6tJR7NFeT+C6mFN/0QMfJXd/VaIhsNxn/vgqOixO+ZHfcAWlDuL
         JrsR0qangd8oEZfB9wVfPMhxHyEkeNcwjMx+0Q+TzPnVDVR72YCQemVsMZxTk0G/ga6f
         zlHBxpNFQijzZsKP3EnO0mqbPzvlzhMF+6fFbY7gFvWt68yfeLgBXbxVxDjIUwTLU5wx
         bNFYSucL+lkWzHGCPLNfLf2DRWfB+Tzy390m0xvCDXuXZyfc+U3h/YPXyZNAFYdsYCW/
         26XA==
X-Gm-Message-State: AOJu0YxMOaGIyuLIfseu8byaQi6kP2HoSRR6yKpcuXMgDsH3c7HbQ7lv
        yKXoVSnmP7k//Ow6kqao3vWfWA==
X-Google-Smtp-Source: AGHT+IERusrAEl2wCCk+nZGgKzy1aZ+jO07Yst4DCgg7p/Ws1QjPmha88uJz6Mc/GI2rpyEOhAAyaQ==
X-Received: by 2002:a05:6512:48d1:b0:500:bf33:3add with SMTP id er17-20020a05651248d100b00500bf333addmr13431425lfb.47.1698941218773;
        Thu, 02 Nov 2023 09:06:58 -0700 (PDT)
Received: from [192.168.67.140] (92.40.204.238.threembb.co.uk. [92.40.204.238])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d4903000000b0032d8034724esm2793705wrq.94.2023.11.02.09.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 09:06:57 -0700 (PDT)
Message-ID: <ba16e523-82cf-47a3-8ed3-24ef116faf66@linaro.org>
Date:   Thu, 2 Nov 2023 16:06:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: misc: eud: Add IRQ check for platform_get_irq()
Content-Language: en-US
To:     Chen Ni <nichen@iscas.ac.cn>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231102075113.1043358-1-nichen@iscas.ac.cn>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231102075113.1043358-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2023 07:51, Chen Ni wrote:
> The function eud_probe() should check the return value of
> platform_get_irq() for errors so as to not pass a negative value to
> the devm_request_threaded_irq().
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/usb/misc/qcom_eud.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> index 7f371ea1248c..26e9b8749d8a 100644
> --- a/drivers/usb/misc/qcom_eud.c
> +++ b/drivers/usb/misc/qcom_eud.c
> @@ -205,6 +205,9 @@ static int eud_probe(struct platform_device *pdev)
>   		return PTR_ERR(chip->mode_mgr);
>   
>   	chip->irq = platform_get_irq(pdev, 0);
> +	if (chip->irq < 0)
> +		return chip->irq;
> +
>   	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
>   			handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
>   	if (ret)

-- 
// Caleb (they/them)
