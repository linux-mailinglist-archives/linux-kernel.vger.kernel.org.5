Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9060B7531AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjGNGC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjGNGCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:02:16 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCEB30F3;
        Thu, 13 Jul 2023 23:01:58 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9928abc11deso202507266b.1;
        Thu, 13 Jul 2023 23:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314516; x=1691906516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gmNBry8PRe3mCDr0ZNCdX5tawyt2CsREutleAeSPYA=;
        b=ZFKNb7Q4NPLg18TzA4gcWzu84L+xDZkKt3EZAq0UbmCyoX8DfV1ypXBj3PhweTS49t
         vmlxCXfZFTe9DXehJYsqzpkZCAseRD2w6QBzkRwTgmC4B74NBJ1ce0W/JNbA1vG3/KnF
         3qPUw5U24+WxiN/Q9zppqZ54Vjikau2vTRdRCTcLPkIW6DbPbXV/ztJHmAp9HfLI5Mpc
         Klasmzy0M3an6w4w4sSXtpwDA5N+nv+VU/Vc7FLQ3mkYZ3pBqNXEfBppKGOSMKAHoX/u
         puPvFP2mKibUcrvZMvqvgyUacHk/qD/aSY16ZtmCtMi9Mj3JtzR+8K+AVW7p/65Ohbyk
         FsnA==
X-Gm-Message-State: ABy/qLZPeLca8CJTCEDgBa+qhieLanI7YoKvGWwrg8n/Elbd52dMzvXD
        +wD5dczEkEN0pM5YmSNfdLMnCjYTGQk=
X-Google-Smtp-Source: APBJJlFIIqXVue5MEh16/w6cwltd7INIgWkYY8EZuoejNA1vxCvuZveo36NXEnsg6aPCP+cfm2kdfw==
X-Received: by 2002:a17:906:2091:b0:987:6372:c31f with SMTP id 17-20020a170906209100b009876372c31fmr3121878ejq.37.1689314516471;
        Thu, 13 Jul 2023 23:01:56 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906d19a00b0098e16f8c198sm5014208ejz.18.2023.07.13.23.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 23:01:56 -0700 (PDT)
Message-ID: <7f3b6708-9573-ed4d-3c3d-7caabcf5f522@kernel.org>
Date:   Fri, 14 Jul 2023 08:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v4] wifi: ath5k: remove parameter check in
 ath5k_debug_init_device()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        Minjie Du <duminjie@vivo.com>, opensource.kernel@vivo.com,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wang Ming <machel@vivo.com>
References: <20230713082433.11485-1-duminjie@vivo.com>
 <288c6005-7d0b-3eb0-514d-e2ac09ae6b00@web.de>
 <1bc521b4-5425-38bf-9600-a6efe11a2549@kernel.org>
 <43838a39-6c31-bf90-19e9-0cf21503bccd@web.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <43838a39-6c31-bf90-19e9-0cf21503bccd@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 14. 07. 23, 8:00, Markus Elfring wrote:
>>> Please apply the subject “[PATCH v5] wifi: ath5k: Remove an error check in ath5k_debug_init_device()”.
>>
>> FWIW I personally prefer the European style: lowercase after colon. So I would not suggest anyone to use one or the other.
> 
> How do you think about to achieve any further clarifications also according to
> the removal / deletion for items like the following?
> 
> * error
> 
> * parameter
> 
> * variable

Sorry, I don't follow.

-- 
js
suse labs

