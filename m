Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0747E6E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbjKIQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343567AbjKIQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:18:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235D1358C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:18:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32fa7d15f4eso658154f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699546711; x=1700151511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQTXl6Zu6Uy1kHuaX8me13xEm3/yUTPeeI94ANaTAbI=;
        b=lBfb5K8R2lrCeSk/gEWICZEFcyaZsZymvPamcg0BdxTHImcGbUW76znPypNMCW7iaT
         w67ySEG29zeOpZGTEPjA++1LHACPwLBGDxkIHBTCrbnn3Sd0+Iyyrb5Fg1GxhmJuWwnj
         DydeaGnUBFf2fy5GPnxzTD3BVBLsD1LH4Ie3Fz9+qQsrx/j9FrT+M4f/q0/nvKMrqSwM
         dv7k12Jv1CIYbZoAYjlVqlIW4VfKxs/rtwaYWGPhNJieopTv5K96bFV/ugoB2bf/E1GI
         ueoBCYutD1NLof9BjiPmCuh1TAjP3l4cW2WRbERLV5ypm+qSwVq0AV3zEX0Ek893d8kW
         VaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699546711; x=1700151511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQTXl6Zu6Uy1kHuaX8me13xEm3/yUTPeeI94ANaTAbI=;
        b=cjQjtxur9pwrlwpDvNWFYuJqtskKnRnySLEFydwfFKtte+IEPNu+zUwG8E5ePlx/NL
         gU0CIs1vEJPldjiNpO1ulUx+zAcwvrMEmgk/AFnqH+qSXViCmECSLfBA3f8gdvxTTden
         IFgazIZrGH9vLUBSpT5WUhHDm5hbBnWXMV6cCJw8N5uLxVdKhVhiD6ui3oycb3pO3OZt
         I0f1haS1R9f46KLCI0OXn9mDsqP4SxMu02Np2owktisaK8Zyyumm/1vRoCwIYt6JMEip
         aTRfhpEH/MNhbtjmRhg09pzZPDgteODlJ3YONLVHUuuVmvIlBd+5BDn7cwb/BzMAcMQN
         AtCw==
X-Gm-Message-State: AOJu0Yza09UF8hattyz7KJM3RX4kC6JkozgqqoBLXa8pzVQdBRPwktTc
        XDBge1ZNReBh40Oxk9ymZbf/cXXzo/8=
X-Google-Smtp-Source: AGHT+IHexaKgLQ/GGGhfb5Y28I8HrRRB5wZXhQW61rrmynZ6/h89ybsaD3BBKLw89E3WOB2OvdQDtg==
X-Received: by 2002:adf:e10b:0:b0:317:393f:8633 with SMTP id t11-20020adfe10b000000b00317393f8633mr4298453wrz.58.1699546711199;
        Thu, 09 Nov 2023 08:18:31 -0800 (PST)
Received: from localhost.localdomain ([212.187.182.165])
        by smtp.gmail.com with ESMTPSA id h6-20020adfe986000000b003200c918c81sm7593363wrm.112.2023.11.09.08.18.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Nov 2023 08:18:30 -0800 (PST)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     Liam.Howlett@oracle.com
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] maple_tree: change return type of mas_split_final_node as void.
Date:   Thu,  9 Nov 2023 16:08:22 +0000
Message-ID: <20231109160821.16248-2-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_split_final_node always returns true and there is no usage
for checking return value.

change return type as void.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 lib/maple_tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb24d84a4922..9389a631483a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3167,7 +3167,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
  * @mas: The maple state
  * @height: The height of the tree in case it's a new root.
  */
-static inline bool mas_split_final_node(struct maple_subtree_state *mast,
+static inline void mas_split_final_node(struct maple_subtree_state *mast,
 					struct ma_state *mas, int height)
 {
 	struct maple_enode *ancestor;
@@ -3191,7 +3191,6 @@ static inline bool mas_split_final_node(struct maple_subtree_state *mast,
 	mast->l->node = ancestor;
 	mab_mas_cp(mast->bn, 0, mt_slots[mast->bn->type] - 1, mast->l, true);
 	mas->offset = mast->bn->b_end - 1;
-	return true;
 }

 /*
--
2.39.2
