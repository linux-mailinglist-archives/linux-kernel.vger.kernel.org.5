Return-Path: <linux-kernel+bounces-98736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025A7877E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B121D28171A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D889638DDB;
	Mon, 11 Mar 2024 11:01:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B204F383A1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154903; cv=none; b=Y4aKHWX4xQS/w+ZAUY+rv8fpLw3wc2YCVIPO+suG1jpxSvH1okA1E0U86hOM213NCS1hHpYNv9ziFucS2Vma4jfuEnuUakFy3e2I7Z5gPSwCE5T6gSdhyq2LltROSmMsyW8t+jw5zSYvEt68d6ebXwOQSn9hdK6ywdRbPLDOCI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154903; c=relaxed/simple;
	bh=p6vRuRinfdWXh6Sy8kvwOzGV5lYzkzBvVit0iOGNe2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JuH0L8u8gTzvSOcTSrotrt9asayR7GutDIWhcA5GbrAVM4qp5J6DulN2gfsXng0wD3EfukmH4cn0w+O4QYsf0GgmWjvG7SB3Mc+LPEyePWU5TyQ1NfQGUslzQmxvCp1F13Ai4nObWoOIRDesRsuvKZ7GCD22524cSu9V6duyctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjdPU-0001So-9X; Mon, 11 Mar 2024 12:01:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjdPT-005h9n-NV; Mon, 11 Mar 2024 12:01:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjdPT-003zmm-24;
	Mon, 11 Mar 2024 12:01:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] lib/build_OID_registry: Don't mention the full path of the script in output
Date: Mon, 11 Mar 2024 12:01:22 +0100
Message-ID: <20240311110121.459581-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=p6vRuRinfdWXh6Sy8kvwOzGV5lYzkzBvVit0iOGNe2g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7uSB6TMG8H6Zt1ktqbzUJrVBve7sQYE33AeGP rM2VS7u0xGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe7kgQAKCRCPgPtYfRL+ TjGUB/9NGgHiG6cVudTL1zCEB6wVVIEbIliOjDvkOPnHIomQfvEmB6N09S6lYVLdc02cgn6WrpK aKG744n2ZXocxNiEhjzl2js0qsqiVJ63b9lmnGn3CREuYWYsGF+EmPruqZtrfiq7jBUpgPon1iN uUyjsd32F1oDbSOWuG/CASJR88lO8n+jyKEwNHjTqV09tOzph5GLGXrana66vZXgnmzrcBFuCNB GERQBTYlGcIs/v6eBlZhMXrI75aiygHcNl9yq6246FIfKI7wQxG9l5jBYkdTL5Dn5xVqfRdVEW+ ALU6qmzmQj4xpJlq9y8y+fIvJMYg/yfEvAgJNct2VKfiNH7y
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This change strips the full path of the script generating
lib/oid_registry_data.c to just lib/build_OID_registry. The motivation
for this change is Yocto emitting a build warning

	File /usr/src/debug/linux-lxatac/6.7-r0/lib/oid_registry_data.c in package linux-lxatac-src contains reference to TMPDIR [buildpaths]

So this change brings us one step closer to make the build result
reproducible independent of the build path.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 lib/build_OID_registry | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/build_OID_registry b/lib/build_OID_registry
index d7fc32ea8ac2..324ee6520ee2 100755
--- a/lib/build_OID_registry
+++ b/lib/build_OID_registry
@@ -35,7 +35,7 @@ close IN_FILE || die;
 #
 open C_FILE, ">$ARGV[1]" or die;
 print C_FILE "/*\n";
-print C_FILE " * Automatically generated by ", $0, ".  Do not edit\n";
+print C_FILE " * Automatically generated by ", $0 =~ s#^\Q$ENV{'abs_srctree'}/\E##r, ".  Do not edit\n";
 print C_FILE " */\n";
 
 #

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


