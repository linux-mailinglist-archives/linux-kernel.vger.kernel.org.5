Return-Path: <linux-kernel+bounces-59770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B066284FB93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EE5284985
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D9185C65;
	Fri,  9 Feb 2024 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="NevMQ/0/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vfyknal6"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23B80C0D;
	Fri,  9 Feb 2024 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502085; cv=none; b=CxDXMxN8XtieJbI6KT3PEx3nZ8kcbKjEdjv/Xpn5AokIwjhlYJ8fOFWaX3B7aT6gyGvV0T9CnDy0JQJ4fT8aYtnZ7x0RaHVWcL/aRRQSKrkMU2Ytfuj0t/m0ejagFS+LXUOmDQqJ8VThkL1S8w9k3Oe1gcnp78DNP1kVUSvaziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502085; c=relaxed/simple;
	bh=drnUUscEJd0qoxeAseYhODkaifRCuE3Ni5XFZNt/K/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lENuoZfiXPYe2vMdatqdeQU4O2C8sxY0pXK+PZseIqpeMduDj+5aEn0bwwCH1bCT9V5d1XZUSKvffF31sjbE/dQ8YUIqxKdKB4c3qnSCLdvumH+YZpQdl/SCAr2Ro6DsR9oHQg08Y7uwRbI/HettDazhfmVP2LGMlsE80i80AtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=NevMQ/0/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vfyknal6; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A733F5C00DB;
	Fri,  9 Feb 2024 13:08:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 09 Feb 2024 13:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707502082;
	 x=1707588482; bh=6gwcRnoAoOJpXfrN5Im6WqVu6p4yEsIVuUrix2xlsVU=; b=
	NevMQ/0/fbOVUllhSo6h7QGb2uDdR1K3a/xG/A0nJ83UJcCflm9YRKy0wkWlO4ib
	Q3SF4Illn++mmxfLvya9ADdE1CBVJJFNZbRJSj5guB9538a+15CBwozRcvQ46SeF
	wfcEjCjMHB4L8r9NQeUZJcPe0lbMLv5jOynunwspEZrLiUBOkyjONpa8oTuHQlPr
	MrKthvcdvi+wnklR1z2qq74H3ISlMA4TXXrwdwLHlkc/bNVHbnPrrLeKwL/5AhLP
	cBp0YdtJ/DCmDCabZa2012W+ZvSekosofEAlSjKdwxHakx3j/FLoY9VmUnW3ru8E
	ldRd30ZqVVQgzsrD2YGRLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707502082; x=
	1707588482; bh=6gwcRnoAoOJpXfrN5Im6WqVu6p4yEsIVuUrix2xlsVU=; b=V
	fyknal6ifS3uYExh8UaMLG57k2g80kVVL6THc05ycFCrmIWWH26pn2wFnVPUpj8e
	DjMvh1cwndjsoZEFVxvOvPbl1pv0T+/vNyeuZ7n4OfXJWJikiW6If6dKyB7O4ViL
	huDT/MxmBnZ0LlDK0u3M+/28MrzHeomn6ZnlAcW6PD8NQEjx9UW8x7UYRGDqqH+K
	7WcGWviLagODI6xCcX9r3FnajW4e9bEZSZGxqg7f11175Cz5NHfTju4jsGEQnOXj
	3bJVNif+pfoplYIP2CoG67S04YxByjfBljjFp473EjgCJ3phP/h4uWz/U7LVwwQf
	KVoYF15fUaT9MfRj5uhVA==
X-ME-Sender: <xms:AmrGZX9FoNgGoIo9UGXyom3Cna-7UQKn8poi3Kmntv2ElNb23g3b3w>
    <xme:AmrGZTvNt7Ugr1naOnKWQbRyJBXNkia-dLNKPnHwoYfKnxu7NSkriFTaC13iO3uGy
    A_lJyGz0j7_T3QVrUs>
X-ME-Received: <xmr:AmrGZVC8adXhvXjYhdBADlAQEt47zSzGtjh-ss2aaBZL0e1JyusUAg3ddkZnD-xcvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:AmrGZTd62BuaqCZg4YXu2g93-ja6SILLvAUDhGyOcEhfXShx-y6A-w>
    <xmx:AmrGZcM38fGCjHzodXI9kCH7nCPod7AgXN1nBygYAlad72jct_U5Kg>
    <xmx:AmrGZVmMeL4xB5JnzyD1Ua6gdSHsfzsXQj3dasvYfZXm1zJkroYirg>
    <xmx:AmrGZZp6wEstt3al0vw2xyWzewAkTgN_3OoY55MvqT7fkihe4e-Utg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 13:08:01 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Feb 2024 18:07:49 +0000
Subject: [PATCH 3/8] MIPS: regdefs.h: Define a set of register numbers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-regname-v1-3-2125efa016ef@flygoat.com>
References: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
In-Reply-To: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=drnUUscEJd0qoxeAseYhODkaifRCuE3Ni5XFZNt/K/g=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtRjmX9DfzNNyT9mwb/p65yQmyU3Fz95VaB87pd6UK1Xu
 L/309u9HaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRtasZGdpVBf3ijxRqbQoI
 urAtJqJ3q8HGp56Wk//EcCVbbZE9FMjIMJuf4XPCIofJvvzFDSuqXlxsMbvi9VE1ecOtq3JFhoy
 v+QA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Define a set of register numbers with their symbolic
names to help with uasm code.

All names are prefixed by GPR_ to prevent naming
clash.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/regdef.h | 89 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/mips/include/asm/regdef.h b/arch/mips/include/asm/regdef.h
index 87ba7be1a847..236051364f78 100644
--- a/arch/mips/include/asm/regdef.h
+++ b/arch/mips/include/asm/regdef.h
@@ -14,6 +14,95 @@
 
 #include <asm/sgidefs.h>
 
+#if _MIPS_SIM == _MIPS_SIM_ABI32
+
+/*
+ * General purpose register numbers for 32 bit ABI
+ */
+#define GPR_ZERO	0	/* wired zero */
+#define GPR_AT	1	/* assembler temp */
+#define GPR_V0	2	/* return value */
+#define GPR_V1	3
+#define GPR_A0	4	/* argument registers */
+#define GPR_A1	5
+#define GPR_A2	6
+#define GPR_A3	7
+#define GPR_T0	8	/* caller saved */
+#define GPR_T1	9
+#define GPR_T2	10
+#define GPR_T3	11
+#define GPR_T4	12
+#define GPR_TA0	12
+#define GPR_T5	13
+#define GPR_TA1	13
+#define GPR_T6	14
+#define GPR_TA2	14
+#define GPR_T7	15
+#define GPR_TA3	15
+#define GPR_S0	16	/* callee saved */
+#define GPR_S1	17
+#define GPR_S2	18
+#define GPR_S3	19
+#define GPR_S4	20
+#define GPR_S5	21
+#define GPR_S6	22
+#define GPR_S7	23
+#define GPR_T8	24	/* caller saved */
+#define GPR_T9	25
+#define GPR_JP	25	/* PIC jump register */
+#define GPR_K0	26	/* kernel scratch */
+#define GPR_K1	27
+#define GPR_GP	28	/* global pointer */
+#define GPR_SP	29	/* stack pointer */
+#define GPR_FP	30	/* frame pointer */
+#define GPR_S8	30	/* same like fp! */
+#define GPR_RA	31	/* return address */
+
+#endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
+
+#if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
+
+#define GPR_ZERO	0	/* wired zero */
+#define GPR_AT	1	/* assembler temp */
+#define GPR_V0	2	/* return value - caller saved */
+#define GPR_V1	3
+#define GPR_A0	4	/* argument registers */
+#define GPR_A1	5
+#define GPR_A2	6
+#define GPR_A3	7
+#define GPR_A4	8	/* arg reg 64 bit; caller saved in 32 bit */
+#define GPR_TA0	8
+#define GPR_A5	9
+#define GPR_TA1	9
+#define GPR_A6	10
+#define GPR_TA2	10
+#define GPR_A7	11
+#define GPR_TA3	11
+#define GPR_T0	12	/* caller saved */
+#define GPR_T1	13
+#define GPR_T2	14
+#define GPR_T3	15
+#define GPR_S0	16	/* callee saved */
+#define GPR_S1	17
+#define GPR_S2	18
+#define GPR_S3	19
+#define GPR_S4	20
+#define GPR_S5	21
+#define GPR_S6	22
+#define GPR_S7	23
+#define GPR_T8	24	/* caller saved */
+#define GPR_T9	25	/* callee address for PIC/temp */
+#define GPR_JP	25	/* PIC jump register */
+#define GPR_K0	26	/* kernel temporary */
+#define GPR_K1	27
+#define GPR_GP	28	/* global pointer - caller saved for PIC */
+#define GPR_SP	29	/* stack pointer */
+#define GPR_FP	30	/* frame pointer */
+#define GPR_S8	30	/* callee saved */
+#define GPR_RA	31	/* return address */
+
+#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
+
 #ifdef __ASSEMBLY__
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 

-- 
2.43.0


