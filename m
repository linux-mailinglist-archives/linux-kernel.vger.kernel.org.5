Return-Path: <linux-kernel+bounces-142905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A9A8A31E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261C61F21AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121AB148827;
	Fri, 12 Apr 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qQQc8YnJ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B861482EB;
	Fri, 12 Apr 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934803; cv=none; b=nhd0+jj5+0QWx9Y9rQyBGrD3JqyA6x2jhaSGHb5H/NFyvCQuEgCN3DUD0e0EFrIfK9ZLE+RysF7wggK/T7Ybe5bQswE0RGpktmF2PgW0/Tj5R68B5DSk4sVHsjTh+m6GySc34/Vz5Q1sVOcObLSxp2+KigmQ9CgABK0FTB5Lb/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934803; c=relaxed/simple;
	bh=E1gk3LZozo44aITg1XCYWr1PwZC5BjHqphnzpkpHYjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqf/EAj1rYKlDuqLkssiCFksFndUl32tsrYrrM+qom4ylkHEVoBKUGio281M39Nc8dyYuNcfAnKid7bqKt6Nf5FxK8o7BIZE5OQotOsq4n+ysWPw8b8Q0k28rCK7KP8SBovxqYfZDfcfvdL/i6MovG6CPb9vjaFa6otXFgUaAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qQQc8YnJ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 4e6cc3ead897acee; Fri, 12 Apr 2024 17:13:13 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C46B766CC48;
	Fri, 12 Apr 2024 17:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934793;
	bh=E1gk3LZozo44aITg1XCYWr1PwZC5BjHqphnzpkpHYjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qQQc8YnJtiAwvEZ20eV052KswBaaCYyyxr1JkUtGHhecIH6rbRINc/+dBmNuB5oCB
	 b+xnhHCUGBHQf01FNsxaKrSuI5ZaEMEB48gSJz00Yz9NvjmsTQtx/jibcX5NZfdmr+
	 NgLowk/czedahZ3gnUuh79HWFNH6ucc0Wkz950LpOfAO8lZ+iwDuBnXngUTI534i/T
	 faZd80S73NpYCqR+Ww5ZRKJyxPjWNnL6FEKSwCS1g5Vm+IpQWEcpXnCvBidTIC2Vha
	 ARfzHeErC6RX8AL4BiZpfTx/XsFOFp8t8LSxSb5NDXREwduvNNM/UQecdhPwsW4ZfY
	 OvjbOKXPQFhxA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 12/12] ACPICA: Update acpixf.h for new ACPICA release 20240322
Date: Fri, 12 Apr 2024 17:13:03 +0200
Message-ID: <3487364.QJadu78ljV@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Saket Dumbre <saket.dumbre@intel.com>

ACPICA commit 718374cd1bc21d08960b61069c8ac62b0cf67c0c

Link: https://github.com/acpica/acpica/commit/718374cd
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3d90716f9522..94d0fc3bd412 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20230628
+#define ACPI_CA_VERSION                 0x20240322
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.35.3





