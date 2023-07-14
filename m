Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB6753101
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjGNFLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjGNFK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:10:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654B35AD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:10:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso2875545e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689311398; x=1689916198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGqSt6J/pVa6NTavIlQOXedDGt4HE4sakZVDJr5TXGA=;
        b=bUopmvPqzv9+EKI4VdxDRqWcJH2b96BARBY42YGo9+ZmodDieQpjbyRN3cZrb9x6Ih
         ij8lvoofbsm3BmvfzLSqgt7t5nQFhNrNHn2XUh8kQ8Z9FUAWbUgK0jPatCwUBQz9Grmi
         6eD8IcDsOAPcYizB9gVmxrlCIHZGh51f72wad4W0zIyXkMQuaBSLC5+SeWEKyLsO8MDO
         XNjSz5zrQJulls9WIrOv/ZJjbgH7AQfy089nxRdgZl/kFoYIpOG7FUM1cGqML79O2zRp
         fmPThd6Zc8meT3QrGBMo5etbjW4YQjOo1pPxr1IlaTQ57Buv1SzynYY/y3pKnziHcplx
         xPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689311398; x=1689916198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGqSt6J/pVa6NTavIlQOXedDGt4HE4sakZVDJr5TXGA=;
        b=Ubkxszcc6HEQM46M8JGn/C7SRJYmbb+fFhghHZSmynJG2332uRZlJsg4Prikz06Fap
         IncuBEHg3+dtDffYbkRwtpleOve1v5JTOasok9KquY54kpb8J4BtLYDVVR/D6e3BqVJD
         IO0d6JnJSKoOmAuzufSXtz9uGiN3MYne4eaZWUdKbySL/gph/7Kc+sH78fLveTZ1v47C
         lejM1LjoniISOMHL6DyJ8R+/a7Vs7PfahGB0xRaK6uas2kaC4Q3Q43IhSM0dKgryN3Ao
         l9a0UB4kOsdzE1CDBUPMU/3XCUzz7uH8HweeJ93jrAonYDX4zWIH4O5V8+vfF6TZAtBq
         pojw==
X-Gm-Message-State: ABy/qLaHo2axvWIgQN2NxqtocYYTS8m/iKBn50HUXbNgWw5ErvRIWQ9K
        3p/FvllYwfgAX+tw/5Za3qXSDutuLwk=
X-Google-Smtp-Source: APBJJlHCbINtm+lUAeHP6Yue/YdCtAa9AVGA4kYBF3lTXyi4eUrgPVT3klViZXXSHiXKbS35Z0P/TQ==
X-Received: by 2002:a05:600c:3b23:b0:3f8:efad:31ee with SMTP id m35-20020a05600c3b2300b003f8efad31eemr3342269wms.2.1689311397473;
        Thu, 13 Jul 2023 22:09:57 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bcb86000000b003fbe36a4ce6sm553622wmi.10.2023.07.13.22.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 22:09:57 -0700 (PDT)
Message-ID: <92728470-692d-b99e-db57-1a2805eaabf0@gmail.com>
Date:   Fri, 14 Jul 2023 07:09:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/12] Staging: rtl8192e: Style Guide Cleanup
Content-Language: en-US
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZK82AIxHctHFc27N@basil>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZK82AIxHctHFc27N@basil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 01:23, Tree Davies wrote:
> This patch series fixes checkpatch CamelCase warnings
> in regard to drivers/staging/rtl8192e/rtl819x_BAProc.c
> 
> Tree Davies (12):
>    Staging: rtl8192e: Rename function ActivateBAEntry
>    Staging: rtl8192e: Rename function DeActivateBAEntry
>    Staging: rtl8192e: Rename function TxTsDeleteBA
>    Staging: rtl8192e: Rename function TsInitAddBA
>    Staging: rtl8192e: Rename function TsInitDelBA
>    Staging: rtl8192e: Rename function BaSetupTimeOut
>    Staging: rtl8192e: Rename function TxBaInactTimeout
>    Staging: rtl8192e: Rename function RxBaInactTimeout
>    Staging: rtl8192e: Rename variable pBA
>    Staging: rtl8192e: Rename variable Time
>    Staging: rtl8192e: Rename variable pTxTs
>    Staging: rtl8192e: Rename variable TxAdmittedBARecord
> 
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 186 +++++++++++-----------
>   drivers/staging/rtl8192e/rtl819x_TS.h     |   2 +-
>   drivers/staging/rtl8192e/rtl819x_TSProc.c |  20 +--
>   drivers/staging/rtl8192e/rtllib.h         |  12 +-
>   drivers/staging/rtl8192e/rtllib_tx.c      |  18 +--
>   5 files changed, 119 insertions(+), 119 deletions(-)
> 

Hi Tree,

please make the Subject more unique. Otherwise some programs/homepages 
for reading this emails are not showing the Emails that belong together 
correct. But it is also for us readers good to have different email 
subjects.

Please have a look at:
https://lore.kernel.org/linux-staging/
for your patches. Usually a patch series is shown together but yours is 
not. May be this has to do with taking to much time between sending the 
emails (patches). If you use mutt to send then I recommend to open 13 
Terminals and prepare all those windows for sending. Then send them all 
quick one after another.

For this homepage it is OK:
https://www.spinics.net/lists/linux-staging/

This does not need to be corrected now. May be to be considered for the 
next time.

Bye Philipp




