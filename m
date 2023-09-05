Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC81792F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242551AbjIEUHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjIEUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:07:50 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43546AB;
        Tue,  5 Sep 2023 13:07:47 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4142ca41b89so19844901cf.0;
        Tue, 05 Sep 2023 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693944466; x=1694549266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWLhmbexMwFItDsfUj1BiKajqO0nL+fAa0yKi72A9kg=;
        b=ec35FZiQR6vs8ePnc92VgmiEMlr0k9jkEmCoUanW63vlV4icPo3bNmAtXwjalrZltM
         zepKNTAfOFdpq0B+j8XW8ram3fbIu7xm8yOtbwwnez0ya1XShvT1exx20SWIzkuOOc1B
         VIdBZcl07IsD8hJD2tmfGE9Lljg39Yz1sP5zM7ksZCvoc1BHgHHyEIqW9ibuCne6SVUP
         OGeCrXe9cdnq+9tXl4niafFIHJ5wJjU4ypbxXk2FHmO1upI4oUN+Q4zZYiuZOzXI+ttS
         Hhrq0g8sECWH11qQOTGKQ2nSw0MSIv3Feofg1XvhCx5Ez/82BXCfnIdp7J+5mvSHvf0z
         l4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944466; x=1694549266;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWLhmbexMwFItDsfUj1BiKajqO0nL+fAa0yKi72A9kg=;
        b=Nr98bbChkN+FRHutYN0I7iLpZBMwFsbvoSyAEZhu66Yykm/3bnQ6WxuFAKhyA7WaKg
         0Il3w0x9dqocpY92WL7NIQFn5CRGFaFl22kADVESRQjv+y2xzn+o5fqgu+Gao/VPFdy1
         zHUiaRgMZpVBM9NFB8c0+l23nhs2wVSXKm41hLxzq7XIz4/GdlQs9nByuBlhsJrWjgu3
         JHyNhOYStNhZKDj0krm/gYc+LqX8bABAfw0tL4KMeRgz6xviej+p1mKxm8zWweSdJmlB
         GeZssAOLkbhdSNT9BEHPdZkRSxdC5vPlmyeWO61yhw/EIXuMH2EwdqJMijNlm5WEkUMo
         GasQ==
X-Gm-Message-State: AOJu0Yz/+4vFKbBcOznKlsisazoaI1rpjPjG+0x0Q4f4TxgHFkq9PD6l
        JKHoh0lXRRhAQijDtNE5Xa+pvb0oRonICg==
X-Google-Smtp-Source: AGHT+IHYXuEyrFsZo1mZAuwnxMK9+X1hIcxfibCAJKF/FhNk+CgDpk4pUHUE9pHQTzgCca8Z/CJKNw==
X-Received: by 2002:a05:622a:288:b0:412:217:3d3d with SMTP id z8-20020a05622a028800b0041202173d3dmr14942089qtw.68.1693944466189;
        Tue, 05 Sep 2023 13:07:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b3-20020ac844c3000000b00410929fe3b9sm4630573qto.58.2023.09.05.13.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:07:45 -0700 (PDT)
Message-ID: <3e573810-d50c-9b54-7ea3-f1d82a7ca5b5@gmail.com>
Date:   Tue, 5 Sep 2023 13:07:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random
 changes
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Waiman Long <longman@redhat.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openwrt-devel@lists.openwrt.org,
        bcm-kernel-feedback-list@broadcom.com
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
 <c98e6c5b-d334-075f-71b8-1c2a3b73b205@redhat.com>
 <ZPX6W6q4+ECPbBmq@shell.armlinux.org.uk>
Content-Language: en-US
In-Reply-To: <ZPX6W6q4+ECPbBmq@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2023 8:40 AM, Russell King (Oracle) wrote:
> On Mon, Sep 04, 2023 at 11:25:57AM -0400, Waiman Long wrote:
>>
>> On 9/4/23 04:33, Rafał Miłecki wrote:
>>> As those hangs/lockups are related to so many different changes it's
>>> really hard to debug them.
>>>
>>> This bug seems to be specific to the slow arch clock that affects
>>> stability only when kernel locking code and symbols layout trigger some
>>> very specific timing.
>>>
>>> Enabling CONFIG_PROVE_LOCKING seems to make issue go away but it affects
>>> so much code it's hard to tell why it actually matters.
>>>
>>> Same for disabling CONFIG_SMP. I noticed Broadcom's SDK keeps it
>>> disabled. I tried it and it improves stability (I had 3 devices with 6
>>> days of uptime and counting) indeed. Again it affects a lot of kernel
>>> parts so it's hard to tell why it helps.
>>>
>>> Unless someone comes up with some magic solution I'll probably try
>>> building BCM53573 images without CONFIG_SMP for my personal needs.
>>
>> All the locking operations rely on the fact that the instruction to acquire
>> or release a lock is atomic. Is it possible that it may not be the case
>> under certain circumstances for this ARM BCM53573 SoC? Or maybe some Kconfig
>> options are not set correctly like missing some errata that are needed.
>>
>> I don't know enough about the 32-bit arm architecture to say whether this is
>> the case or not, but that is my best guess.
> 
> So, BCM53573 is Cortex-A7, which is ARMv7, which has the exclusive
> load/store instructions. Whether the SoC has the necessary exclusive
> monitors to support these instructions is another matter, and I
> suspect someone with documentation would need to check that.

Finding documentation about this SoC has been very difficult 
unfortunately...

Would any of the lock or mutex debugging self test catch hardware 
designed without proper support for exclusive monitors in the DRAM 
controller? Keep in mind this is an uni-processor system however, does 
that mean we may have issues in our SMP_ON_UP alternative patching?
-- 
Florian
