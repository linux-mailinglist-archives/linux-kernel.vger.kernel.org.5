Return-Path: <linux-kernel+bounces-83991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21A86A144
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75EEB26E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DE815098C;
	Tue, 27 Feb 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gcWC20Sh"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D114EFFF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067077; cv=none; b=fZhXq/RzsWMBXhw8R4oDt1bbxfzP5oGPd1XMRZfiC1g1H5gNvZnHcUzAm6cVCYY36MWmuEs2cZ648XSf8DfcieIoyRYTR6qoMhEeGb0GFpPSJ2ALABTIlBa+muw23t7goBg5UCuXza3RSLJTTf2z8Nva0LSqZGecm+BULS38jvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067077; c=relaxed/simple;
	bh=8UZtwuLFt1gMui9a2Im7UgO6iF/un1cR2TCSHsPBa04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd7CqpEbgo3f4ccu/XN3qYvCK4H6VrD7ApOFhh6qVRKMdWDuLpT7DOUDAQo1F6MiKVzVw4gIqQJZTCblUGyMU5xP8N0Bh92I0u8oVoF9QqCmCTgtP1oN17PkWK+ZDGKfgpHf3Afi14KPmDLo+5kJLgSboEoVWov2an1pMQomf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gcWC20Sh; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id f4PjrRU7nxsbMf4PwrnVkS; Tue, 27 Feb 2024 21:51:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709067072;
	bh=+f4AbVJbx28S60iHUgdJzBPh+asTj/MtBzhNY4Ac8Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gcWC20ShNiGpb3YLDEDliWcB/JrBjMeZvLiuX67SiQq7eqjFdQUY2LHnAXwPqJNJY
	 yWw2f7Uqpygzy9cv/62d5bB2+6RsO7P4lOL/IVjXvA6NI26jU5+9grghCbYdyp1OG4
	 jXp60QFwXgvk5vHlKq3j0r2bM5r+tY5/cuZ6Ng2EtGwPYYgA98JHMe927Qazz6XHXC
	 opadKaVCYDe1tWN0/ZXKb2tMl+c6hRZCjdK9EKk17II29QnrlvJnmXESVkyMW2Gp5T
	 3cSWhIEHQZ33KHj7nh2o+UApC2K1iywSVoy+JVNjFJLD7wKtcMnhMSj6ozH0aGp086
	 MCm/cIjUeRNZw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 27 Feb 2024 21:51:12 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: andy@greyhouse.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net 1/2] net: tehuti: Fix a missing pci_disable_msi() in the error handling path of bdx_probe()
Date: Tue, 27 Feb 2024 21:50:55 +0100
Message-ID: <011588ecfd6689e27237f96213acdb7a3543f981.1709066709.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709066709.git.christophe.jaillet@wanadoo.fr>
References: <cover.1709066709.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after a successful call to pci_enable_msi(),
pci_disable_msi() should be called as already done in the remove function.

Add a new label and the missing pci_disable_msi() call.

Fixes: 1a348ccc1047 ("[NET]: Add Tehuti network driver.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/net/ethernet/tehuti/tehuti.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
index ca409515ead5..938a5caf5a3b 100644
--- a/drivers/net/ethernet/tehuti/tehuti.c
+++ b/drivers/net/ethernet/tehuti/tehuti.c
@@ -1965,7 +1965,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		ndev = alloc_etherdev(sizeof(struct bdx_priv));
 		if (!ndev) {
 			err = -ENOMEM;
-			goto err_out_iomap;
+			goto err_out_disable_msi;
 		}
 
 		ndev->netdev_ops = &bdx_netdev_ops;
@@ -2031,7 +2031,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (bdx_read_mac(priv)) {
 			pr_err("load MAC address failed\n");
 			err = -EFAULT;
-			goto err_out_iomap;
+			goto err_out_disable_msi;
 		}
 		SET_NETDEV_DEV(ndev, &pdev->dev);
 		err = register_netdev(ndev);
@@ -2048,6 +2048,11 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_out_free:
 	free_netdev(ndev);
+err_out_disable_msi:
+#ifdef BDX_MSI
+	if (nic->irq_type == IRQ_MSI)
+		pci_disable_msi(pdev);
+#endif
 err_out_iomap:
 	iounmap(nic->regs);
 err_out_res:
-- 
2.43.2


