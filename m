Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D91C751A60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjGMHxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjGMHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:53:00 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD711FF1;
        Thu, 13 Jul 2023 00:52:55 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so65557166b.2;
        Thu, 13 Jul 2023 00:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689234773; x=1691826773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMhGDhSPkVOFk1WX7KdLm58e6BOk+Dpg6SU01MeEJM8=;
        b=DDUlOQAL0X7Cf/y5DCcqBvCBjYy5/t/mVK3aknzRGeUizjapK1GfgjKBAp/xMfHW2W
         wymzGoo8jGMr6KL6SAlpI1xfBtRuiIKWBLonuiaKEATFF5mrRkH/8z8+3vGqlbGbZdmL
         6+v3+Fca1nElYc90lMw5YU8k7s5UJXkqX85OTa4WRc96tCTc9UKGu2EgnNd3G/IIOhkr
         JUqsWDe1oDoeNl99DSZ7qh+GOFbArtkrlEYEkD6awgmhVn8AcJ1GsIpuxvuZtqpiofBF
         tTqnIF2JfnD7BUwkNOFMz952zn1aGwOfbShFU6DmBkeLW4d43i+KZKzLug9Aai7OqBWi
         +1Xw==
X-Gm-Message-State: ABy/qLYYK1NFzU458IO6bzhGNbeZlVXbR+AHyMkGksdavXUP/yb0AtiW
        ThW4SsFuljntQn9n/1w5sas=
X-Google-Smtp-Source: APBJJlHocHdLu8Ml9xRuSHiwTddyegMKaMbj5HvsjMU3ufSRT5CtDKiyvhuphLyTNZ2sB7XkjpSYrA==
X-Received: by 2002:a17:906:de:b0:96a:3f29:40d9 with SMTP id 30-20020a17090600de00b0096a3f2940d9mr738491eji.25.1689234773553;
        Thu, 13 Jul 2023 00:52:53 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id bl6-20020a170906c24600b00977ca5de275sm3701691ejb.13.2023.07.13.00.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:52:53 -0700 (PDT)
Message-ID: <12594c68-b452-b91d-9e41-c7ae8ade191a@kernel.org>
Date:   Thu, 13 Jul 2023 09:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drivers: wireless: ath5k: remove parameter check in
 ath5k_debug_init_device(struct ath5k_hw *ah)
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "open list:ATHEROS ATH5K WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230713074632.11204-1-duminjie@vivo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230713074632.11204-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 07. 23, 9:46, Minjie Du wrote:
> debugfs_create_file() will return early if phydir is an error
> pointer, so an extra error check is not needed.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---

And also: this is a v3 without a changelog.

>   drivers/net/wireless/ath/ath5k/debug.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
> index 4b41160e5..ec130510a 100644
> --- a/drivers/net/wireless/ath/ath5k/debug.c
> +++ b/drivers/net/wireless/ath/ath5k/debug.c
> @@ -982,8 +982,6 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
>   	ah->debug.level = ath5k_debug;
>   
>   	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
> -	if (!phydir)
> -		return;
>   
>   	debugfs_create_file("debug", 0600, phydir, ah, &fops_debug);
>   	debugfs_create_file("registers", 0400, phydir, ah, &registers_fops);

-- 
js
suse labs

