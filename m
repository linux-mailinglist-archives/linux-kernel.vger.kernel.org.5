Return-Path: <linux-kernel+bounces-20995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B4B82883F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E42E1C23DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2794C3B19C;
	Tue,  9 Jan 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H1I0YeOE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2323A8E0;
	Tue,  9 Jan 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tjpzRGznwK55I7Q2n7VmfSXQNhK2++G4Xwmpa8nx6sg=; b=H1I0YeOEf67h7TTv7M7ugEzK7n
	6P74J41Y4EwelsITPZRidtA8FiyzA45p3bNNFgAQLnCfIW63g9UrIxOiVt2dMZokstSZO4RiI4Z/u
	UD+6DBLOkbzB/s2/cc5/kDTluKrmHc/mZV3+uTyR0rzXtLUEO4FfHHRbYHk6fTmByOhEEI4iseZQs
	3IZfD+gFQ9rGuhqHj1LL7oFXM5Mqip9JYAKDQfrt8x6+qs79wV8iA1Iu/ahmhowRWWc4wmN4EfCf8
	zTBIxW08LjWoOj7dFKXwCy4lNfB9glwCBlhCv1jGZtviKXlLSo7f1csvw0MCT1lcYUr6x+oF2hdJF
	jJCikf9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNDB1-009xre-DN; Tue, 09 Jan 2024 14:33:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] doc: Split buffer.rst out of api-summary.rst
Date: Tue,  9 Jan 2024 14:33:57 +0000
Message-Id: <20240109143357.2375046-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240109143357.2375046-1-willy@infradead.org>
References: <20240109143357.2375046-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffer heads are no longer a generic filesystem API but an optional
filesystem support library.  Make the documentation structure reflect
that, and include the fine documentation kept in buffer_head.h.
We could give a better overview of what buffer heads are all about,
but my enthusiasm for documenting it is limited.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/api-summary.rst | 3 ---
 Documentation/filesystems/index.rst       | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/filesystems/api-summary.rst b/Documentation/filesystems/api-summary.rst
index 98db2ea5fa12..cc5cc7f3fbd8 100644
--- a/Documentation/filesystems/api-summary.rst
+++ b/Documentation/filesystems/api-summary.rst
@@ -56,9 +56,6 @@ Other Functions
 .. kernel-doc:: fs/namei.c
    :export:
 
-.. kernel-doc:: fs/buffer.c
-   :export:
-
 .. kernel-doc:: block/bio.c
    :export:
 
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index e18bc5ae3b35..5fc9b19b8d8e 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -50,6 +50,7 @@ filesystem implementations.
 .. toctree::
    :maxdepth: 2
 
+   buffer
    journalling
    fscrypt
    fsverity
-- 
2.43.0


