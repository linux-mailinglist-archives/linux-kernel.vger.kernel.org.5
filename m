Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9723A7CD5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjJRH5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjJRH5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:57:23 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 00:57:20 PDT
Received: from mailfilter03-out21.webhostingserver.nl (mailfilter03-out21.webhostingserver.nl [141.138.168.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB38C6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:57:20 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; t=1697615777; cv=pass;
        d=webhostingserver.nl; s=whs1;
        b=FrqoSocbKsga/yjWi1uMz59PV6EZHdleEvh0sTQ+PdKpoBvtGdbQyUI3ycyZTSbX+JuPWteNAYGt/
         8pBz4GsK7gxJVgmC2qPrP3j/lS6WwUi3KWyxcAw3LUpl47lNA4jfXKQvLkCWpB9QAXHCVWPAWzp4LT
         eMs9/g32rY12ikjgh8/3COVIbbVtPIKR5Zt4plnc3ho4rlgIrHtUSmX9SJ0WSTfgg6G/F/f0TffMpM
         PLi1p9gw8plaDfADATz6yiHbB7pinAeYk536xn37axCgmZQhKw7ZusdkisMhjTuwhUW9n54aTixYr+
         bFuNRSNtCZeiqrP8RJMLdkq2dMVIovw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
        d=webhostingserver.nl; s=whs1;
        h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
         subject:mime-version:date:message-id:from;
        bh=bCMmrlFwAvrWN8g8e+0vUbcMSjYHdLsLN6yIuMSXRak=;
        b=BHi2Xn7vfTBPh+74etLsId+dl2oyhL54EpcGfNl9VVuwL9QQfEVT+6R9LowbZMec1+ZfOx5RNS4pX
         jcRpVf53QT61WBo7P+g+C4/RkKVlWh0xe4AkWX32r6u/zwV+3iXDP1MOWwD5cSTxy5zXvbodboY4tm
         mF6NIWKkvbtks/jCCmJp79ymIL+vcFR03x2Mt1GwPOjJi363iwOSk32ZoxyWWWXiFELBbdaYdOeXix
         nDMSffh+q9pUU1yQqxPzGLHtdTe/GOES7Sq68pfPErfxK7aKJBrA93+0u+YFlGTLnTMZwGhicTKM6p
         HLqrncwMrN7NDhMJ9RgE43+yA194ubQ==
ARC-Authentication-Results: i=2; mailfilter03.webhostingserver.nl;
        spf=softfail smtp.mailfrom=gmail.com smtp.remote-ip=141.138.168.154;
        dmarc=fail header.from=gmail.com;
        arc=pass header.oldest-pass=0;
X-Halon-ID: d00adb21-6d8b-11ee-8141-001a4a4cb9a5
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter03.webhostingserver.nl (Halon) with ESMTPSA
        id d00adb21-6d8b-11ee-8141-001a4a4cb9a5;
        Wed, 18 Oct 2023 09:56:15 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1697615775;
         b=ohI9l0MJMzA7AqTvegvDxUlj9J8guVA3LpXwkdMgRLNabFNCzewDnm6xENgwvuIEF/c1uAgdkq
          Y6M2/S25t97oB82x4dOKefF+nXk+D9hjriY11miFf8FL/PLG5N8veqWxXURNjjm7RWuI1Tf933
          IY2kV9dUZMPwb3iTpDT2P7hH27hKBxYOeWVdyCVft3soYe8r0Pf4QrR7U05S6XijmLE6MjfU9S
          p0OdQT11xpSZ9KdUsqtPg4RI9n6eUtdxHphKnaUWJ50odMtoeUKZPktgtLIArUe1mLFFeDn+PD
          /vmAm+5/lRRIbbqo0afaZU7+7zxt9Hf+EoIw3IHwkIGBnA==;
ARC-Authentication-Results: i=1; webhostingserver.nl;
        iprev=pass (cust-178-250-146-69.breedbanddelft.nl) smtp.remote-ip=178.250.146.69;
        auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
        spf=softfail smtp.mailfrom=gmail.com;
        dmarc=skipped header.from=gmail.com;
        arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1697615775;
        bh=wVYVNzCKcfcbPyUq3XxKINDaNN4vZG510fcqLrJT0cA=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
          Subject:MIME-Version:Date:Message-ID;
        b=pNyKvkyAOCB1Ta1VfoBsF4xsb8oadUO0ld+lvusZkHp/NT/vDJbAyeTZ6QbX0ZfATS5cRqQs0C
          EByafAUrdfpgv4BAqrxptxeDT/DCdWTsy21khrOcsaZmWAw6bOOLkG1jXjgNrHzl00iWn5AMRf
          77AA25+u7eAnYSdv+V8AwucfavZnUIHshZTkNr9pTq0wzV3g5Fm8zVpeimEpZg9NboPTpvad6R
          F/FqrHNPEe+vQfBKqSIQx/z3tHUSy+s22OVZgU5rNjERdy+RIna3dNPR4/CRsnRWFeJQc7qskv
          8tDmEbDWCMGe6gZE/ay++QmutO7dXbOyErOhDTfh8bomww==;
Authentication-Results: webhostingserver.nl;
        iprev=pass (cust-178-250-146-69.breedbanddelft.nl) smtp.remote-ip=178.250.146.69;
        auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
        spf=softfail smtp.mailfrom=gmail.com;
        dmarc=skipped header.from=gmail.com;
        arc=none
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=smtp)
        by s198.webhostingserver.nl with esmtpa (Exim 4.96.2)
        (envelope-from <fntoth@gmail.com>)
        id 1qt1Pb-00D8QQ-0b;
        Wed, 18 Oct 2023 09:56:15 +0200
Message-ID: <ec01f39e-367a-4ee6-8536-3992196ef8de@gmail.com>
Date:   Wed, 18 Oct 2023 09:56:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in
 find_pinctrl()"
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
 <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
 <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
 <ZS7kY/+80Be4geGM@smile.fi.intel.com> <ZS7_5VGvRnw99gzd@google.com>
Content-Language: en-US, nl
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <ZS7_5VGvRnw99gzd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ACL-Warn: Sender domain ( gmail.com ) must match your domain name used in authenticated email user ( ferry.toth@elsinga.info ).
X-ACL-Warn: From-header domain ( gmail.com} ) must match your domain name used in authenticated email user ( ferry.toth@elsinga.info )
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(resend due to html reject)

On 17-10-2023 23:43, Dmitry Torokhov wrote:
> Hi Andy,
> 
> On Tue, Oct 17, 2023 at 10:45:39PM +0300, Andy Shevchenko wrote:
>> On Tue, Oct 17, 2023 at 08:59:05PM +0200, Linus Walleij wrote:
>>> On Tue, Oct 17, 2023 at 8:34 PM Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>> On Tue, Oct 17, 2023 at 08:18:23PM +0200, Linus Walleij wrote:
>>>
>>>>> In the past some file system developers have told us (Ulf will know)
>>>>> that we can't rely on the block device enumeration to identify
>>>>> devices, and requires that we use things such as sysfs or the
>>>>> UUID volume label in ext4 to identify storage.
>>>>
>>>> While I technically might agree with you, this was working for everybody
>>>> since day 1 of support of Intel Merrifield added (circa v4.8), now _user
>>>> space_ is broken.
>>>
>>> Actually, I don't agree with that, just relaying it. I would prefer that we
>>> solve exactly the problem that we are facing here: some random unrelated
>>> code or similar affecting enumeration order of mmc devices.
> 
> Sorry, but the era of static configuration where one has a well defined
> order in which things are probed and numbered has long gone. The right
> answer is either device aliases that provides stable numbering on a
> board that is not dependent on scheduler behavior, mutexes
> implementation (how they deal with writer starvation, etc),
> kernel/driver/subsystem linking order and myriad other things, or
> mounting by UUID. The kernel does not provide any guarantees on the
> stability of device probe and instantiation order.
> 
> If you think about it it is the same issue as legacy GPIO numbering.
> It was convenient some time ago, but now it is no longer suitable or
> sufficient and could change when kernel is uprevved.
> 
>>>
>>> It's not the first time it happens to me, I have several devices that change
>>> this enumeration order depending on whether an SD card is plugged
>>> in or not, and in a *BIG* way: the boot partition on the soldered eMMC
>>> changes enumeration depending on whether an SD card is inserted
>>> or not, and that has never been fixed (because above).
>>
>> This is not the problem I have. I haven't added any SD card, hardware
>> configuration is the same. The solely difference in the whole setup is
>> this revert applied or not.
> 
> Yes, I guess there is a contention on this mutex and the fact that we
> are now taking it once and not twice makes difference in which probes
> happen. If you look at the logs, you will see that even before the patch
> controllers did not enumerate on the order of PCI functions:
> 
> [   36.439057] mmc0: SDHCI controller on PCI [0000:00:01.0] using ADMA
> [   36.450924] mmc2: SDHCI controller on PCI [0000:00:01.3] using ADMA
> [   36.459355] mmc1: SDHCI controller on PCI [0000:00:01.2] using ADMA

You are referring to the order printed in dmesg. But actually

mmc0 = 0000:00:01.0
mmc1 = 0000:00:01.2
mmc2 = 0000:00:01.3

And this has been so for like 8 years. See f.i. 
https://github.com/edison-fw/meta-intel-edison/issues/135
(this is with Yocto, so using systemd, the issue discussed there is not 
related to this but to card detection iirc)

> So you have mmc2 instantiated before mmc1 even before the patch. This
> happens because we now have
> 
> 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> 
> in sdhci_driver structure in drivers/mmc/host/sdhci-pci-core.c. It just
> happened that even with asynchronous probing your storage did end up on
> mmc0 originally and you were happy.
> 
> I wonder, could you please post entire dmesg for your system?
> 
>>
>>>>> That said, device trees are full of stuff like this:
>>>>>
>>>>>          aliases {
>>>>>                  serial0 = &uart_AO;
>>>>>                  mmc0 = &sd_card_slot;
>>>>>                  mmc1 = &sdhc;
>>>>>          };
>>>>
>>>> And Rob, AFAIU, is against aliases.
> 
> Rob might not want them, but they are the reality and are present for
> multiple classes of devices and I believe are here to stay.
> 
>>>>
>>>>> Notice how this enumeration gets defined by the aliases.
>>>>>
>>>>> Can you do the same with device properties? (If anyone can
>>>>> answer that question it's Dmitry!)
>>>>
>>>> No, and why should we?
>>>
>>> Because device properties are not device tree, they are just some
>>> Linux thing so we can do whatever we want. Just checking if
>>> Dmitry has some idea that would solve this for good, he usually
>>> replies quickly.
>>
>> OK.
> 
> I think the right answer is "fix the userspace" really in this case. We
> could also try extend of_alias_get_id() to see if we could pass some
> preferred numbering on x86. But this will again be fragile if the
> knowledge resides in the driver and is not tied to a particular board
> (as it is in DT case): there could be multiple controllers, things will
> be shifting board to board...
> 
> Thanks.
> 

