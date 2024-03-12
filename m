Return-Path: <linux-kernel+bounces-100408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EF1879712
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36305281E63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF66E7C0B6;
	Tue, 12 Mar 2024 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A1TfcKMx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ro1FAR2o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639E7BAEC;
	Tue, 12 Mar 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255816; cv=none; b=iMVEm7ofiEFYx6QIqOTsBzGqFKJbmt+l1sU8XKGw2Eev8NNymNk4o9IefRxYesJykNENi3zq5zMzGZ9Qil8e7BTIf82evZY+z/UsS1a2DOCYF8MBn60xkjxLJjffqfZZ5XDtDeRvI0Q2g68vc5E6DwxmcDF1claQK2Z5LSeEHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255816; c=relaxed/simple;
	bh=KnOxVm6KbqEFVEhejvOeQmbi9cQqkGesnu7vYq0PmMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J19OeesRgxSEQdFaqZDjYQa6hvj2+qGyGEn5A0DrJZejdS4PUvDcbQBluSuaUWOUd2ZKWG4XOaHLga8BjvuhZF6UxdWNRZ6fT3WXkV/w/sqEjnNOe9fU4j2wjXKoV3U36adilQaZeo3oWZ3XcGZfHlPmiGyUdnljGOPHhhRdhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1TfcKMx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ro1FAR2o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710255812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZWEEViQLUdKD5a393nUrHRyZIMhZZB3yU82rz2cbw4=;
	b=A1TfcKMxjIg/tNlC4y0cISDvknIoHkORMtgmRxJDR9rQulMWesPdJa1DJ3uX+IIjWi0g+R
	ZCkl4KPG4Ch7DofE/Ye3IKfNJTjhA2A2BvzBAXgYJKm6YD4cRT2WgmTIZ+/dk4Q0oV4o9O
	XgS0OkJi09S0Quwa4a1hUEfoDd14fJUV7ct80+tzeMd1s4pZTUdR3Kc6KLy2vSwPMbJqMG
	0AMDNh8yvpOsGQEYqh7hs+vCuJCLVjo3Esj0o7iyMpoeBCowC182+d3praSynsiS5EsUK8
	6FfbUGI2l03pR6ipVOTCrb6YNLRcEP3oDiIpK6E7ef31lFsNoNViYU0UsNVVBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710255812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZWEEViQLUdKD5a393nUrHRyZIMhZZB3yU82rz2cbw4=;
	b=ro1FAR2oU08rea8XXXYmZuiv2HBp5XzR5NP3zB7CwvlGR9xcyIZqxODA6bIhSQ6JGGr8AE
	pjzZhP7APc+58TBQ==
Date: Tue, 12 Mar 2024 16:03:29 +0100
Subject: [PATCH 1/2] kbuild: add host-cc-option helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240312-gcc-plugins-gmp-v1-1-c5e082437b9e@linutronix.de>
References: <20240312-gcc-plugins-gmp-v1-0-c5e082437b9e@linutronix.de>
In-Reply-To: <20240312-gcc-plugins-gmp-v1-0-c5e082437b9e@linutronix.de>
To: Kees Cook <keescook@chromium.org>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710255811; l=1088;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=KnOxVm6KbqEFVEhejvOeQmbi9cQqkGesnu7vYq0PmMQ=;
 b=tvbjzwBgHMA+r+to3wpCuLHallidb62UnQ2iFbuGJrbyjfaCiShxCmChYObFcjA9XIIuux2vk
 L+gNh1MLCSbAGDXnoJZ0KskCAh8PCVOCQbfGB3FpfMFco/DTQHYB/v/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This helper works the same as cc-option but for the host compiler.
It will be used by the gcc-plugins configuration to check for the gmp.h
header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 scripts/Kconfig.include | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 3ee8ecfb8c04..84368e23b072 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -27,6 +27,10 @@ failure = $(if-success,$(1),n,y)
 # Return y if the compiler supports <flag>, n otherwise
 cc-option = $(success,trap "rm -rf .tmp_$$" EXIT; mkdir .tmp_$$; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
 
+# $(host-cc-option,<flag>)
+# Return y if the host compiler supports <flag>, n otherwise
+host-cc-option = $(success,trap "rm -rf .tmp_$$" EXIT; mkdir .tmp_$$; $(HOSTCC) -Werror $(HOSTCFLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
+
 # $(ld-option,<flag>)
 # Return y if the linker supports <flag>, n otherwise
 ld-option = $(success,$(LD) -v $(1))

-- 
2.44.0


