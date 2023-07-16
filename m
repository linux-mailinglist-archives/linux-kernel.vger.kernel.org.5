Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854BA7550F2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGPTZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjGPTZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:25:08 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jul 2023 12:25:05 PDT
Received: from abi149hd126.arn1.oracleemaildelivery.com (abi149hd126.arn1.oracleemaildelivery.com [129.149.84.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF69E4C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=vhgu6g5YOVEL+bJ5PxdEHK2qtn3eZn9eR/zLiwfZlaw=;
 b=P9lof9HpebDSDc+dr53P7w+3+JDFVCVdkKbxjf7k7Gu2pZKFdwed2wDWWdpCW0arOajdxpsWPLfQ
   75Ba7m9812h8XqdZK+9rQugmGU9imufmoQnUdNMIWK81EmB+t+e8kmGJktZ1zFFnYCTP4gpIjrv7
   h9jsi5riGHbUWdh15fHr+wIOTU66r6sgEua4P6TXLXs0b8Vm1BIuXZiY/aV+wl7Z0rcLnhaFU5dr
   Zmn3JgH7aIMEP0F8VbqJ6CsFaWXgAiPdninjtvm+e1+kd9un5hZpa7rRK5mJ3V2A5y+F/kbQQqtD
   aUwbwuo4oUA0Sbz7TIYyFG0CPec4MaO68MbRdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=vhgu6g5YOVEL+bJ5PxdEHK2qtn3eZn9eR/zLiwfZlaw=;
 b=fXol21WpT09sXeHr0iRWb36UzH2rcKW4jwdaK69PIjLTop8+Ojs5XRqc9T1ls8+MfHoIQWqs6OO/
   Cjuk4Ksv+HRIt1Tries36yusEIjiUAiF9LIqrYSgcEejCUnig2Ca3zzpZTFyqeFieTWyNVd8dS8O
   ZJtbK4Dj5wb+me6y78J41eOsYXAP4HKG2uibbYqflot79tSAiIeGs/d7PWG6AORoVr8HAAyDRfn/
   IWqj26LzGgjewYzQKO8Sda8d7ZHaBYnAftMBlpAZJM7KB8v87BgwdkWh550E4avzW2I8SDYoB3J4
   TeeDe9qVJknI3VS0gEH7o3w30Sl83tIAuCkYaA==
Received: by omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RXW007UCLPCV720@omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Sun, 16 Jul 2023 19:20:00 +0000 (GMT)
Message-id: <d0ce0f3b-9407-9207-73a4-3536f0948653@augustwikerfors.se>
Date:   Sun, 16 Jul 2023 21:19:56 +0200
MIME-version: 1.0
From:   August Wikerfors <git@augustwikerfors.se>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV (Samsung
 SM-953 Datacenter SSD)
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        =?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
 <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
Content-language: en-US
In-reply-to: <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAET+Clyr9vC9JSs59PNNgJ3bR0x5ue9VFjv5oHhEYeaYfKHXsjMXts9hrb6tWeU
 2lKXLDIjDyswKdI7ODl2Sy6Uejyk2PwirMox5k1amJtObCMmjVcSafeZK/xrEVIo
 MMSZrQupb9nNJa8RLZjWnhqMh0kygZOUtdcTOyBaVkjl8kuuad0yf8ObQE2WgZnR
 wt+O+q9xC/rvX3FMBKEEuaI/XutZE5C5Oz/t6miNzTwjN/XjhwV27z5bZFs+OoQM
 DFLKQO461accRDEcK1EePLLMQD2w7jV4oJOzL0iFq2oWUC5JdXwvAFiDBhspVvQ2
 MoN35HNsAHM6blYXaH6gqCZLiy7V5yx5Ph/yBSmHz1ILg7k5P3s9TnWy1Iba99Ys
 XxSWDkjB/JCr0yexO+8RYedZZtnCvDRWhADwcVA7dib6RpdHp6aCO+HO0afcBHrT 8bETdTg=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-11 08:54, Pankaj Raghav wrote:
>>> Another request came in today, even with a pseudo-patch:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217649
>>>
>>> To quote:
>>> ```
>>> As with numerous NVMe controllers these days, Samsung's
>>> MZAL41T0HBLB-00BL2, which Lenovo builds into their 16ARP8 also suffers
>>> from invalid IDs, breaking suspend and hibernate also on the latest
>>> kernel 6.4.2.
>>>
>>> The following change restores this functionality:
>>>
>>> File: root/drivers/nvme/host/pci.c
>>> Change:
>>>
>>> -	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
>>> -		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>>>
>>> +	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G, 512G and 1TB */
>>> +		.driver_data = NVME_QUIRK_BOGUS_NID |
>>> +				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>>
>> Panjaj, okay with this one too?
> 
> This looks a like a new device that might have a firmware update. I will ping
> internally first.

(Note that this is a different issue from the regression in this thread)

I reported this back in November [1] and was told by Kanchan Joshi at
Samsung that it was fixed in new firmware [2]. Lenovo was also contacted
and said they were working on the update in December [3]. I'm not sure
what happened then, but in March, Mark Pearson at Lenovo wrote [4]:

> I'm stuck on this one - the FW team reached out to Samsung to see if 
> there were fixes that we should be picking up and Samsung reported back 
> that there are no Linux issues reported against this part :(

The release process then seems to have started over [5] and the latest
update as of May is that the update is supposed to be released this month.

[1] https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/
[2] https://lore.kernel.org/all/20221206055928.GB24451@test-zns/
[3] https://github.com/tomsom/yoga-linux/issues/9#issuecomment-1368013293
[4] https://github.com/fwupd/firmware-lenovo/issues/308#issuecomment-1466631468
[5] https://forums.lenovo.com/topic/findpost/27/5196929/5984302
