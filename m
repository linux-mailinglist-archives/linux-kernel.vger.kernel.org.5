Return-Path: <linux-kernel+bounces-30752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EF98323EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696D91F22C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C751A4A08;
	Fri, 19 Jan 2024 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8kuJbEj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D14689
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705636716; cv=none; b=ASe9+w16MoCZIX3iw3E9rs5Rphq+W+a8/sS3m9tFEMK84uHYh8qvMiw1STmjnbaw39C1prh0MhfMepwL6j1SHu1d3TqkNHfXgAi43qsR7EjEk0rRlwCepNVDPAVTwjtiowsAyvvvcugdjij2OK9ehbH4+3yCBfU2Vs4umzxN3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705636716; c=relaxed/simple;
	bh=9jUwky36NLzm8NVF/m7oD9r5D3MHcwxHSo38CN5cyfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/NUpoPgv2HwA20vaZM60a6JU8phW8XwqbBebrgJSIupauD6ES256zCwo9/ah1f7ltDXWdWFZaiu8jWARjAKb0dDKYHXznXeVmtIpT3gx0CfuvftGtLQHDCNch2sRTFAyx0lIWicMlfSx0i0PGqrLK3koc0sTwKIqIrg77dlng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8kuJbEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B426FC433F1;
	Fri, 19 Jan 2024 03:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705636715;
	bh=9jUwky36NLzm8NVF/m7oD9r5D3MHcwxHSo38CN5cyfI=;
	h=From:To:Cc:Subject:Date:From;
	b=H8kuJbEjqFXk72fSA9zFcdqEJlweGa3AAEywE7h9i8N8LGg9zYj3swgDZC/ySQR+H
	 QE9J1R2xX+csTOfB/P7shw70LwKSs9Bxhn9cbllmyX9PEqSOsoMsFG+uMyZLZFGrjz
	 ivCNyOMgMrDzumLIcnLxupTEfBWUNKqXbOrR+5nDvI6AfWdRowFOKOLIc2+MiArCLJ
	 OsNDFklm82ePumvelo5i0DIktgD7i9bzNthHXMRj/G35Ns10RZ2PU6d5xUtwiiJRrR
	 5EJxBCrK9N01MBYczp/Plcrua4GeTiWK9RWM7bByl37VqsjdScrPk5nGfsdXtgdDbp
	 /hPXiHZ5cs1jQ==
From: alexs@kernel.org
To: Tomas Winkler <tomas.winkler@intel.com>,
	linux-kernel@vger.kernel.org
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH] samples: mei: remove unused parameter
Date: Fri, 19 Jan 2024 12:00:12 +0800
Message-ID: <20240119040012.2925013-1-alexs@kernel.org>
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
To: linux-kernel@vger.kernel.org
To: Tomas Winkler <tomas.winkler@intel.com>
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


