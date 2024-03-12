Return-Path: <linux-kernel+bounces-99979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6F687901F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE3D1C20944
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A8E77F19;
	Tue, 12 Mar 2024 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cqRA9V1x"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3477F00;
	Tue, 12 Mar 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233664; cv=none; b=kv6qJWdkHxKXflZre0HLhPCp3p89foQpL7K+tFz3ZP2+x5otLZ/KWf+PXiz6cuj5MGp9xbmEy2DjjwV+ldXubm06n2ErTNUm+6AdxcPmwipmjV9tSvE7UcStAcPzYrNhVxfQO/DTQEOyC5H6yfC5kHs3J5wc4361irj3vk4ksqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233664; c=relaxed/simple;
	bh=v/q1qVsAjFqdy95pGh+TCh2GnS5R55nwOsexJepHNlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Il3iJZRPJgKgCdaimHCZqHhU4FioWG/x6cbN6VMDnDZ+oHhXtDdRCXEmlqMYKeAr+FplpChxJyV6JXGfzarOwSfHQ8WwNEPEOkElKGBrVWD0PcCmxZXNiZm4vEY8iGt9GKW6y6u2vJc3S/PDMtR/bt26+UeGVBtD8mwN6YxME50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cqRA9V1x; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 946E21C000B;
	Tue, 12 Mar 2024 08:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710233659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Va/V9kPpijtdOzFWFEkjafB4xSVQdTFezkUKicaC9OU=;
	b=cqRA9V1xbTouunLrxjD3nnEn+2V9SWcHA34VbAFTqx2GIDGi+MwFLb3pmfdQODmG8kW18W
	2HmS5uIComnwj3s2166gAM7fxMCf/7wxxxGRuoBuo8X27uBFR3FiEg5OkLFiPpM3oDfsVg
	jF3/X5+WOuCJwKq5HqgpnR2bxcaomiAtj5AbfKmoJF3uGa4YItqKhis2GGvTpgFI/+4Iyl
	83xRcGIIEt4MAyCZn7upFjoHzAMxf5utorKa6mWCqym7yZxj/ueXQHq5CER2pdjE/xVCV1
	3J06oR94mVRw9/x5qkHS9gDIwrGqUvNG82riHVxe7h0x2CczAYBfzOkawdkqOw==
From: Herve Codina <herve.codina@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] lib/bitmap: Fix bitmap_scatter() and bitmap_gather() kernel doc
Date: Tue, 12 Mar 2024 09:54:03 +0100
Message-ID: <20240312085403.224248-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The make htmldoc command failed with the following error
  ... include/linux/bitmap.h:524: ERROR: Unexpected indentation.
  ... include/linux/bitmap.h:524: CRITICAL: Unexpected section title or transition.

Move the visual representation to a literal block.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---

This patch fixes de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
available in net-next and linux-next

 include/linux/bitmap.h | 44 ++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 049ba20911c5..ac87c8292f08 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -507,17 +507,18 @@ static inline void bitmap_replace(unsigned long *dst,
  *
  * (Bits 0, 1, 2, 3, 4, 5 are copied to the bits 0, 1, 4, 8, 9, 12)
  *
- * A more 'visual' description of the operation:
- * src:  0000000001011010
- *                 ||||||
- *          +------+|||||
- *          |  +----+||||
- *          |  |+----+|||
- *          |  ||   +-+||
- *          |  ||   |  ||
- * mask: ...v..vv...v..vv
- *       ...0..11...0..10
- * dst:  0000001100000010
+ * A more 'visual' description of the operation::
+ *
+ *	src:  0000000001011010
+ *	                ||||||
+ *	         +------+|||||
+ *	         |  +----+||||
+ *	         |  |+----+|||
+ *	         |  ||   +-+||
+ *	         |  ||   |  ||
+ *	mask: ...v..vv...v..vv
+ *	      ...0..11...0..10
+ *	dst:  0000001100000010
  *
  * A relationship exists between bitmap_scatter() and bitmap_gather().
  * bitmap_gather() can be seen as the 'reverse' bitmap_scatter() operation.
@@ -553,16 +554,17 @@ static inline void bitmap_scatter(unsigned long *dst, const unsigned long *src,
  *
  * (Bits 0, 1, 4, 8, 9, 12 are copied to the bits 0, 1, 2, 3, 4, 5)
  *
- * A more 'visual' description of the operation:
- * mask: ...v..vv...v..vv
- * src:  0000001100000010
- *          ^  ^^   ^   0
- *          |  ||   |  10
- *          |  ||   > 010
- *          |  |+--> 1010
- *          |  +--> 11010
- *          +----> 011010
- * dst:  0000000000011010
+ * A more 'visual' description of the operation::
+ *
+ *	mask: ...v..vv...v..vv
+ *	src:  0000001100000010
+ *	         ^  ^^   ^   0
+ *	         |  ||   |  10
+ *	         |  ||   > 010
+ *	         |  |+--> 1010
+ *	         |  +--> 11010
+ *	         +----> 011010
+ *	dst:  0000000000011010
  *
  * A relationship exists between bitmap_gather() and bitmap_scatter(). See
  * bitmap_scatter() for the bitmap scatter detailed operations.
-- 
2.44.0


