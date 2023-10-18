Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681BB7CE18D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjJRPqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbjJROYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:24:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E74EF9;
        Wed, 18 Oct 2023 07:16:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98611C433CA;
        Wed, 18 Oct 2023 14:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638591;
        bh=WUYQ/WTkvAq4qgNfJHerqnwcH1dHHxTT21MXs/5QBLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVsCt1ssZDdireh4Uf5FaIoRMX2LnOaLSLPEJNSnunLA64jLkhDrE86rQj45xnqtD
         EnA6iwQxIAf+emPKJ8pR5p9p8I42L3mpWkYHskdiTEbAtq/TzthFd/7jxeBWD588C4
         c1IXVSeNbLiiM1jIjxQ+a0BhFa5fYiDSG+LaYtxSjc88oEV4c65Te6s8A7Z4EKLZPU
         XxeenZ3EcwtFnrEPXdDpuxvLwTp0l54qIBbKL7vYGd5KctimbzRYgwngjgedEF4Qm6
         AC5O4AG1cX5EIr/oD3ZvG2pixCnrg1FyK6iipZjYEIy/LjL55ci39hUi1q55ap5VuI
         qFLK4p6z2s84A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Berndt <matthias_berndt@gmx.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, vi@endrift.com,
        swyterzone@gmail.com, lyude@redhat.com, radon86dev@gmail.com,
        maxwell.nguyen@hp.com, matthias.benkmann@gmail.com,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 6/7] Input: xpad - add PXN V900 support
Date:   Wed, 18 Oct 2023 10:16:11 -0400
Message-Id: <20231018141613.1335848-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141613.1335848-1-sashal@kernel.org>
References: <20231018141613.1335848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.327
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Berndt <matthias_berndt@gmx.de>

[ Upstream commit a65cd7ef5a864bdbbe037267c327786b7759d4c6 ]

Add VID and PID to the xpad_device table to allow driver to use the PXN
V900 steering wheel, which is XTYPE_XBOX360 compatible in xinput mode.

Signed-off-by: Matthias Berndt <matthias_berndt@gmx.de>
Link: https://lore.kernel.org/r/4932699.31r3eYUQgx@fedora
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 9f503c1e74b42..1dbe303354589 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -269,6 +269,7 @@ static const struct xpad_device {
 	{ 0x1038, 0x1430, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
+	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
 	{ 0x1209, 0x2882, "Ardwiino Controller", 0, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0301, "PDP AFTERGLOW AX.1", 0, XTYPE_XBOX360 },
@@ -463,6 +464,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
+	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
-- 
2.40.1

