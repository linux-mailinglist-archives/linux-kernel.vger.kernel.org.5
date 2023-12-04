Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF98035DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbjLDOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjLDOEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:04:02 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC0FD;
        Mon,  4 Dec 2023 06:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1701698643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b0R6n2GdeXzFfYLayCJ7fH/bR9FIh7AyGBXRunAkFdY=;
        b=tOvWWh3xPDptDfio68Mh6k02djeZhZclseZwiQh2JhDB4WZO7JJPTghYXlyr6WfM8/tAo6
        pRlnPuyTZ0RYqSGq5K1pHpYBmGPc3NeMyPNY0zZqIaQXdm24BtObai2Dj/rvhInM7sfg78
        3FmRi2R374pvf3JbMnjc8SwzQ4dhB8c=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/4] axi-dmac: Add support for scatter-gather transfers
Date:   Mon,  4 Dec 2023 15:03:48 +0100
Message-ID: <20231204140352.30420-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

This patchset updates the dma-axi-dmac driver, and introduces the
ability to use scatter-gather transfers, that are now supported by the
IP core.

When using an older version of the core, the driver will simply fall
back to using standard transfers.

The patchset was generated on top of today's linux-next (629a3b49f3f9).

Cheers,
-Paul

Paul Cercueil (4):
  dmaengine: axi-dmac: Small code cleanup
  dmaengine: axi-dmac: Allocate hardware descriptors
  dmaengine: axi-dmac: Add support for scatter-gather transfers
  dmaengine: axi-dmac: Use only EOT interrupts when doing scatter-gather

 drivers/dma/dma-axi-dmac.c | 261 +++++++++++++++++++++++++------------
 1 file changed, 178 insertions(+), 83 deletions(-)

-- 
2.42.0

