Return-Path: <linux-kernel+bounces-50306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24184773D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC37928CB28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F31B14D429;
	Fri,  2 Feb 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Z2ScsI0r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MxzwKJ35"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631BC14D422;
	Fri,  2 Feb 2024 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898115; cv=none; b=WhDT1LlzPuAPreFbuiFAcnPYpwJ1X0Ulg3nWMMm4bI23Q9JmvcuTgnBWA8/GUfGcTGYGXpI+x40yZKhKIq5sTOIU6wqjCtzGIpfglF7ADtLd/EmLWdT2q2pLR02NSiHxwH2kM+xErFxq7Y2bBaZaH5MBbfuW8QB7JztIzFZJWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898115; c=relaxed/simple;
	bh=n+btR3GkRkETQalejTxIHKXNJBrs8Yzei44Rbm5kP7k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k+LSwyV/nLCOBIUxbLL8BeJhkhrd2AdYQbrwVFmHG6rbPP7MXmg1NsceEQGEWi2GPpZeJPCv8hCDXNQOtlvCgObknfPc18ZTsiMH5NeFOc83ikBvqaerzscRPIyOW5G+sAV/t36vw8X55RrBP5HdlgSFyCqf8qpvDoP6r5PPzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Z2ScsI0r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MxzwKJ35; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 91D4732009F9;
	Fri,  2 Feb 2024 13:21:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Feb 2024 13:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1706898111; x=1706984511; bh=iJ
	MAmsg1zPOBsyBlr+qBC4WcKfJs1J+Rjidlb6GPrNU=; b=Z2ScsI0rXW55W/iZTc
	bzpuZCrDxRzWGltoHE3WlcT8e9oTNKmcKVy9Q2QcFWscNMmVML5ejGVxPHq8EFfc
	J9TegM1g3B9n26if2RTTmGke12PYgubKDR2y6UulFpP7gri0BQVzTsglNYuArbDR
	PoO/oWojnh4o6D7NgoivuHe/Y2UtJbn2PMk4aEfZOvz3pFpym1iXe2ZBjdOdfo5a
	Jqym0r2Zrcp3/7XLPIWorylBq/2Uj0V4eY5IeJWyTXAqu5+TaC1LGODVEDLMEkBn
	IsdL+KlbIiR9ApdHSGE6kJz/u8U+1tRgir8FxrNaMvQwVTkwRnR384ldkpGduoGw
	P3bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1706898111; x=1706984511; bh=iJMAmsg1zPOBs
	yBlr+qBC4WcKfJs1J+Rjidlb6GPrNU=; b=MxzwKJ35BtjYGxmviqsMwOzjLI44q
	9jhMk3MXU8UpmDjTf10fD1GKZekut7yl5wahzWPEPRTZuwVWQRXDyomUSGjT1Puh
	RgPgg+9Ktk+wfG5rfyCQG0dRk1QNeeHf/B/Fq00yDRLb8xn8Nlgd5r65s+z86Lyn
	NpVIEMwiup7QNHmXKbI0wwaSQ/ISHDDKVdFFif2mXLj4Ev4G3ebx2CBCmBqH7Guo
	vgYxXo4PbevNmbXUuaMqMm6DVZkhiELBrehIdzhHhgt0JjrXBRAhNPX+xXlnaT5S
	Uj8opdpVlkuXx2drBD27RDVRS6YzHgtVK0wlSwGMmfrbKAjhWwALHMHhg==
X-ME-Sender: <xms:vjK9ZVvCiZNHM5LZIuI6VlaB2imyzvARYvd3EilrHqo9HaRhGV9OSw>
    <xme:vjK9ZeeeH_SrTA1Df1enjuqrsJJgsmJyBpoRmfMdHzBKTDWPbHRWpHQ2CdNG2LJDC
    ALl5AIv5lDT7ZeenqI>
X-ME-Received: <xmr:vjK9ZYyKjiBQkcSUtz3W3OeBBC9IHK2RnZNqZUsFXhRY76ROuinZIQJHQ_VQbzLoaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedufffffffhueehvefhgfelveekueegteefgeeiieejheefkeeh
    keevudevieegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:vjK9ZcMxHlOp8R2CFCfeICVyLH8o_QiiM0eXcvVNjdw-S8D6HGwEyw>
    <xmx:vjK9ZV8mmLpvTa_7-ESiZ1KxL4VvdeE0lsHLYCc9nkwY3ap2h6FjAg>
    <xmx:vjK9ZcVMvGdP_hNI5hOFEWkwNOzBrRNE0wL6LCMewlhCWtZpX7bB-A>
    <xmx:vzK9ZRQuZeDQdjZ4TK2jI6uOG2AWQwKdkXpEwhbQDu4PmKEhFImqWQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 13:21:49 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/8] MIPS: Aggregate build fixes
Date: Fri, 02 Feb 2024 18:21:39 +0000
Message-Id: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALQyvWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIKGbk1OWq5tbXJlrbKRrZmxplGJiaJBmZmqgBNRRUJSallkBNi06trY
 WAHlQTW9dAAAA
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Guenter Roeck <linux@roeck-us.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=n+btR3GkRkETQalejTxIHKXNJBrs8Yzei44Rbm5kP7k=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtS9RrvnzJvzwEP2R5/rzmpGdQMXFe2NJzSmsPpOebJAS
 XeNYrBYRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEwk/x0jw5+rCX5Put0nmWq2
 1+uWvYna0Z23QqiMyepzw+uvFx/mzWD4Z7I6rLXwOb9E4/Tmb/GlEh9POZQvmr95q9zd+c9Ujl8
 SZwcA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This series is a collection of build fixes that have been lying
at my local trees for a while, some of them are for Clang built
linux and others are for some wiredo configurations.

Please review.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (8):
      MIPS: Probe toolchain support of -msym32
      MIPS: Remove cc-option checks for -march=octeon
      MIPS: Fallback CPU -march flag to ISA level if unsupported
      MIPS: BMIPS: Drop unnecessary assembler flag
      MIPS: Loongson64: test for -march=loongson3a cflag
      MIPS: Limit MIPS_MT_SMP support by ISA reversion
      MIPS: Implement microMIPS MT ASE helpers
      MIPS: mipsregs: Set proper ISA level for virt extensions

 arch/mips/Kconfig                  |   3 +-
 arch/mips/Makefile                 |  46 ++++---
 arch/mips/include/asm/asmmacro.h   |  22 ++--
 arch/mips/include/asm/mipsmtregs.h | 256 ++++++++++++++++++++++---------------
 arch/mips/include/asm/mipsregs.h   |  22 +++-
 arch/mips/kernel/vpe-mt.c          |   4 +-
 6 files changed, 211 insertions(+), 142 deletions(-)
---
base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
change-id: 20240202-llvm-msym32-6392d410f650

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


