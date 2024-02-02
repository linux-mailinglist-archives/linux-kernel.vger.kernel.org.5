Return-Path: <linux-kernel+bounces-50311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B509D847746
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CAE1F23FE5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995F151443;
	Fri,  2 Feb 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="SHXlUraW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RP+5UG87"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6911509B2;
	Fri,  2 Feb 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898128; cv=none; b=M2zyxCuzVIix7tVkJtir/Jmr9nP2Tb6E9LO65PAQLO4I2GDgOPjDda6q0rmZY1Hrh4VknGWb9sJVjwuVbUr8EWZW6fpXMNJ6du6C8uDNgo3P4mcLETUi3wiZEPPIiPUo8GKtIXuH54KLDNMGPPHSuvrEUXg1QoR3d2Vw2kNb5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898128; c=relaxed/simple;
	bh=371ht8cjT3hC6+X+HE+TEFeE+DMZEi/5TF0EdLjCURA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkiDSRl0zCpiivWwXQtH/31hf+RrNHb6RNw0QYpaO4+UH5BqqCnz7pH+M+HlFqT+53C3S/y98tikb2a4jtA2+prOmUohbMPPKpMADGfPQkE7fkTdWQ2tuwoU+iQ3yk8qGonaEGUeBSHZuEZsHun3eQZpvRKPWBUOkUJm56PSTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=SHXlUraW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RP+5UG87; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 440103200B0E;
	Fri,  2 Feb 2024 13:22:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Feb 2024 13:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706898124;
	 x=1706984524; bh=Ym9BQIoq4bXHoovH8doDvstMiDl4stxFFOM8v58VZtY=; b=
	SHXlUraWZka6/TNeJOUfDuDBLsAUwfvXDABwYa5w968lyAkcF8/ogksmFsgHPhlq
	FPYbr1Wy/tzCWjC5rC/Nu/CMISobgsutYnnshRq8qw/0WsFLxfrADZmAvw2dYy9N
	bGeqVz27WR5Xlf8O1RCP0Q8UIGL05mxJSUi45rIy6Nz0WwQu23GPaR7vtMioGEwQ
	remnxqV3R7/5tkngWJI8pNtgKSs1pjXjUC0k/YhS35dV0rnH2XifZiJR7UgJzoGj
	GLa1cB9ayIeRLDGUG3nU03D+IroUkAvT3TMTBCTpas/ssTqn9ab2+HfGg4UHUwoR
	8U/AKCTZ/XhnM/YYIOl6XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706898124; x=
	1706984524; bh=Ym9BQIoq4bXHoovH8doDvstMiDl4stxFFOM8v58VZtY=; b=R
	P+5UG87JVziEs3cMsEp7L76/EopWOB+3bAz2IFUrQ9b/HZZelKG+hpIqOZt7bSgy
	sz7qkwrcPhGVGjEPclnJlayXe8W4g53/jUWjhlMwinvXVFWiwbTdN965nGSEWE9J
	HYuXVt33CZeg47VCQxFFdDrnTzhZz0z+ITz+Nf4T7dhgH362ERx22UrVMEheXsQq
	872outDP76YKmEQx8l1vWrmhgDSMkoOY1Xpa++Z2V7TMFoxxmhu8AhsShTjC3Q6p
	6q93I6Kqplii8hhD90LbykVBSptJhgKvEGXhC1Hf1iAA0TJqgVtwxmZjyYXfRKAN
	spuEwsyUmnsE64aZxQPmA==
X-ME-Sender: <xms:zDK9ZZ-ntBSFCvSnAF3nirJnQSSxyRSNjNUioUu5PrMChdt4IxKq6A>
    <xme:zDK9ZdtUDtDIOidcA_3pZNxN74uX0iJj6DOPZkpUA5Bre7lwwhp03prj1aHsGSV6b
    UpBPFkZEE_etjGJd8s>
X-ME-Received: <xmr:zDK9ZXA7m5EDCZQgir0tEpK_dsLTar-3UAkvi2_sLNtKsjrZ_Y7gqZ6hja3AufdPmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
    ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:zDK9ZddaoqYDJTmoom8Sw5pIODpM07yNvtRMl7gn0NZtHZoxOwBAOw>
    <xmx:zDK9ZeObNT0ko3WiALAi-FjhjbRCyap_Y3-gTm-y00v1Tv5F_Gjfjw>
    <xmx:zDK9ZfntC0rq3nFrZThq3i573QgcpOZQag_wLwDvaj6wMnQq5CWyJw>
    <xmx:zDK9ZdfL8nWpKkGja-tloU6ytZKwgv57Owh3HOSWDo8tNce78FjkQA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 13:22:03 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 18:21:43 +0000
Subject: [PATCH 4/8] MIPS: BMIPS: Drop unnecessary assembler flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-llvm-msym32-v1-4-52f0631057d6@flygoat.com>
References: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
In-Reply-To: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=371ht8cjT3hC6+X+HE+TEFeE+DMZEi/5TF0EdLjCURA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtS9RnsMr0qGsOV8PLTcXGSx9VYmzoXG9haPWlNOX037X
 TWJc+GRjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZhI8DlGhivTbnh2c6ZuLV/l
 /m+l00aB45ZiJzsm3l5xvnn747tPT/MzMvTrzxIM2a+TkHZJU/1sPVf0ScdjjIme2/U7mxmP5m5
 cwAcA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Nowadays GCC will always pass -march flag to gas, so there
is no need to pass another mips32 flag to assembler.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 91470931a5b8..5a078c5487d6 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -170,7 +170,7 @@ cflags-$(CONFIG_CPU_NEVADA)	+= $(call cc-option,-march=rm5200,-march=mips4) \
 			-Wa,--trap
 cflags-$(CONFIG_CPU_RM7000)	+= $(call cc-option,-march=rm7000,-march=mips4) \
 			-Wa,--trap
-cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-march=sb1,-march=mips64) \
+cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-march=sb1,-march=mips64r1) \
 			-Wa,--trap
 cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-mno-mdmx)
 cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-mno-mips3d)
@@ -178,7 +178,7 @@ cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=mips4) \
 			-Wa,--trap
 cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -march=octeon -Wa,--trap
 cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
-cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
+cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,--trap
 
 cflags-$(CONFIG_CPU_LOONGSON2E) += \
 			$(call cc-option,-march=loongson2e,-march=mips3) -Wa,--trap

-- 
2.43.0


