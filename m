Return-Path: <linux-kernel+bounces-131037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AB898245
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6479C1F2353D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F82259B67;
	Thu,  4 Apr 2024 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NI2aZhhX"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F359B75
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215934; cv=none; b=i1GBLe6Hpi4hLKe5fCdfvspPer12y0J2ZluwL7He+5DkJgCkvsfpmoBDDU+rPzPQfXiWtADk8e+aCpvGcYL8JjJNCgiNsF6+vDzgs+3RO0PNg3HnhsyDe7niV6m9XFo9xO8ltBFdV3pALpfSB3EUqndMR9r+OTTwTo/pyCwB1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215934; c=relaxed/simple;
	bh=Ls3PpIQ2YyG8xs+4rpQ3hM8m7hScp+Qun/2/ykjbdKw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AzEzFxFtR7vDiopj+lRxQLb86hekz2zeR6f6qp2OMxWvBGUxWwhxsGx+C2Fbfa5SJyEdu2PaqwL8Tv21oos374i4MPsTDzmlSlsIt6BsWzrtuL1kxLK+Fqo9y+D2zJzadeO60uFg3X6DI3NBDeLm+9JKMutgLCBhTv6TyIZuZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NI2aZhhX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e22574eb3so42520a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712215931; x=1712820731; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//sAcOVGiFM67Mc+7u0Jl/+UyvrH+ecyO1z9cymLgoc=;
        b=NI2aZhhXCQ6QWkJfbx1MpJwSI0s0ENFJ4MmReW/55Nyo4LTX5UfIoPPFXSyvhXGtoZ
         vqu05wb51knuofbAk/7YoU8EFjH8BDWNOEFR1Zosl/twhmwQM29I1M1+y/Jrwt02JnZF
         OMoJJ6La5xVZdX56nO6UyO+J5ZQA1DpFSzVWpjnhSe7BOfZtr4s/KPJ6nD4TUiMWo+xk
         JyOt86SFO48KTzXeZNDwoPp2uF4uXwbY14XNO7YiJ9LUmJJCbFjouyeZpEcuYyMvsS5t
         XPZojwzwRKCOPoWJgWhwFAKdyIRQ14xpHVDLeAmOhU2HRq/xnNDo3rUkEXbV3dprPqNg
         /OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215931; x=1712820731;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//sAcOVGiFM67Mc+7u0Jl/+UyvrH+ecyO1z9cymLgoc=;
        b=Tu9UBWXi4NmIEOUmfKWOkBLlA2j3AEFiuSoY2OEMueIp7PpC5pu/rO3uo82araQdVC
         IMxrlJ1YwhhbPU0QI95BGzP5siVfqiZg2BzyXhf4VuYH+6TJAhdUKvQSyUhtt20VFB8f
         aPIkp02EXgL1m1XdoxJzIbv34ZFbLHZOxIRfnksBmZ/5RObu/8elgdndd/dC521Seeoq
         4hlrkbztWoN/slfGqUE8qff/TLPHm+IKEl+K2gf2/qT9qxvKQS+oycYBh3OQ9bBuxFFv
         KMCKVNoI07Hw8lFjOuf5N9OWk22WnQU2juj/A4D5z9jDRMlfPJScI/RQQHEggj8Kk+4w
         1n/A==
X-Forwarded-Encrypted: i=1; AJvYcCUcxvFahLDKtJ/EcsmzlshKZ69BMV/4VHW+uY43tbV/UTm8vJEciVpTVe7aGjZKoFHnf0N+qGLeCPFaZJz8vKGYFoM6B+Ke5QSVkI5k
X-Gm-Message-State: AOJu0Yxr38ByX0piTnNzcbzFRopAK4GvBpna4HF6Uzci/HUtAzag5FOX
	1JfBKvIHIEWF2u+OtEOtLkHVCc8VbdmmLYMxWIIXXE6QpcJ9DA4X5//3reJp/CI=
X-Google-Smtp-Source: AGHT+IHGoMQHATjr9mp/W1xlbFnASpGskQs04R+ZSL+kTmOQTHyHF5yua8U3fbJLoFFE5vCnaPng5A==
X-Received: by 2002:a50:8add:0:b0:56d:ee61:6874 with SMTP id k29-20020a508add000000b0056dee616874mr1078667edk.20.1712215931473;
        Thu, 04 Apr 2024 00:32:11 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s2-20020aa7cb02000000b0056c0d96e099sm8845373edt.89.2024.04.04.00.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:32:11 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:32:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rohit Visavalia <rohit.visavalia@amd.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	Vishal Sagar <vishal.sagar@amd.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm: xlnx: db: fix a memory leak in probe
Message-ID: <86def134-9537-4939-912e-3a424e3a75b6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Free "dp" before returning.

Fixes: be318d01a903 ("drm: xlnx: dp: Reset DisplayPort IP")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 5a40aa1d4283..8a15d18a65a6 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1716,7 +1716,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 
 	ret = zynqmp_dp_reset(dp, true);
 	if (ret < 0)
-		return ret;
+		goto err_free;
 
 	ret = zynqmp_dp_reset(dp, false);
 	if (ret < 0)
-- 
2.43.0


