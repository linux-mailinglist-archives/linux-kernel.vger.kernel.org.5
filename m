Return-Path: <linux-kernel+bounces-39959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A15FA83D7D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61401C3005B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757AC50A8B;
	Fri, 26 Jan 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVh5vbrD"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042350A74;
	Fri, 26 Jan 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262796; cv=none; b=otmlz+ifdjIvk5Jn89nBwJOjtI7tdmuvSuNOX08ByIoNKkjzlwMFhHmoc/PeSRxd47+6NSEWbuRm6x6Qm4zIGzPg2EgGcCFeOk9AG3q55DrhxZ1y+9oiv3yHsVL/00dtDbAPh2hiH/m2hHtxFFSWjczMe0KOQcZ7CJzTXUZMHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262796; c=relaxed/simple;
	bh=qIyNv2GKT/pRB+BCdOcRrE+9O93YX0P2wOyy8cuwfv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uVgP2v0FCokT3a+QsqfBX5tB2YjlHREPucbaaP/YHSf+T7kPgqq+4KVk7YZF0YADE6Pu57ePwcjJyWiacDom6SXN7xAiDNmmm8n6wFPmmJEWFd2G9wGMTOGOg/ixT4xZUnqMtX9Kjq/uX6SqR81ptnYEMn7Qu0fhDV4w3ldBHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVh5vbrD; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5955a4a9b23so136234eaf.1;
        Fri, 26 Jan 2024 01:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706262794; x=1706867594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ/3kDvRhsDFelMOEvB+kaIVBVK6Cu/lnq9gIh4BpOQ=;
        b=cVh5vbrDU/7Vj2Ey5n/9DinrNSaB22lcEKzR853TwFy7g6hfKDoquYGaXBynGNE54L
         2BoRwHk5oIC+NtHfYh6mICZL5JGjkYQC8XtxT55dPhYOvyxJJ2lKjosUitFjlGx+5Dan
         hFW8Q3aa9goMLiNmKQQ2ALdvh+CAdXr3UlXu1/HpmySl123omSu+nPzbYcRMpalg84/j
         nr3WekkArBmiwnQ3tIYdWoXT5Gl0Sq2kX74MB1KS+pOGOHlvL54uCPLj+UfIa1FS08QU
         iXj/jX+5W1y3erFxuXeT692F9FCDje0Tnz3RhamzPFOVSUKMAL72Yc3UDe/zT6qXroJ3
         eDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706262794; x=1706867594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQ/3kDvRhsDFelMOEvB+kaIVBVK6Cu/lnq9gIh4BpOQ=;
        b=H2+daFcZ7rC7lu3gc03HCLiUHGy/2H5IbWdNc1XVbDQUVJGj3grAMg7S0pfdqic1sk
         3JAqfQoXgRtHHqeCAHWHImePUjcUp17geqptSxsKw/Rn0PNQ43aXML2YFXg+Rtm4u6P+
         RYythOqn/S6sPP0SLrGb3tYoR29BwVEoGUedyRm0Cfw8hoGqm0ETgVDya5KsfcpGkBrm
         2alvDxPaWbmiOpRzNPdvItgf8XQHtMeQTF38Z6Av9HkK1rYqFHz07+9IlHYXF5P4djDM
         DG+8K2m5RXeOqBmC6EHq7owSLEOtoeXVNpGBAVEjrJHgAQE6u6+q42Lwdob/4f9NXJwG
         Bmeg==
X-Gm-Message-State: AOJu0Yw/XR+SKs5BaO/e5m/Vf3JFMawhPT6BnALQG2tkyrzNRYg9NW2r
	8SoJeVLzwBC18Ij+Ca9wtkgKKawVNfkriIb2u0vUg9nI7f4VrRif
X-Google-Smtp-Source: AGHT+IFAR8CEw9FYEn6c0qELGbaw9Md3V/BeXz2XULDluuB2LMDlrD8c62HnOllvMmmfg5+iT2qznw==
X-Received: by 2002:a05:6358:7502:b0:176:7f72:36af with SMTP id k2-20020a056358750200b001767f7236afmr1111329rwg.23.1706262794099;
        Fri, 26 Jan 2024 01:53:14 -0800 (PST)
Received: from h310mstx.. (2001-b011-4000-1ad1-19f3-37ad-3632-eedd.dynamic-ip6.hinet.net. [2001:b011:4000:1ad1:19f3:37ad:3632:eedd])
        by smtp.gmail.com with ESMTPSA id ei20-20020a17090ae55400b0028feef0f956sm2822847pjb.17.2024.01.26.01.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:53:13 -0800 (PST)
From: Phoenix Chen <asbeltogf@gmail.com>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Phoenix Chen <asbeltogf@gmail.com>
Subject: [PATCH] drivers/platform/x86/touchscreen_dmi.c: Add touch config
Date: Fri, 26 Jan 2024 17:53:08 +0800
Message-Id: <20240126095308.5042-1-asbeltogf@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added touch screen info for TECLAST X16 Plus tablet.

Signed-off-by: Phoenix Chen <asbeltogf@gmail.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 0c6733772698..7aee5e9ff2b8 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -944,6 +944,32 @@ static const struct ts_dmi_data teclast_tbook11_data = {
 	.properties	= teclast_tbook11_props,
 };
 
+static const struct property_entry teclast_x16_plus_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 8),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 14),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1916),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1264),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-teclast-x16-plus.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data teclast_x16_plus_data = {
+	.embedded_fw = {
+		.name	= "silead/gsl3692-teclast-x16-plus.fw",
+		.prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
+		.length	= 43560,
+		.sha256	= { 0x9d, 0xb0, 0x3d, 0xf1, 0x00, 0x3c, 0xb5, 0x25,
+			    0x62, 0x8a, 0xa0, 0x93, 0x4b, 0xe0, 0x4e, 0x75,
+			    0xd1, 0x27, 0xb1, 0x65, 0x3c, 0xba, 0xa5, 0x0f,
+			    0xcd, 0xb4, 0xbe, 0x00, 0xbb, 0xf6, 0x43, 0x29 },
+	},
+	.acpi_name	= "MSSL1680:00",
+	.properties	= teclast_x16_plus_props,
+};
+
 static const struct property_entry teclast_x3_plus_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
@@ -1612,6 +1638,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_SKU, "E5A6_A1"),
 		},
 	},
+	{
+		/* Teclast X16 Plus */
+		.driver_data = (void *)&teclast_x16_plus_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "D3A5_A1"),
+		},
+	},
 	{
 		/* Teclast X3 Plus */
 		.driver_data = (void *)&teclast_x3_plus_data,
-- 
2.34.1


