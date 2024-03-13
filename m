Return-Path: <linux-kernel+bounces-101365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B010087A604
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44564282CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA023E497;
	Wed, 13 Mar 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/hNjN6h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGJemZ87"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDFF3D0DD;
	Wed, 13 Mar 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326403; cv=none; b=oAPRe1uot3a0D55K8ldl+PpTH5G9ejJ3BvqpmWyXj3lrUDnucTQrJUmEkpEOpfu4z/kP0ptwyD8CiFi6N39N/98g54yLdqrOq+SfXkJRHEKf7KZ9RI7upWtaODwa3ZgC7C9UK07jZOsZEVzZdvIfqsTJwqXibmRBPOIfd9HbZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326403; c=relaxed/simple;
	bh=K8IgWJWtrQgOt0ZNFIQiSQNwkZV5nOleywKIjX13Tgo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PLiw5ieO448eggDX8g5KZEoGAmqJJwNArhTedobAl5LCXhM3CxsGqf06CfEGNt1d1TY2WXBafWw0wDwmFReByEYE7mie5Th9QokjVuu8zM8vPIuAageTYhvbUAvNSpqJCSRkpqg+FmldT4F6cimA/P8XInuePY6Am4X7ABRaT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/hNjN6h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LGJemZ87; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 10:39:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710326400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c22LIx7z/GfZ+HHdhWk7HpYjXoheZgNrRHj+xlyKzY=;
	b=0/hNjN6hxGcgxd5ye44MK0c160ZtLywXjke2F8sW4AsdQ+bKXAKMgzblRx+XyrWJJVbNF0
	RgR7QR77n5WzJqjEhRF62yhuo/bVt/p5tyBtvpUUhM143z0Lyq6GKiCGCrgsrHuMAtvYjB
	kBNhkvmMmNPZ1Nvlex8xrnA3uRIxo4eJ/jdYPyETArNfEGgYgCtPBnEmzPrnNtRVUYwX/F
	ktf6tyDuo72wFj0uafK9QoQgLTn8zzCDuLt3NlFOlaSFE4ykVAtPYSrwW9wY1GKID3H4KZ
	3RcYNwQbR+fbeEOLSrxoNvi96+2Is/qDfxGH7whtWpqg50eNv2QhHmrBdB9yNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710326400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c22LIx7z/GfZ+HHdhWk7HpYjXoheZgNrRHj+xlyKzY=;
	b=LGJemZ87bWLpLAt0QPAtR+Oj1yWBD8xinBXK2cFwDoU05vx2GkbNNPLkOYkVn3y8BuKtQr
	AmwcOAeiqGmKwCBA==
From: "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] vmlinux.lds.h: Fix a typo in comment
Cc: Wei Yang <richard.weiyang@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240313075839.8321-2-richard.weiyang@gmail.com>
References: <20240313075839.8321-2-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171032639934.398.7895133639224509934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     1793f69326266269a8117d3f5324ac78db18931c
Gitweb:        https://git.kernel.org/tip/1793f69326266269a8117d3f5324ac78db18931c
Author:        Wei Yang <richard.weiyang@gmail.com>
AuthorDate:    Wed, 13 Mar 2024 07:58:36 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Mar 2024 11:29:10 +01:00

vmlinux.lds.h: Fix a typo in comment

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240313075839.8321-2-richard.weiyang@gmail.com
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5dd3a61..514d300 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -3,7 +3,7 @@
  * linker scripts.
  *
  * A minimal linker scripts has following content:
- * [This is a sample, architectures may have special requiriements]
+ * [This is a sample, architectures may have special requirements]
  *
  * OUTPUT_FORMAT(...)
  * OUTPUT_ARCH(...)

