Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE08A7C9489
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjJNMOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJNMOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 08:14:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54127A2;
        Sat, 14 Oct 2023 05:14:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32003aae100so2642088f8f.0;
        Sat, 14 Oct 2023 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697285657; x=1697890457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uG33e0nxABrnJqUhQYBYHy/jJhv1/W7SNJHYJNJkoug=;
        b=OyE7qNwB+hzL3aPGpWxY3co8EWVE508Nu5IhzvysAjpsUb5px787+IVzxV62hWlMqe
         2WqcNPS2zXWpyz2zfd7mhsw+J9V1Sm1NUfDyYFvuZmASDMeXQdLHHLT7x/x2kG/PjV5C
         i5PWIHPNnOzEJxzDbTOMsfSxycJKdddzi9uba0TAuvtKLuFfQq0aE/t+DeZ29RrWf+l0
         DOcyqIoItAXq9ZkTtMSjyZxMvvfKrIg9G9+T4aS3TGYf7Z1LopBHkjaNhkLIiOtydy1x
         doT2u9adq4yD64J92bxYqWR81gvhxD2zQVsz53rki+swMwtG51zop7M4GzLaYW/eV++L
         ZOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697285657; x=1697890457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uG33e0nxABrnJqUhQYBYHy/jJhv1/W7SNJHYJNJkoug=;
        b=HmkucknGZCxZ/FTiIEvLM2ePCSicripRgsc9Z3KJbsWV7q+vmdsUXZ1osEAi4SyL48
         0y3eN+DvGEBdhWtmI4z2emv25TWwYNkobBCR0t4zPUTLroIBYjta2EmIYlainqx+80+1
         c4+nJI1wGGcPw4ucFi80LKEmEASmFh6RZ7APZXtnDkRrKs+2u7mk1yDxfXvEAcjKxJEv
         JBuYtF1r0D2CyuGnkKwX9P7wlDfdZsBA0EEqw+EUdcKyern0UFywlrzCgVoiKno/qJ8F
         eR+Fn7QADrBCvN1Bx0HvREAF+JhviCFpWO336wmwb25FSLH+BkGlWDLxzvFQxOXTgqN3
         P7BQ==
X-Gm-Message-State: AOJu0YzsPACu5BVND6d97upmsCBlxZ5WoDnWP8qKa9hQBuUPsDr8+TAt
        FHVMszO/18VaDc9im8pOTIhmxKkXn9om1A==
X-Google-Smtp-Source: AGHT+IHkzHlCoBuFGZIRlA4qwWaR028lBtYd4Zx8ozo5sQ/1LK2h4MhitgSNJYPdNYDwQW+VmdqoxA==
X-Received: by 2002:adf:f80e:0:b0:32d:a4d0:1364 with SMTP id s14-20020adff80e000000b0032da4d01364mr1271830wrp.29.1697285656498;
        Sat, 14 Oct 2023 05:14:16 -0700 (PDT)
Received: from localhost.localdomain ([111.88.101.202])
        by smtp.gmail.com with ESMTPSA id di10-20020a0560000aca00b0032d2f09d991sm7614614wrb.33.2023.10.14.05.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 05:14:16 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     m.chetan.kumar@intel.com, linuxwwan@intel.com,
        loic.poulain@linaro.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] drivers: net: wwan: iosm: Fixed multiple typos in multiple files
Date:   Sat, 14 Oct 2023 17:14:07 +0500
Message-Id: <20231014121407.10012-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iosm_ipc_chnl_cfg.h: Fixed typo
iosm_ipc_imem_ops.h: Fixed typo
iosm_ipc_mux.h: Fixed typo
iosm_ipc_pm.h: Fixed typo
iosm_ipc_port.h: Fixed typo
iosm_ipc_trace.h: Fixed typo

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 drivers/net/wwan/iosm/iosm_ipc_chnl_cfg.h | 2 +-
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.h | 4 ++--
 drivers/net/wwan/iosm/iosm_ipc_mux.h      | 2 +-
 drivers/net/wwan/iosm/iosm_ipc_pm.h       | 2 +-
 drivers/net/wwan/iosm/iosm_ipc_port.h     | 2 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.h    | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_chnl_cfg.h b/drivers/net/wwan/iosm/iosm_ipc_chnl_cfg.h
index e77084e76718..fdc211bbeda7 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_chnl_cfg.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_chnl_cfg.h
@@ -51,7 +51,7 @@ struct ipc_chnl_cfg {
 /**
  * ipc_chnl_cfg_get - Get pipe configuration.
  * @chnl_cfg:		Array of ipc_chnl_cfg struct
- * @index:		Channel index (upto MAX_CHANNELS)
+ * @index:		Channel index (up to MAX_CHANNELS)
  *
  * Return: 0 on success and failure value on error
  */
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
index 026c5bd0f999..6bd0290e8be7 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
@@ -36,8 +36,8 @@
 /**
  * ipc_imem_sys_port_open - Open a port link to CP.
  * @ipc_imem:	Imem instance.
- * @chl_id:	Channel Indentifier.
- * @hp_id:	HP Indentifier.
+ * @chl_id:	Channel Identifier.
+ * @hp_id:	HP Identifier.
  *
  * Return: channel instance on success, NULL for failure
  */
diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux.h b/drivers/net/wwan/iosm/iosm_ipc_mux.h
index 17ca8d1f9397..db5f1f9ebf26 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux.h
@@ -432,7 +432,7 @@ int ipc_mux_open_session(struct iosm_mux *ipc_mux, int session_nr);
 int ipc_mux_close_session(struct iosm_mux *ipc_mux, int session_nr);
 
 /**
- * ipc_mux_get_max_sessions - Retuns the maximum sessions supported on the
+ * ipc_mux_get_max_sessions - Returns the maximum sessions supported on the
  *			      provided MUX instance..
  * @ipc_mux:	Pointer to MUX data-struct
  *
diff --git a/drivers/net/wwan/iosm/iosm_ipc_pm.h b/drivers/net/wwan/iosm/iosm_ipc_pm.h
index e7c00f388cb0..5f14d7932af9 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_pm.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_pm.h
@@ -172,7 +172,7 @@ bool ipc_pm_prepare_host_sleep(struct iosm_pm *ipc_pm);
 bool ipc_pm_prepare_host_active(struct iosm_pm *ipc_pm);
 
 /**
- * ipc_pm_wait_for_device_active - Wait upto IPC_PM_ACTIVE_TIMEOUT_MS ms
+ * ipc_pm_wait_for_device_active - Wait up to IPC_PM_ACTIVE_TIMEOUT_MS ms
  *				   for the device to reach active state
  * @ipc_pm:	Pointer to power management component
  *
diff --git a/drivers/net/wwan/iosm/iosm_ipc_port.h b/drivers/net/wwan/iosm/iosm_ipc_port.h
index 11bc8ed21616..d33c52aebf66 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_port.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_port.h
@@ -18,7 +18,7 @@
  * @pcie:		PCIe component
  * @port_type:		WWAN port type
  * @channel:		Channel instance
- * @chl_id:		Channel Indentifier
+ * @chl_id:		Channel Identifier
  */
 struct iosm_cdev {
 	struct wwan_port *iosm_port;
diff --git a/drivers/net/wwan/iosm/iosm_ipc_trace.h b/drivers/net/wwan/iosm/iosm_ipc_trace.h
index 5ebe7790585c..3e7c7f163e1d 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_trace.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_trace.h
@@ -29,7 +29,7 @@ enum trace_ctrl_mode {
  * @ipc_imem:		Imem instance
  * @dev:		Pointer to device struct
  * @channel:		Channel instance
- * @chl_id:		Channel Indentifier
+ * @chl_id:		Channel Identifier
  * @trc_mutex:		Mutex used for read and write mode
  * @mode:		Mode for enable and disable trace
  */
-- 
2.27.0

