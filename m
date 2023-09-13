Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4433679EACA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbjIMORA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbjIMOQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:16:58 -0400
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AABEB2;
        Wed, 13 Sep 2023 07:16:54 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0CDB9542061;
        Wed, 13 Sep 2023 14:16:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 89E8E542398;
        Wed, 13 Sep 2023 14:16:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694614613; a=rsa-sha256;
        cv=none;
        b=6mKAiU0JwxLp36VmSFi9xPTZiMRpBEdJOmunCF7WiqXKk3JC5pE7t4qf/g9UUXmWCMkNQH
        0hkr+ddh8Y0xGh6wmcTKHnhJKRnbbJ2yQLlLP1YpAOg759wIjjRp8pPBDzRFgYbhyi88Wu
        CDqS1JFQggOLjazTuVxlo+HGpYrgYgpe/L9Hsaa6DG+YYqGssWx/9nOfNrE/vYPPIa6LKC
        jf7ioADCu1OBcHuVYQje3TNupVE7OzSbbNmMEpdKQFJ3zsLp99piKkbRTwn0tJ8kyXB72b
        pwK3wCgnz3Av4/Z5fjCc3tJEZ5GF20tPqiDFBasbdYoVE/i6jymmLVFfQAWnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694614613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=1DKFNQllzrV9eZeU0aVABV+6edyBMccXnjBCMPUTXpQ=;
        b=pzSar+oNlVyioKwzbtIvEgTJ7obl7CV4CXQiEjDoiSTiEDG7hUaRAoUvgOAHDthBmkbowS
        fDsaWczBf8HAcSAyNscqhmpFGYzv2LL4frKnQIN7fqV0H2lvONrmC0fckxqLoMnSHwE/Ya
        2OfsmrO0x3QVcd6vTrPQukk6VZYH01BDYMCyqm6BICFz+yE9FZKt7525k8JX6Qo7VGEKH8
        CXmBJCjzoLP/XEmyZ815t1MNxtULSE5p2Vu7D4udK+YRIIIKX9Dpm/Lm8AGI1llqNL+APZ
        mtyhxWOSdVR5kj5fyi4hrYv3iqT19vyDTE2EyZ4YKDDcFFfUHLukfxuD3zbn3g==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-8cr6t;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Plucky: 64ac6f8714804cba_1694614613876_327740246
X-MC-Loop-Signature: 1694614613876:1643764199
X-MC-Ingress-Time: 1694614613876
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.118.211.220 (trex/6.9.1);
        Wed, 13 Sep 2023 14:16:53 +0000
Received: from [192.168.1.36] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4Rm2ZX3Ljyz4g;
        Wed, 13 Sep 2023 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1694614613;
        bh=1DKFNQllzrV9eZeU0aVABV+6edyBMccXnjBCMPUTXpQ=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=toKN/NmE5+LNusMkauBaRoa9bnNA0xX/RCkOLXxYcZzLPqLzdiQI2yzWm4894PRkJ
         Q943ofbQJLlW7asFJ/Eig1Liel4ZEJY65E2KZPG3Ss9bsc36oT9l/vrVjTJaDK1DxM
         MEg2PRxOAsKfgMkqCt9HLYM/+gb3kPv5YmOJCJ7EH8zzMSe132Ay6+rZOsUYFeotbT
         aN3aPUdm8zkIHwfIV13yDNY2ZsaZHwIXO1XslYmASno307HhssFfw9DGpqIfgl9vIU
         5MEt4+rxHdGhNdZaCB1K9e1Nwnq/4x4qrvLFNB4aUIiJJTVgDjn5/I1Q/7LWgcuoi6
         ifBhaAzXam7JA==
Message-ID: <de7f6fba-c6e0-7549-199e-36548b68a862@stancevic.com>
Date:   Wed, 13 Sep 2023 09:16:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
Content-Language: en-US
To:     Donald Buczek <buczek@molgen.mpg.de>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     guoqing.jiang@linux.dev, it+raid@molgen.mpg.de,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        msmith626@gmail.com, "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
 <20230822211627.1389410-1-dragan@stancevic.com>
 <ab757e2b-3ff0-33d9-d30c-61669b738664@huaweicloud.com>
 <2061b123-6332-1456-e7c3-b713752527fb@stancevic.com>
 <07d5c7c2-c444-8747-ed6d-ca24231decd8@huaweicloud.com>
 <cf765117-7270-1b98-7e82-82a1ca1daa2a@stancevic.com>
 <0d79d1f9-00e8-93be-3c7c-244030521cd7@huaweicloud.com>
 <ff996ffb-cba5-cc9b-2740-49ba4a1869b5@huaweicloud.com>
 <07ef7b78-66d4-d3de-4e25-8a889b902e14@stancevic.com>
 <63c63d93-30fc-0175-0033-846b93fe9eff@molgen.mpg.de>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <63c63d93-30fc-0175-0033-846b93fe9eff@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Donald-

On 9/13/23 04:08, Donald Buczek wrote:
> On 9/5/23 3:54 PM, Dragan Stancevic wrote:
>> On 9/4/23 22:50, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2023/08/30 9:36, Yu Kuai 写道:
>>>> Hi,
>>>>
>>>> 在 2023/08/29 4:32, Dragan Stancevic 写道:
>>>>
>>>>> Just a followup on 6.1 testing. I tried reproducing this problem for 5 days with 6.1.42 kernel without your patches and I was not able to reproduce it.
>>>
>>> oops, I forgot that you need to backport this patch first to reporduce
>>> this problem:
>>>
>>> https://lore.kernel.org/all/20230529132037.2124527-2-yukuai1@huaweicloud.com/
>>>
>>> The patch fix the deadlock as well, but it introduce some regressions.
> 
> We've just got an unplanned lock up on "check" to "idle" transition with 6.1.52 after a few hours on a backup server. For the last 2 1/2 years we used the patch I originally proposed with multiple kernel versions [1]. But this no longer seems to be valid or maybe its even destructive in combination with the other changes.
> 
> But I totally lost track of the further development. As I understood, there are patches queue up in mainline, which might go into 6.1, too, but have not landed there which should fix the problem?
> 
> Can anyone give me exact references to the patches I'd need to apply to 6.1.52, so that I could probably fix my problem and also test the patches for you those on production systems with a load which tends to run into that problem easily?

Here is a list of changes for 6.1:

e5e9b9cb71a0 md: factor out a helper to wake up md_thread directly
f71209b1f21c md: enhance checking in md_check_recovery()
753260ed0b46 md: wake up 'resync_wait' at last in md_reap_sync_thread()
130443d60b1b md: refactor idle/frozen_sync_thread() to fix deadlock
6f56f0c4f124 md: add a mutex to synchronize idle and frozen in 
action_store()
64e5e09afc14 md: refactor action_store() for 'idle' and 'frozen'
a865b96c513b Revert "md: unlock mddev before reap sync_thread in 
action_store"

You can get them from the following tree:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git


> 
> Thanks
> 
>    Donald
> 
> [1]: https://lore.kernel.org/linux-raid/bc342de0-98d2-1733-39cd-cc1999777ff3@molgen.mpg.de/
> 
>> Ha, jinx :) I was about to email you that I isolated that change with the testing over the weekend that made it more difficult to reproduce in 6.1 and that the original change must be reverted :)
>>
>>
>>
>>>
>>> Thanks,
>>> Kuai
>>>
>>>>>
>>>>> It seems that 6.1 has some other code that prevents this from happening.
>>>>>
>>>>
>>>> I see that there are lots of patches for raid456 between 5.10 and 6.1,
>>>> however, I remember that I used to reporduce the deadlock after 6.1, and
>>>> it's true it's not easy to reporduce, see below:
>>>>
>>>> https://lore.kernel.org/linux-raid/e9067438-d713-f5f3-0d3d-9e6b0e9efa0e@huaweicloud.com/
>>>>
>>>> My guess is that 6.1 is harder to reporduce than 5.10 due to some
>>>> changes inside raid456.
>>>>
>>>> By the way, raid10 had a similiar deadlock, and can be fixed the same
>>>> way, so it make sense to backport these patches.
>>>>
>>>> https://lore.kernel.org/r/20230529132037.2124527-5-yukuai1@huaweicloud.com
>>>>
>>>> Thanks,
>>>> Kuai
>>>>
>>>>
>>>>> On 5.10 I can reproduce it within minutes to an hour.
>>>>>
>>>>
>>>> .
>>>>
>>>
>>
> 
> 

-- 
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

