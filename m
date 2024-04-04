Return-Path: <linux-kernel+bounces-131471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44949898849
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D121F27441
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96982C7E;
	Thu,  4 Apr 2024 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjGHUybf"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7374C00
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235121; cv=none; b=fxgoR8KllR8qSqHcBXBjBPOjkVdMZxmLFMNLF17llxTbpnv8QSkx/KEvz7itI1HubWwYssHUVR6MoFZI67AxCbNeT3SJ/dd8MVYnn1cRjJ88n+XyawAdiloOmXvfBhmK1AxI/qTw3uYz4BUoWGKr1VedF1ShFQ+eKW+niryRjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235121; c=relaxed/simple;
	bh=HAQPEmrsZnfhJBLM4La7QuPi+ei+wBR7Bf6pBFSm3J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv1KhfY+ydZZp4vFCKkDhrCWR/SOFI7kglfgUw/8GmvVJsSL6/4z3ptqnriHdYDcW7Th0r+rJzSOcMhLTbsQllVlkx1z5aZDasxAZOqYyjCsk8v8/PO6k65gAAkYZ82TXTKWz0GmIEH/VqBHqJaaHzIHxxoiUOPNMVRSDI/Y158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjGHUybf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5193f56986so42093566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712235118; x=1712839918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnnhlpaHNCUCIrrWDg/RL2L2v9aF/5YKbhFHqy0aII8=;
        b=IjGHUybfaKqwFmzC73QI1T5boEvozQBst8Bl6PRhSmscGMYgt0A9gXdeG2HOwCi/6p
         CHRkHLnv9W0apJuS9l2KJvwU4Bb6j37+aJ6hrod0nfZ0cqJYY/Q+95xIZX2aCskYAJFz
         LkFbdyZcawF5taoA0q3gz7dUhtRkT3mabLMwBYkM/zO5g5p4MkVQhEOWPcP1E878HagC
         Ex/5WClVSR60UFiJYNHExq4ZMvJNLA/Cbnr9BT9c7uNd92TQxcnvdTvcvFXicKLs+g/B
         AVv1nKdcpI9v8ywGSnHrvgHSwssRZSg6QD9x3hmX/dXRifxXvPcODICRprLW2eqnFuTq
         Q/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712235118; x=1712839918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnnhlpaHNCUCIrrWDg/RL2L2v9aF/5YKbhFHqy0aII8=;
        b=Tkb3fGWUm9wktcZX+lnop17dSchSQ6mIHJcxyoE3V072CYuJ1Q8iXktMoS85IWArj8
         fdNLDjtnhR4JC2Q4826uQVucLjjUnjVQeJNgdmlPE0j4YOEydJlFOSv9yvKsIxCiLV/B
         YVwyiF3faCTQOYz30vM39akZTupOSNIFypJfpjnieYQC99XO44zR4PRkOLJfm/t+Tzyl
         8RfhJbiNwOoqlQGLTLTwNvoKYGYuuXVbZN4qGjg1xotOybKv6uUZfimmmmhM+h9zOBTk
         +wMRi5UNfpJ1GFxvdnu4fzy/SIK3LIOxnIHOhFljU9QtZNAKgHA13PGhQDQlByCl/FBw
         E1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUZTmGDyxDicQSpQ4eZ70SfFWfTYoeOkte+MclGOCYwrTGefmuae8X79mq65ub31qgkiTj6KckEbclOv1Mny57BZBwmXPNHgAeTpZHo
X-Gm-Message-State: AOJu0YytZ21MG8CejGqbwCRS0St1xiwOeoWVpOJ4lfMGsbcK9ZpMggjy
	HbgA28HxT96LH7+uZib8VBjlxu3fhBwZIVYzUlmPHTmaYFehdaIWxk2gwGigfilPvmZEmxMwQBb
	eln21nI8vvwKgt/luqcwkFouOK1U10ruxikk=
X-Google-Smtp-Source: AGHT+IEAbu57T3CEw3mRcXuQKUKAbPMz0MmW5SuVqjvtMKR/CDDjvR12TFadTmieeFLw/af6A9WId94r6dBGaIvl5w8=
X-Received: by 2002:a17:906:3a81:b0:a46:3ce4:5acb with SMTP id
 y1-20020a1709063a8100b00a463ce45acbmr1583695ejd.75.1712235118422; Thu, 04 Apr
 2024 05:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401224329.1228468-1-nunes.erico@gmail.com>
In-Reply-To: <20240401224329.1228468-1-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Thu, 4 Apr 2024 20:51:46 +0800
Message-ID: <CAKGbVbuvX3qN-0LU9Sj4dWxCY3CoLnj+wcSKx2=D1-K0Qn8WpA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/lima: two driver cleanups
To: Erico Nunes <nunes.erico@gmail.com>
Cc: anarsoul@gmail.com, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Serial is Reviewed-by: Qiang Yu <yuq825@gmail.com>

On Tue, Apr 2, 2024 at 6:43=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com> =
wrote:
>
> Patch 1 is a fix for a crash which triggers on removing the module on
> kernels with CONFIG_DEBUG_SHIRQ enabled, such as the Fedora kernel.
>
> Patch 2 is a fix to this warning:
>   drivers/gpu/drm/lima/lima_drv.c:387:13: error: cast to smaller integer
>   type 'enum lima_gpu_id' from 'const void *'
>   [-Werror,-Wvoid-pointer-to-enum-cast]
> which we have received as a repeated report from the kernel test bot to
> the lima mailing list.
> The warning only reproduces with recent clang on aarch64, but the patch
> does get rid of it and there seem to be no more warnings for W=3D1.
>
> Erico Nunes (2):
>   drm/lima: fix shared irq handling on driver remove
>   drm/lima: fix void pointer to enum lima_gpu_id cast warning
>
>  drivers/gpu/drm/lima/lima_drv.c | 21 ++++++++++++++++++---
>  drivers/gpu/drm/lima/lima_drv.h |  5 +++++
>  drivers/gpu/drm/lima/lima_gp.c  |  2 ++
>  drivers/gpu/drm/lima/lima_mmu.c |  5 +++++
>  drivers/gpu/drm/lima/lima_pp.c  |  4 ++++
>  5 files changed, 34 insertions(+), 3 deletions(-)
>
> --
> 2.44.0
>

