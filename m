Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B557FAB28
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjK0URi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0URg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:17:36 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E231B6;
        Mon, 27 Nov 2023 12:17:41 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 3B0203200BEB;
        Mon, 27 Nov 2023 15:17:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 27 Nov 2023 15:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1701116259; x=1701202659; bh=oI
        xmWDxu2oALwbstLOvWGo+FZUSvDL0mwEFrMrgXeTY=; b=lzR0SWkRhwDXMtTH9D
        O4ev6daZLejKBhDHwJJOFrPg/sD4dGP3XDBsoQe3HFIu+HdcfTMf3MStfhTfZSLv
        p+zoYio6eXAdotdWVuNMn7zD55EqM7oV7Lj9zgsrYJus5r6AtfV+upwRE6AuI+jm
        ReYsyk5PFMh8OLRwQzqbML4PV98XfRplca0Zb5xIJPqXIyyWbIIDXy6baIirhe36
        lMFo+7y5q0KarkWiIOyXm41jHDoTO0T+AhwddBIdG+cBqJWKOYn8iDZAHNBDSA+7
        nFMs9K8KeaUx8D1XoO5UV+H/Ug0eeiMaZ5m46DZa+ceWqkSrm9VJABdxaNY9x+te
        cBCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701116259; x=1701202659; bh=oIxmWDxu2oALw
        bstLOvWGo+FZUSvDL0mwEFrMrgXeTY=; b=x6x830rV07bTQip075qZYit2xER4I
        vV/xi6pOy81hMaPIBupHnT3YhD69Y7WmF1Kc6pPJ/dMT5RZWh597BMVpMOrXqUdV
        Hx9uZODrh+qivFrXvzGUtOnPYm3vUwNrQnvrKS+Gjj1y/8N4xZAFWp85hJLhY5pU
        vLCAFWEZGMIBo6H0HM3NMHFntL49HL+++fN0WB2+gNNU4YZQXZXpKQ4v3AZ2yPLA
        wvTdomQg1xX02bnT/s4/enVI7rJ36YJCigszg1BMD1lpw7p3zyc8dAVNzBtkNhsp
        cmww9u54w6/LY23SPbs2wG7YsV5PuqyUH3i3fnbLdpnpuWxgBl3Xq2Pug==
X-ME-Sender: <xms:Y_lkZaHP6n3vIFvHutmeHCXNsA9B-HwKrE4eYiBzuPIYNauhxXFy7g>
    <xme:Y_lkZbUp5-HjFL-h-lCvI8ff1v2Tx73MWBNMcvPSjRlvhLuUZAcI8TR5911pkDdBM
    WYxzWz8fHrkylybk6g>
X-ME-Received: <xmr:Y_lkZUK4IT_WrKKSKtr4RGabSknlLgRKsD0PRuF8OqTJDBWPqCEA9I9jkjZbkggZy9QZHjNW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiuddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpedvvdegledtheefieejgfevgeefiefhtdevteefteduhfevtdefleethfetgeeluden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Y_lkZUEsoooa7k2zEjg43WjL58Jc2J-0JdPLO0wfXZVaX7WrhIwM0A>
    <xmx:Y_lkZQUC_yDMfTxyZEp4SyVtGnw_kx9PTVTfcF1LG-_jpzzF9PXGIQ>
    <xmx:Y_lkZXP25tuiqHtF0LCGu9giiuT2XJxXL2PmfThSz3dt2ZkcOgV2hA>
    <xmx:Y_lkZdhqpMU9qn9sf25L29jcapIqgcxbi8VsPHwk0VTcoiRwjNo4XQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Nov 2023 15:17:35 -0500 (EST)
Date:   Tue, 28 Nov 2023 09:17:23 +1300
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: disable USB0 hub on ROG
 Ally before suspend
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ZOTS4S.OUOP1DLTNVXP3@ljones.dev>
In-Reply-To: <1c5f3bd2-9f10-4e5d-8c6d-76441b2da850@redhat.com>
References: <20231126230521.125708-1-luke@ljones.dev>
        <20231126230521.125708-2-luke@ljones.dev>
        <1c5f3bd2-9f10-4e5d-8c6d-76441b2da850@redhat.com>
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



On Mon, Nov 27 2023 at 09:53:13 AM +01:00:00, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 11/27/23 00:05, Luke D. Jones wrote:
>>  ASUS have worked around an issue in XInput where it doesn't support 
>> USB
>>  selective suspend, which causes suspend issues in Windows. They 
>> worked
>>  around this by adjusting the MCU firmware to disable the USB0 hub 
>> when
>>  the screen is switched off during the Microsoft DSM suspend path in 
>> ACPI.
>> 
>>  The issue we have with this however is one of timing - the call the 
>> tells
>>  the MCU to this isn't able to complete before suspend is done so we 
>> call
>>  this in a prepare() and add a small msleep() to ensure it is done. 
>> This
>>  must be done before the screen is switched off to prevent a variety 
>> of
>>  possible races.
>> 
>>  Further to this the MCU powersave option must also be disabled as 
>> it can
>>  cause a number of issues such as:
>>  - unreliable resume connection of N-Key
>>  - complete loss of N-Key if the power is plugged in while suspended
>>  Disabling the powersave option prevents this.
>> 
>>  Without this the MCU is unable to initialise itself correctly on 
>> resume.
>> 
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> Thanks, patch looks good to me, except that all the new lines
> seem to use 4 spaces rather then a tab char as indent.

Apologies for the previous HTML email.
I must be going mad... are you sure? I've checked the patch file I 
submitted. Run checkpatch on it. Checked my email copy, and checked in 
lore... I can't see where space chars are?

> 
> With that fixed you can add my:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> to the next version.
> 
> Regards,
> 
> Hans
> 
> 
>>  ---
>>   drivers/platform/x86/asus-wmi.c            | 50 
>> ++++++++++++++++++++++
>>   include/linux/platform_data/x86/asus-wmi.h |  3 ++
>>   2 files changed, 53 insertions(+)
>> 
>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>> b/drivers/platform/x86/asus-wmi.c
>>  index 6a79f16233ab..4ba33dfebfd4 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -16,6 +16,7 @@
>>   #include <linux/acpi.h>
>>   #include <linux/backlight.h>
>>   #include <linux/debugfs.h>
>>  +#include <linux/delay.h>
>>   #include <linux/dmi.h>
>>   #include <linux/fb.h>
>>   #include <linux/hwmon.h>
>>  @@ -132,6 +133,11 @@ module_param(fnlock_default, bool, 0444);
>>   #define ASUS_SCREENPAD_BRIGHT_MAX 255
>>   #define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
>> 
>>  +/* Controls the power state of the USB0 hub on ROG Ally which 
>> input is on */
>>  +#define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
>>  +/* 300ms so far seems to produce a reliable result on AC and 
>> battery */
>>  +#define ASUS_USB0_PWR_EC0_CSEE_WAIT 300
>>  +
>>   static const char * const ashs_ids[] = { "ATK4001", "ATK4002", 
>> NULL };
>> 
>>   static int throttle_thermal_policy_write(struct asus_wmi *);
>>  @@ -300,6 +306,9 @@ struct asus_wmi {
>> 
>>   	bool fnlock_locked;
>> 
>>  +	/* The ROG Ally device requires the MCU USB device be 
>> disconnected before suspend */
>>  +	bool ally_mcu_usb_switch;
>>  +
>>   	struct asus_wmi_debug debug;
>> 
>>   	struct asus_wmi_driver *driver;
>>  @@ -4488,6 +4497,8 @@ static int asus_wmi_add(struct 
>> platform_device *pdev)
>>   	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, 
>> ASUS_WMI_DEVID_NV_THERM_TARGET);
>>   	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, 
>> ASUS_WMI_DEVID_PANEL_OD);
>>   	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, 
>> ASUS_WMI_DEVID_MINI_LED_MODE);
>>  +	asus->ally_mcu_usb_switch = acpi_has_method(NULL, 
>> ASUS_USB0_PWR_EC0_CSEE)
>>  +						&& dmi_match(DMI_BOARD_NAME, "RC71L");
>> 
>>   	err = fan_boost_mode_check_present(asus);
>>   	if (err)
>>  @@ -4654,6 +4665,43 @@ static int asus_hotk_resume(struct device 
>> *device)
>>   		asus_wmi_fnlock_update(asus);
>> 
>>   	asus_wmi_tablet_mode_get_state(asus);
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static int asus_hotk_resume_early(struct device *device)
>>  +{
>>  +	struct asus_wmi *asus = dev_get_drvdata(device);
>>  +
>>  +	if (asus->ally_mcu_usb_switch) {
>>  +		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, 
>> ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
>>  +			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
>>  +		else
>>  +			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
>>  +	}
>>  +	return 0;
>>  +}
>>  +
>>  +static int asus_hotk_prepare(struct device *device)
>>  +{
>>  +	struct asus_wmi *asus = dev_get_drvdata(device);
>>  +	int result, err;
>>  +
>>  +	if (asus->ally_mcu_usb_switch) {
>>  +		/* When powersave is enabled it causes many issues with resume 
>> of USB hub */
>>  +		result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_MCU_POWERSAVE);
>>  +		if (result == 1) {
>>  +			dev_warn(device, "MCU powersave enabled, disabling to prevent 
>> resume issues");
>>  +			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, 0, 
>> &result);
>>  +			if (err || result != 1)
>>  +				dev_err(device, "Failed to set MCU powersave mode: %d\n", err);
>>  +		}
>>  +		/* sleep required to ensure USB0 is disabled before sleep 
>> continues */
>>  +		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, 
>> ASUS_USB0_PWR_EC0_CSEE, 0xB7)))
>>  +			dev_err(device, "ROG Ally MCU failed to disconnect USB dev\n");
>>  +		else
>>  +			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
>>  +	}
>>   	return 0;
>>   }
>> 
>>  @@ -4701,6 +4749,8 @@ static const struct dev_pm_ops asus_pm_ops = {
>>   	.thaw = asus_hotk_thaw,
>>   	.restore = asus_hotk_restore,
>>   	.resume = asus_hotk_resume,
>>  +	.resume_early = asus_hotk_resume_early,
>>  +	.prepare = asus_hotk_prepare,
>>   };
>> 
>>   /* Registration 
>> ***************************************************************/
>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>> b/include/linux/platform_data/x86/asus-wmi.h
>>  index 63e630276499..ab1c7deff118 100644
>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>  @@ -114,6 +114,9 @@
>>   /* Charging mode - 1=Barrel, 2=USB */
>>   #define ASUS_WMI_DEVID_CHARGE_MODE	0x0012006C
>> 
>>  +/* MCU powersave mode */
>>  +#define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
>>  +
>>   /* epu is connected? 1 == true */
>>   #define ASUS_WMI_DEVID_EGPU_CONNECTED	0x00090018
>>   /* egpu on/off */
> 


