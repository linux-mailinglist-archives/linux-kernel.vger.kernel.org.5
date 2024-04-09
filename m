Return-Path: <linux-kernel+bounces-136099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1002089CFF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EDE1F23BC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704C4F1FA;
	Tue,  9 Apr 2024 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYq0BEu5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2494F1E0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627124; cv=none; b=gNlTHCm3DDllrWRpnbuqb8ThY7FvJDK7jeZBmzwVGw8quAqAdNQmK2mNExSrIyZvz2Abm6rwD561qxtp8QgYEvmzzbDB1NIOgqkb4KlJEaCqEdXN4KZC/rBjGcv2P9KcNfafmyIS8rfAqjq2ko0XzlIoXbKFJk2cvRhw8kRR+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627124; c=relaxed/simple;
	bh=z2eCoScpgsl7Ir10XM1QcJSlIyoPYZVQM9kO+cbyA4c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WYzSU8IWhwf5kL+8inMo14vTuI5R+3AK+Jb5rHRRwErzrSGVuB4n9zPmwOhbTexaFIFKGaJqT3b21JqPom1EIMN5dxGwryNqSGrT5IujEXJM+BeShOhDVe1VrghHbgi3LMmvspq1J7Ov+mTo7si24oQ99xR3LLuXFFoshyq3QDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYq0BEu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5305C433C7;
	Tue,  9 Apr 2024 01:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712627124;
	bh=z2eCoScpgsl7Ir10XM1QcJSlIyoPYZVQM9kO+cbyA4c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BYq0BEu52Xr7p+duyjGWBqOJ8lQxU+kvhZP8g8BBzCi1/cdfwn/DUHnGAL4n7FM7r
	 MXD8jY2HLdZ2SiA2XuFQEhKTXp4Cuwq3DTrqoAopfzwn1RS4vMRp9hXwKgvhFKlvl6
	 /OMOodkL377GbnigzmGjgDOT1ByAPWU6oMeEaqnHKEJuI7O1fwaNmw+Rpn6ovdjgmh
	 XFzatHYbuzIavNJWEJIq7Wo95UcR7KeIC94m6zRA6bs/ebslJ/oX0nNvjTqUkWEhXO
	 3GODVwmUFrtZ4O3nqPdBoC51rwfzCufRzKeUzdN9BZ0Y0j7/chak6onuw18zf6eWap
	 1Safc6T57lgRA==
Date: Mon, 08 Apr 2024 18:45:19 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Justin Piszcz <jpiszcz@lucidpixels.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>
CC: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 =?ISO-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 Kees Cook <keescook@chromium.org>
Subject: =?US-ASCII?Q?Re=3A_6=2E5=2E5=3A_UBSAN=3A_radeon=5Fatombios=2Ec=3A_ind?=
 =?US-ASCII?Q?ex_1_is_out_of_range_for_type_=27UCHAR_=5B1=5D=27?=
User-Agent: K-9 Mail for Android
In-Reply-To: <a619df03-e0cb-48f7-840a-970b7a6f6037@quicinc.com>
References: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com> <ZRoIGhMesKtmNkAM@debian.me> <CAO9zADyfaLRWB-0rdojnbFD6SUsqX+zb9JZSZUkgTC7VJN=c1A@mail.gmail.com> <a619df03-e0cb-48f7-840a-970b7a6f6037@quicinc.com>
Message-ID: <CA212FEF-E0BB-483C-86CC-6986D4FBE168@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 8, 2024 5:45:29 PM PDT, Jeff Johnson <quic_jjohnson@quicinc=2Ecom=
> wrote:
>On 10/1/23 17:12, Justin Piszcz wrote:
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>> [Sun Oct  1 15:59:04 2023] UBSAN: array-index-out-of-bounds in
>>>> drivers/gpu/drm/radeon/radeon_atombios=2Ec:2620:43
>>>> [Sun Oct  1 15:59:04 2023] index 1 is out of range for type 'UCHAR [1=
]'
>>>> [Sun Oct  1 15:59:04 2023] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G
>>>>              T  6=2E5=2E5 #13 55df8de52754ef95effc50a55e9206abdea304a=
c
>>>> [Sun Oct  1 15:59:04 2023] Hardware name: Supermicro X9SRL-F/X9SRL-F,
>>>> BIOS 3=2E3 11/13/2018
>>>> [Sun Oct  1 15:59:04 2023] Call Trace:
>>>> [Sun Oct  1 15:59:04 2023]  <TASK>
>>>> [Sun Oct  1 15:59:04 2023]  dump_stack_lvl+0x36/0x50
>>>> [Sun Oct  1 15:59:04 2023]  __ubsan_handle_out_of_bounds+0xc7/0x110
>>>> [Sun Oct  1 15:59:04 2023]  radeon_atombios_get_power_modes+0x87a/0x8=
f0
>>>> [Sun Oct  1 15:59:04 2023]  radeon_pm_init+0x13a/0x7e0
>>>> [Sun Oct  1 15:59:04 2023]  evergreen_init+0x13d/0x3d0
>>>> [Sun Oct  1 15:59:04 2023]  radeon_device_init+0x60a/0xbf0
>>>> [Sun Oct  1 15:59:04 2023]  radeon_driver_load_kms+0xb1/0x250
>>>> [Sun Oct  1 15:59:04 2023]  drm_dev_register+0xfc/0x250
>>>> [Sun Oct  1 15:59:04 2023]  radeon_pci_probe+0xd0/0x150
>>>> [Sun Oct  1 15:59:04 2023]  pci_device_probe+0x97/0x130
>>>> [Sun Oct  1 15:59:04 2023]  really_probe+0xbe/0x2f0
>>>> [Sun Oct  1 15:59:04 2023]  ? __pfx___driver_attach+0x10/0x10
>>>> [Sun Oct  1 15:59:04 2023]  __driver_probe_device+0x6e/0x120
>>>> [Sun Oct  1 15:59:04 2023]  driver_probe_device+0x1a/0x90
>>>> [Sun Oct  1 15:59:04 2023]  __driver_attach+0xd4/0x170
>>>> [Sun Oct  1 15:59:04 2023]  bus_for_each_dev+0x87/0xe0
>>>> [Sun Oct  1 15:59:04 2023]  bus_add_driver+0xf3/0x1f0
>>>> [Sun Oct  1 15:59:04 2023]  driver_register+0x58/0x120
>>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_radeon_module_init+0x10/0x10
>>>> [Sun Oct  1 15:59:04 2023]  do_one_initcall+0x93/0x4a0
>>>> [Sun Oct  1 15:59:04 2023]  kernel_init_freeable+0x301/0x580
>>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
>>>> [Sun Oct  1 15:59:04 2023]  kernel_init+0x15/0x1b0
>>>> [Sun Oct  1 15:59:04 2023]  ret_from_fork+0x2f/0x50
>>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
>>>> [Sun Oct  1 15:59:04 2023]  ret_from_fork_asm+0x1b/0x30
>>>> [Sun Oct  1 15:59:04 2023]  </TASK>
>>>> [Sun Oct  1 15:59:04 2023]
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>> [Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
>>>> [Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
>>>> pages 262144
>>>> [Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
>>>> disable with radeon=2Epcie_gen2=3D0
>>>> [Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table at
>>>> 0x000000000014C000)=2E
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: WB enabled
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: fence driver on rin=
g 0
>>>> use gpu addr 0x0000000040000c00
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: fence driver on rin=
g 3
>>>> use gpu addr 0x0000000040000c0c
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: fence driver on rin=
g 5
>>>> use gpu addr 0x000000000005c418
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: radeon: MSI limited=
 to 32-bit
>>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00=2E0: radeon: using MSI=
=2E
>>>> [Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized=2E
>>>>=20
>>>=20
>>> Please also open an issue on freedesktop tracker [1]=2E
>>>=20
>>> Thanks=2E
>>>=20
>>> [1]: https://gitlab=2Efreedesktop=2Eorg/drm/amd/-/issues
>>=20
>> Issue opened: https://gitlab=2Efreedesktop=2Eorg/drm/amd/-/issues/2894
>>=20
>> Regards,
>> Justin
>
>+Kees since I've worked with him on several of these flexible array issue=
s=2E
>
>I just happened to look at kernel logs today for my ath1*k driver mainten=
ance and see the subject issue is present on my device, running 6=2E9=2E0-r=
c1=2E The freedesktop issue tracker says the issue is closed, but any fix h=
as not landed in the upstream kernel=2E Is there a -next patch somewhere?
>
>[   12=2E105270] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/rade=
on/radeon_atombios=2Ec:2718:34
>[   12=2E105272] index 48 is out of range for type 'UCHAR [1]'
>[
>
>If there isn't really an upstream fix, I can probably supply one=2E

I would expect this to have fixed it:
https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/c=
ommit/drivers/gpu/drm/radeon/pptable=2Eh?id=3Dc63079c61177ba1b17fa05c687569=
9a36924fe39

If not, there must be something else happening?

-Kees

--=20
Kees Cook

