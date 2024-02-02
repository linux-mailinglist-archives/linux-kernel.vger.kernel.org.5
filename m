Return-Path: <linux-kernel+bounces-50312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE01847749
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A9B292B12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3868B14D449;
	Fri,  2 Feb 2024 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Wt76hWQR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hcUXBHN9"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0979151450;
	Fri,  2 Feb 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898131; cv=none; b=GgLZKOrRWKDF7smj7mLuLr0LmQe4JNYtjUt1YjswYbthFCXDeH0e0dz29tQxJUd4lSS4vgI654aDwIQM+KDy4ngLSepvnpjP1f5vqPweFSeP5UMFC/oLRG9DPx5SMCs3ne0c9X9wGpEH9RpiebRsWTwalLRaSnNbXLKsaKk5ElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898131; c=relaxed/simple;
	bh=v3fm5XNxNbZ/kFpT9LC1Qs1K1vIdZfDhhfNiJ9dOdaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hs7ooPchGI9HRFhr0e8a4Nu0eg6iSYgv0YZlaSl3CGwQaLR/YIMJt/foXyRN4Q6/D2LhNA/BJDeT510hYiexai+Ognf74RsBfDkoQgMl+tFKA80kE7SQTIE2GjYzAGfpAjRfveF7hLFVvqkltEy5JgUl+RbLezdw9kR2qvizD2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Wt76hWQR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hcUXBHN9; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 7BE013200AF4;
	Fri,  2 Feb 2024 13:22:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Feb 2024 13:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706898127;
	 x=1706984527; bh=IbdTvmw85NIYEo0qhjhBFbrN8ThSw9KMlRfPR97H1bc=; b=
	Wt76hWQRf/z6qzsifN5aQvc/i7TEQqwX635opQbW5FK0Lgm5j2VkfDOb8pR/mj/b
	siYiY7TZgVw7N8zgV5Wxm0oaILZCb4FogLZrXe8ivnyaV0LuG78KJBcxX1UhDUUw
	mpKhVtWIz8NWZOtSJ7XODFzas90JmE72eohpclqicfhjnX1/IaKQNDdZ0mLQvn3c
	CmAB18tt/LKh6NMSzCXp/zoP3iM/TFrJr1td57CfD/veez4F/uTpRtzI29ygoH39
	/dG1U6YeaXOEyuxa2ZhHJfIrtGP4KAnU8NWRNhq6JE2X0/a2gH0ogDNfBpMYS4yW
	q5AWGCAFCLIcVSYSJS5WYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706898127; x=
	1706984527; bh=IbdTvmw85NIYEo0qhjhBFbrN8ThSw9KMlRfPR97H1bc=; b=h
	cUXBHN915XntnvG8QqbriYHqCCzYzrzyvUp+CHx1R1fKS1ahWmG3zksaPGuOjf1o
	5xX1W1hXgGbVUCpDd9j1FTZFi1LvWWW8QKTHvWdRBjt+7G7mc/kD6kHVJn4n09XP
	/+oZBjG4ylAf4I0gZtSjTzWQFxyJgfkhacAMvv2+qoimjIbiCM5vhXVmsBrwjcld
	hVUqNuHDnZR/vZksaf5y81VHaQFiylCrB/+noDRRvT833oXluodGXqkHfCjfdDAM
	Y9W0fbGOitz1MyxCHzcx+lP3LSmntYvRBrekwhKeTCGW9bUT+5q6NFtraW7N+305
	030pjC4sLF9qLU1oBuGoQ==
X-ME-Sender: <xms:zzK9Zb5V9pZ5yAM9KpRhuD9B7uoK9p4E3AFsk_8V3fu5E91qxhJh8g>
    <xme:zzK9ZQ5SCa8gf8eS2yv96Nmvs5fzOvllrvLW1oQSxEcPw3kUP3hMNi4KbZK4BLqiF
    MCRByZOGB_lz3DMBus>
X-ME-Received: <xmr:zzK9ZSfc-KY4PqeVQK6ICY8F3Fb0bPe8NaWVGFsF3rsY50_Gy7oLLNTnfhXHtBQoOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
    ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:zzK9ZcIymLi6oV-NVMTqjKDWBpxqBBpEJikDhoyXAWJSgQrO0tbTGQ>
    <xmx:zzK9ZfKsg5m8IsskE4QPLlJdpOVX3F51xHlVEBlFrNEmAGzAKLhCGQ>
    <xmx:zzK9ZVyrcHZ8Kz1GeQxqSSzKe_q7m5vD8F36Nx-cXmaegsR-V35mPA>
    <xmx:zzK9Zcp7w-RWijtgwwYtKGMMmh4QOwRtjaGCLLmZt5wsCVzgJy3x3Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 13:22:06 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 18:21:44 +0000
Subject: [PATCH 5/8] MIPS: Loongson64: test for -march=loongson3a cflag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-llvm-msym32-v1-5-52f0631057d6@flygoat.com>
References: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
In-Reply-To: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=v3fm5XNxNbZ/kFpT9LC1Qs1K1vIdZfDhhfNiJ9dOdaE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtS9Rnv4ejglhHL17eUe7177ou1bs0d41Mlm5wWpPXum+
 ma1lxV3lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwER6/zD8U+6WiWT+vzPmWs6k
 5JsTZp3Iti5/FDDlW2/T5ontQQ18UowMZ0I/7bH98uhg/+WvtmFK2at2FBox7U/ycBWrVNTrddz
 NDQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Currently march flag is hardcoded to loongson3a for GCC and
mips64r2 for clang.

We can actually test it to simplify the code.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 5a078c5487d6..80aecba24892 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -187,11 +187,8 @@ cflags-$(CONFIG_CPU_LOONGSON2F) += \
 # Some -march= flags enable MMI instructions, and GCC complains about that
 # support being enabled alongside -msoft-float. Thus explicitly disable MMI.
 cflags-$(CONFIG_CPU_LOONGSON2EF) += $(call cc-option,-mno-loongson-mmi)
-ifdef CONFIG_CPU_LOONGSON64
-cflags-$(CONFIG_CPU_LOONGSON64)	+= -Wa,--trap
-cflags-$(CONFIG_CC_IS_GCC) += -march=loongson3a
-cflags-$(CONFIG_CC_IS_CLANG) += -march=mips64r2
-endif
+cflags-$(CONFIG_CPU_LOONGSON64)	+= \
+			$(call cc-option,-march=loongson3a,-march=mips64r2) -Wa,--trap
 cflags-$(CONFIG_CPU_LOONGSON64) += $(call cc-option,-mno-loongson-mmi)
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)

-- 
2.43.0


