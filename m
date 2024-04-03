Return-Path: <linux-kernel+bounces-130337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FCF8976EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B54B2965C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20516191C;
	Wed,  3 Apr 2024 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxJYywpm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FA161908;
	Wed,  3 Apr 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164774; cv=none; b=TU0FxUF3bW8cMI4Z09z815PUu0NkGyffZcRO2pKoG2+RZ4I1cIBeH+5CEsdD9UArJnq14TBIfdIY1xXxiSAq+/FmnW+3K4brsVpNx88yl5bgtjwsRI16SFOlqcQoM1v/TYjVps1CEos1jIAuFXnGIe7dfHAgNc3EMbcVW2Qz33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164774; c=relaxed/simple;
	bh=KGum2UiFM/XeeIttcKMIY9uAmatsd+1YLL7DOdMp7+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hwf5B/GQHuga9A+bgz/pv44y83QJu6w3n3RCHpwOm5tGvNVo4TWLW6CcgzhcEfhBgFK7Zhgrg6KwnLmJQoflGBhBVl01xI7GXdEEjSss9dhgu/q5hofqYiE/mq44XxpZiWg6z27lH7kZhQ83GtNpNu/smX85tVDL3UOQRP3ZUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxJYywpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46003C43330;
	Wed,  3 Apr 2024 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164774;
	bh=KGum2UiFM/XeeIttcKMIY9uAmatsd+1YLL7DOdMp7+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxJYywpmra78Gjn9DYEa57C4jiRZo5Fw9WEcSfmnjczIo32MIM+OXGHiTZmiX3dkS
	 JID+bJjLG29Bukx6kheSDjeFa1uPFkjBFWkqvKkANLXdjg8IorgnFCNmr+TL9VJB0C
	 wbIyHITEzW+zR2oFAyKPEOx4xLlokq5r+2Fb4ia/KXpo2mUcIN3cYEP7KqPhGVukz4
	 OYb/XtVkat2kuwqVSkN+9FNuleLeAnEj3WcnEDKYb2rZzvGC1vj+1ZwX8iPCQgDQm6
	 FKX0hT0IX0kmz7qVBaPOEimjB3fIsHxbznMkAeop5twpf6NQgTEaCCBvfLNbE6lPyI
	 s6ZoRwsrQ5tMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	FlorianSchandinat@gmx.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 12/15] fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2
Date: Wed,  3 Apr 2024 13:18:56 -0400
Message-ID: <20240403171909.345570-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Aleksandr Burakov <a.burakov@rosalinux.ru>

[ Upstream commit bc87bb342f106a0402186bcb588fcbe945dced4b ]

There are some actions with value 'tmp' but 'dst_addr' is checked instead.
It is obvious that a copy-paste error was made here and the value
of variable 'tmp' should be checked here.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/via/accel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/accel.c b/drivers/video/fbdev/via/accel.c
index 0a1bc7a4d7853..1e04026f08091 100644
--- a/drivers/video/fbdev/via/accel.c
+++ b/drivers/video/fbdev/via/accel.c
@@ -115,7 +115,7 @@ static int hw_bitblt_1(void __iomem *engine, u8 op, u32 width, u32 height,
 
 	if (op != VIA_BITBLT_FILL) {
 		tmp = src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_1: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
@@ -260,7 +260,7 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, u32 width, u32 height,
 		writel(tmp, engine + 0x18);
 
 		tmp = src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_2: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
-- 
2.43.0


