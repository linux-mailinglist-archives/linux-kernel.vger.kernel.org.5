Return-Path: <linux-kernel+bounces-73584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E785C485
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0792B227B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12041353F8;
	Tue, 20 Feb 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBGmZYnX"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641F763EB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456820; cv=none; b=TGjDLMxtBq63dgoUCP2mqZQburzZOiHJ6xARmiyAYXoA/QtzXraZIeQJs7qXja4fPsiA3BVPXSZWAXUiZ71km0rHRoZcp6vMOR+PkbUdaKFw9Y7b+2cyOa3fw9pgrQT4LcsM1GNRXD5+LF0hNZTMwa+ceTsHzTThV2wjIMwBBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456820; c=relaxed/simple;
	bh=W/w+tyzfA6D4Ho5vSBK7CegwettpL7LooQfkf1m9nk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkEhRgVWNnu6Oj9FK8PbL8ye65b4Wu0oD9Ngal6xmkWXjnUVDiO4harZmyhHqgGZdaUKr3gB1jjX2HqE/9Jpr64aVS2WHctgkjp7ovAU7/xZGxC31cG6FRgkIwC703K7ZF2blDZ2C0hzqdyYdQW3m7VwDqNsoMrIb5+R9AaUaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YBGmZYnX; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso5546214276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708456818; x=1709061618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJPwApU9XXgv92RddfdwNnrkCzlQ97sHtpLb8FJGPyE=;
        b=YBGmZYnXrwsVmNl5qpqMKYdZWyyoM1R82xOhLZAlxEeTgm1HsV62L9qsN75sSkz20R
         hvTxDuqmTKYLyFmHcUjyOSHv/cMzWPOWJmBhaj2OYvagoyUGBLIPl8f5Flgr0Q9N4gkH
         +iyRDLXaewohb1uInWiaOn2paE/ESDucoFGWpf3f0dsYVcnMSSEwsRgUaY7l+KZnXsry
         +uvU3NNkFFFWhUG5YYPWnTvfbXKOfrRWcKpIxkrVm3TTeAX6SleUDsHdzsOi0n2Fp6hV
         YE4Kv9DrQiB4DsUIrNwhiTcj/ZMUNQphRR1R0KcTbLnGTG5nnODHNRsOTWLpSERccPtV
         WNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456818; x=1709061618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJPwApU9XXgv92RddfdwNnrkCzlQ97sHtpLb8FJGPyE=;
        b=KsX4WZ3G8E6aQn9zNl3swX5kd6oDaFjTaZ3NFc5Eq8VfDqyPygp9vcGuutjiQ2JyZv
         Zn/A/ITfEKHpTkmI2p27wTqeSXO3iFZU1sb1LILsZpjEJEBjUnbxh+JYgJCkEewc19gN
         8LXBk4wsgsaQaRzCcinOFr10DwVzaAD8ywoBwQETyL7GhBTzWiid37g0pZiST9/Hpo2+
         8CyhJRu4nsxwTVM/rXfJnCsSMgxlFssD654dc/TeE1WbJYjzuE1CuyHxug+wq8m75gSs
         JsilxuzmwZwqJafFmwQ9WjthAQoLYDPx5IfrnMnFZxMGedJqakl9FFS2BGgDjJe2j++7
         rAuA==
X-Forwarded-Encrypted: i=1; AJvYcCWwYRbuf/0wmkwnl2LRbh0y9b1dIbV1mRTKYMYR8h1zVQkwiJtr7kpzJKZmnc31mSItLAYZOj2jvXLOZzq+GcjP53mHW4E8fddj/42a
X-Gm-Message-State: AOJu0YzMwMYVROdQXeh20ZNeie09kNskxeDeIyKAYisp34nMaLKaAta2
	QPdUEB2eFhVzv5M3gh///RpESkQLQogEd6Sa09cNJP5uldC1pRsKLEnw1XClvHbdZLccYbRyy7U
	1uS0CNm24cK+yF7y9I8XpT91N+tMVmGkbEyQCGg==
X-Google-Smtp-Source: AGHT+IEX8MB1nSQa5VpR8vJoxH2b5PfHyVyzVIBSZF2rtV4Pc7Ci0BkpAzatQu7sQcW34YdMBldvJ8Fd82tHXTI79J4=
X-Received: by 2002:a25:aacb:0:b0:dcc:9e88:b15 with SMTP id
 t69-20020a25aacb000000b00dcc9e880b15mr14917577ybi.41.1708456817505; Tue, 20
 Feb 2024 11:20:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215190834.3222812-1-quic_abhinavk@quicinc.com>
 <CAA8EJppQquHgSgCrxKZHPHk248Pxg7Q8mvmmjbcpUxpreQkcuA@mail.gmail.com>
 <d3674c10-5c29-d917-44f5-758d90d9e679@quicinc.com> <CAA8EJpqaG+fBA_FO-L7Bimtjqqg3ZDQtyJL0oPFEueb-1WxjUw@mail.gmail.com>
In-Reply-To: <CAA8EJpqaG+fBA_FO-L7Bimtjqqg3ZDQtyJL0oPFEueb-1WxjUw@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 21:20:06 +0200
Message-ID: <CAA8EJpoeb63QRddxawm2J0s8O0XrLQBrDuYXOB=ZtzDG7mu2PQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, robdclark@gmail.com, 
	freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	ville.syrjala@linux.intel.com, quic_jesszhan@quicinc.com, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 21:05, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 20 Feb 2024 at 20:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >
> >
> >
> > On 2/20/2024 10:49 AM, Dmitry Baryshkov wrote:
> > > On Thu, 15 Feb 2024 at 21:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > >>
> > >> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
> > >> Lets move this to drm_dp_helper to achieve this.
> > >>
> > >> changes in v2:
> > >>          - rebased on top of drm-tip
> > >>
> > >> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >
> > > v1 had an explicit comment before the ack:
> > >
> >
> > Yes, I remember the comment. I did not make any changes to v2 other than
> > just rebasing it on drm-tip to get the ack from i915 folks.
> >
> > >>     From my side, with the promise of the size fixup.
> > >
> > > However I observe neither a second patch removing the size argument
> > > nor it being dropped as a part of this patch.
> > >
> >
> > Yes, now that in v2 we got the ack for this patch, I can spin a v3 with
> > the addition of the next patch to remove the size OR as another series
> > so as to not block the main series which needs this patch.
> >
> > I would prefer the latter.
>
> It doesn't work this way. The comment should have been fixed for v2.

This probably deserves some explanation. Currently there is only one
user of this function. So it is easy to fix it. Once there are several
users, you have to fix all of them at the same time, patching
different drm subtrees. That complicates the life of maintainers.

-- 
With best wishes
Dmitry

