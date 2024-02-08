Return-Path: <linux-kernel+bounces-58518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C22884E777
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4061C21676
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C48562A;
	Thu,  8 Feb 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="oWNaOguX"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC8983CD5;
	Thu,  8 Feb 2024 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416039; cv=none; b=CryG6i/1DLp67AidZSjE+BnngQeby0c7J7viqXgFTW9zhHfuhKeDgTe6FIXsaexT+L+lxgdUIllqgVbbSTlNwx3TG9ami8wfrf689kcgD0QDFJ6NpIX8o2I6slEw7EBxASXA2QpVU3l2d6mvc8t3b+Cs9zyijKi3QHoo1SBxATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416039; c=relaxed/simple;
	bh=ysgMn0ZRWUYT/Hge0FlA9uwr6TJWomFtNilVmXv2T/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cZo5n1dPBeqOCmJ1V3uvXbM5Ps660KtcfT9IyNdphaP3kKI5RPS8tdsWu1KAGAdhBcWBCrHSac+OpZcn6tns/9fyg4HBHWtH+Xb9ZcI69EubyG/5kC37QKYc9JtpDtVt6nafJl7X8kL98sKGSaWGehsrDSC6VoUqImgeZuOXMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=oWNaOguX; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707416015; x=1708020815; i=erick.archer@gmx.com;
	bh=ysgMn0ZRWUYT/Hge0FlA9uwr6TJWomFtNilVmXv2T/w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=oWNaOguXBS+OEugqNs5oiSX4ERBLtaNWdXGAmpmbvCulbsGo2Vly8ueemgf/tuFm
	 ArLtR0+CyRhfuf17Io0mpxoI6Gr4sKh3eIrbd1hMx7+dUfudz4FLpk5mmdh1AHc3/
	 J7HKmXQvJ0WII92bM9Braws0HJBi8mDF0phAC0goZiSGRa/4rNI/ffTt04oxDQp/g
	 YWu9HbWSoYuKuAd6TIGS45tGwv17HOFB4tN/Kdac7/jFQUPXf76Q+5I3oC2F0gB8D
	 jwb8RjPYxqKVcxZ69zzUZbjQlMk9OZSUf+MA5tGvl5lougAf5RRBodg8USxxWLYn+
	 nncympLAZejWAvsTUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M7b6l-1rdLQw2iQn-0081qr; Thu, 08 Feb 2024 19:13:35 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] drm/i915: Add flex arrays to struct i915_syncmap
Date: Thu,  8 Feb 2024 19:13:18 +0100
Message-Id: <20240208181318.4259-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pfHdlpNnJigTy8aCxrOPtJDMrJKf0ixBybkrQ5Vv5mXAzAOCOce
 kE/56VgSJ24fEWyckAkZBiWw31er/4+LJmrLfiKbxBq0xz8Hfrzpel9d0ON3gwuUpxPyHbE
 rdS3TQvdJZV2shpo3dlarUHJyNmnOMWYszl8ojPossp4pbrgBMG/j9ZA3TOBvkYMcVXSjOq
 g75Q7z0uPqbDs2hAyGnmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ppjXGd503ms=;sjS14y9jdFkBR6vOViIScjo85yN
 KfTKdz2Fv9Nbq/W5Jqvf4xxfnQ1w2GCFByHAxdDUY2RP7202k2ZAWvlSM0urrJigc9CxXV/JG
 fwSSv9Au+xgAUGBhSRXmXrGNBw8Mpxjcx2Cxu7ylwNVU5BryCPLJrVN1Kqr/X8LQciF4Z98SU
 u88Pc8e3boUUlXoMAj7mDdqiUG7huRaG78K0QJj9+F/Dl+lblSDEpN22wsSlwHg1zrNgdWZy8
 /ArZ65G8ejLxWZylem8Z3we7BgCej3GduFX1U+GV41Mr00zND7V7nXX6Ka3P8uf+XK+kdTYAe
 9zQ8hT9cZA+dkXBzt9xVlH+YIbD4AVS5yYU5IaIyW4l9aavPNbB5UbUYXi5qzST8PlXIO5z10
 TPrJi6LF3FumJcdFR7qWBiXWqGCZj+pvj2C9rbh07K5CVN/isEh4GKm+EkV78vuPIi8vWx0fm
 mTH59jiovQSkRvF4G0a/OVh8s0h5GrRQU0hAkfdEByT9MwE4ECYbRukwShgl0krjkngxES3X1
 ph/FZa0bB7UifadOOCFDrdIr/Om8JNwTNjAPFHHCaQK5x/w8HukWSkvmHmqzC9pQ13wCV459x
 lNuIoZ1rjwixYJlqDV6UUL5kIy6td/X87DNG9qUvbTyMEIU+2jzCrmHMcDfLDticHuHkHgd4j
 hAHgq9zmV+EtfmhjBu9DZAuUCYzc58MiDGmXFhndtGgPfIFi3/ESTTct2RyTjOmOAUE3Xn0WX
 HByY3J1zQo5Kiwqs36sScHeLnEIn8r1m9RBOFbbUyd6imT6SCGyF5Mj01+RhT6tW0DSWQXmoJ
 Yo+WE7vkwJAAKwVZx6Sh83FtKOewKbNxiCF4OQ2vcaKJ0=

The "struct i915_syncmap" uses a dynamically sized set of trailing
elements. It can use an "u32" array or a "struct i915_syncmap *"
array.

So, use the preferred way in the kernel declaring flexible arrays [1].
Because there are two possibilities for the trailing arrays, it is
necessary to declare a union and use the DECLARE_FLEX_ARRAY macro.

The comment can be removed as the union is now clear enough.

Also, avoid the open-coded arithmetic in the memory allocator functions
[2] using the "struct_size" macro.

Moreover, refactor the "__sync_seqno" and "__sync_child" functions due
to now it is possible to use the union members added to the structure.
This way, it is also possible to avoid the open-coded arithmetic in
pointers.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-le=
ngth-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/gpu/drm/i915/i915_syncmap.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_syncmap.c b/drivers/gpu/drm/i915/i9=
15_syncmap.c
index 60404dbb2e9f..df6437c37373 100644
=2D-- a/drivers/gpu/drm/i915/i915_syncmap.c
+++ b/drivers/gpu/drm/i915/i915_syncmap.c
@@ -75,13 +75,10 @@ struct i915_syncmap {
 	unsigned int height;
 	unsigned int bitmap;
 	struct i915_syncmap *parent;
-	/*
-	 * Following this header is an array of either seqno or child pointers:
-	 * union {
-	 *	u32 seqno[KSYNCMAP];
-	 *	struct i915_syncmap *child[KSYNCMAP];
-	 * };
-	 */
+	union {
+		DECLARE_FLEX_ARRAY(u32, seqno);
+		DECLARE_FLEX_ARRAY(struct i915_syncmap *, child);
+	};
 };

 /**
@@ -99,13 +96,13 @@ void i915_syncmap_init(struct i915_syncmap **root)
 static inline u32 *__sync_seqno(struct i915_syncmap *p)
 {
 	GEM_BUG_ON(p->height);
-	return (u32 *)(p + 1);
+	return p->seqno;
 }

 static inline struct i915_syncmap **__sync_child(struct i915_syncmap *p)
 {
 	GEM_BUG_ON(!p->height);
-	return (struct i915_syncmap **)(p + 1);
+	return p->child;
 }

 static inline unsigned int
@@ -200,7 +197,7 @@ __sync_alloc_leaf(struct i915_syncmap *parent, u64 id)
 {
 	struct i915_syncmap *p;

-	p =3D kmalloc(sizeof(*p) + KSYNCMAP * sizeof(u32), GFP_KERNEL);
+	p =3D kmalloc(struct_size(p, seqno, KSYNCMAP), GFP_KERNEL);
 	if (unlikely(!p))
 		return NULL;

@@ -282,7 +279,7 @@ static noinline int __sync_set(struct i915_syncmap **r=
oot, u64 id, u32 seqno)
 			unsigned int above;

 			/* Insert a join above the current layer */
-			next =3D kzalloc(sizeof(*next) + KSYNCMAP * sizeof(next),
+			next =3D kzalloc(struct_size(next, child, KSYNCMAP),
 				       GFP_KERNEL);
 			if (unlikely(!next))
 				return -ENOMEM;
=2D-
2.25.1


