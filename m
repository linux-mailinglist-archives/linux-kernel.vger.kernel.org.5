Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCFC77D470
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbjHOUjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbjHOUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:39:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194D81FDE;
        Tue, 15 Aug 2023 13:38:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68843478de1so1393506b3a.2;
        Tue, 15 Aug 2023 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692131925; x=1692736725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJeWs7OIKGn73IJs1PM36gTbz2x+r9RPQj8hIDzad/M=;
        b=HfUT5l7I62xsvopeaD8BGGwBUhmHjk5ZrKhZcnEp8L/aFgA+whMbnMH/+5Qq+NB1tf
         ZddeF0EaAn1xkgtFedCqwdgVJ2wagrh1B02ZEwLyJ4QdvGoirbiJ29jXLwFXzntnlUx2
         3PmYJ2344RVB98h6xyDwyRv8pMOPe2kYuSvpmsx5Rru8VCBmTgkGmAwGPnEk7+LQpba2
         +KyMDOjMORHzN1UTYkeEaUgXzcMkREOEYZt6s0uqlm4cQhzI2r43X1iqxJE9uKmK/su7
         tMJ7y9x1OOx2drRGeB9S9kVTllntPkB5L5dWbTRKDwUCk/cjD8UlKUCuwpo2zLPKYYBE
         ooLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131925; x=1692736725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJeWs7OIKGn73IJs1PM36gTbz2x+r9RPQj8hIDzad/M=;
        b=A9cQPao17hrUKMhGWn7+IGobSY+Y/z9gGs7sq/6HJpNP2Ri3rAKZoIbrmhBA4CQsRb
         7CFOmnBQugbQM+VLNgazbMao3i5YQcth+gE/L7Qbk+RfV38HSr9v5bL73ZgMghxOdE2f
         yQd06QE5zxANyrPp8nycmX2khI2m+XhJGV9DMtys0dBVfmofbTziwmqH5QL6xjCHi7rJ
         kIsNnRw3hnrVhuJC3G5H12hdhMbxRp39Z9p8dq5QfL+VyeUovDxtZ+QQasZnGY+Y+53c
         gK0ptCVJ4wvevz6+rax/cfBznjQlY9betAI6I2fidvIQThYX7vPhjm15SINfYFCdQXAb
         Wd2A==
X-Gm-Message-State: AOJu0Yxsy4gVcs77vpmUG2me+uoC7tVaymPv3t/UtiNxlVOX04W3Z/Jc
        71U9bNTF+rDA03EJS96Q3ks=
X-Google-Smtp-Source: AGHT+IFc1LRiANzrNsf5rx6y5C6zzyXMDlr1dYucQRbdZUauvCc5sHZfGvLPCyFV6viQg5k+619Pwg==
X-Received: by 2002:a05:6a00:852:b0:64a:2dd6:4f18 with SMTP id q18-20020a056a00085200b0064a2dd64f18mr15865171pfk.13.1692131925419;
        Tue, 15 Aug 2023 13:38:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:db85:3caf:1429:e455])
        by smtp.gmail.com with ESMTPSA id k17-20020aa792d1000000b00686236718d8sm9571122pfa.41.2023.08.15.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:38:45 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     shubhrajyoti.datta@amd.com, sai.krishna.potthuri@amd.com,
        bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, michal.simek@amd.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Subject: [PATCH v1] drivers: edac: Drop unnecessary error check for debugfs_create_dir
Date:   Wed, 16 Aug 2023 02:08:26 +0530
Message-Id: <20230815203826.51792-1-atulpant.linux@gmail.com>
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

This patch removes the error checking for debugfs_create_dir.
Even if we get an error from this function, other debugfs APIs will
handle the error value and doesn't crash in that case. Hence caller can
safely ignore the errors that occur during the creation of debugfs nodes.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 drivers/edac/zynqmp_edac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
index cefbbafb945e..a8449f0711d7 100644
--- a/drivers/edac/zynqmp_edac.c
+++ b/drivers/edac/zynqmp_edac.c
@@ -351,8 +351,6 @@ static void setup_debugfs(struct edac_device_ctl_info *edac_dev)
 	struct edac_priv *priv = edac_dev->pvt_info;
 
 	priv->debugfs_dir = edac_debugfs_create_dir("ocm");
-	if (IS_ERR(priv->debugfs_dir))
-		return;
 
 	edac_debugfs_create_x32("inject_fault_count", 0644, priv->debugfs_dir,
 				&priv->fault_injection_cnt);
-- 
2.25.1

