Return-Path: <linux-kernel+bounces-123740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B2890D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DD91F26B02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307801465A5;
	Thu, 28 Mar 2024 22:07:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FC146596;
	Thu, 28 Mar 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663665; cv=none; b=Z1bBFa4Ip+/SylVftjmaS44pwSr+uRE1ZXtGqeXiqT8uwoC0R5qf5DB7nznIsG9uB2bKVNowkv54YnwOjfNw8jV3hOYe71OkU4IxV3wis15IHlYT10A37NXUZ6VrBzftQuyLwCbFnDvXK8GkPJjAeHJiE12BqkyhpU7EVEDCOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663665; c=relaxed/simple;
	bh=PxgWr0PvMMYOn7uOXZ9astW2pxgr8a5gyKCWiDPKDjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkL5c3uweIvIG979ODPNMQoiu/O+aYXGrKIEoDQq4bFd9ZIE9MNerF2ff5sB4p97mSD8Hs4/ckwldXRaE1PHKnYM4JBa/7a/ZFMbbx+8nDIailzAVHjQCDl6PGFYS8X/puXrx5aOgA4Fg+hpmxi6sZkE4uIDyJNBNHQPq778brk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486EDC433C7;
	Thu, 28 Mar 2024 22:07:43 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:13 +0100
Subject: [PATCH 35/52] USB: serial: pl2303: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-35-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=664;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PxgWr0PvMMYOn7uOXZ9astW2pxgr8a5gyKCWiDPKDjM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenZdd2t6NpugbpdwO5RIUa5Yy3K/rSgoYvDR
 7996pXQ3TuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp2QAKCRDBN2bmhouD
 18m3D/0WD9f7+adteNDyAOrLLRfK+0OJQD6zkOsMqehoV3IKZEBCOE0HTvDUmsxP1sVB8jIqfMM
 4Nn3mYHbBZ9MFnXZDrxpUZYohuNw1E39FZbyheG5gIhz/g8fCSpDdHfW1n6qVz9IUMqyCzGIB7F
 lDr75viyU1qEEXkHMEB9sFLLmg1VI5p6ojCqVSlbEzVgfmhfZclmySSXeDTPz21lDh+xmO0S/fj
 T8CKQH/lk7NR1X5NuCTaQmNsKMQ8yVAC67yrGTadHtXD0AfIDY7m7xFMvC10vpOailqCxybWEFG
 waPaM7L9GJzwTaMWcxMlNsdA6XdgZmRizax0DEAbeaKKkKNXsE4SZ58hav14uyCn14F8t8jbXlg
 G/ePFoP5lqN6RkJCJY7+gPt79UbUUUmvuodHEfP2RewoXZf+QyPmEn2ZGIZoqtiuNpUknnMDMIP
 rbNioAV/TeRJHMefNWWPCT2PRPgRPsCc22G5fLddIvBR9IxOkt6WxZGpCdb/VF5gcUyHf1io15N
 oyFHKDl2/KtATi9T85QDJWI4qasoOkfO60L4YrVNPH1lhNRg5YlR5Nxc8ISRbNhL/EVPmwRJci9
 oUmqjuA1EDRElgnemgXLDWZSR8RDWL+T7V5HaL/TNJiMod11N11DtH14eu+rQQzTbypdjC9ZAk0
 m7oHgThGXemmE9A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/pl2303.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index d93f5d584557..9e3b524a2e7b 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -1234,7 +1234,6 @@ static void pl2303_process_read_urb(struct urb *urb)
 
 static struct usb_serial_driver pl2303_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"pl2303",
 	},
 	.id_table =		id_table,

-- 
2.34.1


