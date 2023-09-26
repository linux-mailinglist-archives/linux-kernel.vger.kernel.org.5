Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670BC7AE7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjIZIOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjIZIOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:14:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DCEB4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:13:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A31C433C7;
        Tue, 26 Sep 2023 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695716035;
        bh=kovFpRcan5fPXYAx/LeKp5+4tn0cbVZMFIjVCi84H3s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DauZIdmLV6XvDKn1Zi6JhgBVcEwwstjxEzXkni7SQtCzFA01YKgc823ARNkcV4Tfn
         7lYtiexYQ6BhD+BvBLNGfqqR9H5ksaUZPMbftwrw4ev855iqAa+uQ+DxWnn4rb4qJ/
         pg0SQ6quqkTvIz5nwfxSRpiCpPsTReUXWHKW8ulQAvPw5Xw8A+RIeY6cVTIkaPd4Ob
         Vgw6YSp7N9Mzklzr27CE+t/kUWbCQYmGahVjVD7cqBOGgHTLFbr2Tba4nFsKNsRZ0E
         6V/NY/BCHNR7tnJbCeDfXX/c1WMSemJm1vaJ4DUYJjho9FmzEkdQ0qLSAMpPEP7j0A
         CJrr6/r4tdAag==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] accel/habanalabs: remove unused field
Date:   Tue, 26 Sep 2023 11:13:41 +0300
Message-Id: <20230926081345.240927-5-ogabbay@kernel.org>
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

flags in struct wait_interrupt_data is not used anywhere so remove it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/command_submission.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index 751d2c7d3fb8..e5ca490b7fca 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -47,7 +47,6 @@ struct wait_interrupt_data {
 	u64 cq_offset;
 	u64 target_value;
 	u64 intr_timeout_us;
-	unsigned long flags;
 };
 
 static void job_wq_completion(struct work_struct *work);
-- 
2.34.1

