Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E1B75BD8B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGUE6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGUE57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:57:59 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD94B3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:57:58 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1b078b34df5so1182026fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689915478; x=1690520278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AOBpOFQg7H8OmzeSZEq7C/fef9nFDQns99xX1xv55pY=;
        b=gaslqA27pde+cmPIFUN2hwFTdXfob3qXha5KVBiAF+KxT431LSPV8eKDCiOTnUlT+N
         6WKBmgKA1MwskieP/J31ZlIQVoHB7mO3LgCIvdYVtKtXQiWrMTRnFlrQLV8jBQqogY31
         ilz1IjFHBsVme28z1ctrOdawiuouGjGDdL9z+6ToydEQS487YsvORM1CXJBv+BPGb7Tb
         H3z7K2IseEm4BkEsD4TNC+/AoHEA41W5z0bfpIg/Zby3ETNnFzAdstkIx762NzJCnpQ4
         10GeIb4F6jqUNtugWDQdGVy8SvS+HhTmOI+9GqgS4EerxSUjong9tl7V7cdMN3rg1ClF
         dAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689915478; x=1690520278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOBpOFQg7H8OmzeSZEq7C/fef9nFDQns99xX1xv55pY=;
        b=CVeIIyxStoqylal5/Fbg1/M3/pJBv7gmy2JCBO/BNwbDuZetmWz9tPn9SxIFdtDwiN
         cgeorJKtgIvkDuCJUjv9145fz0yiTTCinixrfQ59Q/HbkAxzQ/gTIK2YBYBX6bAueABf
         3qMQ39V7uyiN+0Bl1xZJxPnMU94mjchzwc19AqUn/Si6c6Xg7gXfoyvIl1BNLCQPpwl3
         jXK/qdJ3b4kzIxlG3J2bDe5zXWYkA4+LmzxQjPwMSTZF6ilUo4cgv8inaOKnMhV7wbmm
         k2bPsR1ciO1r+sUONiOrp7TFiN8t2dcw3nAcxH5XrZMSXUPwn5AnWgRkZUxQ0r5sajGc
         J6CQ==
X-Gm-Message-State: ABy/qLa9XAuENrX/GbtbZLTK/bHle/nAwzIWE3nvKwtSY2UO4SleE+r3
        6m0Xa0t8OqHR/V5FZjF7t3s=
X-Google-Smtp-Source: APBJJlFNUy5GtZES0EZJuyzMuRJyJBYXWs8yhrwUjL1SajpSM1AV+nrN4o2ri93pS0YcOv2ln1ASSQ==
X-Received: by 2002:a05:6870:d61e:b0:1b0:db2:189e with SMTP id a30-20020a056870d61e00b001b00db2189emr1059989oaq.17.1689915477756;
        Thu, 20 Jul 2023 21:57:57 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id d42-20020a056870d2aa00b001b390c6e00bsm1196563oae.56.2023.07.20.21.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 21:57:57 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <7931bb57-10d1-61cd-4149-bb133e843a15@lwfinger.net>
Date:   Thu, 20 Jul 2023 23:57:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: rtl8712: Remove redundant braces in if
 statements
To:     Sergey Rozhnov <rozhnov.sergey.89@gmail.com>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZLnoBYlsTiLixTah@terra>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <ZLnoBYlsTiLixTah@terra>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 21:05, Sergey Rozhnov wrote:
> Extract masked value to improve readability, apply fix suggested by checkpatch.
> ---
>   drivers/staging/rtl8712/ieee80211.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
> index 7d8f1a29d18a..fe53453ab9a7 100644
> --- a/drivers/staging/rtl8712/ieee80211.c
> +++ b/drivers/staging/rtl8712/ieee80211.c
> @@ -63,8 +63,9 @@ uint r8712_is_cckrates_included(u8 *rate)
>   	u32 i = 0;
>   
>   	while (rate[i] != 0) {
> -		if ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
> -		    (((rate[i]) & 0x7f) == 11) || (((rate[i]) & 0x7f) == 22))
> +		u8 val = rate[i] & 0x7f;
> +
> +		if (val == 2 || val == 4 || val == 11 || val == 22)
>   			return true;
>   		i++;
>   	}

The value of such a patch is marginal. The compiler will optimize it and only 
calculate the value of rate[i] & 0x7f once, and keep it in a register, which is 
likely what happens with your change as val will never be used again. Checkpatch 
is only suggestive and can be ignored.

You have no signed-off-by tag. As such, this patch could never be applied as it 
has no one vouching that they are the author. Please read and follow the 
instructions for submitting patches.

Larry

