Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770837FAF73
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjK1BRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1BRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:17:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80B71B6;
        Mon, 27 Nov 2023 17:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701134217; x=1701739017; i=w_armin@gmx.de;
        bh=4rXoMs//yrv/VMhjMrJQ2Hx2LajE14cUQRRioCE6nHs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=YPIIFT81RNTcQxlYxcjU1+fGWZ2+JuvyovJj556oZtCmaLiKnVrl9U9pmi4Z0II6
         DAiZNDixqALv/6zst/ryT9jIQuqomwyXtnSFrRwbuihxAKctLDEwjjLV+tfcdgPG2
         aYNd5aPQEbp0P1KpJKBFStzd5YINLtHNIOK4I8c2tMm428mectUkUFnBSnM4WtbRl
         oQWLaNfXuvtSfx16cRxwFFB1fyhO+rUjg7AYcFCsbvDbyQUrX6+Yl/EvQtkLVsfFd
         mBKkTJNoA/pHGMOFD9VzAAiBuoCuLYbaj1yxTBSiuY/Q2eTizmwKvYkxOK7G1V5Np
         JeVsJZ+yUeYH6opOVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f9b-1r98xq0La3-004EYL; Tue, 28
 Nov 2023 02:16:57 +0100
Message-ID: <75db5770-fe31-4569-bab5-1f259223506e@gmx.de>
Date:   Tue, 28 Nov 2023 02:16:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: disable USB0 hub on ROG
 Ally before suspend
To:     Luke Jones <luke@ljones.dev>
Cc:     Mario Limonciello <mario.limonciello@amd.com>, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231126230521.125708-1-luke@ljones.dev>
 <20231126230521.125708-2-luke@ljones.dev>
 <30293382-2287-45a2-9269-55d547432085@amd.com>
 <F1VS4S.MV0FEK6EB3K22@ljones.dev>
 <e583fd64-2cff-4595-a559-a675c6f5ad0d@amd.com>
 <fb8ebdfb-fc53-4343-8df3-96f04b405ace@gmx.de>
 <1J6T4S.AGCT3HWF4DTB1@ljones.dev>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <1J6T4S.AGCT3HWF4DTB1@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j0cMwhhPqSRBEfJQiiFloa4X4ImFjV0kQQLLZCfiqW8g/2XOlxx
 AJULFiMHU14wA91US4kOUAEnA4fA/OZwlNvjFyLpWJEGdn8udtJP+lsf9OWz2h2kyciKbAc
 t7fvDcCOMp7OGRo0xK84RQDvBJq497dQhcH+59H0cGZbziyERgpdea9D8F47rLoeYL02Pe+
 Slq2DKhOXVYZokqNoWhOw==
UI-OutboundReport: notjunk:1;M01:P0:vjerYnvrvbE=;51C+ap/cq6InopzcwdKvnJPuMNN
 cz5MfYREkLYviBprKjtxFS57S1K6MCcJRJYaYnISESrq0vLuqTBeahAl3TCYqQiSxXujxUHt0
 waffKAY3JtCFvwm+X5wo3fKzx2RfteiQq28Rjj5ZRcM1idXlQFpLTOC5aVnJpRXMGeUOyZtGV
 fURQUYQOS7sm2ZWXObalZpdCgUQMXegeu4s5IkM5hB5+aTg9WNt+gT3sG2bHdX65REFO8UUWb
 nImxNCdO0Y/vWkYmWn2UlpS+lHMKQ2AhqU+qCHhCtprnE++6ofsxq6Ys8klFmrWM+tKwiD9Ru
 O0eMzBJqAOv6U0O/M9zLqv9KyKBK7jRpaVzJE9hpepB2BOr8czj8vVg7q8QtXS6TdA3vJz2wh
 dT8mJuLxDvYd49+k56C0UVFLH58BAI+whu0hF8wWEveOhc9Zdj/2yohli9uUdYJomux1jc+Ik
 2mNBqL5wFMVHsBeItwc8sxgeRN0ApP9oM+nUFDDhOiFkfMm5/IuyamuorV9fMl75/emm6Sxwk
 u0Y2EFhDkZyRkFEEOaUXZLT1im+/qh56euPhf5AgQ1F2iHjySuSROCIhQzOclEh1I1UYKFgxc
 uOHGW2rEWNJ7NPdW61uaMWrxwD1GZgf/pd13APPXu2qAwh4JqS2kgEJfhL0n4BVY5om9MvrcO
 97+BpzYYGS8SERJL+5EtwLnryX0dKb6rlq96OEGM3zJInapmV/Iyf8/QPesQV+V1/Mrir6hTi
 TCrFu93ZuNDTyXsec4GCX3BTR2Wl0TADuAimTAfwrVsKWhp+OyTWZHML2scC8PYsvQkhjXHj/
 xeYtqE+FRhEAhhC5cmzLdPjym0BnHCYQL5qEVbtjYbRYRvRudFtcvQhoOBJIRG5hmQBOeDLi1
 XU7gHNaV7c+3N9ZXjSull0d+UCk8sawuRoYBpBdWdIRs07b6LGM7KmHt6io2ggcQGTk21kNqL
 n+FAF8k2eJflur5aT06wzH8U1pg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.11.23 um 01:54 schrieb Luke Jones:

>
>
> On Mon, Nov 27 2023 at 10:42:48 PM +01:00:00, Armin Wolf
> <W_Armin@gmx.de> wrote:
>> Am 27.11.23 um 21:55 schrieb Mario Limonciello:
>>> On 11/27/2023 14:46, Luke Jones wrote:
>>>>
>>>>
>>>> =C2=A0On Mon, Nov 27 2023 at 02:14:23 PM -06:00:00, Mario Limonciello
>>>> <mario.limonciello@amd.com> wrote:
>>>>> On 11/26/2023 17:05, Luke D. Jones wrote:
>>>>>> ASUS have worked around an issue in XInput where it doesn't
>>>>>> support USB
>>>>>> =C2=A0selective suspend, which causes suspend issues in Windows. Th=
ey
>>>>>> worked
>>>>>> =C2=A0around this by adjusting the MCU firmware to disable the USB0
>>>>>> hub when
>>>>>> =C2=A0the screen is switched off during the Microsoft DSM suspend p=
ath
>>>>>> in ACPI.
>>>>>>
>>>>>> =C2=A0The issue we have with this however is one of timing - the ca=
ll
>>>>>> the tells
>>>>>> =C2=A0the MCU to this isn't able to complete before suspend is done=
 so
>>>>>> we call
>>>>>> =C2=A0this in a prepare() and add a small msleep() to ensure it is
>>>>>> done. This
>>>>>> =C2=A0must be done before the screen is switched off to prevent a
>>>>>> variety of
>>>>>> =C2=A0possible races.
>>>>>
>>>>> =C2=A0Right now the way that Linux handles the LPS0 calls is that
>>>>> they're all back to back.=C2=A0 Luke did try to inject a delay after
>>>>> the LPS0 calls were done but before it went to sleep but this
>>>>> wasn't sufficient.
>>>>>
>>>>> =C2=A0Another "potential" way to solve this problem from Linux may b=
e
>>>>> to actually glue the LPS0 screen off call to when DRM actually has
>>>>> eDP turned off.
>>>>>
>>>>> =C2=A0Making such a change would essentially push back the "screen o=
ff"
>>>>> LPS0 command to when the user has run 'systemctl suspend' (or an
>>>>> action that did this) because the compositor usually turns it off
>>>>> with DPMS at this time.
>>>>
>>>> =C2=A0I would be willing to test this if you want some concrete data.
>>>
>>> =C2=A0It would require some cross subsystem plumbing to evaluate
>>> feasibility.
>>> =C2=A0I don't currently have any plans to do it.
>>>
>>> =C2=A0I think your patch makes sense; I just want to make it known tha=
t
>>> "might" clean this up if it ever happens.
>>>
>>>> See my big block of text below.
>>>>
>>>>>
>>>>> =C2=A0This is a much bigger change though and *much more ripe for
>>>>> breakage*.
>>>>>
>>>>> =C2=A0So I think in may be worth leaving a TODO comment to look into
>>>>> doing that in the future.
>>>> =C2=A0Do you mean add the TODO to a line in this patch?
>>>
>>> =C2=A0Yeah.=C2=A0 In case someone ever does it (me or otherwise) I thi=
nk it
>>> would be good to have some reference in the comments that the commit
>>> 'might' be possible to revert.
>>>
>>>>
>>>>>
>>>>> =C2=A0If that ever happens; it's possible that this change could be
>>>>> reverted too.
>>>>>
>>>>>>
>>>>>> =C2=A0Further to this the MCU powersave option must also be disable=
d
>>>>>> as it can
>>>>>> =C2=A0cause a number of issues such as:
>>>>>> =C2=A0- unreliable resume connection of N-Key
>>>>>> =C2=A0- complete loss of N-Key if the power is plugged in while sus=
pended
>>>>>> =C2=A0Disabling the powersave option prevents this.
>>>>>>
>>>>>> =C2=A0Without this the MCU is unable to initialise itself correctly=
 on
>>>>>> resume.
>>>>>
>>>>> =C2=A0initialize
>>>>
>>>> =C2=A0Are we forced to use USA spelling? I'm from NZ
>>>> =C2=A0"initialise is predominantly used in British English (used in
>>>> UK/AU/NZ) ( en-GB )"
>>>>
>>>
>>> =C2=A0Ah I didn't realize it's an acceptable spelling for en-GB, and
>>> thought it was just a typo; sorry.
>>>
>>>>>
>>>>>>
>>>>>> =C2=A0Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>>
>>>>> =C2=A0I think it would be good to add a Closes: tag to the AMD Gitla=
b
>>>>> issue that this was discussed within as well as any other public
>>>>> references you know about.
>>>>>
>>>>> =C2=A0Additionally as Phoenix APU support goes back as far as kernel
>>>>> 6.1 and this is well contained to only run on the ROG I suggest to
>>>>> CC stable so that people can use the ROG on that LTS kernel or later=
.
>>>>>
>>>>>> ---
>>>>>> =C2=A0-SNIP-
>>>>>> =C2=A0=C2=A0 =7F@@ -4701,6 +4749,8 @@ static const struct dev_pm_op=
s
>>>>>> asus_pm_ops =3D {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .thaw =3D asus_hotk_thaw,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .restore =3D asus_hotk_restore=
,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .resume =3D asus_hotk_resume,
>>>>>> =C2=A0+=C2=A0=C2=A0=C2=A0 .resume_early =3D asus_hotk_resume_early,
>>>>>> =C2=A0+=C2=A0=C2=A0=C2=A0 .prepare =3D asus_hotk_prepare,
>>>>>
>>>>> =C2=A0Have you experimented with only using the prepare() call or on=
ly
>>>>> the resume_early() call?=C2=A0 Are both really needed?
>>>>
>>>> =C2=A0I have yes. Although the device comes back eventually in resume
>>>> after only a prepare call it's not preferable as it tends to change
>>>> the device path. With resume_early we can get the device replugged
>>>> super early (before anything notices it's gone in fact).
>>>>
>>>> =C2=A0This whole thing is a bit of a mess. It ends up being a race
>>>> between various things to prevent a HUB0 disconnect being
>>>> registered by the xhci subsystem, and adding the device back before
>>>> the xhci subsystem gets control.
>>>>
>>>> =C2=A0If I add a sleep longer than 1300ms in prepare then the xhci
>>>> subsys registers a disconnect of the USB0 hub. If the sleep is
>>>> under 250ms it isn't quite enough for the MCU to do its thing, and
>>>> on battery it seems worse.
>>>>
>>>> =C2=A0I have asked the ASUS guys I'm in contact with for something to
>>>> disable this MCU behaviour since it is purely a workaround for a
>>>> broken Windows thing :( They are open to something, maybe an OS
>>>> detect in ACPI or a WMI method addition similar to the MCU
>>>> powersave method, from what I'm told it would require an MCU
>>>> firmware update along with BIOS update. If this eventuates I'll
>>>> submit an additional patch to check and set that plus disable this.
>>>
>>> =C2=A0Don't let them do an OS detection in ACPI, it's going to be too
>>> painful.
>>> =C2=A0I would instead suggest that they can have a bit that you can
>>> program in via ACPI or WMI from the ASUS WMI driver that says to
>>> skip the MCU disconnect behavior.
>>>
>> I totally agree, we do not need another _OSI(Linux) type of problem.
>> Maybe those guys at Asus could just implement a ACPI _DSM for the USB
>> controller in question which allows for disabling this workaround.
>> This would be preferable to an additional WMI method, since the
>> notebook would otherwise depend on the asus-wmi driver to suspend
>> properly.
>> With the ACPI _DSM, the USB controller driver can disable the
>> workaround as soon as the USB controller probes.
>
> Would you be so kind as to explain what this means? My knowledge of
> ACPI is paper thin and generally revolves just around the ASUS WMI
> part. From what i can find the XHC0 (the hub the MCU is attached to)
> doesn't have any current _DSM. I understand it means Device Specific
> Method, so I guess you mean adding a method to be used only if that
> HUB is there and implements it?
>
> The ROG Ally depends on the asus-wmi driver regardless, without it, it
> is barely functional.
>
An ACPI _DSM method is a "standardized" way for manufacturers to add devic=
e specific methods to ACPI devices, see
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/09_ACPI-Defined_Devices_and_=
Device-Specific_Objects/ACPIdefined_Devices_and_DeviceSpecificObjects.html=
 for details.

Implementing via a ACPI _DSM would contain the necessary logic for USB sus=
pend inside the USB hub driver, instead of forcing asus-wmi and the USB hu=
b driver
to collaborate on USB suspend. The USB hub driver would discover this devi=
ce specific method during probe and disable the workaround, leaving no cha=
nce for
race conditions between asus-wmi and the USB hub driver to develop.

Of course if the ROG Ally depends on asus-wmi regardless, then Asus could =
as well use the WMI interface for this. But IMHO standard ACPI interfaces =
should be
preferred to custom ones like WMI.

Armin Wolf

>>>>
>>>> =C2=A0I may possibly write a new version of this patch as we've seen
>>>> that enabling powersave reduces suspend power use by at least half.
>>>> And looking through my DSDT dumps, there are a few laptops with the
>>>> same feature as Ally. The patch for powersave being enabled
>>>> requires also AC power state on suspend change detection, and a
>>>> later forced reset in late resume (and the device paths change
>>>> regardless when powersave is on).
>>>>
>>>> =C2=A0When I look at it objectively, the device path changing should =
be
>>>> a non-issue really as it is fully handled by USB subsystem and
>>>> behaves exactly like what it is - a USB hub disconnect. It's just
>>>> that some userspace apps don't expect this. I will experiment some
>>>> more.
>>>>
>>>> =C2=A0Regards,
>>>> =C2=A0Luke.
>>>>
>>>
>>> =C2=A0As another experiment - what happens if you "comment out" the LP=
S0
>>> calls that do this problematic stuff?
>>>
>>> =C2=A0It's important to make sure the callback to amd-pmc stays in pla=
ce,
>>> but if you just skip those ACPI ones does it still get to the
>>> deepest state and are there other problems?
>>>
>>>>>
>>>>>> =C2=A0 };
>>>>>> =C2=A0=C2=A0 =7F=C2=A0 /* Registration
>>>>>> ***************************************************************/
>>>>>> =C2=A0diff --git a/include/linux/platform_data/x86/asus-wmi.h
>>>>>> b/include/linux/platform_data/x86/asus-wmi.h
>>>>>> =C2=A0index 63e630276499..ab1c7deff118 100644
>>>>>> =C2=A0--- a/include/linux/platform_data/x86/asus-wmi.h
>>>>>> =C2=A0+++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>>> =C2=A0@@ -114,6 +114,9 @@
>>>>>> =C2=A0=C2=A0 /* Charging mode - 1=3DBarrel, 2=3DUSB */
>>>>>> =C2=A0=C2=A0 #define ASUS_WMI_DEVID_CHARGE_MODE=C2=A0=C2=A0=C2=A0 0=
x0012006C
>>>>>> =C2=A0=C2=A0 =7F+/* MCU powersave mode */
>>>>>> =C2=A0+#define ASUS_WMI_DEVID_MCU_POWERSAVE=C2=A0=C2=A0 0x001200E2
>>>>>> =C2=A0+
>>>>>> =C2=A0=C2=A0 /* epu is connected? 1 =3D=3D true */
>>>>>> =C2=A0=C2=A0 #define ASUS_WMI_DEVID_EGPU_CONNECTED=C2=A0=C2=A0=C2=
=A0 0x00090018
>>>>>> =C2=A0=C2=A0 /* egpu on/off */
>>>>>
>>>>
>>>>
>>>
>>>
>
>
>
