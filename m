Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C587AE7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjIZIOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjIZIOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:14:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA3511F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:13:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16E6C433C7;
        Tue, 26 Sep 2023 08:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695716038;
        bh=b8JoGCZ+fQG0J2KkZ2rDS/O6LpZsi2zykWH7oEBRPBE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ptVd18rGlQAYTKLFtC6pJ2PZYZfFkDljPqar5Q8wDm1xaHdb4LGw1+j/EnIz7dmjy
         u2+AyooLP7Ueuhn5Aoz4j39MXqD0YNcO8IiMz9ooX45Mg63AC6+wuqDzTkfPYCIfrE
         DorC5K4wxftri4ejIhqGdI9fq0X293HgrKms+XSeTDFUv2yeAFMgV9vEXhB1GVIHD9
         3UWJ/g/MdRYEOf/zL7FyJm0Z1XcNk2cf1lhUE6ERkvV/bwvel0N/F/iynbaSRjSV5p
         +017iPhZvgp2AG+N9MNPdw0/wLmVsmwSKs+ZfhKmE+R3G+1ARJ1r0SxpmITRN0j16t
         Tfpkog9lby6Sg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] accel/habanalabs: remove leftover code
Date:   Tue, 26 Sep 2023 11:13:43 +0300
Message-Id: <20230926081345.240927-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926081345.240927-1-ogabbay@kernel.org>
References: <20230926081345.240927-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was added as part of a bigger feature which was never
upstreamed, so remove this code.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/command_submission.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index e5ca490b7fca..4f7b70d9754c 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -1751,16 +1751,11 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 		/* Need to wait for restore completion before execution phase */
 		if (num_chunks) {
 			enum hl_cs_wait_status status;
-wait_again:
+
 			ret = _hl_cs_wait_ioctl(hdev, ctx,
 					jiffies_to_usecs(hdev->timeout_jiffies),
 					*cs_seq, &status, NULL);
 			if (ret) {
-				if (ret == -ERESTARTSYS) {
-					usleep_range(100, 200);
-					goto wait_again;
-				}
-
 				dev_err(hdev->dev,
 					"Restore CS for context %d failed to complete %d\n",
 					ctx->asid, ret);
-- 
2.34.1

