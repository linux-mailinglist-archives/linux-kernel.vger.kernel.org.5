Return-Path: <linux-kernel+bounces-167934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C08BB152
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3D11C2158F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1F6157A5C;
	Fri,  3 May 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eG2dXHAm"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B6578276
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755616; cv=none; b=NyNZfosooSLh2zZxdirHtTnd66FYV/i8Mj7upib1eLHkHLfSFIx6lUsJMLVMPxFSProFAnlnYAkLkJnd6qeQRuKiH4stS3FrWFaQepujotyYReQLIaQ+ykZ68tBXv9UkM8H6cp7XOPFGW9rDsQGx9TzYw+VMMZsQdyDxFV6PoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755616; c=relaxed/simple;
	bh=xgnxHdHeK4MdVLeuP5d6Ha/RmRburL5mnxPHP466GOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW6MhAkioLOHDpYfughkmr00HvFLArcE7GI+rey6epWzyTHkaYrTrdRpsqxCfYXfpstX6qH4FlPRUhTgJ9xR7ilDh0yFFmTVdN9bVGrrSueUN/Wq5JBMSHKchljJRahkHNfl/kU7cn+wT9HQ8VgkQ/AvbVjV47rBDQR4jmhhe3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eG2dXHAm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e242b1df60so12381971fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714755613; x=1715360413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXU7vMhXEeTp/KYmjwZZbLXJksXGPbDoFW68+DTiGVw=;
        b=eG2dXHAmeit86PvaaPBuZxWq91YdubLb1VRHSftQqtyipVsfzJnt14VC6BQ6B6NWzN
         FhNjjaQQYQG76+Nw+Tu+QgyJUqsYKsZTG9NIrf79H2TMqqlaM/CcyYVZP5AK8FRq8dy2
         Wa9SgeJ5QV3bdZ4gv1HRJ7FS/up4MZHHYigeM8s0t8xU8c22FfPoGOujkPWf8eY0Hwx7
         e84Ery6wOdcOEfEjDM7aUKWEe5DFO5GTiKCPo+CI+4oQrYsrx8CIEmxg/MSKgeDjpRFV
         m2GvZr7E0hKRE1cxeEW9WUGmr5W5DsMmK+tSfYWXBLOE2nAZFpVxShwHyQFbZrIyBmMO
         ydZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714755613; x=1715360413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXU7vMhXEeTp/KYmjwZZbLXJksXGPbDoFW68+DTiGVw=;
        b=GpfxJaWjYmBEmHqqoIPYRmRel1vUQLHVF5haVuGfgID7NjJZoWxezeAf1Ok06vJT5k
         ti34EPPxKf5shUAmva9VvfsvnNPv4F+peuHdTRTIs26UuFNgJR3fr/zooGvkdzhOaMlO
         Qfq+a9tWLrDnQzUQQs3RfghY9nKCVLcbk46P9XRMnRqwLXeYmNi3G6L2H3BjF/0/jNqR
         nqWb4SMOIja0Gdu0QjE1JRX3hkH9ZLUb40n7kvEos3Jnz3uQDRnWN7abNiTDuVTrQSw1
         R+yB9CfIF55LLaXubEiBtRai48QYO18f+DhWW0wIQbHMr8SqyK1KMRUsnu7FGSd/uqRs
         n0vw==
X-Forwarded-Encrypted: i=1; AJvYcCXmJuHYYhsO3rDeCX9WaZruxR3vYunsVPWB4SylM9Aq3hXfUgK5jBxrRXEcQoHQqJPtziAvJoNltGMM7WG40HGm6ssDU+9/9goW/GrE
X-Gm-Message-State: AOJu0Yx/JIwBlrXPZaHvATlB76RmwFm6Eu1Z8HNaO+de49l2dRA5CwQO
	oT2o3u/4KaePToz0KOVNnjUXSWfM4Kcb8dKF6DyL8S7US1Y1EeN+ax2lz0QlCeQ=
X-Google-Smtp-Source: AGHT+IGxOFWEPpbf7YtFt1BYzO/KPqeJOSWt0ZqWNoXVGcsm+jYpRiRT6WvmUbLNEVSLvRZogbhbDA==
X-Received: by 2002:a2e:a98c:0:b0:2dd:d3a0:e096 with SMTP id x12-20020a2ea98c000000b002ddd3a0e096mr2969464ljq.31.1714755613392;
        Fri, 03 May 2024 10:00:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id d20-20020a2e96d4000000b002df6de7283asm585841ljj.126.2024.05.03.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:00:12 -0700 (PDT)
Date: Fri, 3 May 2024 20:00:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Pekka Paalanen <pekka.paalanen@collabora.com>, Simon Ser <contact@emersion.fr>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/connector: Add \n to message about demoting
 connector force-probes
Message-ID: <irv5f3w7aqfae3jlxfk65hf6vnxpgw2li6kvj2jtfu6bih7w7e@dculxnqll6w5>
References: <20240502153234.1.I2052f01c8d209d9ae9c300b87c6e4f60bd3cc99e@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502153234.1.I2052f01c8d209d9ae9c300b87c6e4f60bd3cc99e@changeid>

On Thu, May 02, 2024 at 03:32:35PM -0700, Douglas Anderson wrote:
> The debug print clearly lacks a \n at the end. Add it.
> 
> Fixes: 8f86c82aba8b ("drm/connector: demote connector force-probes for non-master clients")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/drm_connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

