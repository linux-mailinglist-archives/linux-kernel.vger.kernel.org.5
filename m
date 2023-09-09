Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE7799AAE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 21:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbjIIT6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 15:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIIT6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 15:58:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C99212C;
        Sat,  9 Sep 2023 12:58:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401d61e9fecso9288985e9.0;
        Sat, 09 Sep 2023 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694289495; x=1694894295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0F4jEyD+50Ag5LBcb9IntWEhZBR76+0TAP/uE4iXsw=;
        b=RKOE2a6LrG4zQP+e3g0llPa/D8B9ZIqFzJSo6scVb2RP/40ln0CGgR0H4OYrbr7YQh
         7bIqfoYlw0gO9QKIhVeLjK07JR8/G34VGUlQHW+F/ovuny/no2FKdmc+RwuN2ZAX1RwY
         dBcaISABWzlAE2E20F+8OBjMOYpC25bm229BXV8gBPFBED8G7ks2dCusxXmfWmi0BRb8
         +PS9/DcDPXXNwlBXg72IHeL4PgIOHr+0K21O1BHgsyQZ3+p3tWEfJ+nS+/7jr5P02D0c
         rCAFAfwYClEoFB2JctyDlL9/omvW//ywDc7tO2u5kC1eVBfLyBzieyXl6Vmol8KEHJJB
         R/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694289495; x=1694894295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0F4jEyD+50Ag5LBcb9IntWEhZBR76+0TAP/uE4iXsw=;
        b=CkBmyyGVRP8bdjQoFLIiYdMpS2OTgTqMKklOc57Nd6DrGR5wVDvOE1SVWuSSE/FkHC
         O0xPEUYAdxfqDXKgb/SHy6b+TqL37I1MhFcQI+UkxJj5SW8xxSrOKMAiAG9SErYR0FTx
         Cnn3WjUZOWDyGj5ykRskllYHqJbvAiWxc9jRpHKY5HXcwQjVTwMpmsWPMH1lo7NTMfXV
         08lMoROAlt8E+aGlkJng8fj4blD8LK3dK6R6X7F0xc/bt9buyHorzx13LpCSwgS+ruZt
         fOUulsVzxjLkaAZDSYISqe6d+dWTu1bv89+5pQqqTnlkMcFgURab8LAcUbsqU/ssAGtB
         tzFg==
X-Gm-Message-State: AOJu0Yz7EnpOXvnpgoc19iH5iMU3YfUVVPB3yII+cXdLOs5wbXteUeSB
        whMfshF3iPnKmnoa86D1/XdNjU085VM=
X-Google-Smtp-Source: AGHT+IHxACP3AbFMtWMG5fy2nEKc51ZcY+JEKUYXj3Ef+lMCfr0fXgSP0w1dA0SHwFHwRVJLncNEbg==
X-Received: by 2002:a5d:5702:0:b0:317:5f08:329f with SMTP id a2-20020a5d5702000000b003175f08329fmr5002226wrv.1.1694289495267;
        Sat, 09 Sep 2023 12:58:15 -0700 (PDT)
Received: from [10.0.0.25] ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id r17-20020adfce91000000b003198a9d758dsm5589721wrn.78.2023.09.09.12.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 12:58:14 -0700 (PDT)
Message-ID: <2cb0fd0d-acc7-8cdd-85ad-b75ba36afef1@gmail.com>
Date:   Sat, 9 Sep 2023 23:58:13 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] Fix typo in tpmrm class definition
Content-Language: en-US
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jmforbes@linuxtx.org
References: <20230908140629.2930150-1-jforbes@fedoraproject.org>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230908140629.2930150-1-jforbes@fedoraproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.2023 18:06, Justin M. Forbes wrote:
> Commit d2e8071bed0be ("tpm: make all 'class' structures const")
> unfortunately had a typo for the name on tpmrm.
> 
> Fixes: d2e8071bed0b ("tpm: make all 'class' structures const")
> Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> ---
>   drivers/char/tpm/tpm-chip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 23f6f2eda84c..42b1062e33cd 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -33,7 +33,7 @@ const struct class tpm_class = {
>   	.shutdown_pre = tpm_class_shutdown,
>   };
>   const struct class tpmrm_class = {
> -	.name = "tmprm",
> +	.name = "tpmrm",
>   };
>   dev_t tpm_devt;
> 

Hi Justin,

Thank you for fixing this mistake, it's my bad :(

I'm not sure if you know this or not, but merge window is still opened, 
so the patch could be accidentally skipped by maintainers as they have a 
huge load during this period... Perhaps resending it in a few days might 
be a good idea.

Also, probably adding 'tpm:' prefix to the commit title could make it 
more noticeable to the maintainers.

Thank you again for doing this.

--
Kind regards,
Ivan Orlov
