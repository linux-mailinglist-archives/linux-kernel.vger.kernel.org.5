Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE20B7908AE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjIBQ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjIBQ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:28:09 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3521B1
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:28:00 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id cTTUqh7ZQvfOmcTTUqnjtX; Sat, 02 Sep 2023 18:27:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693672077;
        bh=4XtuIWSviDK6Xb8Nwzb/+qJ7KwlLHCWgjDlVm/xkup4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=miaUG0KZP4W5WoMemGjH1/U6E5csb/GdcMglTx8F7IkBa416UNOnsxCR9v3jCO1kW
         tzOVX9SeSnPbQVYMGgXRB1GAonegDqXw6+aOqXKct8vOljmhwOxoz1f2foNHnwLXkh
         dTObtlaINTrUW5sXZt6kecX0/iz3fNfPDAEdmNsPMmAIbQdrubwo5iQDq2dbGleZcP
         o4Z2JuLq/sUDQW7KaVMInvFF+oVVzrMKCvC9AcGNj9S6gnBebMTCSNHpr4CBJO8i3n
         aPGlfwIUNbGVa4fe1x2/Xx0odXhUzrDf9Go+rtWo97Ewx046LYbCEygnv9w+C1SXlw
         Ie5EBYUNyHqbg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Sep 2023 18:27:57 +0200
X-ME-IP: 86.243.2.178
Message-ID: <f15da804-206b-be53-b59e-06a3edfa0e96@wanadoo.fr>
Date:   Sat, 2 Sep 2023 18:27:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] pwm: atmel: add missing clk_disable_unprepare()
To:     Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230902063232.22620-1-Hari.PrasathGE@microchip.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230902063232.22620-1-Hari.PrasathGE@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/09/2023 à 08:32, Hari Prasath Gujulan Elango a écrit :
> Fix the below smatch warning:
> 
> drivers/pwm/pwm-atmel-hlcdc.c:167 atmel_hlcdc_pwm_apply() warn: 'new_clk' from clk_prepare_enable() not released on lines: 112,137,142,149.
> 
> 'Fixes: 2b4984bef47a5 ("pwm: atmel-hlcdc: Convert to the atomic PWM API")'

Hi,

There shouldn't be ' before Fixes:, neither at the end.
Commit id should be 12 chars, not 13.
There shouldn't be a blank line between Fixes and Signed-off-by.

I think that the Fixes tag should be 2b4984bef47a ("pwm: add support for 
atmel-hlcdc-pwm device".
The commit you point you have touched this code, be part of what you 
change was already there before that.

> 
> Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
> 

There should be a --- between the signed-of-by and the below changelog, 
so that the changelog will not be merged in the git history.

Also, it is also useful to add the link at lore.kernel.org of previous 
versions.

Here, it would be something like:
v1: 
https://lore.kernel.org/all/20230822070441.22170-1-Hari.PrasathGE@microchip.com/

> changelog of v2:
> 
>           - moved the clk_disable_unprepare to single point of return.
>           - cur_clk set to NULL before return.
> ---
>   drivers/pwm/pwm-atmel-hlcdc.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index 96a709a9d49a..4d35b838203f 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -44,7 +44,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>   	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
>   	struct atmel_hlcdc *hlcdc = chip->hlcdc;
>   	unsigned int status;
> -	int ret;
> +	int ret = 0;

This initialization looks un-needed and un-related to your changes.

>   
>   	if (state->enabled) {
>   		struct clk *new_clk = hlcdc->slow_clk;
> @@ -109,7 +109,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>   						 ATMEL_HLCDC_CLKPWMSEL,
>   						 gencfg);
>   			if (ret)
> -				return ret;
> +				goto disable_new_clk;
>   		}
>   
>   		do_div(pwmcval, state->period);
> @@ -134,18 +134,20 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>   					 ATMEL_HLCDC_PWMPOL,
>   					 pwmcfg);
>   		if (ret)
> -			return ret;
> +			goto disable_new_clk;
>   
>   		ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_EN,
>   				   ATMEL_HLCDC_PWM);
>   		if (ret)
> -			return ret;
> +			goto disable_new_clk;
>   
>   		ret = regmap_read_poll_timeout(hlcdc->regmap, ATMEL_HLCDC_SR,
>   					       status,
>   					       status & ATMEL_HLCDC_PWM,
>   					       10, 0);
> -		if (ret)

Removing this test looks wrong.

> +disable_new_clk:
> +			clk_disable_unprepare(new_clk);
> +			chip->cur_clk = NULL;
>   			return ret;

This is a really unusual pattern.
Usually, an error handling path is added at the end of the function, not 
in the middle.

CJ

>   	} else {
>   		ret = regmap_write(hlcdc->regmap, ATMEL_HLCDC_DIS,

