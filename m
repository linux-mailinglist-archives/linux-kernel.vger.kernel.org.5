Return-Path: <linux-kernel+bounces-160434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB76F8B3D71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4101C242E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C615B551;
	Fri, 26 Apr 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK3dgk6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AA153BD0;
	Fri, 26 Apr 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150794; cv=none; b=FR3WO3cbBFDhafpVM8nNsPR7xR+rJRKrTYY9RwGNMagd4wDnf9rX7gGQM7jJapn3qmoPkiO3F7f9x92TQu7ZTc0n2Bcvjrerpz8SqsMwvbYRjxPLPUpk/cQEhIUk8Uks1oQGAcj2zkS8NtZt3FR1YZCGnfAxk0LRB3FfYECbjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150794; c=relaxed/simple;
	bh=jgmMLYfSoahSejTPd6/kp4I5ShAHF5p6/V08nhfQwu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z748n7PjIDpJIDu+juHTt+gfz3PwpO+DzWRlqKKZsc4euxvVhHAwFTO0GmSMb7mNE2rswNK/ilmKunfLS/3ZbWrsi9TXWWdDT+nTQ6ctc7xW2CM7a1kCnl22yE2mqTvvS0kMC/Bp9+WeX+fGuK59ch1X7uaQ6Q0uEADFLzY/yQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK3dgk6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03131C2BD10;
	Fri, 26 Apr 2024 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714150794;
	bh=jgmMLYfSoahSejTPd6/kp4I5ShAHF5p6/V08nhfQwu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YK3dgk6EfyJHyfN2aV6uBJEIU6ymKdiZHvtS10ARg0QtapH/I0tGM6R6xUUi2onjc
	 Ub6HNm8DxuwRx1ENNSZgZg4MUGQ9PbG/yQehWAchIMoIjJmSb3jfd0/PCIg+Ozn3/1
	 2HuTnbzmiu6m7LNwSPQT0DmcDkBujg83wq27n5gVmuKroOCAe/sZoaLES7jeuEAx8n
	 K6IYRm/BR13NtSXj9dbA0zruUgLO4iiWeyRIiE9+lQFGAZVxd7UM+ai0RjDh85W9bt
	 N3oEGWdyQcl+9eQWe2jryJJ6r5NJXx2UqnmfaPZAxjap4NYaYFG+8ltCLYo7+CUDFU
	 kJWSwmsUGxhKA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5acdbfa6e95so559478eaf.3;
        Fri, 26 Apr 2024 09:59:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDMpqdbRrJ1I84Pppom0UdnU4gpi03FRR3M7Ii+8t1adxNkmK8oGEmK7w1k18MSUFUoDpxshsL7XFUnVaryAY9t0Z1rEuTppq1GQLmfsQbi+C5uOuozEl0gAaP9r5th6wgIMD6L/c1fA==
X-Gm-Message-State: AOJu0Yx4CxFkVFtEBBNuGshGwnSH+/JQbwGBNeb4gRyUicrlniXfK8IX
	1i+wrgakAOcGXozwS1KKoi1U7yWopDLpTDYWHkOj6Ql7mTvyNg1iJ+AncRmRot64axUzihU6uoy
	brRTturv4AogKi88Khq9Pb/vpy4E=
X-Google-Smtp-Source: AGHT+IGsKp5B81TokZe61JJmDWgSgNTBh04qFZjcV00kAliu5M7yGepUAXmzz0PQwCMGwU95FBIUCmNlHmN5KDNbYjI=
X-Received: by 2002:a05:6870:2808:b0:22e:161b:7682 with SMTP id
 gz8-20020a056870280800b0022e161b7682mr3498222oab.4.1714150793279; Fri, 26 Apr
 2024 09:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424-acpidocfix-v1-1-078658a3c456@jookia.org>
In-Reply-To: <20240424-acpidocfix-v1-1-078658a3c456@jookia.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 18:59:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEcPO0GrjudTWOSn6UVoV7UbjCi3fNpAa3A1+8UbCfcw@mail.gmail.com>
Message-ID: <CAJZ5v0iEcPO0GrjudTWOSn6UVoV7UbjCi3fNpAa3A1+8UbCfcw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: firmware-guide: ACPI: Fix namespace typo
To: John Watts <contact@jookia.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 12:17=E2=80=AFAM John Watts <contact@jookia.org> wr=
ote:
>
> The ACPI namespace has always started with LNXSYSTM, not LNXSYSTEM.
> Fix the documentation accordingly.
>
> Signed-off-by: John Watts <contact@jookia.org>
> ---
> This isn't a major issue, it just is incorrect and requires people
> following the documentation to look for a similar directory.
> ---
>  Documentation/firmware-guide/acpi/namespace.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/namespace.rst b/Documentat=
ion/firmware-guide/acpi/namespace.rst
> index 4ef963679a3d..5021843b526b 100644
> --- a/Documentation/firmware-guide/acpi/namespace.rst
> +++ b/Documentation/firmware-guide/acpi/namespace.rst
> @@ -15,7 +15,7 @@ ACPI Device Tree - Representation of ACPI Namespace
>  Abstract
>  =3D=3D=3D=3D=3D=3D=3D=3D
>  The Linux ACPI subsystem converts ACPI namespace objects into a Linux
> -device tree under the /sys/devices/LNXSYSTEM:00 and updates it upon
> +device tree under the /sys/devices/LNXSYSTM:00 and updates it upon
>  receiving ACPI hotplug notification events.  For each device object
>  in this hierarchy there is a corresponding symbolic link in the
>  /sys/bus/acpi/devices.
> @@ -326,7 +326,7 @@ example ACPI namespace illustrated in Figure 2 with t=
he addition of
>  fixed PWR_BUTTON/SLP_BUTTON devices is shown below::
>
>     +--------------+---+-----------------+
> -   | LNXSYSTEM:00 | \ | acpi:LNXSYSTEM: |
> +   | LNXSYSTM:00  | \ | acpi:LNXSYSTM:  |
>     +--------------+---+-----------------+
>       |
>       | +-------------+-----+----------------+
>
> ---

Applied as 6.10 material, thanks!

