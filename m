Return-Path: <linux-kernel+bounces-44316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B33842089
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4832B27D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54689605B4;
	Tue, 30 Jan 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hboeck.de header.i=@hboeck.de header.b="WS6HwZcH"
Received: from zucker.schokokeks.org (zucker.schokokeks.org [178.63.68.96])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B9605D6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.68.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608261; cv=none; b=nTuyWSzlx0VSHbPtM+ATsdd0ZShPVhLFBPZgKd9CmXVX8FTGJdFb39eJF2luzisnrZLqkAkNbJAp9IVNXFeMfKf6j9gx+PGMMmOLEUEXV5CkXyAkr7dkumgW++foLng4E/CEvue2A0ft9sBsiZ7RCgzq/ddTLqiy0edn/EIyhqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608261; c=relaxed/simple;
	bh=ZQRIYuoVdGBY3FYjM+SKKH2fMwbpdB+uPgmzsErs/zg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FTV/xxKYBWC+0MXes60aXdzsDCViZwc+tfCbqkN1dGfw0qr3ZKw9vcd+BSy3e1unrEih5F81o/0qSLxpWQ4jw559WEDta2U+BQar0JitZINtt09DLhFVMx47dFD3IDZYYldTL5xDPSX4rupKz8npScXbbCZ59OvzLpO4iX8/VKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hboeck.de; spf=pass smtp.mailfrom=hboeck.de; dkim=pass (2048-bit key) header.d=hboeck.de header.i=@hboeck.de header.b=WS6HwZcH; arc=none smtp.client-ip=178.63.68.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hboeck.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hboeck.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hboeck.de; s=key1;
	t=1706607945; bh=trYWNAUV0wSUcmXctj60BCLcFrht8FOcYWG35FtbyNs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=WS6HwZcHIOtytoJP+WpQ2LDHfPR3at5pFhpIMhqc/I7l3Gw8MUFWhAMMV3uxb68L7
	 n0EhK+TmQabxQwO6yXbiTHp5l00JC8aleaKudL7KvA4ljCk4gqTwiE+5bJSoAHhfHb
	 zMm6Y0bHrWYPl2voMpBGpUluPtNbpRFtITJDNm6wcrH8ugR5ZHB32oxYWYN5KBiTMr
	 yGAzyTsVeve+jremtgeVmdyuAtrrcRbidI/6CMDvDgqvBVBZCRKunfV+34xEtQzciB
	 gAMSSp9hi/aS5DzTUpGmJlTvklzoj1Q6oyECUvwgnLOFaFNKOwQy602FvT+KqHYT68
	 qGi/ANi/fUCag==
Original-Subject: [PATCH] x86: Improve description of IA32_EMULATION_DEFAULT_DISABLED
Author: Hanno =?UTF-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Original-Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 30 Jan 2024 10:45:43 +0100
From: Hanno =?UTF-8?B?QsO2Y2s=?= <hanno@hboeck.de>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
  dave.hansen@linux.intel.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Improve description of IA32_EMULATION_DEFAULT_DISABLED
Message-ID: <20240130104543.28840812.hanno@hboeck.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The description of the option disables a default, but does not mention
how to change that default. To make it easier to find out, mention boot
parameter ia32_emulation.

Signed-off-by: Hanno B=C3=B6ck <hanno@hboeck.de>
---

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec175b..a65ff33e0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3006,8 +3006,10 @@ config IA32_EMULATION_DEFAULT_DISABLED
 	depends on IA32_EMULATION
 	help
 	  Make IA32 emulation disabled by default. This prevents loading 32-bit
-	  processes and access to 32-bit syscalls. If unsure, leave it to its
-	  default value.
+	  processes and access to 32-bit syscalls. If set, IA32 emulation can be
+	  re-enabled with the boot parameter ia32_emulation=3Dtrue.
+
+	  If unsure, leave it to its default value.
=20
 config X86_X32_ABI
 	bool "x32 ABI for 64-bit mode"

