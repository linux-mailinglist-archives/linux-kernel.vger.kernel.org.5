Return-Path: <linux-kernel+bounces-16228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECE0823B23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E1D1C21518
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725405684;
	Thu,  4 Jan 2024 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OiUSbn/g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0C5257
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbe39a45e8eso93607276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 19:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704339073; x=1704943873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n80u1CkaWzx8obyOyFuf0rWVWTZDVHCjinQCoRyPWM=;
        b=OiUSbn/g+GZHt6LiMHru5HOMX/1hXR3ODMoJvNO2+bTh9f8JC40mU6ajWAF89+TdyY
         G9eJM6uLDRcS5tmkmcPNn0GXywJ7AMxOM+v6SgE6K1dbFX8EqMRahT8NK5HrS8pyBNFu
         c/hGMmhcul2e3yvFpAx2g2BnuxQp8rvEhn2o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704339073; x=1704943873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n80u1CkaWzx8obyOyFuf0rWVWTZDVHCjinQCoRyPWM=;
        b=X84xqA0vB3HzW14gCyB+fDVDkPrTj37fTUjjuoBnUDr5ncbIdlr09SoXobc6vF1qKb
         WCcBPKB6O8P+9crWWquRkm/WoNThC+9UiywIZLdXnGWNpUPYjDR9JaKLhChed0+k2+94
         Te439TD1aCSRIz08XSq0ls8i6+zV1nzlO6dUOJeC2RTaeONt2h3keu06BgxiI83s0mrK
         EZfq6Zist8dLpBduzOodt2BvSaZyWWQagBG1EspW/802EJ7Mwq+mp7JqJiQAUrpFAuxQ
         OyZ41+p5uWcyRlz+Onz8ywGiIo4mpQuyyVTAUKAG5bz73Nl1LaA2eWb6gjm2BiWjy6zg
         AhUg==
X-Gm-Message-State: AOJu0YwW6eEfczetQ3W5SYJl9t50Hb6EAXnr3bNPvVt/kNhvzNvZKLuv
	iwlRF2lRmFd9FQWA8e32f3rIrFD2lEdmpH0WffXsR7meNPzs
X-Google-Smtp-Source: AGHT+IGuaPvVtHJ5wEmfvzXQLBsZQkV2dtIVwKwQ499x5ahDUSFOeJ36BveDlqYMHrOi+9ZDmI4LmmToAKYZZcRFj38=
X-Received: by 2002:a25:a166:0:b0:dbe:a209:3305 with SMTP id
 z93-20020a25a166000000b00dbea2093305mr10023ybh.98.1704339073736; Wed, 03 Jan
 2024 19:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215235638.19189-1-rdunlap@infradead.org>
In-Reply-To: <20231215235638.19189-1-rdunlap@infradead.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 3 Jan 2024 22:31:03 -0500
Message-ID: <CABQX2QMm4ovL51sLOgi-bFtctLUgXuw-T2m0Qcja41HaR3XKkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: fix kernel-doc Excess struct member 'base'
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	dri-devel@lists.freedesktop.org, 
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Zack Rusin <zackr@vmware.com>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 6:56=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix a new kernel-doc warning reported by kernel test robot:
>
> vmwgfx_surface.c:55: warning: Excess struct member 'base' description in =
'vmw_user_surface'
>
> The other warning is not correct: it is confused by "__counted_by".
> Kees has made a separate patch for that.
>
> In -Wall mode, kernel-doc still reports 20 warnings of this nature:
> vmwgfx_surface.c:198: warning: No description found for return value of '=
vmw_surface_dma_size'
> but I am not addressing those.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312150701.kNI9LuM3-lkp@i=
ntel.com/
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Zack Rusin <zackr@vmware.com>
> Cc: VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff -- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_surface.c
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -44,7 +44,6 @@
>   * struct vmw_user_surface - User-space visible surface resource
>   *
>   * @prime:          The TTM prime object.
> - * @base:           The TTM base object handling user-space visibility.
>   * @srf:            The surface metadata.
>   * @master:         Master of the creating client. Used for security che=
ck.
>   */

Thanks, looks great. I went ahead and pushed this one to drm-misc-next.

z

