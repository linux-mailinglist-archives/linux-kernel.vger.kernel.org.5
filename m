Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96409812DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443864AbjLNLBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443836AbjLNLBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:01:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2095812C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:01:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7ECC433C7;
        Thu, 14 Dec 2023 11:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702551681;
        bh=yWvb1FzC/LQ0zIM53RNXJVNdCzBlRFmPP4IvR0lED6w=;
        h=From:To:Cc:Subject:Date:From;
        b=aymJVjGZ0c6Wz8Q/9vkMjqb9E9hqLcaMz4j481/++0UIev0aRRPySnWl/1j04B+mj
         Dq++vUTOx5NgqQ+ffd5uv3NhDYtpxjAvu6pb3tih8nN9YnnPI9gcXX1tlvq+HXorqc
         cjS9CP43GzjwxnU2uVBRMPBSz6CYXi5GHV0izKwBoOQeKW4GLgarZ7ORyX/1IHvehK
         OmvBzKO418z3dIrLO9+ExYGyAowAuJ5+Lhqbgfm/EGvvaiTqL/id3M0H9jhOuKWedO
         7uWkY4B6rNwzNXXLiHtAmNfEeb52ZEDKALw6dVebwJ/v1FNpyjf1Hjkh0oWkB9dkAe
         AbIdtAqLOkVGA==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: microchip: mpfs-ccc: replace include of asm-generic/errno-base.h
Date:   Thu, 14 Dec 2023 10:59:57 +0000
Message-Id: <20231214-dipper-earshot-72eef3059961@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=uthDO4MEgzFI/RKi4V+giwgtXg1nFE5ZOPfmIqVEYHc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKlVD7Rr5ubMtU/Uc2Zf+bVZ/Njua47TKsLWcJsL2ueLb H96YsfpjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExEn5+R4XGtr+2aPxKuz3Jv nAl9wvZTm0nkoOCkpKv/PDrz1Z9WMjH8j/8bee3i9YX/8k/Ni9Pp5GQJKmSsNj4kwPbEIKGopOI oEwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
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

From: Conor Dooley <conor.dooley@microchip.com>

As evidenced by the fact that only 2 other drivers include this header,
it is not a normal thing to do. Including the regular version of this
header is far more conventional for drivers.

CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
--
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: linux-clk@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/clk/microchip/clk-mpfs-ccc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip/clk-mpfs-ccc.c
index bce61c45e967..3a3ea2d142f8 100644
--- a/drivers/clk/microchip/clk-mpfs-ccc.c
+++ b/drivers/clk/microchip/clk-mpfs-ccc.c
@@ -4,8 +4,8 @@
  *
  * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
  */
-#include "asm-generic/errno-base.h"
 #include <linux/clk-provider.h>
+#include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
2.39.2

