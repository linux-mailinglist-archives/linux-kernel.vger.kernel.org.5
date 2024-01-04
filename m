Return-Path: <linux-kernel+bounces-16226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8687F823B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D4C28889E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D835394;
	Thu,  4 Jan 2024 03:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dsbbhvd3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6EB523D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbd7248ac28so89096276.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 19:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704338914; x=1704943714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjJhlRJd8IebV/Ux2jUleGgIAnCSP1JZTISPsPLyWy4=;
        b=Dsbbhvd3kSNjdq2vFiy+EC51h1sbB03IF3qSE92WW5QGwvcktf6kPqBGuD3M/tbRbq
         aJVy+6akzT3JFjruPQJPuYN/i0XaMQ+eNeE4lNp/caTSHKlgwGGuNumWbauBvh8bhPym
         l7wU6F6sdBpPXiOPXnoGg28HyoikYmuQmzu/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704338914; x=1704943714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjJhlRJd8IebV/Ux2jUleGgIAnCSP1JZTISPsPLyWy4=;
        b=DmFUcrvW9IbbMPgirVUrO/RVxUy6hrSFqAAs2hKtT6QwyfPm3t55plu3fBFYnvLk2t
         ajtAPNLmncmcXQ2aXaeeXm1nXkmK6MjfMz6oVUwZeoUyxCm5DYAYZc990ltnDvXSChpS
         A0bLjqJRp1Z76sbg31cjtI7xj4SRIN7ccztKV47FO1acKSHq9NQ5aZDOb9CUv+HkJc2w
         iCECWuIu3POy1a+UtCkj3SZs9vWPZg+fdyu4QVyCFO4GHRH40oJrX8m2iWoRTDrNsAWp
         5kXXp7Fp3FnDbKklwNFpaApsJKpnGH7q7maFgXPOyYDJEvboIEoD9ZyGOeKuW2Z1rLgr
         8cVg==
X-Gm-Message-State: AOJu0Yyo4S0TpYVs82SbVp2v4wQ3Gnm/hYgS15MHdtUA6m56p7Q8CLpC
	ZHyBBnIOUyq+/iqBTtPoZuedMBaLqfP3Rl4TwXe9a48brjt5
X-Google-Smtp-Source: AGHT+IGnQXJMoLmKebZcu3AExL4W/s42otH47BEQZuiUGpqOkvDW2BL4WUVNvVPN2lb6FY6rYH+lVxDIdaUnEwqPq9M=
X-Received: by 2002:a5b:8cc:0:b0:db7:dacf:3fc6 with SMTP id
 w12-20020a5b08cc000000b00db7dacf3fc6mr15131ybq.115.1704338913905; Wed, 03 Jan
 2024 19:28:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204091416.3308430-1-alexious@zju.edu.cn>
In-Reply-To: <20231204091416.3308430-1-alexious@zju.edu.cn>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 3 Jan 2024 22:28:23 -0500
Message-ID: <CABQX2QNtfJzT_iq0bdsYkz8eUG=r8c8jXyvJ=sp9ipwqfKSErw@mail.gmail.com>
Subject: Re: [PATCH] [v2] drm/vmwgfx: fix a memleak in vmw_gmrid_man_get_node
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Zack Rusin <zackr@vmware.com>, 
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthew Auld <matthew.auld@intel.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 4:15=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> wro=
te:
>
> When ida_alloc_max fails, resources allocated before should be freed,
> including *res allocated by kmalloc and ttm_resource_init.
>
> Fixes: d3bcb4b02fe9 ("drm/vmwgfx: switch the TTM backends to self alloc")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>
> Changelog:
>
> v2: Adding {} to correct the if statement
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c b/drivers/gpu/=
drm/vmwgfx/vmwgfx_gmrid_manager.c
> index ceb4d3d3b965..a0b47c9b33f5 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
> @@ -64,8 +64,11 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_=
manager *man,
>         ttm_resource_init(bo, place, *res);
>
>         id =3D ida_alloc_max(&gman->gmr_ida, gman->max_gmr_ids - 1, GFP_K=
ERNEL);
> -       if (id < 0)
> +       if (id < 0) {
> +               ttm_resource_fini(man, *res);
> +               kfree(*res);
>                 return id;
> +       }
>
>         spin_lock(&gman->lock);

Thanks, I pushed it to drm-misc-next.

z

