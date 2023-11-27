Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24D97FABDF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjK0Uqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjK0Uql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:46:41 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EB2BE;
        Mon, 27 Nov 2023 12:46:47 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id EE81A5C03B9;
        Mon, 27 Nov 2023 15:46:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 27 Nov 2023 15:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1701118006; x=1701204406; bh=sT
        fp7LBK/RiFIopcH0iVO7hR3Pi6XSKLifjfVYxaqjA=; b=OIljDir68DfurLYKMN
        jF8/9+HexOrjSj+IGVGgYLwlVnz5nc3d0GPpAG+ZrioVi0hOckV7AHab06i3nDdZ
        YVMl7OnqtDgX/jdseY6PwKArhj1LqjsEnk6KH2Za+p2b2AbKp+U2dm9MfgfDAa20
        dGUr+0c3x2UOgbClRDS3JywVTuFiOdxqx5fCOdl9qj28AxT+QIY3c4aBV/J2Vf3Y
        3vUuZOVWYB4Dg0dAip/wUi7QKmSKCgY4623n9O3trDfTyr843YTZK2TmLdXQo+Sl
        kqewf5CRe6+2tPsMFSsXiP6m2qHAtJMj2Xe0pAhO5KYbLbQp9o72imiqZrH5ht53
        5gXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701118006; x=1701204406; bh=sTfp7LBK/RiFI
        opcH0iVO7hR3Pi6XSKLifjfVYxaqjA=; b=m1Q9tbpqYl3QyRewy7rkm4kLYxb1E
        /blCs1I5TUGGylw81pz78eXa6AFaddew4Rnm7oY+IYQgVmm4bniF7S1EobtCwgBT
        pPgCXHBADw15btcNQ/ZQC94p/o4SFwdhdkJRqp4INhaQtVzqpggELLLAJ27K6Urn
        Wngw3fd0O3TVdUgY4ZMPjY8vGiHhSBkKtWiXOWRXMd/A/Pc+izhDSixNyE+b1rZV
        R9v3jZPBOiVPgwFngtWWZWmeOjMlX1ZPybT0wVUL9jBBz8UHHvCgLzaVJhw7IISO
        Yss5LQk099LKrUT2oU/tsG+k3bquK16yt7Ryjz/w28ZtQgvROD6QBq0+Q==
X-ME-Sender: <xms:NgBlZWxN9GqQSlEnUTXO-JbP28jG7sGaosWDqTg9QLAHQMz8reieOw>
    <xme:NgBlZSQbGle3P9-kR50TgWIeiQoZJlWRDLGdbkBacLsmeGE6490GiXfvwujilsFmv
    ja944lN7sbi_8OCSHM>
X-ME-Received: <xmr:NgBlZYU-EL-oM4bOB6GzX0eRvDmz8xfJr4Pv0DFLa64yNGuWKIrbidfVpLkuhALUZjDQNX38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiuddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpedvvdegledtheefieejgfevgeefiefhtdevteefteduhfevtdefleethfetgeeluden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:NgBlZciIlS88WFMAvXf4rISBY_AZ9S1X5AaZPXkYb4OextFKrTNVag>
    <xmx:NgBlZYCxMmD9xQTkGtuPyG4FQKV493ikpLlV86U7ZsgkTE0K7Iqi6Q>
    <xmx:NgBlZdIv9aNfkejqhhLbzVuXB1lrsMoVRkUODrbZwTsmrHmt6PC1Cw>
    <xmx:NgBlZbP9UKjIDUmchHaeLr7CcIr6mSQkUZWqZ5YYtJThTye-Xjj5sg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Nov 2023 15:46:41 -0500 (EST)
Date:   Tue, 28 Nov 2023 09:46:27 +1300
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: disable USB0 hub on ROG
 Ally before suspend
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <F1VS4S.MV0FEK6EB3K22@ljones.dev>
In-Reply-To: <30293382-2287-45a2-9269-55d547432085@amd.com>
References: <20231126230521.125708-1-luke@ljones.dev>
        <20231126230521.125708-2-luke@ljones.dev>
        <30293382-2287-45a2-9269-55d547432085@amd.com>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Nov 27 2023 at 02:14:23 PM -06:00:00, Mario Limonciello 
<mario.limonciello@amd.com> wrote:
> On 11/26/2023 17:05, Luke D. Jones wrote:
>> ASUS have worked around an issue in XInput where it doesn't support 
>> USB
>> selective suspend, which causes suspend issues in Windows. They 
>> worked
>> around this by adjusting the MCU firmware to disable the USB0 hub 
>> when
>> the screen is switched off during the Microsoft DSM suspend path in 
>> ACPI.
>> 
>> The issue we have with this however is one of timing - the call the 
>> tells
>> the MCU to this isn't able to complete before suspend is done so we 
>> call
>> this in a prepare() and add a small msleep() to ensure it is done. 
>> This
>> must be done before the screen is switched off to prevent a variety 
>> of
>> possible races.
> 
> Right now the way that Linux handles the LPS0 calls is that they're 
> all back to back.  Luke did try to inject a delay after the LPS0 
> calls were done but before it went to sleep but this wasn't 
> sufficient.
> 
> Another "potential" way to solve this problem from Linux may be to 
> actually glue the LPS0 screen off call to when DRM actually has eDP 
> turned off.
> 
> Making such a change would essentially push back the "screen off" 
> LPS0 command to when the user has run 'systemctl suspend' (or an 
> action that did this) because the compositor usually turns it off 
> with DPMS at this time.

I would be willing to test this if you want some concrete data. See my 
big block of text below.

> 
> This is a much bigger change though and *much more ripe for breakage*.
> 
> So I think in may be worth leaving a TODO comment to look into doing 
> that in the future.
Do you mean add the TODO to a line in this patch?

> 
> If that ever happens; it's possible that this change could be 
> reverted too.
> 
>> 
>> Further to this the MCU powersave option must also be disabled as it 
>> can
>> cause a number of issues such as:
>> - unreliable resume connection of N-Key
>> - complete loss of N-Key if the power is plugged in while suspended
>> Disabling the powersave option prevents this.
>> 
>> Without this the MCU is unable to initialise itself correctly on 
>> resume.
> 
> initialize

Are we forced to use USA spelling? I'm from NZ
"initialise is predominantly used in British English (used in UK/AU/NZ) 
( en-GB )"

> 
>> 
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> I think it would be good to add a Closes: tag to the AMD Gitlab issue 
> that this was discussed within as well as any other public references 
> you know about.
> 
> Additionally as Phoenix APU support goes back as far as kernel 6.1 
> and this is well contained to only run on the ROG I suggest to CC 
> stable so that people can use the ROG on that LTS kernel or later.
> 
>> ---
>> -SNIP-
>>   @@ -4701,6 +4749,8 @@ static const struct dev_pm_ops asus_pm_ops 
>> = {
>>   	.thaw = asus_hotk_thaw,
>>   	.restore = asus_hotk_restore,
>>   	.resume = asus_hotk_resume,
>> +	.resume_early = asus_hotk_resume_early,
>> +	.prepare = asus_hotk_prepare,
> 
> Have you experimented with only using the prepare() call or only the 
> resume_early() call?  Are both really needed?

I have yes. Although the device comes back eventually in resume after 
only a prepare call it's not preferable as it tends to change the 
device path. With resume_early we can get the device replugged super 
early (before anything notices it's gone in fact).

This whole thing is a bit of a mess. It ends up being a race between 
various things to prevent a HUB0 disconnect being registered by the 
xhci subsystem, and adding the device back before the xhci subsystem 
gets control.

If I add a sleep longer than 1300ms in prepare then the xhci subsys 
registers a disconnect of the USB0 hub. If the sleep is under 250ms it 
isn't quite enough for the MCU to do its thing, and on battery it seems 
worse.

I have asked the ASUS guys I'm in contact with for something to disable 
this MCU behaviour since it is purely a workaround for a broken Windows 
thing :( They are open to something, maybe an OS detect in ACPI or a 
WMI method addition similar to the MCU powersave method, from what I'm 
told it would require an MCU firmware update along with BIOS update. If 
this eventuates I'll submit an additional patch to check and set that 
plus disable this.

I may possibly write a new version of this patch as we've seen that 
enabling powersave reduces suspend power use by at least half. And 
looking through my DSDT dumps, there are a few laptops with the same 
feature as Ally. The patch for powersave being enabled requires also AC 
power state on suspend change detection, and a later forced reset in 
late resume (and the device paths change regardless when powersave is 
on).

When I look at it objectively, the device path changing should be a 
non-issue really as it is fully handled by USB subsystem and behaves 
exactly like what it is - a USB hub disconnect. It's just that some 
userspace apps don't expect this. I will experiment some more.

Regards,
Luke.

> 
>>   };
>>     /* Registration 
>> ***************************************************************/
>> diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>> b/include/linux/platform_data/x86/asus-wmi.h
>> index 63e630276499..ab1c7deff118 100644
>> --- a/include/linux/platform_data/x86/asus-wmi.h
>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>> @@ -114,6 +114,9 @@
>>   /* Charging mode - 1=Barrel, 2=USB */
>>   #define ASUS_WMI_DEVID_CHARGE_MODE	0x0012006C
>>   +/* MCU powersave mode */
>> +#define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
>> +
>>   /* epu is connected? 1 == true */
>>   #define ASUS_WMI_DEVID_EGPU_CONNECTED	0x00090018
>>   /* egpu on/off */
> 


