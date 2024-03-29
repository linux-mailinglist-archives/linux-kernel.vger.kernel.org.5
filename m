Return-Path: <linux-kernel+bounces-124807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D9891CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D9D289CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B32419669A;
	Fri, 29 Mar 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7hzL/z0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF30A196689;
	Fri, 29 Mar 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716168; cv=none; b=ALNSJ6ipCVP4s20vdWPnUfMO6nBOVCtERyDOc3rM/syXH+1Q1CUcW7kNZ5U3WEB0jPT87qdN+3cE9JDJH2MC2FU4Fr+LozlRh2FXVgWXFtJA2OQFspP/oBJ4M3laNDiANZ0SRHML7KWRblr9NN3X/B4tEgIzoTzyDjYXEvROGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716168; c=relaxed/simple;
	bh=9JU16l56HTSKEFFyvDoDlOLG57gXP/zaJfHGYt1Fu3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3KMJTvgDyp0spbj17TkpqYFcV+ZB8oHjB5Hw/604dxmMc0F2622yRAo+QMHYpNob2/tGkQQ7vQmfNOIpDDrkB9lhYQ4VmoEdsqfAeLGPDrGhB0nPiHL8jxulVa+iC6Xzo0fE23/N9ZIpq7tbzNg26tAfN/5a6oXAPQ6bDYphxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7hzL/z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07298C433F1;
	Fri, 29 Mar 2024 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716168;
	bh=9JU16l56HTSKEFFyvDoDlOLG57gXP/zaJfHGYt1Fu3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7hzL/z0Y5132YlnzSfHMO+i1s9ChpjigiNKoGcMWAtQgCRkkZBDdQEgVePTbAACd
	 YABF/8rzFWxZc8BCBVhtlMu1S0yWOnw6JkyM7XQiEmVrEgZG6sBP4SzSHIb2PMW1Qf
	 LGVSIm9yAyP4YKp2Cch9JL4OXWnSUHCC7uJtC58ohSc6KxT/YE8e91NizPi0OIiZPc
	 bGiFYruq2Gp9afqnhzrUqQ7UsNRK/7764QSbuXo+JJDFgcmoW5vm82n3JbQi99Lpx6
	 ZZiSnX0+isZ9iT5S6lccsMptjJcIswUJOQhFg14Q5G97ERisR7EFqhEE4HaxeTV3fl
	 RoT3JpQF1FLsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	John Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 96/98] ktest: force $buildonly = 1 for 'make_warnings_file' test type
Date: Fri, 29 Mar 2024 08:38:07 -0400
Message-ID: <20240329123919.3087149-96-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 829f5bdfd2e43..24451f8f42910 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -843,6 +843,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we
-- 
2.43.0


