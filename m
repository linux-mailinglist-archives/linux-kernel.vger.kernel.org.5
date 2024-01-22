Return-Path: <linux-kernel+bounces-33098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B0836476
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879671F23667
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870773D388;
	Mon, 22 Jan 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PIUvxB/S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6DZJtBA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794433D0A4;
	Mon, 22 Jan 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930122; cv=none; b=VyAIKQgMrqvMyUgTLfHd7LUgbhH/jiaG5PaS4Rg6lTT9DMpJ76dZhlSW01eg1e5Yctcf1vw0T4/YKNmgPxz+sgCvqmHLLQhpgyJ4bp/fk29UXJSR8S/rIdiZ2OexnHMvM8bb8gYY3aWs7HZ/YuarE7LL0GsMF/Wv/IQJ1AXFWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930122; c=relaxed/simple;
	bh=wp8CIgOze8zh7UuHcI2z6RuWp2qimi//9CWSfp979X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLhhKe9cUTYo8saZyt6Hodrr409y3KCIWc3EUkDItLO5jzJaAP4vXM4Y+W2Gyvf5C4YiddfLY93XJdTL12DAK4uIuCdYRLzC/JUOhaky3Hw3dlElDmVQXPnKPtS8fyMjb4iCUcX+cOO9QGKYjCTqibBLhoL4Ah9HYvT7uUM8bSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PIUvxB/S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C6DZJtBA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705930119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvZno+kHevh2g23gq9x/FGgfnjZz8motFDnpxT/9ixo=;
	b=PIUvxB/SYWMC8waUFFQ7/UC2TVIVHS+BH/I6SQhE+1L70dC+9ZPyKzdZhFTB3x60g7BVCu
	1PWjW9qZq7hOmAhcvV9z8N1CvviF0sjarzJAL5i1XiZ16cucMP0CkAqNc+qMg6my4wPxle
	4ZixEKLw1ewCs7xsmJ1rKPrDZfpmW7+LAIRQPx2T5HLnD6CyzU2Z87A9uxWSLZCeF5BsYA
	wjmSyhLW7f/o7RddiCzSwOv8OtWuW7xk78UHg4bqGXlxPsNkItbg2rzpPPaqPLCNxLwO3r
	68iF+TRZHPBmfEVSiztgrvnirt+MG+MnyhmYTJDqMH3Qr9sTEqU4mDH3+2NFGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705930119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvZno+kHevh2g23gq9x/FGgfnjZz8motFDnpxT/9ixo=;
	b=C6DZJtBAz6GjBt4Hm9vjPbPUg4cy/VfW0WLxpMGcR+y85IU70jGFMPJmYXYx07ZV2x5jOM
	Q0oXOLBh739O2ZCQ==
To: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Dipen Patel <dipenp@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 2/2] Documentation: Remove deprecated kernel-doc option 'functions'
Date: Mon, 22 Jan 2024 14:28:20 +0100
Message-Id: <20240122132820.46633-3-anna-maria@linutronix.de>
In-Reply-To: <20240122132820.46633-1-anna-maria@linutronix.de>
References: <20240122132820.46633-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As there are no more users of deprecated kernel-doc option 'functions', remove
the related parts in documentation and scripts.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 Documentation/doc-guide/kernel-doc.rst | 3 ---
 Documentation/sphinx/kerneldoc.py      | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 6ad72ac6861b..74d6408abcd3 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -505,9 +505,6 @@ no-identifiers: *[ function/type ...]*
     .. kernel-doc:: lib/bitmap.c
        :no-identifiers: bitmap_parselist
 
-functions: *[ function/type ...]*
-  This is an alias of the 'identifiers' directive and deprecated.
-
 doc: *title*
   Include documentation for the ``DOC:`` paragraph identified by *title* in
   *source*. Spaces are allowed in *title*; do not quote the *title*. The *title*
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 7acf09963daa..2d57c464c76a 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -53,7 +53,6 @@ class KernelDocDirective(Directive):
         'internal': directives.unchanged,
         'identifiers': directives.unchanged,
         'no-identifiers': directives.unchanged,
-        'functions': directives.unchanged,
     }
     has_content = False
 
@@ -74,10 +73,6 @@ class KernelDocDirective(Directive):
 
         tab_width = self.options.get('tab-width', self.state.document.settings.tab_width)
 
-        # 'function' is an alias of 'identifiers'
-        if 'functions' in self.options:
-            self.options['identifiers'] = self.options.get('functions')
-
         # FIXME: make this nicer and more robust against errors
         if 'export' in self.options:
             cmd += ['-export']
-- 
2.39.2


