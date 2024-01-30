Return-Path: <linux-kernel+bounces-44157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC140841E12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EA81C25327
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A563259B68;
	Tue, 30 Jan 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NWQvtLk5"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005454670;
	Tue, 30 Jan 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604058; cv=none; b=ls9BITbKU8lkKVlhgW1g0AEoJYu2WrC/o/Ygu0NGXfM+ggabWQLMPa8i0tTEnzjA44QDRnEDxrC1tmcmXiH7g6saTp4XpWwOC9o7V+OHo2g042chj4PmuVfhT1/m1flqHaI01/wv/P32x6QQnytQO81gdPPiVBHqpDHEx94xdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604058; c=relaxed/simple;
	bh=o3GCbQ0HDcwCxhsdiMaIWoSqnIsvjGA8R22JTLCknSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RavkWNWKRh8hoGLv+8frQJ64IT3h/Osdc3kjZuSPJKJw1HtV0yN6T7tBxdV2njAg0yfduBwxz2pb9N2dF5bnUNazq0WvbuiehyEKeVpPWkzSBnTvNFMD0p9SncTuRhiovc5JqipKmq3zWg1thmad02YhAzpcqPGta63oYOBxr+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NWQvtLk5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 86B506000F;
	Tue, 30 Jan 2024 08:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706604049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dO1lu7mTt2Z5I540dnIACd6uZE/pOpssk6saKJ+PaEA=;
	b=NWQvtLk5OLX0vZs2YGAsz/nl2hB9WFKgCSA7hI1iBwPdy8lPm7XqaoD84J6jU6/HQTeylc
	+kjLGWSyFa2P7EDj8wMACofF8gGJlZAsxCb6AQ6Il0GyHXFHr5YM29KhYnqw6nKK6Fbhjp
	20A3RHvPqs0veEfkFaJPEJWfprIXn5YPLGv+30jgaL2vd94q52TvpspdkdRzPh0ZqZre86
	ldkbn/s6mEDdGrrfcQ2ZZtcqTLL5icJSly74qt7dF2PC9AgPplOiOtyrfN//tKCIAiKj95
	HSdw1CYPo2QNDbFf7ZdNZYWRe8tNMyo9QsHxQgItt/9wn80Y9aYt7za1nxmr6A==
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 4/6] bitmap: Introduce bitmap_off()
Date: Tue, 30 Jan 2024 09:40:19 +0100
Message-ID: <20240130084035.115086-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130084035.115086-1-herve.codina@bootlin.com>
References: <20240130084035.115086-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The bitmap_onto() function translates one bitmap relative to another but
no function are present to perform the reverse translation.

Introduce bitmap_off() to fill this hole.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/bitmap.h |  3 +++
 lib/bitmap.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99451431e4d6..5ecfcbbc91f4 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -65,6 +65,7 @@ struct device;
  *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
  *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
  *  bitmap_onto(dst, orig, relmap, nbits)       *dst = orig relative to relmap
+ *  bitmap_off(dst, orig, relmap, nbits)        *dst = bitmap_onto() reverse operation
  *  bitmap_fold(dst, orig, sz, nbits)           dst bits = orig bits mod sz
  *  bitmap_parse(buf, buflen, dst, nbits)       Parse bitmap dst from kernel buf
  *  bitmap_parse_user(ubuf, ulen, dst, nbits)   Parse bitmap dst from user buf
@@ -208,6 +209,8 @@ int bitmap_bitremap(int oldbit,
 		const unsigned long *old, const unsigned long *new, int bits);
 void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		const unsigned long *relmap, unsigned int bits);
+void bitmap_off(unsigned long *dst, const unsigned long *orig,
+		const unsigned long *relmap, unsigned int bits);
 void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 		unsigned int sz, unsigned int nbits);
 
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 2feccb5047dc..71343967335e 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -682,6 +682,48 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 }
 EXPORT_SYMBOL(bitmap_onto);
 
+/**
+ * bitmap_off - revert operation done by bitmap_onto()
+ *     @dst: resulting translated bitmap
+ *     @orig: original untranslated bitmap
+ *     @relmap: bitmap relative to which translated
+ *     @bits: number of bits in each of these bitmaps
+ *
+ * Suppose onto computed using bitmap_onto(onto, src, relmap, n)
+ * The operation bitmap_off(result, onto, relmap, n) leads to a
+ * result equal or equivalent to src.
+ *
+ * The result can be 'equivalent' because bitmap_onto() and
+ * bitmap_off() are not bijective.
+ * The result and src values are equivalent in that sense that a
+ * call to bitmap_onto(onto, src, relmap, n) and a call to
+ * bitmap_onto(onto, result, relmap, n) will lead to the same onto
+ * value.
+ *
+ * If either of @orig or @relmap is empty (no set bits), then @dst
+ * will be returned empty.
+ *
+ * All bits in @dst not set by the above rule are cleared.
+ */
+void bitmap_off(unsigned long *dst, const unsigned long *orig,
+		const unsigned long *relmap, unsigned int bits)
+{
+	unsigned int n, m;      /* same meaning as in above comment */
+
+	if (dst == orig)        /* following doesn't handle inplace mappings */
+		return;
+	bitmap_zero(dst, bits);
+
+	m = 0;
+	for_each_set_bit(n, relmap, bits) {
+		/* m == bitmap_pos_to_ord(relmap, n, bits) */
+		if (test_bit(n, orig))
+			set_bit(m, dst);
+		m++;
+	}
+}
+EXPORT_SYMBOL(bitmap_off);
+
 #ifdef CONFIG_NUMA
 /**
  * bitmap_fold - fold larger bitmap into smaller, modulo specified size
-- 
2.43.0


