Return-Path: <linux-kernel+bounces-59771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D500D84FB94
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772C01F235D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED1D126F35;
	Fri,  9 Feb 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="mCXVdQbJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQOWNatS"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3F80C16;
	Fri,  9 Feb 2024 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502086; cv=none; b=S9pR+XyqClCGrbJ6zizEVGI5Xo0wth3rU6d6M/OZ7tJB4R8M5KQ9O3PvcA57R5770/p+bwqag7e6mdwMhHzNONGK1a4QWVBsbafZarSq3NKESm9nwSqzF22ed4UBBFmQNSFMbKLGRCKS3NslhA8CgMFMUC47h0nbn5qoUuglS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502086; c=relaxed/simple;
	bh=JYiDQWQkuQam69G61i1ZMe45gTQtctb1ul2pcp6chb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fs4HWWA0mM0FkZ8NsnFbrDFLAEJwfbT4oCU3lW7Aw+RS/8EcS1Etw8BimDVQTZKYDRFMLfVCtXOMtKsGFd1u1rSumX5cMpyAYjAgS1PNXBHmvzaL3OSWglU7Czi+m81BAxyT/SfteWIU8qbncPqNlkV3i8oID4kIUQA67dd8/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=mCXVdQbJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQOWNatS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id AEF4E13800BD;
	Fri,  9 Feb 2024 13:08:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Feb 2024 13:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707502083;
	 x=1707588483; bh=3q3qV7TXH9fl2/87iY/a+gh4HUomq6NbrJMeFnY6F+M=; b=
	mCXVdQbJJ1Y0RIBGoDesG29uRjLSRbpx7QZJkmUP9r4r6mbAXP9/VtRtqK00WgEW
	DDexzcqM8kwRbOjmowOJF8JIQVBlLDSozv2nyw3wvQgXeY+CDUhTgpTrjVLMM4jm
	MgwCdhKaSiolYYZK/n60cpj3EI/hDS9eNL4sxuo84SpCzAiMIiJ160XuRnkHfJOD
	usNy1H5Fvs1uq3ofmWm4Dw3xaYnroCGImWo3aaKclufcA1SVpZI9f6UME0Jqxj82
	CpiQ7s55aFMTivsFHsTHE6hnz9t3bveKag0zvzbFS3Ej2u6Y8MOPVQyJt0i+iA5A
	3/AvUTQeexMYtholXt9oRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707502083; x=
	1707588483; bh=3q3qV7TXH9fl2/87iY/a+gh4HUomq6NbrJMeFnY6F+M=; b=g
	QOWNatSzCpLTJAhtM3dKQaQ+AyAf7uIRJ05QO39QEkplnLWBvmfgfjXid9Z62Q9+
	8JLP+iAtXuBO/Zxp/p40ol4mZXWaJRs3CeoTfxQd901qTiYLmY4FZFRP4+B9OaAL
	egoHZ6Llp/u2STZufAOvaRoETTfBK/P0oqJ5fiu4bT1e/m/O4VPFHOOCJFu0+LSp
	Hplc9IwDmHffByZcQfp1lV1vrhIhd0Fx45fU173J3YPg2nrvYcEVnFkqSPu8snkz
	nslEbEN+enD5rVqJ1vyA9LNrmI5Nxb1/MC0bS7ftVgsyM6dP3jSUtUIYJsZgLka/
	e/qdNWGArM/Lx5ebQZfYg==
X-ME-Sender: <xms:A2rGZeH536foIODWByrMQag1sr2oS6f9lo5ZhrbJwZaSJGg9vcMvNg>
    <xme:A2rGZfWmP3Z4S7ckc1orQbTYNH-u_ploVS6KzCcgxVRLG76BI5KL52naA0gHrNV-c
    Ka1DKKLVUKWmpSf5XI>
X-ME-Received: <xmr:A2rGZYKMVuAFUEIj1AN5ZT5owg0VTwr-2C3bllBlmN4O4IfsVz6LH55ZABpESPIQZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:A2rGZYEL0s-J-7ZRyfi2w4EgA_gqOT8wY56xjuNWLliCoc8N_k5sRA>
    <xmx:A2rGZUWQ9OfStoOeD7i354mWbCU79ZYudFHluIkbL-8wjC9lB3R-OQ>
    <xmx:A2rGZbMHQtNSbPZqStZEJZySX_1nD0PzV3D8_c2nLPV6Xpwmf47rtw>
    <xmx:A2rGZed0XCYB3gu04yhwJtCNYhITnsu6nqMfBI0CTJbNuMX8KvhrOA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 13:08:02 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Feb 2024 18:07:50 +0000
Subject: [PATCH 4/8] MIPS: traps: Use GPR number macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-regname-v1-4-2125efa016ef@flygoat.com>
References: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
In-Reply-To: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=JYiDQWQkuQam69G61i1ZMe45gTQtctb1ul2pcp6chb4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtRjmX/3x3kfLG/z5PKMa5ly/d/lwG2F16TYJ9YuC73x+
 sBLl9M/O0pZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiKxkYGbYKe9RymfmK/mzm
 OeXHVua/wubI+k6uhO3phuWFhSfVJjD8L/p/x6jzUv6z+0arZn2cJvdk7bpmKR1xtg6P32ulJtQ
 6MwEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Use GPR number macros in uasm code generation parts to
reduce code duplication.

No functional change.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index a1c1cb5de913..2d95e9971a2d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -58,6 +58,7 @@
 #include <asm/module.h>
 #include <asm/msa.h>
 #include <asm/ptrace.h>
+#include <asm/regdef.h>
 #include <asm/sections.h>
 #include <asm/siginfo.h>
 #include <asm/tlbdebug.h>
@@ -2041,13 +2042,12 @@ void __init *set_except_vector(int n, void *addr)
 		unsigned long jump_mask = ~((1 << 28) - 1);
 #endif
 		u32 *buf = (u32 *)(ebase + 0x200);
-		unsigned int k0 = 26;
 		if ((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
 			uasm_i_j(&buf, handler & ~jump_mask);
 			uasm_i_nop(&buf);
 		} else {
-			UASM_i_LA(&buf, k0, handler);
-			uasm_i_jr(&buf, k0);
+			UASM_i_LA(&buf, GPR_K0, handler);
+			uasm_i_jr(&buf, GPR_K0);
 			uasm_i_nop(&buf);
 		}
 		local_flush_icache_range(ebase + 0x200, (unsigned long)buf);

-- 
2.43.0


