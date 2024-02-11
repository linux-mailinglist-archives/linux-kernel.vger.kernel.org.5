Return-Path: <linux-kernel+bounces-60809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE418509C8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6AE1F21C29
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494BF5B66F;
	Sun, 11 Feb 2024 15:05:41 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C01E4B9;
	Sun, 11 Feb 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663940; cv=none; b=Fe1mLglXCLMLOs2pj69RSzD6HNL0F0TZSj/BwyNHQtBwEENKHrjFDPYS1VoFDosG0h1U6+nGmdaMumoBft4vCgv/E2v5B3LrQ+CwVNv47srs9/0cayMIYaNp6IXqYNO/ekViOY1Ua838prpMqp5SbdaiMO2IfhYwaku0ZO9qkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663940; c=relaxed/simple;
	bh=EVfYYXla2kngYHRfq5dYArFnPPlhtCqitcRxBeUUBj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ll/5RnWJYGjB/EwW8d8G4rH9i4idiwbUEI/WregvEhHjaW8/USVgNzccq3DkuO0Xw1ZXyGYazvfUN8Vl/zDzfs20aU0TfVbjDDaoYhN9vZx4kD9f9nnDbhAwh6DZ/Z7ls7nMSrrYtaC0CCxKJNA94LQoxiKc0FCgFvzeKEdGybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Kalle Valo <kvalo@codeaurora.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Pieter-Paul
 Giesberts <pieterpg@broadcom.com>, "Franky (Zhenhui) Lin"
	<frankyl@broadcom.com>, "John W. Linville" <linville@tuxdriver.com>, Kan Yan
	<kanyan@broadcom.com>, <linux-wireless@vger.kernel.org>,
	<brcm80211-dev-list.pdl@broadcom.com>, <SHA-cyfmac-dev-list@infineon.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] brcmfmac: Remove unnecessary NULL-check.
Date: Sun, 11 Feb 2024 07:05:16 -0800
Message-ID: <20240211150516.3475-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

In this case req will never be NULL, so remove unnecessary check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 9fb68c2dc7e3..38e4e4f32a39 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -455,8 +455,7 @@ brcmf_usbdev_qinit(struct list_head *q, int qsize)
 	brcmf_err("fail!\n");
 	while (!list_empty(q)) {
 		req = list_entry(q->next, struct brcmf_usbreq, list);
-		if (req)
-			usb_free_urb(req->urb);
+		usb_free_urb(req->urb);
 		list_del(q->next);
 	}
 	kfree(reqs);
-- 
2.25.1


