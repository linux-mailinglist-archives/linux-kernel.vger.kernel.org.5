Return-Path: <linux-kernel+bounces-67032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3832856513
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708A929198E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262D131750;
	Thu, 15 Feb 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4AqLrrz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBDB130E40
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005409; cv=none; b=CHJV0zFfHvLXGS3fQIesRjrknN4SIEhsvrp96BVlL8vupJprmGIo1mOIaoRozBG2JaNo3VXow9LL7aNZwM0+KtavmUdK/R08vohvURt9Yyizx0Q+I9NRG3lHAooROvJjJxUeBJghh0NXdURLuqpU0wg1HWgUIVLwBVTp6ZPN3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005409; c=relaxed/simple;
	bh=qBWtEN63pbVesMm5hww6R9br9/JobA0tAuObkHuLUXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hfbohh2KtEbYMoxbaxqydypuEz9LyX/sccgUpUDZMsDzDbgFHlkQZ2OTPDoxQTntcKo8LG22QccuH4yKgTpJszyMVrj3EJkswTZk8HNv59qFqjn8bDDTWmSepU34lAcVeq1NbQJfz1a6YCWDCuXjzLuGV03RPdcAnfocX4X9a4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4AqLrrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE390C433F1;
	Thu, 15 Feb 2024 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708005408;
	bh=qBWtEN63pbVesMm5hww6R9br9/JobA0tAuObkHuLUXo=;
	h=From:To:Cc:Subject:Date:From;
	b=q4AqLrrzexZRFDLlPj293Vmhn/u39Sg66pWfBvlH1WCVBKL8WuL7g8jMY5J7xzK+I
	 /q3vv7AKW3MKb7kdS9HduX3pxxmXv6QKq7UEyHnFylQXoYqgBB9mvkSDRtC2jo9DuJ
	 1VYgZLS2a7D6Od/4MM20j+qd8s4iRx0TZ04ZgFe2+t19O962qXDo5TNRTuhDwyBiOU
	 5kBK6n4Cof3cB7luf4PPaxZhrE4vLIeVivtu+UoOzaa1U+DjGr6HdcEdlQEm8thFq8
	 8eR+cTSgiUldx0KP2fMM9QqbzNzlmUXC7t9eQo5xwpvFzDGWF8m++BCV/8VXWjZDE8
	 nv3p2IeB8PJ7A==
From: Masahiro Yamada <masahiroy@kernel.org>
To: patches@armlinux.org.uk
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: remove unneeded entry for CONFIG_FRAME_POINTER
Date: Thu, 15 Feb 2024 22:55:25 +0900
Message-Id: <20240215135525.1909606-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is no-op.

FRAME_POINTER is defined in lib/Kconfig.debug.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v6.8-rc1

 arch/arm/Kconfig.debug | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5fbbac1b708b..7374483591f6 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -90,9 +90,6 @@ config BACKTRACE_VERBOSE
 	  In most cases, say N here, unless you are intending to debug the
 	  kernel and have access to the kernel binary image.
 
-config FRAME_POINTER
-	bool
-
 config DEBUG_USER
 	bool "Verbose user fault messages"
 	help
-- 
2.40.1


