Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7127CDF71
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbjJROYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjJROXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:23:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD510CE;
        Wed, 18 Oct 2023 07:14:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2BBC433BB;
        Wed, 18 Oct 2023 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638449;
        bh=BnkTXwsX6GF5cR2UX/Fu+68WyAvMKfRujsFKD5vjavs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYCvK1mPEuSE7xpRYB7HEjYgK/xI760N2PvALomSjFdQgTBH6VehHptRUK0tDMc55
         gO6BmLO8uVAarVylB+jnlBOv7/ESnE3LuBH2oPiU8dF+oYHZF/W2+tqt7Zbje+XyAj
         mq9SAEIj+9YWrISft0IsN/eRAze1W2EEdhmoSKhg8cePX5KeuMJXOBodw+5I412aqC
         nOK8OhtQO6PWsP9IMZYIXhSZUhZ+pVhkofh8lTtucfN6LqhNqXKiRna7l3wVEFIvwk
         +JaQkJETjlcdYe46NuTClzAugyUGP75jM6ToxI/adkN4fFCQAbBggiyYK0FBltak1H
         YD+XZVtylql/g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Berndt <matthias_berndt@gmx.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, vi@endrift.com,
        swyterzone@gmail.com, radon86dev@gmail.com, maxwell.nguyen@hp.com,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/19] Input: xpad - add PXN V900 support
Date:   Wed, 18 Oct 2023 10:13:20 -0400
Message-Id: <20231018141323.1334898-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141323.1334898-1-sashal@kernel.org>
References: <20231018141323.1334898-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.58
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
index 76cbcca13c9e9..c19a4d2023805 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -272,6 +272,7 @@ static const struct xpad_device {
 	{ 0x1038, 0x1430, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
+	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
 	{ 0x1209, 0x2882, "Ardwiino Controller", 0, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0301, "PDP AFTERGLOW AX.1", 0, XTYPE_XBOX360 },
@@ -474,6 +475,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
+	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
-- 
2.40.1

