Return-Path: <linux-kernel+bounces-104443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C5C87CDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5911C20DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8A2575D;
	Fri, 15 Mar 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caQbKsfo"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689F241F9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508518; cv=none; b=O47Z6xwJTUHP7B0sJxYKMMdzfGYCFagHHONU+u/ASynV73/M9utjfzgZztYHtqKcD+rqEFQKiRw5QXJvgxixug9m7IoaQfceAzlFKKIBIMk5s/28p36yREEkPcEnovf68x6lCEEUlvtYbfyA4THlkKbD0EvPzgMpdubbh52cIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508518; c=relaxed/simple;
	bh=Pjj2ZWhSAAWWhwPZ9KE2hS5HpVXut161e8Zimba/FCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/H59CjnzI+T6S3R8b7rLGD1ENPyCN/VEQedKjSL9+mwufdAsb+CvJeejkd7bwp97lwZ52/G83M1l2S7aUjXE5OrwRcFHMK3vXxeYbH44LfT+9YpOE1HwJNlwHlgA7xkDENLKh2af+gFOUcbTED6l+nO/wtLIMd5oq8Yc+bCVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caQbKsfo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29b7caa88c6so1692693a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710508517; x=1711113317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xArLs+uRWKVcLaNLsdyx3ULVcbdPBPfj9m9G7izSGw=;
        b=caQbKsfoHWYQhkuAXhs7KLh4iaxk7Bkhgx6gBj1HUzjw3aUnpRvJYOWs6Q7Ey+uNyy
         msefHvY0i+9PPUf1ISIwo0+cTKeOidaR93GamYpUU5OIwTeniYHtoyyUW36YR7fuMWz4
         E5nuW4ctLD90FRiA48FuVJVJ1wML+NrGUj+a5Xup6Q2CAiJhH/toBasNENxWKs1VMTf+
         WIWTRK8ObwJ9ghNG6xTPEp43NgRo6S4ekXVdCR8iVqvAQFooyYsGGqF20y9Qk/qUdhtH
         Suehm3Xkr7ii5CRKQFo/nrYzAi7vD9Zqi5YHZmGWGSz9esewbvFj2DD8hodCdmVrZcrn
         kkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508517; x=1711113317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xArLs+uRWKVcLaNLsdyx3ULVcbdPBPfj9m9G7izSGw=;
        b=MzsBKjQN5g+Q5MuQDEYtWy7+OgN4uBt1WuZljsv9AXdc4PO3kT/xZhhcMu2cK8eYNI
         zQOjf+3ux47eIjSYYe/acu0HyhUfYPvZCVhXfNlSlyF7YuNgY3+bYHGxtXn6PfwDh4pr
         cd6B5LIBvJ7s2vwqyPNFHA5UkLwjk8QBam0xeVgIVT4rs5DoNJH+zAKnNOF/Tb3XMSmL
         DOjhoSvUoUUXY2kGuZDvBJHNMfWIQImEd1xCsGmi4+wPvqmXIDnyyNt0Nc/GmyMz02+r
         8uaj1UKHgQqnAzW1LpsBaSc6CISA818T9Via+YrwitszZNfSmc2M2j75rKEmHIbdPVHi
         Rktw==
X-Forwarded-Encrypted: i=1; AJvYcCViYm4pHMlTHuUjc/1S+m26wjh+ERtOYM3TYv8VrgeGhYTmfP25ke6Cx5pfez+DLCzkGJ+vV5XpnROsoJKpQGkUSpIEkcf6Tgg7LrUE
X-Gm-Message-State: AOJu0YwQU9UmybKY3Qd1pgUcepqgbmF/wxoo6a3p0s/vdFZhjeBSxR6C
	C35na/wJ6UtX57dsMlP6AxHyHSajHsUlhLZAW85ncsHaWFrok+q5Edf3rdWeTukvIuPbPndZkP9
	R8MIpneAD1algNcwTRyFAjLafUNA=
X-Google-Smtp-Source: AGHT+IFszOtqZsBrsCaeD8AagP6jTW2qGgUUxVKCWna95eZpFtJXyEtQc+YvHuRJlO1PeqRIIw6BgYeFAlMEpQI+mFg=
X-Received: by 2002:a17:90a:ee93:b0:29b:22d2:9dd5 with SMTP id
 i19-20020a17090aee9300b0029b22d29dd5mr4615017pjz.38.1710508516676; Fri, 15
 Mar 2024 06:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315121315.406601-1-sunil.khatri@amd.com>
In-Reply-To: <20240315121315.406601-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Mar 2024 09:15:04 -0400
Message-ID: <CADnq5_NsqSWknj5x0v22iF2_UPCEFO7gnj4BV5j22x-jitO1=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add the hw_ip version of all IP's
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 8:13=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add all the IP's version information on a SOC to the
> devcoredump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

This looks great.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 62 +++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index a0dbccad2f53..3d4bfe0a5a7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -29,6 +29,43 @@
>  #include "sienna_cichlid.h"
>  #include "smu_v13_0_10.h"
>
> +const char *hw_ip_names[MAX_HWIP] =3D {
> +       [GC_HWIP]               =3D "GC",
> +       [HDP_HWIP]              =3D "HDP",
> +       [SDMA0_HWIP]            =3D "SDMA0",
> +       [SDMA1_HWIP]            =3D "SDMA1",
> +       [SDMA2_HWIP]            =3D "SDMA2",
> +       [SDMA3_HWIP]            =3D "SDMA3",
> +       [SDMA4_HWIP]            =3D "SDMA4",
> +       [SDMA5_HWIP]            =3D "SDMA5",
> +       [SDMA6_HWIP]            =3D "SDMA6",
> +       [SDMA7_HWIP]            =3D "SDMA7",
> +       [LSDMA_HWIP]            =3D "LSDMA",
> +       [MMHUB_HWIP]            =3D "MMHUB",
> +       [ATHUB_HWIP]            =3D "ATHUB",
> +       [NBIO_HWIP]             =3D "NBIO",
> +       [MP0_HWIP]              =3D "MP0",
> +       [MP1_HWIP]              =3D "MP1",
> +       [UVD_HWIP]              =3D "UVD/JPEG/VCN",
> +       [VCN1_HWIP]             =3D "VCN1",
> +       [VCE_HWIP]              =3D "VCE",
> +       [VPE_HWIP]              =3D "VPE",
> +       [DF_HWIP]               =3D "DF",
> +       [DCE_HWIP]              =3D "DCE",
> +       [OSSSYS_HWIP]           =3D "OSSSYS",
> +       [SMUIO_HWIP]            =3D "SMUIO",
> +       [PWR_HWIP]              =3D "PWR",
> +       [NBIF_HWIP]             =3D "NBIF",
> +       [THM_HWIP]              =3D "THM",
> +       [CLK_HWIP]              =3D "CLK",
> +       [UMC_HWIP]              =3D "UMC",
> +       [RSMU_HWIP]             =3D "RSMU",
> +       [XGMI_HWIP]             =3D "XGMI",
> +       [DCI_HWIP]              =3D "DCI",
> +       [PCIE_HWIP]             =3D "PCIE",
> +};
> +
> +
>  int amdgpu_reset_init(struct amdgpu_device *adev)
>  {
>         int ret =3D 0;
> @@ -196,6 +233,31 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset,=
 size_t count,
>                            coredump->reset_task_info.process_name,
>                            coredump->reset_task_info.pid);
>
> +       /* GPU IP's information of the SOC */
> +       if (coredump->adev) {
> +
> +               drm_printf(&p, "\nIP Information\n");
> +               drm_printf(&p, "SOC Family: %d\n", coredump->adev->family=
);
> +               drm_printf(&p, "SOC Revision id: %d\n", coredump->adev->r=
ev_id);
> +               drm_printf(&p, "SOC External Revision id: %d\n",
> +                          coredump->adev->external_rev_id);
> +
> +               for (int i =3D 1; i < MAX_HWIP; i++) {
> +                       for (int j =3D 0; j < HWIP_MAX_INSTANCE; j++) {
> +                               int ver =3D coredump->adev->ip_versions[i=
][j];
> +
> +                               if (ver)
> +                                       drm_printf(&p, "HWIP: %s[%d][%d]:=
 v%d.%d.%d.%d.%d\n",
> +                                                  hw_ip_names[i], i, j,
> +                                                  IP_VERSION_MAJ(ver),
> +                                                  IP_VERSION_MIN(ver),
> +                                                  IP_VERSION_REV(ver),
> +                                                  IP_VERSION_VARIANT(ver=
),
> +                                                  IP_VERSION_SUBREV(ver)=
);
> +                       }
> +               }
> +       }
> +
>         if (coredump->ring) {
>                 drm_printf(&p, "\nRing timed out details\n");
>                 drm_printf(&p, "IP Type: %d Ring Name: %s\n",
> --
> 2.34.1
>

