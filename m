Return-Path: <linux-kernel+bounces-125043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C4891F25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FB11C286F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3031C08B8;
	Fri, 29 Mar 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFjjWaJT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E231C0899;
	Fri, 29 Mar 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716693; cv=none; b=GJ0sRZSBEya1T82UdwVkb6jNDq1z8PegerhMzlcjJO1z8hDJEM0/JO6MXELSz9r9VF3Zt/z1pXvgBmlqk30XJQJiM/Etl2lKartYNIe/3CNvM35UE2YfXEHw8UcFPr9ko1HHWgaEVf66FvtCtv6n4Zfsp1ObkB35PobVitSUYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716693; c=relaxed/simple;
	bh=U/P8vKJnazg2oxa4NPelkRvHtpu1iu5HDEqWvTOKclo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID/J+9emMyWgK5s5nLH1cyP135YPQ5eOLe+SOPwKqdmUo40QcVpIQ7EWAixsNWhB47uD8RHIQUowljAGYffinKHafMtpW4H1Qbt3bZUmysBVdWlFMkvro+ngbZKjTMX8lSv0aVmkx0AYMn5j6kMhrDOxYg/a/zv6f2NQLQFQWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFjjWaJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B2AC43399;
	Fri, 29 Mar 2024 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716693;
	bh=U/P8vKJnazg2oxa4NPelkRvHtpu1iu5HDEqWvTOKclo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFjjWaJTn6pLJY72VmL/sIKqJrLox7g7RvcXFlJh55xOSA81PmoNlL6VErB82z1Bx
	 U4utenU6+KwoQXN0u1Y34NGGqCQXe0nMwuQcpnmbkVryrCiOT/b3HLv/4gKNRbTBjh
	 Ax1UvRiysbhySH+nEE10Dcy7HaSXm+HYmhV+g0qzG4YamCM2G1AJYJQ9AYKEdF45VX
	 TJWzQA7C1weNZVhVZIG4vdNRAF/1N/7CZBbsohx0a2q/rMmqr0uKgz4ajPuOOxO3S7
	 I7gJ5vJ1pBqsb8ITBdjozSTKGwwfbRPF88lTSkHvD7HvNoHvqmCou4TiB2GW9su3qs
	 AKrGPrUx4snzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	John Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 19/19] ktest: force $buildonly = 1 for 'make_warnings_file' test type
Date: Fri, 29 Mar 2024 08:50:51 -0400
Message-ID: <20240329125100.3094358-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index 128a7fe45a1e3..a29d9e125b00b 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -765,6 +765,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we
-- 
2.43.0


