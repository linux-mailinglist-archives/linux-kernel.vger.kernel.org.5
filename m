Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9547C48B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 06:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbjJKEJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 00:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbjJKEJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 00:09:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0758F;
        Tue, 10 Oct 2023 21:09:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso4519752b3a.2;
        Tue, 10 Oct 2023 21:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696997340; x=1697602140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjFRhw+abGKuFAc754QE3Q4VfIDjdSB/EOwCq4IqhFY=;
        b=aQEtGHq7WZQO6u8Xfa2PGTz0HfCS80kbzgprsxahm7v5Yc4M2yAMbvo2wWDAsWfAXj
         zCAb6H01AAmGilqNcPue7V9ri7LQUOeqOGSzX5gBBnYScKhdHBnolIu86H+cbdyRECaT
         E01il/eSzWT5iQbiuoYG/xn9f3WHNZoLoe9M1EbmHivkWN2QGwYskgdIOA4Sp0073q/3
         BhCk/AEOGKruiBMzOuRr75W76BmsxO+fznOKNJsYuseHa3pvMd9z2/EwVpAGn0tTmRiN
         V8cHcfd9OJwY+82G78GlUWfl0HsgKTKCFOv0JuxikOupfmvwWxUGwozFbv4/RdOvXSuq
         hRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696997340; x=1697602140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjFRhw+abGKuFAc754QE3Q4VfIDjdSB/EOwCq4IqhFY=;
        b=ZsFLBama25SM2L7pYAS+4BaPhn/+nqLGh+/3voDhrYjT8raJwpPugANUqrQXgP02TR
         hRtmQcfcV7KIYb318MzZl0i48eTiYSkA3oar+UCBLudAKmdc0uysdo/u+nBaNEP3fHLM
         0K+6SgzsZyqaalDq/MZEkk1ttVynBrOsTDBBkETR9BLk2Je5Oc23b48TR13UOQYFho3S
         suRciFs2ftgSt3BREBizT5rFYPNRSjYoF7Zd27f1TZrsctRvd/qYJ/fk5N2gih6VQgB5
         TVHFQlxRa8l+Qm6JXb7S6gcSmreP0WIXlLnkJpG4u1YWKismKGLCxPUgdOQiI/HkPP6s
         d4bQ==
X-Gm-Message-State: AOJu0YzQTb8ZeTbQKvebYg5J8dHd7aHOaSG/LFjAuobhe13cT8G4TBdq
        4u2OoJZtdHuFA9LVOLOLVGY=
X-Google-Smtp-Source: AGHT+IHSRiqovUqs4Zo0c3Rkc7iyCVGCDIPdxs/ixQ+/FALwyLkVdFXLDpav9MpkEwnq+h+1k50WXA==
X-Received: by 2002:a05:6a20:4323:b0:16b:c734:4515 with SMTP id h35-20020a056a20432300b0016bc7344515mr12046114pzk.14.1696997340092;
        Tue, 10 Oct 2023 21:09:00 -0700 (PDT)
Received: from [172.22.12.30] (118-163-147-182.hinet-ip.hinet.net. [118.163.147.182])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902c18300b001a5fccab02dsm12716433pld.177.2023.10.10.21.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 21:08:59 -0700 (PDT)
Message-ID: <88ffe7b3-fa62-e879-b9d6-6e229cfdab7d@gmail.com>
Date:   Wed, 11 Oct 2023 12:08:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] watchdog: eiois200_wdt: Add EIO-IS200 Watchdog Driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1696495372.git.advantech.susiteam@gmail.com>
 <d7df3c7b-730a-4d09-8f15-3cc8591c8092@roeck-us.net>
 <b08d6cf6-cd48-86d7-a959-290fc4de092c@gmail.com>
 <ce810ce8-f93c-4a9c-9d14-1e8f8f8c3e2b@roeck-us.net>
Content-Language: en-US
From:   Wenkai <advantech.susiteam@gmail.com>
In-Reply-To: <ce810ce8-f93c-4a9c-9d14-1e8f8f8c3e2b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Guenter Roeck 於 10/6/2023 10:16 PM 寫道:
> On Fri, Oct 06, 2023 at 05:27:48PM +0800, Wenkai wrote:
>>
>> Guenter Roeck 於 10/6/2023 11:02 AM 寫道:
>>> On Thu, Oct 05, 2023 at 04:51:18PM +0800, advantech.susiteam@gmail.com wrote:
>>>> From: Wenkai <advantech.susiteam@gmail.com>
>>>>
>>>> This patch series aims to add support for the Advantech EIO-IS200
>>>> Embedded Controller's watchdog timer to the Linux kernel. The EIO-IS200
>>>> is a widely used embedded controller, and this series introduces a
>>>> native driver for its watchdog timer functionality within the Linux
>>>> ecosystem.
>>>>
>>> I am not going to review this patch series. This is just ne watchdog driver.
>>> One patch is sufficient.
>>>
>>> Guenter
>> Hi Guenter,
>>
>> Advantech's EIO-IS200 watchdog supports 5 output pins: RESET, Power
>> Button, SCI, IRQ, and GPIO. The most traditional scenario is that the
>> Pretimeout triggers IRQ, and the timeout triggers RESET.
>>
>> However, unfortunately, for industrial usages, there are various use
>> cases, which require certain mechanisms and logic to manage which signal
>> is output when Pretimeout and timeout expire. I am concerned that
>> consolidating all these features into a single patch for upstream may
>> lead to confusion and make the source code less readable and
>> understandable.
>>
> The 1st patch in your series doesn't even compile. I don't call that
> understandable.
>
> Oh, it fails to compile because you include a non-existing file from
> ../mfd directly and because you select a non-existing configuration option
> instead of depending on it.
>
> None of those is even remotely acceptable. Are you seriously sending me
> a series of patches that don't even build to review ?

I understand that the patches don't meet the expected quality standards.
The compile issue is due to my MFD core driver, which is currently under
review and has not been merged yet.

I would also like to seek your advice on how to best proceed with the
sub-drivers like the watchdog driver. Should I wait for my core MFD
driver to be successfully merged before submitting the sub-drivers, or
let Jones Lee review my core MFD driver and all its sub-drivers, or is
there another approach that you recommend?
>> Therefore, I have divided the implementation into 5 separate patches,
>> aiming to make the code more comprehensible and acceptable. If it's
>> acceptable to you, I am more than willing to provide a single patch as
>> per your preference.
>>
> Frankly, your series is one more nail in the coffin. I am now seriously
> considering to resign as co-maintainer of the watchdog subsystem.
>
> Guenter

I also appreciate your patience, dedication, and valuable contributions
to the Linux community. Your longstanding efforts and expertise are
commendable and have been instrumental in advancing the Linux ecosystem.
I understand that upstream review can be a meticulous and vital, albeit
thankless, task. I don't want my actions to cause any inconvenience or
distress, especially to someone as esteemed as you are in the Linux
community. Your insights and guidance are incredibly valuable to all of
us.

Once again, thank you for your understanding, and I am committed to
delivering high-quality code for your review.

Best regards,
Wenkai


