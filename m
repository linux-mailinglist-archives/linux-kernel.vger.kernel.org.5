Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2744F799477
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346045AbjIIAl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345954AbjIIAk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:40:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B517D2D77;
        Fri,  8 Sep 2023 17:39:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8734C43391;
        Sat,  9 Sep 2023 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219875;
        bh=JyutuEkvzWWYmS16NSQQlRKqp2/RxlEIO30qQ4FAv/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3fd1UkqkTJcJLm+aupLbtRrc3lfKNgn9Y5YN7eKp4mb0qijPLpx1tpS6KACArfx5
         9G1zn0bmtsdAFevromNtT4gc7t24ebXTR5qgazBemE+Zj5bZ1rMQY9OmpTpU4Qqw8Z
         fn1dx8GU1qTKBEivcj+2YHQLpjEvPFum8PX0/yx3GZkZn67fNB99PZD2g+i5R5z5Bb
         5V4ln1b3nRVkqASWUaur3jtT+hE8XQnoNAtqa+T64GlMT+Syv9XNwe0HmCMEtaxzbl
         z/2tAW95Aa3a8w//l0k0xAvrFkTwqgk+8tHQkhbAlgbgbUPd64RIK1puC8Y7vFQ8Dk
         mE8o9cEnLLgZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, yong.zhi@intel.com,
        bingbu.cao@intel.com, djrscally@gmail.com, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 21/25] media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning
Date:   Fri,  8 Sep 2023 20:37:09 -0400
Message-Id: <20230909003715.3579761-21-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003715.3579761-1-sashal@kernel.org>
References: <20230909003715.3579761-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 9d7531be3085a8f013cf173ccc4e72e3cf493538 ]

Initialise timing struct in cio2_hw_init() to zero in order to avoid a
compiler warning. The warning was a false positive.

Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index 3c84cb1216320..e3609cb7c4128 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -354,7 +354,7 @@ static int cio2_hw_init(struct cio2_device *cio2, struct cio2_queue *q)
 	void __iomem *const base = cio2->base;
 	u8 lanes, csi2bus = q->csi2.port;
 	u8 sensor_vc = SENSOR_VIR_CH_DFLT;
-	struct cio2_csi2_timing timing;
+	struct cio2_csi2_timing timing = { 0 };
 	int i, r;
 
 	fmt = cio2_find_format(NULL, &q->subdev_fmt.code);
-- 
2.40.1

