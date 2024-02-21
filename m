Return-Path: <linux-kernel+bounces-75465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF9885E916
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59031F24AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FC53B2A6;
	Wed, 21 Feb 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQSHjKhi"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB7EEB3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547704; cv=none; b=AetbowELtBhgv1MfTkusW/Z9t77mBB7XRSznx9HcwdRItKVqdZPovdt/yG8wMlrpSwYhBn2KLqMCN2XWA10uVoZ4YROosg3wNeftllCZ9ZpfAGpz4iKMI2AWLaCDMYDqmK8pqcHvMFG58uEINi+1AKk+T31YzT2WA8lJJ0NNLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547704; c=relaxed/simple;
	bh=OUdtHXh3OzJ/eVKZU2asBP+bROM4KUA0y1H2YPfrJKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9rwhiIAyZPIUDWRh9n/UwDpxTb4nC+DhmEfC0hX2Une/CtCZ2LoBkDqyOaA7qBm6uTO4bAX+Uz0dpnx1VAq3lxQsMjsSYyS5Jhw89VaPsjq7cJ0s2Djg5AUlpRJdLtSC6VXfIt/XKEX5k13S+vJPGgWMP+7UH9j2AbU3P49BoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQSHjKhi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d918008b99so59209785ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708547702; x=1709152502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bhYykhkdnbA79Ly3s+SMOT0nYqMLem10RWT+KTFTuU=;
        b=HQSHjKhivbl0OQHvE9PnrNeylxjmxK8XQsGo+oJOrt4Xgieyu7Yk8xeWrQOJhkgHFB
         2PkNVLjQq+pjnYg4snFPutgok5NCM2kWMb9SAiDlEG25VtBd895NHzkmqJoAUgsSGuf4
         HD44uzzJEc46lDN9WcsVItQ9ZGP8rTGtnMvBGP0SItsztePDIIHtbQ8Xt2XRsZFuHjxr
         hLcW/HbxYJeo5c4X57ttrjmDh14HyoiFR/RCBLqONxMIthEX/tr1Sx4I8zGzkOa4zcyE
         wA9Ifur+UsjwNJYAZ8Fym/aUvzRJ1eozU8ksC40kttUP3GHPjjGjxIiccBC749JJIGus
         099A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547702; x=1709152502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bhYykhkdnbA79Ly3s+SMOT0nYqMLem10RWT+KTFTuU=;
        b=DYc8Aloe5soSEPdMsya0MNVzJRTpnxXu8TX5pTPejYEiASFQjMR6rTtJJ0AG9IIDF/
         +UdcZD7dDcV0X5WkmTo/Z9VMYcuq9kA/USkcfENJh+ZYgG3JqNEFWqffXT3ASrk22tJe
         Mz4Ia8mw5GtC5HJ32ZULOntdSnBsfQCexKJR7EJCFzW/OeWhivbtyh6WV79OlJI6tkdn
         kc+w6Gtae2lJfA4YQiO+qJ9M7NGGaNO5nHbdLerITRxR/YIUvgtSIa2P79cTXzLQ+dDt
         s96/dZvkM/o9Z+hlv90k6TBJpdleQjd+ZVEm4EptuZ6iE4LRaB3OF9o2eQ7y/S6nzcT7
         D7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXfwac1dygDJottrgtV8SdpvlNvVJFFwiuKweOXq1/4HedO0qGlLdnjWVn57KLgXwaqchUIoXwYQx+PhVlttnVrgqWeFtnWOwjqHQfW
X-Gm-Message-State: AOJu0YwbVuh0Ah2P3NLqRqaAKRfgSSAoRJKE3iXgvFWqlFw2ZLfC6aFP
	mP5Ac9ZDv/CQ026MXd7tmCktYlrT9zPz9vyjftDlYDucD18VvjE3jk6VdOoNolqEIZxsDiVxXRu
	0V0mXV4fkstRdttn5DDRPg2I6xvc=
X-Google-Smtp-Source: AGHT+IHUGdXylJFt2yo5p2Mwr4DIrtm0FgL8AyM6LN0zQs70eWze1pfy17ZubP/nB+Geq09MGrBssVmu6al/mnEo6iw=
X-Received: by 2002:a17:90b:397:b0:299:14e4:6579 with SMTP id
 ga23-20020a17090b039700b0029914e46579mr15246193pjb.22.1708547702507; Wed, 21
 Feb 2024 12:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221095907.172408-1-chentao@kylinos.cn> <75a4102e-b078-4e95-a5b5-a677ad9622fd@amd.com>
In-Reply-To: <75a4102e-b078-4e95-a5b5-a677ad9622fd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Feb 2024 15:34:50 -0500
Message-ID: <CADnq5_N42HwHG_LUENEb+ZFf_A7w4wH+YsbSmUDu-DS1oYqjgQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amdgpu: Use KMEM_CACHE instead of kmem_cache_create
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Kunwu Chan <chentao@kylinos.cn>, alexander.deucher@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Feb 21, 2024 at 6:08=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 21.02.24 um 10:59 schrieb Kunwu Chan:
> > For where the cache name and the structure name match.
> > Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> > to simplify the creation of SLAB caches.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the enti=
re
> series.
>
> >
> > Kunwu Chan (3):
> >    drm/amdgpu: Simplify the allocation of fence slab caches
> >    drm/amdgpu: Simplify the allocation of mux_chunk slab caches
> >    drm/amdgpu: Simplify the allocation of sync slab caches
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c    | 4 +---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 4 +---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c     | 4 +---
> >   3 files changed, 3 insertions(+), 9 deletions(-)
> >
>

