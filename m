Return-Path: <linux-kernel+bounces-25692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB85E82D4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2851C20EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BAEBA2C;
	Mon, 15 Jan 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ilurDMY5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D38838;
	Mon, 15 Jan 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705304000;
	bh=QBJld2GpTQR5BTBjcyDUEA5vStcxynZ+NNL+dIDUE1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilurDMY55dNu+IPznIrJtRSBmJ9oU92YD3v1v5MzFV6U/QFwm7Zk6/rVuKGJZ650g
	 ejf0dbWxs0F2zvXhunqQiPSBBZqwcrKX8KCzdESCNYegLqsitab83WV2gvZZnXf/XH
	 8s7cXDzXICTjyHseKcpqh9igWAhWI30TFWgJNNZjXd4r1q4JTStgIcjiZz/CbTKB0k
	 RAB82h9ZvdqLe+hSNTlfT9sLFCPg+qYv1NvvvRf3dwVK9GpWgKLsFYJljn01k2DI4N
	 e8pcP4Z1WDXgHZZr6QEHsJVBe03F4qJisJkQILrgE7N0h5iQ60YCmYrm/yhC5UU4lW
	 WE0zZ6lo6+2Zg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 77B4A37813DD;
	Mon, 15 Jan 2024 07:33:18 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] selftests/mm: config: add missing configs
Date: Mon, 15 Jan 2024 12:32:43 +0500
Message-ID: <20240115073247.1280266-7-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240115073247.1280266-1-usama.anjum@collabora.com>
References: <20240115073247.1280266-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add configurations which are needed for
- hugetlb-read-hwpoison
- ksm_functional_test and ksm_test

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
index 4309916f629e..d16a72036eb7 100644
--- a/tools/testing/selftests/mm/config
+++ b/tools/testing/selftests/mm/config
@@ -7,3 +7,6 @@ CONFIG_TEST_HMM=m
 CONFIG_GUP_TEST=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_MEM_SOFT_DIRTY=y
+CONFIG_MEMORY_FAILURE=y
+CONFIG_HWPOISON_INJECT=y
+CONFIG_KSM=y
-- 
2.42.0


