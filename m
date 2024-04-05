Return-Path: <linux-kernel+bounces-132432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCEF8994CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0171F296EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176D224DC;
	Fri,  5 Apr 2024 05:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHhjhBZz"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75975C138;
	Fri,  5 Apr 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712296152; cv=none; b=LOhjHVluNbprrAxennD93EQP2eCBvb1J8m44hOpB5287HtMZuHJnHujSAxMJfBHEuDg0KcCOPjlNH885Jt29Dcqf56+SY91M66nH6QmyFpE/RFFnm5V+hlKUW/iawPEiw1FifL1kXA29RaY6Zlx3z6NxX3A7woaVzXgtKht7/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712296152; c=relaxed/simple;
	bh=OEqCCkhLuYJwCv3umwicEBa6Ibh0azHwW7l5tIRmFNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyMRZSu+JUc/3PdNd7KfRqAGPODwZt5VH62RxjNAUaB5Ck9UAVOnh6r/yPbCq3mNhn05lmSbxYrbskecKWMyKY4K1q291cOTM17Xid8y3w6p2NCjBv7dFVHqYbryexZd7TS0lRvhWdqeAGTFW/tsdAvjlqp2hfOdPBk5GkYdP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHhjhBZz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4e62f3e63dso227798866b.0;
        Thu, 04 Apr 2024 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712296149; x=1712900949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZKOFz6ndGM4V5kyukstdMcEsPcO/J51RsMhMKg1OJo=;
        b=GHhjhBZzEwdC75Yc8unL0DipESmRO+HYZevc3A/s8E7b3uBxB7XyM4H3qN9gkN9ZR7
         Id7lPgK5byh3iFi39vgorbxDWwbEpaqFtb0ZdlXOTYR/r1JFSeIqmT6i50c0su8nUVc7
         e/CW4PwtOX0wPsf7sJcDjhb2O2Qvn7EN5GYIuIgp1lNkj6odK75DAptmQXIkE1G9rSCS
         Ui0Jze1/H+DbzN0lP2hxuO9++K7VdsTszcSkh6ou3pdLGknIP5LQjK0nhzGUm3DRv61I
         BppQHrNsENt5P4hNeEZjmxDhgdc8wSwxFHrxGazRjoSI+mU0hQ9U8cnVMeXlESOrAhTD
         wE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712296149; x=1712900949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZKOFz6ndGM4V5kyukstdMcEsPcO/J51RsMhMKg1OJo=;
        b=ot56QZS4+h1ZHauQdufpGPevbetDAVeNz6vZjgVDpgouzMOA1IGd3P4pOzHJHQseom
         iGLPtoEqyYRe4McQaDvF1ATytpAiCfmV62LdVEB2gt4irhYisbzJQFMtkJoT3hbXkW1u
         XRfR4NJIPZsZ7KTQyb0MfJE7b/YWBUbD9juY26xh7C3aV3r/N0Rm9GHVJpGRapbECLRT
         9oV/ORs2qoDngzxkD5U7Fyf23Wl++J+Ffnmr1dlpyY503f78/xRtXqM5PuWxmR7EWR9L
         TPCzhK7IlA8GcHOmZMv/qLk11G+hY2zSfa0yAcRq6uDEujbCRfrqQ28Tq26fBfL3/eB5
         pbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCfGVTfAIZaBDO9IgMII3neqkCdxQ1Eji+Ke2DEZan9AGnsu/XmAO5m1O5ZIeeEuza797GPo/jaIsSKKB0Ed/ysxnjLc4FqnAo+4rGWmkWhIpjW7qcRG+PggVDjTn40ihfEPv50xYYj4yg4w==
X-Gm-Message-State: AOJu0YzN0xEp/k7IwSPAupWMhuk9QIaLc72d+w8a7kc8zz8lCBa5xioN
	bI7RzfvwPytOBg3enOlEo6kkkYfzhw0ztMW2B8DR45tJ1fIMUAFiRB0dcrkfqoh8xdy9NjYjmfg
	3hLCrhEH9KmiBl/F2xbcF9ORCnPk=
X-Google-Smtp-Source: AGHT+IEHU8JkUqjrnhPwohYAWoxv8H66yzcJ9LBbvY+7XMSq/92aLDElEDpOiWktBF8uDc+wXmV650EDLIzDNqNXR3g=
X-Received: by 2002:a17:906:4e93:b0:a4e:757:989a with SMTP id
 v19-20020a1709064e9300b00a4e0757989amr230219eju.8.1712296148621; Thu, 04 Apr
 2024 22:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326212324.185832-1-ojeda@kernel.org> <da9dcd58-41c1-089c-2061-be3bad6349a7@quicinc.com>
In-Reply-To: <da9dcd58-41c1-089c-2061-be3bad6349a7@quicinc.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 5 Apr 2024 15:48:56 +1000
Message-ID: <CAPM=9tzDfZA6up+wY+OfBtfFRg0ffU4dm0ja33iCV6VVg_hq=w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix the `CRASHDUMP_READ` target of `a6xx_get_shader_block()`
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Daniel Vetter <daniel@ffwll.ch>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Mar 2024 at 04:39, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 3/26/2024 2:23 PM, Miguel Ojeda wrote:
> > Clang 14 in an (essentially) defconfig arm64 build for next-20240326
> > reports [1]:
> >
> >      drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error:
> >      variable 'out' set but not used [-Werror,-Wunused-but-set-variable]
> >
> > The variable `out` in these functions is meant to compute the `target` of
> > `CRASHDUMP_READ()`, but in this case only the initial value (`dumper->iova
> > + A6XX_CD_DATA_OFFSET`) was being passed.
> >
> > Thus use `out` as it was intended by Connor [2].
> >
> > There was an alternative patch at [3] that removed the variable
> > altogether, but that would only use the initial value.
> >
> > Fixes: 64d6255650d4 ("drm/msm: More fully implement devcoredump for a7xx")
> > Closes: https://lore.kernel.org/lkml/CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHEnc3qApu2Q@mail.gmail.com/ [1]
> > Link: https://lore.kernel.org/lkml/CACu1E7HhCKMJd6fixZSPiNAz6ekoZnkMTHTcLFVmbZ-9VoLxKg@mail.gmail.com/ [2]
> > Link: https://lore.kernel.org/lkml/20240307093727.1978126-1-colin.i.king@gmail.com/ [3]
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
>
>
> LGTM,
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

I'm seeing this on my drm-next tree, where is this fix landing?

Dave.

