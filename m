Return-Path: <linux-kernel+bounces-8526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9532481B908
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF2CB27BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A406D6DA;
	Thu, 21 Dec 2023 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XczRfcSE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqRp/tCq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E365197
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 3484E5C0114;
	Thu, 21 Dec 2023 08:48:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Dec 2023 08:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703166534; x=
	1703252934; bh=pMmsyjj7nl7WSS15wYh422IW+VbkrnpbXUDIHZjOSwQ=; b=X
	czRfcSEBVlloJN/YhhcuwM+UlSYI5kpcd/1kDb/B9uf3DwnnTlzSSFAWJTEFTanw
	J5GY7lkfQQ0lNsdPFt3McVMRqPP7yVAs8w6QXl7x3QxTkS6WttSMSG07mK4eOUnT
	VfJw35KyE242ByG3KG2lrscv2TBwVdCrjImV8mU5zG4cV+iYlafWSOjddlNV1PIM
	amkg18/kitraeT6Tvcj9QWnrbomgKbfCmvY2h38w6Z1RmpaQmfNiHBjP62RlL4Oa
	of0EFVa1H3KYjGnRwU0a1ztg3XEVmxpFH9hPHO9jzADMqMIoeEe/N3vLy9x2zRgo
	Su0DXnNRLo7TruwLdaiAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703166534; x=
	1703252934; bh=pMmsyjj7nl7WSS15wYh422IW+VbkrnpbXUDIHZjOSwQ=; b=I
	qRp/tCqosguPNNDC3p+wLS8QYcc/DWxOEKRO93JCCM5CmpwdBy5vmMUc8iFqYe5i
	EgjaWj0e8698yCDelUAwjbm7v6NoNQ7+jSr6MdTtRd5yCNGx8QzjpyziPQDd7UOd
	HC0kQmLKZOr8hZkmHeeH2cKjYxhk3CZ2s7l7L5rHFU91Tu1IiCAgWFnOH7gHZMzp
	/5rrcu60diGNaa7BhRHwEqlc+S4856CNHD09+LbLYodF3HbPDcZ8NApj8JLB8OuN
	ebSLy/x3TwXLcFhkaYYnbScmaL0RrMDP8MVWPPuRBkt37E+e5bkZcu75UyYpTWSF
	cjpr8VC/eZFw9EZ5Jk5WQ==
X-ME-Sender: <xms:RkKEZTM5e4q9eu6BcHGYSjR2y16AzJciKZZtdsJqr8pBdyoeGk5rqQ>
    <xme:RkKEZd9I1egaYENCoTo80YxOJhsxoukNftZA1INjnsHyp16yUwrw1hVGUHd0j9EuL
    n7d1CQRL7qC_HsTuxE>
X-ME-Received: <xmr:RkKEZSS5PEnHR1fsnniXsi9XogODJrW361nFjbB4gy0p_uwiq5yvmTw6PE4sQLWrx9C7qVr8lA3x7HPqBu7LmU2TPIcC3XBNOiGuUwe3iq-Ekw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:RkKEZXuYROci7VwygWqNMRGnuXt1Ag5_3pj40bCG-yTRPALoyMEzWA>
    <xmx:RkKEZbcy25AVfO9DGCjuljHrh2vgRMHcaeUR0bmUHWX4LK-QiwgR_w>
    <xmx:RkKEZT2ef5C_9t2GeDWIOctSrquoL6Leas2QbjnkL3q7rmy_o6JNYQ>
    <xmx:RkKEZTEYqvTAqcG8fUbnQC45hkHnp1xzjhJY_Vz-pNmc2VeS5a4AiQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:48:52 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH v2 1/8] firewire: core: adds constant qualifier for local helper functions
Date: Thu, 21 Dec 2023 22:48:42 +0900
Message-Id: <20231221134849.603857-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221134849.603857-1-o-takashi@sakamocchi.jp>
References: <20231221134849.603857-1-o-takashi@sakamocchi.jp>
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


