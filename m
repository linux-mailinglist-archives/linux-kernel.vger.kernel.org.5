Return-Path: <linux-kernel+bounces-89817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C74586F60F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2E02854DD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DC86BFA4;
	Sun,  3 Mar 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="cTeivo62"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0286BB46;
	Sun,  3 Mar 2024 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483348; cv=none; b=jxBMpGvPnTKO4DCW72NHBUejGnA9EgdKV5oq2ZW9iZxl95QthjwmUOZaLYM4FovXCwSqlCA6sa/pDjT445tvWg+caWNWx4ws/aMq2MsL0ZDU38ilCM6sWFgzVtBEHAPX+LEzLun135604P80NjZmzOT3V4JGxhjSFILSUjpozL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483348; c=relaxed/simple;
	bh=w/BV0vxxw3KqhEV/ene3cVxbTcqtHuugUeJbU+hKcuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T/9JFnmGEfZ5mraG3/elxvpN1yqgMx08LjVb8nlUPTzI7uuDD/klW1yrLbrfKMWkRQCpl6uYSErZ0sL7+/Q4j0iU26fvvYjXlfhS+sflSpgUTdC1o6x9JALnc8vACRu+W/fa4f/e2e1UALoiUmmsOHx2/mdfPVZbl7DmangZryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=cTeivo62; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so3249594a12.1;
        Sun, 03 Mar 2024 08:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709483345; x=1710088145;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0bcl/GfiCCy6TWoeivaTyJR3kIJe2T31n6M+X38t/A=;
        b=N2YxCVsWYyuR1KVyvT5oIWYnaZXVof8nRyuJS0sLGpEl4mm5XSPbgAuQw4i5FjEtLY
         M8L35AF/sf0t0rToR1dKn9v/z5uG9ZqDgiVHHYplH5sXJBCIfMxPZqbXtYqkpci5civA
         DAvD4bc6FpV97AYFFLtPzetRMmrw/mZ6dPIcCOpbYenZEc2ULvougnbtxPio9dBxzbpD
         wzJnYZoy8+Tb3YgvXQCjs8pZg/FX/CJRjSndhmGd3mQQz9h8PQkyu39zahMvHWn3ZcN9
         F+PfFwquIeDIVN5CCYSOocvgW2l1w53eidL0GUrfWIl+JRGpnP+9zxHgSMHHvKRDdj9S
         Gq9g==
X-Forwarded-Encrypted: i=1; AJvYcCWxHKdsgopmo0zFFBrrWigpxlTJS4dIRlyGLtsPqtSOe9OkRVZWq5nxGDxmN4Tt8iz9JVRVnw6MwOuOor3SpDXoi3qyNEXWrufzYCjfwhnZhj2X1fWged15tqnCxQ0+XbOC9WQJ9iw=
X-Gm-Message-State: AOJu0Yx7scZK7vAU3XL/JnR9+yERF60lBMHeivD//6MQUCCQ6az6zEJb
	6wvarAThy+6VxhfWbdipSOW6Olqv1iRqtHs4tuJ3DstqWc7WfCoR
X-Google-Smtp-Source: AGHT+IH06c6cCQP4rfsOwRqoFzKUEfn8p7DX9qLNCPbxb2OkUf7d3Eiy/5eo7sRG2xgp/ehGVCcXZA==
X-Received: by 2002:a05:6a20:3d94:b0:1a0:dc0a:31be with SMTP id s20-20020a056a203d9400b001a0dc0a31bemr5470619pzi.27.1709483344651;
        Sun, 03 Mar 2024 08:29:04 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p11-20020a056a000b4b00b006e57bd16fdfsm5815478pfo.205.2024.03.03.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 08:29:04 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709483342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F0bcl/GfiCCy6TWoeivaTyJR3kIJe2T31n6M+X38t/A=;
	b=cTeivo62217tGW5K+B2c3eK/690OPV2w6EBt0CFm6rtWY1pgSwPuUPgHB29cvozqO/y7lN
	Uqbuz7Mk83MzBgCocjvC8y9QOdSkGXEH/qlX96uQdqRxCMu6/EuhXGLhPOJ0D6sIq9iCvJ
	qx3ebH4ECrQKW+UEpI2vggqNMJAwQo/4RKBsjbMq9R4e6ycsdYy4rYnYH4bH8nO03PdQJJ
	VT302iN/Dh8pOrUoHHHO4f5gMmectlkj2+sAasK4LX+eQZGDYci5E+Ky0Dza43B+zafwLm
	ncqZXUGKG2D7UsYcqO0GzEdPG2nHk+st2br01jM+4fgtrg4JH5oiDGoLzyzQpQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 03 Mar 2024 13:28:55 -0300
Subject: [PATCH] power: supply: move power_supply_attr_groups definition
 back to core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-class_cleanup-power-v1-1-6a3abb5b15ad@marliere.net>
X-B4-Tracking: v=1; b=H4sIAEal5GUC/x3MTQqAIBBA4avErBNMy6CrRITYVANh4tAPiHdPW
 n6L9xIwRkKGoUoQ8Sam0xc0dQVut35DQUsxKKlaqaUW7rDMszvQ+iuIcD4YRY+qk60xSq8OShk
 irvT+13HK+QN7DL/jZQAAAA==
To: Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3227; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=w/BV0vxxw3KqhEV/ene3cVxbTcqtHuugUeJbU+hKcuM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5KVJOhdHR17GY6viPoIccRxLeZzXxuXxmHke6
 6wBen6jByaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeSlSQAKCRDJC4p8Y4ZY
 pqgVD/4q6QSnHSHTQyfOp7Fm+aJZESOS69yfD23cp57rfybZdCXZCEfVlj0pzuANVVsZOvwJXWE
 /HZ57VCJTu0GBB2+XFlWGdEU71yZ2jXdxmXVXmToPFFel3YV4DvQYAd8TfmgmppZ3s4bQ7fUyR5
 ijGS06d5tzxBo2PIYGoLVliuWrTAp8ucGQH4D3328ULTChXX5BbCAuGPjgkFrdmGOQ9mbLmVRIR
 RPCdNHr6uNX+EqiU7mVAm3QXH4B8GP2rgO7wn2i4FtLP/qq8COMpkUOQwxyLs3kPgpZGZd+Zj8I
 fIWxGZlmK8xrWADojv8iRG2p++9C9G43Rza99pdZVfhJyD12P6XeYnAQLjAcSPR/7pTs+50W4QX
 sjltO5sCNDil0gK6w98JNG5liGHZ5uoJWiy74JM6vKrlBvy+KQ+fFidbDO5NdrkNh/OMjD21fbF
 v8srogXfVYvOI4u2x0BRuUy1IkKyUzHv5PYHdMNHU1R5ekzl1tJzxTXxOZPz2G8OINW1WKhBMNJ
 I/eEQnC88vGy1d22D2cvDzHFCQDY4ldHxD6R4yD/8niRAKKaGpOIgYa31SS+XCAKG+3gDvandpW
 Fo4t8Nf10NmIOSd+83DWUEMas1QHJ4Q/zZQvBLiXeC0OTVAvmp0yO2amWIKPt6L5uShyKcB8y2w
 E5unY8EOYL03neg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

As reported by the kernel test robot, 'power_supply_attr_group' is defined
but not used when CONFIG_SYSFS is not set. Sebastian suggested that the
correct fix implemented by this patch, instead of my attempt in commit
ea4367c40c79 ("power: supply: core: move power_supply_attr_group into #ifdef
block"), is to define power_supply_attr_groups in power_supply_sysfs.c and
expose it in the power_supply.h header. For the case where CONFIG_SYSFS=n,
define it as NULL.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Fixes: ea4367c40c79 ("power: supply: core: move power_supply_attr_group into #ifdef block")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403021518.SUQzk3oA-lkp@intel.com/
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/power/supply/power_supply.h       | 4 ++--
 drivers/power/supply/power_supply_core.c  | 1 -
 drivers/power/supply/power_supply_sysfs.c | 7 ++++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 06749a534db4..3cbafc58bdad 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -17,12 +17,12 @@ struct power_supply;
 
 extern void power_supply_init_attrs(void);
 extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
-extern const struct attribute_group power_supply_attr_group;
+extern const struct attribute_group *power_supply_attr_groups[];
 
 #else
 
 static inline void power_supply_init_attrs(void) {}
-static const struct attribute_group power_supply_attr_group;
+#define power_supply_attr_groups NULL
 #define power_supply_uevent NULL
 
 #endif /* CONFIG_SYSFS */
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 4f27f17f8741..0a716cc0f164 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -34,7 +34,6 @@ EXPORT_SYMBOL_GPL(power_supply_class);
 
 static BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
 
-__ATTRIBUTE_GROUPS(power_supply_attr);
 static const struct device_type power_supply_dev_type = {
 	.name = "power_supply",
 	.groups = power_supply_attr_groups,
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index edb240450e38..bf725cbb0d86 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -389,11 +389,16 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	return 0;
 }
 
-const struct attribute_group power_supply_attr_group = {
+static const struct attribute_group power_supply_attr_group = {
 	.attrs = __power_supply_attrs,
 	.is_visible = power_supply_attr_is_visible,
 };
 
+const struct attribute_group *power_supply_attr_groups[] = {
+	&power_supply_attr_group,
+	NULL
+};
+
 void power_supply_init_attrs(void)
 {
 	int i;

---
base-commit: 71c2cc5cbf686c2397f43cbcb51a31589bdcee7b
change-id: 20240303-class_cleanup-power-7e25046623fc

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


