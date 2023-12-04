Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78C6803FCF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346201AbjLDUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjLDUfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:35:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE0D2685
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:34:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D512C433C7;
        Mon,  4 Dec 2023 20:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722070;
        bh=8SAQFhl1WNO7lMXy+iuBPzv3y+k5QbJiqIb5Kk4ciFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HiYRLuG0XWKtDOmjvp8BMXSXHLWIy+l6cgr+tErZ6pUZ2Z/j9aiKc4CRC9hlmK4xL
         ruTkYS5YwDnuJzmxza9gQgUK++OBhtUayCIoLp5mjnAabNpmJXdO7tRN1W5Ct0LYC/
         wH6pU/J1jLutRyZsm0X4Wh9gpEQWyhJmtfZH+mduEkLFDeSl2P83E33Io80L61T8Rm
         vvIof37LsWCYmquW0OF/czic/apwVdOyjR6kYiqTGUDSIMAKMxVDsp/Q9A8OxyB1G1
         kYi+RLN5Gn9N7apFkbrkkSnc/2G0UlglKiusLhcW8aCiyVUjuY7bx1BP2x7yUH6xiC
         Nw+26H5NQs7LA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mukul Joshi <mukul.joshi@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Felix.Kuehling@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 24/32] drm/amdkfd: Use common function for IP version check
Date:   Mon,  4 Dec 2023 15:32:44 -0500
Message-ID: <20231204203317.2092321-24-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
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

From: Mukul Joshi <mukul.joshi@amd.com>

[ Upstream commit 2f86bf79b63dbe6963ebc647b77a5f576a906b40 ]

KFD_GC_VERSION was recently updated to use a new function
for IP version checks. As a result, use KFD_GC_VERSION as
the common function for all IP version checks in KFD.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index fa24e1852493d..df7a5cdb8693f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1128,7 +1128,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 	struct kfd_dev *dev = adev->kfd.dev;
 	uint32_t i;
 
-	if (adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 4, 3))
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3))
 		return dev->nodes[0];
 
 	for (i = 0; i < dev->num_nodes; i++)
-- 
2.42.0

