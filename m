Return-Path: <linux-kernel+bounces-118907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A83388C0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C61D1C3573D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ACA5810C;
	Tue, 26 Mar 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="MMOrE8a7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xd/u8uEc"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E538FB9;
	Tue, 26 Mar 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453309; cv=none; b=bzhbH35KMDI7P+gyhZxcRVn43B5kBsannoVyTX2EJRoN4HOSqjhw6T9hPlBz4CH2Ia3B9Ki6l8hhiSIAvFgyCbGpN8TlWRjqcl3swdv1rSr7FOz4quYbt2JDP2+Tfanw4lkj4jj/WR3TuG5IYO+XxsvT8YoEF95TDkF+U3K1lgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453309; c=relaxed/simple;
	bh=LOYZi8+5ewDBNNpP9PQQw2zJlRjZ4vowyUViqCM6X4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eTW9AIcdxoDLn67eF3LrPypIOEew+6++hKq9H7IMj0hT74a9GXma9wyruG2QKgBekS8K1B1454uRdKQeTi+77PMRgTBA/hzjc09SiHOa/lnuuwmevnOki06wKhdZ494H8rGwoMuYKSltuQM7h7x/y42O3lVFxgc8WD3Ro+N3nQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=MMOrE8a7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xd/u8uEc; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id C6AAA1800095;
	Tue, 26 Mar 2024 07:41:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 26 Mar 2024 07:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1711453305; x=1711539705; bh=Yz
	g7ptgYv8oRD0lDAK7pZDBw1X+IbqXjWAUI3kCBCjo=; b=MMOrE8a7wUIr+VepPn
	1S4T5s83eF071Kd8WJC777QpVjE1Px7YDLqFUFjbWasQNjpP+HWsmDdK6PDmjteX
	s4W7AxFXsc0ohxGdaeMcEGQMsEtgGfcbJ1T3ExLGzZqFDkoXueji+M/PANBnFd6p
	qnA3+2+7OCNKYaKcuAP66r0VTlYbBaCqX5QR6Zo1SC+EJ/I+GONB4xuIVcxlZe2S
	pvUneGCYfyMBEFUUzruDNKgQAqBGamcjiOCSmdfRIqVjJxr4epwvMok5J+NBVwWY
	zIKsTRN2PVvtGygm4Pme31kVdHT0zYgnBE/AYeqOVoS0VABZUb6+83PgbYwX0E8r
	aFBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711453305; x=1711539705; bh=Yzg7ptgYv8oRD
	0lDAK7pZDBw1X+IbqXjWAUI3kCBCjo=; b=xd/u8uEcxTKXjdWn9DHBXoAhwSO+D
	Vl2riBfwZ+UnXeV9NUMRl6/gjyoqKj/wRjBPT6px6oDJjSMZIEC8FIrrRhcBRXS+
	Do9meykvI/XUDheyWccHb24a2tj3dBp12GFGITIsTlEtPYuCOAHbXZJbNcfXyZPz
	CVQ8DePmOAkJfo35HluVlX6tWnFzC+33ed1z5Af/bV6llbYKgp+K/7481rZamft9
	7kunQq94bwL5qKIBEDLaf8Jjew+zmxO9wz7KZKxgvZwcud0rPP1ZgpJHHxYHrpib
	4bOEr7qBXAH+vHmsnofZp7wz8VwRdUflLAXcfYu7x0G9eiHVxfEdGhhrg==
X-ME-Sender: <xms:eLQCZnK71Zhp0CJNz5GdmMuyV_bNdN7HGcN6WjgxwCxKgftSCQnASg>
    <xme:eLQCZrJXdwqLbhh5btgGUCZIh567N5WC6pWlSxX-eWJhLtpiGm6lqR32xVA5-_BpG
    o67XOKNErV4T_CDL9Y>
X-ME-Received: <xmr:eLQCZvuaEtls2uNFHnSwRdPnwxE8gWzJTUSABY7y1Y2N1LmxR0gxAXk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhephfffgeejgfejieeugffgudegvdekffevgeeuteetgeejveeiteei
    vedvffehlefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:eLQCZgbrcPIiJoF-uoGAWsF-T2TfMdtecYHf92KyXbHbys5iDBT85Q>
    <xmx:eLQCZuY5B8ddyMEOwHiWHeHDPIWTMxj4Vc9SD98Om7UM1mroXDFLwQ>
    <xmx:eLQCZkDnBpFnhMSgV538f_tiNTGcwNvZA2PXuxJFGyFXGbRX6Y5hXA>
    <xmx:eLQCZsaHURUN2vXRypI9HGYVsJ6iEQJ2Fcjn7wiJHtuI908O6ONAhg>
    <xmx:ebQCZjPh0NTAi5rYT5VaAqyhMp9V4I-vbhvMFSanxBxYhWz6_G0TTDNmy7U>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 07:41:43 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 26 Mar 2024 11:41:45 +0000
Subject: [PATCH] MIPS: Guard some macros with __ASSEMBLY__ in asm.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-asm-guard-v1-1-fe0c140a5aea@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAHi0AmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMz3cTiXN300sSiFN2UlJTUJCNjI8MUM0sloPqCotS0zAqwWdGxtbU
 AzHiH21sAAAA=
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=LOYZi8+5ewDBNNpP9PQQw2zJlRjZ4vowyUViqCM6X4I=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSmLVWvMtVvzdjCkhfSd7Z94zkFd16F10dEJkbXPn93f
 TKP6FPhjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIVDLDP/M5K6oEDuVksO67
 wipn3TTz66UoE7uniW+Pn/xknByl84Phr/QPmXkb5l/oS5YwSN/r3/jIZMf2DY+kRFi/KLzVk/v
 wiQEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

There are some assembly macros with very generic naming
being defined asm.h. They are clashing with other macros
from C code.

Guard them with __ASSEMBLY__ to prevent futher clashes.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/linux-mips/8d78894-dd89-9f4d-52bb-1b873c50be9c@linux-m68k.org/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/asm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 2e99450f4228..87ff609b53fe 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -37,6 +37,7 @@
 #define CFI_SECTIONS
 #endif
 
+#ifdef __ASSEMBLY__
 /*
  * LEAF - declare leaf routine
  */
@@ -122,6 +123,8 @@ symbol		=	value
 #define ASM_PRINT(string)
 #endif
 
+#endif /* __ASSEMBLY__ */
+
 /*
  * Stack alignment
  */

---
base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
change-id: 20240326-asm-guard-dddeb2321d69

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


