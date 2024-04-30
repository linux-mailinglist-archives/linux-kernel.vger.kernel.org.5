Return-Path: <linux-kernel+bounces-164607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4127C8B7FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AB31C21DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA4719068E;
	Tue, 30 Apr 2024 18:42:20 +0000 (UTC)
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB7181319;
	Tue, 30 Apr 2024 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502540; cv=none; b=pgC3yyDRV4fF4sZdbXNt5z7EqbuMSoq6eQtbuEFzrcqGLUw3omjhkd93E0UiY0TupFqMM9+Nc1wUFzILlqijGfsiRzco4Y0gqqnf+62LZP3ucAXabOl2BV8W88geNHdwzRkXdBf+MqZ1Dt1zEE8cIku00BMBlCiCESd/vhEFuTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502540; c=relaxed/simple;
	bh=2SWBAatX6Tq6dfCeZcUL/f9RTcVf03C+StuX5KzUDEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRFZDVX63V43lELWPkvUcI0/PdpQKP7A4FjpcR84KTeWpFwIc792Q8ZaUdJN8TyBB76EN4fuNblmjGdoooNyLLVaPR0JumBiAUylQv6emnA1g3DdfsKPIqpTYOzlzF13DZP+RrVvJr38Kkx4dXESXBaA1lSreQqDuPNJN1qE9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breq.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breq.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3c75075ad30so3876362b6e.3;
        Tue, 30 Apr 2024 11:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502537; x=1715107337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gRPPAtOqAwMAtylna7iyoPZyPLqxt58VXYi95JXmxo=;
        b=HCh9IA1K6J2evLMzdmq8D+2tDZfjfHhKnmJCQEY0AE6MIjqKm4GZO9T2M4lpmjTuhf
         /6QO5lCKZLJOfusE/AtAYM307wWIWGHCJZP4nxrHEDflD6gVmECA6qNpP0I9Lk0RVoLL
         4VtOBK3Gu5Kw417zH1GrVQptkqxdzv7Ney0yAr30IUbi5vpJ68TasGR5c6TZpRhMjp3W
         dbwqipxT3pb2J6TxekyD9/DmRP0vas5IyewnO+teR7qdOl+2+6RRRkPK0KLHnRirTa03
         sk5W8v33SRv1E78Cha8cBSHp6d3750IgkTx38/T/LM/qOKj43ASFBQYPcGw91gBIQseE
         Fj7w==
X-Forwarded-Encrypted: i=1; AJvYcCWyUvptXyN7TXXfjvEjzhRfUgWc2YCpmWdfNRDALeriL1Yd3jJVvyOq39dmN3VaSE5diXt/WxIEfh5FB4ymOBoY+lUq+DuXTEe1UlAS8OqR4a1HQ10nBbds4rbPwQSidcgoHf/FIRlguQ==
X-Gm-Message-State: AOJu0YyubpZ+f6sZFsGfzNJC0zZnBCjTroTo7bPQEDyUmSm3CajnfVRr
	HRK1F/rCPtT73kL12c3UQ7SbIwzmDhILIxzEHpzrxt2AEEjuzoih
X-Google-Smtp-Source: AGHT+IGlHJ1jpHTqX1qio86LU7j9pVRajNIWRCPKuRkq5mR4t5v4o04BuxVmsz3zZrFDQ/LqY+2DTw==
X-Received: by 2002:a05:6808:d52:b0:3c7:39f5:d3b5 with SMTP id w18-20020a0568080d5200b003c739f5d3b5mr541578oik.58.1714502537437;
        Tue, 30 Apr 2024 11:42:17 -0700 (PDT)
Received: from artemis.cable.rcn.com (146-115-84-170.s2975.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.84.170])
        by smtp.googlemail.com with ESMTPSA id a15-20020a0ce90f000000b006a0e94eb3e9sm338920qvo.34.2024.04.30.11.42.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Apr 2024 11:42:17 -0700 (PDT)
From: Brooke Chalmers <breq@breq.dev>
To: 
Cc: breq@breq.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: resource: Add Asus Vivobook N6506MV to irq1_level_low_skip_override
Date: Tue, 30 Apr 2024 14:40:52 -0400
Message-ID: <20240430184146.66887-1-breq@breq.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Override the keyboard IRQ level on Asus Vivobook N6506MV laptops to make
the internal keyboard functional.

Add a new entry to the irq1_level_low_skip_override structure, similar
to the existing ones.

Signed-off-by: Brooke Chalmers <breq@breq.dev>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 59423fe9d0f2..1097d9dd657b 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		/* Asus Vivobook N6506MV */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
+		},
+	},
 	{
 		/* Asus ExpertBook B1402CBA */
 		.matches = {
--
2.44.0


