Return-Path: <linux-kernel+bounces-29642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F607831131
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371231F220C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF976124;
	Thu, 18 Jan 2024 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+e8rjyb"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997C6103
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543288; cv=none; b=ZJhoid9IPdhULO+jhDJqT3d5LiN6862zVrlwNS94IfZGVKbPVlSFf9uiUl2B4AylTkKJu0mphQ95HrrICCRqtBGCQSH68/alyiiHRdsccY78S9iJ5zpDMrho+clxnuhc34cvm4IWTccQ0HgV7ilM86OaqPmvyPyoB+7xDj1d2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543288; c=relaxed/simple;
	bh=jkCkol1LlDXcUxYD3N30HrZmE5VGDqsrqmgYaP0Kpj4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=jM17LPZRMVgHWzm2HdJnMRr2mO6w/uUY3vYJLcLuCTKYRu8ZkWMacrcRdTbSf90WB86NuA3c3a+RWg0SoQKtM24gt6hnFpFsqv1zJ7Xaoc702eFX7qvTCQneapHeMDs8s0xB42z38ZI7JTLKdGygbRQDksnTdshv0gHbRiQeoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+e8rjyb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-559533e2503so4441229a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705543285; x=1706148085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+ORuyfvKPKlivBCBwrn1aG4zMB6FM+NFT/lRf60y+w=;
        b=M+e8rjybG2H1uwfwuZvoOWWYiV1qRtQ1FS4odCj8S077sn+0Qx1plHS64FDdAEqoe6
         iZQbVSQPBX0hAo/MMQVXGB5tEc7xwfH40W6pNDVhfPrfAv25pQJZaH0VhfosEVnYIJOR
         AVc2NQyp4fVCmow4Ht8JVQ/S43YxCVlGtDKwYHNP4aVwn/AdSElnpELp45aLKrriuLGj
         gs3n/gZ4WkE/8b/BVNocZ7oKyoqfHLkNk+NfS8+sZlWgmypvX8ITpC93utkrUQemSqNR
         ZnowpEoF01NBU7NiHBqIna0eyZUE5qukGXO6beleTVlyy7vWLZXQ57E04IPF1W53Lqf6
         TN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705543285; x=1706148085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+ORuyfvKPKlivBCBwrn1aG4zMB6FM+NFT/lRf60y+w=;
        b=gRNjaXSQGTHa2oQ8tiCcuuVJVmVVxEzacMXMvBNC4mDtFkH2yQTSZShL1fa900Wk+H
         4+6+vgeBJhEFJ9j9jsb9jyJeX7BWRjCp/iRKASueRZXThD/zGeB/ytwie46nfnl4DRtH
         DEOOZFndWCDhyuTp397O7Aq1jCokkFk2Z3E3pgPEl1smb4lA2RhaskfMyFEVahttmVhe
         CbfiQbALlP7gniuOtdehwlWsprOgxM93T7cuTtq7o8ajt+hy7Gvwj61zdO+UNv6JT1It
         Ffn7nrhYqcjjZZaCk8cj6tO2xdYEo7rMVE8UUUGtBDmeKgFTkl8/Qew0wGYdgJv/T9ET
         FRtQ==
X-Gm-Message-State: AOJu0Yx8vQ9a+lPjwXD0o5pyDskeK6bC50KRf6CUosvXUAAAgpDewqFk
	j2sJvBz4OWMbk0W9adNBwvjgfDWZFi2BVs9c+3F8BDfPYIyWRg9BPHggG8NpUChORvDmCqIzcL3
	IP+eYok6NqXgorLeJuAZNY2CW1Zg=
X-Google-Smtp-Source: AGHT+IFMLQzKS1z+NdIXFGvpFMPMfnfLjyk/zsZHuQ0OYD6RNNRTTG/elCwMSGh3SYfO3ZRlEQK10xOOeARR4/IibAc=
X-Received: by 2002:a17:906:1653:b0:a28:ff59:12eb with SMTP id
 n19-20020a170906165300b00a28ff5912ebmr36518ejd.139.1705543285151; Wed, 17 Jan
 2024 18:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-4-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-4-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Thu, 18 Jan 2024 10:01:13 +0800
Message-ID: <CAKGbVbt_1SUmTftqA5H27keCeH+u2ibrevy=cW8KsJSHu8YRdw@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] drm/lima: set bus_stop bit before hard reset
To: Erico Nunes <nunes.erico@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	anarsoul@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Do we need same for GP?

Regards,
Qiang

On Wed, Jan 17, 2024 at 11:12=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com=
> wrote:
>
> This is required for reliable hard resets. Otherwise, doing a hard reset
> while a task is still running (such as a task which is being stopped by
> the drm_sched timeout handler) may result in random mmu write timeouts
> or lockups which cause the entire gpu to hang.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_pp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_p=
p.c
> index a8f8f63b8295..ac097dd75072 100644
> --- a/drivers/gpu/drm/lima/lima_pp.c
> +++ b/drivers/gpu/drm/lima/lima_pp.c
> @@ -168,6 +168,11 @@ static void lima_pp_write_frame(struct lima_ip *ip, =
u32 *frame, u32 *wb)
>         }
>  }
>
> +static int lima_pp_bus_stop_poll(struct lima_ip *ip)
> +{
> +       return !!(pp_read(LIMA_PP_STATUS) & LIMA_PP_STATUS_BUS_STOPPED);
> +}
> +
>  static int lima_pp_hard_reset_poll(struct lima_ip *ip)
>  {
>         pp_write(LIMA_PP_PERF_CNT_0_LIMIT, 0xC01A0000);
> @@ -181,6 +186,14 @@ static int lima_pp_hard_reset(struct lima_ip *ip)
>
>         pp_write(LIMA_PP_PERF_CNT_0_LIMIT, 0xC0FFE000);
>         pp_write(LIMA_PP_INT_MASK, 0);
> +
> +       pp_write(LIMA_PP_CTRL, LIMA_PP_CTRL_STOP_BUS);
> +       ret =3D lima_poll_timeout(ip, lima_pp_bus_stop_poll, 10, 100);
> +       if (ret) {
> +               dev_err(dev->dev, "pp %s bus stop timeout\n", lima_ip_nam=
e(ip));
> +               return ret;
> +       }
> +
>         pp_write(LIMA_PP_CTRL, LIMA_PP_CTRL_FORCE_RESET);
>         ret =3D lima_poll_timeout(ip, lima_pp_hard_reset_poll, 10, 100);
>         if (ret) {
> --
> 2.43.0
>

