Return-Path: <linux-kernel+bounces-50313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E484774B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578E128F933
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341215147C;
	Fri,  2 Feb 2024 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="LAf4uM32";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U3WdxLjS"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772EB14D44D;
	Fri,  2 Feb 2024 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898134; cv=none; b=Q0L6Twg68e9va/x9QHEQXIjkLO4PfA4Qibzxq/sQIWYBUG9cd1Q/ZKSb2Uh6M6s2lP0ugTqud1+PWXvwXoj7JefY6rbE/Ys6v+2TY5fJu3o4m7MS+wRWsXKb/S7DqqjTG5Y/bsZdV7u/7LIxYMTmXDamkUKmkqNbOVA8sefaQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898134; c=relaxed/simple;
	bh=N59Bj8/WdhFntIwAd6AT31VUOMyxOe1WmRe/HYmvrls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFlywia5viMkl9iL0GZmyYRmdOZlVPaTQ5OoO8jyvJPdHPX1rO2x97PxusFH/YPcGO4SH9yY8hQvzILFi4yk4C/NYoeCzkUwEbtoMBWdaOON6+mSafaQPs/jgdmwDhRbKZqurud2ueaI3BlaJ843hei8a3hiWdf2LQSkTR9i6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=LAf4uM32; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U3WdxLjS; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id DEB063200B0B;
	Fri,  2 Feb 2024 13:22:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 13:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706898131;
	 x=1706984531; bh=OExBeIhg8SJBJvjWKHPnt5PnhMHFu9TlyU4PxD6rmZk=; b=
	LAf4uM325odBgKk2X3ivSYBTTYNzZQCWuJWKsQjcG1jC1El6ojoK0DiaYSz6MBrs
	NxNvs5XnNcYJ+WRkNn3ee0i/MfGig+pPvibfmmzRb+/WvpeZpokhgXON2AVl0S11
	uoZlBqaWUh1iofMGHTBfKEGkpP0lJkJ1Hkc/1EJTMHgyh+RkNDsVvqAhdA6Hu4AA
	Y4Ofnx1PD1WO8RALj56dmFVTHcGDyjqXQJ4aPeA0nTGu58hRFGOKCwo+bEwUtHmE
	50oS1sIVJB1LuRA6sTavr34idiwwD8s2Djhd1NPly0U91A0kPo64cUgD69+U+cCy
	hCUWflT2WtAxJMCmkm3/FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706898131; x=
	1706984531; bh=OExBeIhg8SJBJvjWKHPnt5PnhMHFu9TlyU4PxD6rmZk=; b=U
	3WdxLjSK7lWM9oJ7/UqRa7tMAjSwGJkP6JotbNOrEdmGPehJEfRB2JoB/c3/RmzO
	wqkMLmpiFXW6C+FFri1uM0ZllM315CTekH9Y0+WDk7lDtIvNBoyThvyN1FH/gD5e
	GQnBWKxXbr1Gl0hurii5pOLrFktchlMxSNlJv/OeJXBq8k5Dc2OPDCHfeLPBnBex
	k431ma2PqwlPIlKy7ks7NZ8Uost+1XLCDW1sO64S7tE3v5rgvKk7gqzEQRrH8UsP
	zwDK8wm4t3pJNq28fBD7t9AQ1g67UggtKNY45+OskTLzNeOpWISP6Vh99KhZ3ceR
	0rITwX5U0uzAz18wYV1Hg==
X-ME-Sender: <xms:0zK9ZTiObxPj3Hbs2Utz6G0qr5QnQyJEndRCQzLITSbrZWrlT0uQFQ>
    <xme:0zK9ZQD623PY5B1ruuIfRimSISB22jOVrbfNjr-afLDEEkP66Hrnh1_b3nvIY57K6
    iKjxKx4Yv4ZR2PcYNY>
X-ME-Received: <xmr:0zK9ZTHKpWYdzjdYR-Leie0tXnRN-jVqaQ7PhY5IMb1VErSmN8fZ2D9VdR6u8KES6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeevudejhfffhfevkefhffekteevgfetjeekuedtudeiheei
    geefjedtleevjeetudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:0zK9ZQSJTtAuUvblFYN6phK7C8jOm2mznvkWhJNbsZzXMiLzRGKiig>
    <xmx:0zK9ZQyzfUSFYDgIzpu9jZBByn_ZNgcsnbN8f4dfpBDW4WUJeKLVxg>
    <xmx:0zK9ZW6gWBDwuYIjVRaLSkKmlB--QEWg_sqGE_UEtmPuFBUw7T77ug>
    <xmx:0zK9Zfmgj5FFZ9xT09exWy85F2v_af88wPTolh0nDr_H6BEl6PQ2Gw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 13:22:09 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 18:21:45 +0000
Subject: [PATCH 6/8] MIPS: Limit MIPS_MT_SMP support by ISA reversion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-llvm-msym32-v1-6-52f0631057d6@flygoat.com>
References: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
In-Reply-To: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Guenter Roeck <linux@roeck-us.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=961;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=N59Bj8/WdhFntIwAd6AT31VUOMyxOe1WmRe/HYmvrls=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtS9RnvO13XHvSx4mP4hUsvI3d41drnz7bkC4T88Du/0Y
 J7/gD2so5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZS28fI8G1ujlNJ00vR6ZJe
 m47ujC6+98d0MsNBr1lJHw969UikMTAyvJ/zQDpGds+n1etCTS2Wv36tyKAQqbLl+tuDLb86GWR
 52AE=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

MIPS MT ASE is only available on ISA between Release 1 and Release 5.
Add ISA level dependency to Kconfig to fix build.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v0: https://lore.kernel.org/all/20230414080701.15503-8-jiaxun.yang@flygoat.com/
---
 arch/mips/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797ae590ebdb..c44358a6d93e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2171,7 +2171,8 @@ config CPU_R4K_CACHE_TLB
 config MIPS_MT_SMP
 	bool "MIPS MT SMP support (1 TC on each available VPE)"
 	default y
-	depends on SYS_SUPPORTS_MULTITHREADING && !CPU_MIPSR6 && !CPU_MICROMIPS
+	depends on TARGET_ISA_REV > 0 && TARGET_ISA_REV < 6
+	depends on SYS_SUPPORTS_MULTITHREADING && !CPU_MICROMIPS
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K

-- 
2.43.0


