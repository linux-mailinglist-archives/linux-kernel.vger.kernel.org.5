Return-Path: <linux-kernel+bounces-28418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B032582FE46
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDD828CAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142412B6A;
	Wed, 17 Jan 2024 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EEs2wemr"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B778BED;
	Wed, 17 Jan 2024 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453811; cv=none; b=kLWLlTXaNEql+zqmDvFHK0HbwQhyjG4ez0dvFXVXhgGYZ9fz0ShZavDOR5oiautbhmeaLK+DrcxSFgarktLesCUPdw5LNNfxaVlcWrQA0o6RIUi8f26ZRi44Ssys2Z9cHAEpec23B7NHL6+Wgh9+cmWJ4MEDkquaHRGKbgBV9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453811; c=relaxed/simple;
	bh=jgmXU1E3Z2SWEh6ABHcsCpSffF6ClS5QkoPdtgw0WSw=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=OuK3J6X3w9vReX1OWqoUtiNdQnXBUIvpGj40mYH96pHt48yNNBdHnBDX06yq7spbFSICUEDASTA+vQL0qEC5lD1TmOC0eDa3AI4aODzBO1H7mIKS9XQo5ODgMHXYJhbzRrBkgK2Hgn3XPLv57yuJmsarcxN4nG4uWK5XYSOLelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EEs2wemr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Rfa69KGhRV06omS8OU11mtmpPZ9dpOihzp/ZOk6Xf+g=; b=EEs2wemrsa0B22guu+fu4YngIc
	LrbzCTnPk7n4Ks7EXGQyadLquqMYsq6wknU2JiW5CMLC+NT0NC3+ThJYyYDveOh/AqTqaTCqUroGK
	tbvBXTyRHLR+SArNNP53idwxfhqq8F5uUuxmKTDsHKq5GhlSzQsa4AJ4aPcUk38jjSq46lKKzMnZa
	wxrlsBnv0eSjc4kulABp8UZ6ACPBtKT2AlLZxLnswU4WyUDjSWe+AOLdr8ARSCuljg/tXhG1cdOQZ
	JRkqVvrCBVgiRPT0COO+QRrtBIATqBVJidWLcWDdARr+Dan0+UNIN6AbgxXll34Led+WtzkHY1Mue
	sCksqeuQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRV-00E6zu-1H;
	Wed, 17 Jan 2024 01:10:09 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 13/13] ARM: OMAP2+: fix kernel-doc warnings
Date: Tue, 16 Jan 2024 17:10:01 -0800
Message-ID: <20240117011004.22669-14-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117011004.22669-1-rdunlap@infradead.org>
References: <20240117011004.22669-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function name in a comment.
Add the return value documentation for one function.

These changes prevent these warnings:

wd_timer.c:76: warning: expecting prototype for omap2_wdtimer_reset(). Prototype was for omap2_wd_timer_reset() instead
wd_timer.c:76: warning: No description found for return value of 'omap2_wd_timer_reset'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/wd_timer.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -- a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -57,7 +57,7 @@ int omap2_wd_timer_disable(struct omap_h
 }
 
 /**
- * omap2_wdtimer_reset - reset and disable the WDTIMER IP block
+ * omap2_wd_timer_reset - reset and disable the WDTIMER IP block
  * @oh: struct omap_hwmod *
  *
  * After the WDTIMER IP blocks are reset on OMAP2/3, we must also take
@@ -71,6 +71,8 @@ int omap2_wd_timer_disable(struct omap_h
  * during a normal merge window.  omap_hwmod_softreset() should be
  * renamed to omap_hwmod_set_ocp_softreset(), and omap_hwmod_softreset()
  * should call the hwmod _ocp_softreset() code.
+ *
+ * Returns: %0 on success or -errno value on error.
  */
 int omap2_wd_timer_reset(struct omap_hwmod *oh)
 {

