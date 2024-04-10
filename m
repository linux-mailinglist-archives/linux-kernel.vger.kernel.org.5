Return-Path: <linux-kernel+bounces-138752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7245889F9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637021C215B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1916D9B4;
	Wed, 10 Apr 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F2WZ5N5q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ue1xY9Dk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3716131C;
	Wed, 10 Apr 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759483; cv=none; b=RfG7Lsr80bOr7yXCxtojbfW5wgjcKhAv5H8VX74Q3TPD61IkqtYQdDio2bnb6e9fSJdGj+mCo3YpVYnAttl4DIQcGNAtuvr5fl1YbD2kl1p+4Gtkyo5gq5weA11rQco6lyylLNjZuz8hhq8Amv9vmrW/Xv9Xh6rmnqaRa/Cf9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759483; c=relaxed/simple;
	bh=OGX5xmHt8QB4zrJj4PlvpFzX8zpWwHB+DHJ1mYOEqPo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZYedL3fJXmw59u1P9bJSxSjwIJIChio8k5NM0LizLKFbqCKqwdsfQj1PRomAVd3URngkPJL5I3TLVHr3nGdBSrkir/QQ8vdPrLSqbiE89xYYhvgWMtd9hf7PuP6CT+T/IDAS/4Wx1FKye1yV2ngdLpetvauHg2S00iBV0vFHk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F2WZ5N5q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ue1xY9Dk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 14:31:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712759480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxVO6IH2aKWgClrF7W/S2towoDPaWd3E2DJSD4+8qmw=;
	b=F2WZ5N5qQlnKKSeXgYTtBmsdvUXw2IwBS0VMZvXLtSY2zvQ09DIyswwZcH52FO0S5kfMPq
	9JdLaBjeB8bUKLK7/5f0/tFDKVSVy+aToobxJer3jkqmgs1+QpHwQMJjTIpmBsjA/HqSK8
	Ll+fMkqiWxW7j7Sc5ZEoiAGpM31zK6uWqRku1eTHESjB+HQ10ytx+7Vn3G52rbMJdU1HCb
	HJOIUrtkrsaNHKRrRf+RZ1wIKYUsQP6WP0N52Y2idv9Z1vGeWYyWFIp5/RTBcT1Drhsvyn
	vDC4sugs6OaLw9IjnWkhseg6HdQYTnfSNHDZUA3LJ00xyA0d5QKPsjmXAzDEDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712759480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxVO6IH2aKWgClrF7W/S2towoDPaWd3E2DJSD4+8qmw=;
	b=ue1xY9Dk6GYFvryU4dZFqI8uCAToeuYMjxCiVvlZwddN5+EZ3+fwxDlOu1rX/hx4r85Vs4
	NH5mRDTw6FBm6aBg==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Actually turn off mitigations by default
 for SPECULATION_MITIGATIONS=n
Cc: Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@kernel.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>, stable@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240409175108.1512861-2-seanjc@google.com>
References: <20240409175108.1512861-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275947986.10875.18301514121591592136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f337a6a21e2fd67eadea471e93d05dd37baaa9be
Gitweb:        https://git.kernel.org/tip/f337a6a21e2fd67eadea471e93d05dd37ba=
aa9be
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Tue, 09 Apr 2024 10:51:05 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 16:22:47 +02:00

x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=
=3Dn

Initialize cpu_mitigations to CPU_MITIGATIONS_OFF if the kernel is built
with CONFIG_SPECULATION_MITIGATIONS=3Dn, as the help text quite clearly
states that disabling SPECULATION_MITIGATIONS is supposed to turn off all
mitigations by default.

  =E2=94=82 If you say N, all mitigations will be disabled. You really
  =E2=94=82 should know what you are doing to say so.

As is, the kernel still defaults to CPU_MITIGATIONS_AUTO, which results in
some mitigations being enabled in spite of SPECULATION_MITIGATIONS=3Dn.

Fixes: f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240409175108.1512861-2-seanjc@google.com
---
 kernel/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8f6affd..07ad53b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3207,7 +3207,8 @@ enum cpu_mitigations {
 };
=20
 static enum cpu_mitigations cpu_mitigations __ro_after_init =3D
-	CPU_MITIGATIONS_AUTO;
+	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+						     CPU_MITIGATIONS_OFF;
=20
 static int __init mitigations_parse_cmdline(char *arg)
 {

