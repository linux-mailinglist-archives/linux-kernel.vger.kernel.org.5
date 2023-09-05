Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C109792C09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352879AbjIERFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354732AbjIENye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:54:34 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C6197;
        Tue,  5 Sep 2023 06:54:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 631BE6C1B64;
        Tue,  5 Sep 2023 13:54:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EB55D6C0A37;
        Tue,  5 Sep 2023 13:54:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1693922068; a=rsa-sha256;
        cv=none;
        b=sfCdsw5E7KRHfj6qb6YmO0BB4kOSq1ntVsk3HDwmsQJck6haIW/8iUKzPmcIXyhpt5vBH7
        VTjGmv/72bIT6LlgcbX1Md07B4Wf+YsfgvZXPjCth/2v2b3+SMDl1UimP3LBY9eGgNnbKl
        Whxxc3kDAPysmpIW7HP/alr/kHYvZ4oapBBO4v+4zmwVKeCSr8D6TcVPZlDwoVnQsXwSpK
        xob4R0G+N2CTdgJJ+dJTxXku0Xf2kJVywzPuKX42gDGBCDY2utcDvDmx9899lBnVBJ0YU4
        JSRtGqp5z2b8OCPnAEtAdsfIYKlUGeax4rTdKxynqtSDjCPgG9HXM+w2qvHkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1693922068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=YSrH/KnkOMtWbkKTTQFyMqEbfklmyppO1MILJK4fgqs=;
        b=vq16WH467qElQg1T6C3st3Wj8VSqGT6UEEKI8vrS8kOPXgsp5gVJdMyFqq0KaYqlkZ/uZg
        O/F26JUOGdDV4KCbbjIMC4Ilwd+yZm8DijKRcvObd400cLfjbrXXeU3irSIGazVpE9+VE9
        3YxB7Qh+iNT6egJRtGyVFagEiZtUn0zH3ArZCQAxENPFhcazs/+qmFYvIamBPWK3KuBbvP
        6HgJKYJmlBQlZkHJZOiGxEUEuwz0PSKl8+eOPQUEeUuKEDf1c8LZvFIzzthMFwy8kzlNZ+
        sVCShbUwHxI5VkEX/m2V6VNqvNnvmgHXGKSpZ4N7SD3YsdVFzVHLq4X7EKzXvw==
ARC-Authentication-Results: i=1;
        rspamd-6fd95854bb-lb46n;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Macabre: 3b4a416e5ee73ca8_1693922068939_3873094390
X-MC-Loop-Signature: 1693922068939:3117084652
X-MC-Ingress-Time: 1693922068939
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.143.185 (trex/6.9.1);
        Tue, 05 Sep 2023 13:54:28 +0000
Received: from [192.168.1.36] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4Rg6SL751Rz1b;
        Tue,  5 Sep 2023 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1693922067;
        bh=YSrH/KnkOMtWbkKTTQFyMqEbfklmyppO1MILJK4fgqs=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=byyMlp3+1fl5LGzbfN+YOL6wXZCQgOTBOG5ipX8gUSEV5aBIGNLAGUa0qOaDEpUjM
         Y2otfwCbqxr5cEL4zZz8Gor4fXvs6PIC4Hs89+fF94NJmErxUG1Q9ytGovsXwCyK0A
         2vBUCAWQ+npgZBemO+yJo5xYRUnvrPSckmnUnMGP768hidm4JwYswMuCpi7uyanPdc
         L/dkujl4izMS183NDMUedFoNKSLq5GJz2yqhRb5qdRN8rdVa5vffj7k+P8Yzkf1Ey2
         cjxY1jRHbM9osKzbt8ABD7QUYvVUT8NgqAeCUYUKBguhhjqKMZ0dox4SKCG2cIwR5j
         zULsCfiaIa+JQ==
Message-ID: <07ef7b78-66d4-d3de-4e25-8a889b902e14@stancevic.com>
Date:   Tue, 5 Sep 2023 08:54:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     buczek@molgen.mpg.de, guoqing.jiang@linux.dev,
        it+raid@molgen.mpg.de, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, msmith626@gmail.com,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
 <20230822211627.1389410-1-dragan@stancevic.com>
 <ab757e2b-3ff0-33d9-d30c-61669b738664@huaweicloud.com>
 <2061b123-6332-1456-e7c3-b713752527fb@stancevic.com>
 <07d5c7c2-c444-8747-ed6d-ca24231decd8@huaweicloud.com>
 <cf765117-7270-1b98-7e82-82a1ca1daa2a@stancevic.com>
 <0d79d1f9-00e8-93be-3c7c-244030521cd7@huaweicloud.com>
 <ff996ffb-cba5-cc9b-2740-49ba4a1869b5@huaweicloud.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <ff996ffb-cba5-cc9b-2740-49ba4a1869b5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 22:50, Yu Kuai wrote:
> Hi,
> 
> 在 2023/08/30 9:36, Yu Kuai 写道:
>> Hi,
>>
>> 在 2023/08/29 4:32, Dragan Stancevic 写道:
>>
>>> Just a followup on 6.1 testing. I tried reproducing this problem for 
>>> 5 days with 6.1.42 kernel without your patches and I was not able to 
>>> reproduce it.
> 
> oops, I forgot that you need to backport this patch first to reporduce
> this problem:
> 
> https://lore.kernel.org/all/20230529132037.2124527-2-yukuai1@huaweicloud.com/
> 
> The patch fix the deadlock as well, but it introduce some regressions.

Ha, jinx :) I was about to email you that I isolated that change with 
the testing over the weekend that made it more difficult to reproduce in 
6.1 and that the original change must be reverted :)



> 
> Thanks,
> Kuai
> 
>>>
>>> It seems that 6.1 has some other code that prevents this from happening.
>>>
>>
>> I see that there are lots of patches for raid456 between 5.10 and 6.1,
>> however, I remember that I used to reporduce the deadlock after 6.1, and
>> it's true it's not easy to reporduce, see below:
>>
>> https://lore.kernel.org/linux-raid/e9067438-d713-f5f3-0d3d-9e6b0e9efa0e@huaweicloud.com/
>>
>> My guess is that 6.1 is harder to reporduce than 5.10 due to some
>> changes inside raid456.
>>
>> By the way, raid10 had a similiar deadlock, and can be fixed the same
>> way, so it make sense to backport these patches.
>>
>> https://lore.kernel.org/r/20230529132037.2124527-5-yukuai1@huaweicloud.com
>>
>> Thanks,
>> Kuai
>>
>>
>>> On 5.10 I can reproduce it within minutes to an hour.
>>>
>>
>> .
>>
> 

-- 
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

