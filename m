Return-Path: <linux-kernel+bounces-63710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C44853383
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47C91C27480
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DCE58107;
	Tue, 13 Feb 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="h0pHd52i"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915857872;
	Tue, 13 Feb 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835647; cv=none; b=E/7mqBKmafb9fe16BWH8FcyPaxyEI1nQsvLlG7STKIiJwWepkpZU/GwQA4VVlANbwa8deA54ImkoLIL0r7uj4tLnjpk/hj6M/LYOnJrME4zdkAwM4kgAfSDMXKH7xhClNhMXCVZXG4Ait5LU8j2+FALEuDfrGlKle9CRBfSEWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835647; c=relaxed/simple;
	bh=2+cceclGcci8ULNy1D19PpTajOUJ+CpjOxx4xydbjGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KwbRX2ygmaxDPFwBIBPHFCM7bRXgUgOk87M5jEIL1k1klu1giQ+ex80BYkM5gvTVL2ZTNVGAcjxAJDGyeQUhl5kQdvKix2UpBoNEncKdyWRouq+aWM28id0nKBSwxSAgRteJQeygAtQ8QlqNww1S90OndSt1iAD9WOUY5kLi/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=h0pHd52i; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e10614c276so66554b3a.3;
        Tue, 13 Feb 2024 06:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835646; x=1708440446;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSv+EkEwcIxRTN6Zs9j66Wun/yagrIt+dYmJkNqa1B4=;
        b=UTKQr933PA3Dl3cAn7+bdVFe+bjNJcSfgc/Pv+tsxoYFO5uEfx8FBb0JtbOKlB42Qr
         RuBQzFu7ut1lDEgSu/arV00HjnHBMVE70597FbqL0X7YajpIEVFM4C7N6NmRHC0efoa/
         ITGfjXDp+Ik4GXulZkZEvy/vq6zA+PhWMTd98RkFX2EKjOPmNAUSTO2uWyEHk6ixy8/z
         +ptoJvrkvFM8c2wj2iO2WRmRGY1D/dqoEqijrh5OGG2N7Ejd4rfx61ZHKBhbc+KMxsbQ
         6NGxSYpkfcM4tdoGZFhA0C3sSeblVYFg5ikInxthZoAz4Exrl338uAD8VRsj9540lo19
         uxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsFL7AGNCn1XpRao+d22bkDCWuKW39A8Bv+llj3X1Ou4fD8yUgGbEvXfRSWnaISP50RSq4WamyzhRZOERDl97suAzdexhZjCL4V/Qt
X-Gm-Message-State: AOJu0YwS4egHZNn07OdcyuIMrO0XhXkYaJxSnV18oPBtUWvHuL+oxVVP
	8Wp9rf44btl6zFl03QHFpBogtfUXHm1PXa3br3kTdRNNeH/U0Q1j
X-Google-Smtp-Source: AGHT+IHkntHmDap8tGUW9jvNG3rNItN/F4XQBOkTALr7sTAMM4SZtwvfuLNjLGFzs97E9m8DRCFYTQ==
X-Received: by 2002:a05:6a20:d704:b0:19e:c32f:35fc with SMTP id iz4-20020a056a20d70400b0019ec32f35fcmr7739203pzb.38.1707835645692;
        Tue, 13 Feb 2024 06:47:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXp2cKLlc3WXp80Ux0wkelgGEB7JGwZWU1HX3DxOq4cPevTrsC8yF60XBcXcpZrRJef5BWRN69w44RzcuqF2XuXg4UuFcqyxjjPczcQ+CGMXcM225t1lX7wlNSGUS79yEMVwmilOIfm2KJ0KpuLH/1tk6NEg3yTiCAAVMReB/ypnwXNIjuXfXg4IF9fwAwoHmCsTFdt/z9VNQ8+8HhDV33ybSfiyNiqZvky2jVzLycx8GOtYJJLmha/w2TmxNS12Qteflf1Q199t+1gzw2KwQ8XDjSkcAOJFe0jwJWFP4ybPuLoxA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001db2ff16acasm1533547plb.128.2024.02.13.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:47:24 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rSv+EkEwcIxRTN6Zs9j66Wun/yagrIt+dYmJkNqa1B4=;
	b=h0pHd52i6myN8o63s3wRdqxEhvksXndaTTzrvcKxCIZc+Jjb5vp29wzxptNNgAsd9f7FgJ
	m4nzEPclOQIUdQk397mYe/DOy9XPavdr2v70jD1hYtpAUSnbkQWsTdw8XzohHAPZGSyvRT
	2keM8Xey4o+s45UNZm1MSVrfuicgr0WerpxxYJghJzQnZVXGIqog0rvZYFM2rNS0f+ZmFp
	E7xIpRwXqix49E1pgXmQzwxzqyFFx7DBNEf2KbYNKh3q6v8gxfe5Geyp2I9McPGBzqrPmG
	k+MnfqvN0BnnbC83z+tRJoEKfE3eN8ndcDCnIa899yeSXfDoU16zAJPPU2E3Sg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:48:00 -0300
Subject: [PATCH] net: mdio_bus: make mdio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-mdio-v1-1-f9e799da7fda@marliere.net>
X-B4-Tracking: v=1; b=H4sIAB+By2UC/x3MTQqAIBBA4avErBP8g6KrRITpVAOlohhBdPek5
 bd474GMiTDD0DyQ8KJMwVeItgG7G78hI1cNkkvNpVBsKXm2BxpfIjsdBdajcFx1uteqg5rFhCv
 d/3Kc3vcDSr6q4GIAAAA=
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2589; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=2+cceclGcci8ULNy1D19PpTajOUJ+CpjOxx4xydbjGk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly4Eg/zE4zI0bun71Kvm4k5B9LEWDKef8FNLCD
 nE/VEZmubeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcuBIAAKCRDJC4p8Y4ZY
 ptqsD/0VNY132uydVtSLLUjl8TUKpyoomDt3Kx5iWHf82OVZnI91FM21JtbEcjsX9SXx1lhs19v
 MH1jkEZHct7NUUGtploHuPkPCQGvJv7w66s1zji5VliXY9GZ6pWPLg7G9AV0SYsIsdOtmhf9yq0
 0mcLWt/Z06moe3HYYOvbs0RuSK8X5V3bbS1Xm0awP6LDGw31Z9Q7prcA/r11CNbocql1usC7m2C
 HxgeaD1ZO7bY7C9z9m3vyDbL13ioQ+CKweUqCXn5ApUTyHSNkEidUkICW3+XOzVMIur+uVBz7or
 NRJK3fVLV7mhy7U3zU1YCmtyYvn+KollFDcLxZNNWpjGSF7nRFH7vgCRW/qXtU7nlGaZgqvlPz/
 wZOIphFRl1iYgmIuwKIdFXb7ctjuFpmTgf28109qtxANFWossyxtvjlqSPQqlyyCimcGVyjR3hL
 gJWMoAeKzl4K0jR4hViURgHKfIoZPh85QdYgCBnw5u+jjgjziIc+YnIsEdn4gr6DeZctQfbqO45
 GMHBd2CH9rnvBOYQU3ySKQBA+86cpkfQE9kxNQlKHVUhsKyHEVdXh3opB6TgNfbVS80ao8VYoyx
 IzLAffTaH/9RpDHguU5W8C1nUU3M2Zqiv3MaiThN3I+0v+RT7hW8nfx3Ivz8QYSNLN+u+TCgraZ
 xrDwnC5PY6O5PAA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the mdio_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/phy/mdio_bus.c   | 2 +-
 drivers/net/phy/phy_device.c | 3 +--
 include/linux/phy.h          | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 08624f073014..b765466e767f 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -1426,7 +1426,7 @@ static const struct attribute_group *mdio_bus_dev_groups[] = {
 	NULL,
 };
 
-struct bus_type mdio_bus_type = {
+const struct bus_type mdio_bus_type = {
 	.name		= "mdio_bus",
 	.dev_groups	= mdio_bus_dev_groups,
 	.match		= mdio_bus_match,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9f37c0bfbf8d..d63dca535746 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1604,7 +1604,6 @@ EXPORT_SYMBOL(phy_attach_direct);
 struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
 			      phy_interface_t interface)
 {
-	struct bus_type *bus = &mdio_bus_type;
 	struct phy_device *phydev;
 	struct device *d;
 	int rc;
@@ -1615,7 +1614,7 @@ struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
 	/* Search the list of PHY devices on the mdio bus for the
 	 * PHY with the requested name
 	 */
-	d = bus_find_device_by_name(bus, NULL, bus_id);
+	d = bus_find_device_by_name(&mdio_bus_type, NULL, bus_id);
 	if (!d) {
 		pr_err("PHY %s not found\n", bus_id);
 		return ERR_PTR(-ENODEV);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 2249cdb5957a..c2dda21b39e1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2129,7 +2129,7 @@ static inline bool phy_package_probe_once(struct phy_device *phydev)
 	return __phy_package_set_once(phydev, PHY_SHARED_F_PROBE_DONE);
 }
 
-extern struct bus_type mdio_bus_type;
+extern const struct bus_type mdio_bus_type;
 
 struct mdio_board_info {
 	const char	*bus_id;

---
base-commit: 400909df6e6543cb5cce3db9bbcd413d59125327
change-id: 20240213-bus_cleanup-mdio-8e1d03748437

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


