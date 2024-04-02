Return-Path: <linux-kernel+bounces-128407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FCE895A6A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779211C22889
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20086159919;
	Tue,  2 Apr 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWviRR/q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zo96D1JF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B1B132C38;
	Tue,  2 Apr 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077758; cv=none; b=tleRcDI99MCU7aBWM3OQToRlJGQy0yD0hGUp6WXVW15BWBHjc6uWIjQvAWIEpELYk4ASMncxOZfcNhdg3vt1cTSH9rfJ58ydNj3UAFa+86BuVPc9E7pdzcGwetb6TaQdIBv8Um1de5PqxgWw6ld2Ld1dPo4InaqGyMRH8CtJtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077758; c=relaxed/simple;
	bh=vrLrw4PZ2pbInWmXixTmINalXWw5pkUqlP1Cbc0VEPY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=KosQISC49pUCzWtyUnOITHtVXc480Itme2+8ToUnLuDmcIXGu28OzCTa1jMJZhd8LTKcGrpQDK1YgBX9QlBw7ueVqcBnRap1puLAK8AfoOa4bpRuVoK378ZdpbwDpGYHx5Z53NC3tY0EGIDd2xkrpgVaB5NHWSjydkP6m8ggIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWviRR/q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zo96D1JF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Apr 2024 17:09:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712077754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EkUkhRyxrhRLwcnDLbcsaRp00vCMdcCteMROj6SGNos=;
	b=VWviRR/qEUBGUkqKpn/7HJ8s3dqptv98MS16lIUCP3AtZ/n2EMV2lVRgMsoOfYQEAg7X3A
	hFtpThU9obeTOqAWGQ7V7/e+oHl5byv5kuiBustqWfyFKO1uUfvRR/DAELvvz3VM5eNlQ6
	daEgv4MO50BpLXd+e9tvkGi21XUSedw11/lqIrgsJBrXdN6UAno74oGqlOiXZPqu9F0a24
	FH8GL/gEFLxF6eISuVNOKm7oot4i+RINFPE/Grz+Fe7yvecnc27cRqyeL+nw/MwMA90qmn
	QDpqBhZdgu19ubQgTosMpKLJe7Q0Z8wncZD6ftT0lrh488Un45FiwMQQ2i/uLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712077754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EkUkhRyxrhRLwcnDLbcsaRp00vCMdcCteMROj6SGNos=;
	b=Zo96D1JFWujbWb/9U7wUUnBxL97Avj8ta2tI1DEjwlPzggn/mh/jTt0H1j4h7HKr/PJCKI
	X4exOjuqW+9Kf7AQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] Documentation/maintainer-tip: Clarify merge window policy
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171207775367.10875.7993832027274159765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     bdc42c8b9befcef6368be345004cee3da1ace955
Gitweb:        https://git.kernel.org/tip/bdc42c8b9befcef6368be345004cee3da1ace955
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 22 Mar 2024 11:34:03 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 02 Apr 2024 09:40:23 -07:00

Documentation/maintainer-tip: Clarify merge window policy

There are lots of maintainers "pings" during the merge window, even
for trivial patches.

Clarify that contributors should not expect progress on *any*
non-urgent patches during the merge window.  This applies to all
contributions, not just large ones.

Clarify the language around -rc1.  Trees really are closed during the
merge window.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240322183403.67BAEEFE%40davehans-spike.ostc.intel.com
---
 Documentation/process/maintainer-tip.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 497bb39..6473996 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -409,20 +409,20 @@ See :ref:`resend_reminders`.
 Merge window
 ^^^^^^^^^^^^
 
-Please do not expect large patch series to be handled during the merge
-window or even during the week before.  Such patches should be submitted in
-mergeable state *at* *least* a week before the merge window opens.
-Exceptions are made for bug fixes and *sometimes* for small standalone
-drivers for new hardware or minimally invasive patches for hardware
-enablement.
+Please do not expect patches to be reviewed or merged by tip
+maintainers around or during the merge window.  The trees are closed
+to all but urgent fixes during this time.  They reopen once the merge
+window closes and a new -rc1 kernel has been released.
+
+Large series should be submitted in mergeable state *at* *least* a week
+before the merge window opens.  Exceptions are made for bug fixes and
+*sometimes* for small standalone drivers for new hardware or minimally
+invasive patches for hardware enablement.
 
 During the merge window, the maintainers instead focus on following the
 upstream changes, fixing merge window fallout, collecting bug fixes, and
 allowing themselves a breath. Please respect that.
 
-The release candidate -rc1 is the starting point for new patches to be
-applied which are targeted for the next merge window.
-
 So called _urgent_ branches will be merged into mainline during the
 stabilization phase of each release.
 

