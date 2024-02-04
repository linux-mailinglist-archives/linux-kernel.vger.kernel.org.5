Return-Path: <linux-kernel+bounces-51860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4087849029
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7F11F2162C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899A325558;
	Sun,  4 Feb 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="IXM5dO/4"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C561250E2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076313; cv=none; b=qXhzKvswwr0XWPWwn+K/Cdne0YH99m/Hm5fz2UMcfUoH5DoADvnhwLtSeNGLtcyEn9HbOTQApPWrt/laI8JGESI6tKRzWa1p31JadNfuyJq93SB8/h4QeZoz6xE9blfnpmQPURoNv7HmKEZglQ4KLHY6hc4iWewHf71cCeA437c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076313; c=relaxed/simple;
	bh=IFGJxHx2foEPhvFQU7sM0GpN2LJlqR4qLVoO7StADyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I6u/LMBpAWxr3ycDkV8OrcwNtbhuev2KHQUzTbPSQBRymQSEduHJPWeQMb/BzVLtnjsyPprJW6O+KbEEK0g3sbZ8A6FRORYqkO3xs0zVT2CB3Puy/zUrhx6TWFPzTY8kZkWnnF29ftOnlEjAQVElVrC3EwkGfItnIooAzbsPEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=IXM5dO/4 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7393de183so26855195ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 11:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707076311; x=1707681111;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/VZER7gPfVe5svDXHye7OkZXrLijBRk2e2Xh6GGgdQ=;
        b=KihY7LlDm8L7mbZ+fq0lTte3yIaiGhQxaf9OcCZc0bHigCVVSzQPPJCxKEa9nxrD3S
         FiEllOaoq6cujMENSPjtHyNNdFkXm9W+GemQWG2f7gBBHock8dkF2mxdvvi/BgzkB5Ha
         yEDYbpeLArPR9EQ09etE/gIKmPMrCOe56hRu7NOkOxvtXaLPdqju5zmlh0LRrCzwynNA
         dtybE0y68spYK+c6JUlP3x9aT6gHY5Osfll6Czsw7M2aIZDNkVp7sD4p8EUKcXJ1hBD5
         LD2ncFIohrULd+zLjuY1vZGlexE8lVSpJaFIhxL6Lqj41XJYt/JKJep1/eMei+XTqzp0
         75Dw==
X-Gm-Message-State: AOJu0YxPBHcNpCLmqtrjClf/kKz5IaJnvYzcvsB7p4V2HVDwIIduB4k7
	2BgV9OLEokG5OGJiWXvHIKJJJAsZ4RaZJHgzSvTfof43+gEkCWLF2Db+pY6s06X1lw==
X-Google-Smtp-Source: AGHT+IELouHz1u2E8BfCjxMHYJVLdhaBKPdQlsG+TenyZJdYo0QNtq1PI//3Cil7hbT5DOeZRmq/tg==
X-Received: by 2002:a17:902:c084:b0:1d9:624e:126d with SMTP id j4-20020a170902c08400b001d9624e126dmr8377157pld.62.1707076311353;
        Sun, 04 Feb 2024 11:51:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWLon5groo4jnw4/mZbU+Z+fUcODlwd0FpsBATMWMDY9nvN9tcp5E2kLQsuZI6R6CfvwkU83uxZesBaJuEYUvxeBIesoxTiN06ibg==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id v7-20020a170903238700b001d960a29da2sm4866223plh.62.2024.02.04.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 11:51:50 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707076309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m/VZER7gPfVe5svDXHye7OkZXrLijBRk2e2Xh6GGgdQ=;
	b=IXM5dO/4n53v0C99ssxTCdC4Y0W0soa+LR4Np/AZkoTsCPIbT6+SfuM9rncvFN/lgJdqpd
	LFsawKwH5K/KL7UsxYN6rnmpzZgfm136ixXkx+LbJfUsIcI+H1ZbDZtZUQp8QUe7/hxsjc
	8f/M1INN5Mgy4MQtqGvb/JFWht6t13w/FOXPHLh3Sf38dtLSlEPqxeLHQDCMS1WkoFGV/X
	86DF1fdzVfUFOfsGHDzV6hZyXQm+3zJrsqkQKP+3SlIl6bCd9XrBRlZ1ZIF7sCjnGM5Kot
	2Y0+0pe/98t+5/FTc3xHnRfsQvatIFa//kvLvgYWcnWMZPLrzvtlb0wwWrIOvg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 16:52:18 -0300
Subject: [PATCH] intel_th: make intel_th_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-hwtracing-v1-1-23adbf4e6bb5@marliere.net>
X-B4-Tracking: v=1; b=H4sIAPHqv2UC/x3MQQqAIBBA0avErBPMpKirRITZWANhoVmBePek5
 Vv8H8GjI/TQFxEc3uTpsBlVWYDelF2R0ZINggvJBZdsDn7SOyobTrY9l1Oa7MpkZ6q2mQ2va4T
 cng4Nvf93GFP6AA/lXIFnAAAA
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=IFGJxHx2foEPhvFQU7sM0GpN2LJlqR4qLVoO7StADyE=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv+r0cQBlxYlJ4A2ynSWr/rScgjJwaakJqRf6z
 /kKBp2TCteJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/q9AAKCRDJC4p8Y4ZY
 piZpEACl/cSgbf644uTzaFaXigNtdVLSPoB2pZb4OeqW5f/6UgSNaCOqidA1EDIB9M+yiF5SEeL
 Vdu9qjE5x1fI/+Buia12TkPcsyLLAxAt7PiLLqYvTzuLUf+Xp7hOX/0JIcIdaC1XnrhaFKOznJB
 /0EX1+beZPzNB5Ytcz7VDehtGPig2qscBtnv1Gc3XvaMIEkWiWU+4fJMGE5FepV1dMdbHg3qAIB
 kSeblxIHe3i0xXdOLY0YV51jla39zwen2PM1ZXXVnK5oqbh0nP0+Yl7JzfiziLZh6A3evtPXAI3
 7fkh4hPCFAC+H/w92gTzDeCJ7mKST9anGkPxOHWGaqRoenRuVcJTQM8DvDh0WBVaMx0+oo1NywE
 /U1/P8re7RtV9SKBcvS6CSqwKgIZDZSpWjughkPIQLVGPihNJbvNSJYyT+P4vJXz7ovd7uOYPsM
 8LnV0kj+5M4NWTSS/MXOE/1/8zybSAw0y2fXqMNVfRl5rxlBP+aXtYhmjWqvPeFzG/wspeMhxu1
 aaLZ6b/pkJE54BeNdFvz0x4ojClQg+zSqG949BVCJODBCvZnWUIxjlWwHDs2sOYElDT9rtECk2D
 sXbuUycGe2YYMD0ZQTCphS/bqgv4logoGS8ALxWGIa3WCWm+32mDSy4qo2tbGhYBGCq52IrrgA6
 UtvHuoahpn34IvQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the intel_th_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/hwtracing/intel_th/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index cc7f879bb175..7df56b4093f8 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -166,7 +166,7 @@ static void intel_th_remove(struct device *dev)
 	pm_runtime_enable(dev);
 }
 
-static struct bus_type intel_th_bus = {
+static const struct bus_type intel_th_bus = {
 	.name		= "intel_th",
 	.match		= intel_th_match,
 	.probe		= intel_th_probe,

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-hwtracing-49f176bf033e

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


