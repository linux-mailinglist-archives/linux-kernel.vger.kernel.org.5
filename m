Return-Path: <linux-kernel+bounces-159785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE42D8B33F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9371C222EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4963813E419;
	Fri, 26 Apr 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="IUu8nUQ3"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257E013E3F5;
	Fri, 26 Apr 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123739; cv=none; b=DIAR/vqwsEalxte/Y+I09esgAlIxjGzf5R8c0hhXIQK9xfX4CI5eGPLtrpNlJyfkdVgRrYnma0ftmzqwGbJAq3rZ/Rm+6V3ZFtoqZh1hgLRJIMJ+Wl8gdtqYCiD4QJDL6LUZQT41a6cN8AwYbnzUsG+gbJepEG2iTji3MGHsUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123739; c=relaxed/simple;
	bh=/M4fAtIj7fEFz5rRmpHzBh/6ABxKJzdtM1sihXoR3a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lID7XmG1amYq/cGcrt2BS+TAFGSby7yPXr5wFtmNPXPJExe/CF2ZnPOQ/LwVT7lRG7eokk401GF4U1uhDqRtrKR1+CK6mqYdBtQTYUfvcfveDWZOnCxOuV/bwl9/usseDNsRzW1fhMsSUHRSgC1r6+qIfwqoUk1HXi3xUeQikzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=IUu8nUQ3 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 803d8b87b1d53edd; Fri, 26 Apr 2024 11:28:53 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0519566DFC1;
	Fri, 26 Apr 2024 11:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714123733;
	bh=/M4fAtIj7fEFz5rRmpHzBh/6ABxKJzdtM1sihXoR3a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IUu8nUQ39P9qeBS1VyK8+eBytHtImpG0KLbp9j3wwAT997Ql8nXVzlslWkZClngqQ
	 RVSLrDYwTdrULftNz2XK2a+aH4wxs+Xdls/IzbZUkWNrAvBsxzAvmECXQSdH2lVnn2
	 vv+5dDogTkxc2iFDzLX+lezdJtrjxSdt7/Y1hC1NgjaoshcQKSrTcD4BtCma3b59JO
	 R9AbSrzeThK39ab3G8lVk7bxDQSGK/ztrYhhjZm67OigU6k4GtUihe3Fd632haYbIK
	 +jJMBWXxiIuFfbZwqh/u+Rrio6b/rYNVb4I2kxuK20c66qMtHMLK1dSkQ6JreJfHsi
	 TMiqVwrvlcTbA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject:
 [PATCH v2 3/3] thermal/debugfs: Prevent use-after-free from occurring after
 cdev removal
Date: Fri, 26 Apr 2024 11:28:52 +0200
Message-ID: <2740417.mvXUDI8C0e@kreacher>
In-Reply-To: <13503555.uLZWGnKmhe@kreacher>
References: <12427744.O9o76ZdvQC@kreacher> <13503555.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudelledgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghf
 rggvlheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since thermal_debug_cdev_remove() does not run under cdev->lock, it can
run in parallel with thermal_debug_cdev_state_update() and it may free
the struct thermal_debugfs object used by the latter after it has been
checked against NULL.

If that happens, thermal_debug_cdev_state_update() will access memory
that has been freed already causing the kernel to crash.

Address this by using cdev->lock in thermal_debug_cdev_remove() around
the cdev->debugfs value check (in case the same cdev is removed at the
same time in two different threads) and its reset to NULL.

Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
Cc :6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Add missing mutex_unlock() (Lukasz).

---
 drivers/thermal/thermal_debugfs.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -505,15 +505,23 @@ void thermal_debug_cdev_add(struct therm
  */
 void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
 {
-	struct thermal_debugfs *thermal_dbg = cdev->debugfs;
+	struct thermal_debugfs *thermal_dbg;
 
-	if (!thermal_dbg)
+	mutex_lock(&cdev->lock);
+
+	thermal_dbg = cdev->debugfs;
+	if (!thermal_dbg) {
+		mutex_unlock(&cdev->lock);
 		return;
+	}
+
+	cdev->debugfs = NULL;
+
+	mutex_unlock(&cdev->lock);
 
 	mutex_lock(&thermal_dbg->lock);
 
 	thermal_debugfs_cdev_clear(&thermal_dbg->cdev_dbg);
-	cdev->debugfs = NULL;
 
 	mutex_unlock(&thermal_dbg->lock);
 




