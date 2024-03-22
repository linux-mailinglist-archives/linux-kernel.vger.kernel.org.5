Return-Path: <linux-kernel+bounces-111330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DF886ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50D01C21EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D83EA66;
	Fri, 22 Mar 2024 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ik9Zah+7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/RNdkFw+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE23D3B3;
	Fri, 22 Mar 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105102; cv=none; b=bccIOpG6sfLQfeWUITldQ2YG0S/rPYtTv9L3V4y8z41VANzg/2XHN5/QiGnA/Jli2ijU6t6SFXBoO3OJsupS8oK0907YzHIA7aSCCD0dUvNwFHUQPFergFeFR1oYRH507bQIWTphkayt6xJbZGb9ucCLSm2vDMpRuZQcdBIYHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105102; c=relaxed/simple;
	bh=bdYqEOUgGQOFTC0ng8IyJMq8IevP2WQ40Wgm+34KZS8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B+WWXJA+UiSb5CsmtpFGcWTJVrNHuJojEuLEh7jkla/wsTkyTnO0imKTjrjFl5sp5bG6JbS1PKtydbVuSmqtlZf4DN+ATP7T2E4w5nepRRNrzaPbTnHb7rcSDVL2/wtdg2GyQh31JbNUbOHO4/idjGKcBpLErmBjtgcjqaMiJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ik9Zah+7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/RNdkFw+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:58:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vSE20350aNMrlyxd2H7klULSmGHs2wP9+WBwpsWw7k=;
	b=ik9Zah+7RdPz7Z1EFmMc/K8F3bDmVYDfSgmfi86Fn2cSRHv1NUFz8/KaIzY8xhFGtJ4Jom
	aQKFCtkE/cb3xMCDQf+BGof0lLprtBYlrS7wZNuxWzpvhykhVOTUBUZxBQbNLx9oK/RLzJ
	GsmNtcDyU1CijAoGWQysqtfnam19JDvUG7x7h6xIA1HKc3+TZJ9nIDkukyy4AlY9gfIe6K
	+Sx42WWcg7BaoiSuCUuWiXIzHqbaYE/kC728AhpANv3YDCDq1t/OclXYPHU062V/JSMT97
	JWPqs9s4bHxvMOPd95zLlBVycKtu546NDm1+nOxEbqEfH6s8EbzrVooIavyFrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vSE20350aNMrlyxd2H7klULSmGHs2wP9+WBwpsWw7k=;
	b=/RNdkFw+dz4x/vmtbZiYeFwdV/8tev3O2f+aEy3oCKYgKCdp5b5oGvfGSBz6GzOJOKfvD4
	OKsVZMa9SN+5nrAA==
From: "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] x86/kvm: Make kvm_async_pf_enabled __ro_after_init
Cc: Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240313180106.2917308-4-vschneid@redhat.com>
References: <20240313180106.2917308-4-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110509250.10875.15729351381723382749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ddd8afacc4f65a01204d7a36b8fd96c908e9b72c
Gitweb:        https://git.kernel.org/tip/ddd8afacc4f65a01204d7a36b8fd96c908e9b72c
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Wed, 13 Mar 2024 19:01:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 11:18:19 +01:00

x86/kvm: Make kvm_async_pf_enabled __ro_after_init

kvm_async_pf_enabled is only ever enabled in __init kvm_guest_init(), so
mark it as __ro_after_init.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240313180106.2917308-4-vschneid@redhat.com
---
 arch/x86/kernel/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 4cadfd6..31a48ba 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -44,7 +44,7 @@
 #include <asm/svm.h>
 #include <asm/e820/api.h>
 
-DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
+DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
 
 static int kvmapf = 1;
 

