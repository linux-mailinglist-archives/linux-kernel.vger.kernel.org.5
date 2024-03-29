Return-Path: <linux-kernel+bounces-124969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F90891E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF311F271C4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7716CCEC;
	Fri, 29 Mar 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw6hvqpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FB16CCD5;
	Fri, 29 Mar 2024 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716525; cv=none; b=Bi8MWkP0pPL8wuNSxVEX3KxfmQXMlL+C5vWu36pt+CUf3fCqGWD8kt/bmZURskpJYZ7KEBdsINxm39HSbA4pKIOhPoKMXuwPfmVvEARmYonMICotyaxgNRdCgE2imOvZdB+SuDhX0/Ffb6gTfwBMSiJ/MZiie0vjP07hs+1AYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716525; c=relaxed/simple;
	bh=FopW1+5t67Kp7oQnuAz61rt5C5Ev2YhNbDRJjkDoy14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0jTZfVyvOa96arXKFyifN5k7JYVish6QsE5cS9o9flRr/g7e+HdumWKP6ANcyx8gBT0EahuC78JxLTb0TVI9rVcBZu2Ni/JqwxOaLopzhXIXNodCSxer+cpUYG+Cb4D4NFJJkoNuu+KFEJbnSD1BMDZzM1ncenCrjF1VdEr2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw6hvqpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0446C433C7;
	Fri, 29 Mar 2024 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716525;
	bh=FopW1+5t67Kp7oQnuAz61rt5C5Ev2YhNbDRJjkDoy14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cw6hvqpaYdk9OOGpT1b6Lka3t8I89/32O8o94gjWapZu5nU+dIY7WH/8GYF49yuOP
	 ZjG4PZ/KYJuN4XALzWwLCkHXItQZ1QUpiGQ9aPpRKyiNpMzcOGUTNARRYna/yKDHLW
	 QzPwAWLqxcWBnABMnkA+WOFirErj6zchg2HeaTyNKZM4PTN3EsfHEI2ur6L43moLvM
	 iJ3exfLerYvcmxY7VE5J9h7Ig4Tcoi24YQh6MAfjjmHoP6hY0337ByyZzhmNXyBMxf
	 Yv25I6oMPr2DlyOgl65yFOxuPU0vP209RBUDgWI/h1G6YbepAcG9ATWuG/ArGSVPxm
	 BqRQMY63NuuaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	John Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 33/34] ktest: force $buildonly = 1 for 'make_warnings_file' test type
Date: Fri, 29 Mar 2024 08:47:34 -0400
Message-ID: <20240329124750.3092394-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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


