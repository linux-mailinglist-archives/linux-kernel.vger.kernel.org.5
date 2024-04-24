Return-Path: <linux-kernel+bounces-156809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30B8B0878
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0232868AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE761E480;
	Wed, 24 Apr 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Csq1Ih4x"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B3159588
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958915; cv=none; b=huSGMywMAkxN710+wMeZ+QsSX94WRt6eAgdO0lR3VWnmVvdwaojjtFEEcDmxufFjSkIHVOFkbIQ6XJQOwKiOSA3a/TjwQL34JJOnrNwgG+egGqAaZvfgHALfxZTZgANagjrEzyOIdeA0ed6z/ZS+cTHC5VOrV7V/dzM20r+J0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958915; c=relaxed/simple;
	bh=4lS/KiB1vKWPZ84j/8jQAV+eVGXVWrV4Nf28Lpy9ZII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n4XX/9kNwcssLSye9ClldDMxy5fjKE68tHwUnq4BdqS2NfJ4iDFyZJyEfPkaccfR1c+AgEj67bI15ElOz+oec9BT0ZWnA2bzAVgePvxnjaQHlE2ZEISyWm1XpvYgnBaH1awuURCEe916NMHbg+kxpJSFiHzL4AajBPdLVYatmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Csq1Ih4x; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41aa45251eeso18779505e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713958912; x=1714563712; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELudIBLkjdgxS0elp1PUtkat+hOoPGI1SePmaBawDG4=;
        b=Csq1Ih4xHZLXJEHbz63w3zqUXyHjKJ4Bhn4Ie7fawmCGhdOOerM/rfzHzwZYAlyqVT
         jkEkExX/RXzmbwkxcxl1kLLg3wRbCT3JwcBHWTBa1fTWv2W8N0vB+7beE5W28Mb+VjhP
         yFkHrB43CfhOY1bXbQ0Gn+Jt53Or7dVFcWo+I2+ckvelQkUridMIEgnN9Q+Z+FnM3BP9
         +UXR5+N3ZZoeiITE+lAkSDQq5mrthyEHe2sey6kn8iEA4AV4oYYEA12kIS19s64tye+F
         AfqgNfYwYvhQKB5K7q8v/M5cYeBMHQGK3EMDzVddW5v16MXXjI/y1rXVvpCTm1UAc7Jb
         SmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713958912; x=1714563712;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELudIBLkjdgxS0elp1PUtkat+hOoPGI1SePmaBawDG4=;
        b=UKLx7/fUF/ZqjzTg/43svrgIUHR8o0664x0/JAkQwn50vNVq/UhhT7axK+nLeaSp98
         zAWL1yLCNurKIEnXDsPB/SHXJCRRESZEtIfCO7AXL7bBMR+7DX/OptPbNiZdpogtaFLc
         xG4UMcCqSwPpoLyxDfO5DgTO6IvutrDvLaFu2Z7WUF83yc5ptgmJY2gjdWeTHK7bsTOz
         OSiqh3pgAk4csx3cW9ytugneL72ltxQMveShypn57oY6XcwmqKJA4u2NoSNBguWciCfr
         HHsrxmKOvy6nhfVA3owE0jzDkJL/uTpPSzuY470Yt7Oq5FJnLJ62x3PB71H5F/6dNqRq
         haCA==
X-Forwarded-Encrypted: i=1; AJvYcCXH9ifJJTTVnnmdMhyfLd1sNMCSYPtKWmjHAJyAFmC4olxycqo7B0dltSafvLnumDL7649xaqdVnjPVtlX3UbuqOJT5EoGZLxwdbjwx
X-Gm-Message-State: AOJu0Ywg+CrRBZFwqZOxfAaYhLF9+32a22bgbhr2Rbz/nWg32eOiZSOA
	at6VSTfN9x8fp3HMbEPwPjJNEBLwA8keGEMVxL8S1p5gRDONvjFcahx/5XbozsM=
X-Google-Smtp-Source: AGHT+IFC3Xn9CFwEPi+nZrUxwB85rOXzdnYEMUpkC1nwbPG2hnf4U7btQl9yxJcgwUfAxP5VTsmFNw==
X-Received: by 2002:a05:600c:450a:b0:41a:e5f5:9a4a with SMTP id t10-20020a05600c450a00b0041ae5f59a4amr1690065wmo.9.1713958912043;
        Wed, 24 Apr 2024 04:41:52 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c314300b0041abdaf8c6asm5404240wmo.13.2024.04.24.04.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:41:51 -0700 (PDT)
Date: Wed, 24 Apr 2024 14:41:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harry Wentland <harry.wentland@amd.com>,
	Charlene Liu <charlene.liu@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Alvin Lee <alvin.lee2@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
	Jun Lei <jun.lei@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: re-indent dc_power_down_on_boot()
Message-ID: <e5f538ab-ebc8-400b-8104-4642b8089b4f@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These lines are indented too far.  Clean the whitespace.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8eefba757da4..f64d7229eb6c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5043,11 +5043,10 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
 void dc_power_down_on_boot(struct dc *dc)
 {
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
-			dc->hwss.power_down_on_boot) {
-
-			if (dc->caps.ips_support)
-				dc_exit_ips_for_hw_access(dc);
+	    dc->hwss.power_down_on_boot) {
 
+		if (dc->caps.ips_support)
+			dc_exit_ips_for_hw_access(dc);
 		dc->hwss.power_down_on_boot(dc);
 	}
 }
-- 
2.43.0


