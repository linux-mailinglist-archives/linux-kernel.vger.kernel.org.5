Return-Path: <linux-kernel+bounces-162946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CAF8B629F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3A91F22D04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050613C9C8;
	Mon, 29 Apr 2024 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOaabP7t"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1C13C802;
	Mon, 29 Apr 2024 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419575; cv=none; b=mCAzswi5xb10K11YUy+Uv1MuHMLcPv4aQm46jQZWwynSf8SwQkUtfGyEqXPxfd9FNguQ5i0+MV/BHPpow0LHUbtk5muotj3S5nkXnAL7xUaBPht9FEwJiRX4B4+FfQWjAs8d2y6QLdTk2sDkYpF5/2RrwXKEI132JCdw9gvkHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419575; c=relaxed/simple;
	bh=5WpZu/r79l+78bbnFmQqDFjB9RGGvzz/imN1yr7Rf/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccM7P0f2i9hBQpRZytPSbPdPTpXBkPFnmrAFJ0IpFeFFtxg5pryNsnIoj7+jwo5YQoKqGmI9NAB5g+1iE/A+VbYfHPFLHaav0fMu30ttgZAE+ib+uHp5359hZ8hK3VJWGfITcCWLAz1EvnVuXiO43z8G83uARHmUTAYzqzH8oKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOaabP7t; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7da09662332so160424439f.0;
        Mon, 29 Apr 2024 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419573; x=1715024373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXI+MXWRKKGIldf/Embfy128LRyyxhcJagthHMuW3ts=;
        b=gOaabP7tGLD8uBt0TqjWvg5YxVGTBUI0EVE/AjMKaMPa20FoseHQFCnrcjlh4OE8ht
         qp9nfpsR0JIbYMBTgNhpGscQB7Mjbg6j/yFJd+0VGTQF1FoFeLQjecIBKQQNugdn5O6K
         6RMlFgJzSEMOv7auRo46wjsTZXFzfcXP5s96kN4eofJiK3zb01fOSn68OZovzn7lTIQ/
         f5mQmYUjGhJfauKSGRNs/tLsQFgOOmwdvNVen1+JGJFSUzecyQhIEleYbvPMRSF17kIy
         H55qEfdOf5UP5uqvFZgL2KpsvDnzB2BjpbZKdC7ATDxcK0OEtMbuLFEdlkLd/2ci1UA5
         SQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419573; x=1715024373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXI+MXWRKKGIldf/Embfy128LRyyxhcJagthHMuW3ts=;
        b=Fa37GKuP0I3lABgCbfOw3kARtmbwez0bdBHlav8S0/7gGTnvMmAY6Ewnvh0qDP9Bhh
         WKZOBnzpPy+7+PbLZVojLwqWGHcxkSqgMbHcBcVbMM4XAI3xVP0V0Fx5iBr0FKsEizy3
         pjA9BS6qLfAAxE7ux4Y+s2W+xetaC+cU0KIVQRqbX+zifkrBKOEEG0puWl5+Dg7i3jVJ
         PjVAFEEYUKhaXvdR8z8ADymSrgZKHzoFBPkY3o3YusSpsroBzl86ki6gsA484+PfxmuB
         aJ7CDHWJ5ssX8+KyZo2q5vu2KVp6z89TUrZ0iNSOdDwVtzmQdgEDNkGF272DgB9j0ubK
         aIpg==
X-Forwarded-Encrypted: i=1; AJvYcCX8aCIHUiiwBFp5Bk1YSfD2O7XxGI/7X5LhoiN575RKLmWiusPgiiGqlvXqPC5+Ab45tZ6KNIo0y4z2yxSRBW267RQbMIS304B80nTURrJstJveBrxYySF0zdXcsPoj09SCudw+F+gA
X-Gm-Message-State: AOJu0Yx2gNUwRE8lPNgrm5azM2SU4NXgKkqwp1xf1wnVf34Ql27O8X+J
	WrEdlv80QCdoTH8Zg+BYlOqyFQ/YNzdbbGv6ncqZqZhnPUyH8JUV
X-Google-Smtp-Source: AGHT+IGWpfjvznK6WhTujjscD4YN6L0AQxbNzmm1AE5SspjD0rno7TIevntaxjo8L0b9AeQnuOA3fw==
X-Received: by 2002:a6b:db05:0:b0:7da:1a22:e832 with SMTP id t5-20020a6bdb05000000b007da1a22e832mr584954ioc.0.1714419573239;
        Mon, 29 Apr 2024 12:39:33 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 25/35] docs/dyndbg: explain new delimiters: comma, percent
Date: Mon, 29 Apr 2024 13:39:11 -0600
Message-ID: <20240429193921.66648-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193921.66648-1-jim.cromie@gmail.com>
References: <20240429193921.66648-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mention of comma and percent delimiters into the respective
paragraphs describing their equivalents: space and newline.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst        | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 742eb4230c6e..7b570f29ae98 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -73,16 +73,18 @@ Command Language Reference
 ==========================
 
 At the basic lexical level, a command is a sequence of words separated
-by spaces or tabs.  So these are all equivalent::
+by spaces, tabs, or commas.  So these are all equivalent::
 
   :#> ddcmd file svcsock.c line 1603 +p
   :#> ddcmd "file svcsock.c line 1603 +p"
   :#> ddcmd '  file   svcsock.c     line  1603 +p  '
+  :#> ddcmd file,svcsock.c,line,1603,+p
 
-Command submissions are bounded by a write() system call.
-Multiple commands can be written together, separated by ``;`` or ``\n``::
+Command submissions are bounded by a write() system call.  Multiple
+commands can be written together, separated by ``%``, ``;`` or ``\n``::
 
-  :#> ddcmd "func pnpacpi_get_resources +p; func pnp_assign_mem +p"
+  :#> ddcmd func foo +p % func bar +p
+  :#> ddcmd func foo +p \; func bar +p
   :#> ddcmd <<"EOC"
   func pnpacpi_get_resources +p
   func pnp_assign_mem +p
@@ -104,7 +106,6 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
 A match specification is a keyword, which selects the attribute of
 the callsite to be compared, and a value to compare against.  Possible
 keywords are:::
@@ -128,7 +129,6 @@ keywords are:::
   ``line-range`` cannot contain space, e.g.
   "1-30" is valid range but "1 - 30" is not.
 
-
 The meanings of each keyword are:
 
 func
@@ -153,9 +153,11 @@ module
     The given string is compared against the module name
     of each callsite.  The module name is the string as
     seen in ``lsmod``, i.e. without the directory or the ``.ko``
-    suffix and with ``-`` changed to ``_``.  Examples::
+    suffix and with ``-`` changed to ``_``.
+
+    Examples::
 
-	module sunrpc
+	module,sunrpc	# with ',' as token separator
 	module nfsd
 	module drm*	# both drm, drm_kms_helper
 
-- 
2.44.0


