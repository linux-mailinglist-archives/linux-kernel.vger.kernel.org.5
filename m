Return-Path: <linux-kernel+bounces-109838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D75885655
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CA71F21E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B33FB84;
	Thu, 21 Mar 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ulFLLQcK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FARYEc1O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4F1CD1E;
	Thu, 21 Mar 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012932; cv=none; b=lTWuNWJx755SSGcEB4JSy/Epo0U/jvcvuR/Ps0Ado2YcwFI9kadv58HC9hp4QxGRKsof5qaQ8RNAnPBlHpyfoB1e0U9g6EqOk60YA/FKF83rTioZtSgvIdvZqsDukptd50ZQ9L06e+0QMt6ZHUHnpbl/kzZOCLvvBS7OXECvoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012932; c=relaxed/simple;
	bh=RPht2ch2pRa6w9L3PgouqOq3OT5ai6spU8+fxi8gZho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q4k8sDecv2+SdOkcSchcbGpofi/MHg/Isthj+d5/kRIg8vBjtp7hKfcjTuNMumNlsxdwkUefEO20wrmbP7jqjH6pjrctiLRJ3nthWxlOAwy5DFtvyDX6YawnohUXRxzUTSpe60EECsCjqPiKhWWgwkPjbdfyIm8iaYR6mTNNw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ulFLLQcK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FARYEc1O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Mar 2024 09:22:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711012923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRFActHzVPQVdN9aGPZVJJyFBaZqG0Ziq8FEk+mW0uE=;
	b=ulFLLQcK3NYdNvhUYwG7CywNZfBFBIFsx6ES+oghAy8DlSYF6nQ1rgXTsPm2kGxBWHZ4oT
	x/66FOSmoaWl1L8CGF6ptT78I+VkhnOxgLEF8Fz26OqGr0FViJN/xpZHH2PGdsxummP0aY
	RUOYGmGplbN3/VibpbrWbpuoDWDgC4xxMYkiQXZKYjorEoYUEPr/NUBEyGsBk1bLzNm4Dt
	YgFSmCEmJyuhym11aEyMTNK3EmbbM1slcCjb5g/sE9WtDpfdJzoJ+DFHbT8hpBejwgU61S
	91E5vAPeIPaFFcGmXokW2uT+I5i4iNHQZQ05ltBGLUtaPQpBEDKTJ7VeViY1Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711012923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRFActHzVPQVdN9aGPZVJJyFBaZqG0Ziq8FEk+mW0uE=;
	b=FARYEc1O5Qw5OcBUMA5OtslTatwV806QIWCZyCfX+D29e1KUXyptNAS09d9OIJ4rWUJR6D
	hDrpRTfyDg7MsWBA==
From: "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/config: Fix warning for 'make ARCH=x86_64 tinyconfig'
Cc: Masahiro Yamada <masahiroy@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240320154313.612342-1-masahiroy@kernel.org>
References: <20240320154313.612342-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171101292246.10875.137354922823317813.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b0f269728ccd1d3cabcb6f3a5b610147d98a5dd6
Gitweb:        https://git.kernel.org/tip/b0f269728ccd1d3cabcb6f3a5b610147d98a5dd6
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Thu, 21 Mar 2024 00:43:12 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Mar 2024 10:09:41 +01:00

x86/config: Fix warning for 'make ARCH=x86_64 tinyconfig'

Kconfig emits a warning for the following command:

  $ make ARCH=x86_64 tinyconfig
  ...
  .config:1380:warning: override: UNWINDER_GUESS changes choice state

When X86_64=y, the unwinder is exclusively selected from the following
three options:

 - UNWINDER_ORC
 - UNWINDER_FRAME_POINTER
 - UNWINDER_GUESS

However, arch/x86/configs/tiny.config only specifies the values of the
last two. UNWINDER_ORC must be explicitly disabled.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240320154313.612342-1-masahiroy@kernel.org
---
 arch/x86/configs/tiny.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/configs/tiny.config b/arch/x86/configs/tiny.config
index 66c9e2a..be3ee42 100644
--- a/arch/x86/configs/tiny.config
+++ b/arch/x86/configs/tiny.config
@@ -1,5 +1,6 @@
 CONFIG_NOHIGHMEM=y
 # CONFIG_HIGHMEM4G is not set
 # CONFIG_HIGHMEM64G is not set
+# CONFIG_UNWINDER_ORC is not set
 CONFIG_UNWINDER_GUESS=y
 # CONFIG_UNWINDER_FRAME_POINTER is not set

