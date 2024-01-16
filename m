Return-Path: <linux-kernel+bounces-27311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61FB82EDA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7D21C23281
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6EA1B949;
	Tue, 16 Jan 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpiJ2E9I"
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB341B945;
	Tue, 16 Jan 2024 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-6ddec7e5747so4481705a34.3;
        Tue, 16 Jan 2024 03:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705404289; x=1706009089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTc+c4edYlFfJchp0Igu7aviTpqSoXKhUagZwU54V/o=;
        b=XpiJ2E9Iobu+avUnbewUUc6zPdZBY3gSEiiThvfzmODhE4GAgwXpdzqCbZ1f73mPDI
         51x1ot0tmjCMiDfryZmmIv9eH5uLcQUHiFZ2n42FCMz301S/OZfJhaNT1G263mOe8FpT
         7Mt/M6QAphOQRiOQ7UStYgV0EJ1Zr6mukPfsvkS/ayKXh7fdPSvDElsXp5fCBiyCTxxO
         4MtFpi0zU7fZ+vB6d/pQkmTQuyhvnX7Bsely7Z7ajui1MIxU8n7WBfJiHSFDEc3dsRD2
         bzjivdVPyoVt5ADruVJHiDzMlNc0dobMd2QO3sGiIds4NEQvQxpvIrFJZVyoNgxLfLJX
         h8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705404289; x=1706009089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTc+c4edYlFfJchp0Igu7aviTpqSoXKhUagZwU54V/o=;
        b=X/Kp3a9Lv8npqBEZ/S8H4jvDJUg9NntyXyICc0pgSNd5szr1QuM3et9iGgjCspZlWw
         jPnFgXvIbUvQRG1j2rGcmgDqHhNb9HNzSJM42JYzY5JzXmn5snfQhlCrvfaVitMtfLJw
         t7inQ6//M6xOlMFraXHcPXHjybVxD6U440pzdeJy3+Pn+K8Jjnu6TVZLrlXYUWja/c+y
         VU8vuihMlqtzZs8mQU5vb/Bn3qmzAYkDd14HSyWYE/AAkF+M0GMIl/KJ77ZLdTqxHmf4
         kQM3xaDdTV35pYgHkHfWXz3Z98DsI+oP5G+vLoXOqEi/xEDz7aKkHt34NIUfj9qi7Ute
         +Fuw==
X-Gm-Message-State: AOJu0Yy9naV80sMpSarrCbJt+slY09YnINE2/8U0BDJtqvV5wxi6NIKC
	D6lC3+EIB6AhsN2WBeaSEfW9nF2Kg6gd5L6X9IU=
X-Google-Smtp-Source: AGHT+IGiIoWTwWhoiduU5M1FwwJykQKOHgJDTHbryZu80GMcEzKrrzGJnMpspLKfgauM1q9vrZxMQsSARgC2Jqalols=
X-Received: by 2002:a9d:6b96:0:b0:6dd:ed61:5e34 with SMTP id
 b22-20020a9d6b96000000b006dded615e34mr8457174otq.68.1705404289051; Tue, 16
 Jan 2024 03:24:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115122315.10250-1-mechakotik@gmail.com> <e776db0e-2376-415b-8688-f166118d4007@redhat.com>
 <JQKB7S.8ATKNVGHLV1L@ljones.dev> <15f8da52-e413-4440-bd63-2ee8e96a340d@redhat.com>
In-Reply-To: <15f8da52-e413-4440-bd63-2ee8e96a340d@redhat.com>
From: Andrei Sabalenka <mechakotik@gmail.com>
Date: Tue, 16 Jan 2024 14:24:38 +0300
Message-ID: <CAFh4unEOpJXbPKsHEvoH4hnCNeMYmgg2brGG2a1bfP9pq3T_yA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Re-enable custom fan curves after
 setting throttle_thermal_policy
To: Hans de Goede <hdegoede@redhat.com>
Cc: Luke Jones <luke@ljones.dev>, corentin.chary@gmail.com, 
	ilpo.jarvinen@linux.intel.com, acpi4asus-user@lists.sourceforge.net, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thanks for the feedback!

> If ASUS uses separate custom curves per profile then IMHO so
> should Linux.

I don't think having a fan curve per a profile in the kernel is
a good idea, as user may want different behaviour. The fact that
Windows driver does this is not the reason Linux driver should
do the same. Full control over the system is one of the main
reasons we love Linux, isn't it?

The current sysfs interface is more flexible than the official
driver. However, fan curves getting disabled when changing
throttle thermal policy is basically a side effect, which a
good interface should avoid having.

Enabling custom fan curve means user take full control over it.
If user wants to have a separate fan curve for each profile,
he will simply overwrite the current fan curve when profile is
changed. If not, the curve will remain unchanged, like it should
logically be.

So this patch doesn't make worse if user wants to use power
profiles scheme, but it makes controlling fan curves much easier
if he wants to control fan curves independently from thermal
throttle policy (for example, TTP depends on the current power
source, quiet fan curve is used by default and more noisy one
is turning on when some resource heavy tasks like games and
building from source are running).

Best regards,
Andrei


>
> Hi Luke,
>
> On 1/15/24 21:25, Luke Jones wrote:
> >
> >
> > On Mon, Jan 15 2024 at 13:38:16 +01:00:00, Hans de Goede <hdegoede@redh=
at.com> wrote:
> >> Hi,
> >>
> >> On 1/15/24 13:22, Andrei Sabalenka wrote:
> >>>  When changing throttle_thermal_policy, all the custom fan curves are=
 getting disabled. This patch re-enables all the custom fan curves that wer=
e enabled before changing throttle_thermal_policy.
> >>>
> >>>  I believe it makes asus-wmi sysfs interface more convenient, as it a=
llows userspace to manage fan curves independently from platform_profile an=
d throttle_thermal_policy. At the kernel level, custom fan curves should no=
t be tied to "power profiles" scheme in any way, as it gives the user less =
freedom of controlling them.
> >>
> >> Setting a high performance power-profile typically also involves rampi=
ng up
> >> the fans harder. So I don't think this patch is a good idea.
> >>
> >> If you really want this behavior then you can always re-enable the cus=
tom
> >> curve after changing the profile.
> >>
> >> Luke, do you have any opinion on this?
> >
> > I see some misconceptions that should be addressed:
> > 1. ASUS themselves set separate fan curves per "platform profile", both=
 standard and custom
> > 2. fan curves are not tied to platform profiles, they are tied to the t=
hrottle_thermal_policy, and this is actually done in the acpi - so the code=
 here is a mirror of that
> > 3. platform-profiles are tied to throttle_thermal_policy
> >
> > There is no lack of user control at all, a decent tool (like asusctl) c=
an set fan curves without issues but it's perhaps not convenient for manual=
ly setting via a script etc.
> >
> > The main reason that a curve is disabled for the policy being switched =
to is for safety. It was a paranoid choice I made at the time. The kernel (=
and acpi) can't guarantee that a user set a reasonable default for that pol=
icy so the safest thing is to force an explicit re-enable of it.
> >
> > Having said that: I know that the curve was previously set for that pro=
file/policy and in theory should be fine plus it is already used by the use=
r, it is also not possible to set a curve for a different profile to the on=
e a user is currently in -  this is forced in ACPI as you can set only the =
curve for the profile you are in (the kernel code also mirrors this).
> >
> > So this patch should be fine.
> >
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>
> So I just checked asus-wmi.c again and there seems to be only 1 custom
> curve per fan, one curve for CPU one for GPU and one for MID.
>
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
> >
> >>
> >>>
> >>>  Signed-off-by: Andrei Sabalenka <mechakotik@gmail.com>
> >>>  ---
> >>>   drivers/platform/x86/asus-wmi.c | 29 ++++++++++++++++++++++-------
> >>>   1 file changed, 22 insertions(+), 7 deletions(-)
> >>>
> >>>  diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> >>>  index 18be35fdb..c2e38f6d8 100644
> >>>  --- a/drivers/platform/x86/asus-wmi.c
> >>>  +++ b/drivers/platform/x86/asus-wmi.c
> >>>  @@ -3441,13 +3441,28 @@ static int throttle_thermal_policy_write(str=
uct asus_wmi *asus)
> >>>           return -EIO;
> >>>       }
> >>>
> >>>  -    /* Must set to disabled if mode is toggled */
> >>>  -    if (asus->cpu_fan_curve_available)
> >>>  -        asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled =3D fals=
e;
> >>>  -    if (asus->gpu_fan_curve_available)
> >>>  -        asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled =3D fals=
e;
> >>>  -    if (asus->mid_fan_curve_available)
> >>>  -        asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled =3D fals=
e;
> >>>  +    /* Re-enable fan curves after profile change */
> >>>  +    if (asus->cpu_fan_curve_available && asus->custom_fan_curves[FA=
N_CURVE_DEV_CPU].enabled) {
> >>>  +        err =3D fan_curve_write(asus, &asus->custom_fan_curves[FAN_=
CURVE_DEV_CPU]);
> >>>  +        if (err) {
> >>>  +            pr_warn("Failed to re-enable CPU fan curve: %d\n", err)=
;
> >>>  +            return err;
> >>>  +        }
> >>>  +    }
> >>>  +    if (asus->gpu_fan_curve_available && asus->custom_fan_curves[FA=
N_CURVE_DEV_GPU].enabled) {
> >>>  +        err =3D fan_curve_write(asus, &asus->custom_fan_curves[FAN_=
CURVE_DEV_GPU]);
> >>>  +        if (err) {
> >>>  +            pr_warn("Failed to re-enable GPU fan curve: %d\n", err)=
;
> >>>  +            return err;
> >>>  +        }
> >>>  +    }
> >>>  +    if (asus->mid_fan_curve_available && asus->custom_fan_curves[FA=
N_CURVE_DEV_MID].enabled) {
> >>>  +        err =3D fan_curve_write(asus, &asus->custom_fan_curves[FAN_=
CURVE_DEV_MID]);
> >>>  +        if (err) {
> >>>  +            pr_warn("Failed to re-enable MID fan curve: %d\n", err)=
;
> >>>  +            return err;
> >>>  +        }
> >>>  +    }
> >>>
> >>>       return 0;
> >>>   }
> >>
> >
> >
>

