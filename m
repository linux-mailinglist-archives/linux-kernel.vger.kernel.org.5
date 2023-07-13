Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17767521DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjGMMuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjGMMub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:50:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD7026BB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:50:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-314172bac25so791177f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689252596; x=1691844596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlKO0SkCIkcJEbFS4rnnF3znx3GAgy31FTGppc3TLOQ=;
        b=qHyTuFc2CS8qK1Z+yLbMDWJk47SUNkFJUdjIJesgBy5wDzVqVAHjBxIkpFCVwhc/Pj
         mahAfx+GhF00qgnTtNfqsfrlMIvfbFX84moj5lm6bcR5vwD0E9v07DzmWqivGum3UVXg
         Lq5kHHXSVZt57DhTLLzWZv4cFgKHbCHz7vdutnjanTphoHG9wpCi34itEWMxQ3a1oP/z
         BdXheNgdlmGQmCjaT+ewfOvX80vnnp+AweCa4ZeNMRBK1eQfWNeSMBQcwz5sf77xSQlV
         ll3fxA0Ve9suiy/5k4FrSw53JeqIsxdAi2dyvkP4N2SxEJU+qGbARRQH0Pe1yx00KFOq
         FeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689252596; x=1691844596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlKO0SkCIkcJEbFS4rnnF3znx3GAgy31FTGppc3TLOQ=;
        b=EkuSrb9/1i71NuKRK5Up2TPjFKJRAPhA9mUK/x2SYvJBgakAFDGckY8U6uugAyEDVt
         A4CO+4UmPxqhX5JkmzjkhNhQDHhveui+Hu0K5J9g7Rm+JbEnLBjt34LEDqyZr3OkfPm2
         LVeLjd/xre2Dc/aEQz2NmzkA0uiZtC6R0zuPKKaV8sWTLCaHDPU66WsG6VFGEzu8qi6D
         H8D/0cNUhuLmIUsquOzn2bBHfxT+GkGDJE8BFNz/6pZOOCLyXBR97T3p9+Szf11UD3dT
         wkteczjk5etQ3rNXa8g2LEJhI+9W61hSgsFAh6flV5NuomVOwTTRjZMPGkpLMA17OyFP
         be+g==
X-Gm-Message-State: ABy/qLZnwEIPYnbynaoEW38hjYLCWoi3RxrHMAv6lpdyftt4/NT6zZv5
        qLKBxKqO6lchgBK+CQHSBirI2g==
X-Google-Smtp-Source: APBJJlEZx0FfmTK4X0qxghvM7QrHXfKRrD0+SjmR/ECt5xZdi3FfvkbPU+pWO9gWdk9n2vdXdbJIwg==
X-Received: by 2002:a5d:5962:0:b0:314:31d5:2c3d with SMTP id e34-20020a5d5962000000b0031431d52c3dmr1477988wri.39.1689252595749;
        Thu, 13 Jul 2023 05:49:55 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g12-20020a5d46cc000000b0031455482d1fsm7916964wrs.47.2023.07.13.05.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 05:49:55 -0700 (PDT)
Message-ID: <f1d4ed62-8d01-173f-6e41-4671228782fd@linaro.org>
Date:   Thu, 13 Jul 2023 14:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when
 SCFW turn off resource
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     imx@lists.linux.dev
References: <20230712210505.1536416-1-Frank.Li@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230712210505.1536416-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 23:05, Frank Li wrote:
> Avoid endless print following message when SCFW turns off resource.
>   [ 1818.342337] thermal thermal_zone0: failed to read out thermal zone (-1)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/thermal/imx_sc_thermal.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> index 8d6b4ef23746..0533d58f199f 100644
> --- a/drivers/thermal/imx_sc_thermal.c
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -58,7 +58,9 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>   	hdr->size = 2;
>   
>   	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> -	if (ret)
> +	if (ret == -EPERM) /* NO POWER */
> +		return -EAGAIN;

Isn't there a chain call somewhere when the resource is turned off, so 
the thermal zone can be disabled?

> +	else if (ret)
>   		return ret;
>   
>   	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

