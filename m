Return-Path: <linux-kernel+bounces-71740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0E85A9AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E74287407
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B6D446BB;
	Mon, 19 Feb 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o+iLHWZ4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zzFnjUCt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F9374D3;
	Mon, 19 Feb 2024 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362967; cv=none; b=HvGwzdgUis4SmfJ8qpWs8Yw3/8p0JWiaseyjvWnWgwKsr3Y+aZSHNV2pB6meQhIMsXtip/jA1hYINQDNFtnDoNfXgZJHKTmrGYS+atwES2ByUemYU/BeDjoMbs51AUscpWquZWd+UniN6ZDtzCudX80m14OLIe6W6l5gRoM99U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362967; c=relaxed/simple;
	bh=ii4cgt1E3hEDo18xbhUscZeD0SUd3PhL42zCQYJSoqY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VsJROyrE4ozU8MQDPGLaM+NOwrBtzuTXNFeu6pIeTiOgNLtqW6TdOPNX8k3ND0QhJlqsurmWbcPaQUm7/gYQcXXAOnJ/w3g8cvPmxkC37hIYMMGbSb96X9+UEw6Tes1amuJyKT6AE4BxzUrctHUkvTcweP0+m4YgbmjN+j7Y68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o+iLHWZ4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zzFnjUCt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 17:16:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708362964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cq/bJydinATbNz9JhwbFaWM5CLzy2p99qxbRF0XWmWM=;
	b=o+iLHWZ4ZqJflLSPxvnPsQgcJyzKr+hgI0xHShkbgCPDnnxizoZZt2g+/2iiihKg8w6DgY
	NShRHFzYDSMzEvmwgrr2+sjNeem1fROZS50V1NIuDt6GBcv5QGB/VOIMAyqwLI84sNXYqn
	OZuQv3p1yOzCTPOlIzNtJjpQyc7b+vSSiVekend7g8AkYBqtcgsusZcEvpwo4ZERKvlqmu
	RZIW1J6fiEqzpUJ7rvDlGtCG+IqNwHeC4KoJKOqJkzeZowNc0dFdSqRwKcc2HswvDp2hc7
	6+PAfc7SHHdLLCb85btHoVRW+yz4WlidmwMPM1Yb3zUDLcaegzirJrVseI6DMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708362964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cq/bJydinATbNz9JhwbFaWM5CLzy2p99qxbRF0XWmWM=;
	b=zzFnjUCtxcxl4ZjG0kVIAbFbFSP3Ya5D6UVCd5sdLPdn1fgddft3V3cD7XY18N/+0lCKwb
	o/7/YXuozChWBTAw==
From: "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Make __smp_processor_id() 0-argument macro
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <0037d1f2-8153-4b33-b43e-f4b6ecd710ac@p183>
References: <0037d1f2-8153-4b33-b43e-f4b6ecd710ac@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836296349.398.972337790717931242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     b57b4126dd3bb69db876ae7b271307ab7e0458b9
Gitweb:        https://git.kernel.org/tip/b57b4126dd3bb69db876ae7b271307ab7e0=
458b9
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Mon, 05 Feb 2024 12:39:30 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 18:05:47 +01:00

smp: Make __smp_processor_id() 0-argument macro

smp_processor_id family of macros never accepted any arguments.

	#define __smp_processor_id(x)

works by accident (see C99 6.10.3 =C2=A74). __smp_processor_id() gets
1 (empty) argument and passes it down to raw_smp_processor_id()
which doesn't accept arguments.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/0037d1f2-8153-4b33-b43e-f4b6ecd710ac@p183

---
 include/linux/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index e87520d..cc51700 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -261,7 +261,7 @@ static inline int get_boot_cpu_id(void)
  * regular asm read for the stable.
  */
 #ifndef __smp_processor_id
-#define __smp_processor_id(x) raw_smp_processor_id(x)
+#define __smp_processor_id() raw_smp_processor_id()
 #endif
=20
 #ifdef CONFIG_DEBUG_PREEMPT

