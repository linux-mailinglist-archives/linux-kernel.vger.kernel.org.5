Return-Path: <linux-kernel+bounces-49535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BA1846B96
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF00928CA88
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8196D745F9;
	Fri,  2 Feb 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ik5xPRN4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9+50Y3iD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEE874297;
	Fri,  2 Feb 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865047; cv=none; b=K+n/k4qXzQeMAmlzf6HFsH0a5BKoCHbi8FA9asnX2GwQ2N4YrHOPcFW6rMBIyH+SFE22q8x3Oovpu5UafsOD1DRx1v0gScbxvmf2e3n+9KIFTFGrMZHYGwLtkr0GuV1dd941doXx9CwoQePuaJc55FMrsXSWYnr4nyqLO/T2ecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865047; c=relaxed/simple;
	bh=Mj2eWb37LuM66Dj95CdWDSuDwe5WJYgKCJAiwOQErps=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J9f5hiJCkaChY9ploAuzm51tTf6VUzFe+Jc6s8Dp4nCTbgNeOrcMhjXMK2TGqzCNjtMNhNH6qyWJ3knt6B3vtB2xi59tsZ0LhXURGm+Xs/0IUMf8hj+ip6o2MRE/tlmgSq579a6uKmqOeEMLtDcFZWzENdvtwt5tQjbjPEbQk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ik5xPRN4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9+50Y3iD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Feb 2024 09:10:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706865043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFmzybAsJfE0cVsdsUehIbPmaxNb2tCDaeYPwTsVCSY=;
	b=ik5xPRN4cmK7PvqdvkZ5D8hZzI2VgC8RDV/Cge/ovYrUNZg5XXJiEzZA19A2aEUq9BedMw
	og2Af0Rbh2X1PnodNY5VeEKUMlvpgQNKq1N2MshEYvuGyq0RoFgFCsB6oNb4Sb8yVx/6lf
	DVAdiEK7cSmTJe43i4plmTzXQLo9hdMIh8gpQjQS+VbyD9j+0PTl5acTRipopSw+yAmptO
	BjJDAdgDzJbyOSrRigfW9FgpHeDDOL0gC4530s36DaqWhhSFmQWAMQ0qyiFxI4HfwScWFg
	3QvXukOIm0Lh5Ln/CryHIQn+TUgbOPmWY1Ye241Rdc/OaFZ+lg6m/LOy6+SQVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706865043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFmzybAsJfE0cVsdsUehIbPmaxNb2tCDaeYPwTsVCSY=;
	b=9+50Y3iDRkpaRCUgs0TPws9H3gDLx9qcPbhV88ZFRndsozK3ZMwDPWeHkm6Q2sxOXk8V2o
	pUVDEGxlu0nxLSAA==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Fix a build warning with allmodconfig due
 to 'inline' failing to inline properly
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "Xin Li (Intel)" <xin@zytor.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240202090225.322544-1-xin@zytor.com>
References: <20240202090225.322544-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170686504193.398.15699527281623271387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     cba9ff33451162a6aa9b1424b32503354d7ef20e
Gitweb:        https://git.kernel.org/tip/cba9ff33451162a6aa9b1424b32503354d7ef20e
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Fri, 02 Feb 2024 01:02:24 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Feb 2024 10:05:55 +01:00

x86/fred: Fix a build warning with allmodconfig due to 'inline' failing to inline properly

Change array_index_mask_nospec() to __always_inline because "inline" is
broken as https://www.kernel.org/doc/local/inline.html.

Fixes: 6786137bf8fd ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240202090225.322544-1-xin@zytor.com
---
 arch/x86/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 0216f63..fe1e7e3 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -33,7 +33,7 @@
  * Returns:
  *     0 - (index < size)
  */
-static inline unsigned long array_index_mask_nospec(unsigned long index,
+static __always_inline unsigned long array_index_mask_nospec(unsigned long index,
 		unsigned long size)
 {
 	unsigned long mask;

