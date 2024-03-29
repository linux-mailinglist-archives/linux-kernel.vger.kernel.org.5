Return-Path: <linux-kernel+bounces-125001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795CC891EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D841F26969
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1491B2C3C;
	Fri, 29 Mar 2024 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPyDVh6j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668091B31D6;
	Fri, 29 Mar 2024 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716593; cv=none; b=Qw6PYjkrmbnywUK49qCGsGXhP2SfQ3APhE0gWXpISZoK2HE6Z/skQW/sf3obUSwG7xuDDkTdnk5fE/RPHzxJGgjcxbPQtIGXf7PlLBRt1pMkw4bXz8s6N+6fAGzgVnyUCOefs+c1sJbvdySYPs99q/lYBZqpX4ghDOudraTuo6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716593; c=relaxed/simple;
	bh=QMG4VHrykYqFxPVOwR6KEP8EbtPKU123pCqjdzZ/Ttk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOjGxukd1GW6bKjqH1usN4HEHMDjUeapowgCusx6PXqIv4S5QTNgBSzMNAOymAcPV3btwCRrNy3u/ciowVWgCMcSUDF9RumYqeZBK3Zt5Lv1lem1SJIXFQHGfWgMRV0MA0lt2+xdV9AVGHHJXM1kdvV6y3Hs91XkGCmKa0Qm54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPyDVh6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A5CC43394;
	Fri, 29 Mar 2024 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716593;
	bh=QMG4VHrykYqFxPVOwR6KEP8EbtPKU123pCqjdzZ/Ttk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPyDVh6j+L2Ra/wOosiq+h0rcU4+sgY+GIHhTDzE1lXjlkSdkBIXFFE6wf+ykL8Kv
	 eUIrSdvXK72BaCeXYyzc1RP91Tv7uyDqnrMFb/FFf+SDuX0YAWPlbvNQTt9xwx9XNy
	 cLLCQE/9gfi2NpfGTlW+w6TohgSi6IsveiFjm21lj1yUBWbmTDhyHqnZ06XYxDaDcc
	 BARsbqm77QGpFWNoW1E9bavnt+sQr/viUTaeQ0BBl8LpsgGkGorBtLTTUV2lUuJZ/x
	 081kf1Nb07Y1d018FZWSoG11lFA7KtY2S+suKy/3jZ5NQApuwDG32zX4DAC9ApUGAF
	 q0bCxDYFHy7OA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	John Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 30/31] ktest: force $buildonly = 1 for 'make_warnings_file' test type
Date: Fri, 29 Mar 2024 08:48:47 -0400
Message-ID: <20240329124903.3093161-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index ea26f2b0c1bc2..f72da30795dd6 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -773,6 +773,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we
-- 
2.43.0


