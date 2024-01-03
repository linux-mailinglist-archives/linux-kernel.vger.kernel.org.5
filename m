Return-Path: <linux-kernel+bounces-15651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25177822F8F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D772F1F247CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1021A5A9;
	Wed,  3 Jan 2024 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+eF994S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCB1945B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-203ae9903a6so5542740fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704292216; x=1704897016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX1lPt29dCJY1lm7moFZL9vZknDJXTE84CiBdwPeikg=;
        b=j+eF994SvXp9DuIlSKnYIWj6m//3Gk0fUv2uAUNINn9R0dLGZZo2MSVwSEJU+GmaPc
         Vw1m0aazURlV1HQajNZhESs1PUlxp+Q5l2vm/11OH0l08LIdEEpbqEbBrwbHXnelQ/H2
         mlTZXzk7PG/eX9kZI2UmJ8hR6A2I9agPII+k/6KGs2IbL0GZScvZa8AZipjmVNalOVmW
         928sJz1290q+t024fEjbau9KCqe8PRwilHMtakxW1mTAqEDfU+log28fnX/EDHiwFiKm
         04aNuZ13iaq4KDy9KAiUH78nQ8SDh+ckayGCGDVMflgL3DJjGown2sAM/k1/fKe886oe
         UVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704292216; x=1704897016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX1lPt29dCJY1lm7moFZL9vZknDJXTE84CiBdwPeikg=;
        b=EEaSWYnJOmnilJvT+tmwgglRr9mDI1GumO2TXxHvBMyVLkKm9v30nhNUKF98oxEtRY
         3RnZJTRoXvYeP6PKej6qt/FykXTQ5UFbf9l3WWjowVKzxsQtikS/ukFMbasEdKuljtEu
         ivXWpQ+wPqFOL0MBmT+gezndSWsMn5GiYEoEYPGdPpVo7ALQmhAs87P8rVAhoKvKdG2F
         Q53aeIjfm6QfQEhW7QY4N/qDaRMwmZ+2uq5Lbt5/5ukAGRUcohP65mZ3paGSxNCrJSD0
         irmXFbD3hPZS7+eoQ9yXg0X6Pm4J1ROGul+4FNjL1j3lG4kKkcSOCtlk6epjGOjoOeZs
         hSuA==
X-Gm-Message-State: AOJu0YwrobH4WkPGn/ihg//iFyfvybG6KpssqdRs/jG6DXSBqRdlH2bD
	aaeAAAG8lKmNlBy9S2p/i1DDRlmE0Kdl5aMGCOk=
X-Google-Smtp-Source: AGHT+IEZbfPBEDib/RU6p08tX4ysNOAhGE8Alxp+aBc7Hmb0TEYfeIIZMDhVl6/g8ugOqdTPytJCAXwjXk4Sqggcuss=
X-Received: by 2002:a05:6870:b156:b0:203:e64a:eb73 with SMTP id
 a22-20020a056870b15600b00203e64aeb73mr16227470oal.69.1704292215727; Wed, 03
 Jan 2024 06:30:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231224082249.3539167-1-alexious@zju.edu.cn>
In-Reply-To: <20231224082249.3539167-1-alexious@zju.edu.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:30:04 -0500
Message-ID: <CADnq5_NrcF+Swf0T+upaM64=WYfxExEHyBEGKTDAB8P4Khyw1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/smu7: fix a memleak in smu7_hwmgr_backend_init
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org, Ran Sun <sunran001@208suo.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Deepak R Varma <drv@mailo.com>, Rex Zhu <Rex.Zhu@amd.com>, 
	Ruan Jinjie <ruanjinjie@huawei.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, 
	Ken Wang <Qingqing.Wang@amd.com>, Evan Quan <evan.quan@amd.com>, 
	David Airlie <airlied@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Dec 25, 2023 at 5:18=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> wr=
ote:
>
> The hwmgr->backend, (i.e. data) allocated by kzalloc is not freed in
> the error-handling paths of smu7_get_evv_voltages and
> smu7_update_edc_leakage_table. However, it did be freed in the
> error-handling of phm_initializa_dynamic_state_adjustment_rule_settings,
> by smu7_hwmgr_backend_fini. So the lack of free in smu7_get_evv_voltages
> and smu7_update_edc_leakage_table is considered a memleak in this patch.
>
> Fixes: 599a7e9fe1b6 ("drm/amd/powerplay: implement smu7 hwmgr to manager =
asics with smu ip version 7.")
> Fixes: 8f0804c6b7d0 ("drm/amd/pm: add edc leakage controller setting")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 11372fcc59c8..b1a8799e2dee 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -2974,6 +2974,8 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr =
*hwmgr)
>                 result =3D smu7_get_evv_voltages(hwmgr);
>                 if (result) {
>                         pr_info("Get EVV Voltage Failed.  Abort Driver lo=
ading!\n");
> +                       kfree(hwmgr->backend);
> +                       hwmgr->backend =3D NULL;
>                         return -EINVAL;
>                 }
>         } else {
> @@ -3019,8 +3021,10 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr=
 *hwmgr)
>         }
>
>         result =3D smu7_update_edc_leakage_table(hwmgr);
> -       if (result)
> +       if (result) {
> +               smu7_hwmgr_backend_fini(hwmgr);
>                 return result;
> +       }
>
>         return 0;
>  }
> --
> 2.34.1
>

