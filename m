Return-Path: <linux-kernel+bounces-112559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEDB887B82
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2425B1C20C46
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7891C02;
	Sun, 24 Mar 2024 03:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3bK5VAlO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OB8GVwkw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1817C8;
	Sun, 24 Mar 2024 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711249642; cv=none; b=Tj5zpqUgA8uhMlb9YLbyrmNwNGxiTasTQqlwBAvYdqGm6wbsRiA95GBvPvpmG9aQLHC3kRvSXozzq9c/dvoabcVL8U1ir4Um50yiJbCUWPjpFsoGuYT4WencgLWQT6gojxbKGFrtJdiHvc2/yTrzOyGzAqWVGCKbtApromQr4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711249642; c=relaxed/simple;
	bh=8SqvdGYhJHvygOI7smYCwc3G+VPv6sH4BF+CBTZjXrw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GENtqvPF7/k6l/yzGhcQ9y1dQN5uXZ8yIg0Oov+RBnx5F8BZbQthXm0lXTuizC8isAO9HpRr036b9t+bVwaD2aEUem4/pp4LaxyOpJBl1C6ak/jo0lEbSaYU39IljJRSOKl155cJ9uaCJJqFWTHDRZ24u9+W/BZZMI9FJdkZiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3bK5VAlO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OB8GVwkw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Mar 2024 03:07:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711249639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7BXDn66DR8wcemUgRzv2AAibAH17t9P9tPvKM4Ia6E=;
	b=3bK5VAlOjluwX4Pc7rgvD9tor2Ta/U5t5lymekGba0Ju4Qp/TY3frgdzy+1KAPSnehBH+m
	nj4JJfDaSyrSs4ZwTSMg3BzL9Ygciip5ThUahkNPlldoAJ2FZiGsV8mC8bCNMO1JoCG0iu
	I0pH4amB6rN1rvaTcPiTCB2m6uZFJWNnluiTUssEuaOUunvF6hlZ6dEKCgncO0txnjsswS
	OeoMW/yCc/Gvjsr5RCmPv2ZDEwlEzvYe+sEk1Bob44zIhtMg5u4Cr6iggVBbVs/DTiYb73
	sfLxfP9vXsCrL/LV8upShQrR/Dx7kGATSOHluokxmyjzuN2Wczhm/KSd9PliwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711249639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7BXDn66DR8wcemUgRzv2AAibAH17t9P9tPvKM4Ia6E=;
	b=OB8GVwkwUNxpaDnFpEmjTspGKapSyy2EN9Cj8wJ2Lvmp2VnrXtd8zQEBTLmm4HgY2fk0r4
	DPi+/xcQ5++gGHDQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Documentation/x86: Document that resctrl bandwidth
 control units are MiB
Cc: Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240322182016.196544-1-tony.luck@intel.com>
References: <20240322182016.196544-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171124963792.10875.12035829539103388690.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a8ed59a3a8de2648e69dd5936f5771ac4c92d085
Gitweb:        https://git.kernel.org/tip/a8ed59a3a8de2648e69dd5936f5771ac4c92d085
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 22 Mar 2024 11:20:15 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Mar 2024 03:58:43 +01:00

Documentation/x86: Document that resctrl bandwidth control units are MiB

The memory bandwidth software controller uses 2^20 units rather than
10^6. See mbm_bw_count() which computes bandwidth using the "SZ_1M"
Linux define for 0x00100000.

Update the documentation to use MiB when describing this feature.
It's too late to fix the mount option "mba_MBps" as that is now an
established user interface.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240322182016.196544-1-tony.luck@intel.com
---
 Documentation/arch/x86/resctrl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a6279df..3712d81 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -45,7 +45,7 @@ mount options are:
 	Enable code/data prioritization in L2 cache allocations.
 "mba_MBps":
 	Enable the MBA Software Controller(mba_sc) to specify MBA
-	bandwidth in MBps
+	bandwidth in MiBps
 "debug":
 	Make debug files accessible. Available debug files are annotated with
 	"Available only with debug option".
@@ -526,7 +526,7 @@ threads start using more cores in an rdtgroup, the actual bandwidth may
 increase or vary although user specified bandwidth percentage is same.
 
 In order to mitigate this and make the interface more user friendly,
-resctrl added support for specifying the bandwidth in MBps as well.  The
+resctrl added support for specifying the bandwidth in MiBps as well.  The
 kernel underneath would use a software feedback mechanism or a "Software
 Controller(mba_sc)" which reads the actual bandwidth using MBM counters
 and adjust the memory bandwidth percentages to ensure::
@@ -573,13 +573,13 @@ Memory b/w domain is L3 cache.
 
 	MB:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
 
-Memory bandwidth Allocation specified in MBps
+Memory bandwidth Allocation specified in MiBps
 ---------------------------------------------
 
 Memory bandwidth domain is L3 cache.
 ::
 
-	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
+	MB:<cache_id0>=bw_MiBps0;<cache_id1>=bw_MiBps1;...
 
 Slow Memory Bandwidth Allocation (SMBA)
 ---------------------------------------

