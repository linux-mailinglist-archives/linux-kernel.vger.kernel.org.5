Return-Path: <linux-kernel+bounces-50315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA389847764
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8AD8B292F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC132151CE6;
	Fri,  2 Feb 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="cm7td9MG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYYrscqS"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A8151CD3;
	Fri,  2 Feb 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898141; cv=none; b=d4wgiQTn7TPTS5meaU9f1/gOiIEexE08rhLgV7Q+jZHGdvJCtktpZxocXC2BlWMD6c/QyPbujFBk8VwW82t03NH0YnMZiTZQWg9w9sHcduTWckT3HJ0WJo7JQ6nqIejobNQamTTq0qtW7jiOZvy7QvDdvkrXWndY/9kw2dX0yZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898141; c=relaxed/simple;
	bh=K9jVRbvoC4pJRRadOkCl26uHM4IaJfzZZjnpU9UIQlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E00locpeGTXvbJKuk1bld3utHsB20Z23Y+k7CQ7xaWpyBJkH3p/Nt5e0lB7JtoX13z0iLj7fGjWZR/tttUS3x2AFJh1BjHamc1QkHIUjHN/aluesUnQktIdqG0NRRvybukQXadegbumhKpe6UsUHP2zOCIYLV1GysFjfCLLC6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=cm7td9MG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYYrscqS; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id E4FD83200B13;
	Fri,  2 Feb 2024 13:22:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 13:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706898138;
	 x=1706984538; bh=uKviyZxmRZlj3pVPOpppzhplKj0Xg++k94Zg3QVf1wI=; b=
	cm7td9MG9Y0Ih5bS8N1IdVzpxEnNuBFXWN4k4kQMXLTOt3kn2TDPR2w83+A2SwJs
	i/Bu3IQJN8V1sFnygjrWDc0V1qcwDG7Eq2yWDyG5KH9MMRgXLHuWtzHK0O3OXMJ2
	AJIPJ2j9nt67+PL42GA2R9YZAlF4jpD/AYJUMV1BTnkZlK3bLT6Ziq0+h9BwCmyy
	fHL4Wr4yROgmXsqJyUAlAfKfqThocYySejOwmx/nGRq0tUAICFOz1BMsyX4v53oL
	McRiYKXO7bz8aPeCqopQ8llkIOSnm5z4ZKsQBukbxQQ3N8zAWqYTBgvEl3PNZ0RC
	DJ+88OmYQIa0bTnszXPxmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706898138; x=
	1706984538; bh=uKviyZxmRZlj3pVPOpppzhplKj0Xg++k94Zg3QVf1wI=; b=i
	YYrscqSSFgaGXnSReDw9COKFJ2bE0PA6VgUdnYCSqj8jO61kv9APmJxILqP1kJ/P
	mxoegijWoBnoZMWdTG8v+Xbuv4qbhTDYdYCJvOoF9Uz3dNktBKNGLPkQEVVtsJqy
	NIxF9V1S244Xv7kLUROOXVzSxfgmU3ymvFQ05GdVHwp5sT+3QQm2p/A2oNE2bwV7
	vR/Q0VNsIIjh37DusIs5aS83o6fct3iWhOrodXPkQQnB3oWyce4H7qeuvDw8k5ui
	D0HF0yc/HEeP1Hf4lBMNHRdl+W40KpCw5bQLGDUAZxTfTYEUtbdHCx+tL44vShiF
	9jXiqEPeUDrIi9NAJpHRA==
X-ME-Sender: <xms:2jK9ZQgaHN5ntsm-dtXQELbUV2fDId--7V3Tqr2uKFYR3Whw3gzuMw>
    <xme:2jK9ZZBhsAhaw1OIme1UsDbQld4-ifwUDjRxRflRXSkdevfdoremH-J5HHbeVsHcg
    VKEp5Nb642MqmG0yjg>
X-ME-Received: <xmr:2jK9ZYFC4fKnYka8JsRVbsFiLxPq5dUYstXzSAlyh69pes4vn2tvTv9-E7Bqd1zjoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
    ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:2jK9ZRSjeD2lEOUWs2Uy-nwOquRqt-WrywiX4UoixXxeXVFPvFUhZw>
    <xmx:2jK9ZdwrlXkJ6PnKx-gPopX4rr-WkFyjLPRiWgakEm7uWI8MGkB9UA>
    <xmx:2jK9Zf7woYHyHVUd0NTlkAkbiZv53Krwf7H71xPgkgvt4puF7zTMDQ>
    <xmx:2jK9ZcxvNb2eO-kSu3ddobH0FpLr77wm7h8uw7EWRDmLlqM9pIAK2Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 13:22:16 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 18:21:47 +0000
Subject: [PATCH 8/8] MIPS: mipsregs: Set proper ISA level for virt
 extensions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-llvm-msym32-v1-8-52f0631057d6@flygoat.com>
References: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
In-Reply-To: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=K9jVRbvoC4pJRRadOkCl26uHM4IaJfzZZjnpU9UIQlI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtS9Rnu2nixsmCM6O+rPS4duvg/WzatLZL9zHnsst0Ne4
 87kaUW7O0pZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiH2IYGW4+uxO2UihTf96V
 q4adJ4scPk6f23Z618q+KHvBQ2eKNasZGe6IH1jJb1rA7McmvyxwUcykieyV8squk3UdpL7sXB+
 pzAAA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

c994a3ec7ecc ("MIPS: set mips32r5 for virt extensions") setted
some instructions in virt extensions to ISA level mips32r5.

However TLB related vz instructions was leftover, also this
shouldn't be done to a R5 or R6 kernel buid.

Reorg macros to set ISA level as needed when _ASM_SET_VIRT
is called.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mipsregs.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index dfb268f8aef8..6e97811fa936 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -2087,7 +2087,14 @@ do {									\
 		_ASM_INSN_IF_MIPS(0x4200000c)				\
 		_ASM_INSN32_IF_MM(0x0000517c)
 #else	/* !TOOLCHAIN_SUPPORTS_VIRT */
-#define _ASM_SET_VIRT ".set\tvirt\n\t"
+#if MIPS_ISA_REV >= 5
+#define _ASM_SET_VIRT_ISA
+#elif defined(CONFIG_64BIT)
+#define _ASM_SET_VIRT_ISA ".set\tmips64r5\n\t"
+#else
+#define _ASM_SET_VIRT_ISA ".set\tmips32r5\n\t"
+#endif
+#define _ASM_SET_VIRT _ASM_SET_VIRT_ISA ".set\tvirt\n\t"
 #define _ASM_SET_MFGC0	_ASM_SET_VIRT
 #define _ASM_SET_DMFGC0	_ASM_SET_VIRT
 #define _ASM_SET_MTGC0	_ASM_SET_VIRT
@@ -2108,7 +2115,6 @@ do {									\
 ({ int __res;								\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips32r5\n\t"					\
 		_ASM_SET_MFGC0						\
 		"mfgc0\t%0, " #source ", %1\n\t"			\
 		_ASM_UNSET_MFGC0					\
@@ -2122,7 +2128,6 @@ do {									\
 ({ unsigned long long __res;						\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips64r5\n\t"					\
 		_ASM_SET_DMFGC0						\
 		"dmfgc0\t%0, " #source ", %1\n\t"			\
 		_ASM_UNSET_DMFGC0					\
@@ -2136,7 +2141,6 @@ do {									\
 do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips32r5\n\t"					\
 		_ASM_SET_MTGC0						\
 		"mtgc0\t%z0, " #register ", %1\n\t"			\
 		_ASM_UNSET_MTGC0					\
@@ -2149,7 +2153,6 @@ do {									\
 do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips64r5\n\t"					\
 		_ASM_SET_DMTGC0						\
 		"dmtgc0\t%z0, " #register ", %1\n\t"			\
 		_ASM_UNSET_DMTGC0					\

-- 
2.43.0


