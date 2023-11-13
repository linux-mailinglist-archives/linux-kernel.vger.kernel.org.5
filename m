Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D117E9B23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjKMLZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjKMLYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:24:51 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EF81738;
        Mon, 13 Nov 2023 03:24:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-407da05f05aso31960945e9.3;
        Mon, 13 Nov 2023 03:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699874657; x=1700479457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvYv7yv0Rz2qXj3RF4iM+eVeFbHCrgQ2kQmEmocPEPY=;
        b=fKTRrzAg/F37EX0KcARlMUzr5qCq8vD+vezhTkCI8avjbOq3Nx/RmuDKd5vYJlR50U
         eePX9Z59+cRuPSMGU9h423blE+13Qo5CReF9MqmtLr88AhtFbpV3cI/I/64R8vCWeQGd
         +dm+L48haB2XmZm1ua9rzQIt7fR6GJjR9OfSbeAQ0ZzOj3jJBeXPxyRLGPxGqmMQBkFz
         ht071dP3YT2QqhOfy7lQCPrbEksmWejRngRQf9jdefqfYcNfsZTc5IjO3gop3IpqDVR3
         xcA5Hog60VN5bqb/I6DnknK4XZuVrEzEWlXCORPrLsk5jTP5sjc+iZofuPFqV0XV+PKh
         i4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874657; x=1700479457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvYv7yv0Rz2qXj3RF4iM+eVeFbHCrgQ2kQmEmocPEPY=;
        b=GvqFP38qRLkpuRUug7jIubf4dD2VGJQDAF3akA74jT7Oa3PAteCn5yflo8/TyFK1gF
         Hg5yTOqWTqXnaPSJ2kGYY8ZX/ZpTVpmtnxymLWvkSHngXIhjR4DLBj6I47oYb2HXvZ4P
         1lY6t7f/h2ewrVXBgrJvWYpFXPnnmMokSLabUIeJYGHOGRJCZixTsVTlWriJapZmHswA
         m2FsG/GesmT/lvQRNLsfm4UxUVZh+JZKilANyPgMSr+agUel0wvRiqqGW49NDljPMkqp
         U+To1vALdPjUOLdRBvWmyfQLdRLfmrQaQ4fUSZi8320IdoJEpsk0Ov0qarsCB02k/tIy
         F2jg==
X-Gm-Message-State: AOJu0YyLZdRLpQTVf5QaHwlvpU8trHTbPE/WDNJw+20fgJQHNozMaNrz
        NQmMdar0Mfut3gMlHDOCRbQ=
X-Google-Smtp-Source: AGHT+IE7eFojeiNDrcKNmX5F2m1S5iERu3l7sTJdkhZInxXfHkDe3DfDng4ExEJMZ05PAGHbWKiS3w==
X-Received: by 2002:a05:600c:4710:b0:401:b1c6:97dc with SMTP id v16-20020a05600c471000b00401b1c697dcmr4475019wmo.23.1699874657598;
        Mon, 13 Nov 2023 03:24:17 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 03:24:17 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] drivers/gpu/drm/gma500: remove I2C_CLASS_DDC support
Date:   Mon, 13 Nov 2023 12:23:42 +0100
Message-ID: <20231113112344.719-19-hkallweit1@gmail.com>
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
 drivers/gpu/drm/gma500/cdv_intel_dp.c      |    1 -
 drivers/gpu/drm/gma500/intel_gmbus.c       |    1 -
 drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c |    1 -
 drivers/gpu/drm/gma500/psb_intel_sdvo.c    |    1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index 8992a9507..dd1eb7e98 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -855,7 +855,6 @@ cdv_intel_dp_i2c_init(struct gma_connector *connector,
 
 	memset(&intel_dp->adapter, '\0', sizeof (intel_dp->adapter));
 	intel_dp->adapter.owner = THIS_MODULE;
-	intel_dp->adapter.class = I2C_CLASS_DDC;
 	strncpy (intel_dp->adapter.name, name, sizeof(intel_dp->adapter.name) - 1);
 	intel_dp->adapter.name[sizeof(intel_dp->adapter.name) - 1] = '\0';
 	intel_dp->adapter.algo_data = &intel_dp->algo;
diff --git a/drivers/gpu/drm/gma500/intel_gmbus.c b/drivers/gpu/drm/gma500/intel_gmbus.c
index 09cedabf4..aa4550985 100644
--- a/drivers/gpu/drm/gma500/intel_gmbus.c
+++ b/drivers/gpu/drm/gma500/intel_gmbus.c
@@ -411,7 +411,6 @@ int gma_intel_setup_gmbus(struct drm_device *dev)
 		struct intel_gmbus *bus = &dev_priv->gmbus[i];
 
 		bus->adapter.owner = THIS_MODULE;
-		bus->adapter.class = I2C_CLASS_DDC;
 		snprintf(bus->adapter.name,
 			 sizeof(bus->adapter.name),
 			 "gma500 gmbus %s",
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c b/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
index fc9a34ed5..6daa6669e 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
@@ -168,7 +168,6 @@ static struct i2c_adapter oaktrail_hdmi_i2c_adapter = {
 	.name		= "oaktrail_hdmi_i2c",
 	.nr		= 3,
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_DDC,
 	.algo		= &oaktrail_hdmi_i2c_algorithm,
 };
 
diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
index d6fd5d726..e4f914dec 100644
--- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
+++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
@@ -2426,7 +2426,6 @@ psb_intel_sdvo_init_ddc_proxy(struct psb_intel_sdvo *sdvo,
 			  struct drm_device *dev)
 {
 	sdvo->ddc.owner = THIS_MODULE;
-	sdvo->ddc.class = I2C_CLASS_DDC;
 	snprintf(sdvo->ddc.name, I2C_NAME_SIZE, "SDVO DDC proxy");
 	sdvo->ddc.dev.parent = dev->dev;
 	sdvo->ddc.algo_data = sdvo;

