Return-Path: <linux-kernel+bounces-67178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C43856790
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC4F1F21CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11107133409;
	Thu, 15 Feb 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1Fy2Kz1"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C617132C15;
	Thu, 15 Feb 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010949; cv=none; b=olcSd45Yt2ajytCIACRaNG2rGo7ux6+wEj0tDVXU+uLzZn3vEwoHWnNphRMOmzCBHfHJqwczyXJZwVYK17TV7J5toBnoVVkpu5o/vLenNAK5mbYmWvYMjKGv/J8QBPjnGRY8gTX80FHrzd4A0l7evbNpjv3uZHihqVfOVkz3mPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010949; c=relaxed/simple;
	bh=1Yca3/8c2xie8UJK6ywYfGd+r2rXm8TVWt1OEqGCrEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qg7J++cQq6EkoLc6Wm7x2p7/D5EOPAVvulhtHlsAuE5M3UNmZrHuU+zTzcHV1QmkSMX8qj49WgzAQ87Jn8zFeVlh4V1fUK7URT85L+wHpnHCmCXKanthRrAYcjEaUh7/sE6VnvxAMW5pKPGPG3B8k3FOzLA882QiHBQmzs5oh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1Fy2Kz1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so1365134a12.1;
        Thu, 15 Feb 2024 07:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708010945; x=1708615745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eDYN5/Ne/bAkeG8hRPbK0lvoczmiNehpS0h0H9vcz0=;
        b=A1Fy2Kz1qzY1HC3CA4Zo+/lVlLbTplx1X4kEWza8I5MYbX1Y9NknbyJ59cj9loxybU
         eE7yZf4zmtusf/wuMmZf6YbaWA/4QWyVzOyT1fxvZXyzGNQx/w263HJSAu+0LpBG2pL7
         yYnYy9cYVMHvSjsZV8l/Ku2+LBYMjYtZfDoA/9uPdPUvtkYXGRxToHirbe5b2n8BgpX1
         UxyEF7Mgq6MJsysLhKo/mR1iTnQi9dDymhqPHwgtjbIFgZTFFi7MzQwoidXfgzEwsIca
         NfWruZZyjPrHgCHtfBpCktGROFT4iFTXf8LUzzUhfa5Cd/Z62HasuTpP+aGMoWYCnLFE
         p67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708010946; x=1708615746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eDYN5/Ne/bAkeG8hRPbK0lvoczmiNehpS0h0H9vcz0=;
        b=P/2K5164f9qii29YwByN3C6/OFX5ph39OEIvk1MvWlJdKF2M/uQXtvntoUKruJfQOW
         Y8H3kbe6hcMjee39L/p/BYftlVN9fgc/b8jMYo3RVg4xTUImCzoDwXE3osgrYR+xcsus
         NAiGFbjv/bNekDptx4Y4xqHkWnnApnRAtrUFwv9dFkkZfk3Mj4ZfVcd7OjQI1YM3ELt8
         KAKgN2ic2Q3J5gHmIHV52scVoUSp8XTWTw0QPX1PTC5IXfj8Hg3ZWc2/cQiO1F5295k1
         vbS9P5DhlmiUQ2HT5Tf6w7uXswsdGsbpLNIJdEIFfQo6lcSfNO0yw1YsyCB7Z1qy16CV
         LRNA==
X-Forwarded-Encrypted: i=1; AJvYcCWBDsxB2fCbjxCxTB2+vS3Ro7Xqn0NPo7bLtcLa+VmaTbfHAdy3VH1Re9Ff1bva2CAfaiJd/gygkaJFGTkgu0ETv82UYle8dyaYf4Rsuaoz2Mb5ExamFHiHy4hYTVRCKaCPIPa1J+v+vfYz2w==
X-Gm-Message-State: AOJu0YwfRpS2vodVigCrsRIzccJVXx2D7cvDhhlH0aAMGE/Q3qtGxYYK
	PLqLYOB5gninZg3uK5U/bI42s9j/+qSXHhkj9lSB8XsVOVCIHR3vCziAlxTo50bk4l8OPpph06I
	Urj8oCoo/BluvNtFfg+cbXfU3p0GTmhQN
X-Google-Smtp-Source: AGHT+IH0wv6QwjXSBFTesR7kxTSlclEtl5Zu4zItum5ccGJ5rgl8x0VQTnJVRcQtudZnbwF7kmf2M8Qe9v3dKnp7o1E=
X-Received: by 2002:a50:ee89:0:b0:561:bcbc:7c96 with SMTP id
 f9-20020a50ee89000000b00561bcbc7c96mr1824864edr.31.1708010945460; Thu, 15 Feb
 2024 07:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213172340.228314-1-robdclark@gmail.com> <Zc2-qVd0gtErdbKe@hovoldconsulting.com>
In-Reply-To: <Zc2-qVd0gtErdbKe@hovoldconsulting.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 15 Feb 2024 07:28:53 -0800
Message-ID: <CAF6AEGsPojmqDgMZWrEAm_CoWGZ05euc0jzD5+9aX0cXQha_ew@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Wire up tlb ops
To: Johan Hovold <johan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	Robin Murphy <robin.murphy@arm.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Jordan Crouse <jordan@cosmicpenguin.net>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 11:34=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
>
> On Tue, Feb 13, 2024 at 09:23:40AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The brute force iommu_flush_iotlb_all() was good enough for unmap, but
> > in some cases a map operation could require removing a table pte entry
> > to replace with a block entry.  This also requires tlb invalidation.
> > Missing this was resulting an obscure iova fault on what should be a
> > valid buffer address.
> >
> > Thanks to Robin Murphy for helping me understand the cause of the fault=
.
> >
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Fixes: b145c6e65eb0 ("drm/msm: Add support to create a local pagetable"=
)
>
> Sounds like you're missing a
>
> Cc: stable@vger.kernel.org
>
> here? Or is there some reason not to backport this fix (to 5.9 and later
> kernels)?

No reason, I just expected the Fixes tag was sufficient

BR,
-R

> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Johan

