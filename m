Return-Path: <linux-kernel+bounces-33151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AAD836551
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583C6B24E43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A323D57C;
	Mon, 22 Jan 2024 14:24:44 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD83D559
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933484; cv=none; b=VKkUAk//KgPgtHmgldlJ3bendgOB/4Bta0TavYfvaqRUJfbuFNwl2br/tUHfoBTOXatmvmqMGhx3FESjCaDQxTpfPdmse0dRJkCZHjEx+pUWIRrOpw5Y/9e8FYCpO65aMS+SToUzyAjrRZNs0TuK7PYn5EzEzI2TEi/OREQvZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933484; c=relaxed/simple;
	bh=5xeF4V2g1z6BIJIvEXeiCjThl4DXXG8UvRJEdC08uxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sU50nK25nngu+RqkvZmw7FjZwoAWcjurhA1+i+xajqIFDJryOX40GKgHtNQgLtd33zLYK7AM64uIY3q5P5Azxt3rSdClT9xXgla6LchkVNQQa+xq0JMLbgBTduG318a3w2hAK9qOX8bY3rV0SNzu486sygXbhs9SAXonrwbZoNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:955e:bba5:7ff4:cfb6])
	by baptiste.telenet-ops.be with bizsmtp
	id dqQa2B00S0ZxL6o01qQbH1; Mon, 22 Jan 2024 15:24:35 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvDF-00GGwu-R5;
	Mon, 22 Jan 2024 15:24:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvE2-00CFAb-Rt;
	Mon, 22 Jan 2024 15:24:34 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-staging@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Subject: [PATCH v2 2/4] staging: board: Remove KZM9D board staging code
Date: Mon, 22 Jan 2024 15:24:31 +0100
Message-Id: <f54fe56524e0266a3c705315f04870988912cfcf.1705932585.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705932585.git.geert+renesas@glider.be>
References: <cover.1705932585.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With the EMMA Mobile USB Gadget staging driver removed, there is no
longer any use for the EMEV2 KZM9D board staging code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
---
v2:
  - Add Acked-by.
---
 drivers/staging/board/Makefile |  1 -
 drivers/staging/board/kzm9d.c  | 26 --------------------------
 2 files changed, 27 deletions(-)
 delete mode 100644 drivers/staging/board/kzm9d.c

diff --git a/drivers/staging/board/Makefile b/drivers/staging/board/Makefile
index ed7839752e129abb..5db091b5ca01596a 100644
--- a/drivers/staging/board/Makefile
+++ b/drivers/staging/board/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y	:= board.o
-obj-$(CONFIG_ARCH_EMEV2)	+= kzm9d.o
 obj-$(CONFIG_ARCH_R8A7740)	+= armadillo800eva.o
diff --git a/drivers/staging/board/kzm9d.c b/drivers/staging/board/kzm9d.c
deleted file mode 100644
index d449a837414e6934..0000000000000000
--- a/drivers/staging/board/kzm9d.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Staging board support for KZM9D. Enable not-yet-DT-capable devices here. */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include "board.h"
-
-static struct resource usbs1_res[] __initdata = {
-	DEFINE_RES_MEM(0xe2800000, 0x2000),
-	DEFINE_RES_IRQ(159),
-};
-
-static void __init kzm9d_init(void)
-{
-	board_staging_gic_setup_xlate("arm,pl390", 32);
-
-	if (!board_staging_dt_node_available(usbs1_res,
-					     ARRAY_SIZE(usbs1_res))) {
-		board_staging_gic_fixup_resources(usbs1_res,
-						  ARRAY_SIZE(usbs1_res));
-		platform_device_register_simple("emxx_udc", -1, usbs1_res,
-						ARRAY_SIZE(usbs1_res));
-	}
-}
-
-board_staging("renesas,kzm9d", kzm9d_init);
-- 
2.34.1


