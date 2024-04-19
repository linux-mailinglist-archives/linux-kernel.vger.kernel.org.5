Return-Path: <linux-kernel+bounces-152015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3268AB762
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E82DB2165A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86513D639;
	Fri, 19 Apr 2024 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ve1zoOjS"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD813D60C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713567564; cv=none; b=adKtElXJBT8YteKbRrT/pfNxZ1R1Ik/h5k6xjAuBEr+Ny7P/pHJbJ17OrcMk9oLYiCWR6floO4D9PM3NEiBqXiuOIsM0wK5nmtTO6kJIpVfGUgvo2m7RhgBuEmYtKFmZlFbywJODkvXqGqiA81nEIKs/++Ij4cJVaM7PN9OttJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713567564; c=relaxed/simple;
	bh=dq66rNJndbQc60lsm/BjaeR3uKnAGkQCnG7ybzMIKnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHSdY4SiTDK3U5nZzLG4OA3cVcFrsmsYFpY98O7ZilREcOmoZJmTSm67JIvQbdfiqhsch2CoExh81WjMLjnkGSX4C1b+/sesK6Mr+yh4kJxIc1B2/YKoq5qYNMQjxtAg6tMn0AhHgAZhwyskIA0RuWBECbxwmDkl2b9tYFILM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ve1zoOjS; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516db2214e6so3392959e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713567559; x=1714172359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/pykJ+iNZaZvxsy5yVJ+QnkNtTRNc8ccYnjEfcauKg=;
        b=Ve1zoOjSG3xxakg5n72/UVdaXqdwP/tkldZ8KXQqaRdFWEba+Qv990rwKcTqst1Vi0
         fSOV4RiX+nixGdu3VrVZC55daDW/HSv7rwz5nJg8eZI8r7q5aa/B4xoICw9xmQLT6rRG
         /SPWrX1duZIjJaIBNq6Sasge0M7MJZkDFEg6fRQRlXIrrlvdASlzkeSxLqHqCcbLN9d/
         B8vSFC7vHBpG6s6bDGUT6BRl2PFngxEzRcDikBiQwCIYEnEwIbDd1M6pK6d39s04Fgce
         gxvd/vhNZPkouL2ojaxVkpFuW/ZWb0jW4jR7bTl7DRBZNLumNZwSEFsjoXzfZ3x5vCZu
         kfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713567559; x=1714172359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/pykJ+iNZaZvxsy5yVJ+QnkNtTRNc8ccYnjEfcauKg=;
        b=gdntl0wkhvRTwUxK6YfCt1XCwQa9YZhzRHCZaKqg7+uKWxJ33+D36u4auGrTRg7bQq
         8LbgC1PNQn+Uc1YYAH1306fU14qQIaOH70QceqRhzI22VPwzIChtEl2tQV3LrIQdC5w/
         MII+umsLPXoiwZR3aPHU4Q0dqhqzSkXyX2bZpGfqhcHQDr4OBwu8ZH0evdVcW3n9hipe
         LftqfhEt0F39wSm0vR1pMm7SjnsL3Jlofa+g6ALMaAlSGiCYxnvCvj2rsqrc6kfGNu9w
         qgsUhSgBP9RQPiwv1zglb0B5TMcGosarpVqZk40i4o6ff5ZWGehAm/Y/mn5YDaEouacw
         ItWw==
X-Forwarded-Encrypted: i=1; AJvYcCWgmZWEdc8rL3O7Ou1j7IleQIh78k5q7M2okoQWbYOJBft2YKdC4F0OiXCFPXHspmT3FVBc0Z68Z/8H6Z+W6muosDYBQTbHBriC9bcw
X-Gm-Message-State: AOJu0Yxcq1UqJvDAPT+xOexIdaWcr6suU0rZr7qdvduHuosAvONkbDJT
	8HDMIQiv6TPPBoxgmMUDgy7TNwEiWs3c3S8NyEpz2G+FRbQtLOmuK63cdpiG0zU=
X-Google-Smtp-Source: AGHT+IESWYEtVXjigtQ0L5bOUF7zr3weAYEinceRJ7EB6HeSNIHj7J9wJmp0cfKzhv8mnoUheJDP1A==
X-Received: by 2002:ac2:58cd:0:b0:51a:bdd6:e718 with SMTP id u13-20020ac258cd000000b0051abdd6e718mr1877655lfo.31.1713567559098;
        Fri, 19 Apr 2024 15:59:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id s6-20020a197706000000b00518d7c38cb9sm913814lfc.284.2024.04.19.15.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 15:59:18 -0700 (PDT)
Date: Sat, 20 Apr 2024 01:59:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Archit Taneja <architt@codeaurora.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Vinod Koul <vkoul@kernel.org>, 
	Sravanthi Kollukuduru <skolluku@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jordan Crouse <jordan@cosmicpenguin.net>, Rajesh Yadav <ryadav@codeaurora.org>, 
	Jeykumar Sankaran <jsanka@codeaurora.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>
Subject: Re: [PATCH 2/7] drm/msm/dsi: Pass bonded-DSI hdisplay/2 to DSC
 timing configuration
Message-ID: <omnlm4e6yq5u2iurxld5gwo7rma4jpfmmhvpzsddjz5aensumc@ffsolnsblmyx>
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
 <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-2-78ae3ee9a697@somainline.org>
 <CAA8EJpq-1QwoM2hEyegpfKnVH+qrswjmTd_hpYs9d9B7gikHjg@mail.gmail.com>
 <7fqwkryeumkt7zxsec6va7ys22nfs3tr4rrcz323extdz3f6zv@w4uu2lk4uh7v>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fqwkryeumkt7zxsec6va7ys22nfs3tr4rrcz323extdz3f6zv@w4uu2lk4uh7v>

On Sat, Apr 20, 2024 at 12:18:39AM +0200, Marijn Suijten wrote:
> On 2024-04-17 14:58:25, Dmitry Baryshkov wrote:
> > On Wed, 17 Apr 2024 at 02:57, Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > >
> > > When configuring the timing of DSI hosts (interfaces) in
> > > dsi_timing_setup() all values written to registers are taking bonded
> > > DSI into account by dividing the original mode width by 2 (half the
> > > data is sent over each of the two DSI hosts), but the full width
> > > instead of the interface width is passed as hdisplay parameter to
> > > dsi_update_dsc_timing().
> > >
> > > Currently only msm_dsc_get_slices_per_intf() is called within
> > > dsi_update_dsc_timing() with the `hdisplay` argument which clearly
> > > documents that it wants the width of a single interface (which, again,
> > > in bonded DSI mode is half the total width of the mode).  Thus pass the
> > > bonded-mode-adjusted hdisplay parameter into dsi_update_dsc_timing()
> > > otherwise all values written to registers by this function (i.e. the
> > > number of slices per interface or packet, and derived from this the EOL
> > > byte number) are twice too large.
> > >
> > > Inversely the panel driver is expected to only set the slice width and
> > > number of slices for half the panel, i.e. what will be sent by each
> > > host individually, rather than fixing that up like hdisplay here.
> > >
> > > Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > ---
> > >  drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Thanks, it seems this patch has already been picked up for 6.10 [1] to test at
> least, but I'd advise you to drop it until I resend it in v2, as it no longer
> performs as written in the title.

Ok, dropping.

> 
> When I wrote this patch in in June 2023, commit efcbd6f9cdeb ("drm/msm/
> dsi: Enable widebus for DSI") from August 2023 wasn't there yet.  That patch
> updates hdisplay (because it is unused after that point) with the number
> of compressed bytes to be sent over each interface, which is effectively
> hdisplay (based on slice_count * slice_width, so as explained in the commit
> message that corresponds to half the panel width), divided by a compression
> ratio of 3 or 6 depending on widebus, thus passing a way too low value into
> dsi_update_dsc_timing().
> 
> As a result this patch regresses the DSC panel on my SM8150 Sony Xperia 1, and
> likely also explains why it was quite hard to get the porches "just right" on
> the Xperia 1 III with its dual-DSI dual-DSC 4k@120Hz panel (that these patches
> are specifically for).
> 
> I'm still thinking of how to best fix that: probably introducing a new separate
> local variable, though dsi_update_dsc_timing() only uses it to calculate
> the number of slices per interface, which again as written in the commit
> description, is currently required to already be for one interface (in other
> words, the Xperia 1 with only a single intf sets slice_count=2, but the Xperia 1
> III with 2 bonded DSI interfaces sets slice_count=1).  Which means that this is
> always equivalent to slice_per_intf = dsc->slice_count.
> 
> Let me know which approach is preferred.
> 
> - Marijn
> 
> [1]: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/110

-- 
With best wishes
Dmitry

