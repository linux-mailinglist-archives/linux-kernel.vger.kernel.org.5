Return-Path: <linux-kernel+bounces-26477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A482E1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40D31C22194
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C69199B2;
	Mon, 15 Jan 2024 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="H+HpQ4aB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJ2f9vBu"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945118E10;
	Mon, 15 Jan 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E9F573200AA9;
	Mon, 15 Jan 2024 15:26:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Jan 2024 15:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705350360; x=1705436760; bh=7QOLzz2DrL
	3dLpbkUpynFUGyDkNPTfHQ0AhJK1jrjEY=; b=H+HpQ4aBuRJk35JY0M2TKMgCL0
	9N3PQ0MliVNK0IfmHx3EApwk2AlGpH+md/1Y25MRmlSKUaBxySEh5+n2ail2Ed37
	9b1PAeOrf/yzS/oUqI1pOjI5HQeww3GOw/Ho/xBzzJ8ae5lrfVk+9mAsNNuxLN8x
	3IR9OOqHYMmRSIiR6C7UOXTOVOplGlRfpWAynXAzDYF7//CSUmfYh3F1r8gTRLMm
	+7ow5hcO2mTup+mrcQt48mr3YDDD5MaJ8YtqLqjRGPAAL10iYAxVIpV8dQuHimrW
	KyO5+8s6phkq/S8J8g4pDUN6FVSqvvab81Kfy6Rs6rnIymbv4IM0uuDW7lIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705350360; x=1705436760; bh=7QOLzz2DrL3dLpbkUpynFUGyDkNP
	TfHQ0AhJK1jrjEY=; b=BJ2f9vBu2F5eyRP65jUmrCroVNndxMoewDeDIuog9A5D
	Zh8Meo3VhKrq0KlzBvc2rJ8YmuVcUQ4gJ41OT4tSG1cZR/3os/D42RZqAkuTVbio
	ZpJR/8o+gY5vKnsZN3C8RBkUp1ThKsHtmaYBIZMh8I5y1OfdbMKXJw6COP+l3LIG
	o+gT5nawt9p8z7OiievMnMeRmPpWLrnq9OpM6PO4KuCwMBdb1yIdaxcOl20xB87P
	LQFBNMxXken4XV8As42m/q5K9msB/eUazPXGiOLlOHc/jOyzmaKAYtucx2URxJq2
	896zCqvV49tER9GWWtLOj483m5wlvgaHy5ONijT8IA==
X-ME-Sender: <xms:2JSlZUCs-6hZ87eLDS-xS510Wr5Eszigme-Ogm0ZsPlJmp-2jMGw_g>
    <xme:2JSlZWjz36Je4zbOEBE4_KWmzPRNPHan8kxFlxWINxXHQZqv-hGPPj5JIOvi--Rv2
    D3rRAGYMXHbS95fN1M>
X-ME-Received: <xmr:2JSlZXlrShkySNZuZIT2rNlbhV8czwZ-5MxLjaB8_8t9hU6_h7zzfis7YkTOQKiYYimGNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpedvvdegledtheefieejgfevgeefiefhtdevteefteduhfevtdefleethfetgeeluden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:2JSlZazkref_ESiuBUtod2ZEiBgGjeXQiR49Iczbo9I7DpKMl_GF1Q>
    <xmx:2JSlZZSpUBMRnkhSomleGTmr079yxkoSt0YzHdcwGRzBAH28rgRu9g>
    <xmx:2JSlZVbICd9otsPg1EeCEa78EohZ6GGRUywkUgvR2eGz8KG-Tzp4yw>
    <xmx:2JSlZXNRCyGnAIU8ry2Sv95qZ2j9_uNYeouza4-T3LKgfJG7FYjPzg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 15:25:53 -0500 (EST)
Date: Tue, 16 Jan 2024 09:25:31 +1300
From: Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] platform/x86: asus-wmi: Re-enable custom fan curves after
 setting throttle_thermal_policy
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andrei Sabalenka <mechakotik@gmail.com>, corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com, acpi4asus-user@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <JQKB7S.8ATKNVGHLV1L@ljones.dev>
In-Reply-To: <e776db0e-2376-415b-8688-f166118d4007@redhat.com>
References: <20240115122315.10250-1-mechakotik@gmail.com>
	<e776db0e-2376-415b-8688-f166118d4007@redhat.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Mon, Jan 15 2024 at 13:38:16 +01:00:00, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 1/15/24 13:22, Andrei Sabalenka wrote:
>>  When changing throttle_thermal_policy, all the custom fan curves 
>> are getting disabled. This patch re-enables all the custom fan 
>> curves that were enabled before changing throttle_thermal_policy.
>> 
>>  I believe it makes asus-wmi sysfs interface more convenient, as it 
>> allows userspace to manage fan curves independently from 
>> platform_profile and throttle_thermal_policy. At the kernel level, 
>> custom fan curves should not be tied to "power profiles" scheme in 
>> any way, as it gives the user less freedom of controlling them.
> 
> Setting a high performance power-profile typically also involves 
> ramping up
> the fans harder. So I don't think this patch is a good idea.
> 
> If you really want this behavior then you can always re-enable the 
> custom
> curve after changing the profile.
> 
> Luke, do you have any opinion on this?

I see some misconceptions that should be addressed:
1. ASUS themselves set separate fan curves per "platform profile", both 
standard and custom
2. fan curves are not tied to platform profiles, they are tied to the 
throttle_thermal_policy, and this is actually done in the acpi - so the 
code here is a mirror of that
3. platform-profiles are tied to throttle_thermal_policy

There is no lack of user control at all, a decent tool (like asusctl) 
can set fan curves without issues but it's perhaps not convenient for 
manually setting via a script etc.

The main reason that a curve is disabled for the policy being switched 
to is for safety. It was a paranoid choice I made at the time. The 
kernel (and acpi) can't guarantee that a user set a reasonable default 
for that policy so the safest thing is to force an explicit re-enable 
of it.

Having said that: I know that the curve was previously set for that 
profile/policy and in theory should be fine plus it is already used by 
the user, it is also not possible to set a curve for a different 
profile to the one a user is currently in -  this is forced in ACPI as 
you can set only the curve for the profile you are in (the kernel code 
also mirrors this).

So this patch should be fine.

Signed-off-by: Luke D. Jones <luke@ljones.dev>

> 
>> 
>>  Signed-off-by: Andrei Sabalenka <mechakotik@gmail.com>
>>  ---
>>   drivers/platform/x86/asus-wmi.c | 29 ++++++++++++++++++++++-------
>>   1 file changed, 22 insertions(+), 7 deletions(-)
>> 
>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>> b/drivers/platform/x86/asus-wmi.c
>>  index 18be35fdb..c2e38f6d8 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -3441,13 +3441,28 @@ static int 
>> throttle_thermal_policy_write(struct asus_wmi *asus)
>>   		return -EIO;
>>   	}
>> 
>>  -	/* Must set to disabled if mode is toggled */
>>  -	if (asus->cpu_fan_curve_available)
>>  -		asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
>>  -	if (asus->gpu_fan_curve_available)
>>  -		asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled = false;
>>  -	if (asus->mid_fan_curve_available)
>>  -		asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled = false;
>>  +	/* Re-enable fan curves after profile change */
>>  +	if (asus->cpu_fan_curve_available && 
>> asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled) {
>>  +		err = fan_curve_write(asus, 
>> &asus->custom_fan_curves[FAN_CURVE_DEV_CPU]);
>>  +		if (err) {
>>  +			pr_warn("Failed to re-enable CPU fan curve: %d\n", err);
>>  +			return err;
>>  +		}
>>  +	}
>>  +	if (asus->gpu_fan_curve_available && 
>> asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled) {
>>  +		err = fan_curve_write(asus, 
>> &asus->custom_fan_curves[FAN_CURVE_DEV_GPU]);
>>  +		if (err) {
>>  +			pr_warn("Failed to re-enable GPU fan curve: %d\n", err);
>>  +			return err;
>>  +		}
>>  +	}
>>  +	if (asus->mid_fan_curve_available && 
>> asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled) {
>>  +		err = fan_curve_write(asus, 
>> &asus->custom_fan_curves[FAN_CURVE_DEV_MID]);
>>  +		if (err) {
>>  +			pr_warn("Failed to re-enable MID fan curve: %d\n", err);
>>  +			return err;
>>  +		}
>>  +	}
>> 
>>   	return 0;
>>   }
> 



