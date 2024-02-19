Return-Path: <linux-kernel+bounces-71339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B8585A3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E00283927
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F32E84E;
	Mon, 19 Feb 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="pmcgNQpe"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5A2D610;
	Mon, 19 Feb 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346712; cv=none; b=pw6+2ZGkLJyLY/Lj/ggAo5uuedCJ7oI2KL1aHk5A73Y550H52lQVMzexJK+1udJfAjvfBBG0SxRgDB5HgcOMHpEr0QV1pG5UbbejoVuzPYve5mVnApRD0MA1b8HHsla3jd5BMfX6ueoPeav1nYhVk8J0B09VPWaE/nDaSFJ1Qhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346712; c=relaxed/simple;
	bh=+qGfhiVCyV9q7WZjG4VEtZjEWGbusXpLGOzf0leGW0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KPRG+L5SiJZKuH5jrFKlvxTykWE6cPspTtwcvJIZTsWBUGmVy4CeyGy0NOUqCT58LjJmtvh5kWyrrTID2qK0kQ5re8WP8ErGO0Z4RuUmNIDE7KWVqwHeXCKl0nSpJoXYcjpD7hR0t5rrVgS6IAllCYx3DQxQWsT0cr057ZSHjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=pmcgNQpe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e22e63abf1so920555b3a.3;
        Mon, 19 Feb 2024 04:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346709; x=1708951509;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3d+lJrHnThtsf8pUVLxKYnnmGUoQxCJeQhGw1ipwrk=;
        b=iFUNVog/5XEeraoAVQUo/qNOcLjOeqGOLr6v+CAPz2vJxwJe/9iOR46NrarMPHO5HH
         XQSVQvfheNbPDAvgena6vqSCdtDegu/dWSlo4gTlYTv4bzIsC1BGKMroqGZoikpao7se
         B8FRgY7SNIxTBbJN5hqLTY73Qw3qUR2kOImSPVem8DzZwq3DeZ339FC0NPaBnvY5m8WR
         6oEYrRTT3Y8Db+uY6n76HfSceQDmjUT9khrkr7FmXuvs/hsOa4ggDhTdw6QAWTMlCM9s
         1hnZrZxaj4NkpOIyJcY5Wvw749j4S1Dn7R3s6zUSI6ykbBMW3AIENpVXWNrQedTVQiVs
         cA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLf9duHDEATHdCyAYxK78DzBmw4iiqvTMJqgb2r9VyxvSq6cqCb4HpsKPbtgg6ZVoXvcCFaFrO6uZohepAKUohuW542n8A8bPRT63p
X-Gm-Message-State: AOJu0Yz3InZZqWDBA1GOPE6Wb0T+e6dCUZGzz3BIg59Ii5yMevZRNnq3
	Bo2/EyOz1xodem9s9D6maLBaJaZA71ErhOWbptZI6lwefUzTZQKH
X-Google-Smtp-Source: AGHT+IGWP7wCo7AVG7o3NF8lKLZJpOzUrUMnCQZ7wnQWllz39e6iIFKod1hUclsB6ASZvJHd7YC3Mg==
X-Received: by 2002:a05:6a20:9e4b:b0:1a0:9010:92ad with SMTP id mt11-20020a056a209e4b00b001a0901092admr4780055pzb.31.1708346709194;
        Mon, 19 Feb 2024 04:45:09 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a0026db00b006e4648059b6sm1685205pfw.26.2024.02.19.04.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:45:08 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708346707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F3d+lJrHnThtsf8pUVLxKYnnmGUoQxCJeQhGw1ipwrk=;
	b=pmcgNQpeawXYM49pRCTVvbGqUdnBQMVROUywws/Uj4dnRg7pseGdsNUEE979QGn0hNIBbh
	lj5cqkdYkSHR9qhMHclnHpIy7GmHV10jNPcJMSxSxer2xly1911IkgQDNIkED5Pzy9GXGJ
	rf00efGliok8BpZQ3XhldGvUQpyC8qmof9d/oxuwh3EVCRdIHEO8OhOqjBP+6VKWNi0rtT
	vozKUuXn7+Q94MZB6ipwnOuXEmSg6o3h03bEXM1bYv48KNlL+mNSTEfsYakQCcYTH/+eaJ
	DOAZW03IuoYg/F9zLyyWBt0+84RNUr/r91CDVp4SOhnByTiTUC/BHUknLuZXvA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:45:50 -0300
Subject: [PATCH] thunderbolt: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-thunderbolt-v1-1-7890787f1ec5@marliere.net>
X-B4-Tracking: v=1; b=H4sIAH1N02UC/x3MQQqAIBBA0avErBNUKqirRMSkYw2IhVYE4d2Tl
 g8+/4VEkSnBUL0Q6ebEeyhQdQVmw7CSYFsMWupGatULWyJDs/GE4TrEuV3BUlx2f4pe6dbYTiE
 6hDI4Ijl+/vk45fwB7uaMnWwAAAA=
To: Andreas Noever <andreas.noever@gmail.com>, 
 Michael Jamet <michael.jamet@intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5022; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=+qGfhiVCyV9q7WZjG4VEtZjEWGbusXpLGOzf0leGW0M=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl002Csy5N7M/mDcAaLsxV3VsnAlxjZPjc+Npqr
 K8kYtVqmuKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNNggAKCRDJC4p8Y4ZY
 plsCD/wNjI47Zjz6WoONWQ8IbQhvJ3ls9fMibAiFTn9QnQuCpKaXgkUz5gpJzyHGx+wWfzvhmCA
 U5ZfWHO01omlxCtb38lwXQ/CihkxV3A7I1XwBNfKtcLSEv/JaRivYY8AoqQrEw0lxr0FcGZv2hO
 vhFwJKCczHESP2btoim7OJ+CREu9Wuc1vCzdk71HiSvKEbUlPkKMHeiFxqq8rV087jvmsq5urW/
 KeP/IkkJZ+d2lwCmhp92LJb/lkly7csMu2MxRurq2yELtfjB3GGU7NpBXzzq/cGK1ZObWRlooA2
 bTy7y95G83JXnGhzhc/9W+Lu+TZoTc/tLZf73/WVzQ6oatQMPnNCtAZlhBHT7VysE0ym2FUpxJL
 +aF5K27aj6Exe5cZ69Tqc7nOJ5eQE8kuImDDySOxcCXkyZOiU7wOd8+8GeUwlHG7mZdc70mqzyA
 nfOcrHmbNFRVPzHoBEdTeuRTAxkY2Hrl4TE+NgwuzNey5VO9MDLtBfskU0bKIOAnrhsaEaHlKqT
 URPguBHE6jx+TPUbtJccBNY43zh1lDJN4plzxV6jZ+ODnJuyTEJEkTv0eScOgXU+6gMcYvxwWSh
 J5KlGFpk4Jw7DpEtwaZMuGo7/YEIWrPVgrDDmy44zSLcIsJUCr7/DtNsT6fNc+ZDwOO0HMSYKiy
 DTgZ3fi4o28PF+Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
tb_domain_type, tb_retimer_type, tb_switch_type, usb4_port_device_type,
tb_service_type and tb_xdomain_type variables to be constant structures as
well, placing it into read-only memory which can not be modified at
runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/thunderbolt/domain.c    | 2 +-
 drivers/thunderbolt/retimer.c   | 2 +-
 drivers/thunderbolt/switch.c    | 2 +-
 drivers/thunderbolt/tb.h        | 8 ++++----
 drivers/thunderbolt/usb4_port.c | 2 +-
 drivers/thunderbolt/xdomain.c   | 4 ++--
 include/linux/thunderbolt.h     | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index d7abb8c445aa..6a7ec53ddc44 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -326,7 +326,7 @@ static void tb_domain_release(struct device *dev)
 	kfree(tb);
 }
 
-struct device_type tb_domain_type = {
+const struct device_type tb_domain_type = {
 	.name = "thunderbolt_domain",
 	.release = tb_domain_release,
 };
diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index d49d6628dbf2..6bb49bdcd6c1 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -356,7 +356,7 @@ static void tb_retimer_release(struct device *dev)
 	kfree(rt);
 }
 
-struct device_type tb_retimer_type = {
+const struct device_type tb_retimer_type = {
 	.name = "thunderbolt_retimer",
 	.groups = retimer_groups,
 	.release = tb_retimer_release,
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index bca6f28c553b..5a617ea285a7 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2327,7 +2327,7 @@ static const struct dev_pm_ops tb_switch_pm_ops = {
 			   NULL)
 };
 
-struct device_type tb_switch_type = {
+const struct device_type tb_switch_type = {
 	.name = "thunderbolt_device",
 	.release = tb_switch_release,
 	.uevent = tb_switch_uevent,
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 1bbbeb034e0e..5e93c02d37b3 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -745,10 +745,10 @@ static inline int tb_port_write(struct tb_port *port, const void *buffer,
 struct tb *icm_probe(struct tb_nhi *nhi);
 struct tb *tb_probe(struct tb_nhi *nhi);
 
-extern struct device_type tb_domain_type;
-extern struct device_type tb_retimer_type;
-extern struct device_type tb_switch_type;
-extern struct device_type usb4_port_device_type;
+extern const struct device_type tb_domain_type;
+extern const struct device_type tb_retimer_type;
+extern const struct device_type tb_switch_type;
+extern const struct device_type usb4_port_device_type;
 
 int tb_domain_init(void);
 void tb_domain_exit(void);
diff --git a/drivers/thunderbolt/usb4_port.c b/drivers/thunderbolt/usb4_port.c
index e355bfd6343f..5150879888ca 100644
--- a/drivers/thunderbolt/usb4_port.c
+++ b/drivers/thunderbolt/usb4_port.c
@@ -243,7 +243,7 @@ static void usb4_port_device_release(struct device *dev)
 	kfree(usb4);
 }
 
-struct device_type usb4_port_device_type = {
+const struct device_type usb4_port_device_type = {
 	.name = "usb4_port",
 	.groups = usb4_port_device_groups,
 	.release = usb4_port_device_release,
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index b48df88981bd..940ae97987ff 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1002,7 +1002,7 @@ static void tb_service_release(struct device *dev)
 	kfree(svc);
 }
 
-struct device_type tb_service_type = {
+const struct device_type tb_service_type = {
 	.name = "thunderbolt_service",
 	.groups = tb_service_attr_groups,
 	.uevent = tb_service_uevent,
@@ -1893,7 +1893,7 @@ static const struct dev_pm_ops tb_xdomain_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tb_xdomain_suspend, tb_xdomain_resume)
 };
 
-struct device_type tb_xdomain_type = {
+const struct device_type tb_xdomain_type = {
 	.name = "thunderbolt_xdomain",
 	.release = tb_xdomain_release,
 	.pm = &tb_xdomain_pm_ops,
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 2c835e5c41f6..4338ea9ac4fd 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -87,8 +87,8 @@ struct tb {
 };
 
 extern const struct bus_type tb_bus_type;
-extern struct device_type tb_service_type;
-extern struct device_type tb_xdomain_type;
+extern const struct device_type tb_service_type;
+extern const struct device_type tb_xdomain_type;
 
 #define TB_LINKS_PER_PHY_PORT	2
 

---
base-commit: b4734507ac55cc7ea1380e20e83f60fcd7031955
change-id: 20240219-device_cleanup-thunderbolt-9125cd61aafa

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


