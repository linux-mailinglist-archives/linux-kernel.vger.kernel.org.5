Return-Path: <linux-kernel+bounces-12234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFD181F1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686F1283CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32547F54;
	Wed, 27 Dec 2023 19:53:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F047A51;
	Wed, 27 Dec 2023 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6dc003289c9so128173a34.0;
        Wed, 27 Dec 2023 11:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703706817; x=1704311617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzGvqkA+7vSK4S2dZ8/CmTeqqUn7cIuH50aZn1M+9vQ=;
        b=aA5QtZOpz8PS2QEnyTd+HBvKv7QToIxNN92ylzF/V2eU4y2Ly46TuXI4/bLP3oyskX
         stoMzM0ZYyoyZEGHxafk61Pz7gn7W9kgDgEJ3OxkbA1ah0VUfuI/hYXXPjK7pUFiKHAu
         cx99ZKNKBY1gg4nOpfMx9WxNaeRpVb8qMXE/Wtt6op9GjlL5b76mIl1JuLPxkK3VcqQu
         wzxEEXUAjrYF3KfobWpYVUEVeDvK0vGlnsvecFjR2SF6VMla9WZTYlVGUHgf8783LbKE
         nO2LJ3x22L9nlHHHCQ3v4dkypEl4de+SiugL8kCiIkupNO32ih/KXuFgonxL5FVL3ohq
         cA+A==
X-Gm-Message-State: AOJu0Yx8k1RKyuEvhxAUR0k/flG4JBzaNLQCI4YlvfugoZCihlANIPte
	fUsdm7ClQglIp4KBot9RMogqXWr6OoR3WnEsChU=
X-Google-Smtp-Source: AGHT+IG/Ky3kwmKNdjmAEoxafNE3axXWpyvvl8+rX7EE+bMJtEIGTrxSpSorul7oLAG7YnBfwX14zB5hV3aO1laoJ0g=
X-Received: by 2002:a4a:dc96:0:b0:594:ad62:bab9 with SMTP id
 g22-20020a4adc96000000b00594ad62bab9mr5536266oou.1.1703706817350; Wed, 27 Dec
 2023 11:53:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219092539.3655172-1-daniel.lezcano@linaro.org>
 <20231219092539.3655172-2-daniel.lezcano@linaro.org> <CAJZ5v0gPHwJ+02hYbp5dRx1r69BdLWr_QDKautu-RXy1MEC5LQ@mail.gmail.com>
 <60ecab8e-7b96-469e-9bae-25c51514e6e8@linaro.org>
In-Reply-To: <60ecab8e-7b96-469e-9bae-25c51514e6e8@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Dec 2023 20:53:25 +0100
Message-ID: <CAJZ5v0hKH7tYDur4mG8QF0GfgL+jFfW_bBc3QesUS68OQb_PMA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal/debugfs: Add thermal debugfs information
 for mitigation episodes
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net, lukasz.luba@arm.com, 
	rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Sat, Dec 23, 2023 at 12:41=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 21/12/2023 20:26, Rafael J. Wysocki wrote:
>
> [ ... ]
>
>
> >> +/**
> >> + * struct tz_events - Store all events related to a mitigation episod=
e
> >> + *
> >> + * The tz_events structure describes a mitigation episode.
> >
> > So why not call it tz_mitigation?
>
> A mitigation episode =3D N x tz_events
>
> eg.
> trip A =3D passive cooling - cpufreq cluster0
> trip B =3D passive cooling - cpufreq cluster0 + cluster1
> trip C =3D active cooling + fan
>
> temperature trip A < trip B < trip C
>
> The mitigation episode, as defined, begins at trip A, and we can have
> multiple events (eg. trip B crossed several times, trip C, then trip B
> again etc ...).

I understand this, but I thought that tz_events represented the entire epis=
ode.

> [ ... ]
>
> >> +       if (dfs->tz.trip_index < 0) {
> >> +               tze =3D thermal_debugfs_tz_event_alloc(tz, now);
> >> +               if (!tze)
> >> +                       return;
> >> +
> >> +               list_add(&tze->node, &dfs->tz.tz_events);
> >> +       }
> >> +
> >> +       dfs->tz.trip_index++;
> >> +       dfs->tz.trips_crossed[dfs->tz.trip_index] =3D trip_id;
> >
> > So trip_index is an index into trips_crossed[] and the value is the ID
> > of the trip passed by thermal_debug_tz_trip_up() IIUC, so the trip IDs
> > in trips_crossed[] are always sorted by the trip temperature, in the
> > ascending order.
> >
> > It would be good to write this down somewhere in a comment.
> >
> > And what if trip temperatures change during a mitigation episode such
> > that the order by the trip temperature changes?
>
> Changing a trip point temperature during a mitigation is a general
> question about the thermal framework.
>
> How the governors will behave with such a change on the fly while they
> are in action?
>
> IMO, we should prevent to change a trip point temperature when this one
> is crossed and has a cooling device bound to it.

Well, it's not that simple.

There are legitimate cases in which this can happen on purpose.  For
example, the ACPI spec does not provide a way to get a trip hysteresis
from the platform firmware and instead it recommends the firmware to
update the trip temperature every time it is crossed on the way up in
order to implement hysteresis.

> >> +
> >> +       tze =3D list_first_entry(&dfs->tz.tz_events, struct tz_events,=
 node);
> >> +       tze->trip_stats[trip_id].timestamp =3D now;
> >> +       tze->trip_stats[trip_id].max =3D max(tze->trip_stats[trip_id].=
max, temperature);
> >> +       tze->trip_stats[trip_id].min =3D min(tze->trip_stats[trip_id].=
min, temperature);
> >> +       tze->trip_stats[trip_id].avg =3D tze->trip_stats[trip_id].avg =
+
> >> +               (temperature - tze->trip_stats[trip_id].avg) /
> >> +               tze->trip_stats[trip_id].count;
> >> +
> >> +       mutex_unlock(&dfs->lock);
> >> +}
>
>
>
> --

