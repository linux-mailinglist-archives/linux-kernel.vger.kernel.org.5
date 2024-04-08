Return-Path: <linux-kernel+bounces-135603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A3B89C847
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE5D1C22CEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811E81422A0;
	Mon,  8 Apr 2024 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p734RBnb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF31411CA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590210; cv=none; b=tlUKw8VQozzbVGKWzGADQ8qmHouzZKbedGKY5DpUfHIplgcU6Cmr//Xr6nJh0Bid/nHnBColejmqA17uI7LrKXIjp9qTG6VqkPgqsirx42hKChRd3iCj+OmGX9a8+OQMrgpQj0dtX73MIKrIE7SiUFccS90HoUBAO4cUB51IW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590210; c=relaxed/simple;
	bh=Vpb1x8zaaYpZppjsaSUsvF+Hn0EXztb3KJga9Q7tto0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u24oh+ssUdHSgGXYuDLJY6qFMddQguvqcaaBzfPVSV+4BcaBg3YzhiczhwCKDfqEecBqHjoTs4QXIEi2hqabJrewx05TdfVfbb2txTWzFhUaaKeTtPKNrHRCAtbFgp+hsGxjQ4bXlnWYJyvVtO1WPJ7YhaA+Xl0dk0VfcWa4WnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p734RBnb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso8905234276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712590207; x=1713195007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWR8tijWyRj2FfKuG2Rt//np5l0aZNm00N8W4mX854s=;
        b=p734RBnbK1MaFKSMLkT2+JD5NOAxhqCPrgSkec62y+6c2i1is7KyDhQrh9NgbSWpHe
         Dqc+Gb4hpimi9O4MvksuV0zfkpzaHuuJSRcB8mSMvaDCJCscApbOb9dfMl7mOJBLVZ7m
         k3wizG01hS/3pejsIlb7E6qRC/m6FZD9nsSkxeJrwmrHGq8dENLDLShufCzC5Dy4vdyq
         m0JGUU/YvJaoL0XwQz6QwLYafNnd082KreM2naUIKFGWHPf/fsmLCSbkLdB0xDKJYw4K
         70O14GhlVmcen+kkQL2q2alv0KRuf0d9aK7xwuI0JrRq48t0m4iNOxrmtd5jKSqAGqb6
         nypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590207; x=1713195007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWR8tijWyRj2FfKuG2Rt//np5l0aZNm00N8W4mX854s=;
        b=K+M6WT1zALE6efGd5L0tB9s3w+QuGzjoL/rWk52BXNmFJVX0Mwbai4YEyRH8Ve/PK/
         6VEPliUBD8J2/c1O6+FtLUTcBXrPxxYBiKTI+E0bX9fte4ZiGfDbC4HmCUM3yv7mXvG2
         9sZDhHNZdvDSjDmJ1Eo3xJ2rDk/FuCgRK2uimjHS43vxYa6QWGbjQ7KXVtjZHTkqVdLF
         2sx8u5LaEsJJ6HgR5lfqiet+d8tSKpyNZUync5PQxj8vayEglbYsEJOUCHOIXIIme7S/
         FQLOl213bwakPl9Ad8X0srVNkYnooUWz9IJ2k12dhUuaFzdn6354mLRdzSigukiGk5Db
         /rIg==
X-Forwarded-Encrypted: i=1; AJvYcCVq28DbcytbyOKLmsnTJ1t+m6hgwdIJoVlf6lFMDIsGU9zuqp1UVWiANfm5yEQT5IrKd5VgVZCHMEOEUl0xUQN7k6jxeKWKvQpTHAvx
X-Gm-Message-State: AOJu0YxnNQirKaDDjjxrlSeF7AUZB8YQbnAip3TAgYNcvom+WdCW9/2M
	SKhuX4a6bPNAlvjBNpmsxM4vN68T55EXQtoqSZ0IwXv7zpLQnLI+4RLsZlWC34P9wDwNNeY9W+G
	vxfHWdabTUF6BHDtJeYcLDA==
X-Google-Smtp-Source: AGHT+IE6FoKwTKXpzfONClpxQYuW9N9Gxa8U8wuX//GM6Bov75pxNsHsLhjCO7DRpMzB4WraVxS0nAPMPubHq4MKZg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:ca23:d62d:de32:7c93])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:72e:b0:dc6:e884:2342 with
 SMTP id l14-20020a056902072e00b00dc6e8842342mr3475222ybt.5.1712590207525;
 Mon, 08 Apr 2024 08:30:07 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:29:57 -0700
In-Reply-To: <20240408153000.2152844-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408153000.2152844-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408153000.2152844-3-almasrymina@google.com>
Subject: [PATCH net-next v5 2/3] net: mirror skb frag ref/unref helpers
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Refactor some of the skb frag ref/unref helpers for improved clarity.

Implement napi_pp_get_page() to be the mirror counterpart of
napi_pp_put_page().

Implement skb_page_ref() to be the mirror of skb_page_unref().

Improve __skb_frag_ref() to become a mirror counterpart of
__skb_frag_unref(). Previously unref could handle pp & non-pp pages,
while the ref could only handle non-pp pages. Now both the ref & unref
helpers can correctly handle both pp & non-pp pages.

Now that __skb_frag_ref() can handle both pp & non-pp pages, remove
skb_pp_frag_ref(), and use __skb_frag_ref() instead.  This lets us
remove pp specific handling from skb_try_coalesce.

Additionally, since __skb_frag_ref() can now handle both pp & non-pp
pages, a latent issue in skb_shift() should now be fixed. Previously
this function would do a non-pp ref & pp unref on potential pp frags
(fragfrom). After this patch, skb_shift() should correctly do a pp
ref/unref on pp frags.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

---

v5:
- Made changes to inline napi_pp_get_page() (Eric). I had to move
  page_pool_ref_page() from include/net/page_pool/helpers.h to
  include/linux/skbuff.h, so I don't add more includes to skbuff.h,
  which slows down the incremental builds.

v4:
- pass skb->pp_recycle instead of 'false' in __skb_frag_ref in
  chcr_ktls.c & cassini.c.
- Add some details on the changes to skb_shift() in this commit in the
  commit message.

v3:
- Fix build errors reported by patchwork.
- Fix drivers/net/veth.c & tls_device_fallback.c callsite I missed to update.
- Fix page_pool_ref_page(head_page) -> page_pool_ref_page(page)

---
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  2 +-
 drivers/net/ethernet/sun/cassini.c            |  4 +-
 drivers/net/veth.c                            |  2 +-
 include/linux/skbuff.h                        | 44 ++++++++++++++++--
 include/net/page_pool/helpers.h               |  5 --
 net/core/skbuff.c                             | 46 ++-----------------
 net/tls/tls_device_fallback.c                 |  2 +-
 7 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index 6482728794dd..d7e8deafddf1 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -1658,7 +1658,7 @@ static void chcr_ktls_copy_record_in_skb(struct sk_buff *nskb,
 	for (i = 0; i < record->num_frags; i++) {
 		skb_shinfo(nskb)->frags[i] = record->frags[i];
 		/* increase the frag ref count */
-		__skb_frag_ref(&skb_shinfo(nskb)->frags[i]);
+		__skb_frag_ref(&skb_shinfo(nskb)->frags[i], nskb->pp_recycle);
 	}
 
 	skb_shinfo(nskb)->nr_frags = record->num_frags;
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index bfb903506367..31878256feee 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -1999,7 +1999,7 @@ static int cas_rx_process_pkt(struct cas *cp, struct cas_rx_comp *rxc,
 		skb->len      += hlen - swivel;
 
 		skb_frag_fill_page_desc(frag, page->buffer, off, hlen - swivel);
-		__skb_frag_ref(frag);
+		__skb_frag_ref(frag, skb->pp_recycle);
 
 		/* any more data? */
 		if ((words[0] & RX_COMP1_SPLIT_PKT) && ((dlen -= hlen) > 0)) {
@@ -2023,7 +2023,7 @@ static int cas_rx_process_pkt(struct cas *cp, struct cas_rx_comp *rxc,
 			frag++;
 
 			skb_frag_fill_page_desc(frag, page->buffer, 0, hlen);
-			__skb_frag_ref(frag);
+			__skb_frag_ref(frag, skb->pp_recycle);
 			RX_USED_ADD(page, hlen + cp->crc_size);
 		}
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index bcdfbf61eb66..6160a3e8d341 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -716,7 +716,7 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 		return;
 
 	for (i = 0; i < sinfo->nr_frags; i++)
-		__skb_frag_ref(&sinfo->frags[i]);
+		__skb_frag_ref(&sinfo->frags[i], false);
 }
 
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c0ff85bb087a..2e6a77c398e6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3492,15 +3492,51 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
 	return netmem_to_page(frag->netmem);
 }
 
+#ifdef CONFIG_PAGE_POOL
+static inline bool is_pp_page(struct page *page)
+{
+	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
+}
+
+/* page_pool_unref_page() lives in net/page_pool/helpers.h */
+static inline void page_pool_ref_page(struct page *page)
+{
+	atomic_long_inc(&page->pp_ref_count);
+}
+
+static inline bool napi_pp_get_page(struct page *page)
+{
+	page = compound_head(page);
+
+	if (!is_pp_page(page))
+		return false;
+
+	page_pool_ref_page(page);
+	return true;
+}
+#endif
+
+static inline void skb_page_ref(struct page *page, bool recycle)
+{
+#ifdef CONFIG_PAGE_POOL
+	if (recycle && napi_pp_get_page(page))
+		return;
+#endif
+	get_page(page);
+}
+
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
+ * @recycle: skb->pp_recycle param of the parent skb. False if no parent skb.
  *
- * Takes an additional reference on the paged fragment @frag.
+ * Takes an additional reference on the paged fragment @frag. Obtains the
+ * correct reference count depending on whether skb->pp_recycle is set and
+ * whether the frag is a page pool frag.
  */
-static inline void __skb_frag_ref(skb_frag_t *frag)
+static inline void __skb_frag_ref(skb_frag_t *frag, bool recycle)
 {
-	get_page(skb_frag_page(frag));
+	skb_page_ref(skb_frag_page(frag), recycle);
 }
 
 /**
@@ -3512,7 +3548,7 @@ static inline void __skb_frag_ref(skb_frag_t *frag)
  */
 static inline void skb_frag_ref(struct sk_buff *skb, int f)
 {
-	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
+	__skb_frag_ref(&skb_shinfo(skb)->frags[f], skb->pp_recycle);
 }
 
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 1d397c1a0043..ead2c0d24b2c 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -277,11 +277,6 @@ static inline long page_pool_unref_page(struct page *page, long nr)
 	return ret;
 }
 
-static inline void page_pool_ref_page(struct page *page)
-{
-	atomic_long_inc(&page->pp_ref_count);
-}
-
 static inline bool page_pool_is_last_ref(struct page *page)
 {
 	/* If page_pool_unref_page() returns 0, we were the last user */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 21cd01641f4c..928c615b0fd8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -906,11 +906,6 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
-static bool is_pp_page(struct page *page)
-{
-	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
-}
-
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -1032,37 +1027,6 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data)
 	return napi_pp_put_page(virt_to_page(data));
 }
 
-/**
- * skb_pp_frag_ref() - Increase fragment references of a page pool aware skb
- * @skb:	page pool aware skb
- *
- * Increase the fragment reference count (pp_ref_count) of a skb. This is
- * intended to gain fragment references only for page pool aware skbs,
- * i.e. when skb->pp_recycle is true, and not for fragments in a
- * non-pp-recycling skb. It has a fallback to increase references on normal
- * pages, as page pool aware skbs may also have normal page fragments.
- */
-static int skb_pp_frag_ref(struct sk_buff *skb)
-{
-	struct skb_shared_info *shinfo;
-	struct page *head_page;
-	int i;
-
-	if (!skb->pp_recycle)
-		return -EINVAL;
-
-	shinfo = skb_shinfo(skb);
-
-	for (i = 0; i < shinfo->nr_frags; i++) {
-		head_page = compound_head(skb_frag_page(&shinfo->frags[i]));
-		if (likely(is_pp_page(head_page)))
-			page_pool_ref_page(head_page);
-		else
-			page_ref_inc(head_page);
-	}
-	return 0;
-}
-
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
 	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
@@ -4175,7 +4139,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 			to++;
 
 		} else {
-			__skb_frag_ref(fragfrom);
+			__skb_frag_ref(fragfrom, skb->pp_recycle);
 			skb_frag_page_copy(fragto, fragfrom);
 			skb_frag_off_copy(fragto, fragfrom);
 			skb_frag_size_set(fragto, todo);
@@ -4825,7 +4789,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			}
 
 			*nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;
-			__skb_frag_ref(nskb_frag);
+			__skb_frag_ref(nskb_frag, nskb->pp_recycle);
 			size = skb_frag_size(nskb_frag);
 
 			if (pos < offset) {
@@ -5956,10 +5920,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	if (skb_pp_frag_ref(from)) {
-		for (i = 0; i < from_shinfo->nr_frags; i++)
-			__skb_frag_ref(&from_shinfo->frags[i]);
-	}
+	for (i = 0; i < from_shinfo->nr_frags; i++)
+		__skb_frag_ref(&from_shinfo->frags[i], from->pp_recycle);
 
 	to->truesize += delta;
 	to->len += len;
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 4e7228f275fa..d4000b4a1f7d 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -277,7 +277,7 @@ static int fill_sg_in(struct scatterlist *sg_in,
 	for (i = 0; remaining > 0; i++) {
 		skb_frag_t *frag = &record->frags[i];
 
-		__skb_frag_ref(frag);
+		__skb_frag_ref(frag, false);
 		sg_set_page(sg_in + i, skb_frag_page(frag),
 			    skb_frag_size(frag), skb_frag_off(frag));
 
-- 
2.44.0.478.gd926399ef9-goog


