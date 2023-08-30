Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13278D2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 06:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbjH3Exq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 00:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242039AbjH3Exh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 00:53:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F8ACC5;
        Tue, 29 Aug 2023 21:53:33 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.251.226.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 17097DA8;
        Wed, 30 Aug 2023 06:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693371128;
        bh=AQ2hH+jjmRkRNsYwWM1DxgzM04liNAni9ssv/MDPoJc=;
        h=From:To:Cc:Subject:Date:From;
        b=Xu4I+rGCv8tfWDbVcXeTxJNVPjKUcdC7+8htVBxn+E0+33DmUCYXBo6/RRxfoTuhY
         r1TG8g+xBR9mpJPwqdxvcXrASevKsG4o0duqStY98uYk5SU1YRICxyajPudmjbh/bT
         /upQZqf1vD7p8sx9coAUXI3HCDN6COOIGa5Qv88Y=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/2] media: Use v4l2_subdev_get_fmt()
Date:   Wed, 30 Aug 2023 10:23:21 +0530
Message-Id: <20230830045323.71768-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver of imx214 and imx415 uses subdev active state,
there's no need to implement the .get_fmt() operation.
Use the v4l2_subdev_get_fmt() helper instead.

I don't have the sensors, so the patches are compile-tested
only.

Umang Jain (2):
  media: i2c: imx214: Use v4l2_subdev_get_fmt()
  media: i2c: imx415: Use v4l2_subdev_get_fmt()

 drivers/media/i2c/imx214.c | 17 +----------------
 drivers/media/i2c/imx415.c | 11 +----------
 2 files changed, 2 insertions(+), 26 deletions(-)

-- 
2.41.0

