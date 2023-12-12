Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9F380F107
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376726AbjLLPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376659AbjLLPbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:31:08 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F759D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:31:13 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7b7684f0fe4so6134939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702395073; x=1702999873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GscAVAQw3jOAPyoMvo+XtWiwO1CMlaNrG73NSDT/aj0=;
        b=XMu+v3edZybbZ/Dq6vU/eyshSinkTCLEtYl89eQ8RLw7BXKwtpXnVZ7CTRCTEEGEbj
         FYMYy/JJisWX4DElS0QOxHmcw1+uHANtiQEJaeHDu90sBs9D7lnZjp23qyk5U4gNGlxC
         7/sR6gEnTPEOCtZXUPTM2PR78AI6U/SnEAvxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702395073; x=1702999873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GscAVAQw3jOAPyoMvo+XtWiwO1CMlaNrG73NSDT/aj0=;
        b=OjDjpgwi6za/rdW+CkI7C+cFPqwjhyJBB2HqvtrKsHpIupuGWh77aLnU1P1Vx4lHss
         C3T42RYew17pJ4W68qaxsl8RxUC39Beq7c+HRvlKjxPrZu3tXJBBp9drzC0zgRSQXVlA
         OyHayNyRPbSexU+DmejStBqTVqQ7cWcqUQ8sl8zp2N7TGhvTjaMGwaehRieaoPZOBuCW
         9UHS6N1lRAfHGKtglqUwJh8BoB6qu9EQOjmtBhmYAn22Kd/PoOtrBqq6ZOprCdbK33y3
         +7flPG4kCuveJ+ixfZXILr29fo+/nvUaaNJVMfmhQCO3Bh/YISSXvl3GuOt0sagHW+zn
         trtw==
X-Gm-Message-State: AOJu0YxOt2xK+DEtWgCi7vXJtK9nSjAZ83ILWjErgk5wcUr8P/lLus0N
        HFm/SI1Y7Z7oqTugArtI2YQAYA==
X-Google-Smtp-Source: AGHT+IHpDkWdebgWwXK3Ea4XBvViy8KGX8metxHQsuoTyztbAbyBy5ZkYqONDK/VkPrrr4k5FoFqzA==
X-Received: by 2002:a92:cd82:0:b0:35d:7a37:5236 with SMTP id r2-20020a92cd82000000b0035d7a375236mr11616101ilb.2.1702395072844;
        Tue, 12 Dec 2023 07:31:12 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m6-20020a924a06000000b0035d6bbcede7sm2969309ilf.25.2023.12.12.07.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:31:12 -0800 (PST)
Message-ID: <57a7fb54-67e6-4eb8-8772-9cf01452fb00@linuxfoundation.org>
Date:   Tue, 12 Dec 2023 08:31:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nolibc changes for 6.8
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, WillyTarreauw@lwt.eu,
        Shuah Khan <skhan@linuxfoundation.org>
References: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
 <4074b0bc-e89b-4b2e-ad11-cb3a9517b725@linuxfoundation.org>
 <d486df54-4484-4f6a-b40f-aebeb5f0131a@t-8ch.de>
 <ef2d9d5f-e485-465c-98b7-d993610ae10e@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ef2d9d5f-e485-465c-98b7-d993610ae10e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 16:49, Shuah Khan wrote:
> Hi Thomas,
> 
> On 12/11/23 14:40, Thomas Weißschuh wrote:
>> Hi Shuah,
>>
> 
>>
>> Thanks for spotting this!
>>
>> The fixed commits are published on the same "next" branch as before with
>> final commit d543d9ddf593b1f4cb1d57d9ac0ad279fe18adaf.
>>
> 
> Thank you.
> 
> Pulled and pushed to linux-kselftest nolibc branch.
> 

Forgot to mention that I ran "make run" and "make run-user" and
saw the same results Paul saw. All good.

thanks,
-- Shuah

