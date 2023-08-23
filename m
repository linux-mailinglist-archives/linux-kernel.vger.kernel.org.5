Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BB5784FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjHWE7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 00:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjHWE7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:59:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE56E4A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:59:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c63cd4ec2so1030318f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1692766750; x=1693371550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZaDZO+v9MG56Hk5iDml8pLk4+3/ykfx331epWISZyM=;
        b=d16jqq2HnbhQHvSV2h6DfNUd0Y+F+yQ0b7M7C/d9RrDSO0GhCJd4uRo0Jo2tS/uyzC
         8IZXu8NKUlej4O30KKueOVtll6DYvKPDtYb3Pg9FKPq7T5/5e5bMLZZ66Y1UrTLW3ovp
         NNZIZK0EyngNrXx1mgVWWP0fV75vn2gMBk5Pv8zogwozpmqI6YSu58rqsrXkhYf2VYKd
         jnTxCdockbTL8G1NDwIKbnxdj8ugDPqKScO5+gbtfyoHwtiT5rck/d8RAn4JawsHIm0Z
         sWoFc0y8JIZz/58tJVx0vT3i91msvGWvKeGkd6AOmxKNLM5oRMxCUlHwQC4jNibWCYpl
         cd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692766750; x=1693371550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZaDZO+v9MG56Hk5iDml8pLk4+3/ykfx331epWISZyM=;
        b=b/BDk8JqSaJ0qD239hhfoXYVuhbwNqohsw5K9sm5utFDiq5xVEoPi27Z/NU27p6I+5
         HBcKctCce0lriMhJMjCXhvXguPEBFhoeW7m0tkQ6PIbYp8HTc2Uj84dGTQiiDdYKMGMs
         YAdkECu1oi0hKvnM+EBkhj+DRyhnbzjSkpQvU9+9aVR5rhxtT02A3tRZyF/C3bq3l2fa
         cDHdoUEv2zcCUY7GbQ5vcLXzGbTu4VzEQKC5pDLvehFN4RX/+2k0ENC/hMTK1u3h3Gys
         Jih85lFNqtKppY2LREqTGmJn/MG5l1OsXLhJT+zvjbJb40YVEhkO8hAJS3oiLq2n4e97
         cyCw==
X-Gm-Message-State: AOJu0YxTGtutlRraKkpmppFnRlkzIzY295ky4l8Zg2KKYT0Uv87ohZOJ
        XLaGV0eeqHJAdHfC9uXS7T1sDw==
X-Google-Smtp-Source: AGHT+IF6wT5V6T7EB1mYVkojEC/SkS1mcOnC7jSw0mHdobHGbBcN78NnKG+2UwwFBBmGZgvVKOowEA==
X-Received: by 2002:a5d:6382:0:b0:319:8bd0:d18c with SMTP id p2-20020a5d6382000000b003198bd0d18cmr7788581wru.52.1692766750235;
        Tue, 22 Aug 2023 21:59:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.1])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d6081000000b0031773e3cf46sm17505270wrt.61.2023.08.22.21.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 21:59:09 -0700 (PDT)
Message-ID: <5663e3e6-de16-e9ba-0745-b9a40676b109@tuxon.dev>
Date:   Wed, 23 Aug 2023 07:59:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] pwm: atmel: add missing clk_disable_unprepare()
Content-Language: en-US
To:     Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230822070441.22170-1-Hari.PrasathGE@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230822070441.22170-1-Hari.PrasathGE@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 10:04, Hari Prasath Gujulan Elango wrote:
> Fix the below smatch warning:
> 
> drivers/pwm/pwm-atmel-hlcdc.c:167 atmel_hlcdc_pwm_apply() warn: 'new_clk' from clk_prepare_enable() not released on lines: 112,137,142,149.
> 

Can you add a fixes tag?

> Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index 96a709a9d49a..ce46f6c74a14 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -108,8 +108,10 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>  						 ATMEL_HLCDC_CFG(0),
>  						 ATMEL_HLCDC_CLKPWMSEL,
>  						 gencfg);
> -			if (ret)
> +			if (ret) {
> +				clk_disable_unprepare(new_clk);
>  				return ret;
> +			}
>  		}
>  
>  		do_div(pwmcval, state->period);
> @@ -133,20 +135,27 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>  					 ATMEL_HLCDC_PWMPS_MASK |
>  					 ATMEL_HLCDC_PWMPOL,
>  					 pwmcfg);
> -		if (ret)
> +		if (ret) {
> +			clk_disable_unprepare(new_clk);
>  			return ret;
> +		}
>  
>  		ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_EN,
>  				   ATMEL_HLCDC_PWM);
> -		if (ret)
> +		if (ret) {
> +			clk_disable_unprepare(new_clk);
>  			return ret;
> +		}
>  
>  		ret = regmap_read_poll_timeout(hlcdc->regmap, ATMEL_HLCDC_SR,
>  					       status,
>  					       status & ATMEL_HLCDC_PWM,
>  					       10, 0);
> -		if (ret)
> +		if (ret) {
> +			clk_disable_unprepare(new_clk);

Can you keep a single failure point for all these?

Also, you have to set chip->cur_clk = NULL otherwise next time your apply
will get executed the new_clk will not be enabled.

Thank you,
Claudiu Beznea

>  			return ret;
> +		}
> +
>  	} else {
>  		ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_DIS,
>  				   ATMEL_HLCDC_PWM);
