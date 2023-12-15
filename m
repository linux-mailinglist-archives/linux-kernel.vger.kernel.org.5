Return-Path: <linux-kernel+bounces-847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A840814701
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA606284F15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D246D25102;
	Fri, 15 Dec 2023 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vaDs+Rdp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A/BXbGrY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5724B4A;
	Fri, 15 Dec 2023 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702640031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSN2fEVUsgtu6P86spU9FMzJwboh7vffvRh84WgdouI=;
	b=vaDs+Rdp3LFDY/6qkOXCsSK05KEpzMJmpRcLzOJMb9+EVVrJjHAnyunhJgJmTNYgKYiS32
	PZwD7QK5ltfvaovjpEfI23D5ZsuT0/zWYnwaunlv98h+TeFPL9lE4bQFvKY5X4hPxputhL
	izNJeWUV+PTuL7b3QpBEi7QWDu2MyjxxE4mniB2q/Q7u8gyQnmK/Z2AcMCPuOvIVG7mf55
	3/8Btr+rFoJYz6Vn1GjXt81Z6VsrVjoAJsscLfcJkvAzzC8mPv9UHUJRqC6LolxvVDlZSo
	BJAtDyoovty11K8rq+NcgIWZVS3ATUq2iSmUDpXUqg555lA+C0Rb30yUujb15g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702640031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSN2fEVUsgtu6P86spU9FMzJwboh7vffvRh84WgdouI=;
	b=A/BXbGrYv4ItN4u9A7aIqk8FaNWy//dCwpvqlO8wtC68+Ig6h4bQilY2gmO0Z7+vlcJZlg
	qcmDSh/N/xfBbhCg==
To: linus.walleij@linaro.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] spi: pl022: update description of internal_cs_control()
Date: Fri, 15 Dec 2023 12:33:38 +0100
Message-Id: <4036d8d5845c04179f330f83e825a3921aa50c5a.1702639801.git.namcao@linutronix.de>
In-Reply-To: <f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de>
References: <f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The arguments of internal_cs_control() was changed, but its description
was not updated. Update the description to match the expected arguments.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312151816.munFeE4L-lkp@int=
el.com/
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/spi/spi-pl022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index bdec67cf45f2..de63cf0557ce 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -419,7 +419,7 @@ struct chip_data {
 /**
  * internal_cs_control - Control chip select signals via SSP_CSR.
  * @pl022: SSP driver private data structure
- * @command: select/delect the chip
+ * @enable: select/delect the chip
  *
  * Used on controller with internal chip select control via SSP_CSR regist=
er
  * (vendor extension). Each of the 5 LSB in the register controls one chip
--=20
2.39.2


