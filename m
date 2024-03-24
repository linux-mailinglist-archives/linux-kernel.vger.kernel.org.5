Return-Path: <linux-kernel+bounces-114713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF5888BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98651C29BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A12BD563;
	Mon, 25 Mar 2024 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6qyRSQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DF23C3EA;
	Sun, 24 Mar 2024 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322370; cv=none; b=m3q423d623gZSpX34nOSjKPMs9T4XwC/P3BKl32SpDXV8JZzC/63zCQ6gITUh3l1v+l3xQeEkwk1r+OlQr7GygZ99ltgj0vV1U+S3y/CX4o2SLFfn9nbQaA4ZgGvyWojF40gk47K9v4et5gG6vjmA8mMZQcbLeV2No5a1pu1/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322370; c=relaxed/simple;
	bh=8qJjLW9XF1pyEhVcFIWTS9VwJVoZTtUmgxQrVtwBhLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIBgP42c6DeeiQnL++KBYtB9+0qf4o4tRR9p4IjwMhZeq6nag9K0xLuYSh94LhQwnTqe3/x2e/9vavq5EIc/kU+jbRIQOyO38RHtBxzesMuTmeaVYtIV0UWCnDafWIKQr7J/XP7uR67HrgpKJNXRk5ayNFDu+6fPkCev1wGrQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6qyRSQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E91AC43390;
	Sun, 24 Mar 2024 23:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322368;
	bh=8qJjLW9XF1pyEhVcFIWTS9VwJVoZTtUmgxQrVtwBhLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6qyRSQLjwvrRirYnMe3XGqdEptk2ZCd01xws5LWIRon00igt6yPeOEiNxTp6Un1w
	 d4rsoUZ42h/cX5X4J2pCg/wTYDG7fx32jqoNOp++xdNnarCuRh+bLzt1fT1swBTMl/
	 EKp9p0kk5mASxhJHFEpQ1I88sygtHXl2OFDVUHT38ePcr60I7/Mz6JBf+Q0R4TZxUB
	 lna20FKW1O7CgrM9XhRoQg1sC5+pQQBlFr73n4KM12xg9yEWHcbm5yW9Jx0idQbJ3Y
	 m975sc+KjproSFPAoyfQ5GHRzA4tpGssn+ELpmLD0LJ4bmIasOoiTTL/etyAt3Q7LM
	 GABTcorysT6tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 451/451] Linux 6.1.83-rc1
Date: Sun, 24 Mar 2024 19:12:07 -0400
Message-ID: <20240324231207.1351418-452-sashal@kernel.org>
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

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c5345f3ebed0d..7085cea874b87 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 82
-EXTRAVERSION =
+SUBLEVEL = 83
+EXTRAVERSION = -rc1
 NAME = Curry Ramen
 
 # *DOCUMENTATION*
-- 
2.43.0


