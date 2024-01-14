Return-Path: <linux-kernel+bounces-25391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7468982CF84
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 04:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EA81C20E92
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 03:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C931F1FBE;
	Sun, 14 Jan 2024 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ecx6D5NK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496B1C17
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zB6oY1Pb/KAcIjhGCsPCkGMRgVmBLwYoMbw2aX9BIbk=; b=Ecx6D5NK/wECHjW0yA1w4KZIvQ
	HdisQ+4+u0qTtyzEeWG9v7ubq7YaZB79wBTcgrF71fQLkSVgcyJ1DDzxsoO7VU7cQb0Y8fLRnELlu
	UqckyrJ5sVKcPC9haJq1EwV8+ILIsywhOVCNcgbe5OfPTgAU8UEV2gtq3it1owyItyHtDosZCbaXr
	wBVumMQOsWpKhbBJl3+t9SbnOAOQaxXTqQGYjbmq1q/h3LL8K7h1xqwdjYvxGV/0CsvOCdcdfViak
	Q7C+tTuMAEdCSOKSGr6l0upxJoa7zB2i36ATM3xYuslfzwj5LWib0+cOlw8L0Glidvi5jLV8Lm5jd
	m9KMKrQg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rOqpU-0066co-0C;
	Sun, 14 Jan 2024 03:06:32 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH] arm: mm: init: remove misuse of kernel-doc comment
Date: Sat, 13 Jan 2024 19:06:31 -0800
Message-ID: <20240114030631.30459-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the "/**" beginning of comment to the common "/*" comment
since the comment is not in kernel-doc format. This prevents a
kernel-doc warning:

arch/arm/mm/init.c:422: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * update_sections_early intended to be called only through stop_machine

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e7172247f05b7fd1753a

 arch/arm/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/arm/mm/init.c b/arch/arm/mm/init.c
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -418,7 +418,7 @@ static void set_section_perms(struct sec
 
 }
 
-/**
+/*
  * update_sections_early intended to be called only through stop_machine
  * framework and executed by only one CPU while all other CPUs will spin and
  * wait, so no locking is required in this function.

