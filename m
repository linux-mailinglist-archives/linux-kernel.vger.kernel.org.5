Return-Path: <linux-kernel+bounces-142912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847FF8A31F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CD11C22729
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A56149C6E;
	Fri, 12 Apr 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="chtHHEM6"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD41487D3;
	Fri, 12 Apr 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934806; cv=none; b=WF55VM0HEAidg6JCzLe+MOzRy0QiDUK3mZ2PPCHB+0BcfmIdpXK0vcb9g8GYHfkGwJlVOz0BJhsJ/nx1Jh3/LJQBzGHGum+JPqGAaPFaU6V+uy1ArDaxif0o+/ZQ35RAUTYtM4K1gAIJFp8JyS3dCe5qKE6/dD0dwiC+Y7K0mpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934806; c=relaxed/simple;
	bh=VPSGYhEfMXIbujDfinXLg/1asWJ+/0n1X+qX0g0UdKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWVx79ypxI/DBMt4Efytq4s9ZFGRjIaz0i7lrMLLzmZaXC4GAX6t/AbNJB4ETaC0LdhSEyiLT7doSNCPORSVykixyreCDyuripnIogiH91lda5QCOkoehK9M9BU35WPRmA6hwAtOUel6YIhEsFp+8T+DyEDZm2eRjFDbWiIxd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=chtHHEM6 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 9adeea97e4d64e85; Fri, 12 Apr 2024 17:13:15 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C560466CC48;
	Fri, 12 Apr 2024 17:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934795;
	bh=VPSGYhEfMXIbujDfinXLg/1asWJ+/0n1X+qX0g0UdKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=chtHHEM6cedvYNM1EmVOPO9BvY3QxSloyRehx8YuV9m8UEKh4k7lTNNEFhhPpWKS1
	 2avMxZc3pylMz8VCbe/50cy72vnenxRRhNPqLhu0mrvkvp9mwpTRPBHOTw2VK8BgHb
	 w78NL9B/Uwmivz3NcXu4zqRQorIiA+mWPirkmxcheLx+MSvLEWhW0MgK8llPYvxfcs
	 KbskO5EPRtdOuDkmFMugj7Ht2kyjHbhDnxCUqQ+y68B31FVRgCUaLlsXHFAguJYigw
	 OcdRv4ha76+yULM0qGKMtb6TQkLaCRMBlQdaeLBHjaiNqm8OwRKdkLOhl0gXYw5/ng
	 esAhBEy+YPOnQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 10/12] ACPICA: Fix CXL 3.0 structure (RDPAS) in the CEDT table
Date: Fri, 12 Apr 2024 17:11:34 +0200
Message-ID: <5939961.MhkbZ0Pkbq@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Hojin Nam <hj96.nam@samsung.com>

ACPICA commit a0ad1ed5105fb8a15f6f8384b8ab0a2157efaf23

struct acpi_cedt_rdpas does not match with CXL r3.0 9.17.1.5
Table 9-24. reserved1 and length fields are already added by
struct acpi_cedt_header.

Link: https://github.com/acpica/acpica/commit/a0ad1ed5
Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 1f58c5d86869..841ef9f22795 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -571,8 +571,6 @@ struct acpi_cedt_cxims {
 
 struct acpi_cedt_rdpas {
 	struct acpi_cedt_header header;
-	u8 reserved1;
-	u16 length;
 	u16 segment;
 	u16 bdf;
 	u8 protocol;
-- 
2.35.3





