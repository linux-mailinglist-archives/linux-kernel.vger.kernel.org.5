Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E814977B1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjHNG7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjHNG6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:58:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627F2E63
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:58:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-523ba00a581so4400259a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691996317; x=1692601117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fC9uTjaIAJ5FjIaqRIZtFBZkLO2XpgWA4xpYOOTE2qk=;
        b=cMkdSpxCMvVPajP4PIy88jdv8ncvtVYL4/+ff0B+5ffKoxi3CaejoPppwJ+TrGEoru
         uUpKWR45EoM4qP251Dwx6DgfdWD4C03lFAB35yKKJgLUsxVxEZchtbzJSeCkAn2aD/Il
         TP8bis/HXGg/Qqak0Mk7cfmk1AWXXV5nuvtvDLtS9RC+IBYAPd9irNHbNmvXxqFwMVek
         DHsE/6ecoJwzHAFTxnHHclHayzo3gvlR8MuWHJPP5uduhGW0a9Ejdb6OrCs6PYKxm83A
         hL51IzmZDT/ekqvYLCEtej/JBOBtjkEbjtp1N7A1bAKBAWs26bHSaoTqG2nal+CNnPIE
         axvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691996317; x=1692601117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fC9uTjaIAJ5FjIaqRIZtFBZkLO2XpgWA4xpYOOTE2qk=;
        b=DTNYLV5+zsxj7hn0M/doOuOauRqv/Mzyzhd98MACIie1xrihjNk77y96p8F75tFPXK
         1gr45hFqO5+qbIgx+UqPIty9aptUMF6m3Cy6wO704PRSJDoY8OX9hf7MKiQFamq0Vpib
         yInZe+CN1BmITp8gt3xXBFHTFfhfB8DzTCe/rSP1KS5umeP70ZmmKCzf1dVSuJfATw5L
         +mrDGr59M6phd+Xx6YWz9Pb1Gw3qL3pqqCyjkF4LH0m9CDnoKJUV+xslLmGQQIJ4D22O
         roW4dbp9mr1AAfY1cV73sgiBtft9q7X2HOGUmpylEeQYQfS2SBEY3yXp+6sdWtfeA8iu
         ql4g==
X-Gm-Message-State: AOJu0Yw+6VCibEOeYj5tq8Y5hXRXBMSjU3Xlkwtq+wHbH04d3p16GoaW
        BhB6bF8f54JbT2S6ZcZ0LqWyHg==
X-Google-Smtp-Source: AGHT+IFdIjWhw+ZlarVW/WzN/jbxn2nY95E8dloTVuccAnbzjSG1NMzfG42cKrTjSIxJgaiEyeyWUw==
X-Received: by 2002:a17:906:76d3:b0:99b:4fff:6bb with SMTP id q19-20020a17090676d300b0099b4fff06bbmr7626704ejn.4.1691996316874;
        Sun, 13 Aug 2023 23:58:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090655c600b0098748422178sm5322389ejp.56.2023.08.13.23.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 23:58:36 -0700 (PDT)
Message-ID: <66cbafc5-f490-511c-df9b-02c2e5e40811@linaro.org>
Date:   Mon, 14 Aug 2023 08:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] serial: mxs-uart: fix Wvoid-pointer-to-enum-cast warning
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andi Shyti <andi.shyti@kernel.org>
References: <20230810085042.39252-1-krzysztof.kozlowski@linaro.org>
 <2023081004-lapped-handbag-0324@gregkh>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2023081004-lapped-handbag-0324@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 17:44, Greg Kroah-Hartman wrote:
> On Thu, Aug 10, 2023 at 10:50:42AM +0200, Krzysztof Kozlowski wrote:
>> `devtype` is enum, thus cast of pointer on 64-bit compile test with W=1
>> causes:
>>
>>   mxs-auart.c:1598:15: error: cast to smaller integer type 'enum mxs_auart_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>>
>> Cc: Andi Shyti <andi.shyti@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/tty/serial/mxs-auart.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
>> index 8eeecf8ad359..a9b32722b049 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -1595,7 +1595,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
>>  		return -EINVAL;
>>  	}
>>  
>> -	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
>> +	s->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);
> 
> This feels like a compiler issue as devtype is a enum mxs_auart_type
> variable, so the cast shoudl be correct.

While the cast is obviously safe here, the warning in general is
reasonable - people were make too many mistakes by assuming pointers are
integers...

Just for the record (not saying that others doing is proof of correctness):

https://lore.kernel.org/lkml/20230809-cbl-1903-v1-1-df9d66a3ba3e@google.com/T/

But maybe Nathan can share his thoughts whether we should just disable
this warning for kernel?

> 
> And if not, unitptr_t isn't a valid kernel type, so that's not a good

It is in include/linux/types.h, so do you mean that it is not
recommended for in-kernel usage? I can go with kernel_ulong_t - which is
a kernel type - if the cast is agreed.

> solution either.  Worst case, it's how big a pointer is, which is not
> going to be what an enum is if you have a sane compiler :(


Best regards,
Krzysztof

