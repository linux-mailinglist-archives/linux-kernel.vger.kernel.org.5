Return-Path: <linux-kernel+bounces-96080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5218756D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C86CB21223
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5785E135A73;
	Thu,  7 Mar 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TegHkR+L"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A912CD8F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838866; cv=none; b=iouyv6FYcY/MhB2KHVZQJWvKAbT8rGgmqj1WdW08LiyyxkdOvN2cFM1Ngr0nqPmOlyNCnybaw/smrUdpKkxukX2fGillUhE8XkY/SIm9pRJDPEO05G2YFenDLWGLRK6i6xKPuf/nfjZukWD6Ob4ThpWRr0qjW4gIjcAgWcUeFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838866; c=relaxed/simple;
	bh=MkafVSoOeGiVtVdHLIxUBlWxB9Cz21M/8qQdbdsgm+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qajxt6nXKHSnT3AnkjdUJGtb1pb0IPJe5zEgZnE3EpIRZR0mTpV6FL4jJXKCIn+tGLgtUjdL+51NIEFQ7jsXorF3MEnBQsIeBKnQ0wP0nGNoYDq8wduEfH2TrtCMnEmuXaByI5OLciSsf4i2p/mPVlGzEU2qsfPjJRQR8u1f2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TegHkR+L; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd178fc492so8640515ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709838864; x=1710443664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2se7G0iGKIEtkLcBAFedZUHevjiz1To/PvhvMoYqSbM=;
        b=TegHkR+Lg9tMgNppGrlyjfKmfin0ZL3g1T7sjz6zrtB3FDpNMJzCoDWQcbF7v3wD/7
         Ih6QflhyaoRSyI/FrFEssn+K0o17djtaYvUJSUF26r4izKV3j//ymt0q/AjxqA5ZCKFZ
         pqg9kAAvvAXKEQUS35R4KTDstcx596fAd/Z9Uw6NpKEpc6lV5XZqJcAirUuzS3j9sDQr
         SSVtREyaNYh3Wy0y5v/qzmvwMpIOwMDr4q5ZNGW11AZFYyuzGT3CTAzhrbqpU0jXDJzJ
         ff0fFE/WhFeDDBwSQYq99cd8fjJjbDesbIVDQAgDM2HU33zI7VPfgAZ85jFrYNQMqcqX
         NdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838864; x=1710443664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2se7G0iGKIEtkLcBAFedZUHevjiz1To/PvhvMoYqSbM=;
        b=lmN2yCFokuhjYRHn+5N1H5K24vhLRMCa0ZAGlKiTh/b8+OY3CRgvxLtTYxTcQLD/Z/
         xdD/LR+jRNVd3WeqSjqcM9VUiaby7KS3D7GNmjxHzBXRnfT8Bdu7Wb2cJJqOuIyr6O76
         mchCtfLO02D66Xceq6DVtrl6jaPitnr9N1l7pcaI+ywDTwXuOOzZrucuJB64NljH3qua
         3KFtrKovFmLw/0CSDAFvedtCPzRWq5objCk1NSga/fDzEjn/Ji8W6/VPnvYsiJHCMQn9
         M4n8YgXuVCDPP/o4iy0PvfUlJAqu6iMWTaSNTnx+AcKV2HvXiTxvTHiEeoHQL9BEIXEq
         y3hw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZdFBCNalL3QZ84YAIDo1IjDnd0HXqGaWRcT4mIrDH+aS4V82xbRGMx2xYcV1e06+sJSdGAbX4Sgh8omjZ0tnaDgGaDdzRpTQTLik
X-Gm-Message-State: AOJu0YxnfwiMrftwK4QqqUr7OX4bffYDjFdYZLQ7T8v8jH/ykxVDXEu7
	zWiU9nsVOHUTtnm4CjZg6XYSMafJay+l2+xWb5sY0+ANorJVRsr2F/Mb29tce9JVQXOWc9AqxkM
	yVsIR+U5M3y820Az844jSmjP+FaI=
X-Google-Smtp-Source: AGHT+IHRVNZAUpprQ4dXeszAr2p/sxRYdzvBxRpzG0DMC1RFVrho4mjcstm8PdLmMghCwTV/K39nXyPIHNPzQnu1L+4=
X-Received: by 2002:a17:90a:5986:b0:29a:e05f:3f55 with SMTP id
 l6-20020a17090a598600b0029ae05f3f55mr15893535pji.2.1709838864479; Thu, 07 Mar
 2024 11:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307165932.3856952-1-sunil.khatri@amd.com> <20240307165932.3856952-3-sunil.khatri@amd.com>
In-Reply-To: <20240307165932.3856952-3-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Mar 2024 14:14:12 -0500
Message-ID: <CADnq5_OaCRAjCZGOEpd1gTFSUHdNkVbDqDgx_LQKw_JR1Qtv3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add vm fault information to devcoredump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Mukul Joshi <mukul.joshi@amd.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:00=E2=80=AFPM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add page fault information to the devcoredump.
>
> Output of devcoredump:
> **** AMDGPU Device Coredump ****
> version: 1
> kernel: 6.7.0-amd-staging-drm-next
> module: amdgpu
> time: 29.725011811
> process_name: soft_recovery_p PID: 1720
>
> Ring timed out details
> IP Type: 0 Ring Name: gfx_0.0.0
>
> [gfxhub] Page fault observed
> Faulty page starting at address 0x0000000000000000

Do you want a : before the address for consistency?

> Protection fault status register:0x301031

How about a space after the : for consistency?

For parsability, it may make more sense to just have a list of key value pa=
irs:
[GPU page fault]
hub:
addr:
status:
[Ring timeout details]
IP:
ring:
name:

etc.

>
> VRAM is lost due to GPU reset!
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index 147100c27c2d..dd39e614d907 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -203,8 +203,20 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset,=
 size_t count,
>                            coredump->ring->name);
>         }
>
> +       if (coredump->adev) {
> +               struct amdgpu_vm_fault_info *fault_info =3D
> +                       &coredump->adev->vm_manager.fault_info;
> +
> +               drm_printf(&p, "\n[%s] Page fault observed\n",
> +                          fault_info->vmhub ? "mmhub" : "gfxhub");
> +               drm_printf(&p, "Faulty page starting at address 0x%016llx=
\n",
> +                          fault_info->addr);
> +               drm_printf(&p, "Protection fault status register:0x%x\n",
> +                          fault_info->status);
> +       }
> +
>         if (coredump->reset_vram_lost)
> -               drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> +               drm_printf(&p, "\nVRAM is lost due to GPU reset!\n");
>         if (coredump->adev->reset_info.num_regs) {
>                 drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value=
:\n");
>
> --
> 2.34.1
>

