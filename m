Return-Path: <linux-kernel+bounces-148325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A128A80F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C84B212BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A4713C689;
	Wed, 17 Apr 2024 10:31:08 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384FA1386B3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349868; cv=none; b=mFNGnESX0f2bg6XApFWLzS+82DLaFcq4XjPbmsrOkKhKyE9tcFVTyEw19Gl1vVSJQRnBxLFP+xJIp1fi/kDhIOc8pUK9+Da2mW1UzYFF5jmg+jNuCEjD+T1XQRF2MdYNH5BFRZu5ptXcyRys4zVgqHC9WyLzJ6QPz0tsp2cE6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349868; c=relaxed/simple;
	bh=oo7aLJcvguP5C6Fr2kTmcD7Omy+Ka45JByP2fpqa2KY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exxohf9sgnSNRee9ki/ex6rsyS2S/oWyPgDpKmH9B++kuczVbRbHMze/35ANj68oAckPLKU5vmzZYOC0lTzJdqzJ4P6DDp9qvpDUYJcTgGX8pf0MywbUne/FtiPZHNebRZWYhas40UnodATLUyN/ZfL0HQL0ZfjlPf0o5n/JE2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by laurent.telenet-ops.be with bizsmtp
	id CAX32C00E0SSLxL01AX3wF; Wed, 17 Apr 2024 12:31:04 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rx2Yd-009LEC-OA;
	Wed, 17 Apr 2024 12:31:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rx2Xe-00FLSA-Eb;
	Wed, 17 Apr 2024 12:29:26 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] pmdomain: renesas: rcar-sysc: Remove rcar_sysc_nullify() helper
Date: Wed, 17 Apr 2024 12:29:24 +0200
Message-Id: <ad61b09283cc8a9cf93a5ea9fffd1cb283b9db92.1713348705.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713348705.git.geert+renesas@glider.be>
References: <cover.1713348705.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no more users left of the rcar_sysc_nullify() helper, so it
can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/rcar-sysc.c | 12 ------------
 drivers/pmdomain/renesas/rcar-sysc.h |  8 --------
 2 files changed, 20 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index a60ce08e7d3b09cb..a9d92e38fcee902c 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -439,18 +439,6 @@ static int __init rcar_sysc_pd_init(void)
 }
 early_initcall(rcar_sysc_pd_init);
 
-void __init rcar_sysc_nullify(struct rcar_sysc_area *areas,
-			      unsigned int num_areas, u8 id)
-{
-	unsigned int i;
-
-	for (i = 0; i < num_areas; i++)
-		if (areas[i].isr_bit == id) {
-			areas[i].name = NULL;
-			return;
-		}
-}
-
 #ifdef CONFIG_ARCH_R8A7779
 static int rcar_sysc_power_cpu(unsigned int idx, bool on)
 {
diff --git a/drivers/pmdomain/renesas/rcar-sysc.h b/drivers/pmdomain/renesas/rcar-sysc.h
index 266c599a0a9b9198..8c4ec36ed7da2f9d 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.h
+++ b/drivers/pmdomain/renesas/rcar-sysc.h
@@ -71,12 +71,4 @@ extern const struct rcar_sysc_info r8a77980_sysc_info;
 extern const struct rcar_sysc_info r8a77990_sysc_info;
 extern const struct rcar_sysc_info r8a77995_sysc_info;
 
-
-    /*
-     * Helpers for fixing up power area tables depending on SoC revision
-     */
-
-extern void rcar_sysc_nullify(struct rcar_sysc_area *areas,
-			      unsigned int num_areas, u8 id);
-
 #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
2.34.1


