Return-Path: <linux-kernel+bounces-59767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C674484FB8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034A81C2444E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10880C07;
	Fri,  9 Feb 2024 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="bl6udEzk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EUOTo/CJ"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578180BF8;
	Fri,  9 Feb 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502082; cv=none; b=qgZGjAIOGwa/vdhsvusITS0a/Sai2OUmnK3dK+RhMFtCKGyifKKjBwOuR86PYoSK+vXIrp7zTqe6too5ASDuho8LiGAdKTc54m43xQ3WwvyHn+teV/3n5tGmybfHvhVi1SHDw0cigW+voACJXvTtd/HmQmShmS9FZdICmKHQOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502082; c=relaxed/simple;
	bh=+62asRFl0S1fz6APzJkHn+qsEgHXRlxqLyx3HTejsuA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VTKQocumdCvqhwLKLI1Bz7E96bFblYEiB6AsFGLn+s74NF1BdVghC636FhEaoh+aKj7Xe54MhCIh+Zup3hQ2BMx6hEGAYQYPiMxXI/ukZIAlvuaP3DlsClPxnfu4fmT7uYYIpb9WOUnHrSuFwMJnJylavEEvCUlWcsgQlGs1iS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=bl6udEzk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EUOTo/CJ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 66AA613800BD;
	Fri,  9 Feb 2024 13:07:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 09 Feb 2024 13:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1707502079; x=1707588479; bh=2A
	O4bjcUp6bVYUkMaYAR4RdvPKhD/l+vcIQLPfHFuDE=; b=bl6udEzk2yTyHJT8L8
	SEQUh/JswxpyyvGZNTMHGQ/0llz9DGRN/bf7QEQlMT81C3otLFXgCFej7OlJjvXW
	nSOlIP+hZR+zZe1xETCT3n1HgKniUazvUdGopfgdI6/z4l9ZV2No2BV5VAIGeMWS
	ujjqOufueCIa7maz/UwtkYUq3cbCM8Uzz6leWI0anUckJnhlVScFzWS4jPS9TYgl
	qclpBh4Z7p4pPtMSApXMiQsU36S84AIo2qNLBXwRx83ABZy+Kv0iQXQoRDPmIdZR
	xtmT90bBHuS9/64PnV/uGOpGHQuzo+UG2DeZ6F9lRG3L3gDM3aeuRNMDnt94mdbo
	5tPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1707502079; x=1707588479; bh=2AO4bjcUp6bVY
	UkMaYAR4RdvPKhD/l+vcIQLPfHFuDE=; b=EUOTo/CJfzOrPOngxdFRONwtxh9ju
	gif82uejdcNJyr6HETqbQNmjBuLjgzg9QCO4azhTfvhDiZXkiGFSGeJaepoKpd0n
	7PMMzpC6SxSzcXO/DXHaZbtZ8fn0nwwJIgO4nUvsmIVTL5cnEJO+UQo7qs/GpIoi
	iw4naqijcVfeK3wnFCDZC5t71Z2QyKL7aOShuCa2PIsWabDeKYkf3JVChSB/QgmC
	j4EIkW1zigVEEpH2hrwcaWhLUNg1rup7OH+5lyO2UXVuAsEgQPmQDBU0eqIP1QD1
	N7FnHHiELWvi4McqiNJtPWUGsExYaBzHK+9kB2MteFU1T69QyU9Q0XgPA==
X-ME-Sender: <xms:_mnGZfPCeqXa9TLUI0IGfTDnA_mPQRiB70-3O9q_PJpGTt7LQlV5lQ>
    <xme:_mnGZZ9vZXqVom-ntpBjyCJnHzJW7DxEhmF-lNMYs409GBz2PP4D-A7pVfaO4nYuT
    a-LSp8vIZELyBwVbDE>
X-ME-Received: <xmr:_mnGZeS4bf-oi3BqnSUConLXyq4UABMiiNsgCxdLd-X7nDFV5taaMU57bdjCS9NxQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeetfeegieeijeehfeekheek
    veduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:_mnGZTv958R2krqhI3egCQgnG7PhAlaebZGX1RGCwyViwocl-ULmqw>
    <xmx:_mnGZXeY8RwwL463htW1oQnyL0Y8KfjiYtXayi9CzJvnxO_qyqRWrA>
    <xmx:_mnGZf1wc6IQWFclIs7lZhxC35VrsglEGy21ig2KWjviIPD8Az7SdA>
    <xmx:_2nGZYHZpnRP4_2qWfSjPJsgN_Kg1xMQx_O1BHbIWqWpSAQOtwCQhg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 13:07:57 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/8] MIPS: Unify register numbering macros for uasm
Date: Fri, 09 Feb 2024 18:07:46 +0000
Message-Id: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJpxmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwNL3aLU9LzE3FRdk2RDkzRDQxPzVCNTJaDqgqLUtMwKsEnRsbW1AG3
 Qz89ZAAAA
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=+62asRFl0S1fz6APzJkHn+qsEgHXRlxqLyx3HTejsuA=;
 b=kA0DAAoWQ3EMfdd3KcMByyZiAGXGafzIu2KMdEbiNyppV45/ISVQ1snIT6OKVp5Ak3naaBsjm
 4h1BAAWCgAdFiEEVBAijrCB0aDX4Gr8Q3EMfdd3KcMFAmXGafwACgkQQ3EMfdd3KcN9XQEA/lsM
 TSvyhGkAf06a3pH1IF/gB/golXzk2km1eDLr7u4A/iYEWr2MuhscR+EFvGDOqMLwcncV1k+uwg8
 fC37gqMkA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This is a attempt to unify register numbering macros for uasm,
in response to review comment [1].

This is a rather large cosmetic change so I decided to send
it as a sepreate set.

Please review.
Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (8):
      MIPS: Unify define of CP0 registers for uasm code
      MIPS: regdefs.h: Guard all defines with __ASSEMBLY__
      MIPS: regdefs.h: Define a set of register numbers
      MIPS: traps: Use GPR number macros
      MIPS: page: Use GPR number macros
      MIPS: tlbex: Use GPR number macros
      MIPS: kvm/entry: Use GPR number macros
      MIPS: pm-cps: Use GPR number macros

 arch/mips/include/asm/mipsregs.h | 249 +++++++++++++++++-----
 arch/mips/include/asm/regdef.h   |  91 +++++++++
 arch/mips/kernel/pm-cps.c        | 134 ++++++------
 arch/mips/kernel/traps.c         |   6 +-
 arch/mips/kvm/entry.c            | 431 +++++++++++++++++----------------------
 arch/mips/mm/page.c              | 202 +++++++++---------
 arch/mips/mm/tlbex.c             | 214 +++++++++----------
 7 files changed, 737 insertions(+), 590 deletions(-)
---
base-commit: 445a555e0623387fa9b94e68e61681717e70200a
change-id: 20240209-regname-4c14f1147e25

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


