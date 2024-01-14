Return-Path: <linux-kernel+bounces-25406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E910F82CFD5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 06:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FB81C20F24
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9D1846;
	Sun, 14 Jan 2024 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n4eFp0J6"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CFA7E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wm51K5Htr3Ae/2H+wXzef7Us8N7W+cWvSmN+vmOjbmY=; b=n4eFp0J6e/DOVCVat1qdtilTRz
	nngad6ACZYV7spragk76yGSFCdQiNG3ralPaCGNhuOeh0Bl/0QOT2N5BP+1e1m8YI64ACey9oSzFQ
	MHweGDvbroMBuMkTnMbWqkwiYhlhCmsaNPBq8X+Q/ojBXJXURHNR4U747+UBIT45I9EkXKMFxAODT
	d7YFEJfRQVuk9bXhaK36kGsc2+nRNEMP73sr4uFKgTINk4IQfKWi/lxYmVd2NgTzhxiivuHHLVoDS
	FcyRpVZIO2Bn7QzmBN1GSkJsHDE9MBQRynV0WoPtMukmRmk2qHN2dpMIY1xH6CbW4lFmVOTBJKxAt
	FNs/ph9Q==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rOt4s-006DDI-2S;
	Sun, 14 Jan 2024 05:30:34 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH v2] arm: mm: init: remove misuse of kernel-doc comment
Date: Sat, 13 Jan 2024 21:30:34 -0800
Message-ID: <20240114053034.6097-1-rdunlap@infradead.org>
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
KernelVersion: 0dd3ee31125508cd67f7e717

v2: limit KernelVersion to 30 characters max.

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

