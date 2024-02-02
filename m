Return-Path: <linux-kernel+bounces-50309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E7C847743
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E41A1F23528
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833B815099A;
	Fri,  2 Feb 2024 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="a/bM/jNo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W3QCf6yk"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE79150986;
	Fri,  2 Feb 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898121; cv=none; b=KDH1uyfhhHG49lzIHE8A2PH+ANB0NNHwgvAPexHgSpnehxzapEToXzD3MPKm3ASVxX0g9Xu5cdeZF4iMMN8CRPreXgNA5kmAaxbWPZFQVbBgJvK7iw3VE277tyKPPHcWOFGdR44Pt3eY61nhRO223OAPDiCqIePOklETjGk299g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898121; c=relaxed/simple;
	bh=dISe+F7C2E/OK8vn8VrH+/L47GTB4CFDBhY7zPjHwyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LswExIEtCbmY+GpuAVY/ARbWLawLCdOUkyweR5OZAYJuEwHj5xMzn4t7xPB2tf8H97ZIrxFHP0PfTq386rJ86undLmXpm4OIf6SUOicGNsJqlMMve+1QsIfDgSPJE9JKgfD6CrMFx6NYH3m2yB+VIBNTgmRndvMXnM7WalzqJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=a/bM/jNo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W3QCf6yk; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 931843200A70;
	Fri,  2 Feb 2024 13:21:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 02 Feb 2024 13:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706898118;
	 x=1706984518; bh=7wgclmPc7Zcc1oFkurQBvEr0p3fHo8FQzvtyaCB6UcM=; b=
	a/bM/jNoNSVsm0Nm2UZ44k0tDLkXAmooFTyqsy5WYFgpNIxjflRtKgAQL+jRlRbO
	VvvQooBuwuPU/WEqP7wJOR1csLKT4/Uz4QjOvzEeuwlVH0VsF3UvYyMHv1bhGz57
	rqcg4Ap3zwbm23e/b+kB6ANl7rm+oQ3iPbyEym4QIZwDtbZ1JG+L0bLcjIwTE3sf
	/eRXA/JpGAdcPRTdDCNFJrxBn1o2WPehvRx1aBLoEOi5A/ZKd53oDhAGVzzyM4nY
	Q0RnxIYGYxPFp/hZ6KiIz9nBsS4dPac8mSntsnzq/s1Ii2kXeueFE4h41/CPtLPu
	14MSyL0veMwnJ752dqXyNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706898118; x=
	1706984518; bh=7wgclmPc7Zcc1oFkurQBvEr0p3fHo8FQzvtyaCB6UcM=; b=W
	3QCf6ykzdQJbwC/HRB67d3Hckq0nyXLifBVJyEGkTmdetbQjSCts9lrrPJh14OJs
	ds3ZX5l7dhWyE/W87iF8bi/l8by5v+9AMrKenSyztD0w8OwJb3noBedKmEkstUJu
	Rm4XkNve1HJTP9UqoOkmnQmRxIO1DKjgISwwFs18xrqEgibAC3IYvZ11QddbF+ie
	GzENWcLyWeHA+B8yaVbMzosP7sYOOaUGp9KAio7EJYsC7Y+5Duc2pT6LEwEIOR2y
	gsqwBbT1BPktYdVrjaBcs/mv1AIO98Vi7QYUThtI3QP/ef1rwpXmOCqBJrzBxkC0
	nYhcJWtswOJr7zYyOdmmg==
X-ME-Sender: <xms:xTK9ZfbN6FAPEGUdLskbEoXjRKuWfv5AZewS7MEtbcGdFDqTXsCJdA>
    <xme:xTK9ZebR6BYxA7OsOwHnlGXmi6afVLwdk2Z_nYKRsVqJxbzETUCucLYM9wv5v4ytj
    4kZpDR9dSHGreFKtt8>
X-ME-Received: <xmr:xTK9ZR9bHtm_r-mHtgjXzGD1O0Ou5zgBnv2YU2QNcTb_URBlAbdttGrbDmHPWXOYNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeevudejhfffhfevkefhffekteevgfetjeekuedtudeiheei
    geefjedtleevjeetudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:xTK9ZVoSQt80UT39RPYlTCzvwli-Qjr8rRAqOgF2ALyIaLTAmSxcxA>
    <xmx:xTK9Zapw2p4NkdgZ7jclo0g28TlXxE2Nan2P2ZQyVMULDwpyjMPsng>
    <xmx:xTK9ZbRQ2a3tkX0GU9o9nNvtI9GKFciM91-f818nfFiBVFGlYOcbvg>
    <xmx:xjK9ZaKhYvGDPTwC7CasFLwFzuAsove0uKEErjktY0g5OB5_aRA5wA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 13:21:56 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 18:21:41 +0000
Subject: [PATCH 2/8] MIPS: Remove cc-option checks for -march=octeon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-llvm-msym32-v1-2-52f0631057d6@flygoat.com>
References: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
In-Reply-To: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=dISe+F7C2E/OK8vn8VrH+/L47GTB4CFDBhY7zPjHwyE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtS9Rns+XGj/k285+dCeH281Hx8W+tVWu+uLj+8k+wfHm
 48uyDil3FHKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQATMahjZPhw5c/m701u/ow5
 W6Z9nspU+fHQgtmBJWHr/n9sn2hUbO7EyNC4aMm9PdLPnF+vEz57rj5mywXeIj4fgemrP5aZWDy
 w3sUIAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Nowadays our minimal supported GCC/Clang all support -march=octeon.
Remove cc-option checks to simplify code.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v0: https://lore.kernel.org/all/20230414080701.15503-6-jiaxun.yang@flygoat.com/
---
 arch/mips/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0888074f4dfe..daa569ca4372 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -174,10 +174,7 @@ cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-mno-mdmx)
 cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-mno-mips3d)
 cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=r8000) \
 			-Wa,--trap
-cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += $(call cc-option,-march=octeon) -Wa,--trap
-ifeq (,$(findstring march=octeon, $(cflags-$(CONFIG_CPU_CAVIUM_OCTEON))))
-cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -Wa,-march=octeon
-endif
+cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -march=octeon -Wa,--trap
 cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
 cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
 

-- 
2.43.0


