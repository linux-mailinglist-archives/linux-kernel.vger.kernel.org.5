Return-Path: <linux-kernel+bounces-2526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93D815E74
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78CD6B21E88
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBA16FD5;
	Sun, 17 Dec 2023 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="svQuyeIP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GcoZR86Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAE63DA
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E569F5C00C7;
	Sun, 17 Dec 2023 05:30:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 17 Dec 2023 05:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702809018; x=
	1702895418; bh=1pTTxU/VbzAm0lsOewvACvD5yOw657Fm5X2fzaBqO2I=; b=s
	vQuyeIPK92jI1h59xHID4x1M1mY9Jc9uN0hTwfyXRUs9hkZgsDQVl7oA/tkOjAKA
	sxrTf4XLGx685gMpiAhLuzex0rCYuZX7VLq5hSnZzEfVmS08XfqjYQHS/hLg2Vm7
	zISRUal77Dkt8EWpYbv7vdXTcOiqfalyXJytI+Wc79QcE1LK9gJUa+3NJg6DzXPG
	IDiuZ8MX3h2O+gCGr2nKou3fkfgwmiwJyLEWvxSWO7PIXBeUZMmXs7LoX94OCRN+
	GIqp+tHB8l4Rq1FLwEL7yEtruY3K+S3a2fNlop2qQ0HLtjK0mACpszPPrU7MlG4e
	jBf/Y+mpKmzf/qaAQOatg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702809018; x=
	1702895418; bh=1pTTxU/VbzAm0lsOewvACvD5yOw657Fm5X2fzaBqO2I=; b=G
	coZR86YNxYWIDNJxbKMR78//htusgLWPBhH6Iyg+Mgmiewk/fie4rsvi6EzOalW1
	e+agUOJdeRXHoLQI9oclEVAzDmsxcc9g77+WbdQfj2vK6PcINGXVNFpeEarGRJmT
	9TZID/PR++LQXVDbWlQqoYq2M/xp06aKbRmyrKvqDX5zJ0eXvAOtLI26FSyNj4M1
	4qln2tEtaou5MCTD7tcVvzpBUZem0icJvXX4pyxT7rv3pCC3U6jMtFfwWJi4Rd1m
	Nnoeln/N1M5oPf8JWmh4AL535/mLXExobh7sFXoEqS2pkbQYs41qgycjoGhfEcBa
	WF0htMEfEZNzAHGMyaEdg==
X-ME-Sender: <xms:us1-ZWyXawOTgErjC15bvEl4PUOX7vx2ApzaBtOvkxTdYjS5JzDbtQ>
    <xme:us1-ZSSdYKbXgPjyGshI-qFxKHxNm-2shkjgaO74ExzQsmQ5LpQ2mojIsuZrj7dLD
    3MLbxMzFKUNLzt0O70>
X-ME-Received: <xmr:us1-ZYWY4bDfMSEuIHBONv_WLV0sp9nZ8j6_-ev79GV08P5EeFEOQHsnE-WtwQCBPTxy5jrdlGuysUc78_LJUJ0SEkI5-E8ZvK1R8iAR5G41mQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:us1-ZcjalDRehBSMykIY5ajSN10eNgNBw52_5KmpuDmFszp9fAjCqQ>
    <xmx:us1-ZYCblHyK4Gb_TsEtStlPH-Vmgb-n7IOBfDRG0JuAAhF6ibaLWA>
    <xmx:us1-ZdLR4Wk-i6UjHzvlzrodS5BHa5q31BxNLld-Pvl4ALAwXx_Heg>
    <xmx:us1-ZR53US1jVPDJMjKjEcgW8GTvLGlx4JLL0OzUUx7d1udKVbLIRg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Dec 2023 05:30:17 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [RFC PATCH 1/8] firewire: core: adds constant qualifier for local helper functions
Date: Sun, 17 Dec 2023 19:30:04 +0900
Message-Id: <20231217103012.41273-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217103012.41273-1-o-takashi@sakamocchi.jp>
References: <20231217103012.41273-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some local functions just handles given argument as mutable, thus it is
preferable to add constant qualifier to them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index aa597cda0d88..16c32cb38f0f 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -171,7 +171,7 @@ static const struct ieee1394_device_id *unit_match(struct device *dev,
 	return NULL;
 }
 
-static bool is_fw_unit(struct device *dev);
+static bool is_fw_unit(const struct device *dev);
 
 static int fw_unit_match(struct device *dev, struct device_driver *drv)
 {
@@ -679,7 +679,7 @@ static struct device_type fw_unit_type = {
 	.release	= fw_unit_release,
 };
 
-static bool is_fw_unit(struct device *dev)
+static bool is_fw_unit(const struct device *dev)
 {
 	return dev->type == &fw_unit_type;
 }
@@ -838,7 +838,7 @@ static struct device_type fw_device_type = {
 	.release = fw_device_release,
 };
 
-static bool is_fw_device(struct device *dev)
+static bool is_fw_device(const struct device *dev)
 {
 	return dev->type == &fw_device_type;
 }
-- 
2.39.2


