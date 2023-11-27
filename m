Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E26D7FACBF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjK0VoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0VoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:44:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1653FC1;
        Mon, 27 Nov 2023 13:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701121449; x=1701726249; i=w_armin@gmx.de;
        bh=EoSW9wr3JiYisbo6m0tkBI6tp4fdsnkNDzFyDEIhK1c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=Lt7L1VakIcG295IlXqg/PV8dEsY6S0AbajJ6WOTFVt+UbnTvPm3ic8wq261GP4nL
         I84elvqOR8Zr01fffKvtFigW9QHGKRqa7wrmiKMBq1CW3347xytBcd0+t+g0d66dz
         1rczA0aaApx1Hf7Qt6a7TcKASVjGok517gESQTyr6u0DplD07k5r5zvCerr7BoCNi
         dpTg82cowICPTZlIiBsoP7WHfE2x/e1NmqR20KphcSY2bloCS9+KMXuzlrTDQc05E
         LDnLri8wR5TUNvpYyCbdQh+LgN41IX5aNgZFoH4r8ABlhLxD3aAvlXugBtFa42r4Q
         1gdJyaatE2fYwaTmuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1rlCsz3Wbp-00e7zr; Mon, 27
 Nov 2023 22:44:08 +0100
Message-ID: <db8d6b6c-5455-4f39-a78c-2804df5b5846@gmx.de>
Date:   Mon, 27 Nov 2023 22:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: disable USB0 hub on ROG
 Ally before suspend
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Luke Jones <luke@ljones.dev>
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231126230521.125708-1-luke@ljones.dev>
 <20231126230521.125708-2-luke@ljones.dev>
 <30293382-2287-45a2-9269-55d547432085@amd.com>
 <F1VS4S.MV0FEK6EB3K22@ljones.dev>
 <e583fd64-2cff-4595-a559-a675c6f5ad0d@amd.com>
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <e583fd64-2cff-4595-a559-a675c6f5ad0d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QHWUW4vRzzDetAHaIh2ijoKf8crx7NjOZ2XJ7yYR0aGLRcmpqJI
 zGWGp1g6/Iohin9rvAHGFxC4R+jd+ZQYvJgJMkMquixV04EveEHgZkTzFyJcWDcjVi7teWR
 jtEDzM8p2piBFbCedEVW8EGZnjnpZrEUbCMyqaS08ncH6GpaZ/DRcY5x0uXPnqeiCSh1eWE
 tZhDyxXrKFb/aM4mfJzdg==
UI-OutboundReport: notjunk:1;M01:P0:rBShxJPCngo=;EAdxJocOF0i3D78lQwd60qpGThe
 8t/c3SI/lulEHIgTqNSTCJ/bRbBq+Vrct9Ep9gCRohsXwxuKs6afUbkBHAnaCJdMo9mASwvYn
 VPoP5rg+jCJO+rmiFkkcvV3QV5KAj6FdGFJZqfj+rSb01EmZdmQBFEW20p96KVBHSsei7dADX
 6aEL5Z/9XsehFDkxEv7QOI2WwOuKjyIYQ7yHwlSZ7z+tb49H9iK19yA95thBP6wQSdcJS+9eU
 xGJ+oECsmYW8jOQyj2MNmc6pMS7I+bhD6ixDCOcBJNFShfHZf1YlAspNLZQ3Sw6FaJcbrdc/8
 GNrrO8rGqWaLq3AmRvD71NaBTJ4T7Qaoe7+C1bY7fh6C4NO0/3Sr3SFB/UdPtyudsHb/PYodt
 ey+6BX7NFTxQ41nzeZvrP7V4B8cSU3jD9eln+LjUucxFFHcH/2u2idzH6g1gXAK3yBoUnRTmd
 THEdPDxFKKQ5nm8bNNUhkZNgHvHe1hy/fPLgRS/Jh8O2PizwKaNqMPDhDeRcVO0oAUxtdo+ml
 GLhAN1FLigWg9WkAS3j2yLrY4GSyUjhgIYUP7JCYhJ47MdacrQk+jBKXqZGmfCCFhl2yhi5VA
 FGNp5ewiHFq6nD6L21ndUZVFXAu/BpU28EBoWCyGzo3hJ8n7Ui8jMfHV6wL0uHVvEQanWsqsK
 VGoFW5jlkWppnUYfRQPYjAErxbKFSCwjpMYerCbflAjFl4IEVXYRQbeKBuO7JYdw/KlI6kg7J
 nhDrnnSHnkIcmG4nv2f8GZ/yi8UgP/7HzqYlPyA6ABOI2GSpPqkRgBItSc5TyCalj/Lxc2N57
 AYa20jTCmKmXPwp2n8Wus8+2XJyW5tQF8HZIsCg64eoWtmWWjjTv7Pxk/AbDL/by/jQV7EP1A
 kjSHQBc75LNqZ+KVaU7pHRTMxwkE9VGHB9Gmp+A6/cJDxEzYQEhHijvpLwxkQDWXi1Qgn9RA7
 KwqzwqNugKODUgZ0xckLT+DgUbM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.11.23 um 21:55 schrieb Mario Limonciello:

> On 11/27/2023 14:46, Luke Jones wrote:
>>
>>
>> On Mon, Nov 27 2023 at 02:14:23 PM -06:00:00, Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>> On 11/26/2023 17:05, Luke D. Jones wrote:
>>>> ASUS have worked around an issue in XInput where it doesn't support
>>>> USB
>>>> selective suspend, which causes suspend issues in Windows. They worke=
d
>>>> around this by adjusting the MCU firmware to disable the USB0 hub whe=
n
>>>> the screen is switched off during the Microsoft DSM suspend path in
>>>> ACPI.
>>>>
>>>> The issue we have with this however is one of timing - the call the
>>>> tells
>>>> the MCU to this isn't able to complete before suspend is done so we
>>>> call
>>>> this in a prepare() and add a small msleep() to ensure it is done.
>>>> This
>>>> must be done before the screen is switched off to prevent a variety o=
f
>>>> possible races.
>>>
>>> Right now the way that Linux handles the LPS0 calls is that they're
>>> all back to back.=C2=A0 Luke did try to inject a delay after the LPS0
>>> calls were done but before it went to sleep but this wasn't sufficient=
.
>>>
>>> Another "potential" way to solve this problem from Linux may be to
>>> actually glue the LPS0 screen off call to when DRM actually has eDP
>>> turned off.
>>>
>>> Making such a change would essentially push back the "screen off"
>>> LPS0 command to when the user has run 'systemctl suspend' (or an
>>> action that did this) because the compositor usually turns it off
>>> with DPMS at this time.
>>
>> I would be willing to test this if you want some concrete data.
>
> It would require some cross subsystem plumbing to evaluate feasibility.
> I don't currently have any plans to do it.
>
> I think your patch makes sense; I just want to make it known that
> "might" clean this up if it ever happens.
>
>> See my big block of text below.
>>
>>>
>>> This is a much bigger change though and *much more ripe for breakage*.
>>>
>>> So I think in may be worth leaving a TODO comment to look into doing
>>> that in the future.
>> Do you mean add the TODO to a line in this patch?
>
> Yeah.=C2=A0 In case someone ever does it (me or otherwise) I think it wo=
uld
> be good to have some reference in the comments that the commit 'might'
> be possible to revert.
>
>>
>>>
>>> If that ever happens; it's possible that this change could be
>>> reverted too.
>>>
>>>>
>>>> Further to this the MCU powersave option must also be disabled as
>>>> it can
>>>> cause a number of issues such as:
>>>> - unreliable resume connection of N-Key
>>>> - complete loss of N-Key if the power is plugged in while suspended
>>>> Disabling the powersave option prevents this.
>>>>
>>>> Without this the MCU is unable to initialise itself correctly on
>>>> resume.
>>>
>>> initialize
>>
>> Are we forced to use USA spelling? I'm from NZ
>> "initialise is predominantly used in British English (used in
>> UK/AU/NZ) ( en-GB )"
>>
>
> Ah I didn't realize it's an acceptable spelling for en-GB, and thought
> it was just a typo; sorry.
>
>>>
>>>>
>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>
>>> I think it would be good to add a Closes: tag to the AMD Gitlab
>>> issue that this was discussed within as well as any other public
>>> references you know about.
>>>
>>> Additionally as Phoenix APU support goes back as far as kernel 6.1
>>> and this is well contained to only run on the ROG I suggest to CC
>>> stable so that people can use the ROG on that LTS kernel or later.
>>>
>>>> ---
>>>> -SNIP-
>>>> =C2=A0 =7F@@ -4701,6 +4749,8 @@ static const struct dev_pm_ops asus_p=
m_ops
>>>> =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .thaw =3D asus_hotk_thaw,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .restore =3D asus_hotk_restore,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .resume =3D asus_hotk_resume,
>>>> +=C2=A0=C2=A0=C2=A0 .resume_early =3D asus_hotk_resume_early,
>>>> +=C2=A0=C2=A0=C2=A0 .prepare =3D asus_hotk_prepare,
>>>
>>> Have you experimented with only using the prepare() call or only the
>>> resume_early() call?=C2=A0 Are both really needed?
>>
>> I have yes. Although the device comes back eventually in resume after
>> only a prepare call it's not preferable as it tends to change the
>> device path. With resume_early we can get the device replugged super
>> early (before anything notices it's gone in fact).
>>
>> This whole thing is a bit of a mess. It ends up being a race between
>> various things to prevent a HUB0 disconnect being registered by the
>> xhci subsystem, and adding the device back before the xhci subsystem
>> gets control.
>>
>> If I add a sleep longer than 1300ms in prepare then the xhci subsys
>> registers a disconnect of the USB0 hub. If the sleep is under 250ms
>> it isn't quite enough for the MCU to do its thing, and on battery it
>> seems worse.
>>
>> I have asked the ASUS guys I'm in contact with for something to
>> disable this MCU behaviour since it is purely a workaround for a
>> broken Windows thing :( They are open to something, maybe an OS
>> detect in ACPI or a WMI method addition similar to the MCU powersave
>> method, from what I'm told it would require an MCU firmware update
>> along with BIOS update. If this eventuates I'll submit an additional
>> patch to check and set that plus disable this.
>
> Don't let them do an OS detection in ACPI, it's going to be too painful.
> I would instead suggest that they can have a bit that you can program
> in via ACPI or WMI from the ASUS WMI driver that says to skip the MCU
> disconnect behavior.
>
I totally agree, we do not need another _OSI(Linux) type of problem.
Maybe those guys at Asus could just implement a ACPI _DSM for the USB cont=
roller in question which allows for disabling this workaround.
This would be preferable to an additional WMI method, since the notebook w=
ould otherwise depend on the asus-wmi driver to suspend properly.
With the ACPI _DSM, the USB controller driver can disable the workaround a=
s soon as the USB controller probes.

Armin Wolf

>>
>> I may possibly write a new version of this patch as we've seen that
>> enabling powersave reduces suspend power use by at least half. And
>> looking through my DSDT dumps, there are a few laptops with the same
>> feature as Ally. The patch for powersave being enabled requires also
>> AC power state on suspend change detection, and a later forced reset
>> in late resume (and the device paths change regardless when powersave
>> is on).
>>
>> When I look at it objectively, the device path changing should be a
>> non-issue really as it is fully handled by USB subsystem and behaves
>> exactly like what it is - a USB hub disconnect. It's just that some
>> userspace apps don't expect this. I will experiment some more.
>>
>> Regards,
>> Luke.
>>
>
> As another experiment - what happens if you "comment out" the LPS0
> calls that do this problematic stuff?
>
> It's important to make sure the callback to amd-pmc stays in place,
> but if you just skip those ACPI ones does it still get to the deepest
> state and are there other problems?
>
>>>
>>>> =C2=A0 };
>>>> =C2=A0 =7F=C2=A0 /* Registration
>>>> ***************************************************************/
>>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h
>>>> b/include/linux/platform_data/x86/asus-wmi.h
>>>> index 63e630276499..ab1c7deff118 100644
>>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>> @@ -114,6 +114,9 @@
>>>> =C2=A0 /* Charging mode - 1=3DBarrel, 2=3DUSB */
>>>> =C2=A0 #define ASUS_WMI_DEVID_CHARGE_MODE=C2=A0=C2=A0=C2=A0 0x0012006=
C
>>>> =C2=A0 =7F+/* MCU powersave mode */
>>>> +#define ASUS_WMI_DEVID_MCU_POWERSAVE=C2=A0=C2=A0 0x001200E2
>>>> +
>>>> =C2=A0 /* epu is connected? 1 =3D=3D true */
>>>> =C2=A0 #define ASUS_WMI_DEVID_EGPU_CONNECTED=C2=A0=C2=A0=C2=A0 0x0009=
0018
>>>> =C2=A0 /* egpu on/off */
>>>
>>
>>
>
>
