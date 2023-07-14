Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0455C7531D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjGNGNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjGNGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:13:50 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCC830D7;
        Thu, 13 Jul 2023 23:13:43 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so200646466b.2;
        Thu, 13 Jul 2023 23:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689315222; x=1691907222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQL/qYQdlzMuXAZovBDIHb8pZCn9R3HPgbRx22grkvk=;
        b=S01bSmXNm68Q2Ld7vIFfYMNZBuBUjt/Zon+BbZTta47WL4zOUAVpgHiZPpiW19TMyp
         so07Ox0WJd50kolyqAxHHsm1cI2n5zdTxsVq57KoRGPo5xXChzaimVNTi/1ev6x6I6dB
         Hxe3n6yZmOiod+O9uw06rBUVlt7g//LLcmSrOSUeGp0/s1CXASMvrg1oK8Ggri/cMEfY
         lb5oRG18oQlMpbXSL9/QFBZSHzFIUlnpXnEzaJmZm0n9nJvivcYrkMn6cuEodRHhFqSd
         +P6wiZ17YT3qhgfTftk9/ScarWCAKYEsnRLuIQxOZepkZqIUvWbvhcgpKUBP3by2y1Nm
         wRzg==
X-Gm-Message-State: ABy/qLbfvZ81WFN7j92K0RaZNerpwm+T9zD4VVcLtbgfmVX5Gsyp3bPm
        QXibZZPYy/Dx9yyK9eaHgzPPW/tpv6g=
X-Google-Smtp-Source: APBJJlF3yullhgWPZb3fuRYXrHOVlzSOsUCysSELc1CaC2BqaY3XSsU7ttx+2aeOqQIoL6huzIBqXw==
X-Received: by 2002:a17:906:7a4d:b0:993:d97f:ae06 with SMTP id i13-20020a1709067a4d00b00993d97fae06mr3359129ejo.13.1689315221819;
        Thu, 13 Jul 2023 23:13:41 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id jo26-20020a170906f6da00b0099315454e76sm4924061ejb.211.2023.07.13.23.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 23:13:41 -0700 (PDT)
Message-ID: <a68eae4c-a991-ff15-3800-86d39b4e4868@kernel.org>
Date:   Fri, 14 Jul 2023 08:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] wifi: ath5k: remove parameter check in
 ath5k_debug_init_device()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "open list:ATHEROS ATH5K WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230713082433.11485-1-duminjie@vivo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230713082433.11485-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 07. 23, 10:24, Minjie Du wrote:
> The parameter 'phydir' error check is mistake.

It's not actually a parameter.

> debugfs_create_file() will return early if 'phydir' is an error pointer,
> so the error check is removed.

What about something like:
Subject: wifi: ath5k: remove phydir check from ath5k_debug_init_device()

'phydir' returned from debugfs_create_dir() is checked against NULL. As 
the debugfs API returns an error pointer, the returned value can never 
be NULL.

So instead, remove the check completely as it is unneeded as per 
documentation. (Other debugfs calls are a nop in the error case.)

?

Or something like that, feel free to reword.


> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
> v1: use IS_ERR() to error check.
> v2: use IS_ERR_OR_NULL() to error check.
> v3: remove the error check.
> v4: fix the patch format.
> ---
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

