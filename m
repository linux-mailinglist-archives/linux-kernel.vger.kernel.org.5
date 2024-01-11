Return-Path: <linux-kernel+bounces-23964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFF282B48C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BE1286694
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1DF537F5;
	Thu, 11 Jan 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="hMNIey/C"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04084537E3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbd6e377ceso4440993b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1704996697; x=1705601497; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNwfPpOc+w6+qUvr4c6LiIOhhkOq06R1P3AdfBXYN2Y=;
        b=hMNIey/CDK5B1EZAQ4GoR07e+qaSHxxOjE9KrmmBxnaR4QOZQ9Kd35Dn2eDO89EZqh
         QaGA+4CCPjgBo3um5DKZJYxVoDOdlBI2GOTewycQeS4s9/vkvcpXH+QWc3k11qWFL3Im
         8BXZoCPNM3xfc+W9YepgkdAAm+OBCeNconj2yf6qT3vZZA3ZuwnHBqR4Kpi+poKr3ymN
         /DIWKB1XAoBP0qjKI8QRyGhZkAOoVlsbt37kwLE5Fqc0eJxd0HPPb22TGWPmfAr7U9wf
         h0pcdoH2LJqXMkiNOV9+ynzjpxMzaerQF7Yq3IXlAxiX0GPpgxJH2UnyR/yfQp10k44+
         fvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704996697; x=1705601497;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNwfPpOc+w6+qUvr4c6LiIOhhkOq06R1P3AdfBXYN2Y=;
        b=j/kqxRqnLWugxeH/xmvgG9vxqlFFBTT2C6grgofEr6/diyy+uk74QoX6nd1MnsO0vW
         fggCDbk7TEI0gB+GYXvIdBPhWXIt8glcdVbdBJFohZHelWwHQgSk7LODr0EHqTaLHfVY
         USaZHvHzEFWHtj2mSSVJNfBt7cQBC7vG6fjcqdeWQAK6g9z31niea15pTBZUTVOsgoy8
         HesuzyRd/K3qlgj/is/Ys758SK5QpsC6qFrYU9HFRedHhxon9ViErWy8vCoTOxSBVRPy
         mZ7YZ2U82SezNfOaLHqNEKKvPkNFs+vNCzApTppyuvqD4F4wKPJQdzCvH3E8X5uATD+k
         O29Q==
X-Gm-Message-State: AOJu0YyNfmmkix+1lx8UGujHdY1+6f8jR8PPA9XXotR0233gzmjxXOKg
	UVP/tydu1gyPc+L4usiMlYNb77yrrr6aUe5Uq/xMktkuf2Q/fw==
X-Google-Smtp-Source: AGHT+IEOQA3VGINqdDq3XtCaDe7x77fu7+Iwu6ym4ijoXArXnWe9XYkfG56HHC5HEq3XFTuTf4bmEuP1OyFcAzpA/9w=
X-Received: by 2002:a05:6808:3989:b0:3bd:5006:e313 with SMTP id
 gq9-20020a056808398900b003bd5006e313mr78961oib.105.1704996696986; Thu, 11 Jan
 2024 10:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220121110.1441160-1-vignesh.raman@collabora.com>
 <CAPj87rOMPioOK0r74vcnVkXusm6Nah6KNUWyxYgpVLdkMNtW2g@mail.gmail.com> <ad7cbd59-5264-96e8-5e9b-aafde8028e41@collabora.com>
In-Reply-To: <ad7cbd59-5264-96e8-5e9b-aafde8028e41@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 11 Jan 2024 18:11:25 +0000
Message-ID: <CAPj87rPRRfJmxTev50YqxBizyvzCUhCiymoV_bdqsZ-zvcREfA@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] drm/ci: Add support for GPU and display testing
To: Helen Koike <helen.koike@collabora.com>, Dave Airlie <airlied@gmail.com>, 
	Sima Vetter <daniel@ffwll.ch>, Daniel Stone <daniels@collabora.com>, Emma Anholt <emma@anholt.net>, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	David Heidelberg <david.heidelberg@collabora.com>, Rob Clark <robdclark@gmail.com>, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Wed, 10 Jan 2024 at 10:47, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> On 09/01/24 19:08, Daniel Stone wrote:
> > A better sequencing would be something like:
> >    1. add ANX7625 config
> >    2. refactor _existing_ MTK display jobs to use YAML includes, change
> > the existing job name, and rename the existing xfail set, remove
> > IGT_FORCE_DRIVER from the script since it's now set by the job
> >    3. add MTK Panfrost+PVR GPU jobs with new xfails, add xfail entry to
> > MAINTAINERS
> >    4+5: same as 2+3 but for Amlogic
> >    6+7: same as 2+3 but for Rockchip
> >
> > Then the separate rename/update xfail commits just disappear, as does
> > the removal of IGT_FORCE_DRIVER, because it's just done incrementally
> > as part of the commits which change the related functionality. It's
> > extremely important that every change can work standalone, instead of
> > introducing intermediate breakage which is only fixed in later commits
> > in the series.
>
> Thank you for reviewing the patches. I agree, will follow this sequence
> and send a v2 version.

Alongside Rob's patch to add msm-specific tests to the runlist, we'd
need to add the Panfrost-specific tests. Whilst we're here, we might
as well add the vc4/v3d/etnaviv/lima tests so they can use it in
future.

Panfrost should also skip kms_.* tests - since it's not a KMS driver,
it can't run the KMS tests, so there's no point in trying.

Cheers,
Daniel

