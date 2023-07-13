Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE20751A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGMHw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjGMHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:52:25 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5A51BEB;
        Thu, 13 Jul 2023 00:52:23 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-98df3dea907so65484766b.3;
        Thu, 13 Jul 2023 00:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689234742; x=1691826742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTxbR6KeeV+FJxSPbnngFcfSxrDlS1AZ/DJwic9okog=;
        b=anx2Se0UlJ5YKSG8ONeSnJCn5GZ7qPgFuPmnL7O7V4Zh6H2NpGSGHSidEwT+zTRdEN
         pWDWVzE7fFxXDff5rgw56dLheNNPgtORB+hXsMk1OCydqEgIyA8k1Pf+2Dz35/2OfDx0
         +Su0DuNjGfClr8/fzDX3uFKrvbCvb7uy7cKk3H8VkZV3UfIapjJPmIerUOwGL2mGokb/
         g2O+opiRqDMGo76HBb+CLPP9s+ID5t9ncjfCLrkjgQVrq+dxCOzDuhlEbiWKGM9o5z3H
         nprajnZPElGL5kOesDVWHN7iUhurI0qhpoK+PAvqPmHDWaTRKlpV8OCXnTTGQjdRxBYr
         +hQg==
X-Gm-Message-State: ABy/qLbZ3uNirsEA4Py01TvxIAIocgg2dANFJGufsfNPVrtVD+vKiIqj
        RA4z5XqrnTMYvXwsZGxriPE=
X-Google-Smtp-Source: APBJJlGOS2AaW76q4ZnCSo5z8pAsHue+NRxzJWQOZoQqkA7aWR99PZcWX2wB/rrGbJOdGuYeOs68Cg==
X-Received: by 2002:a17:906:739e:b0:977:befe:d888 with SMTP id f30-20020a170906739e00b00977befed888mr863511ejl.13.1689234741590;
        Thu, 13 Jul 2023 00:52:21 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id d24-20020a170906175800b009928b4e3b9fsm3606280eje.114.2023.07.13.00.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:52:21 -0700 (PDT)
Message-ID: <7305080b-9626-3cd3-707f-b41296578c49@kernel.org>
Date:   Thu, 13 Jul 2023 09:52:20 +0200
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
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject should be:
wifi: ath5k: remove parameter check in ath5k_debug_init_device()

I believe this is documented in SubmittingPatches.

On 13. 07. 23, 9:46, Minjie Du wrote:
> debugfs_create_file() will return early if phydir is an error
> pointer, so an extra error check is not needed.

It would be worth noting that the check is actually wrong.

> Signed-off-by: Minjie Du <duminjie@vivo.com>
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

