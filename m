Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9837AFBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjI0HVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjI0HVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:21:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF410E;
        Wed, 27 Sep 2023 00:21:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A650C433C7;
        Wed, 27 Sep 2023 07:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695799293;
        bh=TvYNB+3F24ELcD9mVneJy07mTn3mHrunWhOd2Ry3R5I=;
        h=From:To:Cc:Subject:Date:From;
        b=fBuKlV1rQLt6hdVwyObNGLVV/SlX5W51lp1K3JoBM93EKu3ImzRnLviMtS5eNmO/N
         SEojQFwSykRk+DeV7SoWC2ZsEfrMnS7k1BuuRAJ7LTM+22DYVg8A+mbietuXKkQ/oX
         Y/35Zht892YLU/ddfO2pOD8T5VzkXmk007xytX5FUnUuSZ4KAp4oTWBVPcutpJYLSH
         qosJgsRCS/FmZwZhfYu6SB/+yJNHBRZzZI0e9AiiuoE4ssQv3w0c6ZwYKaJGweyBP1
         7mGZfq0xiFqHH6dT07Wd105eNb5oOrpmUi57KAE2LZpx+RDQ/A9lzndYuPAszQhDrI
         SgMmKkc6WhDmw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wentong Wu <wentong.wu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: pci: intel: ivsc: select V4L2_FWNODE
Date:   Wed, 27 Sep 2023 09:21:19 +0200
Message-Id: <20230927072127.2529885-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

Some missing select statements were already added back, but I ran into
another one that is missing:

ERROR: modpost: "v4l2_fwnode_endpoint_free" [drivers/media/pci/intel/ivsc/ivsc-csi.ko] undefined!
ERROR: modpost: "v4l2_fwnode_endpoint_alloc_parse" [drivers/media/pci/intel/ivsc/ivsc-csi.ko] undefined!
ERROR: modpost: "v4l2_fwnode_endpoint_parse" [drivers/media/pci/intel/ivsc/ivsc-csi.ko] undefined!

Fixes: 29006e196a566 ("media: pci: intel: ivsc: Add CSI submodule")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/pci/intel/ivsc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/intel/ivsc/Kconfig b/drivers/media/pci/intel/ivsc/Kconfig
index 0acea4678fc0d..6a2995b02d274 100644
--- a/drivers/media/pci/intel/ivsc/Kconfig
+++ b/drivers/media/pci/intel/ivsc/Kconfig
@@ -7,6 +7,7 @@ config INTEL_VSC
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_ASYNC
+	select V4L2_FWNODE
 	help
 	  This adds support for Intel Visual Sensing Controller (IVSC).
 
-- 
2.39.2

