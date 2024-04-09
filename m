Return-Path: <linux-kernel+bounces-136225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3789D177
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D63C1C239F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD4762D7;
	Tue,  9 Apr 2024 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3t8dqR9"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67D7604D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712636599; cv=none; b=uchqHGbaZHkOCnOHkd26lMZsNeyCc4tILGmcMnsj7VxgPNqkPt8bhzv9bVyiGgx9Ju6d83tbwyMQyiGEQqt0ffnZHDggadnyRX0ar6D69dSs/RpJl4nXzYzdmtebcIM4kQ5PBop6InHa7+SgAtorB35tCyNtKuDTR0/T7fpmJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712636599; c=relaxed/simple;
	bh=beTkpYwtJV+t5CxYWh0zckfi7M3IpQimrt25Wfmutgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgMIc3xH8BS6gbbgPqq5+30/bNq+LQkfTjtVWQIxK0gMi+AKquDHWWT7z10CxBNIAzHH7Rzaj4b2ykaa6knCP6/ezlw4ZScvYSOS9/bCMIJV/l3988VviI+L4EWM+IxDSk+z0Z5JSmgZc7zD6pgc+oB9TexjNRX3hdsBnHsiZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3t8dqR9; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4300536a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 21:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712636597; x=1713241397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmMw7a5O50tj9x9X/rTKi3+asqjaHKmEWJL4jpB0MIM=;
        b=Y3t8dqR96GhluqRs55RQe7vbRDLzm/SES2oM0qo8ggLGkrjQYTxaB7yvNgkuSWjWZ9
         3olQBNjwaXDobUQzup6m4JYGwkEZxLPEKX0L85QHCsx7MmTimQvURvsyAWP9iZbz2PB8
         jiFfByN2ZXFGdTUr+9Jz8vD8P25Z0yI6culINlKrSuORgbopoYIjGiMOb4V1DQ60C/xB
         1hcM0AUkkW+cgCGYV2NsK7AZTDVWpIl4l3ABU/OVS00yrENmDAS5NSxnhfN0T8ZUxsqc
         o1jcYbTfMk4RlAsRHQj6VJIHjvNt209/CrPGezvbnulyaFMuqzsQ1jybaeF2kjyO1jjC
         KjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712636597; x=1713241397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmMw7a5O50tj9x9X/rTKi3+asqjaHKmEWJL4jpB0MIM=;
        b=UDorniXKzqc0w4+aDSqe77nksgZ5GFHDJVDURX6lFhhPHFBcwz5GKYUuswGh9Hman1
         aiDni5DNvIVxGPFEdnBJrHNauSRrsF6wt2BUUuTYZsLBLxwCzwHQiSAd41j323y9RBiV
         ByuFCCafO+szvTCtHBnC7XWzGSkJs8U/KQpDGhlatjKF1tQoppagJrhFeqHDOejAI1Cq
         e6GGQl8s7SNaoZ5nHLWLkugRysLgXlx7JmBTJcIQAQaiw/QA8EenKZwWnQ/CtzMAbXHa
         4uUwvDNocMAKYtw1GaZwadn4rk0+7U/NhxrSbypMn7syN4OC2IjTM5zGsYN+6hSR4NWs
         jprA==
X-Forwarded-Encrypted: i=1; AJvYcCWKrxwVU8i3m4BGsLw9eBCtLgKih3sJTykSmxh6QETdtiQsJFc0EPH8VsuGKNMvLhahnA/ChAIVG/Ytp5Yc/8KBONeYpkus9rF8DReV
X-Gm-Message-State: AOJu0YzjDXaOCopDJzg0fnMu3aiQ748rYdjq7TmyY8aZDTGesayEiqRM
	g35SUFzHWRVYX7e5vB2rI37YxUbMRLwM5itaqdrBJtkmqzLwdN8gNvHpSmZBs4o5OwhCaokU98b
	J3K6PTL4co34xfEH4rz8xVdkcG34=
X-Google-Smtp-Source: AGHT+IErkFwGKO2kTAdhos7XepQZsquGNVc0/92UHzaKSlD+q8rpc3ijcmyr5W4VXK5Zf6zz4zb7gE9OjGY/Z/6i8K0=
X-Received: by 2002:a05:6a20:5603:b0:1a7:9ce4:bd1d with SMTP id
 ir3-20020a056a20560300b001a79ce4bd1dmr1604314pzc.34.1712636597462; Mon, 08
 Apr 2024 21:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
 <ZRoIGhMesKtmNkAM@debian.me> <CAO9zADyfaLRWB-0rdojnbFD6SUsqX+zb9JZSZUkgTC7VJN=c1A@mail.gmail.com>
 <a619df03-e0cb-48f7-840a-970b7a6f6037@quicinc.com> <CA212FEF-E0BB-483C-86CC-6986D4FBE168@kernel.org>
In-Reply-To: <CA212FEF-E0BB-483C-86CC-6986D4FBE168@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Apr 2024 00:23:05 -0400
Message-ID: <CADnq5_PKoX9G8jD=m1WnX3nxd_+GL_xi03_Dgq8HK6Diw3=JsQ@mail.gmail.com>
Subject: Re: 6.5.5: UBSAN: radeon_atombios.c: index 1 is out of range for type
 'UCHAR [1]'
To: Kees Cook <kees@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux AMDGPU <amd-gfx@lists.freedesktop.org>, 
	Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:45=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On April 8, 2024 5:45:29 PM PDT, Jeff Johnson <quic_jjohnson@quicinc.com>=
 wrote:
> >On 10/1/23 17:12, Justin Piszcz wrote:
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> [Sun Oct  1 15:59:04 2023] UBSAN: array-index-out-of-bounds in
> >>>> drivers/gpu/drm/radeon/radeon_atombios.c:2620:43
> >>>> [Sun Oct  1 15:59:04 2023] index 1 is out of range for type 'UCHAR [=
1]'
> >>>> [Sun Oct  1 15:59:04 2023] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G
> >>>>              T  6.5.5 #13 55df8de52754ef95effc50a55e9206abdea304ac
> >>>> [Sun Oct  1 15:59:04 2023] Hardware name: Supermicro X9SRL-F/X9SRL-F=
,
> >>>> BIOS 3.3 11/13/2018
> >>>> [Sun Oct  1 15:59:04 2023] Call Trace:
> >>>> [Sun Oct  1 15:59:04 2023]  <TASK>
> >>>> [Sun Oct  1 15:59:04 2023]  dump_stack_lvl+0x36/0x50
> >>>> [Sun Oct  1 15:59:04 2023]  __ubsan_handle_out_of_bounds+0xc7/0x110
> >>>> [Sun Oct  1 15:59:04 2023]  radeon_atombios_get_power_modes+0x87a/0x=
8f0
> >>>> [Sun Oct  1 15:59:04 2023]  radeon_pm_init+0x13a/0x7e0
> >>>> [Sun Oct  1 15:59:04 2023]  evergreen_init+0x13d/0x3d0
> >>>> [Sun Oct  1 15:59:04 2023]  radeon_device_init+0x60a/0xbf0
> >>>> [Sun Oct  1 15:59:04 2023]  radeon_driver_load_kms+0xb1/0x250
> >>>> [Sun Oct  1 15:59:04 2023]  drm_dev_register+0xfc/0x250
> >>>> [Sun Oct  1 15:59:04 2023]  radeon_pci_probe+0xd0/0x150
> >>>> [Sun Oct  1 15:59:04 2023]  pci_device_probe+0x97/0x130
> >>>> [Sun Oct  1 15:59:04 2023]  really_probe+0xbe/0x2f0
> >>>> [Sun Oct  1 15:59:04 2023]  ? __pfx___driver_attach+0x10/0x10
> >>>> [Sun Oct  1 15:59:04 2023]  __driver_probe_device+0x6e/0x120
> >>>> [Sun Oct  1 15:59:04 2023]  driver_probe_device+0x1a/0x90
> >>>> [Sun Oct  1 15:59:04 2023]  __driver_attach+0xd4/0x170
> >>>> [Sun Oct  1 15:59:04 2023]  bus_for_each_dev+0x87/0xe0
> >>>> [Sun Oct  1 15:59:04 2023]  bus_add_driver+0xf3/0x1f0
> >>>> [Sun Oct  1 15:59:04 2023]  driver_register+0x58/0x120
> >>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_radeon_module_init+0x10/0x10
> >>>> [Sun Oct  1 15:59:04 2023]  do_one_initcall+0x93/0x4a0
> >>>> [Sun Oct  1 15:59:04 2023]  kernel_init_freeable+0x301/0x580
> >>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
> >>>> [Sun Oct  1 15:59:04 2023]  kernel_init+0x15/0x1b0
> >>>> [Sun Oct  1 15:59:04 2023]  ret_from_fork+0x2f/0x50
> >>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
> >>>> [Sun Oct  1 15:59:04 2023]  ret_from_fork_asm+0x1b/0x30
> >>>> [Sun Oct  1 15:59:04 2023]  </TASK>
> >>>> [Sun Oct  1 15:59:04 2023]
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> [Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
> >>>> [Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
> >>>> pages 262144
> >>>> [Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
> >>>> disable with radeon.pcie_gen2=3D0
> >>>> [Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table a=
t
> >>>> 0x000000000014C000).
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: WB enabled
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring=
 0
> >>>> use gpu addr 0x0000000040000c00
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring=
 3
> >>>> use gpu addr 0x0000000040000c0c
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring=
 5
> >>>> use gpu addr 0x000000000005c418
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: MSI limited =
to 32-bit
> >>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: using MSI.
> >>>> [Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized.
> >>>>
> >>>
> >>> Please also open an issue on freedesktop tracker [1].
> >>>
> >>> Thanks.
> >>>
> >>> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues
> >>
> >> Issue opened: https://gitlab.freedesktop.org/drm/amd/-/issues/2894
> >>
> >> Regards,
> >> Justin
> >
> >+Kees since I've worked with him on several of these flexible array issu=
es.
> >
> >I just happened to look at kernel logs today for my ath1*k driver mainte=
nance and see the subject issue is present on my device, running 6.9.0-rc1.=
 The freedesktop issue tracker says the issue is closed, but any fix has no=
t landed in the upstream kernel. Is there a -next patch somewhere?
> >
> >[   12.105270] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/radeo=
n/radeon_atombios.c:2718:34
> >[   12.105272] index 48 is out of range for type 'UCHAR [1]'
> >[
> >
> >If there isn't really an upstream fix, I can probably supply one.
>
> I would expect this to have fixed it:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/gpu/drm/radeon/pptable.h?id=3Dc63079c61177ba1b17fa05c6875699a36924=
fe39
>
> If not, there must be something else happening?

This patch should silence it I think:
https://patchwork.freedesktop.org/patch/588305/

Alex

>
> -Kees
>
> --
> Kees Cook

