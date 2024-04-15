Return-Path: <linux-kernel+bounces-144445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A6E8A4680
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9231F21E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEEC4C9F;
	Mon, 15 Apr 2024 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqqTKEo8"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B54A1C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143906; cv=none; b=ROwdhzw8Op0EzVGtQ9tpShfOqkICKHyupJtop8Hhq6CrH5LtLERW7fUH4HtXHJyCfJSfxHZfUZn8u9iwXbE/cQBqBa3Un87ElVGP6h8SibIrlIG/F4twC77aNgou+AHtmIseSdEstZwyi/QfKwyXuJtWJdvoqRAiJHTcoD6lPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143906; c=relaxed/simple;
	bh=r5PRUMdjJQ841mS1ayH4ScnOGFJqE1Jxhym/WGYtLw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMTmGsaiq4gOwSfxeEqSsOUROKK+yRZw4GL88JTbDFf4QiKdaHcH1fsOGhm8Vbv02HOVXNOkm8RT/+9hA9NRnyPwuxLNlex9QLJgG21WmrS5wpRCy7iW6Py9DC1DUKlzhHtp7hdzI36DcNhntLqXBkPcLA9Jc5w0q0plL7JIl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqqTKEo8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51a7d4466bso296121366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713143903; x=1713748703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwPGycLSrCh1dRJbd0yuomILaAkxQqTDIBktFZv8mM4=;
        b=QqqTKEo8f/7xKWjJsXMRFfIxjn0K3rkiX+TjkKDHcQcoXZKluicJNzuD9AeaBNEIpt
         sk+S4nmI5+zpZKJZ9JNbhHMxghB9/FHnK3dtl5YJoVNLGwg8Yw95VZVVat7d1lWd6+Y4
         K/jmWKU+9ZWATMggR4tpOQfyJs0bgRFecHjHD8OWdwAG4JByiNYtXLDSEYTyCAEDhOpw
         7aMURYP+aGz2MbkGzwKthp9UrOuCU/spQm8quzXnkegmBNoKHM9urc2UodrF7CZsS1b+
         T8X+z1i1WKmo2UwFkaAhPSc/1Yu1qHrYcTIx+vInvXnh+KRo/fHKK14kkS8OBk0TU38k
         0akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713143903; x=1713748703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwPGycLSrCh1dRJbd0yuomILaAkxQqTDIBktFZv8mM4=;
        b=WWPKIEgXz8I2qhm3c1XkKKnS5ImfKzj1n7HNdv74UsR6KE9H4xBKTureK0QsGUnQSx
         TVtQqNPK4h5kKRnftxhVxdsqUBHbsbwpY+lVdx2f049wefVpVyhCxmHIcl69nwbkE+sa
         uYMGe8N8NphTUhCRfsXduYoDzT8CBl31wPLk45vbP8awkhEsCGS5HR9fYEGcmQubibOj
         IRxCUtJZKkSKSPW7i6mC8b9PlMEam6pvLTM201FdbhbLXKTnQKcDLevftzXQiNnvKUfa
         Y/Scei4+QaAmM1X+2xBSGbamFx86u3DDkeg6MabjWth5jyfw78yXwVFuapB2BGiOFDsK
         96Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWR+dmFz3F8MrqYu9Yi0rVDzftXTPkq1bswvBjRSX1gHHeQzSQzbgE9Ehth0NQMMmP1bZlt2vhC5OkQV99eSB8w21A4wtrQfdDFnLFO
X-Gm-Message-State: AOJu0Yy1a4fkrWDPiumcxmjGQxgOoogcscZAuDjA+UiFes0Tid+OiHuv
	c1a6LNXFjNZ34CHnIDbtCE+sAIo9lWDMYRTCv8jxex5bMuUQGEXzcXD7RielFDXqGYR7vs5MvvG
	9LASE6tYnKV0XGtfiuxth2xFczcM=
X-Google-Smtp-Source: AGHT+IHSYyCetEUJiEW1j/Tp6AIPuwzOizG7KKp4K8LEV3KdbbxqyolRbz/9lI44q6B/TNAOTkx01pvz9uhuVimTrFE=
X-Received: by 2002:a17:906:6954:b0:a52:5774:69cc with SMTP id
 c20-20020a170906695400b00a52577469ccmr1807845ejs.46.1713143902925; Sun, 14
 Apr 2024 18:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401224329.1228468-1-nunes.erico@gmail.com> <CAKGbVbuvX3qN-0LU9Sj4dWxCY3CoLnj+wcSKx2=D1-K0Qn8WpA@mail.gmail.com>
In-Reply-To: <CAKGbVbuvX3qN-0LU9Sj4dWxCY3CoLnj+wcSKx2=D1-K0Qn8WpA@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Mon, 15 Apr 2024 09:18:11 +0800
Message-ID: <CAKGbVbuO89N0R4+XbTJ6Ns+ZFR24tGqg0vOM3vJu=Bi0=LcGAw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/lima: two driver cleanups
To: Erico Nunes <nunes.erico@gmail.com>
Cc: anarsoul@gmail.com, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

applied to drm-misc-next

On Thu, Apr 4, 2024 at 8:51=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote:
>
> Serial is Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> On Tue, Apr 2, 2024 at 6:43=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com=
> wrote:
> >
> > Patch 1 is a fix for a crash which triggers on removing the module on
> > kernels with CONFIG_DEBUG_SHIRQ enabled, such as the Fedora kernel.
> >
> > Patch 2 is a fix to this warning:
> >   drivers/gpu/drm/lima/lima_drv.c:387:13: error: cast to smaller intege=
r
> >   type 'enum lima_gpu_id' from 'const void *'
> >   [-Werror,-Wvoid-pointer-to-enum-cast]
> > which we have received as a repeated report from the kernel test bot to
> > the lima mailing list.
> > The warning only reproduces with recent clang on aarch64, but the patch
> > does get rid of it and there seem to be no more warnings for W=3D1.
> >
> > Erico Nunes (2):
> >   drm/lima: fix shared irq handling on driver remove
> >   drm/lima: fix void pointer to enum lima_gpu_id cast warning
> >
> >  drivers/gpu/drm/lima/lima_drv.c | 21 ++++++++++++++++++---
> >  drivers/gpu/drm/lima/lima_drv.h |  5 +++++
> >  drivers/gpu/drm/lima/lima_gp.c  |  2 ++
> >  drivers/gpu/drm/lima/lima_mmu.c |  5 +++++
> >  drivers/gpu/drm/lima/lima_pp.c  |  4 ++++
> >  5 files changed, 34 insertions(+), 3 deletions(-)
> >
> > --
> > 2.44.0
> >

