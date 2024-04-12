Return-Path: <linux-kernel+bounces-142909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ABB8A31EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1855BB25494
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33C1487F1;
	Fri, 12 Apr 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="gztiwGiu"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59D1487D6;
	Fri, 12 Apr 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934804; cv=none; b=d1HABry0rEiM7XgRe4O8iKYwRk44OKaTIRYlTLr12WGk5XBebOBXgX+Z4ISbsH7y3ptTrLieS5e5qi3cEGAnMzW5WU22Xe2cRugPkdslPXJoyGw7HrgvpvKzWtXDJnzrywSAV22W8v9LsIrYCuiKriQGikU8O3T/WqLmAR77HKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934804; c=relaxed/simple;
	bh=z3eInpC6E3xhqZdsL8ZAbel/kFTj1PbYZLhspguFhGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qORaiapOimCkBDp6rcHCrPsA6yrYdcOLgDrGeZGM6hhzoh4XU0YIgwxECMXspsV7dI1AjZD8ewqBSYwQHPfxKoOp1DMApNPZr0jm5sEKanWlVcjAjqLjRP8tZprado82DiD2iiyUXxbxBcvkRTFABjPmtDbCFjawIbVAFUnqe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=gztiwGiu reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id dc2ae899fde4f9e4; Fri, 12 Apr 2024 17:13:20 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 562AD66CC48;
	Fri, 12 Apr 2024 17:13:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934800;
	bh=z3eInpC6E3xhqZdsL8ZAbel/kFTj1PbYZLhspguFhGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gztiwGiuG4g6p28BSQAg9EHs94B2QTlpMg7amsKbzyP5AwNw8Z7BMrpytVadBGnFN
	 QNG5Htxn9bwcpStYkoAgFGU9Qyo8FyxRCh2sMwZk/PXbp1xEuGZW05wWIYlcBukSlT
	 cUckNcpOF68EeMpzEIpQ4BlS7X8K1NrKOsl6Iqa+yOuajhzwPNi7e6wTHoyT4iAKUO
	 3aMeNkgmPv1/yaKJjHfLlY/ZEIKzI3LEPEFZMApoP24D/sGhAAPgjVSnmi/gfb8LVo
	 B+P3h+/OBy5X+esIF42xveQB/tG356jVsbuIkYwYs1cI8G4gwqDWo/g4Nlw+TUlEDO
	 9+g30OW6DC/QQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 04/12] ACPICA: Fix various spelling mistakes in text files and code
 comments
Date: Fri, 12 Apr 2024 17:06:35 +0200
Message-ID: <3294335.aeNJFYEL58@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Colin Ian King <colin.i.king@gmail.com>

ACPICA commit 6cd47047aca6e273c84a5ce95d2f6d8485f958d1

There are a handful of spelling mistakes in various files as found
using codespell. Fix these. No code changes.

Link: https://github.com/acpica/acpica/commit/6cd47047
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/aclocal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 82563b44af35..02012168a087 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -547,7 +547,7 @@ struct acpi_field_info {
 
 struct acpi_ged_handler_info {
 	struct acpi_ged_handler_info *next;
-	u32 int_id;		/* The interrupt ID that triggers the execution ofthe evt_method. */
+	u32 int_id;		/* The interrupt ID that triggers the execution of the evt_method. */
 	struct acpi_namespace_node *evt_method;	/* The _EVT method to be executed when an interrupt with ID = int_ID is received */
 };
 
-- 
2.35.3





