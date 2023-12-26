Return-Path: <linux-kernel+bounces-11248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DCA81E3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A1AB21F90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A861B5811C;
	Tue, 26 Dec 2023 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UruK2fyZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9858102;
	Tue, 26 Dec 2023 00:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B067C433C7;
	Tue, 26 Dec 2023 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550222;
	bh=b4DDAmGv18Y0v7dNLBafuHTTJE18Ii6KicK0PHMLmq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UruK2fyZZWrujbUP+XBWr2iuNzMtDX1WugQLfnrHGXvKJRLN/WU9wFY7tE5T7RQPc
	 WzPln4jK4mT6apU7eqlJfVhahJGmyvJoi4Ug1hRcZxFnICF9AY7RRT4Ahto0xwwgXx
	 lSPjiFegRnwf9Tste+UzK6f2RyPYkKIRARTPPo2Jw1TzMTmej3g4M87q93VNvgeJHG
	 3q5JamIHxagIUUy2ALx9W1bvBBaR1x4jnIa16AFQEgXgRTYQ63BUIJaYFqTyyoCjN1
	 dRAmu+SKf34z9CrhGrH0zBdWs9jTrTD4c7OFVx/nxKkKFyCWKZHoQO/gbKBtXooQ+k
	 fL+AKpSrqRn4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	agk@redhat.com,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/24] dm audit: fix Kconfig so DM_AUDIT depends on BLK_DEV_DM
Date: Mon, 25 Dec 2023 19:22:09 -0500
Message-ID: <20231226002255.5730-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002255.5730-1-sashal@kernel.org>
References: <20231226002255.5730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.69
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

[ Upstream commit 6849302fdff126997765d16df355b73231f130d4 ]

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 662d219c39bf4..db0e97020256e 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -650,6 +650,7 @@ config DM_ZONED
 
 config DM_AUDIT
 	bool "DM audit events"
+	depends on BLK_DEV_DM
 	depends on AUDIT
 	help
 	  Generate audit events for device-mapper.
-- 
2.43.0


