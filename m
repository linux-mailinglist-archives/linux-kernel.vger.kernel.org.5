Return-Path: <linux-kernel+bounces-31740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDD783332D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 09:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87C61F22886
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D454441F;
	Sat, 20 Jan 2024 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PbJxE+Ib"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC92105
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705738093; cv=none; b=QTBTqwDAvvtWGlH+1jZsC6Q4HgM+ZAEKy0U+SVrWhjIAYb1gsASA1a5YcnpnKufz40STlCBN4lcgdWP4790oQ6zW37A1f7lQJz3MnEl22DHbMVsY5BX68wChuxeM3WkYgPGgxu3P6DdNRFZ8DSWt6OqSO/yDeFoCdyXR4k/+RQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705738093; c=relaxed/simple;
	bh=LxSWeL86UuZjcYrsu9ximZbggaJfpSpAduOC7mbTICc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIzYk7Ul/fyjZKUBOBJA+yNZgm8d4GriJA1b9MXyF92m4iMJNMoWwNqZIiCIr/cvBux9ARvGRnVfLWZPXrd9J6wRQbdcBoZ8RS0ya0QKgQu1j17cRBAg4CoOWamawnrrhuq6YZeBM77x9D3WQaJgxnhDuTcjnNXyRuHkBEKxU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PbJxE+Ib; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id R6OWrt72yoKAUR6OWrIak4; Sat, 20 Jan 2024 09:08:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705738082;
	bh=FnsqDqIoO9tFCmJjjWeGB5Cxwpi97rkH+F9pmjgfNVY=;
	h=From:To:Cc:Subject:Date;
	b=PbJxE+IbeIYXigNe41fiHMR0ZjKfpaGgpsi//rHz8TInke/fn8BDspsMyRuFcis8D
	 WyYfit7aYiNfHDIoELBJZpXwsm74LDDXiPsFan1DwN/HRJuP7Qvhh1gijkvYzrKNxg
	 0mfJyjWc4As5OoJT9k6CNaeJFPDrfy02yd3LqlKLfCSanEyjexgNNQZ2iHdZUvHJ7S
	 kQsrXI4UO7KGPtsViCWzwIrExpFiXy9CV5149pVBBpZ54DdUJN8NLdtNefH3YempCg
	 7IPG7IlgrG0UX+Bg/uGPJ3IsrgZ/AHIGv195jyrXWXzV5WqzNhwLi7EE6B9K3rPnXt
	 ZXNQstHBJA6CA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jan 2024 09:08:02 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jeremy Kerr <jk@ozlabs.org>,
	Joel Stanley <joel@jms.id.au>,
	Alistar Popple <alistair@popple.id.au>,
	Eddie James <eajames@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fsi@lists.ozlabs.org
Subject: [PATCH] fsi: occ: Remove usage of the deprecated ida_simple_xx() API
Date: Sat, 20 Jan 2024 09:07:54 +0100
Message-ID: <6e17f2145ce2bbc12af6700c8bd56a8a7bdb103d.1705738045.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. So, this upper limit, INT_MAX, should have
been changed to INT_MAX-1.

But, it is likely that the INT_MAX 'idx' is valid that the max value passed
to ida_simple_get() should have been 0.

So, allow this INT_MAX 'idx' value now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The change related to the INT_MAX value is speculative.
Review with care. (or I can re-submit with INT_MAX-1, to be safe :))
---
 drivers/fsi/fsi-occ.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index da35ca9e84a6..f7157c1d77d8 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -656,17 +656,16 @@ static int occ_probe(struct platform_device *pdev)
 		rc = of_property_read_u32(dev->of_node, "reg", &reg);
 		if (!rc) {
 			/* make sure we don't have a duplicate from dts */
-			occ->idx = ida_simple_get(&occ_ida, reg, reg + 1,
-						  GFP_KERNEL);
+			occ->idx = ida_alloc_range(&occ_ida, reg, reg,
+						   GFP_KERNEL);
 			if (occ->idx < 0)
-				occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-							  GFP_KERNEL);
+				occ->idx = ida_alloc_min(&occ_ida, 1,
+							 GFP_KERNEL);
 		} else {
-			occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-						  GFP_KERNEL);
+			occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
 		}
 	} else {
-		occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX, GFP_KERNEL);
+		occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
 	}
 
 	platform_set_drvdata(pdev, occ);
@@ -680,7 +679,7 @@ static int occ_probe(struct platform_device *pdev)
 	rc = misc_register(&occ->mdev);
 	if (rc) {
 		dev_err(dev, "failed to register miscdevice: %d\n", rc);
-		ida_simple_remove(&occ_ida, occ->idx);
+		ida_free(&occ_ida, occ->idx);
 		kvfree(occ->buffer);
 		return rc;
 	}
@@ -719,7 +718,7 @@ static int occ_remove(struct platform_device *pdev)
 	else
 		device_for_each_child(&pdev->dev, NULL, occ_unregister_of_child);
 
-	ida_simple_remove(&occ_ida, occ->idx);
+	ida_free(&occ_ida, occ->idx);
 
 	return 0;
 }
-- 
2.43.0


