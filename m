Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F797FAF75
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjK1BUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK1BUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:20:43 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A122E131;
        Mon, 27 Nov 2023 17:20:48 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 123695C028D;
        Mon, 27 Nov 2023 20:20:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 27 Nov 2023 20:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1701134448; x=1701220848; bh=XT
        RDcUotbq3KE1sWM+QUCdZWG7mBV4SiArZy58YJ0Co=; b=fR9wrIh3zv1mGNbUno
        SU1XJ6SwpkbP+11KwQl7NgJB6ClIFBRDoG7VYHpGwAGpt1ZwJqpoFJYxaTcvipr4
        I6eOqZfGX5f3X7AavVVdTOo+RP/2QDteANfnqa40pn9L9zCX9oeTPBDjhkju8gW7
        CPLi6mZ6hPbiFJLDZhQav/EfwxXIa9gPi9k0Ic/QUxMrgVcO/Sz5eza0R5MoVWjh
        X9/GTAhbHhht3G6d31krjqlRM2OtpuncPs8v/U/353pxpiyj3qBAdCy173Uzb2lu
        aEB6F4j8ITodQ1zIKpH3yDQVIcLR3yz3/DS7+MmL+8DCT2tvog3ZN2IocGEwc0MY
        9oOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701134448; x=1701220848; bh=XTRDcUotbq3KE
        1sWM+QUCdZWG7mBV4SiArZy58YJ0Co=; b=LK6Z4Gky7zFZOR36+3STuS8PFrAPR
        O0tdZ6WMIgNySRTUx2JkQVNV2r/+1JyjA4Z3Vd7aA3q+AN8e5XB8h8U3AQAEmqMU
        C1gAFTe2EVUxdtrW6sKmB9fwjXIx0wdemgRCY7jyvM3aG+xtUJMrBrrONSkGir7/
        LMxnE8hJQSmchlz8jj6MuFmJIeOA310PVU2587EinTmizYotbSoo2MjnIV7ACPaL
        uWUdPZFIOGzvJaZSQ6vpOpwuozi98zoNpp+F64DxbiJPS6GbHnK6Blc4BZQ+Pdfr
        ZJZLZe/mYYtccEijGuAD0bYXqJpasDLRkG528xA1n8EorkWbx9aum1pyw==
X-ME-Sender: <xms:b0BlZWBF4gdxnvNAb7nkFYcGiL6a9Qig-bYZtRYA1BddpbT6hboQug>
    <xme:b0BlZQjmISKY7qUDj2bOsnhLv-bM0oivDgcffJkA3rJyhMVqSFDYmjgTQfOLDWVD3
    EzKgCRSg0TQBfAGKyE>
X-ME-Received: <xmr:b0BlZZl52vM_1HWuaPlW4TneC_rA9weuXXAtG3p2250yHBt84NrBLmsYgpor3JxNUq7rGjLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeivddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvdefudeivdegjeehteehvddufeettdffieeuffdvledtjeeijeeghfevudeghfeinecu
    ffhomhgrihhnpehuvghfihdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:b0BlZUyoNCmDUDF5Ahog5jkFK2pZL8gSdOAvt7A91KirfjJ8j206bQ>
    <xmx:b0BlZbS08yQ4hA9MkRDkx_TwCNuIsImdJLoADYy7jUrjT_XklNlmtg>
    <xmx:b0BlZfZE9N7ZWZp9v4h50IlRwP3yp46zb_LegkMWAX7cFZzjsZJ5Ug>
    <xmx:cEBlZZMFGBl4GgwbI7cFkMXPLu1-6VxTHhriw_UW6Wv6nfad2yKdug>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Nov 2023 20:20:42 -0500 (EST)
Date:   Tue, 28 Nov 2023 14:20:27 +1300
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: disable USB0 hub on ROG
 Ally before suspend
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <3Q7T4S.YETEEQF4KQOU@ljones.dev>
In-Reply-To: <75db5770-fe31-4569-bab5-1f259223506e@gmx.de>
References: <20231126230521.125708-1-luke@ljones.dev>
        <20231126230521.125708-2-luke@ljones.dev>
        <30293382-2287-45a2-9269-55d547432085@amd.com>
        <F1VS4S.MV0FEK6EB3K22@ljones.dev>
        <e583fd64-2cff-4595-a559-a675c6f5ad0d@amd.com>
        <fb8ebdfb-fc53-4343-8df3-96f04b405ace@gmx.de>
        <1J6T4S.AGCT3HWF4DTB1@ljones.dev>
        <75db5770-fe31-4569-bab5-1f259223506e@gmx.de>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Nov 28 2023 at 02:16:53 AM +01:00:00, Armin Wolf 
<W_Armin@gmx.de> wrote:
> Am 28.11.23 um 01:54 schrieb Luke Jones:
> 
>> 
>> 
>> On Mon, Nov 27 2023 at 10:42:48 PM +01:00:00, Armin Wolf
>> <W_Armin@gmx.de> wrote:
>>> Am 27.11.23 um 21:55 schrieb Mario Limonciello:
>>>> On 11/27/2023 14:46, Luke Jones wrote:
>>>>> 
>>>>> 
>>>>>  On Mon, Nov 27 2023 at 02:14:23 PM -06:00:00, Mario Limonciello
>>>>> <mario.limonciello@amd.com> wrote:
>>>>>> On 11/26/2023 17:05, Luke D. Jones wrote:
>>>>>>> ASUS have worked around an issue in XInput where it doesn't
>>>>>>> support USB
>>>>>>>  selective suspend, which causes suspend issues in Windows. They
>>>>>>> worked
>>>>>>>  around this by adjusting the MCU firmware to disable the USB0
>>>>>>> hub when
>>>>>>>  the screen is switched off during the Microsoft DSM suspend 
>>>>>>> path
>>>>>>> in ACPI.
>>>>>>> 
>>>>>>>  The issue we have with this however is one of timing - the call
>>>>>>> the tells
>>>>>>>  the MCU to this isn't able to complete before suspend is done 
>>>>>>> so
>>>>>>> we call
>>>>>>>  this in a prepare() and add a small msleep() to ensure it is
>>>>>>> done. This
>>>>>>>  must be done before the screen is switched off to prevent a
>>>>>>> variety of
>>>>>>>  possible races.
>>>>>> 
>>>>>>  Right now the way that Linux handles the LPS0 calls is that
>>>>>> they're all back to back.  Luke did try to inject a delay after
>>>>>> the LPS0 calls were done but before it went to sleep but this
>>>>>> wasn't sufficient.
>>>>>> 
>>>>>>  Another "potential" way to solve this problem from Linux may be
>>>>>> to actually glue the LPS0 screen off call to when DRM actually 
>>>>>> has
>>>>>> eDP turned off.
>>>>>> 
>>>>>>  Making such a change would essentially push back the "screen 
>>>>>> off"
>>>>>> LPS0 command to when the user has run 'systemctl suspend' (or an
>>>>>> action that did this) because the compositor usually turns it off
>>>>>> with DPMS at this time.
>>>>> 
>>>>>  I would be willing to test this if you want some concrete data.
>>>> 
>>>>  It would require some cross subsystem plumbing to evaluate
>>>> feasibility.
>>>>  I don't currently have any plans to do it.
>>>> 
>>>>  I think your patch makes sense; I just want to make it known that
>>>> "might" clean this up if it ever happens.
>>>> 
>>>>> See my big block of text below.
>>>>> 
>>>>>> 
>>>>>>  This is a much bigger change though and *much more ripe for
>>>>>> breakage*.
>>>>>> 
>>>>>>  So I think in may be worth leaving a TODO comment to look into
>>>>>> doing that in the future.
>>>>>  Do you mean add the TODO to a line in this patch?
>>>> 
>>>>  Yeah.  In case someone ever does it (me or otherwise) I think it
>>>> would be good to have some reference in the comments that the 
>>>> commit
>>>> 'might' be possible to revert.
>>>> 
>>>>> 
>>>>>> 
>>>>>>  If that ever happens; it's possible that this change could be
>>>>>> reverted too.
>>>>>> 
>>>>>>> 
>>>>>>>  Further to this the MCU powersave option must also be disabled
>>>>>>> as it can
>>>>>>>  cause a number of issues such as:
>>>>>>>  - unreliable resume connection of N-Key
>>>>>>>  - complete loss of N-Key if the power is plugged in while 
>>>>>>> suspended
>>>>>>>  Disabling the powersave option prevents this.
>>>>>>> 
>>>>>>>  Without this the MCU is unable to initialise itself correctly 
>>>>>>> on
>>>>>>> resume.
>>>>>> 
>>>>>>  initialize
>>>>> 
>>>>>  Are we forced to use USA spelling? I'm from NZ
>>>>>  "initialise is predominantly used in British English (used in
>>>>> UK/AU/NZ) ( en-GB )"
>>>>> 
>>>> 
>>>>  Ah I didn't realize it's an acceptable spelling for en-GB, and
>>>> thought it was just a typo; sorry.
>>>> 
>>>>>> 
>>>>>>> 
>>>>>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>>> 
>>>>>>  I think it would be good to add a Closes: tag to the AMD Gitlab
>>>>>> issue that this was discussed within as well as any other public
>>>>>> references you know about.
>>>>>> 
>>>>>>  Additionally as Phoenix APU support goes back as far as kernel
>>>>>> 6.1 and this is well contained to only run on the ROG I suggest 
>>>>>> to
>>>>>> CC stable so that people can use the ROG on that LTS kernel or 
>>>>>> later.
>>>>>> 
>>>>>>> ---
>>>>>>>  -SNIP-
>>>>>>>    @@ -4701,6 +4749,8 @@ static const struct dev_pm_ops
>>>>>>> asus_pm_ops = {
>>>>>>>        .thaw = asus_hotk_thaw,
>>>>>>>        .restore = asus_hotk_restore,
>>>>>>>        .resume = asus_hotk_resume,
>>>>>>>  +    .resume_early = asus_hotk_resume_early,
>>>>>>>  +    .prepare = asus_hotk_prepare,
>>>>>> 
>>>>>>  Have you experimented with only using the prepare() call or only
>>>>>> the resume_early() call?  Are both really needed?
>>>>> 
>>>>>  I have yes. Although the device comes back eventually in resume
>>>>> after only a prepare call it's not preferable as it tends to 
>>>>> change
>>>>> the device path. With resume_early we can get the device replugged
>>>>> super early (before anything notices it's gone in fact).
>>>>> 
>>>>>  This whole thing is a bit of a mess. It ends up being a race
>>>>> between various things to prevent a HUB0 disconnect being
>>>>> registered by the xhci subsystem, and adding the device back 
>>>>> before
>>>>> the xhci subsystem gets control.
>>>>> 
>>>>>  If I add a sleep longer than 1300ms in prepare then the xhci
>>>>> subsys registers a disconnect of the USB0 hub. If the sleep is
>>>>> under 250ms it isn't quite enough for the MCU to do its thing, and
>>>>> on battery it seems worse.
>>>>> 
>>>>>  I have asked the ASUS guys I'm in contact with for something to
>>>>> disable this MCU behaviour since it is purely a workaround for a
>>>>> broken Windows thing :( They are open to something, maybe an OS
>>>>> detect in ACPI or a WMI method addition similar to the MCU
>>>>> powersave method, from what I'm told it would require an MCU
>>>>> firmware update along with BIOS update. If this eventuates I'll
>>>>> submit an additional patch to check and set that plus disable 
>>>>> this.
>>>> 
>>>>  Don't let them do an OS detection in ACPI, it's going to be too
>>>> painful.
>>>>  I would instead suggest that they can have a bit that you can
>>>> program in via ACPI or WMI from the ASUS WMI driver that says to
>>>> skip the MCU disconnect behavior.
>>>> 
>>> I totally agree, we do not need another _OSI(Linux) type of problem.
>>> Maybe those guys at Asus could just implement a ACPI _DSM for the 
>>> USB
>>> controller in question which allows for disabling this workaround.
>>> This would be preferable to an additional WMI method, since the
>>> notebook would otherwise depend on the asus-wmi driver to suspend
>>> properly.
>>> With the ACPI _DSM, the USB controller driver can disable the
>>> workaround as soon as the USB controller probes.
>> 
>> Would you be so kind as to explain what this means? My knowledge of
>> ACPI is paper thin and generally revolves just around the ASUS WMI
>> part. From what i can find the XHC0 (the hub the MCU is attached to)
>> doesn't have any current _DSM. I understand it means Device Specific
>> Method, so I guess you mean adding a method to be used only if that
>> HUB is there and implements it?
>> 
>> The ROG Ally depends on the asus-wmi driver regardless, without it, 
>> it
>> is barely functional.
>> 
> An ACPI _DSM method is a "standardized" way for manufacturers to add 
> device specific methods to ACPI devices, see
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/09_ACPI-Defined_Devices_and_Device-Specific_Objects/ACPIdefined_Devices_and_DeviceSpecificObjects.html 
> for details.
> 
> Implementing via a ACPI _DSM would contain the necessary logic for 
> USB suspend inside the USB hub driver, instead of forcing asus-wmi 
> and the USB hub driver
> to collaborate on USB suspend. The USB hub driver would discover this 
> device specific method during probe and disable the workaround, 
> leaving no chance for
> race conditions between asus-wmi and the USB hub driver to develop.
> 
> Of course if the ROG Ally depends on asus-wmi regardless, then Asus 
> could as well use the WMI interface for this. But IMHO standard ACPI 
> interfaces should be
> preferred to custom ones like WMI.

Okay i understand now, thank you. I'll make a note of it in my next 
response to ASUS.

> 
>>>>> 
>>>>>  I may possibly write a new version of this patch as we've seen
>>>>> that enabling powersave reduces suspend power use by at least 
>>>>> half.
>>>>> And looking through my DSDT dumps, there are a few laptops with 
>>>>> the
>>>>> same feature as Ally. The patch for powersave being enabled
>>>>> requires also AC power state on suspend change detection, and a
>>>>> later forced reset in late resume (and the device paths change
>>>>> regardless when powersave is on).
>>>>> 
>>>>>  When I look at it objectively, the device path changing should be
>>>>> a non-issue really as it is fully handled by USB subsystem and
>>>>> behaves exactly like what it is - a USB hub disconnect. It's just
>>>>> that some userspace apps don't expect this. I will experiment some
>>>>> more.
>>>>> 
>>>>>  Regards,
>>>>>  Luke.
>>>>> 
>>>> 
>>>>  As another experiment - what happens if you "comment out" the LPS0
>>>> calls that do this problematic stuff?
>>>> 
>>>>  It's important to make sure the callback to amd-pmc stays in 
>>>> place,
>>>> but if you just skip those ACPI ones does it still get to the
>>>> deepest state and are there other problems?
>>>> 
>>>>>> 
>>>>>>>   };
>>>>>>>      /* Registration
>>>>>>> ***************************************************************/
>>>>>>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h
>>>>>>> b/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>  index 63e630276499..ab1c7deff118 100644
>>>>>>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>  @@ -114,6 +114,9 @@
>>>>>>>    /* Charging mode - 1=Barrel, 2=USB */
>>>>>>>    #define ASUS_WMI_DEVID_CHARGE_MODE    0x0012006C
>>>>>>>    +/* MCU powersave mode */
>>>>>>>  +#define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
>>>>>>>  +
>>>>>>>    /* epu is connected? 1 == true */
>>>>>>>    #define ASUS_WMI_DEVID_EGPU_CONNECTED    0x00090018
>>>>>>>    /* egpu on/off */
>>>>>> 
>>>>> 
>>>>> 
>>>> 
>>>> 
>> 
>> 
>> 


