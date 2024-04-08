Return-Path: <linux-kernel+bounces-135404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7FE89C0DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7431F21B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E184181AB1;
	Mon,  8 Apr 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQpagJeT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eD+Z76Li"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636080029;
	Mon,  8 Apr 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581847; cv=none; b=VjGuBUamBzBvtaqcIDsDvNEkliXtWYH44z6tsseyVQICQ+AgpLJzxS7fJgwlC0J/DIIFg0dHIrnBL7HVqrudHm0oQnwBcp9VR8eVeCQyPzr+CENnyMbKKK2XdjEEpkt7xoEfahpz72fx3Z2LZWzQp5hgrpFbSn5q9E9mGCGL2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581847; c=relaxed/simple;
	bh=BQ7PyoI725u0z3sCjDHso82ef/w4c8t+ud5AEItxvl8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sM5B4fRizF06rOO1MxrQOh2A+yKoWs4lpgsAkJ2FbmXGr1CmkBNfwTTBcuIJanr3WEQkrz+FQPQfiet0BdXSItcWqroaSvM5c+ze5J+3sHTF8s56aVBeKm1hehyPE+lZJTCruuxJu9EwjpOltYV+fLbeY1Y5Vz6jrcDP8H5doVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hQpagJeT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eD+Z76Li; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LC9sQXTLSbo0WGC9gc3QQQGsICOaWlN1GU1gt+8jlDg=;
	b=hQpagJeTeCLjVi1oyTlYhHkkaH6+8mxHq/w++Ntjow0Jql028cZfsY+2f2Emr/vE2qKXD6
	YjfCS4kKxijBzsy+RGBa/UPWfmF37qE2hQGpldLf9Z/RL1yvwuNZ/vwQk4Xhg5Qu8+hvb5
	nc9uELON14dOmUL0QzpT5r5tPGLiMms3MJG9fOsHFPFRPekALvDdwZw7eSZjZHn9TM25HB
	DNvxSTgUuCtmYoT09ZB/GlIKPkmDPq0HDK6Ox43i8NU/5twpcvRHWw55QebQo7XNvgZFej
	ndJc5FlkY5N0Z03aFdmvxEODrBKS1P5txm2WdE77NaGK1jNa0qI0Xsdt+3qr5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LC9sQXTLSbo0WGC9gc3QQQGsICOaWlN1GU1gt+8jlDg=;
	b=eD+Z76LifTM/mTdCW+HQY2n/wEu7+JWHYTuGyIsOOdLSDmNcq/fw9F85QE/wIPjXTCdssO
	ImuVOSc84RO9E4Ag==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso: Add CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-4-adrian.hunter@intel.com>
References: <20240325064023.2997-4-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258184335.10875.8126157733328789129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0c68458b0a5878d735572b4f4d91219a1db7c784
Gitweb:        https://git.kernel.org/tip/0c68458b0a5878d735572b4f4d91219a1db7c784
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:06 +02:00

vdso: Add CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT

Add CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT in preparation to add
multiplication overflow protection to the VDSO time getter functions.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-4-adrian.hunter@intel.com

---
 lib/vdso/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index d883ac2..c46c230 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -30,4 +30,11 @@ config GENERIC_VDSO_TIME_NS
 	  Selected by architectures which support time namespaces in the
 	  VDSO
 
+config GENERIC_VDSO_OVERFLOW_PROTECT
+	bool
+	help
+	  Select to add multiplication overflow protection to the VDSO
+	  time getter functions for the price of an extra conditional
+	  in the hotpath.
+
 endif

