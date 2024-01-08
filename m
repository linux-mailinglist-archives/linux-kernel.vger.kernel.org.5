Return-Path: <linux-kernel+bounces-20085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2700827919
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C3A1C2305F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9FF5579C;
	Mon,  8 Jan 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="f+mLiayT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567535577B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 733F5240108
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:22:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1704745375; bh=QdXdfx57ZJPNwppUDVSfjTZfO7rtid5cQ8dOF8J1p8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=f+mLiayTkIkdCQsqNYeLNTSKdh8rsjRSg6AeDgKXVYiI1APjpptqojbY+foZ0Slb2
	 nwx3XVXY4HOc9dPKRQwSMmWDUlW02MLw6DtSQLdI31ZP1ajx+Nl7vwPlqnFceTsRLS
	 MkHp91rftJvk7PK9P0KZVJOoqd3E1/uHfVFHYEvfu0Hc2bbmRsmY5vwAuxj/9NHmzF
	 hvxAeshXsxW0hJ4pVxkl3BvjTb4GYfWGSh9tBHdVHNyqBJy3Ls3tv3Lrp80TpkHZ3N
	 P2wV20OUPUzW5bjd3FiU2fuaMSgWFE4RwWS3wCnhLeUcRdD1jPEcEyNrkNZZKdh5IG
	 C7zflfrmmtZMg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4T858k6p49z6tyS;
	Mon,  8 Jan 2024 21:22:46 +0100 (CET)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Yueh-Shun Li <shamrocklee@posteo.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hu Haowen <src.res.211@gmail.com>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] coding-style: recommend split headers instead of kernel.h
Date: Mon,  8 Jan 2024 20:22:08 +0000
Message-ID: <20240108202217.191839-1-shamrocklee@posteo.net>
In-Reply-To: <20240108201851.191604-1-shamrocklee@posteo.net>
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org> <20240108201851.191604-1-shamrocklee@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In section "18) Don't re-invent the kernel macros" in "Linux kernel
coding style":

Recommend reusing macros from headers inside include/linux, instead of
the obsolete include/linux/kernel.h

Change wording

- "The header file contains macros" -> "the header files provide macros"
  Some macros are intended to use inside the header file only, or are
  considered the implementation detail of other facilities. Developers
  are expected to determine if a macro is meant to be used outside the
  header file.

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 Documentation/process/coding-style.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 6db37a46d305..2a5c4f4c568c 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1048,27 +1048,29 @@ readable alternative if the call-sites have naked true/false constants.
 Otherwise limited use of bool in structures and arguments can improve
 readability.
 
+
 18) Don't re-invent the kernel macros
 -------------------------------------
 
-The header file include/linux/kernel.h contains a number of macros that
-you should use, rather than explicitly coding some variant of them yourself.
+The header files in the ``include/linux`` directory provide a number of macros
+that you should use, rather than explicitly coding some variant of them
+yourself.
+
 For example, if you need to calculate the length of an array, take advantage
-of the macro
+of the macro ``ARRAY_SIZE()`` from ``include/linux/array_size.h`` by
 
 .. code-block:: c
 
-	#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+	#include <linux/array_size.h>
+	ARRAY_SIZE(x) // The size of array x
 
 Similarly, if you need to calculate the size of some structure member, use
+``sizeof_field()`` from ``include/linux/stddef.h``.
 
-.. code-block:: c
-
-	#define sizeof_field(t, f) (sizeof(((t*)0)->f))
-
-There are also min() and max() macros that do strict type checking if you
-need them.  Feel free to peruse that header file to see what else is already
-defined that you shouldn't reproduce in your code.
+There are also ``min()`` and ``max()`` macros in ``include/linux/minmax.h``
+that do strict type checking if you need them. Feel free to search across and
+peruse the header files to see what else is already defined that you shouldn't
+reproduce in your code.
 
 
 19) Editor modelines and other cruft
-- 
2.42.0


