Return-Path: <linux-kernel+bounces-39381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035B283CFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA761F24F23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB140134AA;
	Thu, 25 Jan 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgU9vfu4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFF12B82;
	Thu, 25 Jan 2024 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223362; cv=none; b=dmncPmx+6vzxGGsSaJEQjH81Nlp2MYTiHvSdONEWVYGwdGrYYKuu3AjUnGbCyYviDJYa8LBun9wXLZWcM6UxAMGzhu135xGv8wTQ0BMqZ2lNIXJYnyAhHxa5TS+HHTWr0azlOj2AYmvBBEH1+uOh0CVCbrx/Xahtp7sMMt9Rmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223362; c=relaxed/simple;
	bh=x+4g7ReKIyIJhKSP2GxkvPMFHG6lRsI5FMdClkdB74Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbvrhjpQfi1yL4yUPwVwPU9I8TEqT5cOm6E56rS2i4MrEF0N6SkNAIDWCigkHCEqpnmYeaE+mYcPBaTMy8P8uluell4fz1D6ah2Uaw1ywZTqEaiNHpXrc/Y3BjOWj4i3hvbRHh7N4/d1MOf6MUDcW6OU46sgaGtRd0LEzJu9Dro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgU9vfu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432E6C433F1;
	Thu, 25 Jan 2024 22:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223361;
	bh=x+4g7ReKIyIJhKSP2GxkvPMFHG6lRsI5FMdClkdB74Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fgU9vfu4+B4cCQZXLwrhFaJz6b8A7tcRqpefZZ9ZxvBFAMI9fO5YKJzUHMYaUkMXA
	 HwVWj2DByzwsc24TzMYueqZ9QElJH/Cg6wWWHzfAGMcZ6SwSMT6Vt4zjqfvkYM+6vg
	 3F8ETTbtM/+IOn/AmpjTahJYmmikwMuncnD/pWt1YOZn52e20MGkuSLJMsglw1IjMn
	 vsLZtOcl9xgSS5kTnHMbESbzJp+NItxnyi4FbM3/9R9kQNHvoPmOWnP0KpcrsXrmC3
	 ck9xKFi+lorRWWZDoZoNhzBjR6etzWXRWfnBfAndh2x5bLcO4HaFH/Byl+4mhlcRpQ
	 xFfBOtB2ukNUg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:08 -0700
Subject: [PATCH 02/11] Makefile: Drop warn-stack-size plugin opt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-2-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=nathan@kernel.org;
 h=from:subject:message-id; bh=x+4g7ReKIyIJhKSP2GxkvPMFHG6lRsI5FMdClkdB74Y=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv1Nn3/9RZHdBf2F3tzsU/YddA8PPvLFXml2Xu2Ub
 7OfNoqod5SyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJFO1mZPiuFPdsYf+K2Tvm
 JE/ftT6q4szlAo+jn+usZ75rfFpmH+PP8FeQPbb8qegslwDBE0qR4a/XLpTJXGjTf32mQF3CT+Y
 QRn4A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Now that the minimum supported version of LLVM for building the kernel
has been bumped to 13.0.1, the inner ifeq statement is always false, as
the build will fail during the configuration stage for older LLVM
versions.

This effectively reverts commit 24845dcb170e ("Makefile: LTO: have
linker check -Wframe-larger-than") and its follow up fix,
commit 0236526d76b8 ("Makefile: lto: Pass -warn-stack-size only on LLD <
13.0.0").

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Makefile b/Makefile
index 9869f57c3fb3..885b2940e20d 100644
--- a/Makefile
+++ b/Makefile
@@ -951,14 +951,6 @@ CC_FLAGS_LTO	+= -fvisibility=hidden
 
 # Limit inlining across translation units to reduce binary size
 KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
-
-# Check for frame size exceeding threshold during prolog/epilog insertion
-# when using lld < 13.0.0.
-ifneq ($(CONFIG_FRAME_WARN),0)
-ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
-KBUILD_LDFLAGS	+= -plugin-opt=-warn-stack-size=$(CONFIG_FRAME_WARN)
-endif
-endif
 endif
 
 ifdef CONFIG_LTO

-- 
2.43.0


