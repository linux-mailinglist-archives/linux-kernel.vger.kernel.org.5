Return-Path: <linux-kernel+bounces-67059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6276856584
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC091F26099
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1EC133988;
	Thu, 15 Feb 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWJVXoLm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B3131E5B;
	Thu, 15 Feb 2024 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006156; cv=none; b=NsS5uw1pQkXsgxiT+p/1A3Z/k806d1vQKfUqd1Mwhmxkvf4+2GJw2ZR0efEPQvSfCgjFi/1eBMVU3pM0xebS13B5EtnmIvP8jTup+V5YKPcclMdmpI72d2MBb7msYtusYvaHfz79A5aPOBIxefSsNJLNyOPyS0OBNrrwjvuRaUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006156; c=relaxed/simple;
	bh=ivJfSLb5cBWaYq/gEjt21srATBTLZ/Rxsy9blVSH+qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MDcZt9aizTzPKjo9LqWRFwyMeYX6v+1fxMcsBG6kuz8U9ygLJihGHj1SXNEXhQNVo0zif8mC4zeQDCb2W4dFYRg0ckejQv/hMCQH4gfb3d0Cbos9HORSUveKO2D1WSbDjwxnT0jm456ZNrkrLcyB3Mg5q39a0URPSxJH5Xe2r+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWJVXoLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2152C43390;
	Thu, 15 Feb 2024 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006155;
	bh=ivJfSLb5cBWaYq/gEjt21srATBTLZ/Rxsy9blVSH+qs=;
	h=From:To:Cc:Subject:Date:From;
	b=LWJVXoLmeHYsluH055Vq5uXU85yymLmbd54m5CIgcL7htAYsEkdNEME0+9s1TpZZe
	 Sjw31yx0CPd7doCj5HGUVq25qoDhIN2e9wQZAJ4y3ZoMXHhhQw9rukSbuAEJgkEQS7
	 h5RqMWwQDa7Yz4Wi0GzmCXcz3s/SV7aSJimxDQg+ByRpej43+vZqaLfCKzt6H/FeyX
	 fvP4U0ca5LhgJHEg2iBZk/q6QZiDKBXzfMLjMrgogGRCjFf3T9cmo7UwGGN6v/x4MY
	 ITpyLTcrddaT4cFIHIg/y8B3WX0YhFoJ8/I+fNmG6F93TB9BkGPjG5RlhiTGgLCz31
	 VMYd1Xlot4/zA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hexagon: select GENERIC_IRQ_PROBE instead of redefining it
Date: Thu, 15 Feb 2024 23:08:19 +0900
Message-Id: <20240215140819.1910705-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select GENERIC_IRQ_PROBE, as the other architectures do.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/hexagon/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index e922026fef09..a8dd2501f39f 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -21,6 +21,7 @@ config HEXAGON
 	select HAVE_PERF_EVENTS
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
+	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
@@ -60,9 +61,6 @@ config GENERIC_CSUM
 #
 # Use the generic interrupt handling code in kernel/irq/:
 #
-config GENERIC_IRQ_PROBE
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
-- 
2.40.1


