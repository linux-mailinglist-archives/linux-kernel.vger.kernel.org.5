Return-Path: <linux-kernel+bounces-129119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E09896538
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAC41F23CE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CBB5A0F3;
	Wed,  3 Apr 2024 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RriFMNIv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8bjeoJr2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5E17C64;
	Wed,  3 Apr 2024 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127597; cv=none; b=hcTYcwn3rA2/eLyEHdIIfBevr9AzuC3kahljnixeJRYyZXgJQehEhFW1PPGfjTTNzncvZ/Zog2ZOcQEgUMeBk/Its5qWm9DgfseWcIQwVHlWKeHKDTZjC3NBnZrE3YnqhB62/RutOAZxYsbTBFexzHnwGy6DYjS8AemjfBd1bBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127597; c=relaxed/simple;
	bh=zn9DBjaICBQPMV0B2OxKwA/vPD2hbq4XwG09W2UUBxQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jWnfPET7LQm8UpvP3EOnSHerQFGgmULOReo9DJwxbSjcRo7QwM+T1hBSVnHYRpMJBvpydyFjEfIfsGpoEsi3xp+vxRtLnqWvWW6iQsMdU1rP1Y6RyIftm1E5LSpgSUO9EUdYGsmxTxjQHVCnBxL+lb7yPSW/fNiFDp/0rXhNnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RriFMNIv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8bjeoJr2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 06:59:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712127593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4chSnUD9QYF/lQ0kqhGD43OJo+PDTEAz7FhJpuZl0g=;
	b=RriFMNIvTjRNQanBbFzbCgbOcLWEZvMENtGNywiDiOnE8zGYv4Ahum0AaU3yFQiVVDjRSt
	385XWC46S/H6xae24WwaFNl+y5mlg44zoi9qwmx0tCo21Dkg2CF+Gx04yZYmgVPQLBYfHs
	hVdwTLWHdGRmkEUHbs3EJOF4XamYxoxk5a1Q7pVFtENyVjqtF1blYEFrochcpQ3tee8YV5
	nzl0qR5lRSLlt1jqGBzArPLr4EjoaBPN5d26W8ZVIZV09H26tqoZeOcJBeS/7LRwcnRc/k
	ea6PQcJ1F5XXQYb7cHqtOR2DEFiBNMp/s3gaTSeQkk5nOwzbSp9F0g9EpxCfVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712127593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4chSnUD9QYF/lQ0kqhGD43OJo+PDTEAz7FhJpuZl0g=;
	b=8bjeoJr2przfEnSth6sNltRvRTLm/7VGpcpGRdZD72TXNF9XctOzX+b6HMcqdliThUkI9G
	mGv5IaiAa9idCUAg==
From: "tip-bot2 for Saurabh Sengar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/hyperv/vtl: Correct
 x86_init.mpparse.parse_smp_cfg assignment
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1712068830-4513-2-git-send-email-ssengar@linux.microsoft.com>
References: <1712068830-4513-2-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171212759282.10875.5340373336172340894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     fe5e6b599fbc417662c549c04d278a13098eb52a
Gitweb:        https://git.kernel.org/tip/fe5e6b599fbc417662c549c04d278a13098eb52a
Author:        Saurabh Sengar <ssengar@linux.microsoft.com>
AuthorDate:    Tue, 02 Apr 2024 07:40:27 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 08:46:08 +02:00

x86/hyperv/vtl: Correct x86_init.mpparse.parse_smp_cfg assignment

VTL platform uses DeviceTree for fetching SMP configuration, assign
the correct parsing function x86_dtb_parse_smp_config() for it to
parse_smp_cfg.

Fixes: c22e19cd2c8a ("x86/hyperv/vtl: Prepare for separate mpparse callbacks")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/1712068830-4513-2-git-send-email-ssengar@linux.microsoft.com
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 5c7de79..3efd0e0 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -34,7 +34,7 @@ void __init hv_vtl_init_platform(void)
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg = x86_init_noop;
-	x86_init.mpparse.parse_smp_cfg = x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
 
 	x86_platform.get_wallclock = get_rtc_noop;
 	x86_platform.set_wallclock = set_rtc_noop;

