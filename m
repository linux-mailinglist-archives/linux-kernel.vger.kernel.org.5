Return-Path: <linux-kernel+bounces-55569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3935384BE3C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD92B22A74
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84350175BC;
	Tue,  6 Feb 2024 19:43:50 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3371B270;
	Tue,  6 Feb 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707248630; cv=none; b=mdxd0dvrp6zFo57cFPIYTOISFrTfkRsX05Rq0jJXTkc9UTkH1Gd69NFpB+0BzF4rFGSyqB0Ep2f5ICn4rEVxGqGpxh8hJ7oL4nr4P4eEdGjp74mZSyOHgsyLbLEVf5NqUmt/LhKkQlQWr2ss72YQ1v0//l7DH/gx0R7uX30i5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707248630; c=relaxed/simple;
	bh=6Lirs0Mnt0IWEIAldTBBLf0MeJqsDrL6eFamlNgJG4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdt485AIQ2vy8z2Me2Jdnlv4SMXLTcIozU54g3XutmdDoR32xKQhPY6xWcwvLVrh74b9dDH3B9c2CZ1J0E7OEqB76Z8wrrwe+2UxXm6Gm2tcPE2290F4aXIzbytst5qu46A9SHG6QR1iKuDFy9Wkxr5F3GdM68EJtX+ie4nrR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59584f41f1eso1982213eaf.1;
        Tue, 06 Feb 2024 11:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707248627; x=1707853427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lb5wcqeRy+vlaNArKIwVtaEfEgOoKp4cUFbNlHx3fM8=;
        b=gU1KlcifgxBV+kZ+4bVG83NOw4ew5JxhvUKY/8BDbdXDQq3GJskBJvTK6G1o7YIs9l
         Y50as5NpKh+aoPpaH7LOmGisAMuIda91z70sxxY2lyXzKkjT1KWxkuU74k+rM8R8JZkR
         dgi8KYovpmfiB/D1kiA4/5x6dRL34HonXw3+WDqR2Xatg6p12bmU0z4IckAxZkMG2TTH
         H9h90LaWvacaC5ADwARrM+OWyS9J3sscoZX+Utx7drN7SpHS2k0r5ifz2V4sUV2s1UAr
         KXIHEN0bH89yKhihGb5dt0Ec15Dlrm/+vlhfvN7Ru0F318qgFKSmIbWaK9mpmNDc2uYz
         ftlg==
X-Forwarded-Encrypted: i=1; AJvYcCW4YDb8Ba8QEKuIn320yuPVcLzwKrhnKAhBKNiedg72k+3VYuOnYh9xm20UmO3L4HV+0QYuO2yL1pm38GdXHazjoT7LhauZDOhNP2d7VKRqFMcVHJRtwDMT0cN70HlSayXvYuT1z5bfUg==
X-Gm-Message-State: AOJu0YxwnpZXVLXl98p5lu7fIrDlBSP044vuIxv8geCAG5y/FjKLXsFZ
	ge4KH9kbqxsZ0UUnMJq2BvPKv2owkqtjCHNhu+76/OyUh6KzqVXSCNzuX2kPscv3Ua8clPFHvqV
	Z0MMfjNLFeaz8OLo0ig7CcvnFpqQ=
X-Google-Smtp-Source: AGHT+IFYpomoi6DqiLfOdnXUy18la5AUhPIE1vXch0R4vJYU9EvwTF3nTdcympXAvGk/V9053cees/3tktHeg9wZtyk=
X-Received: by 2002:a05:6820:82b:b0:59c:eb7b:c04e with SMTP id
 bg43-20020a056820082b00b0059ceb7bc04emr2573848oob.1.1707248627613; Tue, 06
 Feb 2024 11:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201221119.42564-1-mario.limonciello@amd.com>
 <20240201221119.42564-2-mario.limonciello@amd.com> <CAJZ5v0iw3PLB4W0QNmRCgK2AWxe5A7wxnWSz-Jm--Mb=fnugEw@mail.gmail.com>
 <c96de797-39c4-4c83-96e2-d4579504e88e@amd.com>
In-Reply-To: <c96de797-39c4-4c83-96e2-d4579504e88e@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 Feb 2024 20:43:36 +0100
Message-ID: <CAJZ5v0iZTJtMwZLGFovoLbFTP=OG=L6ZLgBbLU2ob5_X6OLB0A@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ACPI: video: Handle fetching EDID that is longer
 than 256 bytes
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, amd-gfx@lists.freedesktop.org, 
	Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
	Hans de Goede <hdegoede@redhat.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:09=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 2/2/2024 10:07, Rafael J. Wysocki wrote:
> > On Thu, Feb 1, 2024 at 11:11=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> The ACPI specification allows for an EDID to be up to 512 bytes but
> >> the _DDC EDID fetching code will only try up to 256 bytes.
> >>
> >> Modify the code to instead start at 512 bytes and work it's way
> >> down instead.
> >>
> >> As _DDC is now called up to 4 times on a machine debugging messages
> >> are noisier than necessary.  Decrease from info to debug.
> >>
> >> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extens=
ions/output-device-specific-methods.html#ddc-return-the-edid-for-this-devic=
e
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > or I can apply it if that's preferred.
>
> Thanks!
>
> I think go ahead and apply this one to your -next tree.

Applied now.

Barring any issues with it, It will get into linux-next in a couple of days=
.

Thanks!

