Return-Path: <linux-kernel+bounces-167326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D18BA7EE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0B71F21E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F84147C6A;
	Fri,  3 May 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXOkw9CO"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ECB13959B;
	Fri,  3 May 2024 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721949; cv=none; b=rUxyk6km67/5TUG0UxL/HZ0nA6MdNODRYi19jfbT67R9B55a16JHmomews9FeicoAmLwKgxcoM7UJNIsOo9H/TwDjn+yG2j38yarVwvu5dgmV251hxpcRF+tXWvAwMU+ZebVMuPsmfmZDrTOVAaCtwKYikrrOZVhKnwEyQkE3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721949; c=relaxed/simple;
	bh=phooMRarU/0xrivjAwCBcwnpeJiTRTePATT7ls23gHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=danJ/ES8E1sMh/BfhRtC/fVZK1udAOF9njseWmfQCOJPrRRmxSsO5ISAuVP5dFyERBbQEwyA8hP7Fpi2o3TvcX72FGlytU5+9sZ0RRqC9hcziPh0ERpxWyOL3VtKrIeFGAvyQD5sSAVnHz/gdtmZ4WRpzxzVUC31BFvqVULVQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXOkw9CO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61e0f733e8aso17721257b3.0;
        Fri, 03 May 2024 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714721947; x=1715326747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPEvS0qK5UcK4PLaAgghQY6fqmdqWcs7u1b/vENJXdw=;
        b=LXOkw9COuzFSAkwzFcJsXsWO28zSFjfdNl6XVc3pPgL2Rg+vfJuFyTFq7yfhiCZj7T
         3HJgJp8t5oCYOkghfIGoMOJIX0+ohC6uGDRSbqdYDieEg2GVKMsTa72kMZ4ouC4LMhJj
         0ulF2iuN39pmtMfNANKNV5crWrbUo1pK/8eMmFQ9gYEj5ofQz67JN5xcarQFwia0i7JM
         0euBKQALCqxiltZx0BwWYoFdPQWulXJipSw6u9kcz67f3PwkxwYJQmqBoxJhIjxngCji
         rn001czXYF8rJJAqyP2rqCwP9tXzZukMsjoExy0mLq37YL6YnEE92nCqkF2sG/8sbvjA
         FP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721947; x=1715326747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPEvS0qK5UcK4PLaAgghQY6fqmdqWcs7u1b/vENJXdw=;
        b=JoVcDvFlispNq6ghK77VWDpBixoHyQC2eYCo9czbA6psUBdUmL5i3Amwvg9qId4xUB
         8KdA1csEC5NDpMO6sVi4lyGSzfi7PE+sNFPlxAKmVGYOAJnzDDtL5v8QU2VQUku5qgj7
         QY2zlLDFYhaGszxampH2RrcyV4uqrCgzO/v251YP35dGqQDLJpk9J/KeHLKYRP6yR/KT
         +oObtPg3QQON2iUtTlkIW3fXz7FG85byQ3/pxXHpKlxNdr/3KypUwzhh+bZ5P72UaCoF
         PBz2eoyBTyHR3yvlVolMc/nE99lHLzf3VPRkB9pzYL4O3Q8qAxpz6J23GGPgtQ623IXe
         +ppQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/kD0U0BOoJCszOMYFMER1q/I1Q6zbOg0zT6Sotgj7KNpe1RDcyorum9PGlLmy0S13MfUJVoebYY0gdzQFpNkWnUnXtNJ5AQ92F6vskcOfKRwagXMTFBO5pLlGRoke7uFh5IjmLccnM0vhn/h0
X-Gm-Message-State: AOJu0Yxf7NyKu1wNM6uxNxJoGBUCX2fdNQJGvNzL/rL69wFtPHuwLXmz
	iixj49k+yCs8ddvZR4i4+e0gHYqXEqGPnA8tg6fn2Pbgh6IavgljkiaAYnw0tEg4J6IZ/A254Wl
	Lbsv2DG9vDKScbWFA4QJuOMJXd08=
X-Google-Smtp-Source: AGHT+IGliypnZWfDbUdqOvUUIpgR2+a0zXwhwmSmDCfGwN97GTEOSPRd0xLYH1khdRiq550wJGDKrBovrHPT2uWWIAY=
X-Received: by 2002:a0d:dd88:0:b0:61b:33b6:41dd with SMTP id
 g130-20020a0ddd88000000b0061b33b641ddmr1739009ywe.37.1714721946830; Fri, 03
 May 2024 00:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314163511.2372458-1-colin.i.king@gmail.com>
In-Reply-To: <20240314163511.2372458-1-colin.i.king@gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Fri, 3 May 2024 09:38:55 +0200
Message-ID: <CAMeQTsZKk-af5xhnnb=PfHiCNWzBK7VnEc1iBevfYdnyxrXDfA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/gma500: Fix spelling mistake "patter" -> "pattern"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 5:35=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in a DRM_DEBUG_KMS message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to drm-misc-next

Thanks
Patrik

> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma5=
00/cdv_intel_dp.c
> index dd1eb7e9877d..cc2ed9b3fd2d 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -1547,7 +1547,7 @@ cdv_intel_dp_start_link_train(struct gma_encoder *e=
ncoder)
>         }
>
>         if (!clock_recovery) {
> -               DRM_DEBUG_KMS("failure in DP patter 1 training, train set=
 %x\n", intel_dp->train_set[0]);
> +               DRM_DEBUG_KMS("failure in DP pattern 1 training, train se=
t %x\n", intel_dp->train_set[0]);
>         }
>
>         intel_dp->DP =3D DP;
> --
> 2.39.2
>

