Return-Path: <linux-kernel+bounces-145307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C848A526D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FADAB20D10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A847319C;
	Mon, 15 Apr 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ero135lM"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202411E896
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189411; cv=none; b=QOZf+NKCWeUfcnb4Nt3XKvkD4ElFcSck60E2wBIFg+1p+uN0B4/2felnnCR+J63Pu60FNx0GEnCfBjjRH3hJC1XQEfERqahYmtprZHyS5Eqwocw8pmougygfY2vpzzR+AUIWsvQJclg3VI66bbT83yoq/71zDoj6mdTQ3ViU0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189411; c=relaxed/simple;
	bh=2Rc/FROJ/tVQ3yRp7w3W7hLiWt24ZpOOoheaUgBrXwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdXSp3f/LZaiJNJr6VUgph0G5iTxqP0Ad6UlPVRv/8MGc6HxL96uyc3Sri5r1chcDw3t4Mtv8GSV53aPL9KtwgEiN9d8snStd9ojzhmktcv6TIwC4G54LKh/3GKmj8pqsQC0Nw14U17rM1ZA3xoFVlWOMLFf4I/nTkdaWaSCdFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ero135lM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3017093a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713189409; x=1713794209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N27uhOB3jdl5PJcj6aOsTcYbh8hiJsFDu4/EeTNh8FU=;
        b=ero135lMKbUpxuoAEcUoFdjP+ayFhelK24k/Ys0S752WaQiSalFsWa9WVKqnY/LUSI
         f8qEgdWX34xRAzgqR154rotDgU1y1jBrwVg/vOxI8fNSayN35EGajteqco7igCJN8jN+
         lD+lLCE6+XriBEvetnvppC8Xyl/lD4klpbp7p4riGRfZg6PKdCuHWYzvGenWSLn1ll1o
         uBsLBj8uBvCIGDtRbRm+/5vLtE1na1erJoWrHx2eII5qjozZV03qI/j2jYN4hIGQXuGq
         6L6BsfPwL7Yrj0TTPZMmWdzOEuCsnZe0dvCdCPNDdL3sQsx2EZ0QPtlqbMTIpFcLMP9Z
         Hejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189409; x=1713794209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N27uhOB3jdl5PJcj6aOsTcYbh8hiJsFDu4/EeTNh8FU=;
        b=b7VRU2n3+sUwxt3Tte40aI5cLgBlOC7FM8FM8XTnxYQpojFpZ5zmtWEItPaW1gq32N
         blPq4fY8UUrw1mEKvdvXLSyNI/HnDj48Us2YIdm0P46KWk4TgHkzPW+voDaZLHdHKxc6
         5ofKkgtK50GG2ZR07Aa9MjtD7wAn7+DhYFXS3NE0WagejO4yQ8IzOH6eTmtKuTWiSbHi
         MV+mCreuKyxsmjAkKeGC3wPCjG14I7u8mZvVBscyyAHsgjNZqcKHP4hbToSP01zkSV3q
         Lexm2zViCGJt4HgTsIGYOvobAFUXjeJFpVRYTY+zB72AOz6i0lwCFKmI1YIHhYyq5qWm
         UvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu4C2UMWls2ezmVaE5lpDMTwviumlXyL11uJDJtSX3Foq+QccZI1lbuHckxv6hRlU4EtVZTF+rldfYpoBXG6qnq5g6Ry3Bldgqsxl1
X-Gm-Message-State: AOJu0YwWG++Y8blV2jFj3T+ZRYB5RiWxgGLTnAhR0AfNDLaa+ieMRvWC
	lUs8Kx/23RLeQgJYRACkPFUYtLFut9TW08sqqNwb/U4ZWSFY7RIvxriNc/Jt5uDceCufuAGg3Co
	ildtqEx/qXw0H/NHIAAtYcdq2xX4=
X-Google-Smtp-Source: AGHT+IEuqzfxEKSwCRqiSawZUWwilC/ojUvHQDxuDQYLsSXPdtaOnhU6lM2L2uNln4vBjCYSGvjs1qSx8rhc0LBcb7A=
X-Received: by 2002:a17:90b:892:b0:2a6:76e2:86db with SMTP id
 bj18-20020a17090b089200b002a676e286dbmr14028033pjb.15.1713189409324; Mon, 15
 Apr 2024 06:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414233838.359190-1-thorsten.blum@toblux.com>
In-Reply-To: <20240414233838.359190-1-thorsten.blum@toblux.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Apr 2024 09:56:37 -0400
Message-ID: <CADnq5_P1YjyywJ1B+uG+0VRmWKGqiHOLQDuVe5_jmL3cMN-3OQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add missing space to DRM_WARN() message
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Mario Limonciello <mario.limonciello@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:40=E2=80=AFAM Thorsten Blum <thorsten.blum@toblux=
com> wrote:
>
> s/,please/, please/
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

And applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7753a2e64d41..3cba0e196ca8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1455,7 +1455,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_devic=
e *adev)
>
>         /* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
>         if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
> -               DRM_WARN("System can't access extended configuration spac=
e,please check!!\n");
> +               DRM_WARN("System can't access extended configuration spac=
e, please check!!\n");
>
>         /* skip if the bios has already enabled large BAR */
>         if (adev->gmc.real_vram_size &&
> --
> 2.39.2
>

