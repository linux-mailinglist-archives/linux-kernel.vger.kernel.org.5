Return-Path: <linux-kernel+bounces-29498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC5830F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33C71F268C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67F2C854;
	Wed, 17 Jan 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="cbWV9vEP"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF028E07;
	Wed, 17 Jan 2024 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531161; cv=none; b=V869EOc3wSjX7KClS1toJk/KgaGjggr5g+jvoVoN/huqjse6fvOt4P5Xc9EruBSAlGJGpznDW+woLo/0G61E1x2eq1Q+nqU9sd7OfVcyS9pbC6BPTdTud/OM3UBPMW+6ZJ1PE7S9qlI5/3SBFcl9Yt3IQBeALN0Qf9LOltkkmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531161; c=relaxed/simple;
	bh=LG1XkAm+pVD/M5D2xlLUOZxrIEqTkYj1+DNyBG/MGsI=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=DH5t+2O5uOxLg3/EnpYS/ETokDqgTjRyptbxwkb3Sl1WdSGJu4FDK7ZxHcl1CR73QQ+9dutNyPw7xlzDBiiVcwwrPMWDR1k2ZrlxbrLSW0EdwctjTgqo8GYd90GHP/Qd4Q9GVVnaN5SVaEbVMfinDajDVZiw56K//b0V8QCaGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=cbWV9vEP; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=tKjX+pLpR8hzsx1Di3oRU87vSyeR7xOmR97tTtTRkaQ=; b=cbWV9vEPEiZjNN41TiFvYlI65I
	cTQtBnEMigvEP5l+BtltvRm4RBe1Du7osAG3yRbW4Vg9MdRFp+2f8QyHUrPAVmBG1klsIEKKd+d9m
	bLF0vCXrKlRHWJ8bCgC6p/3T78XowMEtgHz12NT4NQjty2uxrTmGBDbfkHAjXL21i+tg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEYu-000155-Sg; Wed, 17 Jan 2024 17:39:09 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 17 Jan 2024 17:38:44 -0500
Message-Id: <20240117223856.2303475-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117223856.2303475-1-hugo@hugovil.com>
References: <20240117223856.2303475-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 06/18] serial: max310x: remove holes in struct max310x_devtype
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Running pahole shows that there are some holes within the
max310x_devtype structure.

Remove holes and optimize alignment by reorganizing structure members.

This can also lead to data structure size reduction for some CPUs.

On 64-bit CPU (arm64):
Before:
    /* size: 40, cachelines: 1, members: 6 */
    /* sum members: 34, holes: 2, sum holes: 6 */
    /* last cacheline: 40 bytes */
After:
    /* size: 40, cachelines: 1, members: 6 */
    /* padding: 6 */
    /* last cacheline: 40 bytes */

On 32-bit CPU (i386):
Before:
    /* size: 32, cachelines: 1, members: 6 */
    /* sum members: 26, holes: 2, sum holes: 6 */
    /* last cacheline: 32 bytes */
After:
    /* size: 24, cachelines: 1, members: 8 */
    /* padding: 2 */
    /* last cacheline: 24 bytes */

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 27c8ec956691..21f2fa3a91e5 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -258,11 +258,11 @@ struct max310x_devtype {
 		unsigned short min;
 		unsigned short max;
 	} slave_addr;
-	char	name[9];
 	int	nr;
-	u8	mode1;
 	int	(*detect)(struct device *);
 	void	(*power)(struct uart_port *, int);
+	char	name[9];
+	u8	mode1;
 };
 
 struct max310x_one {
-- 
2.39.2


