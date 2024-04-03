Return-Path: <linux-kernel+bounces-129781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D37A896FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3DC28F6C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CB71487D7;
	Wed,  3 Apr 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtrIgt7W"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166BA147C8C;
	Wed,  3 Apr 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149549; cv=none; b=LZ0eO4OmQRsMpTgDdUVRWs1hNiMS1m1ytIh5lefEuhMacPdTZULQa/SVaUieYMaxVBc2n130vumpGU+88/fHnfhCmxHWHTzgUFasmTVgfLnXJMsQwDufElfE5GqLRoQYgflrapm50Jz4lOt7Pxu9E6TGJyJRsTyuSRzEwajp0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149549; c=relaxed/simple;
	bh=QJEeCIkAPiFZbRuleWyDEENFSiH12JZFpZfsYZc250s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDbWoO79lflLZ7cMAykwdYYWuNC3ttfPRJlg64WCPNkE3w6bPrW9/CjBh//HgAKNj2eps1njRUEGHt3hBZofZqZrgYYb8fTRrJkhxVRUIyjhg2eABi7O9+xHX6iRklHT9nbzyyAXXevHPp2lq9wHGFDYUqtY4bbj75/YyeDkYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtrIgt7W; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso2960279b3a.2;
        Wed, 03 Apr 2024 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712149547; x=1712754347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qpDKTFHgYEBe0w0N3iXwvyoiKCATOl8h9lKP1Scxuc=;
        b=DtrIgt7WtyDPCLFT7y5WFeQgtqeMe68CqmFcrAXvpaE2JF0QUhcp8b7Hc9hcO8RMit
         GxUS85mrXr4VVQazbQf6j2D4Gqs78Or+a9b4oh09Xa7qvt4XOii273hk0cK+889S0CsE
         zbdtSCfJzzxYWUJwafnqwSeEFW3eMktYA5qDKCJgcIGjWuKq2gZ5+Csp5WmlMrLcXheN
         1LXOhH9BpJcps9jnRiUqh42Hw1BJDDMlgBxB5dquMUhjgoPfycgT48BAGeIpVcWj3Iwk
         VxnmVLl+C8eqsDeUgwSSfRSvtsvxXx0W3qtN9NzJbCtu3fGwpIBFpFxxJhgEwX7jNCWZ
         uUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149547; x=1712754347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qpDKTFHgYEBe0w0N3iXwvyoiKCATOl8h9lKP1Scxuc=;
        b=rP+dn1EyYdq6uNqUXAVtUk0uSGtGmRuPdZ0IXBxr3zUCMqGQEiAazA9U+22F3CA9BO
         mU2LMJd+RoPK78qQ7zzjhF9EqgwxRhcqE4ZMjn/ISgz8zxL8mPpGEyLawayhmG8h7H0y
         J+B1PSkd4PIZ9beJ0Yyx69m7QtGjtrV8n7eV1B6T4trVSfl1gMd9u6zMsu4pEKmyrDiP
         vSmuEzTbYlQOP7JczyiAo+AKzMYkLp74fx/fbt+jHgEoofyqeskgpiXb6i2AuJcu6Fo0
         HpzJCpUltyS14D4n9Mh567eSe0Ru/Aspa+NkIpVKci/ZKOOIbr43hPOxIYh7jmqpIFqp
         81XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf7xWxqw7Mgxe5bLu9JgOqTcWYbIGdwBcbSw4X2uKolSDa4SIIAbSJnE1mr/i4Yoaf/JUwnLbEQ6EuhqbkDt2SuP5NxgxFPv73N0lF+ikUNLoWq8qmcoOCMsEzWnakckcw6uhen8A=
X-Gm-Message-State: AOJu0YztHpv0hQEZw4trqN6ynI96tjA6QzUBUB/hcCU9NozqgIr/OZeg
	y5K5weMuGJBRAoboxSzVb3tR2pdLKKeD8CU7Nq/7YcqkaxsRUB5zfwjt8efU3ljaTJP+g819+5T
	Oetf9RpOZ8VhKjeoWMaW91J3+PcQ=
X-Google-Smtp-Source: AGHT+IHj03gMS2kJE81A6fLRXaMe/gexzYIBYP4LehLc5GMbebVJzPVL7069PYpRl07nTID94Ij/N08ROieeVx+dvOs=
X-Received: by 2002:a17:90a:d4f:b0:29d:dd50:afe with SMTP id
 15-20020a17090a0d4f00b0029ddd500afemr12411970pju.30.1712149547342; Wed, 03
 Apr 2024 06:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
 <20240403-gpa-no-cooling-devs-v2-3-79bdd8439449@trvn.ru> <187a3acb-d4a8-41e6-822c-f901a693aae1@arm.com>
In-Reply-To: <187a3acb-d4a8-41e6-822c-f901a693aae1@arm.com>
From: Nikita Travkin <nikitos.tr@gmail.com>
Date: Wed, 3 Apr 2024 18:05:36 +0500
Message-ID: <CAN_S-bUOozoU=eP_FEwphL2HWtt7WQQC4n_98dL0nt=jsqogjQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] thermal: gov_power_allocator: Suppress
 sustainable_power warning without trip_points
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 3 =D0=B0=D0=BF=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 17:52, Luka=
sz Luba <lukasz.luba@arm.com>:
>
>
>
> On 4/3/24 12:31, Nikita Travkin via B4 Relay wrote:
> > From: Nikita Travkin <nikita@trvn.ru>
> >
> > IPA warns if the thermal zone it was attached to doesn't define
> > sustainable_power value. In some cases though IPA may be bound to an
> > "empty" TZ, in which case the lack of sustainable_power doesn't matter.
> >
> > Suppress the warning in case when IPA is bound to an empty TZ to make i=
t
> > easier to see the warnings that actually matter.
> >
> > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> > ---
> >
> > I've decided to add this along to supress those warnings for some TZ on
> > sc7180. Feel free to drop this patch if you think the warning should
> > always appear.
>
> That warning should stay, since in the development or integration phase
> quite a lot of stuff is missing. This will warn that there is an issue.
> The case with 'empty' TZ is an exception only to 'work' with IPA.
>

Yes, that's understandable, though by suppressing those I could
actually see the few actual warnings for TZ with cooling devices
and no value, which I couldn't see before because it looked like
"all of them" have the warning.

In any case, as I said, I'm fine with this not being applied :)

Thanks for your review!
Nikita

> Thanks for the patches!
>
> Regards,
> Lukasz
>
>
> > ---
> >   drivers/thermal/gov_power_allocator.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/go=
v_power_allocator.c
> > index e25e48d76aa7..05a40f6b5928 100644
> > --- a/drivers/thermal/gov_power_allocator.c
> > +++ b/drivers/thermal/gov_power_allocator.c
> > @@ -704,7 +704,7 @@ static int power_allocator_bind(struct thermal_zone=
_device *tz)
> >               params->allocated_tzp =3D true;
> >       }
> >
> > -     if (!tz->tzp->sustainable_power)
> > +     if (!tz->tzp->sustainable_power && params->trip_max)
> >               dev_warn(&tz->device, "power_allocator: sustainable_power=
 will be estimated\n");
> >       else
> >               params->sustainable_power =3D tz->tzp->sustainable_power;
> >

