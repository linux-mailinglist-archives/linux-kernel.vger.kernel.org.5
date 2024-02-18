Return-Path: <linux-kernel+bounces-70433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710EE8597AC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A282A1C20859
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F846D1BA;
	Sun, 18 Feb 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGSfMZ7S"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300B91E531;
	Sun, 18 Feb 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708271357; cv=none; b=aVgVj5pS8ARTUf57JCgYZ0Yl5OYzmD/Y4wDl/up0FFHVEsHonPJ5RS5DqwS/0QG6kTZkhJWi038lBe/RWDRdKXopzWMTYCQe/rRbpLwZpU4jieHHuC8k++0s11wEfp1Qdjk5HrdNfoxWeITdzLxHTsKo+n5/Vc7OD4LzWALnMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708271357; c=relaxed/simple;
	bh=8nGoFUXWmyGHOy260pPB+sKZI6HN3nM/YAmZ0KHV6BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz8x3O5UNarZ8jAfSqvao89+Vs+VfRIc/ml8KYKL/8hkgm/f/Iee2DMqbXDeSMNKNiuuuSbYA3HMCnEzAQRIHmdufve16HypNq0wx30aOd7i1RzBGK9Wiabow/bXVfEYv3vq6Y9+T1TJhR/rIH9aKguwHBSvQO0P7rByNdl7FUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGSfMZ7S; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e45ef0115eso3261b3a.2;
        Sun, 18 Feb 2024 07:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708271355; x=1708876155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HygTjwzdRXTfZJXPzKIecTHavlYq9dpN87Z53dyDVe4=;
        b=EGSfMZ7SvB8t27nVYbXo/+ynnUnDRSxGP2lVn/+OxahHwGg8Yxel6YBJyL7gtEmAFm
         u4U/M4V9qoqEqZmZyQmypz5h985vsGJaFY2r16MrMUP2je2IW/ONwqTW3ilkSglTSwhw
         6IY83NWF0yO7z/lYfHtovR6SZReCJ9NxfJLPPMvTsgmo2FmFuAe46jvrZE97M5thPrn3
         RKZwkjGAP+FM0TPOfoC1KPsfFu6GBvr3puLCja+vNSbEzNK0kMKsF76q2KcL5Q+suKc9
         FEkPNO3OpyCMIeVmLrQWiv6NgeUZh6L1LBS0x8vj/I+3553+C8Sc4ZBUKnF3mHBOyw8Y
         E4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708271355; x=1708876155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HygTjwzdRXTfZJXPzKIecTHavlYq9dpN87Z53dyDVe4=;
        b=fwbHWC73TdmK2i5QUEfPBQfe6GoXs0asx2qPxQq9KFvL7CcD1g1kOaijMiWp/I8VjR
         NdfbnzMutJQum24rbg15shbBopTeggOX+irsWc7g4VNSqeHNYTPdmDES8ArUZqFRBG1g
         A96opjTl4vbDYsBWXTnscfCqcWPwSj7Ze04XUEW7RHGC/a5PS3G6ymBpgLziyoUgZhI2
         o5mV/szi8w9n0udk+Ckbegn1Xx+WFdvfVbiKPYokSRe13uaBGgbf6vo02mP/YeOLvOCW
         cI2YmeUP7iPSF/MC6+bXL5PONv5osbsFTmNVZiyjNaCKoSEBaJ7Jg0KPw6ZTdyMl9ptB
         GdqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVazckTcLtmGQ6iIUPbQDPdfB4U2wsh4k4vLiLXu602rY6DUSaHyM5JiR6PC0/WGpaqxKkqDGhSqr8nRG9os0IAi5i/Xkn1lOoys6M8p2BIBG/bPfEAmikd7qVjafeIN5+p1+s6RwL21ck=
X-Gm-Message-State: AOJu0Yy10m/mt0WkGVwijxxePhsJ2KWWrJPN2Mjydg5zpB5WD0YGNRHd
	pW4td105vVg9W2/QBORym1vOmIf9sMTNpz/vI0eULuQI+dWDDEDG4HQv8704
X-Google-Smtp-Source: AGHT+IGtFTeG1xqdQuslCfg46RlX50lmgmsSXRs+AAF00N8eLRLlV9eHfM6YvKpqSj14RdRN0G6Org==
X-Received: by 2002:a62:cec2:0:b0:6df:c3b1:1c2e with SMTP id y185-20020a62cec2000000b006dfc3b11c2emr8689930pfg.30.1708271355446;
        Sun, 18 Feb 2024 07:49:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a0018aa00b006e144bac418sm3149232pfh.74.2024.02.18.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 07:49:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 18 Feb 2024 07:49:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Marco Pagani <marpagan@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian Koenig <christian.koenig@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v5] drm/test: add a test suite for GEM objects backed by
 shmem
Message-ID: <a45b796d-5e04-4eac-b5ba-ea6bb3b6131b@roeck-us.net>
References: <20231130171417.74162-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130171417.74162-1-marpagan@redhat.com>

Hi,

On Thu, Nov 30, 2023 at 06:14:16PM +0100, Marco Pagani wrote:
> This patch introduces an initial KUnit test suite for GEM objects
> backed by shmem buffers.
> 
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

When running this in qemu, I get lots of warnings backtraces in the drm
core.

WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:327
WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:173
WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:385
WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:211
WARNING: CPU: 0 PID: 1345 at kernel/dma/mapping.c:194
WARNING: CPU: 0 PID: 1347 at drivers/gpu/drm/drm_gem_shmem_helper.c:429
WARNING: CPU: 0 PID: 1349 at drivers/gpu/drm/drm_gem_shmem_helper.c:445 

It looks like dma_resv_assert_held() asserts each time it is executed.
The backtrace in kernel/dma/mapping.c is triggered by
	if (WARN_ON_ONCE(!dev->dma_mask))
		return 0;
in __dma_map_sg_attrs().

Is this a possible problem in the test code, or can it be caused by
some limitations or bugs in the qemu emulation ? If so, do you have any
thoughts or ideas what those limitations / bugs might be ? 

Thanks,
Guenter

