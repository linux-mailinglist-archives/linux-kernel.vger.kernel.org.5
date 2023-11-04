Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0087E0F2E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjKDLjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDLjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:39:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C2D47
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:39:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-408363c2918so4308865e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699097979; x=1699702779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VC+Vc18HpjDuM9zWgO0MZbqut4q/1GieWVs47SxImQ4=;
        b=WRZZN1Gwz+lJI6CqqdLqDeKasThYo4ocsoMhvsbX0sbzykiGC3BkpPCYmcYh0AgFRI
         oEgoCadJrEEYbBT88HUtv9Uo8zeC/1QEmIq/+6TqL8jwANqvhxlIvWUG0UHHABaCgpHE
         b7v9/EYyoMykq9H6FtHWrfaLkpYMUSI1Ah7jKKELIOjiDSQ9kQbkiXQOsBIIweUpKgiv
         Qn2jxfStosX0fexVXqHx8tWFX3RDDsvukZ3uWp+DxvV/iFdHAE5PLmBVR2DQyf14sl1Q
         z9R2Mwc6kaIh0irQW6yKcblCK9ZpJmreK09zi7DUnJXb2lT3LexQw3Ct2nJiHyOb51vO
         f8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699097979; x=1699702779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VC+Vc18HpjDuM9zWgO0MZbqut4q/1GieWVs47SxImQ4=;
        b=ENgwlSffijJtiZcx3OH/kK9mVD3bZC9Go74UnuRhLD+rVHZTUPc1y1bQCygJ5BQmSE
         39jAnFqRn9GGMUzHW4ARKmso5q8M0OB7akvXLJhplgitjCT2N3shytzoukZ64J3e4RYL
         lnBAIvsQQnpVd2FAitFIrkPf+PUU2OsIuOQ9Lc2OAZ12zvAliu/5P9i+73II/OeFzLfa
         jIaDc9FRpaR6Dm/b7p/LMP3tNQKVYwlkkIwEtKAjkhhIWe1m0gpo2bl/3YgyMeZWtyUX
         e+R/G0wDiE0G4Y8lwTtVs1KHPmeii0DqODOZQBh0eJNKRQTSRmnOs4VgV74EtF80jzQp
         c+MQ==
X-Gm-Message-State: AOJu0YyzJVJGbrreR2uHR//jFHKIWYBYxEkvL65dfVRr0PgSYCdolACe
        xOjSe0svT77vMTytswkKEnE=
X-Google-Smtp-Source: AGHT+IHX5f1HLte02nzyZNKgs/kxN9IuJMQRjXsXHwsrJreD9jq6XeILbmbew3HV57LWCb07veaayw==
X-Received: by 2002:a05:600c:1c1b:b0:403:334:fb0d with SMTP id j27-20020a05600c1c1b00b004030334fb0dmr19559329wms.4.1699097979324;
        Sat, 04 Nov 2023 04:39:39 -0700 (PDT)
Received: from [192.168.0.101] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003fe1fe56202sm5610361wmq.33.2023.11.04.04.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 04:39:38 -0700 (PDT)
Message-ID: <0056c9ec-6e05-44b2-a7c5-e3c743454e22@gmail.com>
Date:   Sat, 4 Nov 2023 12:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Type encoding info dropped from variable and
 function names in NIC driver part2
To:     Pavan Bobba <opensource206@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1698730318.git.opensource206@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1698730318.git.opensource206@gmail.com>
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

On 10/31/23 06:34, Pavan Bobba wrote:
> This patchset series consist of fixes to issues found by checkpatch
> 
> Pavan Bobba (11):
>    staging: vt6655: Type encoding info dropped from variable name
>      "qwBSSTimestamp"
>    staging: vt6655: Type encoding info dropped from variable name
>      "qwTSFOffset"
>    staging: vt6655: Type encoding info dropped from function name
>      "CARDqGetTSFOffset"
>    staging: vt6655: Type encoding info dropped from function name
>      "CARDbSetBeaconPeriod"
>    staging: vt6655: Type encoding info dropped from variable name
>      "wBeaconInterval"
>    staging: vt6655: Type encoding info dropped from variable name
>      "qwNextTBTT"
>    staging: vt6655: Type encoding info dropped from function name
>      "CARDqGetNextTBTT"
>    staging: vt6655: Type encoding info dropped from function name
>      "CARDbRadioPowerOff"
>    staging: vt6655: Type encoding info dropped from function name
>      "CARDvSafeResetTx"
>    staging: vt6655: Type encoding info dropped from variable name
>      "pCurrTD"
>    staging: vt6655: Type encoding info dropped from variable name
>      "apTailTD"
> 
>   drivers/staging/vt6655/card.c        | 90 ++++++++++++++--------------
>   drivers/staging/vt6655/card.h        | 18 +++---
>   drivers/staging/vt6655/device.h      |  4 +-
>   drivers/staging/vt6655/device_main.c | 18 +++---
>   drivers/staging/vt6655/rxtx.c        |  2 +-
>   5 files changed, 66 insertions(+), 66 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

