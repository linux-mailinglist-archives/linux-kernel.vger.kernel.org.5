Return-Path: <linux-kernel+bounces-50140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B578474CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2B11C21C19
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AC685276;
	Fri,  2 Feb 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B2pqHIzy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2piXi6He"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1917748;
	Fri,  2 Feb 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891563; cv=none; b=IyvkgFeBeMZKA7c+afT+5uS7dHVKwPk85XTVzQAsVNl2FCXSIHS7ZBxIIFLBLVbt4IgzPHgmB9KPiAZxIBYSZlFFiXENjxNNwVkic3HB4lilPN45FigGkNR+sSAucvQby7wFnu4L++EpMyp1Bjip2nkjl/Pn0EU4/QTiZK8stjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891563; c=relaxed/simple;
	bh=jxbk4BHSOPL9Csuh5bEMzXEArLzdt9RKawIWRWU34aM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q9IVnYBod7XUJQGUiH3vzN+DCTFHFtbJZyfUXMsps/uMqp0igjDwMuAT1PXGqdPwx9u2yw7ucljgnnIJ2L2yLCJ65Hv8a2tp48CKI8KYRFBIwyagSrpI8MdA4tKpnK9YAbqppc6/kkrfEpDODSK9i5U0qscJNgTQSPz+21f1Lss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B2pqHIzy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2piXi6He; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Feb 2024 16:32:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706891556;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxY23inNlfXJDtd6QFnah1CyV2XYWkEg48KIrm4vOAk=;
	b=B2pqHIzy+XcAUTnymgWIJToyHYkkedh1JPzVkfd7R+GETi6OWEwWWR7Iz7F3uCSYziXhqs
	NHntlstdEclC8XhqTBDQhG3GoO8QBjhz596hv9xan0Kr2UnmCgycGCIT0+lv1hT+7LikhU
	vpekHItsgHw42mAk7lkhd1+eyOXaarQAdgvnDpk2oxwn60yJCqLFSBllufDKq3WS5zVLPn
	8QDqmrRYVJohTclaXbblmGAM7m14cTO/gvcXMUNJ1Rel5Eh5WqVoLpypdHVLFhk5LXLKLm
	vKzlN35NN1dV7PddFdsoQ7IGWLxaIwwZHTMVztZaDKt42GQwNjprnIFtBj408A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706891556;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxY23inNlfXJDtd6QFnah1CyV2XYWkEg48KIrm4vOAk=;
	b=2piXi6HekQL5rHCj6iim3Et95UsoPpuPfkz92WoJk2qtOaGqnGu/bIzgsPz/GbU1U7Oip0
	bE0IXA3xt3eSGVDA==
From: "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] Documentation: virt: Fix up pre-formatted text block
 for SEV ioctls
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240202160544.2297320-1-michael.roth@amd.com>
References: <20240202160544.2297320-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170689155526.398.13288838751196694327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     1bfca8d2800ab5ef0dfed335a2a29d1632c99411
Gitweb:        https://git.kernel.org/tip/1bfca8d2800ab5ef0dfed335a2a29d1632c99411
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Fri, 02 Feb 2024 10:05:44 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 02 Feb 2024 17:21:22 +01:00

Documentation: virt: Fix up pre-formatted text block for SEV ioctls

A missing newline after "::" resulted in the htmldocs build failing to
recognize the start of a pre-formatted block of text, resulting in

  kernel/linux/Documentation/virt/coco/sev-guest.rst:75: WARNING: Inline emphasis start-string without end-string.
  kernel/linux/Documentation/virt/coco/sev-guest.rst:78: WARNING: Inline emphasis start-string without end-string.
  kernel/linux/Documentation/virt/coco/sev-guest.rst:81: WARNING: Inline emphasis start-string without end-string.
  kernel/linux/Documentation/virt/coco/sev-guest.rst:83: WARNING: Definition list ends without a blank line; unexpected unindent.

Fix it.

Fixes: f5db8841ebe5 ("crypto: ccp: Add the SNP_PLATFORM_STATUS command")
Closes: https://lore.kernel.org/linux-next/20240202145932.31c62fd6@canb.auug.org.au/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240202160544.2297320-1-michael.roth@amd.com
---
 Documentation/virt/coco/sev-guest.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index 14c9de9..e1eaf6a 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -71,6 +71,7 @@ The host ioctls are issued to a file descriptor of the /dev/sev device.
 The ioctl accepts the command ID/input structure documented below.
 
 ::
+
         struct sev_issue_cmd {
                 /* Command ID */
                 __u32 cmd;

