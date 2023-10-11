Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F457C5000
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjJKKXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJKKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:23:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8450092;
        Wed, 11 Oct 2023 03:23:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A62C433C8;
        Wed, 11 Oct 2023 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697019807;
        bh=uzaVQqLOGJxWr+e1UKs6LqUdqccor/QwHqpTPeLLIjY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HR8fQApm8u948mV5ib/wShytLG4hsN8EqV9zfYTtJCYGcqDBF3rUzwHyc4F5UCe4E
         4sFTQcJ+sE15ZKutBAKB7M1Hkh7Ux1FGD6sTB8eRBKiIsFcn/I7RpZ+uL2NWvJFtZY
         ZqjZ30vP3ww5L5ngeju14Yg4i+a/84B40blyKwNNBwbUvm3hHnTTnMJWU8MHdoS8Hx
         EmBFUTKtEeZfULzqwOgxPcYEasB+uHE+E0fUito+FzWQMehuNlcRKqqQRwBYvDEr6+
         DBuCi6AYo4uYdovuZTMydGZ0DNug3AA4JGqtcrvI/ydsZWfUXFhmQZWcBdR+cp/mEx
         MYLX3cKc8sJpA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Neal Gompa <neal@gompa.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Dmitry Antipov <dmantipov@yandex.ru>,
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
Subject: Re: On brcm80211 maintenance and support
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
        <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
        <87ttr454bh.fsf@kernel.org>
        <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
        <e1ee4d76-f717-a67c-8099-7b91192ba1ca@yandex.ru>
        <e470902a-35eb-9bb4-7a9e-167f985c98bb@marcan.st>
        <CAEg-Je-mpcrEoM_nD3_8A=gZhdWpn3hxfGZNEfGRNupGwRdetw@mail.gmail.com>
Date:   Wed, 11 Oct 2023 13:23:22 +0300
In-Reply-To: <CAEg-Je-mpcrEoM_nD3_8A=gZhdWpn3hxfGZNEfGRNupGwRdetw@mail.gmail.com>
        (Neal Gompa's message of "Tue, 10 Oct 2023 10:52:56 -0400")
Message-ID: <87edi14fvp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neal Gompa <neal@gompa.dev> writes:

> On Sat, Oct 7, 2023 at 8:51=E2=80=AFAM Hector Martin <marcan@marcan.st> w=
rote:
>
>>
>> On 07/10/2023 00.48, Dmitry Antipov wrote:
>> > On 10/6/23 18:34, Hector Martin wrote:
>> >
>> >> For better or worse, if nobody else does, I'm willing to sign up to
>> >> maintain the chips shipping on Apple ARM64 machines (i.e. BCM4378,
>> >> BCM4387, BCM4388 - that last one I have bringup for downstream, just =
got
>> >> it done this week) and partially BCM4377 as a bonus (since I have acc=
ess
>> >> to an older Intel Mac with that one, and already did bringup for it,
>> >> though my access is sporadic). I'm already playing part time maintain=
er
>> >> anyway (other folks have already sent us patches I'll have to upstrea=
m),
>> >> and we need this driver to keep working and continue to support new c=
hips.
>> >
>> > Good news. Would you capable to consider some generic (not hooked to a=
ny
>> > particular hardware) things like [1] ?
>> >
>> > [1]
>> > https://lore.kernel.org/linux-wireless/20230703162458.155942-1-dmantip=
ov@yandex.ru/
>> >
>>
>> Sure, I've done cleanup type stuff myself too.
>>
>
> Can we please get this done so that the pile of Broadcom patches can
> actually start landing again? It's been frustrating watching patch
> submissions be ignored for over a year now. At least add Hector as a
> co-maintainer and allow him to land stuff people have been using
> outside to get Broadcom Wi-Fi to *work*.
>
> Having stuff sit on the pile and be *ignored* is frustrating for
> contributors and users, and massively disincentivizes people from
> working in upstream Linux.

Your email reminds me of this comic:

https://xkcd.com/2347/

In the last few years we seem to be getting more of these "Work faster!"
emails and honestly it's getting frustrating for us maintainers. If
Linux wireless is important for you then help us! You can review
patches, run tests on real hardware, write hwsim test cases[1], fix
compiler warnings[2] etc. to help us maintainers and speed up
development. There's so much to do and while you gain experience on the
wireless development you can help even more.

Also take it into account that it's not just simple to "take patches"
and be done with it. There are high quality requirements, the code needs
to have no compiler warnings and must not cause any regressions in
existing setups. That's not easy at all, especially as our hardware
testing is basically limited to few the most active drivers. And let
alone there are very exotic hardware out there and it's impossible to
test all of them.

If you have patches you want to submit to linux-wireless: please read
carefully our documentation (starting from the wiki link below) and then
go to the main Linux documentation[3]. Once you have a good
understanding how we prefer patches to be submitted, submit a patch. But
I always recommend starting from something small, taking baby steps and
learning from the feedback. This gives the best chances of patches being
accepted.

[1] https://lore.kernel.org/linux-wireless/ac1f3d9b81dbca244bdc8262e9d2ee44=
220f78c1.camel@sipsolutions.net/

[2] https://lore.kernel.org/linux-wireless/87fs2k5l1a.fsf@kernel.org/

[3] https://docs.kernel.org/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
