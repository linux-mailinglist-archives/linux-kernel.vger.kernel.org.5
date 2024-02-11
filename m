Return-Path: <linux-kernel+bounces-60902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30413850AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A901C21712
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30435D478;
	Sun, 11 Feb 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6dZTeFz"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4041E488;
	Sun, 11 Feb 2024 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707675459; cv=none; b=tqC8BfgXArqCuPhmCF2Kpga5DWszAIPasCIelqsLDFvoNdaGGnAtIc1ie6zPg/gxeQ9JKy1oxhGQfgqNhEBRAxOyhUwa6e7k+z2QnTbO4wDLMM2EuZ3AHqsnbNz8yGqL9A/4bFgUExJ547Q9BxJpuA6t6E4wb6cV/Fsm+Y2HqX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707675459; c=relaxed/simple;
	bh=io3+Hed8JnnC4i7HX4lVCBexNVH3DyfS4NoC4XK9xpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTb5F7Y/1tTg3ocZlTAwrbtk4wPAnqQ3IC8eRDuEgBvuraXWAZkkchTNGjs8EgFepwj9iiHt+jp8iCUYnxY3tQwwQUjKddYm309IP7/8WoB87R3GDhgsubkMao6bSOaymmhacHQz/qHs4fXAKAieSxRNT8rmzb6/qi+CiTr1gd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6dZTeFz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a383016f428so269976766b.2;
        Sun, 11 Feb 2024 10:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707675455; x=1708280255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRlkryYzMpYNr8EiU9J50+QP+nynNhNlhOvQquw1dL0=;
        b=P6dZTeFzGt+sMI9p+O6q7d8ZrAZ3q3tFbaFTynO7jkrHi8sTIPCRhFhCPkrh+CEom0
         +jiq2u7+wzOJ9iUkJaQqd8WHFCBIzsoKm5iqafEzJpGB3A8qth5Emp2p1bZibT1TJcbD
         /YJDeuk6pn4J79QlpapPjz2VBFzcqBmnaTrSk8ELojq/8pgZFoviaYOgPkg+oaJlp9Yb
         lInPg/rDzsA/vZ0KcKm8ypFpFj9x6rjes3nQLUs6270bsMsnFTFlU6KZc3+t0ETh1WYP
         79n3ZFRzUffKbSeecxAeJNgqqSMR5eTGTft4shWk4HQ2j6fPbNdnkj5OUPWshKjoKOlT
         x1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707675455; x=1708280255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRlkryYzMpYNr8EiU9J50+QP+nynNhNlhOvQquw1dL0=;
        b=rpMQL+UeT7oZusaQvzaHOB5HRB0wyOycFKnn5V2dkchlaKipIANhZCbD9Q9bySmlrZ
         3F6Hc9hDEJccl9QyHc1Bm3YXBA/kBCaeWrvU1LPQA2DVmHxkQdB7+d7h7gM5f9yWDgTZ
         90ZclY78zkA4ypyeIlfkkviqMdG279f0WXvkSt4P21V0Bp57dcgCqHeHz8WKSPucnp1V
         W5BmgZdneZ1hI2oLkAxgiauR9UTsT5/q6CHOVrMPaPqCjbVjQMBhfVXuicukPwlbz0jH
         1zI98fmKv+H/CA5COswIAHBLGm78710ASj21uaQYUpc4DrP3v2dX2rbnyMV9tykDvvHg
         hCLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5bMuFfCYi/j+yS3+aIEL5z5sOFT4f/sII7jmQ9K0U/q/V1Xlq6pNDE3dub0qhA1+ZG6ebzNMhgsA3smAqV+ag2Iqc8LiqozR6t0+iCos7Nh1Pnf2E6Q0Av8kwiop6awn5wFW7
X-Gm-Message-State: AOJu0Ywrzwh6EVnb3fhQuaPIlzRtxUDidvMfcCNCaxRSZ5aZsoY9jSuY
	Jnq0907gei9p1xcQJKoTrOd/Uap3qrXLkqN5UFlm0nSNxIkA4lSaqcw39Vjo7a4=
X-Google-Smtp-Source: AGHT+IFhvzIdDIU9NI22aPCKrR1T8TqA4e5Qm7JyUEIBkXaoV6ec/doDEFG0EufEn8PQqlUXOl0syg==
X-Received: by 2002:a17:906:af10:b0:a37:b91c:8a4e with SMTP id lx16-20020a170906af1000b00a37b91c8a4emr3968636ejb.60.1707675455330;
        Sun, 11 Feb 2024 10:17:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4poW54j57mNFwT+6WKg8BUMcfLGB9lydg99gKlKbj3k4C0FvA920rzecg8k2+dW3+h+ESmVRRkEd2jR/r/B/fddQdOVzke/DUr7/gP7juDcF4gq83AoSe0r3pSWpQZ20P7K1sYXNaGIssN1cK5l1j0DwitlsBK8OcqueRegZxfyIc04ucqyWxmH1IMvm2xZm/5RVh3EzDmYdddNecafwRSMULeVaL2TxE8MVW6F2wwe4nAC6kbzLS432guBmWRXReDmcQy/SYM2G9xeV8lE2qrlalBYKam6HLIKzdO07rXcp0hh0Gx/t5JQsxzhzMQYGIz+jd0ImJrx3QtI5MwWnmjY0KgZyoAW029rQocLWjLxM=
Received: from fedora.. (cpe-109-60-82-27.zg3.cable.xnet.hr. [109.60.82.27])
        by smtp.googlemail.com with ESMTPSA id cx3-20020a170907168300b00a3c488d79b1sm1571670ejd.223.2024.02.11.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 10:17:34 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ansuelsmth@gmail.com,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next] net: phy: aquantia: clear PMD Global Transmit Disable bit during init
Date: Sun, 11 Feb 2024 19:16:41 +0100
Message-ID: <20240211181732.646311-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PMD Global Transmit Disable bit should be cleared for normal operation.
This should be HW default, however I found that on Asus RT-AX89X that uses
AQR113C PHY and firmware 5.4 this bit is set by default.

With this bit set the AQR cannot achieve a link with its link-partner and
it took me multiple hours of digging through the vendor GPL source to find
this out, so lets always clear this bit during .config_init() to avoid a
situation like this in the future.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 97a2fafa15ca..e1f092cbfdce 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -727,6 +727,15 @@ static int aqr113c_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_TXDIS,
+				 MDIO_PMD_TXDIS_GLOBAL);
+	if (ret)
+		return ret;
+
+	ret = aqr107_wait_processor_intensive_op(phydev);
+	if (ret)
+		return ret;
+
 	return aqr107_fill_interface_modes(phydev);
 }
 
-- 
2.43.0


