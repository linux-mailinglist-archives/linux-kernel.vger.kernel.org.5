Return-Path: <linux-kernel+bounces-69773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D5E858E50
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412EFB21B14
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D841D55E;
	Sat, 17 Feb 2024 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pbl9lNnH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E61D527;
	Sat, 17 Feb 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708161574; cv=none; b=hcA2TDAVRQjHc4KKyv/ujVUEJYAj2Y90/yjNXaDjGN/jA6K9rmz/gDPZfFNdDUsvHbFHaQhumUZbyqLn4m9VV3XpYc79RI9rk9h576Xxa7kedlXPV0jSU6+XTLfPQfAmjsg0BVtAQPNeTXhAtdqHsxEF0o93gtzGQQnbR8ntSbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708161574; c=relaxed/simple;
	bh=pgy9PZf2TrTJH8JzAKg5bYc1IgeALENUoKus/Rm1fPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7TEBs+Fxz/XxXq11xu26NEhemzwb6T+0w5deNLfh/lZePISmX5vRyO12RE76pKatEgZuoAAMPL8GrgX9wi3BPVDANj3M5vzrgUY2IFaPul818mBD3UzI5t9awH9aXcZWeG7Ts+lzQzJXc+6Bg0r5rzBZvuBzVEUCaEhfjK0iIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pbl9lNnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AB6C43394;
	Sat, 17 Feb 2024 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708161574;
	bh=pgy9PZf2TrTJH8JzAKg5bYc1IgeALENUoKus/Rm1fPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pbl9lNnHpdpFX2TW4fgOzjg3JXeVhdRlOHllKDzuKcoIPNwZzS21k9iTYW0rRAyEH
	 ZtEaY5ar901iL89nMW8RaiZ+GgsE910tLGb2hA+Ei81ZOvS1ZKWIFKw0kKa47i8LyW
	 P4+2kovNsoWlbtBLYj7xegk8Ss8517IEc1zMQySFQhSQN4fhL0ATaebSnRgIWK91Cq
	 7pj1uqQ+Z4z9jasKp/TZ+sjT1JtAHv755gwest6WfAMs/vjK/KVqKHbAviV86g9Ioi
	 sGFUFoMTK/s5NQYjYafkJeWlbu29F/woOJBITsfDNMMwesyghARQt4IvtvYqhfql4v
	 y96XQjq96Eo+w==
Date: Sat, 17 Feb 2024 10:19:26 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
 m.szyprowski@samsung.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v12 08/15] media: uapi: Define audio sample format
 fourcc type
Message-ID: <20240217101926.3f1d2452@coco.lan>
In-Reply-To: <1705581128-4604-9-git-send-email-shengjiu.wang@nxp.com>
References: <1705581128-4604-1-git-send-email-shengjiu.wang@nxp.com>
	<1705581128-4604-9-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 18 Jan 2024 20:32:01 +0800
Shengjiu Wang <shengjiu.wang@nxp.com> escreveu:

> The audio sample format definition is from alsa,
> the header file is include/uapi/sound/asound.h, but
> don't include this header file directly, because in
> user space, there is another copy in alsa-lib.
> There will be conflict in userspace for include
> videodev2.h & asound.h and asoundlib.h
> 
> Here still use the fourcc format.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-audio.rst  | 87 +++++++++++++++++++
>  .../userspace-api/media/v4l/pixfmt.rst        |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          | 13 +++
>  include/uapi/linux/videodev2.h                | 23 +++++
>  4 files changed, 124 insertions(+)
>  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-audio.rst b/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> new file mode 100644
> index 000000000000..04b4a7fbd8f4
> --- /dev/null
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> @@ -0,0 +1,87 @@
> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> +
> +.. _pixfmt-audio:
> +
> +*************
> +Audio Formats
> +*************
> +
> +These formats are used for :ref:`audiomem2mem` interface only.
> +
> +.. tabularcolumns:: |p{5.8cm}|p{1.2cm}|p{10.3cm}|
> +
> +.. cssclass:: longtable
> +
> +.. flat-table:: Audio Format
> +    :header-rows:  1
> +    :stub-columns: 0
> +    :widths:       3 1 4
> +
> +    * - Identifier
> +      - Code
> +      - Details
> +    * .. _V4L2-AUDIO-FMT-S8:
> +
> +      - ``V4L2_AUDIO_FMT_S8``
> +      - 'S8'
> +      - Corresponds to SNDRV_PCM_FORMAT_S8 in ALSA
> +    * .. _V4L2-AUDIO-FMT-S16-LE:

Hmm... why can't we just use SNDRV_*_FORMAT_*? Those are already part of
an uAPI header. No need to add any abstraction here and/or redefine
what is there already at include/uapi/sound/asound.h.

Thanks,
Mauro

