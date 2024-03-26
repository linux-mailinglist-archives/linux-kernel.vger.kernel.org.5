Return-Path: <linux-kernel+bounces-119931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626088CF11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DA41F85B21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8D613DDB1;
	Tue, 26 Mar 2024 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="RKedk3Wo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PwuWUQx8"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70113DDA1;
	Tue, 26 Mar 2024 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485338; cv=none; b=RQQn5uOg7Q62x32tahC0TUtQpOttevfvkOfuaVsEhWkWtOAeToyCn3nSGb37eC+8lm6dC5eaxddCrA9XuDTiqfaA2ph1+zTsWWSDx/tdUIOcuIkOUIGILtnQTucbMfG+WO1YTQD6dyDHUpTI0te5qPLgYLqL/uCWp4kGjsgyeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485338; c=relaxed/simple;
	bh=PtOUXMjzXjX7s5GqUQPaos1/0Du7txixWN+eg4H2I80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=spgkE2FGOzKnU0cMZEs9BhuQJEi3bPGFILmNWooy8Xbapm+h7cCaCJoJq+JgfIo502wHB0Bsxug7gaPyDUbrupd04d8SjD16QoDyX1lEoI+8ucmbUXKaJLtSNgqTsRUnF7F+OxQHTXJXKq+GH1itCsDchpgHv/vSp9rop5bo6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=RKedk3Wo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PwuWUQx8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B9415114013D;
	Tue, 26 Mar 2024 16:35:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 26 Mar 2024 16:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1711485335; x=1711571735; bh=Hs
	sF6jxDOo9gWplv7ETpFdcCAQiZ2CJEi3RcbG0EW2w=; b=RKedk3WoMHjqBfj7/p
	vBUjbsxhHGGfFv4DoyvH3VfZh/UBpLEGJiu+58c9TYtRpFX6Bb1m7j0Ne1dcbZQn
	KqFNiYowDx+XFwrIxu9KtBfKPWTpbeKONw51w3vEVdZtVlgs0i3ix7zxcCDQJzjE
	tLIm5yYmaC0VWYnJEON/w7LccNVi5qbbFD1TOUFkt8ZXcVSiEAWW6DGsWnbRpDW4
	30CkhG+i1JlfS2u+rY2t1NweZc8v4bZmymotYut83y7A0w53zFoKL20N8FUz+D8s
	nMS8C9QEC8TaNndQY+RUeGbzwkaVviL1BOC58aZrgVJaZRpV4hp/iRjVaGTCBRgg
	Ks8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711485335; x=1711571735; bh=HssF6jxDOo9gW
	plv7ETpFdcCAQiZ2CJEi3RcbG0EW2w=; b=PwuWUQx8ZXqWZwtbF5DUnYgDsCO3b
	WPWaKvr++6CGXgSugR6+HNCZdknJBjA09SVCaH5oWTub0cwHyz69hA+gAYiAdNH4
	DWpEeGTmsuxm5TnVoS2YQGTVixSVh9Bg7tP7IzspUvIffxu2gii6HMgOwEwWIHeC
	RQs1q1IvPsBeTCfa2Nx5xxrRymqxRL+XIqnhJ3umUfN3bbVEzWYloxTOJ4f7Mt0G
	Ug0WKS6RT6Y5v+BTfVeFpxVXMPU6rbw5litS/50UrEd+rNtX2BhS/kOE1lXV0Qie
	NInPllQ3MDjGUul4Oo8gIqx9pDkzDyW2EdnkRyz/Dpdj7WJ374hv2+4gw==
X-ME-Sender: <xms:lzEDZv_YDsxiavBVVvzlL2_nUdNWSG9HkMn2olMJdUBrShkrVzrWVw>
    <xme:lzEDZruaUa5PLBQlqwgWgEf__M1-GzGsQUUlBORAFGm_KcWeYgTG7Zbjzu3TmnTB5
    paYraoQR7-05j3h2tY>
X-ME-Received: <xmr:lzEDZtA7h0_r_BmNaqXHtl74eG7X0TIVcqFUVqTGKr2zfs7tXCYX6AE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedufffffffhueehvefhgfelveekueegteefgeeiieejheefkeeh
    keevudevieegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:lzEDZrfD9CQp6i22sHUDMGBoa5wn_Z1CW399wzZtWRYLqBoaxOWf-A>
    <xmx:lzEDZkODBf_YnNuKBxMiKoRQpdNngwrfs-HYfsZeDgqsUffLLd97LA>
    <xmx:lzEDZtmx8SXH6YYHAasSzvMWlIRx7yeDcCRBA56AekaeZNhPOHw8Eg>
    <xmx:lzEDZutAW-KlIUoYUR1jw7AkC9EaoPOQ17tcFjnUxxhz27OcoPviow>
    <xmx:lzEDZj2XfcMVmJPEjo8vcMDn4qhLmxusZsbDkoslnvJaGdwVM-U9TQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:35:34 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/9] MIPS: Unify low-level debugging functionalities
Date: Tue, 26 Mar 2024 20:35:32 +0000
Message-Id: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJQxA2YC/3XMQQqDMBCF4avIrJsSx6JtV96jiMRkogNqJLGhI
 t69qfsu/wfv2yGQZwrwzHbwFDmwm1PgJQM9qLknwSY1oMSbLLAUEy+hNdS9+3YchaYKLVHelQo
 hfRZPlj+n92pSDxxW57eTj/hb/0kRhRRVIcu7QmVM/qjtuPVOrVftJmiO4/gCcNktv6wAAAA=
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2517;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=PtOUXMjzXjX7s5GqUQPaos1/0Du7txixWN+eg4H2I80=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRmw5nOudsX1oSIXk5LP6czIaUnbNLivG9Rk2P1Ep+Lf
 N1rlpzTUcrCIMbBICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABOp4mRkeLF1heDPgjrb44JP
 eP5cOjJJZ6bv3rNLD+8qeXYmwXXJheuMDH8UFxnt5tl35z2HxrZL7wNPCnNt+B3j0+d4zzviyuo
 NXAwA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This is a attempt to bring all low-level debugging print functions
together and provide a arm-like low-level debugging interface and
a further capability to debug early exceptions.

This patch elimiate platform specific early_printk, zboot printing
functions and cps-vec-ns16550 by newly introduced debug_ll.

Hope you'll find them handy :-)

Happy hacking!

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (9):
      MIPS: asm: Move strings to .rodata.str section
      MIPS: debug: Implement low-level debugging functions
      MIPS: debug: Hook up DEBUG_LL with early printk
      MIPS: debug: Provide an early exception vector for low-level debugging
      MIPS: debug_ll: Add Kconfig symbols for some 8250 uarts
      MIPS: debug_ll: Implement support for Alchemy uarts
      MIPS: debug_ll: Implement support for AR933X uarts
      MIPS: zboot: Convert to use debug_ll facilities
      MIPS: CPS: Convert to use debug_ll facilities

 arch/mips/Kconfig                        |  12 +-
 arch/mips/Kconfig.debug                  | 240 +++++++++++++++++++++++--------
 arch/mips/boot/compressed/Makefile       |   9 +-
 arch/mips/boot/compressed/dbg.c          |  39 -----
 arch/mips/boot/compressed/debug-vec.S    |   3 +
 arch/mips/boot/compressed/debug.S        |   3 +
 arch/mips/boot/compressed/decompress.h   |   8 +-
 arch/mips/boot/compressed/head.S         |   6 +
 arch/mips/boot/compressed/uart-16550.c   |  49 -------
 arch/mips/boot/compressed/uart-alchemy.c |   9 --
 arch/mips/boot/compressed/uart-ath79.c   |   2 -
 arch/mips/boot/compressed/uart-prom.c    |   9 --
 arch/mips/include/asm/asm.h              |   2 +-
 arch/mips/include/debug/8250.S           |  60 ++++++++
 arch/mips/include/debug/alchemy.S        |  46 ++++++
 arch/mips/include/debug/ar933x.S         |  41 ++++++
 arch/mips/include/debug/uhi.S            |  48 +++++++
 arch/mips/kernel/Makefile                |   4 +-
 arch/mips/kernel/cps-vec.S               |  16 +--
 arch/mips/kernel/debug-vec.S             | 194 +++++++++++++++++++++++++
 arch/mips/kernel/debug.S                 | 130 +++++++++++++++++
 arch/mips/kernel/early_printk.c          |  19 +++
 arch/mips/kernel/head.S                  |   4 +
 23 files changed, 756 insertions(+), 197 deletions(-)
---
base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
change-id: 20240326-mips_debug_ll-ce72fee1b6a2

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


