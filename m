Return-Path: <linux-kernel+bounces-114493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45C888AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4B91F23F96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D597F2892C8;
	Sun, 24 Mar 2024 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SESmlu4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435CF225216;
	Sun, 24 Mar 2024 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321940; cv=none; b=ce3NPDSavoK/jQ3tMsgtVPU/x7zqQ1AG6ktFjEV9zVdaLEdPVRSnWo7mOlaM7vTrKlxTWmtLmIDTCrGUPuQSVAFf0dC6pr/96g2VQvuC4zrXO52LxLYp+jrKuT9ICM7FzOu0a65zOrYY5I3EGkcVQZdACR+Kq5kzt1q2NYfy4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321940; c=relaxed/simple;
	bh=23GL57ye74vveaYu/3CUzURuBoHACp2aCQAhOc/s4z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VncF0d+AbuxdvT3D4f2MutCTHJmKMPgB0yaVd8YrMXICzJat7XXgfYA95XLNo1IzllCP3Bbt/APZdioj7XuUC75canyYo6FT96aJcmwotECiSVhQ0hnxhFOi9zdOSxkcB5ETpRkWvOAVr3fJVKe/1fmr64dQrODKtQaqtv1sJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SESmlu4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680C9C433F1;
	Sun, 24 Mar 2024 23:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321939;
	bh=23GL57ye74vveaYu/3CUzURuBoHACp2aCQAhOc/s4z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SESmlu4juaXC/RGEj5HrB/iBinwxeIu9HKQtVlq635Y2wN7oA5quqn+JL3yJAz8Be
	 +yUTJnbkloPxFx/kwbE54b29szdGVXkxG4t5EJLf+ZHdWZradwxdp3nYSPKHlcZVpQ
	 8jhlRWip0R5FERY6oZqr4rEiRabQiD9024GuIJIyFyvaT0+o76pizlBGtGmQkzdu5g
	 u/SYUxN+AseCm9PwqCTFstqyqiiPVX6wUEbfhTG92eefxvT6Ix0DtE7t3czE2vzs/z
	 J1WEm8liAbe9RqB7/vfSjlItG/9qPwyd2zclkiikKcMSQsuueEStUnkgHMtdXyNTM1
	 a1u0KhHLtvl5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 010/451] nfsd: add some comments to nfsd_file_do_acquire
Date: Sun, 24 Mar 2024 19:04:46 -0400
Message-ID: <20240324231207.1351418-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit b680cb9b737331aad271feebbedafb865504e234 ]

David Howells mentioned that he found this bit of code confusing, so
sprinkle in some comments to clarify.

Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ab37b85b72077..50349449a4e52 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1094,6 +1094,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	rcu_read_unlock();
 
 	if (nf) {
+		/*
+		 * If the nf is on the LRU then it holds an extra reference
+		 * that must be put if it's removed. It had better not be
+		 * the last one however, since we should hold another.
+		 */
 		if (nfsd_file_lru_remove(nf))
 			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
 		goto wait_for_construction;
-- 
2.43.0


