Return-Path: <linux-kernel+bounces-6353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3840F81979E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FCD28872C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EECC13D;
	Wed, 20 Dec 2023 04:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GYjGfUJI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGQp/efh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571581D696
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 589803200A34;
	Tue, 19 Dec 2023 23:18:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 19 Dec 2023 23:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703045894; x=
	1703132294; bh=pMmsyjj7nl7WSS15wYh422IW+VbkrnpbXUDIHZjOSwQ=; b=G
	YjGfUJIhOJwkHSqDxieXHzEPhT+uOTQscQGYgEka7MhjZppnj5HTzRFUOEtxHHVe
	be6F3CP0puIHkQJL7AxFJ7k3tIiIrCuNpz2nXkcgYFdWnDGNTlc99zDL8WDW0R3Y
	zLzfzudvUwIhKXolc2SdhFTo9pOlviU3C9wY1pjM017YBCdfosCqv1/y2OTQ73ex
	GQuCz7+cmyKT8/3v0KaH5BPifs15G+nvCbR+IGMTLzMd2XKSDa4krTqD4CzuX+Oy
	fQtmQUfnlSZsrfsBgxGtrPNDOu59gaax6rqlT4ROjYCVE7+O1IHgoL5LbZg2NKOt
	IazKAUfpulyKJC11yNBMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703045894; x=
	1703132294; bh=pMmsyjj7nl7WSS15wYh422IW+VbkrnpbXUDIHZjOSwQ=; b=Z
	GQp/efhkgdyUbPGQOWeMq/CEghPDvKbrA5QSoFY4y8psrSDskmRRkrmO1Sx7o5Vs
	rtVwgYP6XB45uqk9P8lF00uBonBewbb3weHmmYwHcx3DNj3d80FU8WiOMPHuqnMM
	18PMtwCZ4L+cXqdwZGiostS3JNTWyWB08u+Tds6kuIMpjeyCwO2Gw0epAdaLDHjh
	hZyAKG2gTHSkF5wi1G7cfqILuaR2qztr532y4oIfiUh8FKNHUpz3RY7Xu2hQjiOt
	YCRMcwIxaG7AyGXgbtYHm6zXjNS8ULErNWrf4OcR+K98AP3FY+veRc/JE8b5K3L3
	+0rAQgpjitcwQakQIzGoQ==
X-ME-Sender: <xms:BmuCZQuwJxqHnA5yEo5fchnB1ld8CiIkITBuP7MLPsM4Eskbe9HDaQ>
    <xme:BmuCZdfyKedmLuHVf7Cl-PkywyEDr6N1JqYu9hz9sHFJsRZ_mmYE49gLd1OkrBbSZ
    AnTZAkCTdahbIfmAPU>
X-ME-Received: <xmr:BmuCZbznnWTE0bhHc-nIxFJGrINO74rHPC8crk0YsdDN5KiiZt_t6_OSV7p2hykxtBlMA6KyaivHk7b0KFg3GtRRwhn7yskcnSl05asb-qnJBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:BmuCZTP_oaNFAcffZaSDIvln13o1nsOt_kEE4lXBeeVv5kDVc1a-3Q>
    <xmx:BmuCZQ8_ifDqRnqpjFogeTLPQc2PmdgWItud-hMduH28C4b1SzHSiw>
    <xmx:BmuCZbXv0V3SCJy7UdXjw4xqm88dfETVhkvkv7MdlrGbLeLHagoOAg>
    <xmx:BmuCZemdGGBDkNuD5bJKFjsMoKv_bMx0dB3cJBr3s-s0BObGQMjwrw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 23:18:13 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH 1/8] firewire: core: adds constant qualifier for local helper functions
Date: Wed, 20 Dec 2023 13:17:59 +0900
Message-Id: <20231220041806.39816-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220041806.39816-1-o-takashi@sakamocchi.jp>
References: <20231220041806.39816-1-o-takashi@sakamocchi.jp>
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
index eeda7cc59e27..96b0b43da863 100644
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


