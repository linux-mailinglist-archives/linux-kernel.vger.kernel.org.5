Return-Path: <linux-kernel+bounces-129290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90EF896845
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C2D1C20EC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A892D13D268;
	Wed,  3 Apr 2024 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnbFzmjd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924F8665A;
	Wed,  3 Apr 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131773; cv=none; b=m4vpxnpDL7Ah/XwEJfNfooYyiUJsE2mE7dYSTc80QEa3cLUHc65jfIp5HFIq4LIa5b/1vbfWyhjEMcwMlm6B3m/hFm58mkRnIsjpa3KIaPpILL1WW3aWn2Qyss7dWACSJuI6k4CRjFLOhvyr9Gzxmvt8rzMFaa1EE4TGA0J4By4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131773; c=relaxed/simple;
	bh=FvIlBe77Yoh0MKWjYe9xoZT/FkLcQ+ILm2wyKc5MkhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I0xPPTxlTsXeCUKfKcLdjKlC6ajNnwqmpTBMmufLl4xI9VBxb5rQxkX8AswTBhBw+UkLyxFZCw7t9ZQpLqs8/TZ0enlCFZlFOd6AB5zJkawwes+pdjuYbPaomG6xpo8USudqklxpDzeeCSEQJyskIhlcw6uKIxq/Tb8xt12kV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnbFzmjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B11AC43390;
	Wed,  3 Apr 2024 08:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131772;
	bh=FvIlBe77Yoh0MKWjYe9xoZT/FkLcQ+ILm2wyKc5MkhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RnbFzmjdcQ30Sndx9lkziwpkmrab2NP+OVJvBb2yaxEFNr9FpWviNtIg1gorVVRei
	 L70xsTLYzUCRe/lTrqA6icZWxYwqnUjd8HsI+E6FgfnFdYdwr6KlyJy3q2qWqJspTc
	 6jtYazoHB15Jahe4kdRKCzoOBEZljXCEQpr6hgTGdDOb0nsr3dgwh89azelMWhpb40
	 8qamJntci6zOE9vaHJu36X3BMs21LbZggER3B94qvzbaTDIgr0Vx/Ogiep25DnHlQA
	 IJgIW+fS9xHPA3zozHqv6BbLZp69J7CsEoL2dDqLBABIasOTWDAtABcvctQaTTUzaz
	 sDNsDcobDonKA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 13/34] sisfb: hide unused variables
Date: Wed,  3 Apr 2024 10:06:31 +0200
Message-Id: <20240403080702.3509288-14-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows that a couple of variables in this driver are only
used in certain configurations:

drivers/video/fbdev/sis/init301.c:239:28: error: 'SiS_Part2CLVX_6' defined but not used [-Werror=unused-const-variable=]
  239 | static const unsigned char SiS_Part2CLVX_6[] = {   /* 1080i */
      |                            ^~~~~~~~~~~~~~~
drivers/video/fbdev/sis/init301.c:230:28: error: 'SiS_Part2CLVX_5' defined but not used [-Werror=unused-const-variable=]
  230 | static const unsigned char SiS_Part2CLVX_5[] = {   /* 750p */
      |                            ^~~~~~~~~~~~~~~
drivers/video/fbdev/sis/init301.c:211:28: error: 'SiS_Part2CLVX_4' defined but not used [-Werror=unused-const-variable=]
  211 | static const unsigned char SiS_Part2CLVX_4[] = {   /* PAL */
      |                            ^~~~~~~~~~~~~~~
drivers/video/fbdev/sis/init301.c:192:28: error: 'SiS_Part2CLVX_3' defined but not used [-Werror=unused-const-variable=]
  192 | static const unsigned char SiS_Part2CLVX_3[] = {  /* NTSC, 525i, 525p */
      |                            ^~~~~~~~~~~~~~~
drivers/video/fbdev/sis/init301.c:184:28: error: 'SiS_Part2CLVX_2' defined but not used [-Werror=unused-const-variable=]
  184 | static const unsigned char SiS_Part2CLVX_2[] = {
      |                            ^~~~~~~~~~~~~~~
drivers/video/fbdev/sis/init301.c:176:28: error: 'SiS_Part2CLVX_1' defined but not used [-Werror=unused-const-variable=]
  176 | static const unsigned char SiS_Part2CLVX_1[] = {
      |                            ^~~~~~~~~~~~~~~

This started showing up after the definitions were moved into the
source file from the header, which was not flagged by the compiler.
Move the definition into the appropriate #ifdef block that already
exists next to them.

Fixes: 5908986ef348 ("video: fbdev: sis: avoid mismatched prototypes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/sis/init301.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
index a8fb41f1a258..09329072004f 100644
--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -172,7 +172,7 @@ static const unsigned char SiS_HiTVGroup3_2[] = {
 };
 
 /* 301C / 302ELV extended Part2 TV registers (4 tap scaler) */
-
+#ifdef CONFIG_FB_SIS_315
 static const unsigned char SiS_Part2CLVX_1[] = {
     0x00,0x00,
     0x00,0x20,0x00,0x00,0x7F,0x20,0x02,0x7F,0x7D,0x20,0x04,0x7F,0x7D,0x1F,0x06,0x7E,
@@ -245,7 +245,6 @@ static const unsigned char SiS_Part2CLVX_6[] = {   /* 1080i */
     0xFF,0xFF,
 };
 
-#ifdef CONFIG_FB_SIS_315
 /* 661 et al LCD data structure (2.03.00) */
 static const unsigned char SiS_LCDStruct661[] = {
     /* 1024x768 */
-- 
2.39.2


