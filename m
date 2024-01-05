Return-Path: <linux-kernel+bounces-18320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B700825B82
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE42DB224A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF83608B;
	Fri,  5 Jan 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nu5zXS4i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB33608A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704486057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=feGX1dWCZ1Zr4S7jaL2F3HEuMoSwekLDmkBU7V6ngkA=;
	b=Nu5zXS4iFOhB8+Lxw1TyabTvzYRBl3f732c9vQ8wiCEMT3JbEhxmhwBUgvOH6/P7pF8cBV
	dFMiRWqUQWtxa/cbL9Hdo2qPvZppMtkHEVrklYksQww4gMPV6xh0LHfQAnFtml6b3Pujl2
	oiDE50EAR8gJiM0Cb0MyuQaaY6VUeWQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-k7kpzOQ3OCyZbxDoLc6uPQ-1; Fri, 05 Jan 2024 15:20:56 -0500
X-MC-Unique: k7kpzOQ3OCyZbxDoLc6uPQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3368698f0caso1134272f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 12:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704486054; x=1705090854;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feGX1dWCZ1Zr4S7jaL2F3HEuMoSwekLDmkBU7V6ngkA=;
        b=LOvgH/2OIDVnkIo3VNb+N3/kVAT4O426C5uAu8yBNVto+w3W0gIOKQ/n4CHGikzeMZ
         q5HWraX3GtH+3rWnOGEhFwm2l5i17sR4Yxm2vpGU0iowykNhPFAJXJ9XjCLm4P8F0+Dg
         CmBs0aGdTLBQU6v2bpqo81JwuA2gdneDaui6VRyRM8bEitSflNZAAlWs8I9h0mFI16vu
         TkYSLOGoYTqeHc9qhe5basX/MYc5ML7pjmIn7ROg8wzF5LiuVQQz6q3zaNirLcoVd3L0
         ChMH8Y39CBCI/5yBzhIJWcYN0OtbZ6tXFqY3QZRvxQPTfUh0Rt2Sif0HVJQg2oz2GPg1
         /U1Q==
X-Gm-Message-State: AOJu0Yw5dL9j1mSiU3GsYzz6ZYzC4bvLJGv5ZDt+ydCHNYMElWyND3/H
	xAKypBB7+eDgpAP0D4/lPR4Bhjonnc9rNB0FYjUEtjHsE09qFJ3m5QRvzqyT/8sw9xvvp0FkoyG
	yNfVx5vTykvyOk+Ps7Vqb3RTZTCUsbwa4oWWZ2fZ2E2fTVw7xqHR9MMPwM24N025S5dXa7GKNHD
	BAqSFz+pXAEuzIe46K
X-Received: by 2002:a05:600c:230f:b0:40d:5d82:d0f3 with SMTP id 15-20020a05600c230f00b0040d5d82d0f3mr14876wmo.271.1704486054614;
        Fri, 05 Jan 2024 12:20:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRXHrQG4uL5h01cAVjuN2b5+39l3eQgycBlTvo7X85CIbjYYmbapqrhHJI5AbnlwHqwNhq7A==
X-Received: by 2002:a05:600c:230f:b0:40d:5d82:d0f3 with SMTP id 15-20020a05600c230f00b0040d5d82d0f3mr14866wmo.271.1704486054204;
        Fri, 05 Jan 2024 12:20:54 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bi16-20020a05600c3d9000b0040d5ae2905asm2537402wmb.30.2024.01.05.12.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 12:20:53 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm: Move drm_set_preferred_mode() helper from
 drm_edid to drm_modes
In-Reply-To: <20240102122208.3103597-1-javierm@redhat.com>
References: <20240102122208.3103597-1-javierm@redhat.com>
Date: Fri, 05 Jan 2024 21:20:52 +0100
Message-ID: <87le934jmj.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Javier Martinez Canillas <javierm@redhat.com> writes:

> The helper is generic, it doesn't use the opaque EDID type struct drm_edid
> and is also used by drivers that only support non-probeable displays such
> as fixed panels.
>
> These drivers add a list of modes using drm_mode_probed_add() and then set
> a preferred mode using the drm_set_preferred_mode() helper.
>
> It seems more logical to have the helper definition in drm_modes.o instead
> of drm_edid.o, since the former contains modes helper while the latter has
> helpers to manage the EDID information.
>
> Since both drm_edid.o and drm_modes.o object files are built-in the drm.o
> object, there are no functional changes. But besides being a more logical
> place for this helper, it could also allow to eventually make drm_edid.o
> optional and not included in drm.o if only fixed panels must be supported
> in a given system.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


