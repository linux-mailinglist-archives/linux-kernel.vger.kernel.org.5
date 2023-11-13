Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82F27E9B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjKMLYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjKMLYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:24:24 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423AD5F;
        Mon, 13 Nov 2023 03:24:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso37314025e9.2;
        Mon, 13 Nov 2023 03:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699874651; x=1700479451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0UShpfjCPfBIWng5J4/pQaeext1SYGd0ovoJY2VHzk=;
        b=QqOSbKwzWihyZtNLq/zgF00CdiQa2YMIxc3wwFAD7uryqc8iY2NGOGErTysrTYY8Ke
         qcuDh47CogmgrwuHQxbuK+1JgaeG2+pU3iE3VZmM4sDNu78PfDosqK9X0Y1NYAJt/MKY
         gm+FSowBEadchGMlYCXDOHd2/KXUC/m/XPV2J3wM9bNCx6X3rFzCwBF87da6HuR8xOuF
         bJh8jm7d4AqPzcvprKJ71vKflkUmTKXHi5sL0nyICnabuDcF98d5yHPEbLcHnQqiYA2A
         wVOuiMgY42w0Xug/kNcGu8VxKB4eMatPMrwIZ7hs+9PKGBCqNwJL7KdLa0EpV9W643SL
         5DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874651; x=1700479451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0UShpfjCPfBIWng5J4/pQaeext1SYGd0ovoJY2VHzk=;
        b=VzUfd/vrML7q9sD1v4IBP6HWNC3+xd92CYKphGDHA9C7YwiQ4LlDkgV3ayY5bgDgUd
         TEklZfuLne64Ao/Od/SKyMY33YZyNQ7SMVJ0SESdLmDHZQdPgDW+xCJMIb1ipOEjjO+V
         qzXMXnu45wlCUSLqeyIStMMK920ZTkBtt/GtLf0tuIJH0ymSDcnZnnPJ1m5GQuMnWzQb
         GRcQbPQhr1tlu7aD4MAP8s5G2iUuAJCHLffWjlOZmlCLE0GSZK1Jh0DiRDxB9VlCal3G
         xx6uUcJIupE1vyc4Ej/EK7lnulpYrY7h8fPW1Fgx9VIQLKwiXxAB4a6vl/jIyp1eZX8l
         bfKQ==
X-Gm-Message-State: AOJu0YxbThJF2YeuAC7PnHsjexIV7FPtXaSehMmXEVIVrzyaigEFstwC
        GYtvfL5q9Q7p9QkKrYVVIQk=
X-Google-Smtp-Source: AGHT+IGFHS306bbRiz2f+lNTVzDFOlLgNqhmA6tscwfIyFuanprmk3KxQkw7tNj8GMTBgarDSCdngg==
X-Received: by 2002:a05:600c:21c2:b0:40a:463c:1d8c with SMTP id x2-20020a05600c21c200b0040a463c1d8cmr5105398wmj.21.1699874650883;
        Mon, 13 Nov 2023 03:24:10 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 03:24:10 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/20] drivers/gpu/drm/bridge/synopsys/dw-hdmi.c: remove I2C_CLASS_DDC support
Date:   Mon, 13 Nov 2023 12:23:35 +0100
Message-ID: <20231113112344.719-12-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113112344.719-1-hkallweit1@gmail.com>
References: <20231113112344.719-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 52d91a0df..aca5bb086 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -515,7 +515,6 @@ static struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi)
 	init_completion(&i2c->cmp);
 
 	adap = &i2c->adap;
-	adap->class = I2C_CLASS_DDC;
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = hdmi->dev;
 	adap->algo = &dw_hdmi_algorithm;

