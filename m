Return-Path: <linux-kernel+bounces-168004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B18BB21A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2163A281D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6B21591EF;
	Fri,  3 May 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzzkfqr+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACE158DCB;
	Fri,  3 May 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759409; cv=none; b=Lg7wtvYMr0pUV/08uM9yBzU3sgWKYsjCtOltmFPxiKljSAqj+ZKuPrFvXaRlrmqXp0XVXrlp5IFesjCkykyZufqaJR9k3TffBBQNsVBW3SL81T0RC/CcUgBdRlIcDiWyQoAqxC2+Gk6PQMFkfLc4HZVOqXuXQnYZBbh4jUByAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759409; c=relaxed/simple;
	bh=vvc+A8ByGJ8xt/IgKthXz7OStObcnnunoP3kVT7p2/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XxT7XVkU5E3eLnciYZW6b7021xnWHdJvTtx02e8MwePW8pyePwaVD9xaoIb6IC1WAzWAxBTGgc5MmtvJlmak4/QSxGsMIBfm+LSRlDShn9kTNukF7yXTcALSCmujyVPTKD6+0mMa76kgmgr/9I0Y7vn2yfeHbh06uTSZ2enTplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzzkfqr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E1BC4AF48;
	Fri,  3 May 2024 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759408;
	bh=vvc+A8ByGJ8xt/IgKthXz7OStObcnnunoP3kVT7p2/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gzzkfqr+kVCfXlIKoHA2gbCdNyEFbHbZh2BRCGxe0x3lv8EucgG8XZp6zvKD1iThb
	 aOAvuMnXwXzfbJgJfGR63SjlpMHoSStan0RleGxeDpgHzHrulAsTdSc2BlsL2gYdlD
	 d2GE25HvkZ+/cgX9u2WAmhfaTfMOHutdtvuiyCjLETlL9Yovp0As3Rdu0o1zmVp6ex
	 S8ns2yGBVmfzM2ARcz3sXb6R/zMXo5YF6VXSb+bdslYyozEIK6ll+zCnVMgMss3wZe
	 vz1aFxisyDfxSMLDc1FWiorLrPkx/fUvUGK7BUg8pF1E5bBh2YTjzsCJ1NRvCVnoOX
	 ZqTqBDoSXDTdA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] Docs/mm/damon/maintainer-profile: change the maintainer's timezone from PST to PT
Date: Fri,  3 May 2024 11:03:17 -0700
Message-Id: <20240503180318.72798-10-sj@kernel.org>
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

The document says the maintainer is working on only PST.  The maintainer
respects daylight saving system, though.  Update the time zone to PT.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 5a306e4de22e..ea42f57cf9dc 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -48,9 +48,9 @@ Review cadence
 --------------
 
 The DAMON maintainer does the work on the usual work hour (09:00 to 17:00,
-Mon-Fri) in PST.  The response to patches will occasionally be slow.  Do not
-hesitate to send a ping if you have not heard back within a week of sending a
-patch.
+Mon-Fri) in PT (Pacific Time).  The response to patches will occasionally be
+slow.  Do not hesitate to send a ping if you have not heard back within a week
+of sending a patch.
 
 
 .. [1] https://git.kernel.org/akpm/mm/h/mm-unstable
-- 
2.39.2


