Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344547F3077
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjKUOPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjKUOPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:15:45 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8F610C8;
        Tue, 21 Nov 2023 06:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1700576138; x=1700835338;
        bh=w6t3q7QiWYrDWual5a1/k9jSpxXTVHrIAMwIDut4tJ8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ylDvzFC7K1X2DMe57S7NqIa9Pn+wuA3+9DagRAm8S15QY8XKyJQDM2bbNSvxZnQwW
         5vtCk9ACjQT1uYSByu104tw9pN6pb6KejP3JnRDH81TE1yfAm514FyOrkeX0Z0JplE
         0BDsAz2xDyquXRomdmc9zs78QlXvHxK2gs/X0oaQaNWevTvsK97gfxnuqDIDpy9OS9
         y2fTBOmeXvs3fNMRQW/zkY39GBNK/Sa9wZr2e671N4hNQYmTKBLFfQ+gLP6K+J+h/i
         iH0pEilx8NJEV+MxlwEA+l+t9O3rYf9ilKvSCxUFEgfficB0lpzBpK1CSK+VwU2RIr
         konvICt6dTGwA==
Date:   Tue, 21 Nov 2023 14:15:31 +0000
To:     Jiri Kosina <jikos@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
From:   Mavroudis Chatzilazaridis <mavchatz@protonmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        =?utf-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        LinuxCat <masch77.linuxcat@gmail.com>,
        Marcelo <mmbossoni@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: Logitech G915 Wireless Keyboard acts weird on 6.6.0
Message-ID: <4071999d-77ca-4a75-a9e0-d8ccac0dada1@protonmail.com>
In-Reply-To: <nycvar.YFH.7.76.2311211435050.29220@cbobk.fhfr.pm>
References: <6929ebbf-f2e0-4cd4-addc-1e33ecf3277f@gmail.com> <ZVyr-of1X4RudpWG@archie.me> <nycvar.YFH.7.76.2311211435050.29220@cbobk.fhfr.pm>
Feedback-ID: 20039310:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-21 15:37, Jiri Kosina wrote:
> On Tue, 21 Nov 2023, Bagas Sanjaya wrote:
>=20
>> Hi Thorsten and all,
>>
>> On Thu, Nov 02, 2023 at 09:11:42PM +0700, Bagas Sanjaya wrote:
>>> Hi,
>>>
>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>
>>>> Hello,
>>>> After upgrading from 6.5.9 to 6.6.0, my keyboard started acting really=
 weird in its wireless mode, key actions sent are completely wrong, see vid=
eo attached.
>>>>
>>>> Most keys are perceived as either E, 3 or F7, with F8 and <, as well.
>>>>
>>>> Modifier keys (CTRL, ALT, ALT GR, Shift and Super) are working normall=
y, as well as media control keys (pause/play, previous, next, mute and soun=
d up/down).
>>>>
>>>> The keyboard works as expected if it's wired.
>>>
>>> Another reporter bisected the regression:
>>>
>>>> Bisected to
>>>>
>>>> 9d1bd9346241cd6963b58da7ffb7ed303285f684 is the first bad commit
>>>> commit 9d1bd9346241cd6963b58da7ffb7ed303285f684
>>>> Author: Mavroudis Chatzilazaridis <mavchatz@protonmail.com>
>>>> Date: Sun Jul 16 18:23:44 2023 +0000
>>>>
>>>> HID: logitech-dj: Add support for a new lightspeed receiver iteration
>>>>
>>>> The lightspeed receiver for the Pro X Superlight uses 13 byte mouse re=
ports
>>>> without a report id. The workaround for such cases has been adjusted t=
o
>>>> handle these larger packets.
>>>>
>>>> The device now reports the status of its battery in wireless mode and
>>>> libratbag now recognizes the device and it can be configured with Pipe=
r.
>>>>
>>>> https://github.com/libratbag/libratbag/pull/1122
>>>>
>>>> Co-developed-by: Filipe La=C3=ADns <lains@riseup.net>
>>>> Signed-off-by: Filipe La=C3=ADns <lains@riseup.net>
>>>> Signed-off-by: Mavroudis Chatzilazaridis <mavchatz@protonmail.com>
>>>> Reviewed-by: Bastien Nocera <hadess@hadess.net>
>>>> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>>>>
>>>> drivers/hid/hid-ids.h | 1 +
>>>> drivers/hid/hid-logitech-dj.c | 11 ++++++++---
>>>> 2 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> See Bugzilla for the full thread.
>>>
>>> Anyway, I'm adding this regression to regzbot:
>>>
>>> #regzbot introduced: 9d1bd9346241cd https://bugzilla.kernel.org/show_bu=
g.cgi?id=3D218094
>>> #regzbot title: Logitech G915 Wireless Keyboard key event only detects =
few key codes
>>> #regzbot link: https://streamable.com/ac6l8u
>>>
>>
>> There's no reply from culprit author nor linux-input people (did they mi=
ss
>> this regression?). And on Bugzilla, other reporters replied that reverti=
ng
>> the culprit fixed the regression.
>>
>> FYI, there's similar Bugzilla report on [1].
>=20
> As there was no reaction from Mavroudis in order to figure out why he is
> not observing the issues the other reporters do and what to do to fix
> those, I already do have revert in my queue for -rc3.
>=20
> My first guess would be that the extra buttons in the extended report are
> not properly reflected in the emulated report descriptor, but that
> wouldn't explain why it worked for the author of the commit.
>=20
> So revert it is, and once Marvoudis resurfaces, we can try again for some
> of later releases.
>=20
> --
> Jiri Kosina
> SUSE Labs
>=20

Apologies for not requesting a revert earlier, I was away on vacation=20
and didn't realize it would take me this long to get to it.

As I mentioned in this bugzilla report [0], I think the extra buttons=20
are handled by vendor defined bytes at the end of the descriptor, so it=20
boils down to the emulated descriptor not being updated.
This patch worked for me as the Superlight X that I own only has two=20
side buttons. In addition, I was unaware of how many devices this would=20
affect.

For now let's make sure this commit is reverted so that people have=20
working devices and I will get to fixing the issues that showed up.

Once again, apologies for this.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=3D218172#c9

