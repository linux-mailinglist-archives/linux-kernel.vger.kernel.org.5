Return-Path: <linux-kernel+bounces-60965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C49D850BB9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA01C20D0D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485A5F49D;
	Sun, 11 Feb 2024 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMyravJh"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1415A8;
	Sun, 11 Feb 2024 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707688259; cv=none; b=TZnTFI8qPgSJKTDJmtfoUnIdJzhlfZcHxa36/bVsnAx/VyPg+06iG5spMXbDeSHncxYfJis6UhpEUf/s8pRZx2QpLPDtO4/+gISsmoqV25at/HguCmSAamWzTA1PseLEB0Gow4mYTwXR8/u1YTAD8pX7L6dw2VER4I1fIQqhhZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707688259; c=relaxed/simple;
	bh=e66QFBC5T5nvIc6FBuBpH5frqym7eBz1RtUcQY6iYRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9vxJh/5z3do9+bbynKNh3Acf7Bq2qTdh+mgTckww24uSbpKyEiVTyrzFw97EALc6dT3o0GlsUOJsH75GVsqGjir0WH2gj35Oy3x7phTfr9wPM/wCpgMZeXQoCS11MQy2dpDnp/8ALJ3C/Vb9VbOXTcxRBP187WSEZok9O+QeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMyravJh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0ca40aafaso5693321fa.0;
        Sun, 11 Feb 2024 13:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707688256; x=1708293056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCiwfWXaBiDiiMoNauIUr8Aq7JRDoqoJY68Ac5P8N3Q=;
        b=XMyravJhjESPxwP/ztQVmJuEv/aNWk2YeIoszeblTiUKmh9kozLe/c8z+r0MKjOjV7
         XHJ4lvYqm/Y7x5lAjhiz55YGykYJ1vR7wbj6e8eslnRToILu7EeIqbWvc42DgyhRC34i
         rW5m8WBIiE6Gzkml9biOXLp1JcgIPKTuu+BF0dmkLljc64DItC/A2rVBlPceGxw+N+Cw
         w+qT+c/Y5aVqGKcHxF0qJoOcDTCX+Akz7lipNAkNL0deDrK9raXpyMzh2RnyQJ9vQnRO
         C0IZbC7ZaS4rLiOdt192LfKjmenTVFQF/2XgVfE3kYlWtxa2pY60sdrNk1ZN0j9/r4L7
         C1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707688256; x=1708293056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCiwfWXaBiDiiMoNauIUr8Aq7JRDoqoJY68Ac5P8N3Q=;
        b=tpcq+rHJmovw9TNM+j+M53CgT6RyXXEnHL7JGb6t0FOsP+IAuNTzK+YBFyCL7MyJb8
         h8p+bxkgROIUZnIYzl5i34Z90OFoSQgmytqs1MyNIgb7AL63b6e7H5MGyK7DxVSG6fxp
         5P1usMvsLAt6JqkdtRtRXm1EqxmzVFHMQR2Qm6OjAl1gJWGemKnU/wAhYvUyKxN9Dd8Y
         2/4mJJhd7Gc8Y8jRPGqxr2r75VkfKxUNFgVf/MrWsT2lBS9llkkJQ6VfxMUOLiIgM670
         oai35aEICdU8wjqBTRsZ3PI3dJPJXCaUVUROMdHqFY88puRPUvDputrrYHOLH2P1E94q
         XETQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHoBS2OxG72fmVNKGQABaihoWOntzErbG2GuZ0sW7CCWsNTxHMyad8ttHU1q5T45DolnG+n2P9k4k4MTBoLkcWyuZEx0LIaFc9+8T/DfPrU74QBloND41JCb3qx7Kxfh6FHONXhhTA1fEwxXEt
X-Gm-Message-State: AOJu0YwCS8fYQ00DdUHKGFZ3NdU6UfB2RPLVb1KL9LmMJht+7dPEDjN+
	+3CeO8SwO4yBgBD96iaw9QOQOJUF/z/8rqVh6Az0FsfQSWM0OAFs
X-Google-Smtp-Source: AGHT+IF2zWkwXblenI1gRXr70yrT64HoBD+FajchtchHXmqpxVAuXiJ0OFipLmO1Ysv08aBR9nCokA==
X-Received: by 2002:ac2:434b:0:b0:511:680c:94e9 with SMTP id o11-20020ac2434b000000b00511680c94e9mr2303766lfl.3.1707688255748;
        Sun, 11 Feb 2024 13:50:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWa+ad82KJzb5NNgxC9WfLsveEabqTv2bjpzz476MAr69saqz91H0Xpc3s7eHOWxvuh4tlA4b0dZTxY+I3ZsAyB9GrX+1syIQQUQoJHuiPJxrI5rQHTYVf2shmHFohsuNfo4eo18qFVwgszoOR8ZThcdwQf3GYBStOLX0p+WkIJu/n9Y8OIb8cp4z60WDsGBGjWk9ENHUXd1Gpf/izAQYP0+PgN8oJAKff/n4acdnUglwdQB0ZmC+Kfl5YciYzqg88WjozhRrVEIvYTrzfnU2V1MeHU3YR4paLGpdmGGfbffA2fHzK+Zds7XafjQmQjX9ulWRys5hsqpJgsxVqm5MqyDDsN4E0Q3wvlQbFhAIaHWtGjFRLST52leU4/sgTjlQT03yd5aiCn6t2z88+Zu+mitNrnRKjAMrxJ4BOuaDhkvlbr3fM8xvjNlkLTYc1XRbNCiuGnHaU7iMfTFPHD
Received: from localhost (88-115-160-21.elisa-laajakaista.fi. [88.115.160.21])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25598000000b005118f40845fsm77733lfg.281.2024.02.11.13.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 13:50:55 -0800 (PST)
Date: Sun, 11 Feb 2024 23:50:53 +0200
From: Zhi Wang <zhi.wang.linux@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, David Airlie
 <airlied@gmail.com>, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/gvt: remove redundant assignment to
 pointer map
Message-ID: <20240211235053.00002b5c.zhi.wang.linux@gmail.com>
In-Reply-To: <20240209160829.3930396-1-colin.i.king@gmail.com>
References: <20240209160829.3930396-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 16:08:29 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> The pointer map is being initialized with a value that is never
> read, it is being re-assigned later on in a for-loop. The
> initialization is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/gpu/drm/i915/gvt/interrupt.c:346:28: warning: Value stored to
> 'map' during its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/i915/gvt/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/interrupt.c
> b/drivers/gpu/drm/i915/gvt/interrupt.c index
> c8e7dfc9f791..8c8e37f50a45 100644 ---
> a/drivers/gpu/drm/i915/gvt/interrupt.c +++
> b/drivers/gpu/drm/i915/gvt/interrupt.c @@ -343,7 +343,7 @@ static
> void update_upstream_irq(struct intel_vgpu *vgpu, {
>  	struct drm_i915_private *i915 = vgpu->gvt->gt->i915;
>  	struct intel_gvt_irq *irq = &vgpu->gvt->irq;
> -	struct intel_gvt_irq_map *map = irq->irq_map;
> +	struct intel_gvt_irq_map *map;
>  	struct intel_gvt_irq_info *up_irq_info = NULL;
>  	u32 set_bits = 0;
>  	u32 clear_bits = 0;

Thanks for the patch!

Reviewed-by: Zhi Wang <zhi.wang.linux@gmail.com>

