Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7467DF9A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346798AbjKBSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345507AbjKBSLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:11:46 -0400
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 11:09:56 PDT
Received: from mail.asbjorn.biz (mail.asbjorn.biz [185.38.24.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E571AA;
        Thu,  2 Nov 2023 11:09:55 -0700 (PDT)
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
        by mail.asbjorn.biz (Postfix) with ESMTPSA id 5AE5E1C0A98D;
        Thu,  2 Nov 2023 18:00:58 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
        id BFC40203FD8; Thu,  2 Nov 2023 17:59:34 +0000 (UTC)
From:   =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>,
        Muhammad Sammar <muhammads@nvidia.com>,
        Alex Vesker <valex@nvidia.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: Fix reserved at offset in mlx5_ifc_fte_match_set_lyr_2_4_bits
Date:   Thu,  2 Nov 2023 17:59:22 +0000
Message-ID: <20231102175924.3456007-1-ast@fiberby.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A member of struct mlx5_ifc_fte_match_set_lyr_2_4_bits has been mistakenly
assigned the wrong reserved_at offset value. Correct it to align to the
right value, thus avoid future miscalculation.

Fixes: 5c422bfad2fb ("net/mlx5: DR, Add support for matching on Internet Header Length (IHL)")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/linux/mlx5/mlx5_ifc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 4df6d1c12437..09c50e786ff4 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -552,7 +552,7 @@ struct mlx5_ifc_fte_match_set_lyr_2_4_bits {
 
 	u8         reserved_at_c0[0x10];
 	u8         ipv4_ihl[0x4];
-	u8         reserved_at_c4[0x4];
+	u8         reserved_at_d4[0x4];
 
 	u8         ttl_hoplimit[0x8];
 
-- 
2.42.0

