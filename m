Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78D17C7279
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379536AbjJLQZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379540AbjJLQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:25:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1DD8;
        Thu, 12 Oct 2023 09:25:49 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d2b814912so230138a91.0;
        Thu, 12 Oct 2023 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697127949; x=1697732749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XA1bnjURyQEajydjepfYTZ+FcgQ3CdpqFI865kskAQ=;
        b=WJ3LaGtdPtK7QREQHbUj+s8QckI1CSt1zflgNoABY4qPScL9Epu5UlKCskvAgT6CTw
         fuklJwSuF5UzRhSSsiJ6fP74xzRghoSNOB+4jUsKCdZ8umZtvcAJwboFTBNRO31L97Te
         yOUF/Wn9s1HYxbY4ZPxsEvEkYO0I/jhf0NVS8RcSHUQYC5RDqj3Y74o1syxdBZm/Lrxv
         yywiFo5ooUv+mExz5DSGipTWwI6903gpm/lLKBWIkpP89jWvVm2dpdNo5SB9cyJfrS+C
         ThEX4sZKPfit6lTWDgFTauJZGIh00xpZ7JiHGtBFYzwMCvZchOpLGUnuPBrkYkoZ6TtJ
         +PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127949; x=1697732749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XA1bnjURyQEajydjepfYTZ+FcgQ3CdpqFI865kskAQ=;
        b=NENpSRyeYwfxvUdvb9bTzoO0Va7RUZ/7PPQ85ba5mmem/w6dMSb7d8ttD8dXQxcQwU
         u6KRjvbQ0kTKGcvscjIXHky5HEtONG2doMcrKhcjYKrU/lG/uE6xZkXlJYXr2pqpve7J
         qv+djy1bpKkBcy8sjyM+vCnt8ia56xYjBMBYyH6LC0udYg+chT/kqtPv5Pyf0lwD983Q
         O19vhxYuFU9+2Zp/d4c6q1aT5JMF9/+rfVo6fVRBm5Id1H/vUqn62Ght8kBbYijXWZsh
         8alFE+7U78AdHitM0zc8+yKeCrf8qioQBwS9XVeIbwSuuuTzXPya+EKkgbDIRngxX+MP
         yYmg==
X-Gm-Message-State: AOJu0YwzFOvuiC38zg3s92sneprzIm6NqDAb9JzDnzPdxWXONYguddUV
        G+TCjKI7426ZMMv2xs63O00=
X-Google-Smtp-Source: AGHT+IEOCcgOF3ACTlAZ50AUtGYWnkIntc1mQq7q/5nOk/hE6VK/yLVWFH8/e9BFv21TIsrFTwmzMw==
X-Received: by 2002:a17:90b:1892:b0:27d:c36:e130 with SMTP id mn18-20020a17090b189200b0027d0c36e130mr4470251pjb.8.1697127949257;
        Thu, 12 Oct 2023 09:25:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id qa17-20020a17090b4fd100b002790423f66fsm2037732pjb.26.2023.10.12.09.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 09:25:48 -0700 (PDT)
Message-ID: <9b5e8c02-31fc-43c8-bac6-d84f540f2407@gmail.com>
Date:   Thu, 12 Oct 2023 09:25:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On brcm80211 maintenance and support
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Kalle Valo <kvalo@kernel.org>, Neal Gompa <neal@gompa.dev>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com,
        Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phil Elwell <phil@raspberrypi.org>
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org> <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
 <e1ee4d76-f717-a67c-8099-7b91192ba1ca@yandex.ru>
 <e470902a-35eb-9bb4-7a9e-167f985c98bb@marcan.st>
 <CAEg-Je-mpcrEoM_nD3_8A=gZhdWpn3hxfGZNEfGRNupGwRdetw@mail.gmail.com>
 <87edi14fvp.fsf@kernel.org> <cce5765d-342f-4811-ab7f-fb41ede0b3a1@marcan.st>
 <14ce82c5-f807-59bd-30ec-7eff5066e4f0@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <14ce82c5-f807-59bd-30ec-7eff5066e4f0@broadcom.com>
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

On 10/12/23 01:41, Arend van Spriel wrote:
[snip]
>> I have a patch to enable WPA3 in Broadcom chipsets (yes, the driver is
>> in such a sorry state it doesn't even support that yet). The current
>> support attempt was added by a Cypress engineer and uses a completely
>> different firmware mechanism. Is that supposed to actually work? Does it
>> work currently? Is that the case for all Cypress firmwares? Or only
>> some? Does the alternate mechanism we have for Broadcom chips work too?
>> Only Cypress can answer those questions ahead of time, and they aren't
>> (they ignored me last time I brought this up). So my current patch just
>> replaces the mechanism with the known-working one for Broadcom chips.
> 
> This is mainly why I introduced the vendor-split concept so we can keep 
> the Cypress mechanism and allow a different mechanism for Broadcom 
> chips. The Cypress mechanism did not work for the Broadcom chips I have 
> so I wanted to test it on the Cypress chips I got shipped long ago and 
> they simply do not come up. Have not tried with RPi as it is not running 
> vanilla kernel. Could try with a backports driver.

You can run mainline on all of the Raspberry Pi devices, as far as Wi-Fi 
is concerned I cannot think of any major roadblocks, if not, email me 
privately and we can figure this one out.
-- 
Florian

