Return-Path: <linux-kernel+bounces-38923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2B83C884
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AE1296609
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1D1132C18;
	Thu, 25 Jan 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUkcoNPZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BAKL2yrv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221F1386C9;
	Thu, 25 Jan 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201022; cv=none; b=rObEg3jA2j6Fu6xPILfKrGPnDA582yhABgn8TzFzR9QPkkoKJ+uTv0a9Vq/5RmCMkGR3JPrIOq8mkl6xwUG4IJsGKAL+/d+ec1LNADAGTh7hmelh/YvF6oIH4wtjdNeUlqfKPfs1Y0jNrSsF9CDYtYDt3UIJHrVnH4e0M4cp6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201022; c=relaxed/simple;
	bh=qlZenJyIstVYdWiJcRf04ZXU4wRC9pZX/QYgGL3c40s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Tc7EKb8Tsw8go/y50X+KoaNL14quOlpb5Fux+Sdh2cUrKE8sxeW+l128IM4irSFylkOVqOJ/4Bt+015WH0R0spfxiJ2LvIaPPlcjfQ0rcakebZTV5gN8DLdJ0rw7w5RZCEHNfE+1hegwK4kcMZi81fbF7ILY6dq3XFU8ZWJCywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUkcoNPZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BAKL2yrv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 16:43:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706201018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9alz6IhoFeSBeq+RLDCT53ipn+PBG+CbCy5oS/MiWY=;
	b=iUkcoNPZdZW6zaapgJmGPJ5/7NO5k0g7nklK/z6nyl/fymgi+O4kWTC0xDzIUWFHE1lLNl
	n3EDLrBeycJ25IZ0A/pAJ0pu490FPo4lHMR2UFm6Gp8uOoIIm4M50m8A+MYkv465oA9ZAV
	VkHxVy4MWsRKTfe52HLXRgwqKhdSPO8XR1JFEyEIR3QoM0XUBEngYHxO8kILXquZEHWUn8
	dcMNbsiteT5kX9J8htlj+EhOWBX1skQd83kvZ+bswnwpgdzw+7Hh1VowjXas/yBt3wTc4R
	gwIcrm61wlXS5ebN4i7Ec9TXzXNPh4/rOmQ+jUwGM0L6N1ZUUJ8rzjsAJTYmkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706201018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9alz6IhoFeSBeq+RLDCT53ipn+PBG+CbCy5oS/MiWY=;
	b=BAKL2yrvb8IMgsso1FevVA91cagHzwlhEKA193ldPCDd7zaCjlsKUniYQkgUmusU+qL1cy
	CWs2HFdsn6/yt1Cg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] Documentation/maintainer-tip: Add Closes tag
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240124205442.GAZbF5EmOB8LpKqlSc@fat_crate.local>
References: <20240124205442.GAZbF5EmOB8LpKqlSc@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620101796.398.15398694905540241969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     b37bf5ef177a1aae937451f2e272943a9333dd5c
Gitweb:        https://git.kernel.org/tip/b37bf5ef177a1aae937451f2e272943a9333dd5c
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 24 Jan 2024 21:51:50 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 25 Jan 2024 17:31:17 +01:00

Documentation/maintainer-tip: Add Closes tag

Document where Closes: lands in the tag ordering.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240124205442.GAZbF5EmOB8LpKqlSc@fat_crate.local
---
 Documentation/process/maintainer-tip.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 08dd0f8..7993592 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -304,13 +304,15 @@ following tag ordering scheme:
 
  - Reported-by: ``Reporter <reporter@mail>``
 
+ - Closes: ``URL or Message-ID of the bug report this is fixing``
+
  - Originally-by: ``Original author <original-author@mail>``
 
  - Suggested-by: ``Suggester <suggester@mail>``
 
  - Co-developed-by: ``Co-author <co-author@mail>``
 
-   Signed-off: ``Co-author <co-author@mail>``
+   Signed-off-by: ``Co-author <co-author@mail>``
 
    Note, that Co-developed-by and Signed-off-by of the co-author(s) must
    come in pairs.

