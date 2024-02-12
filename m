Return-Path: <linux-kernel+bounces-61213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B16850EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1681F21115
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929CAF51B;
	Mon, 12 Feb 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeiM934w"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818E522C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727217; cv=none; b=aKyljf4/Vl4A1TKd5PzjXE0l6rmiMJ17kIPapcMp0ieFXGkoyaAFY46es0DKFBc4qRv7LfWSjnufG6vRM4MFeeXhCSg2XZZjpcpU+7N2xP6DOhpJs+leSX6JozDe9iIj8zqFFKc6FhD+TuuMJEK+3wy4mOQSeCeJps0XvNA3rPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727217; c=relaxed/simple;
	bh=H7HdBiAs04p56cZBJJLxvIhXRaVYbVE0YSOPadORfso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amXol6FLInqwtSLnT8gZTiVOhUqBUxFtxaKlYmWMkGh3o6gEj2slPAjBkYWYHDZCIG9qFxwtIIv6FnNDAXKdwXgFf/KRA69fR67xDrmBs5G1HCYHcCkaZ4yGNxmYi1wFyXPiOqVtQ3RDJxVNsttXTqoPa/x+MmQjSdyDFTFKmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeiM934w; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3ccea0d75fso21732566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707727214; x=1708332014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2xx3qmM5DQGb345GrWzFVJ1pSbmuD2ER1Bx8oiyhcA=;
        b=MeiM934wwKvoH/F9pXp6+1mEHhL+Xp4XHCQgpNypoif5pZIt4UoXnQo6q8fekXFkny
         WHbL50wSqfIVi9Bk5emOnsJvDCsFwSbrJcyJ9nCsITiLuxVuSgCf+NKCXqmZNNJLkEfP
         D5wZWPPsZs6Tm+Y4yWpcVWaF+Lz1pWP+3fth1f2Rv3RVqPUxnsOGoj7IwluDBi9oiFs/
         B6w7kPZyudka+0DChkPKzelkDMYxQ6CZmW7UTFszHuPUwRuILBT5fQ68ZS10yUbe/63G
         OplXXopU3yGOm9El86Uz0NrDiLkBVopSIB/NFwSisnPm43WlGFTcVy2MHKAKhuzF+BFq
         jgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707727214; x=1708332014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2xx3qmM5DQGb345GrWzFVJ1pSbmuD2ER1Bx8oiyhcA=;
        b=JeIvCWtHE6QpxSJbdTFzfxxaXu/JR5TRlvI8IZcDTT2/ubso0PaJEJikDNxUXLEC7x
         ZbiW5SWXD9xPgeEuTqYDHTLMZthXWgoS/tPVF+XTv+zPR+YPc4Ij6FtFk3IxFwo5509H
         Fzx8UScTPzNbmByi+HBkHpxSOkHiGMflLpc+mtXLZRgQI/DaxcxBmuccb0Rbx1RzFepE
         PodytLGPU1mHZWAhQU8SxuCMlTfhvIravkPoqBm1dIw3XNFPDPPwmadjVkVihgJjWhof
         8WTcJqutPhUzOctESviN27nkRNV1TyklK40HmdjZeOp3cnqANsYGvv81qT+bdkcMBi//
         a89A==
X-Gm-Message-State: AOJu0YwHxdV2e9QZc/1wFVUs5Uf4gTmu5p8i5pQptSn58n/TOs0MAZOH
	bC5glOIjnQE5dCS8vGKKZ9LqhdmK2jrJ/APxXG9l1nGKJ/l4LPS20Mpxjvq09Rmlg87EnKaryOm
	E+EQZj72sXGPC9+5lpXv6YAavRYk=
X-Google-Smtp-Source: AGHT+IGHu8Gu6lx/Z58M3WTUbZ2FP4tKJEXJaK+dLgiGcDi7Ai/qCtNWUA3mugM69D/IODos2t/68TUhBhZndZsFhU4=
X-Received: by 2002:a17:906:195b:b0:a3c:aace:1649 with SMTP id
 b27-20020a170906195b00b00a3caace1649mr937573eje.26.1707727214079; Mon, 12 Feb
 2024 00:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124025947.2110659-1-nunes.erico@gmail.com> <CAKGbVbtAe5jnAwb7O8epq3g4FqLC-ggof3D=5gO9hJf5OuH0OQ@mail.gmail.com>
In-Reply-To: <CAKGbVbtAe5jnAwb7O8epq3g4FqLC-ggof3D=5gO9hJf5OuH0OQ@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Mon, 12 Feb 2024 16:40:02 +0800
Message-ID: <CAKGbVbvOcAmiUPUQak3VA_2=KeAQZryG=vTTn7pydjmSSLwBPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] drm/lima: fixes and improvements to error recovery
To: Erico Nunes <nunes.erico@gmail.com>
Cc: anarsoul@gmail.com, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

applied to drm-misc-next

On Tue, Jan 30, 2024 at 9:07=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wrote:
>
> Serial is Reviewed-by: QIang Yu <yuq825@gmail.com>
>
> On Wed, Jan 24, 2024 at 11:00=E2=80=AFAM Erico Nunes <nunes.erico@gmail.c=
om> wrote:
> >
> > v1 reference:
> > https://patchwork.kernel.org/project/dri-devel/cover/20240117031212.110=
4034-1-nunes.erico@gmail.com/
> >
> > Changes v1 -> v2:
> > - Dropped patch 1 which aimed to fix
> > https://gitlab.freedesktop.org/mesa/mesa/-/issues/8415 .
> > That will require more testing and an actual fix to the irq/timeout
> > handler race. It can be solved separately so I am deferring it to a
> > followup patch and keeping that issue open.
> >
> > - Added patches 2 and 4 to cover "reset time out" and bus stop bit to
> > hard reset in gp as well.
> >
> > - Added handling of all processors in synchronize_irq in patch 5 to
> > cover multiple pp. Dropped unnecessary duplicate fence in patch 5.
> >
> > - Added patch 7 in v2. After some discussion in patch 4 (v1), it seems
> > to be reasonable to bump our timeout value so that we further decrease
> > the chance of users actually hitting any of these timeouts by default.
> >
> > - Reworked patch 8 in v2. Since I broadened the work to not only focus
> > in pp anymore, I also included the change to the other blocks as well.
> >
> > - Collected some reviews and acks in unmodified patches.
> >
> >
> > Erico Nunes (8):
> >   drm/lima: reset async_reset on pp hard reset
> >   drm/lima: reset async_reset on gp hard reset
> >   drm/lima: set pp bus_stop bit before hard reset
> >   drm/lima: set gp bus_stop bit before hard reset
> >   drm/lima: handle spurious timeouts due to high irq latency
> >   drm/lima: remove guilty drm_sched context handling
> >   drm/lima: increase default job timeout to 10s
> >   drm/lima: standardize debug messages by ip name
> >
> >  drivers/gpu/drm/lima/lima_ctx.c      |  2 +-
> >  drivers/gpu/drm/lima/lima_ctx.h      |  1 -
> >  drivers/gpu/drm/lima/lima_gp.c       | 39 +++++++++++++++++++++-------
> >  drivers/gpu/drm/lima/lima_l2_cache.c |  6 +++--
> >  drivers/gpu/drm/lima/lima_mmu.c      | 18 ++++++-------
> >  drivers/gpu/drm/lima/lima_pmu.c      |  3 ++-
> >  drivers/gpu/drm/lima/lima_pp.c       | 37 ++++++++++++++++++++------
> >  drivers/gpu/drm/lima/lima_sched.c    | 38 ++++++++++++++++++++++-----
> >  drivers/gpu/drm/lima/lima_sched.h    |  3 +--
> >  9 files changed, 107 insertions(+), 40 deletions(-)
> >
> > --
> > 2.43.0
> >

