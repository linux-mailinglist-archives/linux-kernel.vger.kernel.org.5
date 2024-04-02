Return-Path: <linux-kernel+bounces-127674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE2894F43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF492827FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E455A4D5;
	Tue,  2 Apr 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTdE5dde"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254FF59B79
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051809; cv=none; b=RPoG4v9zd7gHDqDizwPwM8Wq6rlH0DhR4J8W07OpSDxvrObCAzGrgZtCxQXv/Ez4TPNMbpEFQ5v3eVUn33GLNUftIGWawHmVlAS/QzUPndXH/MuHQiGNGHT2UKEPmSPuYju+hepnDetvUpiPiFb7AuJAA61Pfo2cUAFK2lps0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051809; c=relaxed/simple;
	bh=teQDxib2Uf+FgdvYVSISC39IdNk+9G89gKg6gn5dyJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kf+3GlX9CQdsriqVrUdS9ehQsOeGzDat/xiM6lNu7MuemjaN94L0+QEIHIomRHpqVpW728FR237G+eIaYMrmcwIUisccX0DXiHmvdlwGpwl/kJffGbvpmgJRuAB92x0lKdEXQ9pkGUnU8A9CwQbz/uDpGJVjLbFnHMfAZOXL0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JTdE5dde; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56dc9955091so2006119a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712051806; x=1712656606; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=718ZM86+71A8BdEVL2GnpD+8wX4z74S1znydXwGnzcw=;
        b=JTdE5ddenp7q9/Jb6uWFwA2H5igPP/90C85jklRW0uNyDTQzKAfIrLyLJZfnPDtbz4
         eoCsyUD1TX8LRymL0pYsQELMdMQ0vWEvOjx6UnhU9PoCoWj2a+qlwQ9hc0CY5LoZ+hhH
         NU6Zmx8RvIbZSI4EXwoTFpppvLnI2reR9MFxTIWTAUI9HkTWMric0e5ca9af00zV7SIt
         uGwsN1kRZGQriBZ5k61j+msryZoAdmFx/MKYI8gz69pu1nusOJ1OIzdjdvsWK7F5psjN
         nSjs3KWTYw1qqIZCuHtfv65ECLyCQ7H+9McbWxhyJqXoUuxSuIYiWcLyGV9hiDizEz2Q
         H2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051806; x=1712656606;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=718ZM86+71A8BdEVL2GnpD+8wX4z74S1znydXwGnzcw=;
        b=loPVQK75RlPyzl2jiz7XmGTpTumBSi2dBblG58JM7sWADafMta5QqwLRSVqyRxc2rb
         d0ldshXtRIs157xMWqDUpOzzG6w+X/5Zqa+1j6P4MZoyyvgWjohWk9Y73Gm2l1wUo+En
         K8mCjllNc1Nf2mb37BSf5EuaS8Lnit+ZTXo7zji8zXX0Ky8Vro9ZEN+6HuylVGWRex6R
         k/0KISq10NJ18kS9AQp643clorwlEMvp+NZFvDnbyDdtyKg7sagUy8zHBjiqOG3HDGMO
         8N5Us+AbFjlFv161ZLer5U3jtQtSKa9VtOegkaIkOQmsRju1kd/FeYKRMw43VNIbrzOE
         Bp5g==
X-Forwarded-Encrypted: i=1; AJvYcCViXGSXsT4rnRX6wQsLpY0mv/hBU/PkMe68EEK4zZBF4v/z22aLgoM6ZfD2yHDp9QnX7+WJp45DN42GJHl/EZ1hFV7tXfl5IDvti5ss
X-Gm-Message-State: AOJu0Yypk2aBATipg1LdiLJKu8Oti9YKgepR3R1jBlkcc+lR7c4fc3lg
	ceHWoe6haaeYvtjAsHRjb20O6J0sAvx0Xr/CQjZJ2e7UcL80Y3o1V0lsA3g2apg=
X-Google-Smtp-Source: AGHT+IEJjgwUkgIFH8v8m5U7taah5woPEVoICpVprECTBBshSjtqYr7X1fMj5MRpzZPnXQqCG7ctQg==
X-Received: by 2002:a05:6402:4311:b0:56c:197a:76e2 with SMTP id m17-20020a056402431100b0056c197a76e2mr9137367edc.0.1712051806315;
        Tue, 02 Apr 2024 02:56:46 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id dh25-20020a0564021d3900b0056c09fda4e6sm6726525edb.54.2024.04.02.02.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:56:46 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:56:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/panthor: Fix off by one in panthor_fw_get_cs_iface()
Message-ID: <62835c16-c85c-483d-a8fe-63be78d49d15@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ->iface.streams[csg_slot][] array has MAX_CS_PER_CSG elements so
this > comparison needs to be >= to prevent an out of bounds access.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 33c87a59834e..181395e2859a 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -308,7 +308,7 @@ panthor_fw_get_csg_iface(struct panthor_device *ptdev, u32 csg_slot)
 struct panthor_fw_cs_iface *
 panthor_fw_get_cs_iface(struct panthor_device *ptdev, u32 csg_slot, u32 cs_slot)
 {
-	if (drm_WARN_ON(&ptdev->base, csg_slot >= MAX_CSGS || cs_slot > MAX_CS_PER_CSG))
+	if (drm_WARN_ON(&ptdev->base, csg_slot >= MAX_CSGS || cs_slot >= MAX_CS_PER_CSG))
 		return NULL;
 
 	return &ptdev->fw->iface.streams[csg_slot][cs_slot];
-- 
2.43.0


