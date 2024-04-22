Return-Path: <linux-kernel+bounces-154227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B2E8AD99A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8183287D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809E156C65;
	Mon, 22 Apr 2024 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSKrrNwT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31455156C51;
	Mon, 22 Apr 2024 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830057; cv=none; b=Uthp+H8lgTRE1sJgpybSPqd3Tg9h9mbKUK3OyJBkPRj9CXItXQNj23Vm6LHUUvtprVNRTBvgQZ4co5rGOAwR+wQBiL7/1BHObV9oxuwS+y9e9fpfpQAlAHB/oTwU12p3a26/v2inKu/0ZgsMWyrBBFkYpTtJlz06JzL4tN0iXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830057; c=relaxed/simple;
	bh=463WU74UafRM4JLsYmYPi8HB3ZVhJzdNeKKPSlj0sEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhdEDfvszdYlmuMNvsbDEolJTyzkEm4OnAZOJpWHS0rJmWX56YDFhGLYncBj7yy3dH5E0yeHZ5STBVsdsrlKQr4hTOR/HXhJ4tMy2aK0d9bMYlJdyaFzfy/I9oSz5nBcgwXHrjHL+N9PQiOBKP7MV1fh1yQxmFsFsBNg6XtrSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSKrrNwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F58BC2BD11;
	Mon, 22 Apr 2024 23:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830056;
	bh=463WU74UafRM4JLsYmYPi8HB3ZVhJzdNeKKPSlj0sEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSKrrNwT1Od+D3+l0fAajmyERkoyr4NQ8vkxZcgxr/1CU39YXpO1+8O9nwXIQBy3l
	 /VuhfcJ7i4bqZhzI0/IcEWqdbFVz66G97D0gTm/ACLGnosMk+GOy7I3mZ272PctK1I
	 XGAZVyCM5Z/DkA7nXdIoYgJF145BVpPoxrtnY/MWlZcWhx0sgUkn63U+z+MaPEMhtH
	 SdXc4M903w0DUvPNbue43GSHvYoXZ5VJf0YnhndykZwlv33JTrQQzZkmO5jjsloMAO
	 siTnMx6H8O/0Dn2r7e8AJQv7eFQApIhgN5KZDFJI3r78CjVaW9OW4hDj55tf6tkauX
	 uHP0N8bjU8QsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	rongtao@cestc.cn
Subject: [PATCH AUTOSEL 6.8 10/43] memblock tests: fix undefined reference to `early_pfn_to_nid'
Date: Mon, 22 Apr 2024 19:13:56 -0400
Message-ID: <20240422231521.1592991-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit 7d8ed162e6a92268d4b2b84d364a931216102c8e ]

commit 6a9531c3a880 ("memblock: fix crash when reserved memory is not
added to memory") introduce the usage of early_pfn_to_nid, which is not
defined in memblock tests.

The original definition of early_pfn_to_nid is defined in mm.h, so let
add this in the corresponding mm.h.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Yajun Deng <yajun.deng@linux.dev>
CC: Mike Rapoport <rppt@kernel.org>
Link: https://lore.kernel.org/r/20240402132701.29744-2-richard.weiyang@gmail.com
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index f3c82ab5b14cd..7d73da0980473 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -37,4 +37,9 @@ static inline void totalram_pages_add(long count)
 {
 }
 
+static inline int early_pfn_to_nid(unsigned long pfn)
+{
+	return 0;
+}
+
 #endif
-- 
2.43.0


