Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561227D3BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjJWQF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjJWQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:05:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1585910D;
        Mon, 23 Oct 2023 09:05:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DB4C433C8;
        Mon, 23 Oct 2023 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698077152;
        bh=rsdBpDp3RXcMnY1Y8bJLNbH0IoXz+q0JDXqgZCh8R3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDIxQ4aXY28mYhgeBoKUkAaWIKehUEhKwHGVdlqPlHjBx8ZACUP0ilYGo5EUNmauI
         7oArSePao6D3uH3ld0IL84YcNO1B4VWzszoiT0pPsKsdNEfgyvYAEu0P5npvOGyAuw
         6DmfRN9QEH1FUMkbYAuybaOozq0EliKV3SSODPhDBePi21UoncKecE8nsTyKXW8uMv
         hOtykMbEFxhkg95hTh6w1O7R5MWHz2JyPCMn1UnfZcUApeqBl1CiYwTPR2dkSEvy+d
         +J31ChpnJOBzoexxVqNKx3pzpSvvRlnivjAOQJ7pwlCo/Qre9OKpyk9tNyTUkMloB3
         d4pjfvyLsgxYA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Martin Tuma <martin.tuma@digiteqautomotive.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: pci: mgb4: remove bogus 'select' statements
Date:   Mon, 23 Oct 2023 18:05:32 +0200
Message-Id: <20231023160539.1537355-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023160539.1537355-1-arnd@kernel.org>
References: <20231023160539.1537355-1-arnd@kernel.org>
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

As this is just a regular device driver, it has no business force-enabling
other drivers in the system, it should be entirely independent of the
implementation of the spi-nor layer or the specific DMA engine.

The IIO symbols that are selected here are library modules that
are legitimately used.

Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/pci/mgb4/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/pci/mgb4/Kconfig b/drivers/media/pci/mgb4/Kconfig
index f2a05a1c8ffa..b90347c7f19b 100644
--- a/drivers/media/pci/mgb4/Kconfig
+++ b/drivers/media/pci/mgb4/Kconfig
@@ -6,10 +6,6 @@ config VIDEO_MGB4
 	select VIDEOBUF2_DMA_SG
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-	select I2C_XILINX
-	select SPI_XILINX
-	select MTD_SPI_NOR
-	select XILINX_XDMA
 	help
 	  This is a video4linux driver for Digiteq Automotive MGB4 grabber
 	  cards.
-- 
2.39.2

