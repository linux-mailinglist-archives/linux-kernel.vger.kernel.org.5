Return-Path: <linux-kernel+bounces-59769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FAF84FB91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445691C25193
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B1784A48;
	Fri,  9 Feb 2024 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="WLN3XHtL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndlPE5p9"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB480C01;
	Fri,  9 Feb 2024 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502084; cv=none; b=rv/syLdC4yihOBTR/5UXe/IbcThKo+yshE6wYNXDjiZ56DZSqdo9MDJWPrmkREkNQmS3wQsQ9oW9MQS+riYx+T97cpcaPScKKtHgXTn1uGnBUrJh2mpfoZP1gXYIrMMJ1GwKUUiAQ+SOFcQZgCINoqKwZFTePgSmsTn1NvVkcOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502084; c=relaxed/simple;
	bh=LKttXLr0babb1IylnCacJGFrcMdR+mMwj71Fm7abKUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnXDMySoVxtqmseERckyF3+QLBQU4+33a+9KFw4pH4TMT6eVDmhRo7xmrrwCr9lHZ/SqVjIAEJt6dmfcW320ajjfnwgDfxMUCzBduubr2losdreD+4aTsN8nM4PH+NE9HGSKH353v6+EYuyGb1/0MG33I9viV6fUi8z33NTDGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=WLN3XHtL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ndlPE5p9; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 88E685C0154;
	Fri,  9 Feb 2024 13:08:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 09 Feb 2024 13:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707502081;
	 x=1707588481; bh=rOTpDa4ia+tDgi5nhBOgRAcL/ixRct8eMBhwoMPjL34=; b=
	WLN3XHtLvsPxqg0Xk8woWerpd8LRHATppn8GwQi8sKjtTfpeEHZmvi0XS58opon6
	IiY67MeRjpNczg3q+sprAdQZH3bYxbo2Fm7LqFf3AjdHCv0o2GBhi44Euj5j+h3N
	++niUDDClkT325DBGoIBVrC95e6wxo6o39XyqlomCg33yBZzxgZ9i0FOKAD7lIIt
	QloQmQhc38Qy/+j+WtJ58kT1RDhcRsSwVJm2LhRoZw2vyT9PcYHKYjieR+jn5nHj
	uh+OrH8YWc5vSx9N8Tfw4ZnA1ohet3Vx3gfE8bbInfcK07zInwr87B7PY7/GygYb
	NT2qhRv38IHeaT/qTbs2IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707502081; x=
	1707588481; bh=rOTpDa4ia+tDgi5nhBOgRAcL/ixRct8eMBhwoMPjL34=; b=n
	dlPE5p9ztThejkwz2SZi2wTTbhdWnzI76bsD+aBGUZi/JztyWHtRAdug5CqYV6zr
	yl26DLxKKtBWL1W2st4ylB6EacXDnta11YIy6UQ4/aKxOGks2gcT/01WxT9ViJmB
	SPjU1s1mc4YLBqnJmuh97FxTkslRDrsIKFQG1+GQ2iyR3sh+D1wleeYMEcshwx3P
	pehK7vuS1wW00s5Fx7xbXkZoLdkUKSNl4g7rHDC9eSLsCNED8/DQOmdD6siLVCUk
	mdAS3Yp4V9oC526/SyZT86BB4YGf2ynz+E2ft1eNAHjh4JjZY7klubkvehbuBWQB
	J8ds12ZGPUx/dfR1vmjog==
X-ME-Sender: <xms:AWrGZSid7p-SfiIZVGVQAwP5ALnd8XS5Sdn5YbRYV0f6TDkGWQftLA>
    <xme:AWrGZTD2oFJOFxYq8xrYMStTBX7ij9-n0vs3ZPQk0MmezKoPBB1K0nm4--tJHFKjI
    ZvBhE67KrOsLslYzJQ>
X-ME-Received: <xmr:AWrGZaFKWFdYkkgcXf6QkrKHWMP4HL8GUm1cJ6a9i4vHlCJ-tyEUdfogFHB0nAxIWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:AWrGZbTY8zKJ_DSSFYMsvA6A4AjzXAMEBaTKG995StxJMSkavNu_5g>
    <xmx:AWrGZfzAuODZ4oJPdSGMDh8_J-daDhOpBh6UHRKFW5lKb69ewgryRQ>
    <xmx:AWrGZZ4vQ52R58cS0YlV9Vrrs9kVFe25cSzEY-BZNR0lc6iZ3SKAmg>
    <xmx:AWrGZRuIw9euXMQ4k9rMPeSRkjUDnATspyAvQN63f0Uavagv237UpA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 13:08:00 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Feb 2024 18:07:48 +0000
Subject: [PATCH 2/8] MIPS: regdefs.h: Guard all defines with __ASSEMBLY__
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-regname-v1-2-2125efa016ef@flygoat.com>
References: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
In-Reply-To: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=731;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=LKttXLr0babb1IylnCacJGFrcMdR+mMwj71Fm7abKUY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtRjmX+u+E2w3D9TIWyGzjLr24sUjPm+5pWIlLdxC6d+m
 uNSMvtCRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExE8jfDf1/n7K7JTx9wh822
 1eG/andxc6lbkv7PBNE5j5sOqm7f94WRobcypm6mZpWMU2DgouIHT6R39v4Jb48o4Dmw4pOJq+8
 rVgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Those definitions are only meant to be used in pure assembly code.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/regdef.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/regdef.h b/arch/mips/include/asm/regdef.h
index 3c687df1d515..87ba7be1a847 100644
--- a/arch/mips/include/asm/regdef.h
+++ b/arch/mips/include/asm/regdef.h
@@ -14,6 +14,7 @@
 
 #include <asm/sgidefs.h>
 
+#ifdef __ASSEMBLY__
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
 /*
@@ -102,5 +103,6 @@
 #define ra	$31	/* return address */
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
+#endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_REGDEF_H */

-- 
2.43.0


