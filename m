Return-Path: <linux-kernel+bounces-26296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFAB82DE35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723491F22AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A7018044;
	Mon, 15 Jan 2024 17:09:20 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1853F18041;
	Mon, 15 Jan 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2057f388b2dso1805451fac.1;
        Mon, 15 Jan 2024 09:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705338558; x=1705943358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AuNqPEQ6+Di1qW9NRwRXKxlP0o+roEfzht1wXg9bXQ=;
        b=P9Ygee4ZoLHkGWZnLlBDjbXsEA7h6ZmC0RW7X7ffUEqucQB7YywJJgQcgFzTD29E2A
         OuY+88Dp2ljo+ixaJOPyFOpzM3mmXAAmjGUhO8oqYXW4BPOIp8oQSw7GKyqWiI+fp6OO
         i4TaTdlertJ2zU0SM45/4Qnbx09/tF0v16tPr31OQ0tDR5reI7WPJ3hysp9E+11klHPt
         cMbiPVaeDJh1Wc2bwg2Z0hXEmTaQ3pEwY2yZSmPYJzTLV+ju8ZWuAeVO3vPpM2fZzb9w
         jWgQDGHnpf52JC/Cx7y5RR1q3DUtTqEAM3Owv6sYGrvA20fvqMVdB9IFXHFD0FmUfUfs
         41zw==
X-Gm-Message-State: AOJu0Yw81AO/myI9we7p6cDRllDWULIjpFivKAAMSOOIX2zUo+ar3FBA
	oNnb1KYgTggydZ4mTrixfoBx+jDfoi7Uc9twGNM=
X-Google-Smtp-Source: AGHT+IFhfjxeCDFPecLvc0lUbEbFPHiZjVTXDe1D6aEUWaUeN7qvqVtnYqEpODTUXTjZDpIEPPGlaRk/fdN5b9nDChI=
X-Received: by 2002:a05:6820:510:b0:598:c118:30d1 with SMTP id
 m16-20020a056820051000b00598c11830d1mr11628098ooj.0.1705338558095; Mon, 15
 Jan 2024 09:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115082507.29651-1-duminjie@vivo.com> <CAJZ5v0jPeYgGc9xmSrnLsg6RkhzmU=TfPdhrzxWBd_d_dmJh+Q@mail.gmail.com>
 <ecb33c61-bb40-43a0-94a1-8973d70dc0b4@linaro.org>
In-Reply-To: <ecb33c61-bb40-43a0-94a1-8973d70dc0b4@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jan 2024 18:09:06 +0100
Message-ID: <CAJZ5v0hhvwz++RUtw-e4EM10Rs0ipOUQBXi4GUH0oL01iUJKrQ@mail.gmail.com>
Subject: Re: [PATCH v1] thermal/debugfs: Remove unnecessary
 debugfs_create_dir() error check in thermal_debug_init()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Minjie Du <duminjie@vivo.com>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 5:55=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 15/01/2024 16:52, Rafael J. Wysocki wrote:
> > On Mon, Jan 15, 2024 at 9:25=E2=80=AFAM Minjie Du <duminjie@vivo.com> w=
rote:
> >>
> >> This patch removes the debugfs_create_dir() error checking in
> >> thermal_debug_init(). Because the debugfs_create_dir() is developed
> >> in a way that the caller can safely handle the errors that
> >> occur during the creation of DebugFS nodes.
> >
> > I honestly don't see what the purpose of this patch is.
>
> I think it is because the recent debugfs changes were about to reduce as
> much as possible the code related to the error handling as the debugfs
> is not supposed to go in production system.
>
> So for instance debugfs_create_dir() will not fail if the parent is NULL
> and will create the entry in the debugfs topdir.

Which would be confusing IMO.

> At the end we are ending up with:
>
> d_root =3D debugfs_create_dir("thermal", NULL);
> d_cdev =3D debugfs_create_dir("cooling_devices", d_root);
> d_tz =3D debugfs_create_dir("thermal_zones", d_root);
>
> The current code will avoid creating lost entries in /sys/kernel/debug

Right, and IMO it is the right thing to do, and I would even go a bit
further and roll back the thermal debugfs initialization if any of the
above is NULL.

Note that currently d_tz can be NULL and it will work in the sort of
degraded mode with the other two, but it is not a big deal IMV.  It
would just be more consistent to clean up everything then, but that
can be done later.

