Return-Path: <linux-kernel+bounces-86771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C55286CA89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4A51F2274F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C18626A;
	Thu, 29 Feb 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeE1KY3t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C97E56F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214217; cv=none; b=i+YUWp3yvAp3/hVCuOiWN2MeUwEWJxqQiBEafxinSFOX6FR6cRWjwdnKpWcle4FsIr6N73lXATS1k0CulKoYEzlgMScGjyUVCAgg3I0idjLnCioZIGnZSGhqGjlFWCBTFP16h2v0Jnbv4yAv4zWuT7vT/Wg1dz0BW5QEFcAWIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214217; c=relaxed/simple;
	bh=HZ6+9Mbpn1I8cryuXkULAc0fYJ2z+EeV7bESY05zesw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t92adKYUS4BvZ3zfeoCyI30OVict7Ym1HDI04beqL4NtS3VpGpXwNsGVZfR6pNsWHZWkrO2C+v2N/bNsrPe8sWfb9Pa09zUYaSi6mpL1s+W1MA/V9DRG7kZLK8Yf9pjd7KMIbiOFvqQggBMrM34KGjDdmG5UVGOcM0FXgNMmgVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeE1KY3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2DAC433F1;
	Thu, 29 Feb 2024 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709214216;
	bh=HZ6+9Mbpn1I8cryuXkULAc0fYJ2z+EeV7bESY05zesw=;
	h=From:To:Cc:Subject:Date:From;
	b=JeE1KY3twzJZDDh/9LyW0zBnuUAdjmMj8SuWbu8s+b/dOaDuUSqzCa+uJvpV+he6/
	 QByoWzQhXzJCqg0fj7ktk1XjM2LP9Q/6LVtsI8Pw1V8Cb87y7UTCl4h+CUfZc5Ye9s
	 I3oA5+CnPLge1KqppvvbJVdvJkjHBHsKP6WFjxgb2k7U78jamIN3zhjAexDEzdDQ8o
	 6uMkNTezI45ocdAkmYUNHLNQHMj0Uxx1YSoBsW+sscTLGWINBvIO5rPq5OMdIlx8D1
	 wMmmAOxfJa4XBUHS+CbpV5gMIFSvDv68T8Jz7+M2Lx0ZO/mGCgIqBqgxVb6fyF5TtG
	 oCRUaqNoozZHg==
From: Niklas Cassel <cassel@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] mailmap: Fix Kishon's email
Date: Thu, 29 Feb 2024 14:43:18 +0100
Message-ID: <20240229134318.1201935-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kishon updated his email in commit e6aa4edd2f5b ("MAINTAINERS: Update
Kishon's email address in PCI endpoint subsystem").

However, as he is no longer at TI, his TI email now bounces.

Add the same email as he has in MAINTAINERS to a mailmap, so that
get_maintainer.pl will not output an email that bounces.

(This is neeed as get_maintainer.pl will use "git author" to CC
people who have significantly modified the same file as you.)

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 08f28f2999f0..94597524472e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -325,6 +325,7 @@ Kenneth W Chen <kenneth.w.chen@intel.com>
 Kenneth Westfield <quic_kwestfie@quicinc.com> <kwestfie@codeaurora.org>
 Kiran Gunda <quic_kgunda@quicinc.com> <kgunda@codeaurora.org>
 Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
+Kishon Vijay Abraham I <kishon@kernel.org> <kishon@ti.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
 Koushik <raghavendra.koushik@neterion.com>
-- 
2.44.0


