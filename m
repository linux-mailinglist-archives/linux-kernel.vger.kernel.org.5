Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31677FC871
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376615AbjK1VQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376703AbjK1VPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:15:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7263D5BAF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:10:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C2CC433CA;
        Tue, 28 Nov 2023 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205826;
        bh=Ih5yEDk5Isn9e8/MbZccaziuk6foJKqir2R20DQ02sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6nTXZRFqoqzQg1wUjvT2mmdRIagoOdFP5v02mEqvtVqsgZ10FeKfOzVC1jXCE57M
         soMagbLCG0asL/+F9NyWwdaqbdTRFJE3h/G9VAqaxFdqwGLW/Yiqz5uEtLAnWTUbGP
         h/drWPXOu681/nX95zzH5HCIKmqnua79NEJ4ZO61M/gBQgceMCJSDLx0wsiVIVCb9m
         5LSVOo4TsE2DZoxVCxojkyozQr7mh1zRwYp7pz0q83kcMVJ0XNzYuL8Yjx0T/251ss
         B5hYQiGwm3C8lxJRuk8+wzCs1ahY8b+QdV4a6fOv8ibmitILpO8ylN+8IO2egCHhxM
         Cyo3YmKKgGcqQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/7] platform/x86: intel_telemetry: Fix kernel doc descriptions
Date:   Tue, 28 Nov 2023 16:10:13 -0500
Message-ID: <20231128211018.877548-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128211018.877548-1-sashal@kernel.org>
References: <20231128211018.877548-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.331
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit a6584711e64d9d12ab79a450ec3628fd35e4f476 ]

LKP found issues with a kernel doc in the driver:

core.c:116: warning: Function parameter or member 'ioss_evtconfig' not described in 'telemetry_update_events'
core.c:188: warning: Function parameter or member 'ioss_evtconfig' not described in 'telemetry_get_eventconfig'

It looks like it were copy'n'paste typos when these descriptions
had been introduced. Fix the typos.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310070743.WALmRGSY-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231120150756.1661425-1-andriy.shevchenko@linux.intel.com
Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_telemetry_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_telemetry_core.c b/drivers/platform/x86/intel_telemetry_core.c
index 0d4c3808a6d89..a0595fcd945ea 100644
--- a/drivers/platform/x86/intel_telemetry_core.c
+++ b/drivers/platform/x86/intel_telemetry_core.c
@@ -111,7 +111,7 @@ static const struct telemetry_core_ops telm_defpltops = {
 /**
  * telemetry_update_events() - Update telemetry Configuration
  * @pss_evtconfig: PSS related config. No change if num_evts = 0.
- * @pss_evtconfig: IOSS related config. No change if num_evts = 0.
+ * @ioss_evtconfig: IOSS related config. No change if num_evts = 0.
  *
  * This API updates the IOSS & PSS Telemetry configuration. Old config
  * is overwritten. Call telemetry_reset_events when logging is over
@@ -185,7 +185,7 @@ EXPORT_SYMBOL_GPL(telemetry_reset_events);
 /**
  * telemetry_get_eventconfig() - Returns the pss and ioss events enabled
  * @pss_evtconfig: Pointer to PSS related configuration.
- * @pss_evtconfig: Pointer to IOSS related configuration.
+ * @ioss_evtconfig: Pointer to IOSS related configuration.
  * @pss_len:	   Number of u32 elements allocated for pss_evtconfig array
  * @ioss_len:	   Number of u32 elements allocated for ioss_evtconfig array
  *
-- 
2.42.0

