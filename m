Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C345F811EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442135AbjLMTWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442035AbjLMTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:22:41 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4565D99
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:22:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-55238437f2eso130384a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702495367; x=1703100167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkEUH41nE0miyMOhxtL4U6jrUAw9ffApP2YF4fuAh1E=;
        b=MDu3+4qNbslInU8SINBM740WSgdxSUZH1xnqPcMujQCrBWBbf/qqHMqyGWho/9jwrk
         LH8sCt9k0YLlIK3AgYNwW9ag31WYgAPZtWLF12f7LNvLN0DrfJ4Bob8T8ii3H8dPuXF+
         tDh0IypzMxZuRblomdPzIq7auSnY3uxwvDNDTEJYxPusN9cLM9spf3AnLIxmgMgSZ/pt
         mjSlZgLHyRiS3SvtLVonf7GILOeMvJl5SaWFmf1AB3iRyKeXopV1feiwYvRIwMo01O/7
         LjAETKIHN9fqtMT0oCrtI06bvtVWfEhJ6hHrAHvDGNtXttQH3Xq3gHr9Lc1gMFcSa9ne
         L0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702495367; x=1703100167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkEUH41nE0miyMOhxtL4U6jrUAw9ffApP2YF4fuAh1E=;
        b=Wl5n6erUMpakLw6O7auq9m6TGWYjdqFYe9aI9yp3XP1hI9gYmhlQeLMqGo/FSX/eqo
         D8WsT0wTV9if6+kTQ0i6FF6GRjLPxE3Af8XwnKYyW8luAAyd4afqpb4h5PAX0be3emgy
         nBMPJXNIFgSP7gZCsIVQv6YPTD53k9ZmFF4HflzFa1MKINTnbcRG7nLgElm7391eCvbO
         oedPLUvE9mHvgDEPVB/9POQSVK7ah92Ug2doXelOX2Qk2217KWfmthwSqYLHobfV5owh
         Y84LujJJ9hSmMATpO2PGoXnNvfZ8kudqfAfjg2LCSqO4z3gIcQb5D/JLmi4SWP10H08x
         1I/A==
X-Gm-Message-State: AOJu0YwceIpMymFRqcz73CQP/O5B82rBuSvoERJmf/Q2dPnrOSSH+9SW
        mYiLyMEI5RjuF4nGx3AiJ7E=
X-Google-Smtp-Source: AGHT+IE3ImK1TElUvL5+Q08Sy19tJXZdek724Pw4J1SWn/uFhRDdo64e3a6OmvNh/iqh6O2j37b6ag==
X-Received: by 2002:a17:907:1602:b0:a1e:75f2:a2f3 with SMTP id cw2-20020a170907160200b00a1e75f2a2f3mr9199485ejd.4.1702495366523;
        Wed, 13 Dec 2023 11:22:46 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id tr6-20020a170907c58600b00a1b7747e3c0sm8234459ejc.151.2023.12.13.11.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 11:22:46 -0800 (PST)
Message-ID: <66abc945-e539-4152-9044-2931934fb0fc@gmail.com>
Date:   Wed, 13 Dec 2023 20:22:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] staging: rtl8192e: rename variable
 HTGetHighestMCSRate
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231213175459.5425-1-garyrookard@fastmail.org>
 <20231213175459.5425-2-garyrookard@fastmail.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231213175459.5425-2-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/23 18:54, Gary Rookard wrote:
> oding style issue, checkpatch Avoid CamelCase,
> rename it. HTGetHighestMCSRate -> ht_get_highest_mcs_rate
> 
> Signed-off-by: Gary Rookard<garyrookard@fastmail.org>
> ---
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
>   drivers/staging/rtl8192e/rtllib.h         | 2 +-
>   drivers/staging/rtl8192e/rtllib_wx.c      | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 25097f1935a5..06542ac851fc 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -377,7 +377,7 @@ static u8 ht_pick_mcs_rate(struct rtllib_device *ieee, u8 *pOperateMCS)
>   	return true;
>   }
>   
> -u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
> +u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
>   		       u8 *pMCSFilter)
>   {
>   	u8		i, j;
> @@ -545,7 +545,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
>   		pMcsFilter = MCS_FILTER_1SS;
>   	else
>   		pMcsFilter = MCS_FILTER_ALL;


kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ cat 
~/Downloads/20231213-\[PATCH\ 1* | git am
Applying: staging: rtl8192e: rename variable HTGetHighestMCSRate
error: patch failed: drivers/staging/rtl8192e/rtl819x_HTProc.c:545
error: drivers/staging/rtl8192e/rtl819x_HTProc.c: patch does not apply
Patch failed at 0001 staging: rtl8192e: rename variable HTGetHighestMCSRate
hint: Use 'git am --show-current-patch=diff' to see the failed patch

