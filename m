Return-Path: <linux-kernel+bounces-153776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C698AD2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FF31F21DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72FE155A21;
	Mon, 22 Apr 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xirwMpvt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HDQOyNI5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C315574D;
	Mon, 22 Apr 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805153; cv=none; b=aVZu6w0ePTOzZFzuYUB1fBsCScRTtKgIvu0z5795ZQa8vyF4TJoK2wc0lXNM16N+NClv0jHXoQVILQRlICahKblCJXqZo0tzWnupgUu6d0QBgvMUueLIoeaCezTCNfLcFE/zDTuBzeP01MboJo3p1eYwVlTMkPpe3jCxeeUaK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805153; c=relaxed/simple;
	bh=LfruV1Hguo4mvDNEJitoxYBqUeomvtwEh/ARyD1kwuY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mr7mNeca/Ipbb9YRmR0zwBNdzW0Zac4a6OUBd024ZW8kqpgN7GNfrVOrAaeumvgVE1u8phPl4OPZtCdm7Af1z3TgRI6HOYtri/HEZbGGTnCKnYuP5Fdgy9zGqKWDbSOSfJD11kuPmPjfwhieCUsE/fyVQC7r7EdxI985zNlwjqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xirwMpvt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HDQOyNI5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 16:59:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713805149;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4zvUu6nM9Son2hrQTKw+7zRLF0suhhHlCs6iZIU4Pg=;
	b=xirwMpvtQ6JwG2kHDPcH7q4oL8xBRRT5Z5c3gnIC8q7GfCyfN2/+YjD0TQaI5FgT/FhiQa
	bp1GXLIqt31PHsOCvyCNZuNYXmuwtquzWRx4Nc9x1bxIuDqkoV/LMWsjlpt70cYdfBVfNx
	+2Li4tCqeLkwoGc2Gs7MzK/VKW+JiRO+7g6/cIHVwc7Ye+kdbEY9hyes9avhe/i/FaLi3T
	7k4A1nut6tuVG39LpiK56ymKLZilATUm69iCO2oYtRiOEGG29l86rUeXFfx8DCUjfjOVvk
	0wKx8OkZNk32yB93mOQvgYgYgHBSCvWN5PllklcuGAmxFTUhk3IRlZtUXX75hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713805149;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4zvUu6nM9Son2hrQTKw+7zRLF0suhhHlCs6iZIU4Pg=;
	b=HDQOyNI5mFHV62Md0VP7mbKngTq/F1xUGBe6CEGx2lBLmplCkqFzuZYX3kaY0vyTnf345O
	9TTZfFatEYPN1KCA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Check for MWAITX and MONITORX opcodes in
 the #VC handler
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C453d5a7cfb4b9fe818b6fb67f93ae25468bc9e23=2E17137?=
 =?utf-8?q?93161=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C453d5a7cfb4b9fe818b6fb67f93ae25468bc9e23=2E171379?=
 =?utf-8?q?3161=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171380514854.10875.17134181849297868311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e70316d17f6ab49a6038ffd115397fd68f8c7be8
Gitweb:        https://git.kernel.org/tip/e70316d17f6ab49a6038ffd115397fd68f8c7be8
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 22 Apr 2024 08:39:21 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 22 Apr 2024 18:38:28 +02:00

x86/sev: Check for MWAITX and MONITORX opcodes in the #VC handler

The MWAITX and MONITORX instructions generate the same #VC error code as
the MWAIT and MONITOR instructions, respectively. Update the #VC handler
opcode checking to also support the MWAITX and MONITORX opcodes.

Fixes: e3ef461af35a ("x86/sev: Harden #VC instruction emulation somewhat")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/453d5a7cfb4b9fe818b6fb67f93ae25468bc9e23.1713793161.git.thomas.lendacky@amd.com
---
 arch/x86/kernel/sev-shared.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 8b04958..b4f8fa0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1203,12 +1203,14 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 		break;
 
 	case SVM_EXIT_MONITOR:
-		if (opcode == 0x010f && modrm == 0xc8)
+		/* MONITOR and MONITORX instructions generate the same error code */
+		if (opcode == 0x010f && (modrm == 0xc8 || modrm == 0xfa))
 			return ES_OK;
 		break;
 
 	case SVM_EXIT_MWAIT:
-		if (opcode == 0x010f && modrm == 0xc9)
+		/* MWAIT and MWAITX instructions generate the same error code */
+		if (opcode == 0x010f && (modrm == 0xc9 || modrm == 0xfb))
 			return ES_OK;
 		break;
 

