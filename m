Return-Path: <linux-kernel+bounces-27247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F03382ECBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02AC284FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2D13AC0;
	Tue, 16 Jan 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHXODNTX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBEF134D6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705400746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiMv+uvq92JCTmXCvsW6Nbc3mcTpVP9FkpubTec/vqo=;
	b=GHXODNTXedUC0VZi9MliV1LBYMBho6sFh/y9+pDXH/ICmJqvrtga4cGseMqghWaWfu6KYu
	kUrGd0NC2N/4892PKjN5ymiFQ1jmqAbcZy+WO1r+YkvUi9mxvdZeazWzG+89fqNP4rPUGd
	HFqfQzJ0mqQB1aEfaA8yx5zL2S5Fe0Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-TPw2LHaGOfOVURouIEsgxA-1; Tue, 16 Jan 2024 05:25:44 -0500
X-MC-Unique: TPw2LHaGOfOVURouIEsgxA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2b8bd6c6a3so618054566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 02:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705400743; x=1706005543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiMv+uvq92JCTmXCvsW6Nbc3mcTpVP9FkpubTec/vqo=;
        b=IT6l0ARV4qh5Wm6fCyrmoVdgdwdpU3+pNK6kUedfax24tBmL2u7+Mr0Nymia21zSvY
         f5HsDldCtKjnBFSTGHGC/Dm9/eLbAQrr4ZieCqqazXwlW1Bb9kKxY8/TGXP+SjRi6H7F
         G29PeS8VFaso0xqFqLjeJ8WevMCgVHBa6lmcwc/b31ZN/3WGCeR7DPOwciTTzLl7Swg2
         UULnM2lHukefktnB087jjQeaRBvTevodSW8GWRktOXw1TihPh6c0YllBYxsjzh005OjZ
         cGQ0h1X/LLPhuyf3yykCp1Y3vjJi3h7zSyLdItyiknXdV4zV5yrTnviGPhR7y61QpZc+
         UsHA==
X-Gm-Message-State: AOJu0Yw4qQmEOWLlK2Cjxhw0h56D0wG/Q8059g+2ZkpW7bD5//dlDD84
	Bonypbd9nROwxK6UNUrUvWv4Jdb2V3EeCVzMviOwCvQ5FlgjxU7uCp57OsyNhyTGtgAM+VnZ3T5
	/ZbVjydAtTSug0bx9zAnPLUG20F9quhZn
X-Received: by 2002:a17:906:2359:b0:a2b:804a:4192 with SMTP id m25-20020a170906235900b00a2b804a4192mr3265122eja.57.1705400743310;
        Tue, 16 Jan 2024 02:25:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEanu9bPhF/CtdeRFvMOI9vU4ArNRKtnVEY0jlPCuk3uFyH9hGwLse6UelyTcl6FI2G7WqK5Q==
X-Received: by 2002:a17:906:2359:b0:a2b:804a:4192 with SMTP id m25-20020a170906235900b00a2b804a4192mr3265114eja.57.1705400742953;
        Tue, 16 Jan 2024 02:25:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x25-20020a1709064bd900b00a28f54aacf1sm6334251ejv.185.2024.01.16.02.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 02:25:42 -0800 (PST)
Message-ID: <15f8da52-e413-4440-bd63-2ee8e96a340d@redhat.com>
Date: Tue, 16 Jan 2024 11:25:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Re-enable custom fan curves after
 setting throttle_thermal_policy
Content-Language: en-US, nl
To: Luke Jones <luke@ljones.dev>
Cc: Andrei Sabalenka <mechakotik@gmail.com>, corentin.chary@gmail.com,
 ilpo.jarvinen@linux.intel.com, acpi4asus-user@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240115122315.10250-1-mechakotik@gmail.com>
 <e776db0e-2376-415b-8688-f166118d4007@redhat.com>
 <JQKB7S.8ATKNVGHLV1L@ljones.dev>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <JQKB7S.8ATKNVGHLV1L@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luke,

On 1/15/24 21:25, Luke Jones wrote:
> 
> 
> On Mon, Jan 15 2024 at 13:38:16 +01:00:00, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 1/15/24 13:22, Andrei Sabalenka wrote:
>>>  When changing throttle_thermal_policy, all the custom fan curves are getting disabled. This patch re-enables all the custom fan curves that were enabled before changing throttle_thermal_policy.
>>>
>>>  I believe it makes asus-wmi sysfs interface more convenient, as it allows userspace to manage fan curves independently from platform_profile and throttle_thermal_policy. At the kernel level, custom fan curves should not be tied to "power profiles" scheme in any way, as it gives the user less freedom of controlling them.
>>
>> Setting a high performance power-profile typically also involves ramping up
>> the fans harder. So I don't think this patch is a good idea.
>>
>> If you really want this behavior then you can always re-enable the custom
>> curve after changing the profile.
>>
>> Luke, do you have any opinion on this?
> 
> I see some misconceptions that should be addressed:
> 1. ASUS themselves set separate fan curves per "platform profile", both standard and custom
> 2. fan curves are not tied to platform profiles, they are tied to the throttle_thermal_policy, and this is actually done in the acpi - so the code here is a mirror of that
> 3. platform-profiles are tied to throttle_thermal_policy
> 
> There is no lack of user control at all, a decent tool (like asusctl) can set fan curves without issues but it's perhaps not convenient for manually setting via a script etc.
> 
> The main reason that a curve is disabled for the policy being switched to is for safety. It was a paranoid choice I made at the time. The kernel (and acpi) can't guarantee that a user set a reasonable default for that policy so the safest thing is to force an explicit re-enable of it.
> 
> Having said that: I know that the curve was previously set for that profile/policy and in theory should be fine plus it is already used by the user, it is also not possible to set a curve for a different profile to the one a user is currently in -  this is forced in ACPI as you can set only the curve for the profile you are in (the kernel code also mirrors this).
> 
> So this patch should be fine.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

So I just checked asus-wmi.c again and there seems to be only 1 custom
curve per fan, one curve for CPU one for GPU and one for MID.

And while the custom curve may be fine for e.g. low-power mode,
that same custom curve may lead to overheating/throttling with
performance mode since performance mode typically requires
higher fan speeds.

As you write yourself: 'ASUS themselves set separate fan curves per
"platform profile", both standard and custom', but there is only 1
custom/user curve (in the kernel), not 1 per platform-profile.

So IMHO disabling the custom curve on profile switching is
the correct thing to do. Then userspace can do something like:

1. Have per platform-profile custom curves in some tool
2. Have that tool change (or monitor) platform-profile
3. Load new custom profile based on the new platform-profile
4. Enable the new (fitting to the new platform-profile)
   custom fan curve.

I also see that fan_curve_get_factory_default() retrieves the
defaults for a *specific* thermal-policy / platform-profile

So if a user somehow just enables custom-fancurves without
actually changing the curve then this patch would lead
to the following scenario:

1. Driver loads, lets assume the system boots in balanced
mode, balanced factory-default fan-curve is now loaded into
the custom fan-curve by fan_curve_check_present()

2. User calls fan_curve_enable_store() writing "1", because
reasons.

3. User changes platform-profile to performance,
throttle_thermal_policy_write() calls asus_wmi_set_devstate(
ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY) and the EC
sets fan curve to performance factory-default fan-curve.

4. Next throttle_thermal_policy_write() will now call
fan_curve_write() restoring the balanced factory-default
fan-curve even though we are in performance mode now.

This seems undesirable to me.

Restoring custom fan-curves automatically on platform-profile
change IMHO requires also storing a separate custom curve
per profile inside the kernel and populating all custom
curves with the factory defaults at boot. If I read what
you have written above this would also actually match
what you wrote above about ASUS using separate custom curves
per profile. If ASUS uses separate custom curves per profile
then IMHO so should Linux.

Note custom fan-curves per profile still means that the custom
curve will be overwritten when changing profiles, some new sysfs
interface would be necessary to write the non-active custom
curves so that the restored curve on profile switch can be
custom too on the first switch.

(rather then having to switch to be able to write the custom
curve for a profile other then the currently active profile).

Note this is not a 100% hard nack for this patch, but atm
I'm leaning towards a nack.

Regards,

Hans










> 
>>
>>>
>>>  Signed-off-by: Andrei Sabalenka <mechakotik@gmail.com>
>>>  ---
>>>   drivers/platform/x86/asus-wmi.c | 29 ++++++++++++++++++++++-------
>>>   1 file changed, 22 insertions(+), 7 deletions(-)
>>>
>>>  diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>  index 18be35fdb..c2e38f6d8 100644
>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>  @@ -3441,13 +3441,28 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>>>           return -EIO;
>>>       }
>>>
>>>  -    /* Must set to disabled if mode is toggled */
>>>  -    if (asus->cpu_fan_curve_available)
>>>  -        asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
>>>  -    if (asus->gpu_fan_curve_available)
>>>  -        asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled = false;
>>>  -    if (asus->mid_fan_curve_available)
>>>  -        asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled = false;
>>>  +    /* Re-enable fan curves after profile change */
>>>  +    if (asus->cpu_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled) {
>>>  +        err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_CPU]);
>>>  +        if (err) {
>>>  +            pr_warn("Failed to re-enable CPU fan curve: %d\n", err);
>>>  +            return err;
>>>  +        }
>>>  +    }
>>>  +    if (asus->gpu_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled) {
>>>  +        err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_GPU]);
>>>  +        if (err) {
>>>  +            pr_warn("Failed to re-enable GPU fan curve: %d\n", err);
>>>  +            return err;
>>>  +        }
>>>  +    }
>>>  +    if (asus->mid_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled) {
>>>  +        err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_MID]);
>>>  +        if (err) {
>>>  +            pr_warn("Failed to re-enable MID fan curve: %d\n", err);
>>>  +            return err;
>>>  +        }
>>>  +    }
>>>
>>>       return 0;
>>>   }
>>
> 
> 


