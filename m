Return-Path: <linux-kernel+bounces-29310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B01830C93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FF91F23C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E283F22F05;
	Wed, 17 Jan 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWVdi1j/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59C22EE0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515474; cv=none; b=euD9VQ0SgTGErZSkEZaKro7/lJGDSPvrzjl3Zz7WOLxv8SRaAZCSUKpF+zZk+fNXQSihs8iUB66ojv/gfDCTNQe2j5JOkWQ7RhbBjUImbUTvZ1z9+HxdRmYl29e/ZL9vOyF9YF/NzJv6JiiangbvTnuKJUkOjzWuPE/pWVblJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515474; c=relaxed/simple;
	bh=WvQNTcu7rqbJv5yCi1GthboGGdsWbP3S2OLtyEk7dRE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=m9/ufDk/9And+qvnd/70OWhv3L5lbm/ZgrijzUyEBI0OJZE4mLlLGxcI9y9Djjg1V8xe/uVOdyFWsNNdMUh+yU7V4QD+rUUSuhDNkxnICIlEwID+0sKB1/kTNHWArNl95NelzuxunWljd78MZGOrqExkxRo5mBP7xVRIzVLSXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWVdi1j/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3379e942685so849661f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705515471; x=1706120271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu6LdrycNNgQ08y3UW6a9CSmx2uDyBWPruWDy4r8EMA=;
        b=NWVdi1j/dBE884TOX3WeNKKe8jFKngzRIHFrCFeKdx4UccbbrJSm6dkmyT97OBgRDD
         UY7LxgHJ4y0jxos/cguwGpVOnDD866kIB3UfUz0U+87pfw9pWebMLHNB9xLT3nhQs/rp
         qRZHKbry/oMSI4ilgcv+hV9DNHETy3TE/dIsE7CwdGpo1Lym3G4zfbTVthlB5wdP4eoQ
         0BZOcbNrh3gyN7sbWDFAYUJgO8HxQG0oZlbto5cecNBD+xQ3DjTPU0vT1UyLnHueGrFa
         s9tzyLcgqhJToBMnzrbprCFkvBA69CUELmdxuxTVoFqu6HHupMITI07H6JEQ6lCwk357
         0fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705515471; x=1706120271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu6LdrycNNgQ08y3UW6a9CSmx2uDyBWPruWDy4r8EMA=;
        b=cSiwhp0QMOL8lXa9f93SRSdscEWWrlRTFZWRBI/M1sQi5vXYy8cP0KsQC54+8KUNon
         PenkP9AKVIVSL/fQR0JE3lHeG9W0pMukrU14+yctvJrHVKIFPQNBcdvKrjzsDExQLKoI
         NUtM+W9Y6RGtZ/3cbvRhVGbZcXCppmpZKI3BHU98jCMcXUqfN2f+kFreqmyukC3OtwbQ
         rnUldeDlQv4RpB/50hpNL9ndJa7MXvT7jOVIKktFY7h3BhCZz6lZKKrDJmKteova/qsc
         1brUphr989K9/ni0nl2dkY2tXOqH6LbyjTD2nyzDrkHc+6tiLZ1yIvoOvv5o9WCmGMhv
         9SYg==
X-Gm-Message-State: AOJu0YzMBGHrQFPxqrRkWMhqer1wmCqHXhHN8hqPrYrh7hx5aOgQuvxq
	IXljq99s7A/XDVzxfwpoh3kcZiBOSQxLMKpYVJQ=
X-Google-Smtp-Source: AGHT+IEmrIoZhd1MvIESvU6Yko91IWdxVx2oC+8IxhhdJadrZ5NjRPWqIvMY3kKddOVb1AmvsJizybm09U2UO8cIEAM=
X-Received: by 2002:adf:fec8:0:b0:337:c50c:27df with SMTP id
 q8-20020adffec8000000b00337c50c27dfmr1311116wrs.4.1705515470923; Wed, 17 Jan
 2024 10:17:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-3-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-3-nunes.erico@gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 17 Jan 2024 10:17:24 -0800
Message-ID: <CA+E=qVe2NB+Bj07JmKVdxreVw0bCuv31xzXng=qPX17spBjDWQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] drm/lima: reset async_reset on pp hard reset
To: Erico Nunes <nunes.erico@gmail.com>
Cc: Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:12=E2=80=AFPM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> Lima pp jobs use an async reset to avoid having to wait for the soft
> reset right after a job. The soft reset is done at the end of a job and
> a reset_complete flag is expected to be set at the next job.
> However, in case the user runs into a job timeout from any application,
> a hard reset is issued to the hardware. This hard reset clears the
> reset_complete flag, which causes an error message to show up before the
> next job.
> This is probably harmless for the execution but can be very confusing to
> debug, as it blames a reset timeout on the next application to submit a
> job.
> Reset the async_reset flag when doing the hard reset so that we don't
> get that message.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  drivers/gpu/drm/lima/lima_pp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_p=
p.c
> index a5c95bed08c0..a8f8f63b8295 100644
> --- a/drivers/gpu/drm/lima/lima_pp.c
> +++ b/drivers/gpu/drm/lima/lima_pp.c
> @@ -191,6 +191,13 @@ static int lima_pp_hard_reset(struct lima_ip *ip)
>         pp_write(LIMA_PP_PERF_CNT_0_LIMIT, 0);
>         pp_write(LIMA_PP_INT_CLEAR, LIMA_PP_IRQ_MASK_ALL);
>         pp_write(LIMA_PP_INT_MASK, LIMA_PP_IRQ_MASK_USED);
> +
> +       /*
> +        * if there was an async soft reset queued,
> +        * don't wait for it in the next job
> +        */
> +       ip->data.async_reset =3D false;
> +
>         return 0;
>  }
>
> --
> 2.43.0
>

