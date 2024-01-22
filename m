Return-Path: <linux-kernel+bounces-33192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA08365DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19211F220A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202C3DB83;
	Mon, 22 Jan 2024 14:50:53 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1F3D553
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935052; cv=none; b=BsJIUd+z0c0eD2S8Yg3Za1uSbB4OtUmJZlQyJ96SC5/Fx11Q3bV+X7BH1YOs+64bWs66Mcdfux04E+FqJ9idJnAkz1UCvMCSIZdGoP8ektlnmQccIycAC86+LqrMhXN1Di5j3vAICSydcGN4P2/Y30JFo7c4wVkbAZ31UmwattU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935052; c=relaxed/simple;
	bh=dCsN5Xwxzp8w/3SKShSYkJ/ugzoeRbU8bWqgmHB1nFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cIcl6IiWAg0aTTDCGX9/95E1h3kV11KSayxrRoYZtRYCU/YFimvEAgrpnDkRXrNkoaCtJXandVsV2XXcOP1V+At66TkglWiaBw91LCIZllOiqTNiTn90uyAVOLabKwHNMWTsRmyHX8NG+uO0X99kwRG7vfdSRu9JEkrmLSgAsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:955e:bba5:7ff4:cfb6])
	by michel.telenet-ops.be with bizsmtp
	id dqqn2B00k0ZxL6o06qqoHv; Mon, 22 Jan 2024 15:50:48 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvcc-00GGyr-Qa;
	Mon, 22 Jan 2024 15:50:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvdP-00CFi4-Ri;
	Mon, 22 Jan 2024 15:50:47 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] lib: dhry: add missing closing parenthesis
Date: Mon, 22 Jan 2024 15:50:45 +0100
Message-Id: <772b43271bcb3dd17a6aae671b2084f08c05b079.1705934853.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705934853.git.geert+renesas@glider.be>
References: <cover.1705934853.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The help text for the Dhrystone benchmark test lacks a matching closing
parenthesis.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 79dc58b938f860d3..b93eccc2ebfb756a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2141,7 +2141,7 @@ config TEST_DHRY
 
 	  To run the benchmark, it needs to be enabled explicitly, either from
 	  the kernel command line (when built-in), or from userspace (when
-	  built-in or modular.
+	  built-in or modular).
 
 	  Run once during kernel boot:
 
-- 
2.34.1


