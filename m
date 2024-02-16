Return-Path: <linux-kernel+bounces-69356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF7D8587EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F18CB2BF10
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9490145FEF;
	Fri, 16 Feb 2024 21:16:57 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC41384A6;
	Fri, 16 Feb 2024 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118217; cv=none; b=UiA0ofiGjWKkI+OIyp2Z22hISoKgc+A3sv/DscOcRA4/uZomnCD97HoIsq22ZwHjAewWUX03iGpLTaZ7F5Oimj4tYurT8Wqx+JXyZc+6lG0bFMZd33hJT/oiaSw145JrLJx69iYFmxdh4sSacsokmxeS/fjTIYVwDWhGDVo3jfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118217; c=relaxed/simple;
	bh=qSJ1/TTcVsBzLbrf10anAAA1rn4tSH4MQZtvL9vgfq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctNtWpqSFCcTWO+XbMPK010CayhfPNoQEKyr2gRSECLU1qPqVONeT9XYC4gzMQroN+efvUt/vI164/N2WyFU8lSbjXrrV0xUWC7LjH2wwG/XdXEx+Y8zxTDPqZhee6q1BbNZhyLyOjPcAJAtwHMyVURSlHL60b0g+sZhr9wtHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 4D76785ED3;
	Fri, 16 Feb 2024 22:16:46 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Fri, 16 Feb 2024 22:15:43 +0100
Subject: [PATCH v2 1/2] Revert "leds: Only descend into leds directory when
 CONFIG_NEW_LEDS is set"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240216-expresswire-deps-v2-1-8be59c4a75f5@skole.hr>
References: <20240216-expresswire-deps-v2-0-8be59c4a75f5@skole.hr>
In-Reply-To: <20240216-expresswire-deps-v2-0-8be59c4a75f5@skole.hr>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Hans de Goede <hdegoede@redhat.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Helge Deller <deller@gmx.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=qSJ1/TTcVsBzLbrf10anAAA1rn4tSH4MQZtvL9vgfq0=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlz9CFxRmO8aCVhI+x7Vyk3o4zgPCoN+3XgcQJJ
 NpHqnxdDoqJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZc/QhQAKCRCaEZ6wQi2W
 4Up1D/49POAcQZkjzsmoC6tbb2ATYuJ4+xypsjy5ftiHT8PPYhNfH++nm/LAWiDrnrYkypgvapd
 bksdzvOS+Y8dMkJa/HBO9gsH1rwbrofF03499pw8O2F3T603yHExlOMfPF088VXjC2nhMraaLK6
 K5bkxB+1oQHJwmpbMCTw0RJauc1Rb9CLVVwzkKBdQ1zll/1pqqXa5PE9jCFwfeOZhau851f71l6
 Q6s7V851M6nZws/AwNfAj65kIouCaDMKe4TPuC/Bc48J53txYJmOxvB2lbfhzhcfFX+E/IidvKa
 6qGxTeM2Talut0R3FFuwlImB1PHSklspCh5BHxdihW3srpa+w1Ra37s9XrHhOKgkozonCqNuCjw
 3m0MTKr0/cYpEhobeNjJQiedoWncEDIdFZ8FcMX9ZHvYRhWklqjHbUZspd6LUx3PHjEjo0iR+Hq
 n8EhyXu3sGDZ1zZl4mq4rzGHoKvtl4Ni4FemC7IE09bZEHWlp8e8Q8373xSUcj7wFYJdbH2z10A
 rVYuLq6cyK7cim7j+z6lCXy7SiW4IsYbRtVNYrHKcj6jfJ8NMvu5uViH5V1iiGtkYoJ4O0zXTtZ
 SRLw7ltEpmGPKRAdzwxlwK0EwLDLTgvDFhcaPeR2vP8pKje+4F9PxLEAHdDLyFfTRodRmM45wIj
 WD0L6umB+kpeo2w==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

This reverts commit b1ae40a5db6191c42e2e45d726407096f030ee08.

The ExpressWire library introduced in commit 25ae5f5f4168 ("leds:
Introduce ExpressWire library") does not depend on NEW_LEDS, but without
this revert it would never get compiled if NEW_LEDS is not enabled.
Revert this commit to allow the library to be compiled.

Link: https://lore.kernel.org/2cacd8dc-6150-4aa2-af9e-830a202fb0a8@app.fastmail.com
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- Add "commit" before hash to silence checkpatch
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 37fd6ce3bd7f..3bf5cab4b451 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -135,7 +135,7 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
 obj-y				+= mmc/
 obj-y				+= ufs/
 obj-$(CONFIG_MEMSTICK)		+= memstick/
-obj-$(CONFIG_NEW_LEDS)		+= leds/
+obj-y				+= leds/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/

-- 
2.43.1



