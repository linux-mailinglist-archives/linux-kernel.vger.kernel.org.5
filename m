Return-Path: <linux-kernel+bounces-18762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C598262A7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 03:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BE4282E86
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E910787;
	Sun,  7 Jan 2024 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apvNioIi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB0101DD;
	Sun,  7 Jan 2024 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68009cb4669so8006956d6.1;
        Sat, 06 Jan 2024 18:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704593613; x=1705198413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z6x4FnsNbhe0lWnxf/CCjJTz+ocztnYQV+3F3SJpB8=;
        b=apvNioIii0BOYMbjEtaBL+z82EiwLi5GnWyKe4ugnYC1l+Svayu+may+6JtxrsnyLM
         rg3gV6CAc9AiKnMXYTLCppUHV+9zl7q9TPFAF+1cs8x4+6rmIz3xQioRhcegFRXaXH/e
         t4hsWxHGwpq12dPwPfqfiDJS+dtyz/CnWNWE9KFSfH9ckQY33ZHrtLvDlfxZwJsqzm/+
         QkuL9Pw3bJbKjdJ1AcMH9wQ8Aucu5EDaBvf2ERvlN6qxhbcZ2ZsL8CEYussCESGdWkoP
         Tp84oFoXKwKKwMmm0bm1Ax70IZp55HbfmufWKVNXzjVtD70GEuGffSPr3IhjQgLhPZeE
         3YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704593613; x=1705198413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Z6x4FnsNbhe0lWnxf/CCjJTz+ocztnYQV+3F3SJpB8=;
        b=N/WnraCFgWSVVSaHqQPF3PqAQtC++rv9uj5y+yua3hvmZws7dCdk72jwuUdSn//MFq
         v8N1vsKsjf0ei71QrucSpbdF1Xqx0Tm1Jwh683K7DaAZdRaKdDHmr9IzFhwBQbDy38Wu
         TCmrgs67DKqTn6Q6xZ9JgLorEVuiQXpPYUvaQE27VHytDAK0sk6f9YC7XA/LMm50wosN
         1q4MAF2KKhoaSztqykQoevTshJFCKAckhnFfb0QlSRdZ3Fdda6xcgpUX10IUOksuopTJ
         xwJ+DkU/gUAZhdshoKR50FWh3at9qnx+81tcor2JDLux+NOPaqmKz3ALwNwk1vwS6OdX
         /Mzg==
X-Gm-Message-State: AOJu0Yx4x46D11hwwyXRM/7uXtElq4LNXLVwgR2w5GqMvz4nmodH9MXc
	nAqZkGGugln3HNNVIPqfF68=
X-Google-Smtp-Source: AGHT+IG+3gpbyy5Rr6t26K0+FkAI1ImeNZYdD1pLE0WX+5Hw5LBTnlMADrivVQlorCF6HK50YmzNGw==
X-Received: by 2002:a05:6214:528e:b0:680:c5ef:b170 with SMTP id kj14-20020a056214528e00b00680c5efb170mr2314365qvb.58.1704593613194;
        Sat, 06 Jan 2024 18:13:33 -0800 (PST)
Received: from fedora.. (c-73-4-251-179.hsd1.ct.comcast.net. [73.4.251.179])
        by smtp.gmail.com with ESMTPSA id a17-20020a0cefd1000000b0067f70c0dcd9sm1744870qvt.64.2024.01.06.18.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 18:13:32 -0800 (PST)
From: Ben Mayo <benny1091@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Mayo <benny1091@gmail.com>
Subject: [PATCH] acpi/drivers: add DMI exception for ASUS Vivobook E1504GA and E1504GAB to resource.c
Date: Sat,  6 Jan 2024 21:13:23 -0500
Message-ID: <20240107021322.7709-2-benny1091@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asus Vivobook E1504GA and E1504GAB notebooks are affected by bug #216158
(DSDT specifies the kbd IRQ as level active-low and using the override
changes this to rising edge, stopping the keyboard from working).
Users of these notebooks do not have a working keyboard unless they add
their DMI information to the struct irq1_level_low_skip_override array
in resource.c and compile a custom kernel. This patch will add support
for these computers to the linux kernel without requiring the end-user
to recompile the kernel.

Signed-off-by: Ben Mayo <benny1091@gmail.com>
---
 drivers/acpi/resource.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 9bd9f79cd409..eb34d201b65f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -482,6 +482,20 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
+	{
+		/* Asus Vivobook E1504GA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "E1504GA"),
+		},
+	},
+	{
+		/* Asus Vivobook E1504GAB */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "E1504GAB"),
+		},
+	},
 	{
 		/* LG Electronics 17U70P */
 		.matches = {
-- 
2.43.0


