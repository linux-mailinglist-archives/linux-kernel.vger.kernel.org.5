Return-Path: <linux-kernel+bounces-120281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E588D544
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C62B22097
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4771722F08;
	Wed, 27 Mar 2024 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAS3atLd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37622616
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511974; cv=none; b=Y6xtKlXhAPiVoDWrDvK3GRoCyz3WrXNrVLBB3BrE7MNX6Yv4ftcv6JZDEQabEpeURRFHCZLMTyoq6LGTPMqtb6L39h6oDvFSEoU7lHwcW6R6Tx0e4Ci7WsDrpWvJR26GYGbOkWuufwbIH5hxJ1GyALJcn8YHF7naSKcAzvYJ1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511974; c=relaxed/simple;
	bh=wdhcNM4K/OS+1KKlXGTq4jMXwOj4D3vjq6o3BLfilf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gs5cXenQvjokpe7C8ahYFy9an48Ch9tl7M4/bbSLOktp9yOp4z/0+xdKRukiDRsVngYN/uGlzulk1SBnVi6MeEqEhhP5hxbPDsswxghCwsY2MAbfizVeb/w91uU7czK4DwR2L8P7WVqlBGmfysLfW++byDT4wp6WcPM+SoD6P+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAS3atLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654D2C433F1;
	Wed, 27 Mar 2024 03:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711511974;
	bh=wdhcNM4K/OS+1KKlXGTq4jMXwOj4D3vjq6o3BLfilf4=;
	h=From:To:Cc:Subject:Date:From;
	b=RAS3atLdjT+qrd4ZCTtvl3u1irnbrhc34DhRTPe8nUv33ahvx+KAqDVeYtLzPf8+H
	 REoT9bZuoMeztN1HmVn3J5DaL16w/Ns1UCP3Q2XvmILMMSh9lfTz6AVlcq9AY0lgqe
	 jTSUm3oJxOzlY/zlqO6YTtp/hFctoqstDY25W7vZTuW18W090qwK0bVUEmRTkY47Wx
	 uZKIh2kjwrg7uyBBxaGuV04MPMmHoAzJGhl8nKtSSKU5dXboVoCCrSqSedZa/jfbtK
	 yAZ9YYsio/0rLHL7hgHqtHXJ7u9DxQKflovOefuqJp01pkOKVh/gtJE4ed7DCLy1jv
	 fH0suXLjnLgUQ==
From: alexs@kernel.org
To: Tomas Winkler <tomas.winkler@intel.com>,
	linux-kernel@vger.kernel.org (open list:INTEL MANAGEMENT ENGINE (mei))
Cc: linux-kernel@vger.kernel.org,
	Alex Shi <alexs@kernel.org>
Subject: [PATCH] samples: mei: remove unused parameter
Date: Wed, 27 Mar 2024 12:02:50 +0800
Message-ID: <20240327040250.478844-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

The timeout parameter isn't used in func mei_send_msg(), better to
remove it.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
---
 samples/mei/mei-amt-version.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-version.c
index 867debd3b912..bf14d8a819b9 100644
--- a/samples/mei/mei-amt-version.c
+++ b/samples/mei/mei-amt-version.c
@@ -195,8 +195,7 @@ static ssize_t mei_recv_msg(struct mei *me, unsigned char *buffer,
 	return rc;
 }
 
-static ssize_t mei_send_msg(struct mei *me, const unsigned char *buffer,
-			ssize_t len, unsigned long timeout)
+static ssize_t mei_send_msg(struct mei *me, const unsigned char *buffer, ssize_t len)
 {
 	ssize_t written;
 	ssize_t rc;
@@ -391,8 +390,7 @@ static uint32_t amt_host_if_call(struct amt_host_if *acmd,
 	memset(*read_buf, 0, in_buf_sz);
 	msg_hdr = (struct amt_host_if_resp_header *)*read_buf;
 
-	written = mei_send_msg(&acmd->mei_cl,
-				command, command_sz, acmd->send_timeout);
+	written = mei_send_msg(&acmd->mei_cl, command, command_sz);
 	if (written != command_sz)
 		return AMT_STATUS_INTERNAL_ERROR;
 
-- 
2.43.0


