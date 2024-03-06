Return-Path: <linux-kernel+bounces-94177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBCA873AF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990C528119C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DF513540D;
	Wed,  6 Mar 2024 15:41:30 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC81350DE;
	Wed,  6 Mar 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739689; cv=none; b=V2FFgpFb3EamQR94p0aIZsEyx+LWSRJJy7WZ/BjmvEuAHidpzKKu5izv182RB7wxx5suQNLP1oIOhZ930irKHHqiagN1V1P4fQf9umzXaht7dNUlcQiatGLlS67g1lp3XUIdJRHyu6Cxv7SsBOCu+c82yAB4ONjtbWwCo2TgWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739689; c=relaxed/simple;
	bh=Y7msQX6hlYEAcec3lwddke08WECZzCMsCX5OZt0uRMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5ATDBCZgELWOCtPwf/5eDbvDc71bhKSolAQTQQ+Ta1fzR/yrR6TXfJZc+3/KeRO2+AJNPIU1X12jtJAk6IYWIJ8EiaZvcMIwLKjQwpDFeWR4ZAuqj2u02cCT/7t1YTnxKPJBEB9mCpDfjje1W3Z4Vs1vN7TgxT2XHonK18ADQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-220ce420472so1342646fac.1;
        Wed, 06 Mar 2024 07:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739687; x=1710344487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F78bIbT0P37zvvyz4bkiHFYqGTllW22ypORx2SaQJ08=;
        b=UyRnSiGnjgTU8k5S0PMbO1X7XCXFTNe3BHnJzOEi2JQbraIQ/TDuW+7a3udysvy7Xl
         FM+RbTe5IoDHNH8QnGXMCxdS80+ZpogBc1XlGvk6wQ4dEgu27IR0ddPmJ2N8ouguVRXC
         BtcXLCozoe5fbMv8WOeonoyt7HKNo70EfB1atXiv9ynrCApr0FnsC/Ta3DU7bilssPCe
         9Qo7pEqeXIKlFEMhAWvg5Wp9h99G+MielNXgDxDN4wSbRReYBMc34Jj3p9sLXiTLj0je
         MYGVj3KNyRJd/5Tb5+q9CQvDciEx5lJr3BTw9Gk87qAGiephErr9+JizPK8FA8JwB++z
         wEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe/6aNLvgiSnot/CRQESyraExU4VPt3FtbRSR/mCHEDCpLvkLaIN1BUcxPeNtgxzLwTeVZl+ZAlc/soksmDLQoa7Mkt3DnIK68hdzEjabEV9zt/h0zd37bQnnI5zdUUdqKBl9eK28=
X-Gm-Message-State: AOJu0Ywkei9dNQJqc9Yop7YmzKMwKeZzai37K1fHKcDSfeE80yCsMC2q
	yt/9kKmbxPlyNDgIRT+aLlogzyL0b8DG8ciJQ8IfR9m+97xjBpuPOVd4HeQ97xAbJ1/txZg2MSR
	qjaZ0zNiosI7/6a+GdHfOcqaoElE=
X-Google-Smtp-Source: AGHT+IFmX+FQzpiDkvtWMX+QyHRjkNUKTg7pvgNraTk/YCQSp6p6U0VDsiDoRLbacWLsDzNW6Z0MGbrQGOSywv4RJ6U=
X-Received: by 2002:a05:6871:60a:b0:221:16e3:8f22 with SMTP id
 w10-20020a056871060a00b0022116e38f22mr3798613oan.5.1709739687157; Wed, 06 Mar
 2024 07:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085428.88011-1-daniel.lezcano@linaro.org>
 <CAJZ5v0jAn2F-GH=fguX0+3bG38vyAxfufadtFiBUfg=EjTBh6Q@mail.gmail.com>
 <14651d5b-0f67-4bff-b699-2cd1601b4fb2@linaro.org> <CAJZ5v0j6At1DuQYjjbA-fw9Z-jJPhXSVSz=_uLa3KfNMJowYbA@mail.gmail.com>
 <0e7f32aa-b2c3-43d0-8ebe-7118cb6e0edf@linaro.org>
In-Reply-To: <0e7f32aa-b2c3-43d0-8ebe-7118cb6e0edf@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Mar 2024 16:41:15 +0100
Message-ID: <CAJZ5v0gWhNqTGpoOH01scCdC51cEnt_8_T5ccqZC6yXPDv9QcA@mail.gmail.com>
Subject: Re: [RFC PATCH] thermal/core: Fix trip point crossing events ordering
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 2:16=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 06/03/2024 13:53, Rafael J. Wysocki wrote:
> > On Wed, Mar 6, 2024 at 1:43=E2=80=AFPM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> >>
> >> On 06/03/2024 13:02, Rafael J. Wysocki wrote:
> >>
> >> [ ... ]
> >>
> >>>> +#define for_each_trip_reverse(__tz, __trip)    \
> >>>> +       for (__trip =3D &__tz->trips[__tz->num_trips - 1]; __trip >=
=3D __tz->trips ; __trip--)
> >>>> +
> >>>>    void __thermal_zone_set_trips(struct thermal_zone_device *tz);
> >>>>    int thermal_zone_trip_id(const struct thermal_zone_device *tz,
> >>>>                            const struct thermal_trip *trip);
> >>>> --
> >>>
> >>> Generally speaking, this is a matter of getting alignment on the
> >>> expectations between the kernel and user space.
> >>>
> >>> It looks like user space expects to get the notifications in the orde=
r
> >>> of either growing or falling temperatures, depending on the direction
> >>> of the temperature change.  Ordering the trips in the kernel is not
> >>> practical, but the notifications can be ordered in principle.  Is thi=
s
> >>> what you'd like to do?
> >>
> >> Yes
> >>
> >>> Or can user space be bothered with recognizing that it may get the
> >>> notifications for different trips out of order?
> >>
> >> IMO it is a bad information if the trip points events are coming
> >> unordered. The temperature signal is a time related measurements, the
> >> userspace should receive thermal information from this signal in the
> >> right order. It sounds strange to track the temperature signal in the
> >> kernel, then scramble the information, pass it to the userspace and
> >> except it to apply some kind of logic to unscramble it.
> >
> > So the notifications can be ordered before sending them out, as long
> > as they are produced by a single __thermal_zone_device_update() call.
> >
> > I guess you also would like the thermal_debug_tz_trip_up/down() calls
> > to be ordered, wouldn't you?
>
> Right

I have an idea how to do this, but it is based on a couple of patches
that I've been working on in the meantime.

Let me post these patches first and then I'll send a prototype patch
addressing this on top of them.

