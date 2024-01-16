Return-Path: <linux-kernel+bounces-31704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E88332B5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 05:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC5C1F22FF6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AC81366;
	Sat, 20 Jan 2024 04:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="MfqfZf/m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ylbP0at9"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B720E8;
	Sat, 20 Jan 2024 04:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705724087; cv=none; b=uaes90aVUPSSqGQ1scTQi7N7v2cXTdHUi54/igJ7QF4K7UOgy4/G5W0/jF5IneN/b4zDslIiEWSSEjwesUuOuaoL/ih9wly65NBhpUlL75SQQZVEhVHP4ymR+sD4gR1B33QgF1Zi2pCAADJQDN91vBcNCFNeHWIepYSQ7D4jq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705724087; c=relaxed/simple;
	bh=mJfvr0IMQJPjLDhoG/hRig1BfeH3e92cnQtUTdbzqcg=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dN/2PA4KlPsmbsplEg86/0Dx/4uFSLn9Kjex7TcoWJ86sAQ37l/iVmjIcL09hD1BAGZI+3Y9Z8eqXv+efdGY0tVFZL7xbFJoeoqderkYrUfJuuxDNAatWpQLIF8aX38quJTNFHhy3MUB6C+8TVpZMaqwnPCAXKVbLjWFSzdDn/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=MfqfZf/m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ylbP0at9; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id A6ED51C00076;
	Fri, 19 Jan 2024 23:14:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 19 Jan 2024 23:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705724083; x=1705810483; bh=kx1mHVrJWA
	o+SJ9Y+JfHtxSfUvCwDNlmhYg4JRHpj0A=; b=MfqfZf/muwpOpCurkYLtptccCz
	mpTguzUGV+tIVE7Buqk5R5A0JUtU8ABgWXGS9yZZkkAK6/rreKAniYEOQEtT4ZyH
	q5OuuccwIfZkVRi0IIaq31Fsq/y5jWzlIcuTYSvf0/Gl8ZDH75Cznex7HQbL3qf2
	jnJuJzBDv6I5jsgge9hMP8xC8PJyWHYiepisfw1Y0oHrv/ug2btTUvtvPTXDzx8m
	H2uy6cvlpJepm9ijc7yZKhLZoWMtYmCcDHih4F0fp2bnmVXkdsHsDe5ioy1Jzekl
	6qDBlEVNcYiCcHvak9V9CTKTTOS7BkD8MIqxUj3lq3LRnC8+ElAswDeYAJZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705724083; x=1705810483; bh=kx1mHVrJWAo+SJ9Y+JfHtxSfUvCw
	DNlmhYg4JRHpj0A=; b=ylbP0at9QDWxYnxI5vqpBuRuh18RTR9UkEL8zY0ajUcw
	ViwTrz9vb/tw6A3q/Tl4fSbGXJLtZJ9SvUCwOuoJmcRodbnELJoiWhCcBvfoYT0+
	lc991F51ZgqloUi38wWjTCNh/v8sDBOzrQalpTFu2LlpXv1MF+May6qfhoC7G/La
	YbFhHS0FEQTSdD92ZCos4Lv6syT18/0X5o7oyOGJcEd5X2/QqBrjhqCniTGx8dY5
	tOyB2Ic15EomWmfeqCQRrcZHLHDnF94FHYQyBY+yRc0Q81nbC7rygC/qbhxgjVgB
	lMoCFbsqIYrJrK4ESM8LKPjmjaiUe5CF0uVOHh2w2g==
X-ME-Sender: <xms:skirZchc4uczOSOvHp66R9PjEZjri_yR9YTxqZ7DPGwXiVVI5164oA>
    <xme:skirZVBNE1uVsAf0I-cIGOHrox0zaKYYvVVGwordfgfuqnsRXR90P8WmtAni3msF-
    qs_flXz4LDN2yjt5BY>
X-ME-Received: <xmr:skirZUEjzruoW-1Sg2D4j_xTLQk2CiOdIdK4aqXJ6Wh6NTXyXAR3IvYi-1_DAs96buEo5K3y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:skirZdTUQE1Y9SeZnkNQfhdPU6Z9N5NeA5m3ENxtptQxuPXbD8dzCQ>
    <xmx:skirZZzahGunOt5MHx4Btrz54MErTmgkY1gp5jcDN60S-68_zUxViQ>
    <xmx:skirZb7Yr3T_hK8cTLFrFjZ3LoIH8UVEiJxzdyXitgnLkvqESOi48w>
    <xmx:s0irZQmEQFu0Fj6rWwd8bm1PsYaw0OvL4Z6dx_n6rwHObpHzY-TaPgqNgGE>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 23:14:38 -0500 (EST)
Date: Wed, 17 Jan 2024 08:43:01 +1300
From: Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] platform/x86: asus-wmi: Re-enable custom fan curves after
 setting throttle_thermal_policy
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andrei Sabalenka <mechakotik@gmail.com>, corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com, acpi4asus-user@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <PFDD7S.4NAT8RZ4C0PR2@ljones.dev>
In-Reply-To: <15f8da52-e413-4440-bd63-2ee8e96a340d@redhat.com>
References: <20240115122315.10250-1-mechakotik@gmail.com>
	<e776db0e-2376-415b-8688-f166118d4007@redhat.com>
	<JQKB7S.8ATKNVGHLV1L@ljones.dev>
	<15f8da52-e413-4440-bd63-2ee8e96a340d@redhat.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Tue, Jan 16 2024 at 11:25:41 +01:00:00, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Luke,
> 
> On 1/15/24 21:25, Luke Jones wrote:
>> 
>> 
>>  On Mon, Jan 15 2024 at 13:38:16 +01:00:00, Hans de Goede 
>> <hdegoede@redhat.com> wrote:
>>>  Hi,
>>> 
>>>  On 1/15/24 13:22, Andrei Sabalenka wrote:
>>>>   When changing throttle_thermal_policy, all the custom fan curves 
>>>> are getting disabled. This patch re-enables all the custom fan 
>>>> curves that were enabled before changing throttle_thermal_policy.
>>>> 
>>>>   I believe it makes asus-wmi sysfs interface more convenient, as 
>>>> it allows userspace to manage fan curves independently from 
>>>> platform_profile and throttle_thermal_policy. At the kernel level, 
>>>> custom fan curves should not be tied to "power profiles" scheme in 
>>>> any way, as it gives the user less freedom of controlling them.
>>> 
>>>  Setting a high performance power-profile typically also involves 
>>> ramping up
>>>  the fans harder. So I don't think this patch is a good idea.
>>> 
>>>  If you really want this behavior then you can always re-enable the 
>>> custom
>>>  curve after changing the profile.
>>> 
>>>  Luke, do you have any opinion on this?
>> 
>>  I see some misconceptions that should be addressed:
>>  1. ASUS themselves set separate fan curves per "platform profile", 
>> both standard and custom
>>  2. fan curves are not tied to platform profiles, they are tied to 
>> the throttle_thermal_policy, and this is actually done in the acpi - 
>> so the code here is a mirror of that
>>  3. platform-profiles are tied to throttle_thermal_policy
>> 
>>  There is no lack of user control at all, a decent tool (like 
>> asusctl) can set fan curves without issues but it's perhaps not 
>> convenient for manually setting via a script etc.
>> 
>>  The main reason that a curve is disabled for the policy being 
>> switched to is for safety. It was a paranoid choice I made at the 
>> time. The kernel (and acpi) can't guarantee that a user set a 
>> reasonable default for that policy so the safest thing is to force 
>> an explicit re-enable of it.
>> 
>>  Having said that: I know that the curve was previously set for that 
>> profile/policy and in theory should be fine plus it is already used 
>> by the user, it is also not possible to set a curve for a different 
>> profile to the one a user is currently in -  this is forced in ACPI 
>> as you can set only the curve for the profile you are in (the kernel 
>> code also mirrors this).
>> 
>>  So this patch should be fine.
>> 
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> So I just checked asus-wmi.c again and there seems to be only 1 custom
> curve per fan, one curve for CPU one for GPU and one for MID.

I misread sorry. Yes this is correct. The ACPI only allows fetching the 
defaults for the currently loaded profile so this was a result of that.

> And while the custom curve may be fine for e.g. low-power mode,
> that same custom curve may lead to overheating/throttling with
> performance mode since performance mode typically requires
> higher fan speeds.
> 
> As you write yourself: 'ASUS themselves set separate fan curves per
> "platform profile", both standard and custom', but there is only 1
> custom/user curve (in the kernel), not 1 per platform-profile.
> 
> So IMHO disabling the custom curve on profile switching is
> the correct thing to do. Then userspace can do something like:
> 

Yes agreed. And that is indeed why I set them to off originally when 
changing profile.

> 1. Have per platform-profile custom curves in some tool
> 2. Have that tool change (or monitor) platform-profile
> 3. Load new custom profile based on the new platform-profile
> 4. Enable the new (fitting to the new platform-profile)
>    custom fan curve.
> 
> I also see that fan_curve_get_factory_default() retrieves the
> defaults for a *specific* thermal-policy / platform-profile
> 
> So if a user somehow just enables custom-fancurves without
> actually changing the curve then this patch would lead
> to the following scenario:
> 
> 1. Driver loads, lets assume the system boots in balanced
> mode, balanced factory-default fan-curve is now loaded into
> the custom fan-curve by fan_curve_check_present()
> 
> 2. User calls fan_curve_enable_store() writing "1", because
> reasons.
> 
> 3. User changes platform-profile to performance,
> throttle_thermal_policy_write() calls asus_wmi_set_devstate(
> ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY) and the EC
> sets fan curve to performance factory-default fan-curve.
> 
> 4. Next throttle_thermal_policy_write() will now call
> fan_curve_write() restoring the balanced factory-default
> fan-curve even though we are in performance mode now.
> 
> This seems undesirable to me.
> 
> Restoring custom fan-curves automatically on platform-profile
> change IMHO requires also storing a separate custom curve
> per profile inside the kernel and populating all custom
> curves with the factory defaults at boot. If I read what
> you have written above this would also actually match
> what you wrote above about ASUS using separate custom curves
> per profile. If ASUS uses separate custom curves per profile
> then IMHO so should Linux.

This is correct yes.

> 
> Note custom fan-curves per profile still means that the custom
> curve will be overwritten when changing profiles, some new sysfs
> interface would be necessary to write the non-active custom
> curves so that the restored curve on profile switch can be
> custom too on the first switch.
> 
> (rather then having to switch to be able to write the custom
> curve for a profile other then the currently active profile).
> 
> Note this is not a 100% hard nack for this patch, but atm
> I'm leaning towards a nack.

I revert my signed-off. This is a nack. Everything a user may want can 
be done in userspace.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
>> 
>>> 
>>>> 
>>>>   Signed-off-by: Andrei Sabalenka <mechakotik@gmail.com>
>>>>   ---
>>>>    drivers/platform/x86/asus-wmi.c | 29 
>>>> ++++++++++++++++++++++-------
>>>>    1 file changed, 22 insertions(+), 7 deletions(-)
>>>> 
>>>>   diff --git a/drivers/platform/x86/asus-wmi.c 
>>>> b/drivers/platform/x86/asus-wmi.c
>>>>   index 18be35fdb..c2e38f6d8 100644
>>>>   --- a/drivers/platform/x86/asus-wmi.c
>>>>   +++ b/drivers/platform/x86/asus-wmi.c
>>>>   @@ -3441,13 +3441,28 @@ static int 
>>>> throttle_thermal_policy_write(struct asus_wmi *asus)
>>>>            return -EIO;
>>>>        }
>>>> 
>>>>   -    /* Must set to disabled if mode is toggled */
>>>>   -    if (asus->cpu_fan_curve_available)
>>>>   -        asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = 
>>>> false;
>>>>   -    if (asus->gpu_fan_curve_available)
>>>>   -        asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled = 
>>>> false;
>>>>   -    if (asus->mid_fan_curve_available)
>>>>   -        asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled = 
>>>> false;
>>>>   +    /* Re-enable fan curves after profile change */
>>>>   +    if (asus->cpu_fan_curve_available && 
>>>> asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled) {
>>>>   +        err = fan_curve_write(asus, 
>>>> &asus->custom_fan_curves[FAN_CURVE_DEV_CPU]);
>>>>   +        if (err) {
>>>>   +            pr_warn("Failed to re-enable CPU fan curve: %d\n", 
>>>> err);
>>>>   +            return err;
>>>>   +        }
>>>>   +    }
>>>>   +    if (asus->gpu_fan_curve_available && 
>>>> asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled) {
>>>>   +        err = fan_curve_write(asus, 
>>>> &asus->custom_fan_curves[FAN_CURVE_DEV_GPU]);
>>>>   +        if (err) {
>>>>   +            pr_warn("Failed to re-enable GPU fan curve: %d\n", 
>>>> err);
>>>>   +            return err;
>>>>   +        }
>>>>   +    }
>>>>   +    if (asus->mid_fan_curve_available && 
>>>> asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled) {
>>>>   +        err = fan_curve_write(asus, 
>>>> &asus->custom_fan_curves[FAN_CURVE_DEV_MID]);
>>>>   +        if (err) {
>>>>   +            pr_warn("Failed to re-enable MID fan curve: %d\n", 
>>>> err);
>>>>   +            return err;
>>>>   +        }
>>>>   +    }
>>>> 
>>>>        return 0;
>>>>    }
>>> 
>> 
>> 
> 



