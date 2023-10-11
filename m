Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919297C520C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346239AbjJKL2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbjJKL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:28:41 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260938F;
        Wed, 11 Oct 2023 04:28:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BC4FF41D83;
        Wed, 11 Oct 2023 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1697023715; bh=xjP+LgFAl0MkpLgAGKhOSsA7ViOMicthTrbsCsfkTj0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DukLi+W8W3m7xUnCBTELLtRQkhgKots5M7siBJngDE1IRMcVgz1ExBx/Sykno/uvY
         EzAJhnL32o3FVssZe7pkTooIOXx1E33CppwbIRxrbBZdybLIJs+XQbHu4iWiwR4QqK
         gg0o4Du81BJeLD4P1QcX4Z+I0DZm7hbmAajRkq20ELOCebBOz0yisTktUw2CWyO9Uy
         sxdHYyTDXcwWrEbhNqylHKpjxM+F+TZEajVnVAjyaCpzLVtjFRjJ+0wv4x9Q64n/pC
         JAChprwddYCZKFtrztm+QyOjvIuYfnNq0xWZCdV/FwqlH1gjrSNxBh1CSavpgN6m73
         7UP0VfAXwEi5w==
Message-ID: <cce5765d-342f-4811-ab7f-fb41ede0b3a1@marcan.st>
Date:   Wed, 11 Oct 2023 20:28:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On brcm80211 maintenance and support
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Neal Gompa <neal@gompa.dev>
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
 <87edi14fvp.fsf@kernel.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <87edi14fvp.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/11 19:23, Kalle Valo wrote:
> Neal Gompa <neal@gompa.dev> writes:
> 
>> On Sat, Oct 7, 2023 at 8:51 AM Hector Martin <marcan@marcan.st> wrote:
>>
>>>
>>> On 07/10/2023 00.48, Dmitry Antipov wrote:
>>>> On 10/6/23 18:34, Hector Martin wrote:
>>>>
>>>>> For better or worse, if nobody else does, I'm willing to sign up to
>>>>> maintain the chips shipping on Apple ARM64 machines (i.e. BCM4378,
>>>>> BCM4387, BCM4388 - that last one I have bringup for downstream, just got
>>>>> it done this week) and partially BCM4377 as a bonus (since I have access
>>>>> to an older Intel Mac with that one, and already did bringup for it,
>>>>> though my access is sporadic). I'm already playing part time maintainer
>>>>> anyway (other folks have already sent us patches I'll have to upstream),
>>>>> and we need this driver to keep working and continue to support new chips.
>>>>
>>>> Good news. Would you capable to consider some generic (not hooked to any
>>>> particular hardware) things like [1] ?
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-wireless/20230703162458.155942-1-dmantipov@yandex.ru/
>>>>
>>>
>>> Sure, I've done cleanup type stuff myself too.
>>>
>>
>> Can we please get this done so that the pile of Broadcom patches can
>> actually start landing again? It's been frustrating watching patch
>> submissions be ignored for over a year now. At least add Hector as a
>> co-maintainer and allow him to land stuff people have been using
>> outside to get Broadcom Wi-Fi to *work*.
>>
>> Having stuff sit on the pile and be *ignored* is frustrating for
>> contributors and users, and massively disincentivizes people from
>> working in upstream Linux.
> 
> Your email reminds me of this comic:
> 
> https://xkcd.com/2347/
> 
> In the last few years we seem to be getting more of these "Work faster!"
> emails and honestly it's getting frustrating for us maintainers. If
> Linux wireless is important for you then help us! You can review
> patches, run tests on real hardware, write hwsim test cases[1], fix
> compiler warnings[2] etc. to help us maintainers and speed up
> development. There's so much to do and while you gain experience on the
> wireless development you can help even more.
> 
> Also take it into account that it's not just simple to "take patches"
> and be done with it. There are high quality requirements, the code needs
> to have no compiler warnings and must not cause any regressions in
> existing setups. That's not easy at all, especially as our hardware
> testing is basically limited to few the most active drivers. And let
> alone there are very exotic hardware out there and it's impossible to
> test all of them.

I think we need to qualify this "no regressions" "rule". People regress
our machines in mainline all the time. We catch it and get it fixed,
sometimes in RCs, sometimes it goes all the way to stable and needs to
get fixed there. We've had patches break everything from Bluetooth LE
pairing to core memory management to the point we needed earlycon to
diagnose it. That last one was a blatantly wrong patch to core Linux MM,
it wasn't even something specific to our platform, but even that got
past review (it just happened to break us specifically due to a
coincidence).

The review process doesn't magically avoid regressing things. "No
regressions" is impossible without someone actually testing things.
Claiming otherwise is dishonest. So if I end up as maintainer here I
certainly am not going to promise "no regressions" for chips I can't
test, without someone interested in those chips testing them. Of course
I'll take regression fixes when they do happen and someone notices, but
I can't know in advance until someone does.

Consider a patch that changes some codepath in the driver. I can't know
whether the original logic was always broken, or whether it worked on
some chips, and whether the new logic works on those chips or will
regress them, without testing. This is a regular occurrence with
brcmfmac, due to the complexity and variability of the firmware
interface. Often multiple versions of stuff are supported, or some
structures can be extended, but sometimes they can't. It's a mess, and
without firmware source code nor any official specs, there is no way to
know exactly what is intended and what the backwards compatibility
requirements are.

The only way to avoid that is to gratuitously introduce version/chip
gates for *every single change affecting behavior from the firmware
POV*, which is a complete non-starter and would quickly yield a giant
mess of spaghetti code. It's bad enough having to support explicit
ABI-breaking changes in firmware, and having to deal with multiple
versions of huge structures and convert between them. Trying to outright
keep existing logic identical for "other chips" is just not going to
happen, not without first having confirmation of what the requirements
are from someone who has the required docs/source.

I have a patch to enable WPA3 in Broadcom chipsets (yes, the driver is
in such a sorry state it doesn't even support that yet). The current
support attempt was added by a Cypress engineer and uses a completely
different firmware mechanism. Is that supposed to actually work? Does it
work currently? Is that the case for all Cypress firmwares? Or only
some? Does the alternate mechanism we have for Broadcom chips work too?
Only Cypress can answer those questions ahead of time, and they aren't
(they ignored me last time I brought this up). So my current patch just
replaces the mechanism with the known-working one for Broadcom chips.

Next time I send a bunch of our downstream patches, I'm going to resend
that WPA3 patch. And if it regresses Cypress WPA3 support, tough luck.
If someone catches it (Phil?) and it turns out the existing support is
the only way to do things on Cypress, I'll rework the patch to
conditionally support both styles. But if nobody does, and nobody cares,
then I'm sorry if I regress things, but there is no way to avoid it. We
can't be gratuitously gating every single change just to hope to avoid
regressions, without any confirmation of what is required. That just
doesn't scale.

Phil: Given Cypress' complete apathy towards this driver, if you want
the Cypress chips in Raspberry Pi systems to continue working and catch
potential problems ahead of time, it would be helpful if you can test
the patches in this branch. This is our downstream brcmfmac patchset.
Regardless of what ends up happening with the maintainer situation,
giving this a whirl will be very helpful in catching problems with
systems people actually use. It should be easy to bisect regressions too
(we keep this rebased directly on recent kernels so you can apply it on
top of your tree or whatever).

https://github.com/asahilinux/linux/tree/bits/080-wifi

- Hector
