Return-Path: <linux-kernel+bounces-142906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545148A31E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD701F21ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50AC14885D;
	Fri, 12 Apr 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="QA4kR7uJ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904F1487C3;
	Fri, 12 Apr 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934804; cv=none; b=CwZvHQxucixsx4cMu6qrXvbsUPAtSZ0abdl0t5gJWesFkJXalRAmN7+usRI7L+LoOcUrgfzZGYofeT5YZexlgevVdDVjH8y0xAuJqaDdg+awM7jtOsZavfxqwSpBA3xn0svOiWoyPuMWUZqAj5YyE0MRJNDz5IBIMkReI4Nrzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934804; c=relaxed/simple;
	bh=D/I7zxNBS8m8Chbv2XRv0I+6HHBNWVRfkhP2l99McE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvjCKuCGP1cLWTlHSycjUrGAxDIaV4aclmCTutf7D+iQuShwmyEWymArXIiGSpM8vwE0syPaAE7ENhT6NYXeuJt14MD90pz9XcZKVpkQt0kh+215e1N9yCz14T+TWcGnSeYajOcfIXrHqdE3q1+/qOfk1VTzFAoLRGFdbrLrIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=QA4kR7uJ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 8ba249045168371a; Fri, 12 Apr 2024 17:13:14 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EB84466CC48;
	Fri, 12 Apr 2024 17:13:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934794;
	bh=D/I7zxNBS8m8Chbv2XRv0I+6HHBNWVRfkhP2l99McE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QA4kR7uJKDXiNZkWegNMd3v9l1E8+saTyFWpAV5nQ+y1rK2LlvFetr5m/6t1Se1CK
	 Vc8HxWQaMCHTbf4ZYM3j6fqt2+FDEFyJitJdoRCEbf0JkzOvssmvPOfsFjKw8ZdEf1
	 AI59NgRPSQjNI8+wJHmpPTda2YkIiwJSjClA9NYk0VcOtoNYOtJBVoGxo5caJJ075j
	 C2w8KPY6DTt9E4O+DO3D0T1briGf5jPrtw8CjhrB7pvbeItQRSrRARYoelasVObYb5
	 VPbufxnDALv10nDvNRjjf8TQMMehJgF3ZUMJrVpjru1bwPsxkGJtBLqzEaabadFZPN
	 oeYLtOLTre1KA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 11/12] ACPICA: events/evgpeinit: don't forget to increment
 registered GPE count
Date: Fri, 12 Apr 2024 17:12:21 +0200
Message-ID: <8409590.NyiUUSuA9g@kreacher>
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

From: Daniil Tatianin <99danilt@gmail.com>

ACPICA commit ba8a36b5c7343cb56af6b331362e97b25e898eb2

This was used to log the number of newly discovered GPEs post table
load in acpi_ev_update_gpes(), but we never incremented the number inside
acpi_ev_match_gpe_method(), so that was never logged.

Link: https://github.com/acpica/acpica/commit/ba8a36b5
Signed-off-by: Daniil Tatianin <99danilt@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evgpeinit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 0dbc4d88919a..38f408cf13ce 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -413,6 +413,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 	gpe_event_info->flags &= ~(ACPI_GPE_DISPATCH_MASK);
 	gpe_event_info->flags |= (u8)(type | ACPI_GPE_DISPATCH_METHOD);
 	gpe_event_info->dispatch.method_node = method_node;
+	walk_info->count++;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
 			  "Registered GPE method %s as GPE number 0x%.2X\n",
-- 
2.35.3





