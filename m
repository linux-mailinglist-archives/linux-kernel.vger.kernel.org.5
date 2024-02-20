Return-Path: <linux-kernel+bounces-73565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD885C444
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB72B22561
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6E612F5BF;
	Tue, 20 Feb 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrlKFqxu"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03B44C94
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455970; cv=none; b=m/PEW+EQz8HbN8g5gxexNQV+nIVHsKRuPRu34guirTgm7c8gXUZMsZyWECKXgELeiO4thtREVwbIO3LSlUHl7FnSXui6sdptJdhxRheanTjJYsKGqXpkDlmE2UNZikQJ/R5cl0M4PnhqAVnDvLkjsHTARGEdJl+25AFAjS/PoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455970; c=relaxed/simple;
	bh=NtN/27W5nKu3paKST0RdBM/OGFP8mhg1uFFj/t74hlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pedzd9qkrvKHOVQR8cajvMgcEcTLKaJ/L+OmWrDMwhoOyxbvDfWIjVUxJT9TGncYdWElWrnYQ1B9Vnwl5oSbdPYia7sjHf0tGykdZb0KbSmxHpsdS2Hd+3cjT9YjeYzQld+2R4A/6wM4DWwWsFaUqfgh33/6PtNZ3h8ggcQbSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VrlKFqxu; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607d9c4fa90so59460677b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708455968; x=1709060768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FqbWBojOxNxmodBmyheWK78bpyU1XZWA8MIuZ3ABrLU=;
        b=VrlKFqxuzNWYP1SoipzFFCh84W6nip87XXgls9xTEATBRkY3shrgTJ4d3Xk6/V/LbO
         7hXOC0ScgP70wcbtlEb4JQD5hNUp7GrQjRjv63jknHrciRlQFjky89Ro4moNVRLpUWYq
         mwqTknSmGIgYT8SlOf7TMPv7RsVeF9I00QGJlhIUa/SnqYSFZ+ha/ScZfMhcWrB4UVGw
         jCEuOa76nUa0UPbcMzXo3mx5J2LH/SVrE0W5VDG38ekskTgulOkz4Fe8UOVujlRxvqgv
         ZVFqyLhQOf963EhcV5bm+i159A2VVwDkul4tBa6DDw9cjdZnlaZc8f01sl2sKN8oqFdm
         G1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708455968; x=1709060768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqbWBojOxNxmodBmyheWK78bpyU1XZWA8MIuZ3ABrLU=;
        b=jha/HLhnnuYEHFor74u/a+EamtndVDU8UJN+weVfcN/gGeI29JWIqEiP1ygL1/tLxm
         SNq1NZaO9OAhTdbPpeADc5UlMM5YnBPe+Twek4IlNnbQHknni6EWvsZ5qsoMquHTuENa
         4neoMo0q5XFf0MeyDie16qgIhU8RDVkRjtLjjv4DZdiD+VgV96i+KYhSD0SdYy7Vgjpd
         K8f3yQHsbpBdkd7CW/kSYmvtLT4sbGjj7CpjjOcoDoG14p3QBB/t4akJVG6kcV/HFYvN
         KnkmcAWS+RCIS3kFq9BCI31EeCi/NKLtj2xv+KjwcoLjl8p0DSrv64VcSkc9UfCmHYPy
         V01g==
X-Forwarded-Encrypted: i=1; AJvYcCUtRprmZ/9REf625gRGe4qjKZRFKxWsW7Aqq4oqc8me49LZXImCEbhGqUMvGBtHGoBd6moQFbBaFknAkRhgwfXaiKOlcQMoCZ0mGZ+I
X-Gm-Message-State: AOJu0YwJ/nR/joZENIBlJagV/dKfBKvCRowKXneY3N3Nar9puw/MH/rA
	A2ejV7UQKXH0/llkF+I+yNi5AGh0Ni6EZcEcu+4JCi65j3x+LzUMyCpoBOTGzGyPPVYbiL86wIN
	ASPpuEMJLdISZO07QXuPe4LUkUHeCZfqfCqbAIA==
X-Google-Smtp-Source: AGHT+IGCO1F9zun/vDWXopm6gAPN6SOyj4ssXPYwfBGVfMSRD3cjVgDDI2QGkBvOlcrbG3wB8s9mVzvLx/l2sr/cQqM=
X-Received: by 2002:a81:7184:0:b0:604:230a:a823 with SMTP id
 m126-20020a817184000000b00604230aa823mr15975734ywc.50.1708455967733; Tue, 20
 Feb 2024 11:06:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215190834.3222812-1-quic_abhinavk@quicinc.com>
 <CAA8EJppQquHgSgCrxKZHPHk248Pxg7Q8mvmmjbcpUxpreQkcuA@mail.gmail.com> <d3674c10-5c29-d917-44f5-758d90d9e679@quicinc.com>
In-Reply-To: <d3674c10-5c29-d917-44f5-758d90d9e679@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 21:05:56 +0200
Message-ID: <CAA8EJpqaG+fBA_FO-L7Bimtjqqg3ZDQtyJL0oPFEueb-1WxjUw@mail.gmail.com>
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

On Tue, 20 Feb 2024 at 20:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 2/20/2024 10:49 AM, Dmitry Baryshkov wrote:
> > On Thu, 15 Feb 2024 at 21:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
> >> Lets move this to drm_dp_helper to achieve this.
> >>
> >> changes in v2:
> >>          - rebased on top of drm-tip
> >>
> >> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > v1 had an explicit comment before the ack:
> >
>
> Yes, I remember the comment. I did not make any changes to v2 other than
> just rebasing it on drm-tip to get the ack from i915 folks.
>
> >>     From my side, with the promise of the size fixup.
> >
> > However I observe neither a second patch removing the size argument
> > nor it being dropped as a part of this patch.
> >
>
> Yes, now that in v2 we got the ack for this patch, I can spin a v3 with
> the addition of the next patch to remove the size OR as another series
> so as to not block the main series which needs this patch.
>
> I would prefer the latter.

It doesn't work this way. The comment should have been fixed for v2.



-- 
With best wishes
Dmitry

