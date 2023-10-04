Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F267B81CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbjJDOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjJDOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:07:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B961AB;
        Wed,  4 Oct 2023 07:07:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so3690164a12.2;
        Wed, 04 Oct 2023 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696428461; x=1697033261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T0sP0tgQAUHqC8yCC+IOTFqWb27w1M9CLBpbcefWOCM=;
        b=heZv85G2mX68Fq5PzuTtt2e0fbuu04GIWdP+7szv8azeeWALB3oUMCmq2MMW+LMM8m
         9rDz7uWgnTwVTPMj6n3EKiifg7LWQL+rqKHL+fhV403nDXPqteGqu83vapwAAlQKcS4Y
         dyoFcX1ESj56r74baeutxBGcDqqcSOdNUwCCvxIorcxA1YqNDHxdjLbMYYDvG73PREcv
         ljwO7rb0MgZtfqkXdhh3ciONqwn/lzmLWrg7BpCbzJk90Lb2IYuvaVKZ/ay/vTM9nhhg
         pZp0LHGPheXIxeRLEf4D2i9MSr9vI89WCFtXqI9tBoaDz5FmIv/Xo1qz+tcDlS8ngtaq
         FdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696428461; x=1697033261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0sP0tgQAUHqC8yCC+IOTFqWb27w1M9CLBpbcefWOCM=;
        b=RFCVjLuqyyzjXdWsGDLcQZ5g8mlz++Razt77T7gnmdXefVrBkobUTqZoov0HVu+goX
         094n4fND6lPf+wcNp7YG8JKznDWvHLvjsFXdl9yzydil/6sVUGR0DZQ7/BRR++w/9pqp
         7/WUwS6ZAB9LSMbC5gPGWlCusqWf/oWPwg+en+kMhG+FRaXF7XjHSTERjYS2thH5siZq
         UN1AptgNmhDeetuteb7lC7qDYbaoPmSK848fa65boDiI9WK+966Vm+ls7BP3xOCEa1YX
         sU9t9iT5P2sBE7KtcqUM6I322uXcsCdBVKsM+XX5K4EYkzUVVouz6u1XzqA1AOJL8Kl3
         x+oQ==
X-Gm-Message-State: AOJu0Yy1RP98fhjoOyrmBX5qVKlwmyMC3HyigXKRuKBA05+TKc1xIWxU
        BEcxDKWIyDJRR02fOGnarb4na9WMzMU=
X-Google-Smtp-Source: AGHT+IFCPJZwxy+qqLaPWB48IYMJFtZqhWvX4HlYN4o9eddnBTeS5bYXY8Wf//chvbDKHxq/TlXmRA==
X-Received: by 2002:a05:6402:b18:b0:531:1875:bbc8 with SMTP id bm24-20020a0564020b1800b005311875bbc8mr2124049edb.19.1696428460318;
        Wed, 04 Oct 2023 07:07:40 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id f17-20020a50ee91000000b00537f5e85ea0sm2472700edr.13.2023.10.04.07.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 07:07:39 -0700 (PDT)
Message-ID: <1edcdb9d-196a-4b0f-9752-5f6ef0520e48@gmail.com>
Date:   Wed, 4 Oct 2023 16:07:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix regression in sed-opal for a saved key.
To:     linux-block@vger.kernel.org
Cc:     gjoyce@linux.vnet.ibm.com, jonathan.derrick@linux.dev,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Ondrej Kozina <okozina@redhat.com>
References: <20231003100209.380037-1-gmazyland@gmail.com>
Content-Language: en-US
From:   Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20231003100209.380037-1-gmazyland@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 12:02, Milan Broz wrote:
> The commit 3bfeb61256643281ac4be5b8a57e9d9da3db4335
> introduced the use of keyring for sed-opal.
> 
> Unfortunately, there is also a possibility to save
> the Opal key used in opal_lock_unlock().
> 
> This patch switches the order of operation, so the cached
> key is used instead of failure for opal_get_key.
> 
> The problem was found by the cryptsetup Opal test recently
> added to the cryptsetup tree.

Just forgot to mention - this is regression in 6.6-rc,
breaking our OPAL cryptsetup support, so  I think this
should go into next 6.6 rc.

Stable versions are ok, only 6.6-rc is affected currently.

Milan


> 
> Fixes: 3bfeb6125664 ("block: sed-opal: keyring support for SED keys")
> Tested-by: Ondrej Kozina <okozina@redhat.com>
> Signed-off-by: Milan Broz <gmazyland@gmail.com>
> ---
>   block/sed-opal.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 6d7f25d1711b..04f38a3f5d95 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -2888,12 +2888,11 @@ static int opal_lock_unlock(struct opal_dev *dev,
>   	if (lk_unlk->session.who > OPAL_USER9)
>   		return -EINVAL;
>   
> -	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
> -	if (ret)
> -		return ret;
>   	mutex_lock(&dev->dev_lock);
>   	opal_lock_check_for_saved_key(dev, lk_unlk);
> -	ret = __opal_lock_unlock(dev, lk_unlk);
> +	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
> +	if (!ret)
> +		ret = __opal_lock_unlock(dev, lk_unlk);
>   	mutex_unlock(&dev->dev_lock);
>   
>   	return ret;
