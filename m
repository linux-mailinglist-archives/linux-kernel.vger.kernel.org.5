Return-Path: <linux-kernel+bounces-112561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BC2887B85
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591101C20D76
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA041C05;
	Sun, 24 Mar 2024 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eI3RipZj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EsyN9eEK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247B1A38C0;
	Sun, 24 Mar 2024 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711250159; cv=none; b=Mt9cjKsorCRc5/OQuE8xfOVNHKffsIS6LxGPD8YDnCud40kIQnrJrADwgBHEjw54VqwaA+rpVwAtg6C6Rf1TEGjnfZCRjoSnutd4G+6jJtSk6kRKbQ5OZijatpFSJrQcNs/x/vaYrQQ4F+OXOrU7LO42x4CyaJia1nbLOaZv1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711250159; c=relaxed/simple;
	bh=7ZBX6Ipsokt2J0+u4CS1Im9O1JQpfTSNj+mIYpc4+D0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IRFeEBU30AK97QzFkyOB5Boj/60QAIRiAREkNY4nOv0JRCW+X5vs8UyJaeyMzQSdFPxG9kgpDXpb0ABsbCtkiuHNPxvjGObzfEQjZChvVMX7i2VShTDZkC5XU+dZyuQdKqetBhsNI7oWnE0l+NHm8cdDmgkl0dgc/jpw9qQpCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eI3RipZj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EsyN9eEK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Mar 2024 03:15:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711250156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmG8Mc6x8o3YIVtl1ARbKhjSiByJazy9Unmg1nXc+ck=;
	b=eI3RipZjeA2KMMEyg7GO8QVlmvIdG1blMuu5VUFrc2ONanvyMXeAp3gLRKhKCzjtx7OQhB
	SSIuyBUye1uO7G971HDaWufMBcTXR7F+zOb/zfl2KLzv+x1oAZBHckPEOYqKh1kOktWL/N
	dahCJWEF0vYZJlxp0gEfJZDM9Wzwpj+17F0HAMbrEvnkxP1qDqvTEXdy5f9HRhCFvedv4a
	Ig9ubPvzF//U+NC2wIAGI4HuGU2WMsljvw3VS6FVYMWOM2lpc1Ualk/yxPq3GajLss5JqA
	M5npvQNjAMz6J5ubOBkwN3j3B7wFitne01QbBHEdTiw8V0/DzoLly3lIY0SVnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711250156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmG8Mc6x8o3YIVtl1ARbKhjSiByJazy9Unmg1nXc+ck=;
	b=EsyN9eEKoB7E4K+8r9VceWShNYS1s/osYW4WdMVU5nACG3QXVsMM62fI0mFfJNRL+6V93K
	S4HNh0awVs4Se7Cw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add model number for another Intel Arrow
 Lake mobile processor
Cc: Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240322161725.195614-1-tony.luck@intel.com>
References: <20240322161725.195614-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171125015493.10875.7368068973475455963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8a8a9c9047d1089598bdb010ec44d7f14b4f9203
Gitweb:        https://git.kernel.org/tip/8a8a9c9047d1089598bdb010ec44d7f14b4f9203
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 22 Mar 2024 09:17:25 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Mar 2024 04:08:10 +01:00

x86/cpu: Add model number for another Intel Arrow Lake mobile processor

This one is the regular laptop CPU.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240322161725.195614-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b65e9c4..d0941f4 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -127,6 +127,7 @@
 
 #define INTEL_FAM6_ARROWLAKE_H		0xC5
 #define INTEL_FAM6_ARROWLAKE		0xC6
+#define INTEL_FAM6_ARROWLAKE_U		0xB5
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
 

