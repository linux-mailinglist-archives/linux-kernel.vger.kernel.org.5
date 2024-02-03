Return-Path: <linux-kernel+bounces-51146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B394848715
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD631C2157C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED85F48F;
	Sat,  3 Feb 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QGqG24Wv"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376655E70;
	Sat,  3 Feb 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973749; cv=none; b=E5Qgh8NzYDx979b5S4WbxirX9atL2W2ibnu4iU4AYveYoUDBs1cg1kJTLg3sB1dHXOLgOmAFkmqMlc/Cc/2os4joimuidTIaC61217iAIoXJr0v5rZt+V3FjqNLhHS1G5CfBHyBo67r62SGAFHzLHcK2r4kF16Fyua1wuHSF7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973749; c=relaxed/simple;
	bh=c+Jc4BAS+IryDupflpvWK9nQ/pkuVv+Flzsyr7rEEDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t19uylTRv/yNx35kajZ4VaP7jhRNOVQbzG5dBI29XyWPT0bcuW00k2cF9yw2TWxwRuP38OIB7J8QAEGXJWqG3NemqLKUNn6xYhyhNsrWXAm9ay8/1Ls56gXNzEoEgq3LrxAYKgAq39+K9FhBvBK9fjX/wLkuv/m6J9YYFlVBQvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QGqG24Wv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=j9K/vax56e3sCnb71UIU5Gz4B8feV2qAX5/Vur9/dM8=; b=QGqG24WvpulgcmjYWeP8Fzj7U/
	IDQyV210c3AwnZgQSuytBZ8xpVsTGWSJ7OKnfCWF6MzQD65aautSRsr4vcTcPBP1lnF1s9HZ2yg5W
	veng2shFrLwq4KM5wmQ4c5HY1YQV3z4cEmzp5IGQv9rxhOHMjaXeKHUaAnUh84TLin29RxETU+W3Q
	V7jDq/T41zpRwMhWr/6RiucZo5uZXV3x9Lw29Wx63CkLQifvwWH9Df5cct3cZ19CrUxRKBpAnDsAj
	QnmnmrAMxGPnQ+pz8gO65O5q22jYQ9bGzBvISh11tdCpVn+PrKwTuoBlnmDx3goLsIWj8HWmu5bXt
	ztzRv2CQ==;
Received: from [187.90.178.235] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rWHqP-00DJoe-Vg; Sat, 03 Feb 2024 16:22:14 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-doc@vger.kernel.org,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	rdunlap@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH] docs: Document possible_cpus parameter
Date: Sat,  3 Feb 2024 12:21:13 -0300
Message-ID: <20240203152208.1461293-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of possible CPUs is set be kernel in early boot time through
some discovery mechanisms, like ACPI in x86. We have a parameter both
in x86 and S390 to override that - there are some cases of BIOSes exposing
more possible CPUs than the available ones, so this parameter is a good
testing mechanism, but for some reason wasn't mentioned so far in the
kernel parameters guide - let's fix that.

Cc: Changwoo Min <changwoo@igalia.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..e553740190ea 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4644,6 +4644,11 @@
 			may be specified.
 			Format: <port>,<port>....
 
+	possible_cpus=  [SMP,S390,X86]
+			Format: <unsigned int>
+			Set the number of possible CPUs, overriding the
+			regular discovery mechanisms (such as ACPI/FW, etc).
+
 	powersave=off	[PPC] This option disables power saving features.
 			It specifically disables cpuidle and sets the
 			platform machine description specific power_save
-- 
2.43.0


