Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21754753158
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjGNFgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjGNFgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:36:13 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5AF2D79
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:35:38 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2Kv96qxWzBR9sT
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:35:33 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689312933; x=1691904934; bh=gK7OprNNceFo1/5i9J6sc3labxZ
        QSM4pPR64BkZs428=; b=l7xv629ePLJGpQM3RAx01xvNGyOjVn+M9SN8p8cXPBV
        2nzy+d40AhZPhM8g4Lg++HheDAKIF+XMBo5DOjjFQS7+QNNoDk9rI7uwUnw3veLE
        8ebRbEQYmsuRo5uNjPh5WjX4JUCKpHRgs9nPh2diq/etCS+TfDLijdsV/YH16K2I
        tyW/cbp6hY6CjThf2sMts6x0YP4gPMAIyfk405Ds5eRDaSLblCU0o26mfDqw3MOK
        rMrmynSEOyQ6Q4fkzXLePRvQ8rA2fkIuIMU1kPn95s62VTYB2f6CrjzEBVXxy43P
        F3bAPwZ+NW9ljx1Hv/RDYpWK854X4YwhD6XTVAWrcuQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O1sVSCOTaab3 for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 13:35:33 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2Kv9304TzBR7bB;
        Fri, 14 Jul 2023 13:35:33 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 13:35:33 +0800
From:   shijie001@208suo.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: "(foo*)" should be "(foo *)"
In-Reply-To: <tencent_16FACBDCDA61595C4219E185613C85C8BF0A@qq.com>
References: <tencent_16FACBDCDA61595C4219E185613C85C8BF0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <26d3424f83f1f394614e2a774d1bf1e9@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix one occurrence of the checkpatch.pl error:
ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/uvd_v1_0.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/uvd_v1_0.c 
b/drivers/gpu/drm/radeon/uvd_v1_0.c
index 58557c2263a7..5684639d20a6 100644
--- a/drivers/gpu/drm/radeon/uvd_v1_0.c
+++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
@@ -142,7 +142,7 @@ int uvd_v1_0_resume(struct radeon_device *rdev)
      addr = (rdev->uvd.gpu_addr >> 32) & 0xFF;
      WREG32(UVD_LMI_EXT40_ADDR, addr | (0x9 << 16) | (0x1 << 31));

-    WREG32(UVD_FW_START, *((uint32_t*)rdev->uvd.cpu_addr));
+    WREG32(UVD_FW_START, *((uint32_t *)rdev->uvd.cpu_addr));

      return 0;
  }
