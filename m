Return-Path: <linux-kernel+bounces-9265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8B381C324
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22A7B25701
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB215A4;
	Fri, 22 Dec 2023 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmF8ynSe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2A4699;
	Fri, 22 Dec 2023 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d099d316a8so1401720b3a.0;
        Thu, 21 Dec 2023 18:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703212534; x=1703817334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F41gjk22/8XF7wdrXN44EAASWHCnE2ogjFxGWtoeVo=;
        b=cmF8ynSew7zcmjSGiCsRNJj/qgNz5hYEErOYwUFwchZdDa6Rab0OmCjjiagRRCISoS
         zEmL4LnivWarSa4qkp6OQzRyLdNAA+NU9JR1DDzlqyHMHGqouHFvGt1ag1zl35A6W5Am
         /w6HgVe1fxY+Tv78Bz1JcRDtNJ0N+84WWc5TqMAe9/Q45xDrJQIwf0KIoxHfvzdbYf4r
         YsINjz8Fe5iJn+beiTeCfrt2n57bDuKpzt8uevewGhfYuiBzdJzc1ZBcAzO9hK0/PaYY
         EB9qLKKlqVOpBMn8lr5vLvKnH933YTJO6xNqKs0T/Mr4ZrwOnkVTAePdcHBu2AmioQAj
         jaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703212534; x=1703817334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1F41gjk22/8XF7wdrXN44EAASWHCnE2ogjFxGWtoeVo=;
        b=mnsbDqgTfO+ou1uFYRFKkr4b6oxvZ/rOWsgj9c9Tmwzcni4/iyLhUQHKJmXNxVjsNd
         aU+vv4p+/2oqCqC7eWBowKLu3plobhBBw8Ji0A/cqvYSioRI0EWWdQRX8doa5YmyRjex
         8fQdwqTJ07/aoqdmdxQwJ4/2qD6+M4z815uxFo+hHsYgU5Uj+MsOJvYSgk8QLd0GAOqz
         Bv82RgB3+c2Z9Gc4zSSD6xLtbqakZv1W70OjIAlsNJmDKsqwXMeiKLhdwim8Efw80zgq
         zotnRTr2GROAn35GDus0H5Io7DSzXYMN2rO+KGKmxcj9jggiSRrjk7BcEDxmIAMgmr4x
         vMQw==
X-Gm-Message-State: AOJu0Yz388RLypRTBI7HSZZFxBk/KUB0Pd/Xmbqs9xZfbTkZQb6Keevm
	+mmq/waOkkdxadKoDVlM0+PUQqjFFZozpXJPDtY=
X-Google-Smtp-Source: AGHT+IFaxueBZdOz7yKsg8T921Wxw3cuSAsbW2/yV/5x/MNgKMSqpEbErIlv/Vq6whgkoNOYGl8uV+RtUTPx2BT24UI=
X-Received: by 2002:a05:6a21:78a0:b0:195:2c0f:e28c with SMTP id
 bf32-20020a056a2178a000b001952c0fe28cmr655954pzc.102.1703212533761; Thu, 21
 Dec 2023 18:35:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221104343.5557-1-2045gemini@gmail.com> <abc324aa-1ccc-c8fd-1437-a77465f6e4be@huaweicloud.com>
 <CAOPYjvbfGZObUa+P5Bo_syLMpyMNEPU6SNm6xJPSqSZYREmNfw@mail.gmail.com>
In-Reply-To: <CAOPYjvbfGZObUa+P5Bo_syLMpyMNEPU6SNm6xJPSqSZYREmNfw@mail.gmail.com>
From: 20 39 <2045gemini@gmail.com>
Date: Fri, 22 Dec 2023 10:34:58 +0800
Message-ID: <CAOPYjvYhEzeF3vdd9GXCX+k_-OmsE1yP7VNozcMt4vOyFLDAfw@mail.gmail.com>
Subject: Re: [PATCH] md/raid5: fix atomicity violation in raid5_cache_count
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuai,

Thank you for your patience. This email is essentially the same as my
previous one, only now adjusted to plain text format. I apologize for
any inconvenience caused earlier.

Thanks for your email and the insightful points you've raised. Let me
clarify a few aspects regarding the raid5_cache_count() and
raid5_set_cache_size() functions.

1. Callback Function in setup_conf(): You mentioned that
raid5_cache_count() is called from setup_conf() where reconfig_mutex
is held. While this is true, it's important to note that
raid5_cache_count() is actually initialized as a callback function in
setup_conf(), as described in /include/linux/shrinker.h. This means it
could be invoked later in a context where the reconfig_mutex isn't
necessarily held. The documentation in shrinker.h indicates potential
invocation scenarios beyond the initial setup context.

2. Comment on Unlikely Scenario: Regarding the comment in the code /*
unlikely, but not impossible */, it seems to acknowledge the
possibility of a race condition where conf->max_nr_stripes is less
than conf->min_nr_stripes. This comment implies that previous
developers might have noticed potential issues with race conditions,
even if they are considered unlikely.

3. Use of Local Variables Instead of Locks: In addressing this issue,
my approach doesn't involve introducing additional locks, which could
potentially lead to deadlocks or other concurrency problems. Instead,
I've opted to store the values in local variables to ensure that the
check remains effective and consistent throughout its execution. This
modification aims to prevent reading intermediate values that might
lead to incorrect calculations, without introducing new locking
complexities.

I'm looking forward to any further insights or suggestions you might
have on this matter.

Best regards,
Han


20 39 <2045gemini@gmail.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=BA=94 10:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kuai,
>
> Thanks for your email and the insightful points you've raised. Let me cla=
rify a few aspects regarding the raid5_cache_count() and raid5_set_cache_si=
ze() functions.
>
> 1. Callback Function in setup_conf(): You mentioned that raid5_cache_coun=
t() is called from setup_conf() where reconfig_mutex is held. While this is=
 true, it's important to note that raid5_cache_count() is actually initiali=
zed as a callback function in setup_conf(), as described in /include/linux/=
shrinker.h. This means it could be invoked later in a context where the rec=
onfig_mutex isn't necessarily held. The documentation in shrinker.h indicat=
es potential invocation scenarios beyond the initial setup context.
>
> 2. Comment on Unlikely Scenario: Regarding the comment in the code /* unl=
ikely, but not impossible */, it seems to acknowledge the possibility of a =
race condition where conf->max_nr_stripes is less than conf->min_nr_stripes=
. This comment implies that previous developers might have noticed potentia=
l issues with race conditions, even if they are considered unlikely.
>
> 3. Use of Local Variables Instead of Locks: In addressing this issue, my =
approach doesn't involve introducing additional locks, which could potentia=
lly lead to deadlocks or other concurrency problems. Instead, I've opted to=
 store the values in local variables to ensure that the check remains effec=
tive and consistent throughout its execution. This modification aims to pre=
vent reading intermediate values that might lead to incorrect calculations,=
 without introducing new locking complexities.
>
> I'm looking forward to any further insights or suggestions you might have=
 on this matter.
>
> Best regards,
> Han
>
> Yu Kuai <yukuai1@huaweicloud.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=BA=94 09:37=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hi,
>>
>> =E5=9C=A8 2023/12/21 18:43, Gui-Dong Han =E5=86=99=E9=81=93:
>> > In raid5_cache_count():
>> >       if (conf->max_nr_stripes < conf->min_nr_stripes)
>> >               return 0;
>> >       return conf->max_nr_stripes - conf->min_nr_stripes;
>> > The current check is ineffective, as the values could change immediate=
ly
>> > after being checked.
>> >
>> > In raid5_set_cache_size():
>> >       ...
>> >       conf->min_nr_stripes =3D size;
>> >       ...
>> >       while (size > conf->max_nr_stripes)
>> >               conf->min_nr_stripes =3D conf->max_nr_stripes;
>> >       ...
>> >
>>
>> raid5_cache_count() is called from setup_conf() where reconfig_mtuex is
>> held.
>>
>> raid5_set_cache_size() is called from:
>> 1) raid5_store_stripe_cache_size(), reconfig_mutex is held
>> 2) r5l_start() from raid5_add_disk(), reconfig_mutex is held
>> 3) raid_ctr(), reconfig_mutex is held
>>
>> So, how can they concurrent in the first place?
>>
>> Thanks,
>> Kuai
>>
>> > Due to intermediate value updates in raid5_set_cache_size(), concurren=
t
>> > execution of raid5_cache_count() and raid5_set_cache_size() may lead t=
o
>> > inconsistent reads of conf->max_nr_stripes and conf->min_nr_stripes.
>> > The current checks are ineffective as values could change immediately
>> > after being checked, raising the risk of conf->min_nr_stripes exceedin=
g
>> > conf->max_nr_stripes and potentially causing an integer overflow.
>> >
>> > This possible bug is found by an experimental static analysis tool
>> > developed by our team. This tool analyzes the locking APIs to extract
>> > function pairs that can be concurrently executed, and then analyzes th=
e
>> > instructions in the paired functions to identify possible concurrency =
bugs
>> > including data races and atomicity violations. The above possible bug =
is
>> > reported when our tool analyzes the source code of Linux 6.2.
>> >
>> > To resolve this issue, it is suggested to introduce local variables
>> > 'min_stripes' and 'max_stripes' in raid5_cache_count() to ensure the
>> > values remain stable throughout the check. Adding locks in
>> > raid5_cache_count() fails to resolve atomicity violations, as
>> > raid5_set_cache_size() may hold intermediate values of
>> > conf->min_nr_stripes while unlocked. With this patch applied, our tool=
 no
>> > longer reports the bug, with the kernel configuration allyesconfig for
>> > x86_64. Due to the lack of associated hardware, we cannot test the pat=
ch
>> > in runtime testing, and just verify it according to the code logic.
>> >
>> > Fixes: edbe83ab4c27e ("md/raid5: allow the stripe_cache to grow and ..=
.")
>> > Reported-by: BassCheck <bass@buaa.edu.cn>
>> > Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
>> > ---
>> >   drivers/md/raid5.c | 7 ++++---
>> >   1 file changed, 4 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> > index 8497880135ee..62ebf33402cc 100644
>> > --- a/drivers/md/raid5.c
>> > +++ b/drivers/md/raid5.c
>> > @@ -7390,11 +7390,12 @@ static unsigned long raid5_cache_count(struct =
shrinker *shrink,
>> >                                      struct shrink_control *sc)
>> >   {
>> >       struct r5conf *conf =3D shrink->private_data;
>> > -
>> > -     if (conf->max_nr_stripes < conf->min_nr_stripes)
>> > +     int max_stripes =3D conf->max_nr_stripes;
>> > +     int min_stripes =3D conf->min_nr_stripes;
>> > +     if (max_stripes < min_stripes)
>> >               /* unlikely, but not impossible */
>> >               return 0;
>> > -     return conf->max_nr_stripes - conf->min_nr_stripes;
>> > +     return max_stripes - min_stripes;
>> >   }
>> >
>> >   static struct r5conf *setup_conf(struct mddev *mddev)
>> >
>>

