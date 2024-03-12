Return-Path: <linux-kernel+bounces-100409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F5879713
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAF8281EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285797C6C8;
	Tue, 12 Mar 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vTVRBIBj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1X+np/yD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E97BAF6;
	Tue, 12 Mar 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255816; cv=none; b=R77IOLwNMD1rjnQylgUu87CfKYnI03/ReVJlQ8PBiXSBnFwcx5PMebedR1BQ6Jn4AtmIQ43N96/S3rUO+OHHuTnfieEnFuFFvMomjSPTiVImHLzhB+mQivLUXDZgg4aAl6vBQAPrxuHCKmnAb03iDUGnSjrUaJo1NkvGkMvUbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255816; c=relaxed/simple;
	bh=TcxH0jrVy0D6HM+7vL6WapyAgd3uVKWanz7kOcNypZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ro5CqJwfdOxs9UJwMtmaGh12sKJNacO/Z84Mvh3DmqSniky7L9ZXWJHelBuXtCHkOhD0LJgbAJ2VhuH5b8rIv9eWvKdvZarmS7NVOegEpZia3cnOEALu+YAcm/FdNvceWoHB/+Ac/fdi804XfzctLMJrYl4GvyW5YdG9cE6xImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vTVRBIBj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1X+np/yD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710255813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+iYqjfIE0bdUlAp8TcPV24ADFNBzMPbm85EoHAvJgM=;
	b=vTVRBIBjycadCGKN6Yf8fQHPzs1MvhF9heom8D/ADl+k5nud17hDLuobNWMwfKv9gQjJtq
	izHD3z+5B/f0Oh4OGhIv9YilHzmO/cUmdWwhBwYnSl5yzTCXthtiWTMehVEHm1Pq6oIMLw
	AjQTJEnJFcdlrbChriPb3sRb6jgclY9hJ/hNOA/b16FGmSejqCQzasmjk4KxYV7g5yns62
	NO6llYamDd8dLose3SzzFMgDTrUBTtxnXZhk28UfX43rSkF3eU4UK3yO/5SZvNgRNNlcwI
	VqOb/SFttAXsQq+FqHuF+xWNZCtD/r2SNEWK2w+c/3a+96XnAb1WHGpdhbh4dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710255813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+iYqjfIE0bdUlAp8TcPV24ADFNBzMPbm85EoHAvJgM=;
	b=1X+np/yDR5nn5cZS6MzyrGrwsOngCcGR6nrQSBj+ketGVJgMuiiARZP2bXpnboAFuEfaAM
	q7bE+D8HMQOoirDA==
Date: Tue, 12 Mar 2024 16:03:30 +0100
Subject: [PATCH 2/2] gcc-plugins: disable plugins when gmp.h is unavailable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240312-gcc-plugins-gmp-v1-2-c5e082437b9e@linutronix.de>
References: <20240312-gcc-plugins-gmp-v1-0-c5e082437b9e@linutronix.de>
In-Reply-To: <20240312-gcc-plugins-gmp-v1-0-c5e082437b9e@linutronix.de>
To: Kees Cook <keescook@chromium.org>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710255811; l=1265;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TcxH0jrVy0D6HM+7vL6WapyAgd3uVKWanz7kOcNypZo=;
 b=7RerVu3xGGXTy2AlyLsvG1WEgFjAlA8jBCMVP3Or/JPpdSYWiEw70aOLifyuYqexe+BQn/R4X
 36UlLDa55SzDQQpaYEtq+YGL+rBCixy/vCgfFmbNaeZwrKwUWvQ0FfX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The header gmp.h is meant to be picked up from the host system.

When it is unavailable the plugin build fails:

In file included from ../crosstools/gcc-13.2.0-nolibc/i386-linux/bin/../lib/gcc/i386-linux/13.2.0/plugin/include/gcc-plugin.h:28,
                 from ../scripts/gcc-plugins/gcc-common.h:7,
                 from ../scripts/gcc-plugins/stackleak_plugin.c:30:
./crosstools/gcc-13.2.0-nolibc/i386-linux/bin/../lib/gcc/i386-linux/13.2.0/plugin/include/system.h:703:10: fatal error: gmp.h: No such file or directory
  703 | #include <gmp.h>
      |          ^~~~~~~

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 scripts/gcc-plugins/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index e383cda05367..a664fb5cdde5 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -10,6 +10,7 @@ menuconfig GCC_PLUGINS
 	depends on HAVE_GCC_PLUGINS
 	depends on CC_IS_GCC
 	depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)
+	depends on $(host-cc-option,-include gmp.h)
 	default y
 	help
 	  GCC plugins are loadable modules that provide extra features to the

-- 
2.44.0


