Return-Path: <linux-kernel+bounces-50308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B305847742
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB095B2395D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243814E2F0;
	Fri,  2 Feb 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="rPAK5d6z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nn7eTDEs"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C414D447;
	Fri,  2 Feb 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898118; cv=none; b=fQe2ZK5vJj1AymDPTvm/nPZD1vqSj0TkmJDaOcEIMFL5thIQzVXIYMr/uM2fg4m9rf8yTHrBEAsdYfDnyNMU6UfvbOJZgaWxj2bAVY0IAPNeVEfiBlWDetbv8brPXmc8k5ibJ2nofC1Qxw8Wya+RGMkc6u/hlU09AuYF/baUcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898118; c=relaxed/simple;
	bh=G7pEwmE2rBW0Y6l+YNkudDnlODmTUfzEzQVNoJ8fF9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0bMJJlurBav+/iscBjfq9b5QDZER6XwAm2hDm6jU4ZWED56UYfsgKuYW2ZUEbJzg6MK2Nw6Xuw2sQhOwOAinGPyFk4eBfXUP4qJPJS+Vk1F5QE/syy6Ln7h+NGynwLhEKrQ7w7hCFkhIBm3gzOvPHfrV7qsaAJUlLk/+/qwenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=rPAK5d6z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nn7eTDEs; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 4B4583200AF4;
	Fri,  2 Feb 2024 13:21:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 13:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706898114;
	 x=1706984514; bh=5CMEthdiIfkclr3TTuMp0s9GIA2qa1FQiAoY820EjG8=; b=
	rPAK5d6zq4uoNfX8tRxazchKVNcHaje4l0KNYEijXEdzUsimsq3cZNERaGeaMH/g
	FIyvsr45/vHzspx5cK485TewE5M02LNkUUDv/oq9asrrfaR4vsktV8s6izL4UROR
	KoIiQYLk/cn0/jE/hftPAqrJ1ytINVxorkV3/+PqxR250hhMPxraetC06ndlBYL9
	Cs2NIOuM8CndQtj1BQIcjBVjUHg0/YvRsEIvlTi3+lCASc/OuVy8geW8wfZEDUIh
	7DiFbOAbYVNCzpZ7ItEmhZu2Q0x3TnjfK0ENY+pkRP4dl1p2Pa9WakcV3HS5lZRF
	ZK4gRgAWDInSCTNl2YrStg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706898114; x=
	1706984514; bh=5CMEthdiIfkclr3TTuMp0s9GIA2qa1FQiAoY820EjG8=; b=N
	n7eTDEskqTJPNfy9iMMA8jaefWuj/aC4vGh1OFPl16GSsunPNH73jk4VXZd8+DLx
	2XKmEj2leFK9yCNSuUr7V7NtLbqxAOIzFov/SSqDaEiY/rTlD2X0PqpsUo/SJ7dc
	YPdeJnnbJk/vfih83Z/r8wMOhxoEyVA1ZpLsOJxGrkO64ulgub40SeetNiKbNOsl
	wbgrJa+R0EAp2NBRnR8gqFvXBaO149ZI2latqFm3rVC0xwOp6XauMFXByhslQwGf
	Y63iOCDlaVuh3q3NmSUA8BIuO7XlDLdHyhP6pCw9JEq8MSAOhMifM21e1IEZyq6s
	tUn/VldX1/z7zwHN7sG6Q==
X-ME-Sender: <xms:wjK9ZVFiirlvdz8n3CMNGMIT5TC_KqawL6gud-zhrOXh-jftA5kofA>
    <xme:wjK9ZaW-4nxjLsOBnxhR9_jNJf7Md8fILMSP6aH-Dq0wMPhS7KHdaIW3F1BCoGnGg
    hzfjjVGq7OVk7n8nnQ>
X-ME-Received: <xmr:wjK9ZXLCT7FSND8JEWRqcqCHYtRIbD0x2i_zs9S6L3OUmWXy_T1SPg-PACXNW7DlQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpefgleegfeekgeeggeeifeethfejjefhuddvleelheetveek
    tdehgeeghefhffegteenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wjK9ZbGio4khyBSqbJTWInAgp6WGrsxWDi5P1XYM0j7HYV3R8NWRyw>
    <xmx:wjK9ZbUPR1RH_AfErwn9HzyBpu2XwJmkbNq0KMSFoOqtHTsg45G9HQ>
    <xmx:wjK9ZWPqIKzTdnsqbJ0ClFI-o4x-u7zvbLzCpgde7wOR1YfJf9nY3Q>
    <xmx:wjK9ZSE8PbDeoYb-c7jsobtxqKwJtm3eSuJwOtI6rtNVyMTZwrhjAw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 13:21:53 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 18:21:40 +0000
Subject: [PATCH 1/8] MIPS: Probe toolchain support of -msym32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-llvm-msym32-v1-1-52f0631057d6@flygoat.com>
References: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
In-Reply-To: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=753;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=G7pEwmE2rBW0Y6l+YNkudDnlODmTUfzEzQVNoJ8fF9c=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtS9RrsNmDc1yE7SXiVesZxhCmt20av+NeUXthrxHjZcN
 /+9vqpFRwkLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEyE8ycjw3O32RMmsbVfTb5w
 YmXt838fOa5zb1xxRdlUfKW72wHnLfMZflxrcFzIkqgYr8a0PvDEvDWyu2zzfyg8Fbp3WnJtN58
 nHwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

msym32 is not supported by LLVM toolchain.
Workaround by probe toolchain support of msym32 for KBUILD_SYM32
feature.

Link: https://github.com/ClangBuiltLinux/linux/issues/1544
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index f49807e1f19b..0888074f4dfe 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -299,7 +299,7 @@ drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 ifdef CONFIG_64BIT
   ifndef KBUILD_SYM32
     ifeq ($(shell expr $(load-y) \< 0xffffffff80000000), 0)
-      KBUILD_SYM32 = y
+      KBUILD_SYM32 = $(call cc-option-yn, -msym32)
     endif
   endif
 

-- 
2.43.0


