Return-Path: <linux-kernel+bounces-71287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB7285A2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A355F284D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA182D610;
	Mon, 19 Feb 2024 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="MC36vAxU"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B022D608
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344836; cv=none; b=q28AfHcjqY/9JWmMJ9+L5wb0Od6rEtosMXSNv+aVAJMSMduxCoVqDsgwJw2Tca0+AvQnODMJH0Z+gfYf5l60p1MCG2w4dZEK5NnUp6YYtlBUVUHhpxDvmCCbaRZEAohOrOQAaoQCvgrAu56a5vvOFGLuXgGRWAqPHq6Kr7o0akw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344836; c=relaxed/simple;
	bh=m94DFBN75h11eMjK/lxCoA7i3I1BfSskcMzW+CgEmcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oOVzE5HMXzqrb2SET6GKt7JpC32k17GjHrooDtF9XcX7dCxORWv1eBEXn8RoZFkk956j5Pn69CpHiUKvj/rBt60INcnDGxvpL7XGZMriO7nHjtmwwqFJ8Y8LunmNifGH7w5/UYQFLzymmpmJ+K4BrEjnknG2xkAY7TMeCtfK86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=MC36vAxU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e457fab0e2so448044b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708344834; x=1708949634;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pBesxh4+nFLzoiYgE0c+lzzUwgR3fOryJ/2gHoTxn0=;
        b=gFRU7DyhCE3PjyBVdhBttsIc/GcgNf6mZRpBVaH4QbudP6KhlxSr7pZvy9EbsS4D5X
         jfO20wSW8MajFPWMyqsaFWdUOPg/rCVPHhIp0u066DKXDH+Hct+atF4N6pz51R2KuNoT
         tW4C5DlGenVvIbiQbBpzjYtD9/wBcuTq0BZSdadZFNRUm5h0ybHQbPRRRwN0Nfo9LsE+
         Dd9DqC8Oh8Uorme++iArAwhmQCNUGwCYu/dr4PU6HH116yqQlTbosaTo2J4U6rPTNp5m
         3saubZ9ywqvyqTqRzuPsAZffqXDXMlMtoXoa0iS8JG0Qc0B6BhvfhlO6UlCidtCTEBAY
         X+JA==
X-Forwarded-Encrypted: i=1; AJvYcCVVzLkeZonG2Qwguw/iJvYnSO6H4ydfcx6t7R2Ud86lbMKyWuaZuTdtW8csHfa5hsfeBMskYUzN+1FsSIfLZnMy/k/336NO3JIXYuXU
X-Gm-Message-State: AOJu0Yy86221A80miQhGehU8DK7JNR5bRRvIJ8TbCyE841zPrq5ebFYd
	FyrQNLBHtPfjHpd1aUXt0qr5AzaEToOaaRZc6VjgXQOytx3/Hdcx
X-Google-Smtp-Source: AGHT+IHKPkYDoxgDGFOj6r80fmLwRa0HCPqUzDzCpSNGKGOTn29TycmZI79HDCq6I3Am4KT+B2ZivA==
X-Received: by 2002:a05:6a00:2389:b0:6e0:377f:bece with SMTP id f9-20020a056a00238900b006e0377fbecemr20579977pfc.9.1708344834135;
        Mon, 19 Feb 2024 04:13:54 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id k4-20020aa790c4000000b006e04b47e17asm4659879pfk.214.2024.02.19.04.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:13:53 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708344832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0pBesxh4+nFLzoiYgE0c+lzzUwgR3fOryJ/2gHoTxn0=;
	b=MC36vAxUPSod9WRK2yLA2b3oHSWPZa55hZkREdt3rlNZqKLTgBwj9OJuDUXGnnJb7HGfag
	hJT1e1GCVGdA+Po5LbS4zIbAQNrUqqdT0Sds4JlGa/GK5hOflaEIer/RAyB9eJFPUp3aQO
	+wV26NJVccHkpyRXJ8hg4QaPHmSunhzOLi7JT432/J5XIZG2ytndBzzc/HsrScLDGoKAge
	meV7rKgs/gC/pQwMcpsRy/7jvStMF/rHqFkpgJ9tpHRzTyOJsHjSCv8emk5Zez3vJf6z07
	A119bmBBoEDk3ugBo/oBZci4YknyfdgaEeYwvwvuLX5K6rXwojKllY1KAisDlw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:14:36 -0300
Subject: [PATCH] soundwire: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-soundwire-v1-1-9edd51767611@marliere.net>
X-B4-Tracking: v=1; b=H4sIACtG02UC/x2MWwqAIBAArxL7naAmRV0lIkTXWggTpQeId0/6H
 JiZDAkjYYKpyRDxpkSnryDaBsyu/YaMbGWQXCouxchslQyu5kDtr8DSeXn7UERmeDc457QcVA8
 1DxEdvf96Xkr5AM8qEhxqAAAA
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2275; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=m94DFBN75h11eMjK/lxCoA7i3I1BfSskcMzW+CgEmcU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl00YuiDhOFFfnyc51bRB9ko/i9hRE2Zue44nTt
 egARFE/xROJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNGLgAKCRDJC4p8Y4ZY
 po1fEACK3JjrmJbQYmxM+k3e1xXLldbMkS+i6Jb1msxHOSMpUGG4EYzzhNelkdXTBk/OUFPdbNu
 p3/YjspxqXFX8WtUQP0lphDO5ua6CCJS8JpBNr3YIvst5pNk12rFwcrEKjY7I1twqBLzssUsWS3
 Yupe6dMO5zKr6LjFMKnjKtlac0/kWjzBJM8XpfZqmJCAx3vGRDMsTaxI3UuUt7CQ57FvKsOpi1F
 iXL5ZYfvhTKKzn/wB9ubJg0UZaYtpU0zsWhrgRoGRAfajOLR82P+47wQzpkeh4t2LeC+w1oyUQb
 dPtfF8JoKUwydAVnRTTV5hQYxV8Uuvb6D4CjoOPYwdS/0UUVjC+gGBCNhmwkut47F7SdPyoyhjn
 ZVI+WT2VP06t7JvdAHZVT8sS1e221idROyzKVQto4D8/SjVxw+de2XcT5Srg+ecRb1c5ubbVdsb
 bhVuNNV5xduM4i3WYS1xlAdgyY0WMgVfmUa1xXtGNsWZslzdpt/ZGNFFfPrwkDlwAXqPqJbdSar
 kHPpZDOKfogqB/3MKEj1svrYJzyjh1aAfNz8DunTLu3GmoeyOb523HT4WAUDA/1GmUCtiYl1zyN
 zdul/F6RH9pVS0TAPeRAcHvV0J72WFW1MOrZbQUlIbJfY34un48Dp+YswAX0MxdUI+daY4OpnIp
 2s432J3Iw4Bfm3g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
sdw_master_type and sdw_slave_type variables to be constant structures as
well, placing it into read-only memory which can not be modified at
runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/soundwire/master.c         | 2 +-
 drivers/soundwire/slave.c          | 2 +-
 include/linux/soundwire/sdw_type.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 51abedbbaa66..b2c64512739d 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -112,7 +112,7 @@ static const struct dev_pm_ops master_dev_pm = {
 			   pm_generic_runtime_resume, NULL)
 };
 
-struct device_type sdw_master_type = {
+const struct device_type sdw_master_type = {
 	.name =		"soundwire_master",
 	.release =	sdw_master_device_release,
 	.pm = &master_dev_pm,
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 060c2982e26b..9963b92eb505 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -16,7 +16,7 @@ static void sdw_slave_release(struct device *dev)
 	kfree(slave);
 }
 
-struct device_type sdw_slave_type = {
+const struct device_type sdw_slave_type = {
 	.name =		"sdw_slave",
 	.release =	sdw_slave_release,
 	.uevent =	sdw_slave_uevent,
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index b445f7200f06..693320b4f5c2 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -5,8 +5,8 @@
 #define __SOUNDWIRE_TYPES_H
 
 extern const struct bus_type sdw_bus_type;
-extern struct device_type sdw_slave_type;
-extern struct device_type sdw_master_type;
+extern const struct device_type sdw_slave_type;
+extern const struct device_type sdw_master_type;
 
 static inline int is_sdw_slave(const struct device *dev)
 {

---
base-commit: 81a7d0c4d059cb5c122110acbeec7bedfb91a741
change-id: 20240219-device_cleanup-soundwire-c037fffa2746

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


