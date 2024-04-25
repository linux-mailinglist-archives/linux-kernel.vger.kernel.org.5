Return-Path: <linux-kernel+bounces-158655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBD98B237E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A027D1F25639
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2AA14A0BF;
	Thu, 25 Apr 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="HieG2HuK"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93406149DF8;
	Thu, 25 Apr 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053954; cv=none; b=gZiky9FU6UPCRGJimoU0hHu6tyQswUh54ZtMkjjqBqbGPk9+7ngWKis6+RtGdnGuLNBnIOFOOCGGuzbdHA851RR0YQVHylzTDSQQpQkgavbWjk4kgdPG5bf8mDIMweQZFibJheVtRy5akMXOCoE+xRFUid4FkOjtNoB2DeKbJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053954; c=relaxed/simple;
	bh=BCnLUuHW13RAzYcj99Bg9BBRzCEWgCC4VRRm5BqFDsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USp2bphl/nrLBSr4fuVcHbaY4UuEmmC8x7DWEBVVCRhCnJqz8osevkvKeuN7+WtNBRx54osUMHU7Dhd9PGYHB14gNPzjgBcXOSULvsL+TaKg8U5hTKgYDR2nhHJR+jGjWJwGdWQZvyQFepqXJHzT2+tFrQcHswpugxJiPqfqV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=HieG2HuK reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 752468661f5a371b; Thu, 25 Apr 2024 16:05:50 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E506066DF23;
	Thu, 25 Apr 2024 16:05:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714053950;
	bh=BCnLUuHW13RAzYcj99Bg9BBRzCEWgCC4VRRm5BqFDsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HieG2HuKO5CcQ0i7OtODKpNqFUSOaQQPOTpIUavE+d+Gk9a9/mxyAimBf2hgy2dvA
	 dsJVKHMA2opf2AKveKxAUNUYc8AsWqdLuR5P0AbpdyzjIcMKn9gdmFjRv7apnyLGRx
	 YJfZmfq2ZWYHf3wkJXcND6fqErYnOEObXpFgBHYf7Z//mfjZtIz1OpNzHT2CxYnlAN
	 wwiWjD92im90VTn+mosDOf78TwPkdkudpUzh5diqYpHRkPY2Z8oJntOXy0vhjnZ1tE
	 9ogklxeIPT/DgQ+mbYG/MkfpSMNrqpOkykfjjrp/L/Zl8uRI4Ql8ScnFJviIB+WRw8
	 f1T6tYokl/cCA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 1/3] thermal/debugfs: Create records for cdev states as they get
 used
Date: Thu, 25 Apr 2024 16:03:42 +0200
Message-ID: <10458619.nUPlyArG6x@kreacher>
In-Reply-To: <3297002.44csPzL39Z@kreacher>
References: <3297002.44csPzL39Z@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because thermal_debug_cdev_state_update() only creates a duration record
for the old state of a cooling device, if its new state is used for the
first time, there will be no record for it and cdev_dt_seq_show() will
not print the duration information for it even though it contains code
to compute the duration value in that case.

Address this by making thermal_debug_cdev_state_update() create a
duration record for the new state if there is none.

Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
Reported-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -433,6 +433,14 @@ void thermal_debug_cdev_state_update(con
 	}
 
 	cdev_dbg->current_state = new_state;
+
+	/*
+	 * Create a record for the new state if it is not there, so its
+	 * duration will be printed by cdev_dt_seq_show() as expected if it
+	 * runs before the next state transition.
+	 */
+	thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations, new_state);
+
 	transition = (old_state << 16) | new_state;
 
 	/*




