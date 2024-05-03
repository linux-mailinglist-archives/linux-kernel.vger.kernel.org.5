Return-Path: <linux-kernel+bounces-168001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B7E8BB213
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40141C22E0C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C09158D71;
	Fri,  3 May 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueOhhzQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D7158A32;
	Fri,  3 May 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759407; cv=none; b=MP6xo9o086fXmVYRc2itgdA0tU5c35QCE2pnzlv3o5tHd8/XQ+mijXWr13JnYDEv1f6bZZlb24NSmoG+aaasj2wkyADdTxObW5YIwGLtGpTA0IJ95SpCynApeqZpgwzbn+hgko+xhUTgNGHRkVjNKfJiAXj+xd+qwQplWqM2Lm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759407; c=relaxed/simple;
	bh=AS2JS3BGQVHo5RzbTVMIa5UQeXJ+fVLWbjaYsPF6V/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnLjw99rjEA2ypAu/zm7ceVbElSYdzupBi2LpV510QoxbJlnaSI+lSuO+H9vyr3zMuONLLwFp/gehZADv6YiYzwDfIGmn/pm8Xb5aGusZGYvV4lYeajDwIevzXtAno2Vc4QM9Jy5sWVst4+RCHJnvvpAJ0e6r0co9AyLapARYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueOhhzQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49F2C4AF49;
	Fri,  3 May 2024 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759406;
	bh=AS2JS3BGQVHo5RzbTVMIa5UQeXJ+fVLWbjaYsPF6V/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ueOhhzQVHOqQWS9hYd7/BOnLu3AxufgKPocOXtiZLC21qJmV/tqXZ61UompLt/MJd
	 +WVAZWgVSP9eVni1vx7w7nHUO/+7h6JQlu391AY1frY6stamIP3CGGUutmqakezWye
	 s/dYRTuD9XCUL49qOm8PjT5kc3Z7DWRP4jDyjRpZsrl8J5sRKJpdMTjfA86XtGDudR
	 QOevYHYzah/lMOmxfaYzul8yQPsENcjYKTXqc69dZfwQQRLegrgx3Af9MdlHGWpmab
	 SWfahDGBBQdx6ypo2/1tIBOCEnouQr1GEQiSV0YRQvAW9xuSeVTo8bXLtQViTC4sYJ
	 x0l/C9XFWnn2g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 06/10] Docs/admin-guide/mm/damon/usage: fix wrong example of DAMOS filter matching sysfs file
Date: Fri,  3 May 2024 11:03:14 -0700
Message-Id: <20240503180318.72798-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503180318.72798-1-sj@kernel.org>
References: <20240503180318.72798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example usage of DAMOS filter sysfs files, specifically the part of
'matching' file writing for memcg type filter, is wrong.  The intention
is to exclude pages of a memcg that already getting enough care from a
given scheme, but the example is setting the filter to apply the scheme
to only the pages of the memcg.  Fix it.

Fixes: 9b7f9322a530 ("Docs/admin-guide/mm/damon/usage: document DAMOS filters of sysfs")
Closes: https://lore.kernel.org/r/20240317191358.97578-1-sj@kernel.org
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 69bc8fabf378..3ce3f0aaa1d5 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -434,7 +434,7 @@ pages of all memory cgroups except ``/having_care_already``.::
     # # further filter out all cgroups except one at '/having_care_already'
     echo memcg > 1/type
     echo /having_care_already > 1/memcg_path
-    echo N > 1/matching
+    echo Y > 1/matching
 
 Note that ``anon`` and ``memcg`` filters are currently supported only when
 ``paddr`` :ref:`implementation <sysfs_context>` is being used.
-- 
2.39.2


