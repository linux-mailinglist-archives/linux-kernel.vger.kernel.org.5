Return-Path: <linux-kernel+bounces-116847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE3588A47D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B3A1F62599
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4D8149009;
	Mon, 25 Mar 2024 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLvxdGqf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zG8S5VJY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197EE148FFB;
	Mon, 25 Mar 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363112; cv=none; b=qh9tWqes42YWkqNAAI2q9WLqpbU0c/pnXOi5oBJV99DYTxwYK1GvFlMe01uSafATktwPxCoYTI/gMLmhi1s/k1nCBc6gr5OPkOsZsw9VsXlGTNcXXD8uPXMjbGh65+SC+QQXoHhqpl/stSEVvSjgGlfK25FUuNvIiVRg1oie6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363112; c=relaxed/simple;
	bh=VIFtQK0XN/rUgOMv3CmvkztzHLGtAOCm/Nglv4NTnkU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gwKhW/ZF/8PtnlzyQB4zIv7HRl2g5dTyxXuTbGiSpKE3wcWlHgKYwUZ2zO09g19VlXQ4rFQ5tx6qu5/FDWXSBoNtYvkhESoWXgNE/+LidY/b2cCw9Ka/Yv/8D07KrRWUjMg2iP8EGElw6kgehj1z06LiSSa55p/yxRR5eh2gXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLvxdGqf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zG8S5VJY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 10:38:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711363109;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfLHiy8Np0Ojm/mylOsW6CnKsAh2WH7Zx2l6XpB1aDI=;
	b=vLvxdGqflF3qTt2mNXtpGBjw0107DeBO6HzVN1mqUwX5MLv/gT+XZGTDFPgaaIzyc6ZxRM
	Qn9xZAh78mN/QO67w8w3uUKUry+GTsx7Y0QYdSB6o0IMbSrBKGaxXBn8uwW6w7++lHXWZg
	gIds1zsn7cz1q2OaL6Ptl3d9wBmSdL2ZbRBOg+He7hA+onZJPHHtg26Y0PUlXEb5lsX00W
	rLqjtKdUvfjr6zuHgA/M0bHJCScsqi/Xj063Y+2Ku82bZ69OZm0NjocwNT1EjfwtFSdR/D
	/E4t3xHB2OpjFOwPFpLYxvHhjc8RObgZNIdhVJ9ALOuo6NXuMqydlHhP6XHE9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711363109;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfLHiy8Np0Ojm/mylOsW6CnKsAh2WH7Zx2l6XpB1aDI=;
	b=zG8S5VJYwkr3im2ltwzDyDoMRNY19sCdjcoWZf2EpjNloCCwYqQdk9jPzOGbBUGQ4z8JlI
	3COrmfQpElP9XzBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Documentation/x86: Fix title underline length
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@kernel.org>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240325121750.265d655c@canb.auug.org.au>
References: <20240325121750.265d655c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136310847.10875.2241882307085232437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     91491e5fb09624116950f9f2e1767a42e1da7868
Gitweb:        https://git.kernel.org/tip/91491e5fb09624116950f9f2e1767a42e1da7868
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 25 Mar 2024 11:29:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 11:29:16 +01:00

Documentation/x86: Fix title underline length

Fix:

  Documentation/arch/x86/resctrl.rst:577: WARNING: Title underline too short.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20240325121750.265d655c@canb.auug.org.au
---
 Documentation/arch/x86/resctrl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 3712d81..6c24558 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -574,7 +574,7 @@ Memory b/w domain is L3 cache.
 	MB:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
 
 Memory bandwidth Allocation specified in MiBps
----------------------------------------------
+----------------------------------------------
 
 Memory bandwidth domain is L3 cache.
 ::

