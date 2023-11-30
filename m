Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DD37FE9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbjK3H0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjK3H03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:26:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A529310E3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:26:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-332c0c32d19so445791f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701329194; x=1701933994; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxfaT7Lx/SLvMXZ8BIazUPMWfseGLyrbhSm3CqW4/u4=;
        b=ob9Yq46AtWZwUTmefP1KR39gcE5Oq1jenZW7ksI4rWwkSmkciNf4vXXMKACA79LwWe
         4eFZluxYfHpyZBEAq8JPZr2hQmBtFUR6/ATVDyyy1mIZiq81pV0V1A2FkF7LhX48U0In
         P8xBuwcsg28T6e2ZOZBd8Tkv2oUmzzCftLj+Sm10+w0+6idlnaHcg4KKYhRW5hYUovLy
         M/rxTL/v/M4/i1zJ5z9Tkqnlz4sTZiH513Rg/OgWdiuKmX5BbzFTogMtumIOuyFqIXk9
         2qcYNe9mGCytC0zQvNsDFfMjg8CJ5q/Xy6EafLPpau8Xz/8BX09HZjiva9rzc/P7QARe
         yqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701329194; x=1701933994;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxfaT7Lx/SLvMXZ8BIazUPMWfseGLyrbhSm3CqW4/u4=;
        b=fME5rrar56LBOGqtVcUzNwMpCi9UhdAV1CYWBZdGz/83pSJnSCeVDsVGC/pQG+JfQq
         EmK4pu1W+fw8R0bGrQZLFyVTFeVSaKebF/JVm05mM/9AmJwmt37w0FBZmE9023ErQ7s6
         njHSVZHjngJks5MRqBfOHFU2Ahf4TjArUUlPIKg7kUC6RdYskdcYrzpuaMgWPouW2KVh
         jBkg7hKUxSTUAjfSNom//mX01/3AxK6WE7bgzb+oq+Z5LCtRfPfujTT7JjUijTgwC3KU
         5vZ4Im5BWSgqKovLl8qQooVPMpKNQDmm1EA80bLVRrzKhUtK0I3PEy8C6AFZ+WHnfQy5
         KPuQ==
X-Gm-Message-State: AOJu0Yx+hJV4tGH9h/ogrTrBzQwFBtSYyt6JvTgiW/VNWhr7IIePthkz
        pLpxbmx/zq/AtHXBjea+MsPb6Q==
X-Google-Smtp-Source: AGHT+IEvR5GCRaBK6/l20FiBKNUdxPm6IPz8FnTeJNAeTaKjXHHuuKIh2lHQQWfzA51hiC4R/SwnJw==
X-Received: by 2002:adf:f88c:0:b0:319:7c0f:d920 with SMTP id u12-20020adff88c000000b003197c0fd920mr14168970wrp.57.1701329194008;
        Wed, 29 Nov 2023 23:26:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4cc6000000b00332f82265b8sm702358wrt.4.2023.11.29.23.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:26:33 -0800 (PST)
Date:   Thu, 30 Nov 2023 10:26:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] drm/imagination: Fix error codes in pvr_device_clk_init()
Message-ID: <1649c66b-3eea-40d2-9687-592124f968cf@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a cut and paste error so this code returns the wrong variable.

Fixes: 1f88f017e649 ("drm/imagination: Get GPU resources")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/imagination/pvr_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 8499becf4fbb..e1dcc4e42087 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -105,12 +105,12 @@ static int pvr_device_clk_init(struct pvr_device *pvr_dev)
 
 	sys_clk = devm_clk_get_optional(drm_dev->dev, "sys");
 	if (IS_ERR(sys_clk))
-		return dev_err_probe(drm_dev->dev, PTR_ERR(core_clk),
+		return dev_err_probe(drm_dev->dev, PTR_ERR(sys_clk),
 				     "failed to get sys clock\n");
 
 	mem_clk = devm_clk_get_optional(drm_dev->dev, "mem");
 	if (IS_ERR(mem_clk))
-		return dev_err_probe(drm_dev->dev, PTR_ERR(core_clk),
+		return dev_err_probe(drm_dev->dev, PTR_ERR(mem_clk),
 				     "failed to get mem clock\n");
 
 	pvr_dev->core_clk = core_clk;
-- 
2.42.0

