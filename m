Return-Path: <linux-kernel+bounces-162663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534E8B5EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132171F22F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD484D0B;
	Mon, 29 Apr 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ0gAp/h"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB985275;
	Mon, 29 Apr 2024 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407267; cv=none; b=IF0+vCORp4/W8z8LaR7ywSLS0oodL5s/rB8fchb2Ds3CkhQ5i3QiMvVFrsv1un9YeZk9529hxsKvg+73aDr4hiQ4dTmfrGtphWDOe0EjvPOqAPQBSFrhTKuDXPavbK+EuUPydWb7SMHMOzqv5cXS7vL72Fvxq0Sq3l0guJcol2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407267; c=relaxed/simple;
	bh=CR/y2tnZiy//zXySTW4b91MXql772mzEYZf3A+Efy+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUEGk+MBXakD1L7Mo2qUjpqxAEqNjQzHgAa38mpyNnsJGROEUh/jZ7d957LIhq8uQ4jJt5UTO1TVH4ZT+bfrHtjxBakVAKZvGxYS0ilEGwZLVppWrSgb0WyXw7jKbPjdwQBhRVBn8Gcg//ds3AvuMPJb/A8obTWG15SmzPgTmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ0gAp/h; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so3278074a91.0;
        Mon, 29 Apr 2024 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714407263; x=1715012063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf+IdRgb927i0JxCWv/ngKuUP45B0rhv7CgotNlHqq4=;
        b=IQ0gAp/h2uBw+Q+dVdt1eEDdtBkbXs2GqpLKLGfyXWa2v4v1QRkjFK5yPtEnZqWt3e
         k8Zv+Y3WBYn/jxT6cyuPPBLGgRTgbMq3POYzMC2Sq72eTtbFOKa4OMKgc+K5WNLv/uUr
         PC/f0SCY497eg7tgK+L7ylL2GLw0u4TnOGkL/M8hockyT8a7Zto4/bhFYxO/30Zg54OB
         7k5tiOScRd7WcFAKdKT9BcGOW4EkpW9vwpjxVlvjYXSUogcxxD/pWGDGuT36xkvBl/Qi
         RQXzsW3jp3iiYXk4Y37r2ETskTzii6yz4w+wwSQe8Qdbw60jF/T0rLlMCYi/pMTbbA87
         yWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714407263; x=1715012063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uf+IdRgb927i0JxCWv/ngKuUP45B0rhv7CgotNlHqq4=;
        b=OlbfkMWBUKK2tZyTlH/gWRFEY19fp/ehwoel/2dWn+Z6nb8Uc/inqC7Ny5CeJFi5qF
         5pDTsccx04xgAcjSl+giMCdYlEW8lXZQEId9LxuvCQB7wEWq6rRdYJO4EFvj0SfARaTe
         +Wgbj9D8umDZqKj63p34wUfMivWrDQo+CPtiw8dNKOmb5vLZcNkD4cxYiFwuXmMmKj22
         dGtx1j4QiENyOylpchFTrn5imvECFMPV/TW2QWwbRyux1v/iEsRmRBpltHubTb4DNqEa
         eJgyCKOwKpTtrDI3sfW0nxhsjh/R2ybfF+o98l7Xxq26ikXH55mVZoOidvPcLKZhoPjH
         KD2g==
X-Forwarded-Encrypted: i=1; AJvYcCVkioZN0rOAh5CAZ7QJGyU0wiM/qAx+TGhysLkBeG6A8hCgTIDU9O/xyAwfIHmQIJD4gkPiEtkQZjPelH1HxhNjAVenGkIpAtbTOpXwYYM3wDyodwtzNmhmPjlltnAtYjihuUA/t5pPFnrlWSIi
X-Gm-Message-State: AOJu0YyHfpYHr3UCN/6l7mDKPS8ckp9nf1edHCL1gG0OBzwGkxwo0mYa
	OJfN7Y55iO1zum2H01vSSX6Z3/FAfS8uLANuVZytESRwXNCbhRtAQ+xN7Mz5ZfuVaoso/niUCck
	REIwxpXnetnDYuDN0FpFRjNRI/18=
X-Google-Smtp-Source: AGHT+IG2B2nx6bmugj+Ci4mKUZM0wGBXzxrm1KAJlrCGW9qVvtEKi0H28eOfwvOwV2BggQL03pq5kA8s/A6ylUd2IIM=
X-Received: by 2002:a17:90a:d685:b0:2af:de3:f0e3 with SMTP id
 x5-20020a17090ad68500b002af0de3f0e3mr126396pju.23.1714407263053; Mon, 29 Apr
 2024 09:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afb229a9-3f18-44cb-b305-5fbb2e1b4ee3@moroto.mountain> <CO6PR12MB53946126A02595B4FDF76525941B2@CO6PR12MB5394.namprd12.prod.outlook.com>
In-Reply-To: <CO6PR12MB53946126A02595B4FDF76525941B2@CO6PR12MB5394.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Apr 2024 12:14:11 -0400
Message-ID: <CADnq5_NQPgW-xmebV5OS-8v_-vY07hP4NYJemYLOC4iCydkxLw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap_irq()
To: "Zhou, Bob" <Bob.Zhou@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
	Guchun Chen <guchun.chen@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
	"Sharma, Shashank" <Shashank.Sharma@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Sun, Apr 28, 2024 at 9:32=E2=80=AFPM Zhou, Bob <Bob.Zhou@amd.com> wrote:
>
> [Public]
>
> Reviewed-by: Bob Zhou <bob.zhou@amd.com>
>
> Regards,
> Bob
>
> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: 2024=E5=B9=B44=E6=9C=8828=E6=97=A5 20:57
> To: Zhou, Bob <Bob.Zhou@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie <ai=
rlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Kuehling, Felix <Felix.K=
uehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Guchun Chen <guch=
un.chen@amd.com>; Ma, Le <Le.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;=
 Sharma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.org;=
 dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; kernel-jani=
tors@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap=
_irq()
>
> The "instance" variable needs to be signed for the error handling to work=
.
>
> Fixes: b34ddc71267a ("drm/amdgpu: add error handle to avoid out-of-bounds=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_0.c
> index 101038395c3b..772604feb6ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2017,7 +2017,7 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu=
_device *adev,
>                                       struct amdgpu_irq_src *source,
>                                       struct amdgpu_iv_entry *entry)  {
> -       uint32_t instance;
> +       int instance;
>
>         DRM_DEBUG("IH: SDMA trap\n");
>         instance =3D sdma_v4_0_irq_id_to_seq(entry->client_id);
> --
> 2.43.0
>

