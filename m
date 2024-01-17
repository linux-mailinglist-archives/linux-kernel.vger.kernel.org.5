Return-Path: <linux-kernel+bounces-29503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55AE830F66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751A61F21CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8F2DF88;
	Wed, 17 Jan 2024 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="NyCI0udk"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EC28E12;
	Wed, 17 Jan 2024 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531167; cv=none; b=il0pKW2dpB8YVPi5iRvUlK/3uM6JsYqaqnVDPNjF2FGW87gYf+ZT4ev3Vf19+9sOVYuoQ+Jt14duvnxCvYY1n+pqWf/z9CQOcs5TILH/LLlDBU8o+FvJO8fSm/+6TsT6Z1t45d4vHiK7uKpp4P6ArKhcS3mKKBQwH/b1b1SSRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531167; c=relaxed/simple;
	bh=qq68Svgtjykhbhl5rAlPQhu0HhKZSWC/DLcmfv0KXyI=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=B7kUoGEuVx66GuPM6jD7fuJFy3zf9LACW2LGeQMr0ZnGIFhdryt9vN7hzD/P2yTlWEeUGftc1/cNfBDFs2QamHj8w82t3oAWZ6zPqn007sazCgzA5SRhyc+z/ft+xvHKSa4K2Ffvd3x9RglJXQlQn5+JHt9v3zQmbL1vQa/rtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=NyCI0udk; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=TfKTVwhndI1UyGewTV1S4ar0XEK7Df5xSFhlc8zyp1E=; b=NyCI0udkdrOdbzlJa3Bg9YU8SW
	poSd63AqaOle1d+k6UHqYi+Sgoj22KYnDloxFxWPLel2viPXf1C6uF/8d9iOob9JTwd1L0B5Eqjhm
	uQmOjHXGhYhsvnBv31hr+j+LxsMQk5ZRN7g/0bbHJQ4KRtSNhJTMOr0f19TYaJ4tDfJc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEZ8-000155-EF; Wed, 17 Jan 2024 17:39:22 -0500
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
Date: Wed, 17 Jan 2024 17:38:53 -0500
Message-Id: <20240117223856.2303475-16-hugo@hugovil.com>
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
Subject: [PATCH 15/18] serial: max310x: replace ENOTSUPP with preferred EOPNOTSUPP (checkpatch)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fixes the following checkpatch warning:

    WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP

According to include/linux/errno.h, ENOTSUPP is
"Defined for the NFSv3 protocol", so replace it with preferred EOPNOTSUPP.

Similar to commit c7581a414d28 ("drm: Use EOPNOTSUPP, not ENOTSUPP").

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e39d8ea51e4e..12219b22b880 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1217,7 +1217,7 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 				1 << ((offset % 4) + 4), 0);
 		return 0;
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 }
 #endif
-- 
2.39.2


