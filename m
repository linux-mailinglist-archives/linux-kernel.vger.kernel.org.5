Return-Path: <linux-kernel+bounces-148613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6C8A851A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF8A1F21B00
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1103A1420A6;
	Wed, 17 Apr 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="q7C9906n";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="I3j9U7Cc"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514A140384;
	Wed, 17 Apr 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361462; cv=none; b=iScoE9b38SXIV4jdeNZ/HC75VdX0rJ6SSfP+WPqiBSPA5MWnMVi2sx3p08a+qYM5+5Tqx72C0k8YrjAe/Y3p1Y/OG5mvwcNUsF2+6TSSuVOPLo4Q13fXXKmHF3ZqMbPEoHS/WT0031iUNJjjcshtOEyRGj3bYSrbWLAmC8I8eJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361462; c=relaxed/simple;
	bh=yK+ROtYitetXJ8XItGGO6/66x6yNtq2igZnZMLn+JwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHiDkP8NmFKFLLTNVJBDCpN4mAjF2swjoAnMWMgWeV18bQ7CfQJQXxBMxc8i2OuyPKB+wHxN7pogxAzwGiVPStdQ/xrtPkPomUSsRgN4KTg+Kng7QIRMZXqXQhAlmKgFi9fV4hgRY4U9l/JwVa/Fz49x/HfdBSOWUhqT8bU5Fs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=q7C9906n; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=I3j9U7Cc reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713361459; x=1744897459;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CR6cJnQRvZN30ZHhHz6IPksA2Q8whaqadyCrTglEecc=;
  b=q7C9906ns2MOF1ua01PQhPsRJo6RsEdtIAxWxyuNO2riqaogQYJmOBN/
   AzV5zpjyAJaYAkiqgAQqJ6c6RRV8cxBUjIzOEm/9Q0uo8fGsFyHFss0FB
   K3M2xSVlGu7+UdtXHVF9JEoaKQwlllvVbMYGNKmkzPjm/kPuWRtwqQSHx
   7iMlpel6PMtzRIvYFtJ7b1pCjuffpJTVrfEU9ZG3aeyQMA+2BiTXgfqEh
   AfEt/a5A+Q/zQGtiWKOuYB4GvmZkXAWxXFWRZyw4+V7NuE7tQlIQEUg8P
   YMincUbXU8sehADRItwkkE7LUmBSlhFIH+C3QibhbP0WA0BkUSlzpPu5b
   g==;
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="36469975"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Apr 2024 15:44:18 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A894F173198;
	Wed, 17 Apr 2024 15:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713361454;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CR6cJnQRvZN30ZHhHz6IPksA2Q8whaqadyCrTglEecc=;
	b=I3j9U7Cc4zIBmBF7fLlz1b5cg9hVllwfbGQZ1JdEuPxrn8Guq7Y+6tcZgbc1+9+8uDf01U
	XYqBn3wNOOoHXsQJoFIlKNEUsNg/3vBWpr8LXqosVzzcuckW4lohix/whUP0RyxMmc69gR
	MVO9iOj29liXnxYqNcHqw2i71DAsWN0Eh6YZ/z6fg2WUNaEpj9QQNg6Hm5zn35cED7C+dc
	vpapbRzqAkpJdG8qJFPnBF4bI9vyZdzW0AY1GG/oT9mlHMrks0JTJhV6LE3jhUnA4EdLcp
	WjTmUiSQXNgo3MSnnam897b8LcXkfone+ld5PaoD6wBezy49O3E3SxN078VHiA==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 17 Apr 2024 15:43:55 +0200
Subject: [PATCH 2/4] can: mcp251xfd: mcp251xfd_regmap_crc_write():
 workaround for errata 5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-mcp251xfd-gpio-feature-v1-2-bc0c61fd0c80@ew.tq-group.com>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 alexander.stein@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713361443; l=2482;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=yK+ROtYitetXJ8XItGGO6/66x6yNtq2igZnZMLn+JwQ=;
 b=NTlVNUGdN/FgjDQUOEv+ceBRxM5INd2qvI5QU8/MlIO4G4ViHcqs1qHWld/jSxyllh8xHp6QA
 5q+iqGB9b+pCkeFCOu/NSdNpG1l85aL6Nw1SNDqHynW0aEFNFRe+EXc
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

According to Errata DS80000789E 5 writing IOCON register using one SPI
write command clears LAT0/LAT1.

Errata Fix/Work Around suggests to write registers with single byte write
instructions. However, it seems that every write to the second byte
causes the overrite of LAT0/LAT1.

Never write byte 2 of IOCON register to avoid clearing of LAT0/LAT1.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 35 +++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 92b7bc7f14b9..ab4e372baffb 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -229,14 +229,47 @@ mcp251xfd_regmap_crc_gather_write(void *context,
 	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
 }
 
+static int
+mcp251xfd_regmap_crc_write_iocon(void *context, const void *data, size_t count)
+{
+	const size_t data_offset = sizeof(__be16) +
+		mcp251xfd_regmap_crc.pad_bits / BITS_PER_BYTE;
+	u16 reg = *(u16 *)data;
+
+	/* Never write to bits 16..23 of IOCON register to avoid clearing of LAT0/LAT1
+	 *
+	 * According to Errata DS80000789E 5 writing IOCON register using one
+	 * SPI write command clears LAT0/LAT1.
+	 *
+	 * Errata Fix/Work Around suggests to write registers with single byte
+	 * write instructions. However, it seems that the byte at 0xe06(IOCON[23:16])
+	 * is for read-only access and writing to it causes the cleraing of LAT0/LAT1.
+	 */
+
+	/* Write IOCON[15:0] */
+	mcp251xfd_regmap_crc_gather_write(context, &reg, 1,
+					  data + data_offset, 2);
+	reg += 3;
+	/* Write IOCON[31:24] */
+	mcp251xfd_regmap_crc_gather_write(context, &reg, 1,
+					  data + data_offset + 3, 1);
+
+	return 0;
+}
+
 static int
 mcp251xfd_regmap_crc_write(void *context,
 			   const void *data, size_t count)
 {
 	const size_t data_offset = sizeof(__be16) +
 		mcp251xfd_regmap_crc.pad_bits / BITS_PER_BYTE;
+	u16 reg = *(u16 *)data;
 
-	return mcp251xfd_regmap_crc_gather_write(context,
+	if (reg == MCP251XFD_REG_IOCON)
+		return mcp251xfd_regmap_crc_write_iocon(context,
+						 data, count);
+	else
+		return mcp251xfd_regmap_crc_gather_write(context,
 						 data, data_offset,
 						 data + data_offset,
 						 count - data_offset);

-- 
2.34.1


