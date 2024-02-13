Return-Path: <linux-kernel+bounces-64436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03193853E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362921C2290F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360DD77F07;
	Tue, 13 Feb 2024 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft7QnrOO"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265A77A08;
	Tue, 13 Feb 2024 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861985; cv=none; b=VtcXVl7BfyR0y1kP3do183A7sA5GXUFzA80IwPkZcEA1cYZ6+rCsJCa84V8efLYW639uXRoZQTDRgjvPc/MciVDFNviixZLTQTD787oM1X+GH7Sew/SWaXbLE5y1XaiH7Bk2emOrE6NKU1QENChObHN5QxazquPFik42LmXhYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861985; c=relaxed/simple;
	bh=hPoqurwpt0Nzd4K48f24Meg4YCMaFciuOSzhb8zDw9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GSdWRA/QsSnyJFONPbAqYCNM+lsPClcJsH9iq0zhqP6xVK28glCMPvFbMgqBza+yhvo4XRswF7XQxSQU02OZyfl2ot4fg/cxHN036Bh8pTf4TO1iA0v5TNArOgsqUUUIomhaCaSpPiymm88OZqRDFxQLTqcIyBybvHYKm4lUHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft7QnrOO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d39b2c269so14278066b.3;
        Tue, 13 Feb 2024 14:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861982; x=1708466782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lfZKWMdVX06rkt/a2RPzvoVKkcprfsWZW9EdATKrus=;
        b=ft7QnrOOe5JHSaAnVzT1evB3OFB5yfsZepKX/hYRC6p9YF0MntKZX9aQGzhP6IUggK
         DFRmuzlfHL2rbB1vkD0n5cuD4ZuwqOYoph1sXVY/LxB74SkYiwDD38XVDUk2BmPKJlCx
         +HF38OKglRghokU9/1b8+8uRLPqV3zMWty1KXiOmWk14Ckut/Ra/gkvT2Z+zWkepqH+v
         3m/3ZIEJYtgg7yhAekcRhGBWOuU/zQtzUeC+8tz2VLnpsOonJZ/kXwiRE/bBOa0abGN1
         gb/OYoFCwTxTdFpfm3pk59RAYDYOUTSeqAvV95aeM9ZUe8WFu3FRT9N4/ZfkOo+P+Zh6
         9Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861982; x=1708466782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lfZKWMdVX06rkt/a2RPzvoVKkcprfsWZW9EdATKrus=;
        b=fptdPLAMdjUwTEDauSuf5518CL5jbzsgJzKAMEluYdRhqe4JnTpheV73vckOZFyxRT
         +W82BpiuPrCknRZ1/npaoQvxGwMHYxMdTT82L8JxqqlqMIBQUo28tXBghS5+89+LTk+W
         ED7nS+0K3Xtnlyy8hc6t3vVxlV35mBAmswuyRoLo6cr7sSAXx14wfxpKyYkecZM15bKL
         XJHOiYPfgS6Jn10smboEqZlESG/30BAXKqm+uH66B9wM1YY8PMYGz4Veuil303Bm9czu
         kYWHInPqslU1PHpQDBF7L9DnSz89+beh2GBI9ICLBKwRmX+7kEo5bPtILnTvabqzod+M
         W5+A==
X-Forwarded-Encrypted: i=1; AJvYcCW5U5PS9aRUoOlv2fMPzMUoguEHah7boxtxPu3airIuLQQV6DyhCiQZEXMupxNQ3TuRYijyzkHOFs86Ttu+OpdQls96rEhizURJeGzS
X-Gm-Message-State: AOJu0Yz5GC2xuN/ibWsEyXbKjsAdkVNNFenI/j4BospKJ5sznFP7MGQA
	lVTFk33IxFo7eR7xgNDXOe6Uj4cFXV13IdG2k9/HCIU6H0ScdsG8kzTf3tNDQAs=
X-Google-Smtp-Source: AGHT+IGbSm2u1unhRkzRHw0LxILh3z40D0Vc98mIpZQbe6gu8tWK35H7CtRrYmJjUWw1x5EPkB4/VA==
X-Received: by 2002:a17:906:f10a:b0:a3c:fc34:d5c7 with SMTP id gv10-20020a170906f10a00b00a3cfc34d5c7mr435072ejb.61.1707861981841;
        Tue, 13 Feb 2024 14:06:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlF7wPfzwC0FthiObG9mNggVsgoTXaW6orPkdbuVmifEyHR9vHn1/XxFTlRk3S9x1v+rPWep99t3BhAdOJLT3qtCEjLKegPqPeQlJytzkvL2nFaY1C6oJ65cnsP6YJ+shZidDyisFRajnSReRVWkMPw9IzfdjJeSJK0QbJJWaZ3M0wXflSrF3TLrimvcggo/FfraRWS3FCuV4OuRvuRU6pJclAwWKHxi4/mIfhDeUUW/44RsLIJvgF6y2QhAkGs0WBFKQK1Z8+Dl+G0B0LdZ1OT3MUnmFOBRH8sM84PZbJMGmgKxS+cuVH2ZZdgjFOD1X7bi9jocNMZGwqFVtpA9M8Q0IygPTXaUyq1qrucZHWn82432b/v61I6prmM93L/JAf46kvb8iiGf+a/W5hBUUAem1oHjZ76AEZalmnVjaE2HAgnCltP/n+2KHKMJlMD4mJ/1Tbzt6O3A==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:06:21 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 14/15] net: dsa: Define max num of bridges in tag8021q implementation
Date: Tue, 13 Feb 2024 23:03:27 +0100
Message-Id: <20240213220331.239031-15-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220331.239031-1-paweldembicki@gmail.com>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Max number of bridges in tag8021q implementation is strictly limited
by VBID size: 3 bits. But zero is reserved and only 7 values can be used.

This patch adds define which describe maximum possible value.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - introduce patch

 drivers/net/dsa/sja1105/sja1105_main.c | 3 +--
 include/linux/dsa/8021q.h              | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6646f7fb0f90..6e22d7a6bfa3 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3156,8 +3156,7 @@ static int sja1105_setup(struct dsa_switch *ds)
 	ds->vlan_filtering_is_global = true;
 	ds->untag_bridge_pvid = true;
 	ds->fdb_isolation = true;
-	/* tag_8021q has 3 bits for the VBID, and the value 0 is reserved */
-	ds->max_num_bridges = 7;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 
 	/* Advertise the 8 egress queues */
 	ds->num_tx_queues = SJA1105_NUM_TC;
diff --git a/include/linux/dsa/8021q.h b/include/linux/dsa/8021q.h
index f3664ee12170..1dda2a13b832 100644
--- a/include/linux/dsa/8021q.h
+++ b/include/linux/dsa/8021q.h
@@ -8,6 +8,11 @@
 #include <net/dsa.h>
 #include <linux/types.h>
 
+/* VBID is limited to three bits only and zero is reserved.
+ * Only 7 bridges can be enumerated.
+ */
+#define DSA_TAG_8021Q_MAX_NUM_BRIDGES	7
+
 int dsa_tag_8021q_register(struct dsa_switch *ds, __be16 proto);
 
 void dsa_tag_8021q_unregister(struct dsa_switch *ds);
-- 
2.34.1


