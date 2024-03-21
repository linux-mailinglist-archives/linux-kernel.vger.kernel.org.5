Return-Path: <linux-kernel+bounces-110611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26788886145
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D085E1F22877
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D8C134423;
	Thu, 21 Mar 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4jItjY/"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C71339AB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050366; cv=none; b=rUnkD9fBfVjd3XtZyEt7ZZXIgEemUAkNt+duJS3PVNKtQUw3vK8rCSKI4k8q/7W2zvX8L+iNGeHFTUtTfu091C2VpikFolwY8Ueu4o8XBFOt9BMZYXX5zmCpSuex4gP6c+JJfVFH4qIfnH87BL7VQpX0b/5vi0fRIUOWtupUNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050366; c=relaxed/simple;
	bh=sAleMLwt2hNmhmSINGrQ1JYzFvFbKalmI7TJtSAxz3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEwN3hjCRgVxN/XfRCwdVISDG4fJ9lHPdSEbHYFO+61oz6rVvRjG+ymsR1mJeKn2gVTanBe1BuauESFBT+mdP0EToiT0DJyzoS5QIbRqNGjLFDkGbq2ZNKSLeN1TISZFJnV5cE1T7ZOC5OEKhKvTTiXmK1/7ki2cTrFSJkuWm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4jItjY/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29dee60302fso1774704a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711050363; x=1711655163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vba/RjM6pvvbsfl0+e3q074Z+mH/WxL5U5TdVTaBNws=;
        b=O4jItjY/X9VLhwgSnGq6OaXOpZOhapEEnNDVE5CQIjsn/rqNzw4MyM0kyki3ZsSxVs
         3DL33EuIq1YMzSpvl8gXpV8YVjgq3UEDnQze/hCc4O1cy4eDfv8aPFeXkRnAyTgL+rN6
         MhASiZ6rUNCm0SkO0odaJHX1HHWJzohp1TmUymuUVPvOo7cdqqe8Hci/07VON3yTG0jj
         N4L3uaqHLP6H49m2Ob6iHu7iI96xE9x4rcsLOOS11cGCvdMy5ooXG1DJ7cXyKQa3w8Xo
         9/hfD8K0sTnvXIXeS4+vrrn6cHiAlwVFAvm+D+bKtQrGMkmNKpV9dlchDMQUio/lt4t0
         i3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711050363; x=1711655163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vba/RjM6pvvbsfl0+e3q074Z+mH/WxL5U5TdVTaBNws=;
        b=AvijQcMXIbzwpvnJP3iPhfRuKRYTl+KmjrJtWgGOQ++yUWzj9+4wrmN04gD6jWiOGS
         bf5fX4sqmPcPfn0dhrEU/eO74XDgNKg4tpgBx775nej87xVBw4l6vzNfKSNo6FhOIT7m
         hi9U8ec4P41T0OeZJbdcTYZSByag1ppjJnOT5VhAcFCHSjm8QgFHYUGV7Cf4i0ytt6LA
         z3VOVqBikBtPTBpatlwxtpgbkBAh3GaxvQlcZ7sOGO/eoMZX0NYUVUNjHN53jPxhtRvA
         781vyZceswSPvrPUUtZDAPK3M0XJ1PHONv4lj7H5mM/i0UgF4UIPdtULpJkpmISDxm62
         Bgxw==
X-Forwarded-Encrypted: i=1; AJvYcCUlihqXV7RhGinD/nhbqdX9MqhS8vzIjq0EanJlinnEnsch81QcgCVuluk52Rtm4OCMUjO4vp5EGGGOMInLOSM645ntXso3Ht9WZpoq
X-Gm-Message-State: AOJu0YyryUwhLlJqexuFJ9FMssjrRpT1GE0rRzwAS+6RTNAPkBrqxVnH
	IfHnX48646paNWTgKLfRAgzcgi9DgwDFy+6CY2K8vVMQVqiJwq7j4Z6m4W876OB4rXFFJ1r91n+
	A3f5QbEt9flomPWlQty9F+YtvKSZR81QJ
X-Google-Smtp-Source: AGHT+IFzGDqp2c3xNj+jgmU7qMt5VRv/Iw4MyuHnNXDZd7os0Hll4oNTnqrKLXI/Pfvlyo6kM/qOIu0s8HeCrJArY5M=
X-Received: by 2002:a17:90a:fa0e:b0:29c:6146:6adb with SMTP id
 cm14-20020a17090afa0e00b0029c61466adbmr736759pjb.12.1711050362877; Thu, 21
 Mar 2024 12:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321181403.1365947-1-sunil.khatri@amd.com>
In-Reply-To: <20240321181403.1365947-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Mar 2024 15:45:50 -0400
Message-ID: <CADnq5_NbOxav2U-hK8PGnsSymqKn_xjuxGtStjuHzWu_PjfPmA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix function implicit declaration error
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Mar 21, 2024 at 2:14=E2=80=AFPM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> when CONFIG_DEV_COREDUMP is not defined in that case
> when amdgpu_coredump() is called it does not find it's
> definition and the build fails.
>
> This happens as the header is defined without the
> CONFIG_DEV_COREDUMP ifdef and due to which header isn't
> enabled.
>
> Pulling the header out of such ifdef so in both the
> cases the build does not fail.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 95028f57cb56..f771b2042a43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -74,10 +74,7 @@
>  #include "amdgpu_fru_eeprom.h"
>  #include "amdgpu_reset.h"
>  #include "amdgpu_virt.h"
> -
> -#ifdef CONFIG_DEV_COREDUMP
>  #include "amdgpu_dev_coredump.h"
> -#endif
>
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> --
> 2.34.1
>

