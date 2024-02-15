Return-Path: <linux-kernel+bounces-67349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC01856A43
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85AA2849E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1D3137C27;
	Thu, 15 Feb 2024 16:54:08 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ECA1353FE;
	Thu, 15 Feb 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016048; cv=none; b=ak8QLRxdYwcPsPNpCx4pwVwBmAHf0cSML0+qYcrRZtM9nsJxTZ7xueoqWe2P3HlztC8AFrBDWsGsqm/RsCPwd8e3R+loxCsRtgG8xwlATV/WEPh09rLYUrSrSzSKaUw9vJ/6k2kv2UM19ouqpcwCZ6mRbF9YMP8blrEd6zKD0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016048; c=relaxed/simple;
	bh=UNBMhdZkJ8i2ygg/m+VxNNBbaZjxJhARj35RepppVjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0SsS/XWEOzo2YxzJLTXbgK+hH3mqu4SO/BOw6BHxKuAUVQNBYGgMjXFUg+ha+cqbfg+/8JOjNaoqvfQZWcrJcHS8gnmMmT3809JAxYOQXizPo3w25qxxkDLBLe+SZePPArljKALj5ytjzPkl4ISB2FHNdElbmOAZfAfKZBGT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so1117491276.1;
        Thu, 15 Feb 2024 08:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708016045; x=1708620845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpZ3DC22tFbBqcAPh32HZHLlqMy5ASZz7S0FXazTgLQ=;
        b=o0R/9bOjDot+YeFsf+jV3tjYmdGfvPLKrCY6w576+Hmu6UMyt6DKBuUtQ+fFCqcMIT
         3drMIh1i8eUm81JPmbp/mrnHvOettExvfKWvnbpZlUNvTOc0HyCxygAtxsZNK+LcT3YP
         9Y7JZn+LLVjp/+HsO+HP33jO/+6RpRxj5zW4UR9t3Wq4xEK2scuUASqelmXJ6DdUSKtk
         GY38IQwFA9ApO/8YkXIMiCJXU2Y7xBWsyijJtmX33AZ6Si0MSRezzx7vzKSBdXmde6g8
         sFbKTJbXwtFGvtcnV0RbAxTCMvZySWMmjvWHDFeYrai6Xse+UOv9+rYuaccK+oABpvoV
         cdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnPnQgnleFTbv5UGiWBm81UkC1uTgFAUbSEsWQlixrTjHibu1FzWsx75T8pxMqBLDcn8D8l/3BoWlk7x8kI40voTKzGrmIuZI+w+XR1nxNWwREFA8FYh0cTrEoCseux8xN68WY6kdYJsDlXRCDOpQ=
X-Gm-Message-State: AOJu0YwZsQWQh8xGymeK6R5lPa2g9NjI4cnB44jiyWYPMZFB7PoRlkJN
	4JcYniec+GxcnrMaGMVKtscgSqFxJkEyQoDpqWgHED9YZ87qOXz4aRDb/8hS7Iv4iw==
X-Google-Smtp-Source: AGHT+IHo47sXEcO+vqJLfG+1w1TbKhf9Or+bZxpuVNdwtstFO91a3d11C4tzJ3XUdWYFjFRy4hPelA==
X-Received: by 2002:a81:4417:0:b0:607:82e9:17a8 with SMTP id r23-20020a814417000000b0060782e917a8mr2480467ywa.7.1708016044970;
        Thu, 15 Feb 2024 08:54:04 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id t197-20020a8183ce000000b005ff821bfdd3sm315175ywf.27.2024.02.15.08.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 08:54:04 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso1124005276.3;
        Thu, 15 Feb 2024 08:54:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7Eba0KUR4nWjsg33rEOCwNRZZSnz+qJAUgoToGMKUGbnt+1X0VEjr8B3ZIFtXxgLdUgNDmdhCsFirdZVrTZf+wGZzCC9rj/kFgFpQH9AeAjJHsa1ZNRK6EH6+nlvQ6O95PdrlC/ht/Md3uEdkRTs=
X-Received: by 2002:a0d:e8c9:0:b0:604:4498:34a0 with SMTP id
 r192-20020a0de8c9000000b00604449834a0mr2240802ywe.22.1708016044638; Thu, 15
 Feb 2024 08:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>
 <kycepdxukfsww3tnxoo5hoiuo3vcgpqqmynokzhtl4vodgm6zc@ih4uhw7gz4jh>
In-Reply-To: <kycepdxukfsww3tnxoo5hoiuo3vcgpqqmynokzhtl4vodgm6zc@ih4uhw7gz4jh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 17:53:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVf7ophCwKt-n_N-LBHV4+t14Gjb4d1O0T8FDk_9xMFtA@mail.gmail.com>
Message-ID: <CAMuHMdVf7ophCwKt-n_N-LBHV4+t14Gjb4d1O0T8FDk_9xMFtA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To: Maxime Ripard <mripard@kernel.org>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sarah Walker <sarah.walker@imgtec.com>, Donald Robson <donald.robson@imgtec.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Nishanth Menon <nm@ti.com>, Adam Ford <aford173@gmail.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
> On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert Uytterhoeven wrote:
> > Using the Imagination Technologies PowerVR Series 6 GPU requires a
> > proprietary firmware image, which is currently only available for Texas
> > Instruments K3 AM62x SoCs.  Hence add a dependency on ARCH_K3, to
> > prevent asking the user about this driver when configuring a kernel
> > without Texas Instruments K3 Multicore SoC support.
>
> This wasn't making sense the first time you sent it, and now that commit
> log is just plain wrong. We have firmwares for the G6110, GX6250,
> GX6650, BXE-4-32, and BXS-4-64 models, which can be found on (at least)
> Renesas, Mediatek, Rockchip, TI and StarFive, so across three

I am so happy to be proven wrong!
Yeah, GX6650 is found on e.g. R-Car H3, and GX6250 on e.g. R-Car M3-W.

> architectures and 5 platforms. In two months.

That sounds like great progress, thanks a lot!

Where can I find these firmwares? Linux-firmware[1] seems to lack all
but the original K3 AM62x one.

Thanks again!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware=
git/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

