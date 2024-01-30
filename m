Return-Path: <linux-kernel+bounces-43727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95D84186A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34351F2576D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4837710;
	Tue, 30 Jan 2024 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U70W3FmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF051374FF;
	Tue, 30 Jan 2024 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578561; cv=none; b=EmYALy3meMOxobZX3Ug4xpaNttlvyZB7iDP7DiKVmcsrJfJ0Xvp7PHDEXIB6gU/w3UOJMl2TQitGqwOjtYI5+dO8M5JACgOj7vQYt2ztgp9IrsTA2uOBPJvXHJQaOX0JvpvjF1W15h1CLlUWtUKA4OQ7CQpALIHp/eTgn7Oqo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578561; c=relaxed/simple;
	bh=6XVXKH5SHkCRbfNXw+ACfRyxafwIyett+q0yka+zTjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNP3Vt5X6BdyQ9X7WsuJ60DCT/YFNjayliCy5ITb5mQZfPr0f7pquWnix7Ag6AwOnYrnCT+1yzsV/+l8mQMwwD+aKXY1y2zCqpRoi9EKDQUBLLl/xgE0cjdGD11UPvtZ3Ha8fO2svkq994DSgc5rvSmTHFp99wtXSyQ+kfZ93GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U70W3FmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088C5C43143;
	Tue, 30 Jan 2024 01:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578561;
	bh=6XVXKH5SHkCRbfNXw+ACfRyxafwIyett+q0yka+zTjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U70W3FmGU7i5j5k+6FsO/9Kid8M057PLCj+ZqfqXtFpo2kZarzQkd/flxN8967gcy
	 BO5hanenOLhNlpphcmPg8RgJSHXXVq4VWja4IuUlW+BfXiZO8Xw/WxMr9JoENbpPnY
	 41z+vRNmkYfoWWXOrYWap8yCizoBFjDT0UEhuTvvvUfOzE0NI2B8VzBW/kKzsi2CkP
	 8lT/oGQKMqaNivBOVAl1nQ5gOPaEUS0+qJTmd8BKagGH9QJVjSVX25MZ3Fwj8OTm1Q
	 KPMztpTPLxUeHrinN56K11jl8ae4cYwPXuSh0FywWB0wpLls7aEzSo8bx51ThXDANj
	 +WE+4TPfYD/WA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] mm/damon/dbgfs: rename monitor_on file to monitor_on_DEPRECATED
Date: Mon, 29 Jan 2024 17:35:46 -0800
Message-Id: <20240130013549.89538-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130013549.89538-1-sj@kernel.org>
References: <20240130013549.89538-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel builders could silently enable CONFIG_DAMON_DBGFS_DEPRECATED.
Users who manually check the files under the DAMON debugfs directory
could notice the deprecation owing to the 'DEPRECATED' DAMON debugfs
file, but there could be users who doesn't manually check the files.

Make the deprecation cannot be ignored in the case by renaming
'monitor_on' file, which is essential for real use of DAMON on runtime,
to 'monitor_on_DEPRECATED'.  Still users who control DAMON via only
user-space tool could ignore the deprecation, but that's what the tool
developers should take care of.  DAMON user-space tool, damo, has also
made a change[1] for the purpose.

[1] commit 935dae76f2aee ("_damon_args: Rename --damon_interface to
    --damon_interface_DEPRECATED") of https://github.com/awslabs/damo

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index fbc0cd63f34c..f7abbc0633aa 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -1091,7 +1091,7 @@ static int __init __damon_dbgfs_init(void)
 {
 	struct dentry *dbgfs_root;
 	const char * const file_names[] = {"mk_contexts", "rm_contexts",
-		"monitor_on", "DEPRECATED"};
+		"monitor_on_DEPRECATED", "DEPRECATED"};
 	const struct file_operations *fops[] = {&mk_contexts_fops,
 		&rm_contexts_fops, &monitor_on_fops, &deprecated_fops};
 	int i;
-- 
2.39.2


