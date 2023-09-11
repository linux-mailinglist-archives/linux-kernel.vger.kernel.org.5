Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4979BC65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242721AbjIKU6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237346AbjIKMl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:41:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA28CEB;
        Mon, 11 Sep 2023 05:41:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401b5516104so46739385e9.2;
        Mon, 11 Sep 2023 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694436083; x=1695040883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ac6H1Uz2Vd0TNGk9X+Ey+nGUJRUHGmDNDKA1cgLsa3Y=;
        b=fgB8h4GxDhKJrsMU95fzNmTmYSiaWI2+JvK4PRWEoKpK9QwVwTo8gvlWj0MZzoixLh
         cLa7iCKvajueMfCvpxlO/bkPBXXyXLEYiXblQUDKhbshjDCFr8FhqKGALvmXSCvBSMb/
         yY2kpLVtmlGDFh5nC40C5KEs1mKNtLAbWwksHl3BZ/At71nwOnoh8Z1hFnF5WrYjzOpL
         WPQsUep/roX1DroM0iazDTV3Thpml6N9f+0LIvtAuQQe8PlolwVaCi8ehquxVb0Axnj6
         s98wasXaNBN+1fv6bywvaFk0eCrSNSSeIymOAIqoI3KvoByUsa90tfLboQ9JSnLqigTU
         FT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694436083; x=1695040883;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ac6H1Uz2Vd0TNGk9X+Ey+nGUJRUHGmDNDKA1cgLsa3Y=;
        b=lGyLCqNDN0NUW59+eBGr8I3MoYSdNkyJGhD3OKSR8od5ENAx01NM00HyeXv8MgSHMj
         DvNvcC6lGRZfK3vGL/KnoDnSzS5+H576IjvhKbb0BXXiFdJseTgebbl7vpidDjkITXal
         gRkACzsMM99RHs+5VpQGNr8uLQ+CT3PwnoVyiPiyf1HGCcvSttzi/qI2sszADNCtWGpp
         f/H5zk+hxWLQiYhDzpESzbqr8fgAkK6fA9gy0QFTMz8hcqBA0s31WlQ6RKNQueyj4bx7
         AKVsukTRRdaRkM85Z5srB8TPs5iZ86YQFG4ace7UGM08w4VZfGQOd4/zK2L9TywXI41z
         q8rQ==
X-Gm-Message-State: AOJu0YygyJIXIu7vas4zpp9geiD/2zHNCRTvrvHTc573rQ8u7tc81mb8
        8VWLJiJF1vPqanciM+fVyLkIMxV46ss=
X-Google-Smtp-Source: AGHT+IHesgaYH5Wp7Jtmc0soZ1/OuIXyuMQEnobV7N+fv26TvJPsrXUuihJylYXx2+lv7LyISv3MSA==
X-Received: by 2002:a05:600c:2482:b0:3fe:d6bf:f314 with SMTP id 2-20020a05600c248200b003fed6bff314mr8003301wms.39.1694436083361;
        Mon, 11 Sep 2023 05:41:23 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.161])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c204d00b00402d7105035sm13040202wmg.26.2023.09.11.05.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 05:41:22 -0700 (PDT)
Message-ID: <2984eff5-528e-4a27-bfa0-502210d84b79@gmail.com>
Date:   Mon, 11 Sep 2023 15:41:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: fix LED control code of RTL8192FU
To:     Zenm Chen <zenmchen@gmail.com>, Jes.Sorensen@gmail.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, pkshih@realtek.com
References: <20230910002038.56362-1-zenmchen@gmail.com>
Content-Language: en-US
In-Reply-To: <20230910002038.56362-1-zenmchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2023 03:20, Zenm Chen wrote:
> ASUS USB-N13 C1 is a wifi adapter based on a RTL8192FU chip and its LED
> doesn't blink with the rtl8xxxu driver. This patch fix this via writing
> the correct value to the register "REG_LEDCFG0".
> 
> This was tested with these two wifi adapters:
> ASUS USB-N13 C1	(vid=0x0b05, pid=0x18f1, rfe_type=0x1)
> MERCURY MW310UH	(vid=0x0bda, pid=0xf192, rfe_type=0x5)
> 
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> ---
>  .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 24 ++++++++-----------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> index 28e93835e05a..ab6d4e4e228e 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> @@ -2014,26 +2014,22 @@ static int rtl8192fu_led_brightness_set(struct led_classdev *led_cdev,
>  	struct rtl8xxxu_priv *priv = container_of(led_cdev,
>  						  struct rtl8xxxu_priv,
>  						  led_cdev);
> -	u16 ledcfg;
> +	u32 ledcfg;
>  
>  	/* Values obtained by observing the USB traffic from the Windows driver. */
>  	rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_0, 0x20080);
>  	rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_1, 0x1b0000);
>  
> -	ledcfg = rtl8xxxu_read16(priv, REG_LEDCFG0);
> -
> -	if (brightness == LED_OFF) {
> -		/* Value obtained like above. */
> -		ledcfg = BIT(1) | BIT(7);
> -	} else if (brightness == LED_ON) {
> -		/* Value obtained like above. */
> -		ledcfg = BIT(1) | BIT(7) | BIT(11);
> -	} else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
> -		/* Value obtained by brute force. */
> -		ledcfg = BIT(8) | BIT(9);
> -	}
> +	/* Enable LED0 GPIO and turn LED0/LED1 off. */
> +	ledcfg = (rtl8xxxu_read32(priv, REG_LEDCFG0) | BIT(21)) & ~0xffff;
> +
> +	/* Values obtained by brute force. */
> +	if (brightness == LED_ON)
> +		ledcfg |= BIT(3) | BIT(11);

Can you explain in the commit message why you changed the
LED_ON and LED_OFF branches? It's not obvious to me and they
don't have anything to do with the hardware-controlled blinking.

> +	else if (brightness == RTL8XXXU_HW_LED_CONTROL)
> +		ledcfg |= BIT(0) | BIT(1) | BIT(8) | BIT(9);
>  
> -	rtl8xxxu_write16(priv, REG_LEDCFG0, ledcfg);
> +	rtl8xxxu_write32(priv, REG_LEDCFG0, ledcfg);
>  
>  	return 0;
>  }

My Comfast CF-826F still works fine with this patch.
