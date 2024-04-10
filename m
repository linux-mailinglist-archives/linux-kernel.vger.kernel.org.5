Return-Path: <linux-kernel+bounces-138543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0531289F32E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43AA3B274E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8E15ECD1;
	Wed, 10 Apr 2024 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0wMcmEqI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8IQ/LgL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4415B568;
	Wed, 10 Apr 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753484; cv=none; b=auux0gn/2s8N+Jeo1wcS6LWllT/raGmDM3suK3iFg+pc3TG2sRFnjHipESoc2yXDx/arvZHh2cgNu+xOybsDSd5HHnS0oBFz9Gh+EYqsDsRge2gIvcIxbBrMrUvln/IW4RsnrJINEcEbgtfBO0jqajlvMsn5icbtD/dU120mKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753484; c=relaxed/simple;
	bh=dfET7XXzYYU+yzxfACXrhOWM08LglU4Ve5vv60oK6aA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OTrGFGRjSZexysZGp2Ki6bSZzp3BhW5JRuPVZDU64mh2T2IVtom5CxKkAArGK0XMerZhlnx7uoSCo71PU2TmG1RFGBdOaziaqbIpr4P0U1zKkBP6FwiyvUbQODdhUIxF2MkqeCXYvWRYJ/Din6mUgrT4+8l3J8bbREXOGfoUQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0wMcmEqI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8IQ/LgL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 12:51:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712753480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWzJ2kD7h9F7BnT4FS6HAf8LyVlxVB2anCHRyyyrNoA=;
	b=0wMcmEqIVYuxMN7WlIsSBtM2dlngcBMhKQIUxuGqblyHxLP2oElyX2FiL4RASPc0rL0H8S
	5/O88bDeL3RvyKARSLGv4mi9bakvQQjH5KU2SZ41/kNPBuVb/1RExltd63TC/Rkyc0geQT
	g2p/9GDWCRvaXpj6XFQ0Y89zPsY5IPHEpCiFyR8jlEPsOUktpoBsiVGTGowTSuv53yv2OR
	hmzVG4+/ulU9JqdM3N2Z1SOq/IdX789HCbwX35qnLGVjCihE0lUgWeE7AVhFofG8fzybXj
	rvqvECDUV7tbnYDgltjJWlIQSVE/VCvymF0FUu3KcSGJ3FwEU8DNCtCmjYPKOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712753480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWzJ2kD7h9F7BnT4FS6HAf8LyVlxVB2anCHRyyyrNoA=;
	b=s8IQ/LgLbRk9GBehUvT1smvqUAQEge2F06UG0Dgbi7BHRStWcWvER78yPHuOB42yFGRfF+
	fkwyW3BEr46SFdDQ==
From: "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Add support for Intel Lunar Lake
Cc: Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240410124554.448987-2-rui.zhang@intel.com>
References: <20240410124554.448987-2-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275347987.10875.4222928422673828343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     acf68d98cae8a60dc4af2e9feaaa799bf0aa5c04
Gitweb:        https://git.kernel.org/tip/acf68d98cae8a60dc4af2e9feaaa799bf0aa5c04
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Wed, 10 Apr 2024 20:45:54 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 14:48:18 +02:00

perf/x86/rapl: Add support for Intel Lunar Lake

Lunar Lake RAPL support is the same as previous Sky Lake.
Add Lunar Lake model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240410124554.448987-2-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 00bb6ea..ca5f687 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -808,6 +808,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&model_skl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);

