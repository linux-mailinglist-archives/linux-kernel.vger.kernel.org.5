Return-Path: <linux-kernel+bounces-23674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817A682AFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3174528C26B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A13A8F4;
	Thu, 11 Jan 2024 13:44:04 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D0364A9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8291:a340:26b8:8238])
	by michel.telenet-ops.be with bizsmtp
	id ZRju2B0084LvM1A06RjuCM; Thu, 11 Jan 2024 14:43:54 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rNvKw-00F7rd-Qm;
	Thu, 11 Jan 2024 14:43:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rNqle-008hXN-5V;
	Thu, 11 Jan 2024 09:50:26 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Christian A . Ehrhardt" <lk@c--e.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: unittest: Fix of_count_phandle_with_args() expected value message
Date: Thu, 11 Jan 2024 09:50:25 +0100
Message-Id: <20240111085025.2073894-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The expected result value for the call to of_count_phandle_with_args()
was updated from 7 to 8, but the accompanying error message was
forgotten.

Fixes: 4dde83569832f937 ("of: Fix double free in of_parse_phandle_with_args_map")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/unittest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 45bd0d28c7173db9..cfd60e35a8992d7d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -574,7 +574,7 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	}
 
 	rc = of_count_phandle_with_args(np, "phandle-list", "#phandle-cells");
-	unittest(rc == 8, "of_count_phandle_with_args() returned %i, expected 7\n", rc);
+	unittest(rc == 8, "of_count_phandle_with_args() returned %i, expected 8\n", rc);
 
 	for (i = 0; i < 9; i++) {
 		bool passed = true;
-- 
2.34.1


