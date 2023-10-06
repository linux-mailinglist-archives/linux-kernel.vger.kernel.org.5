Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4027BBBCD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjJFPfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjJFPfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:35:09 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1023DB9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:35:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6B244421F5;
        Fri,  6 Oct 2023 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1696606505; bh=1Z3KuS4rx7bn81F7tENVoClM2+k0q9jEwhyEsQupDdg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tDEEQbdME4GndqtMiJjqUz60zNKaoTQs54bDYzA3C+4rfhhCUurDvHhJ/5g5pAUy9
         xk752ySe5+znYA4nkQR58bXz+iMXc5RhN2ZOvxSRfu2dClUk/HYUqgnVsq1Lrr9DE0
         2OcOzBFQS9i3YtGWY4Gzd7cEs7JrdXYIkniRfHAazudq5lgXhuWEXY4mbRZAm9Gyfg
         wZSkg+d3lUOEGay9QVxMz5rhJiTXjoLqbuLAAPgcv8Aba20uckBd6rNsvcyrKhwLhx
         PGUWairqUkk9w3dC3Tl0C+SFI/wZqlK6Loc1v9pVX+FtnvN8mn7xotDa3YIuWUtEmX
         XI8jU4DlhGGEA==
Message-ID: <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
Date:   Sat, 7 Oct 2023 00:34:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: On brcm80211 maintenance and support
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com,
        Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <87ttr454bh.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 21.21, Kalle Valo wrote:
> Julian Calaby <julian.calaby@gmail.com> writes:
> 
>> Hi Dmitry,
>>
>> (relevant people and lists CC'd)
>>
>> On Fri, Oct 6, 2023 at 3:16 AM Dmitry Antipov <dmantipov@yandex.ru> wrote:
>>>
>>> Kalle,
>>>
>>> what's an actual status of brcm80211 driver? It seems
>>> that the relevant MAINTAINERS entries are no longer
>>> useful, and [1] states that Broadcom is just "disappeared".
>>
>> Arend hasn't posted since February:
>> https://lore.kernel.org/linux-wireless/63f72045-e51d-d9a4-a0ed-c221bcdcee03@gmail.com/
>>
>> Franky is still reviewing things as of early August:
>> https://lore.kernel.org/linux-wireless/CA+8PC_evb-6Y3dKnAN4BN=ODEVxY5-cDb6Lc72u0j1WBtx7p1A@mail.gmail.com/
>>
>> Hante hasn't posted since 2018:
>> https://lore.kernel.org/linux-wireless/4f6223b8083ed69432493a37d4f45b69@mail.gmail.com/
>>
>> Hector Martin has a bunch of Apple-specific patches downstream in the
>> Asahi Linux kernel and has been looking for guidance on how to
>> upstream it without any real answers:
>> https://lore.kernel.org/linux-wireless/181af6e9-799d-b730-dc14-ee2de2541f35@marcan.st/
>>
>> There's also speculation that the Raspberry Pi people have downstream
>> patches too, but I haven't been able to find anything concrete in a
>> very brief search.
> 
> Thanks for the research, that is helpful.
> 
>> Finally, the Cypress / Infineon people appear to be uninterested in
>> discussing the driver.
>>
>> I think it's pretty safe to say that this driver is nearly
>> unmaintained by Broadcom, definitely unmaintained by Cypress /
>> Infineon and Arend is unable to answer questions relating to anything
>> beyond the code as-written.
>>
>> Kalle, should this driver get orphaned?
> 
> We definitely need to consider that but let's first wait for Arend to
> comment.
> 

For better or worse, if nobody else does, I'm willing to sign up to
maintain the chips shipping on Apple ARM64 machines (i.e. BCM4378,
BCM4387, BCM4388 - that last one I have bringup for downstream, just got
it done this week) and partially BCM4377 as a bonus (since I have access
to an older Intel Mac with that one, and already did bringup for it,
though my access is sporadic). I'm already playing part time maintainer
anyway (other folks have already sent us patches I'll have to upstream),
and we need this driver to keep working and continue to support new chips.

I don't have much time to work on new feature development beyond the
basics (STA mode) but I will gladly take patches to add/fix new stuff
from others and test them. I'm in a decently good position to test
across all the aforementioned chips, and even ship that stuff ahead of
time in our downstream tree and get tons of user testing before it goes
upstream. Someone already volunteered a patch to fix AP mode that is
going into our next downstream kernel builds as well as 6GHz support
from someone else. I also have a decently modern home WiFi network
(UniFi) so I can set up test SSIDs with specific characteristics and
whatnot.

However, I make no promises about any other chips. I *especially* make
no promises about Cypress / Infineon variants, since as far as I can
tell they seem completely uninterested in working with anyone. If they
were consistent it wouldn't be a big deal, but it seems they are
increasingly forking the firmware ABI, and without cooperation from them
there is just no chance whatsoever to support their stuff, and I'm not
going to sign up to do their job. I have more than enough work figuring
out Broadcom's chips without their help.

As for Broadcom, the right logic to gate firmware API structure changes
is often anyone's guess. Sometimes they have actual feature flags we can
use, sometimes they don't, and when it's based on WL version there's no
chance anyone outside of Broadcom knows what the specific supported
branches are with accuracy. So basically, any time we get this wrong we
might break some chips/firmwares, and there is no way to know. All I can
do is make sure the chips Apple ships work with the firmwares Apple
ships. No more, no less.

For reference on just how painful this is without Broadcom's help, this
week I spent an entire day figuring out a single line of code that I had
to remove (gate) to stop BCM4388 firmware from crashing and asserting on
startup. And that is having access to (some random fork I found on
GitHub of) the "open source" bcmdhd driver with support for that chip -
even with that, it's picking out a needle in a haystack, and I often end
up porting/reimplementing random features from it we don't actually need
just hoping I can eventually find the "magic" thing that makes it work.
This time around, lovely Broadcom even decided to censor out some
headers so I had to reverse engineer some stuff by tracing what Apple's
driver does. It can be done, and I will get it done, but only for our
chips, there is no chance in hell I can afford to spend time on anything
else.

- Hector

