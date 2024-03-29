Return-Path: <linux-kernel+bounces-124935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B4891F45
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B503B3395A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEE61A5D71;
	Fri, 29 Mar 2024 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgGFtLp0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055713B59E;
	Fri, 29 Mar 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716452; cv=none; b=dy9p70XBJqvuGpweqOpXGBMGsqN3OcZTD8QULvNkhwH39GxyU9K/Q7keZGxxTxQ0k8Tciw2E5Inn9VwXPYrj5ZaN5v6zokfQlZm0TPSdeYBSfx+m8MSyZ/S4S1ugrVYS3EeE5FHjp3B5aGpzeiFa+11OFntZigEMNxOKE/9Hb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716452; c=relaxed/simple;
	bh=FopW1+5t67Kp7oQnuAz61rt5C5Ev2YhNbDRJjkDoy14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky128mOpK5jIcyzaJ6IE6m5c+ztRLSFonFgbDIjqddPg+UYdhgo3t9flXDACWE336/q9fAqKTUEB4NCSrI9V2Cn1Sa304YN/lFn7khVr499wHY8scXRJS4Kr8j7jCQX8xcoC1yLQM3hyfejHMCIi8EQWgNOI7+OAYOiybtrNMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgGFtLp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA16C43399;
	Fri, 29 Mar 2024 12:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716452;
	bh=FopW1+5t67Kp7oQnuAz61rt5C5Ev2YhNbDRJjkDoy14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgGFtLp0f2nm/OQrs+hXU+3iv6KICPGsfumBEYw/yx3vbAs7+t4q9AdBONmYeWC+F
	 piufJc6oPPzZ7PiuVE2nHECkhzLd3ErVAO7RePi84gBPmzLfAyZwFL8JZuieh+Xw5K
	 hiQbfUPy+xTbP30rYXl0t35Mu5PAfq0Acs2effNyxU4ze1x/s2DVE3gf/7ZG7zeGli
	 qmaSfnWQmPETmkEvZnB4dLD6rPD8BFFeceyoiiftHoyiQsjnsrKnys9B+AXIlRy7Gv
	 w+iuSt8THMrXK3RAm7rbvmOKoyyMh9AtF+3FNe1Ib2XdbJ0W6emewRHd8zmI7oQMms
	 1M2JxLNXB/iOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	John Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 51/52] ktest: force $buildonly = 1 for 'make_warnings_file' test type
Date: Fri, 29 Mar 2024 08:45:45 -0400
Message-ID: <20240329124605.3091273-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: "Ricardo B. Marliere" <ricardo@marliere.net>

[ Upstream commit 07283c1873a4d0eaa0e822536881bfdaea853910 ]

The test type "make_warnings_file" should have no mandatory configuration
parameters other than the ones required by the "build" test type, because
its purpose is to create a file with build warnings that may or may not be
used by other subsequent tests. Currently, the only way to use it as a
stand-alone test is by setting POWER_CYCLE, CONSOLE, SSH_USER,
BUILD_TARGET, TARGET_IMAGE, REBOOT_TYPE and GRUB_MENU.

Link: https://lkml.kernel.org/r/20240315-ktest-v2-1-c5c20a75f6a3@marliere.net

Cc: John Hawley <warthog9@eaglescrag.net>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/ktest/ktest.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index e6c381498e632..449e45bd69665 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -836,6 +836,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we
-- 
2.43.0


