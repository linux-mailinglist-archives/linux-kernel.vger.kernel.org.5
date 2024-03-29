Return-Path: <linux-kernel+bounces-124882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE20891D69
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162BD284695
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F02C2101A6;
	Fri, 29 Mar 2024 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnSIoHn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F649210196;
	Fri, 29 Mar 2024 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716339; cv=none; b=iRzteJMojBEQk4gSJNGum0LTMrBSTt5eZjLrDwyxhp30gJb+v1G5dGJrl/KLAsRXTsh+4nfuRjy+EL+NHFZ5Fh+6LwxkWeeQn1NaE3nqWqRi9KyAaBm9x+Ljg4Yr9I0S88GQpKXGqdNmGQnleDjHeAAxdPaQ5HbwhxJEvse6H6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716339; c=relaxed/simple;
	bh=9JU16l56HTSKEFFyvDoDlOLG57gXP/zaJfHGYt1Fu3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wzia+DN3gR5pSzhHOY5Vvjm7vbomMCFHMgHuJLJGRKnVX7+69wO8ZN94wydWFE2CYrBcLjs+4/j7w3dPi3USHiK6+Mxr41mlaHo5r6CQE02KGRECt2ZHD1Fdm6iymX62o+WxOGUyk2GmINf7SyTyYauABtjYP+C8LrZXOnuwF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnSIoHn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837EEC433C7;
	Fri, 29 Mar 2024 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716339;
	bh=9JU16l56HTSKEFFyvDoDlOLG57gXP/zaJfHGYt1Fu3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnSIoHn3qO6aHc9StkfMk0lk+82ZxPQIT2U9f1ei7cCpBJH4dGgeSeX4iD3/Ne2WA
	 kpnr9WETjh/bIpO46IDjx9W0+44S93nwfZLMFVivDcHt4XV2mxkAftc8Pwl3wReeFj
	 ttwPkyh1PVMXDdXks5taY8loFpmFNCJLpQ7hR1/ESFrCt+DYAudQalH0OkB6BKK9U6
	 1tkiaN1/lWuLPuW+w69xOC/xetrvHvFSRi2877Bz6KSQ/rEH0NoGDWCYre2vE7wOO3
	 K63MCpBZRYa2VTbsT83086/EBlju+9WT6OtO2zRWyygAhZTbN61Rd2r2hxtDGR7Z82
	 L26RsApu7v63g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	John Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 73/75] ktest: force $buildonly = 1 for 'make_warnings_file' test type
Date: Fri, 29 Mar 2024 08:42:54 -0400
Message-ID: <20240329124330.3089520-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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


