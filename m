Return-Path: <linux-kernel+bounces-142910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7378C8A31F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D73A2820E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C3B149C4A;
	Fri, 12 Apr 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Opi65Laf"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809E148825;
	Fri, 12 Apr 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934805; cv=none; b=rEMGmN0Xe48WNUY7+ful/gNLjqd5KKRWbXPjVNTgSwXDOguND8v5u6AG/4mqhW5dM3DU7CZTCr/X/fDMsMeMxcqcWSNufhr8I8Wx/SKQ4W9+DdkLtrqoQ4jdcTRkmGjZl3t5UbeG5rERIiCYvWeANOAyWHXIupGMj2CmYeBuViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934805; c=relaxed/simple;
	bh=PB/t6D/nHgvvaaQ7muuWfmBW82xaxpRveW7hV5xtX70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqhK0/wYFXHp7WVHX5nLs1eCSaVyMzoslKBGwPdlBOt/HwkGqRbfTwW2th9WqhxMHFGYqW8Yl+xtk9rL8HV30bKaBJC4RD6dODM5YIs1zwlaPnc2CGnfuE25kJ0As18JCOaFZ+D3ILJAmMaTiTJEB6HXvS4dgu2AQLD3AtGZd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Opi65Laf reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 4c5b826b5a2475f2; Fri, 12 Apr 2024 17:13:16 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 98B0C66CC48;
	Fri, 12 Apr 2024 17:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934796;
	bh=PB/t6D/nHgvvaaQ7muuWfmBW82xaxpRveW7hV5xtX70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Opi65LafSuYwJUPKT7ejSEvopgi81Y+VCChTpJu/gSRz+Un/s9p8wfKlFUynrLEYB
	 ZlVAeZpRnziu2u3uN47Qwmw3O4HBWzAWsKE+bLxOLDnxfUoFpdpTWh6E0V8y87bwwR
	 X6ohqFR4CvU/5iFqz378GN08/hxrcSr46T0UxNHjRc9wPbqW/S2s/mXWONt9hrZsMU
	 WehHH2EZ7tXrM1JCK+fdHiINptpp12OMbzRWzfy4KcODX50HVgiOlzwQf10FzG5asG
	 A1FO2COb9ZFgAYz9RPgVOmKICVzSI4w2952G/OuOPmf2TlctnAZhuVoflmIr5ctlCx
	 gbjn6jgWZx1Rw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 09/12] ACPICA: SRAT: Add dump and compiler support for RINTC
 affinity structure
Date: Fri, 12 Apr 2024 17:10:48 +0200
Message-ID: <9271958.CDJkKcVGEf@kreacher>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Haibo Xu <haibo1.xu@intel.com>

ACPICA commit b9423c1d35b072c8f2acf97a5842b9f144449eaa

After adding RISC-V RINTC affinity structure definition,
enable corresponding dump and compiler support.

Link: https://github.com/acpica/acpica/commit/b9423c1d
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index e32149d605dc..8f775e3a08fd 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -308,7 +308,7 @@ struct acpi_srat_rintc_affinity {
 	u32 clock_domain;
 };
 
-/* Flags for ACPI_SRAT_RINTC_AFFINITY */
+/* Flags for struct acpi_srat_rintc_affinity */
 
 #define ACPI_SRAT_RINTC_ENABLED     (1)	/* 00: Use affinity structure */
 
-- 
2.35.3





