Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3618A808478
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378824AbjLGJTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjLGJTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:19:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE9E1729;
        Thu,  7 Dec 2023 01:19:17 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1241C6607393;
        Thu,  7 Dec 2023 09:19:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701940756;
        bh=qmAKEwMzQObcjLEImfox96rI8rjtke8mQ615PmXpD6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGVnA638sMEQ9HaGHUDUvuHtJ5Xh/906YK6hhJu/GIKx7xqGz7Fojo1t+eMsIo5cq
         rMm+GieXrh/Zht8XyARJl/XABeOOMRifvopgH/WD0JmvyJQjvWoCbstPi3IE3q6R0D
         mtTI1ZXW4A+5IuYkMxm8A45j9/BXIyp2rKV5UsbUw24i/os8twuWB91V6u2nfnZiqJ
         bCV0ox19vmwdGqlYDSkhoCtEG3ZaJ9wi1gCz5uOfEYQBigzgpy6uKGVdRfUKZy665k
         W1A97teFWuaU3HCzcXXtkaM4EqRU7R+1TCT3LFNHZrwI9fLPxuk89Vg9OIGh1cUcZ1
         /GNyhEhXCKx2A==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 09/10] drm/doc: ci: Add IGT version details for flaky tests
Date:   Thu,  7 Dec 2023 14:48:30 +0530
Message-Id: <20231207091831.660054-10-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207091831.660054-1-vignesh.raman@collabora.com>
References: <20231207091831.660054-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the IGT version in the flaky tests reporting template.

Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v6:
  - Added a new patch in the series to update drm ci documentation

v7:
  - No changes

---
 Documentation/gpu/automated_testing.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/automated_testing.rst
index 240e29d5ba68..2d5a28866afe 100644
--- a/Documentation/gpu/automated_testing.rst
+++ b/Documentation/gpu/automated_testing.rst
@@ -69,14 +69,15 @@ the result. They will still be run.
 
 Each new flake entry must be associated with a link to the email reporting the
 bug to the author of the affected driver, the board name or Device Tree name of
-the board, the first kernel version affected, and an approximation of the
-failure rate.
+the board, the first kernel version affected, the IGT version used for tests,
+and an approximation of the failure rate.
 
 They should be provided under the following format::
 
   # Bug Report: $LORE_OR_PATCHWORK_URL
   # Board Name: broken-board.dtb
-  # Version: 6.6-rc1
+  # Linux Version: 6.6-rc1
+  # IGT Version: 1.28-gd2af13d9f
   # Failure Rate: 100
   flaky-test
 
-- 
2.40.1

