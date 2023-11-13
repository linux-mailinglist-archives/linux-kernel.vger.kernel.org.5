Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF28B7E9AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjKMLYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKMLYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:24:08 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9DDD5F;
        Mon, 13 Nov 2023 03:24:05 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c834c52b5aso35774131fa.1;
        Mon, 13 Nov 2023 03:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699874644; x=1700479444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o3s7Gg19og8FHPmLJsossp9CoxmOk03jVqJSNlvYEE=;
        b=csuvi8qNQU1o2bmJJp11vVml9q+1mUXNj/xoXGvxza/8Jtr81AAUbPgJDE1fwoDJxa
         c9pAHioCYNF3xl9+D0RX76iSHfFWXI4o3o1y2sMa86lU7DoxrfiB9gtPmWeYt/S5jYRJ
         YWtiThXCbBcBYZMBVBezSdmEuYamgmLxP9mSLlHJn493/eR6HK8M94DEBkJVhrIwfYpf
         ZcboUelaIjqmAjxucLZm+6+EIZR5F1efeyR8ZWiCqku87z6CzOTN9+F1W8ZrvgNquvtw
         FOh8840TU0yxjrmQ2c0ObLHOlj20CXR7927SbcGUs9+gspL2eVnklomRshQ4hT/JQ/ce
         4fPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874644; x=1700479444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o3s7Gg19og8FHPmLJsossp9CoxmOk03jVqJSNlvYEE=;
        b=DqToIFICaLuG2krTKmRUKKkFEsUpG1N/nvHp32ApOQqTYYQ0w4cTLCpzDH9r86qXA9
         wb3wHmcAvnqbRZ4PZ7FwlrZUPmPYsx8jsSDfSFH2sOEgqFbwYBJLVKn3/8GfuITjENzj
         mK6eiCjRRVNi5SnJl7IDOOgr3RDtQSf2HN5lYjElLPLOnT6n24ohUpev3FyYBIZW92Hm
         sNDt+XE1vVnBFkEz63Q03KlllLJYSXuJQMuYR0+22VJ64LHaOcuIQDfvYSHTo/hjW/yE
         KIBlPc0Ko96s4vNtrkQPSv7useuQyU205NycexbzWcmFdHNhW8kcp2TpGzIiiO18bzNg
         uyGw==
X-Gm-Message-State: AOJu0YwgHU2U9BUO8GpNJVr2F38+XWuMPuc5q6mplrf3IUn7GXgApRvF
        E4+AKCQbuAimoDWQPWoHBhU=
X-Google-Smtp-Source: AGHT+IH61A5pPCfNwMBXGGsskBdp/S7K92gc20LeFda5wnWDvVisuAv0N9mZOP0o4Cx1RRVOFVPMyQ==
X-Received: by 2002:a05:651c:102a:b0:2c8:323b:9207 with SMTP id w10-20020a05651c102a00b002c8323b9207mr4450710ljm.11.1699874643357;
        Mon, 13 Nov 2023 03:24:03 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 03:24:03 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c: remove I2C_CLASS_DDC support
Date:   Mon, 13 Nov 2023 12:23:27 +0100
Message-ID: <20231113112344.719-4-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113112344.719-1-hkallweit1@gmail.com>
References: <20231113112344.719-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
Class-based device auto-detection is a legacy mechanism and shouldn't
be used in new code. So we can remove this class completely now.

Preferably this series should be applied via the i2c tree.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6f99f6754..ae1edc6ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7529,7 +7529,6 @@ create_i2c(struct ddc_service *ddc_service,
 	if (!i2c)
 		return NULL;
 	i2c->base.owner = THIS_MODULE;
-	i2c->base.class = I2C_CLASS_DDC;
 	i2c->base.dev.parent = &adev->pdev->dev;
 	i2c->base.algo = &amdgpu_dm_i2c_algo;
 	snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c hw bus %d", link_index);

