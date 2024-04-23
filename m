Return-Path: <linux-kernel+bounces-155160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD25A8AE605
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDB0286208
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16EA86253;
	Tue, 23 Apr 2024 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixyfno0M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1478814;
	Tue, 23 Apr 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875196; cv=none; b=O/g7xFciTK/Im6UTf4eV+1BYcYGdjVkCwNT9l1XGgu4rznpPFQlTD+WEc8nCzCWHtoXLPW7rQhgq8tZNn8Qt4KH7sLuQXBaDsf3f2nHDnvb7YzRGpJogDTYpix+N8WliXIRDmwJvvzOmZv2ATLKO93A5nEglrQQa8mX170HZxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875196; c=relaxed/simple;
	bh=GhFqWYnEMMVlmMXQ3Fz18iujy63dteb43440Fc9T//g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noOOflfRSUnvz1UnTlL04Fse38aEvMBcf0LgLfUKkRvAd2OVq+nfiXhlep9+9Mm8GvDUn3D2Pa06Tiym8YA9E42FtPlk6WHAu7Uu24CL6u62oUk+pIxWhUNhCXZwl0H0+xbMc5TWOWpqV2+necaXMM+2sw8J2Jcj8h+QBH1Bf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ixyfno0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7016FC3277B;
	Tue, 23 Apr 2024 12:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713875195;
	bh=GhFqWYnEMMVlmMXQ3Fz18iujy63dteb43440Fc9T//g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ixyfno0Mumqxt2FxXvWIDrsNtDKx93yJVNdJNhB8n5MM2+SDtNwxEMRX5RyDRDFHN
	 2Qu5PqID+p7dm2F590GnHTWuiAW70aNRmIT/Z9l8FSdI5YYxOBw5i8bY+BvdJIIH+S
	 umR6clL5Tlu6w0K0wY1gOVDeftg/XZ6aPlMJlEoBgVvKmMyzC/T7U9CRJgUx4wxksv
	 32frTGY3+AHtwkb1uhZsu+HoIq/EcYiA83eIjH4VSrAR344Exe67tXPW8+OcQGxTtv
	 amQbNci+0Z28QM7vjj8jv1DQeDdBXNKrTKj3YXNjWM2+Myrvbm4omg2gvLWqKV80DU
	 qon1HGcHrcNAg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5acf5723325so1309113eaf.0;
        Tue, 23 Apr 2024 05:26:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrpwo0arYK5Tf59akftLixY3Zs3cSjc/T7a08tM+Vw41Syx/jz1xwzjCiy6hnA/MbYQQRsGP8tYgJyXDw8jQEOpl5nsC281t2Pu/9ITZU4A9nwiOeGpob0iyU75eyXJolF+sfaRf8=
X-Gm-Message-State: AOJu0Ywey0VjyYESG0c8nk3WXlremKGpsrfU7UFgxgUABHv6kcAlJsub
	zRDgXbem2S5Y5M9mprQbjXxWiIb2dZEYn1OjoayTyBoBoWg+EGfJyj1Fpfgm2NqX4SnOYai2FmK
	x1CpZySy7XWAh0atQ83EKQSV6RkA=
X-Google-Smtp-Source: AGHT+IFVvA0HYfJ9IJSegQOjv5BhZ39vVydOBEH1PRw89xFYxRibhABRSF6oPzxBSeSuT69zRTXeirYp/IuSCMPsnjw=
X-Received: by 2002:a05:6820:ecb:b0:5ac:6fc1:c2cb with SMTP id
 en11-20020a0568200ecb00b005ac6fc1c2cbmr13195937oob.0.1713875194616; Tue, 23
 Apr 2024 05:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4918025.31r3eYUQgx@kreacher> <3a8f1978-c5df-40d6-91ca-276431bb01e1@arm.com>
 <e8193798-4c02-423a-a9d8-63d29ebd7faa@linaro.org> <CAJZ5v0i2pvTLwj7jTzwhoQMap_cvjvNnK2Beuje2COo+F4hBzA@mail.gmail.com>
 <2acea3c3-5c8f-4f3c-a275-743c3fbfd2e6@linaro.org>
In-Reply-To: <2acea3c3-5c8f-4f3c-a275-743c3fbfd2e6@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Apr 2024 14:26:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5Ja9-vuC9ve9Li=UxATcBtTmdMdhMS1g993XBe1DVqw@mail.gmail.com>
Message-ID: <CAJZ5v0j5Ja9-vuC9ve9Li=UxATcBtTmdMdhMS1g993XBe1DVqw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] thermal/debugfs: Fix and clean up trip point
 statistics updates
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 6:12=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/04/2024 17:48, Rafael J. Wysocki wrote:
> > On Mon, Apr 22, 2024 at 5:34=E2=80=AFPM Daniel Lezcano
>
> [ ... ]
>
> >> or we should expect at least the residency to be showed even if the
> >> mitigation state is not closed ?
> >
> > Well, in fact the device has already been in that state for some time
> > and the mitigation can continue for a while.
>
> Yes, but when to update the residency time ?
>
> When we cross a trip point point ?
>
> or
>
> When we read the information ?
>
> The former is what we are currently doing AFAIR

Not really.

Records are added by thermal_debug_cdev_state_update() which only runs
when __thermal_cdev_update() is called, ie. from governors.

Moreover, it assumes the initial state to be 0 and checks if the new
state is equal to the current one before doing anything else, so it
will not make a record for the 0 state until the first transition.

> and the latter must add the delta between the last update and the current=
 time for the current
> state, right ?

Yes, and it is doing this already AFAICS.

The problem is that it only creates a record for the old state, so if
the new one is seen for the first time, there will be no record for it
until it changes to some other state.

The appended patch (modulo GMail-induced white space breakage) should
help with this, but the initial state handling needs to be addressed
separately.

---
 drivers/thermal/thermal_debugfs.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -433,6 +433,14 @@ void thermal_debug_cdev_state_update(con
     }

     cdev_dbg->current_state =3D new_state;
+
+    /*
+     * Create a record for the new state if it is not there, so its
+     * duration will be printed by cdev_dt_seq_show() as expected if it
+     * runs before the next state transition.
+     */
+    thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations,
new_state);
+
     transition =3D (old_state << 16) | new_state;

     /*

