Return-Path: <linux-kernel+bounces-142915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A12FC8A31FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28757B23F11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072D914A4F4;
	Fri, 12 Apr 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="QAR9QOn+"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07231147C7D;
	Fri, 12 Apr 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934808; cv=none; b=dQ24QW6rQ2phHXAS3v15FfKNg/TnbB9KP3y1l6YYDDbf+5JdSwn1/uIRMB1SNjMhiOj+Hx79l2tt4yETBq7La+t7DZfo8i5P3YjAaDjiFP2rMMsVuxaVQSWm0YXlGBuEH8gMxLL4I0mcTyAHL0nlaV9rg3zD/dhtpmFAu1Wq7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934808; c=relaxed/simple;
	bh=MXKmzl9vStH8Iy800kQYS6F4qCSKWpsJSxXMS6D7JPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fELLoLc1f0cxpWBiVyGC6kFtJlS8Mx379oKxMjr66ryziaMnA/A1oeS2zi5uEuQDwWozqbDSBHBJBa/Y+o35GWXEDQKuZcJ9GGus5i50RpdCzxmCNIuJzppYgu8NRsozVPKaCCMQpjfQFu2Kp0W3R1qrG8xQimgiQq5Z2Kv20Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=QAR9QOn+; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id a781b9e1c20eb884; Fri, 12 Apr 2024 17:13:23 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5FB6366CC48;
	Fri, 12 Apr 2024 17:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934803;
	bh=MXKmzl9vStH8Iy800kQYS6F4qCSKWpsJSxXMS6D7JPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QAR9QOn+tCb1qm3oL0tiqoYyPVTWX+ih1t/yvGpQBedj6lwlC+kLG+PT/pMJBZy/q
	 qDKdS9oe4YcPRctSed63XHtxIOJ4fQfc49+G2Bw7m/TaMW4mjdn5sWZfP/l6nUr87q
	 FIXPqyXXxo8rsX0Dly9TG88oujOJKmX4Gbue1PBVSUf5ZZj4TmozE7Sp+ZwR2gcPTD
	 OAfeAyaQFkOunDoGVy1dNtvfdutMchN/AUMwXqswRXi6a+10SHsDDvtyLkhFI863XU
	 VgN7ZX3rCgJNQOExbKh5Rwo2KRh9dFQy5f8U0WI+bQLtNz75JzIHBnHguJ1B/wztcJ
	 N3lMpnKqvaT9g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 01/12] ACPICA: actbl1.h: Add EINJ CXL error types
Date: Fri, 12 Apr 2024 17:04:16 +0200
Message-ID: <2330760.ElGaqSPkdT@kreacher>
In-Reply-To: <4920972.31r3eYUQgx@kreacher>
References: <4920972.31r3eYUQgx@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4

From: Ben Cheatham <Benjamin.Cheatham@amd.com>

ACPICA commit c7171588a9f684afafc83c6c18ed0bab9274e5e6

Add EINJ CXL error types added in ACPI v6.5.

Link: https://github.com/acpica/acpica/commit/c7171588
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index a33375e055ad..1f58c5d86869 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1096,6 +1096,12 @@ enum acpi_einj_command_status {
 #define ACPI_EINJ_PLATFORM_CORRECTABLE      (1<<9)
 #define ACPI_EINJ_PLATFORM_UNCORRECTABLE    (1<<10)
 #define ACPI_EINJ_PLATFORM_FATAL            (1<<11)
+#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     (1<<12)
+#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   (1<<13)
+#define ACPI_EINJ_CXL_CACHE_FATAL           (1<<14)
+#define ACPI_EINJ_CXL_MEM_CORRECTABLE       (1<<15)
+#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     (1<<16)
+#define ACPI_EINJ_CXL_MEM_FATAL             (1<<17)
 #define ACPI_EINJ_VENDOR_DEFINED            (1<<31)
 
 /*******************************************************************************
-- 
2.35.3





