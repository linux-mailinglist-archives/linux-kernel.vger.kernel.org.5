Return-Path: <linux-kernel+bounces-116110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E83A88994F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9861C2CC9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D7229BFE;
	Mon, 25 Mar 2024 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGTyXoGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4717994B;
	Sun, 24 Mar 2024 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323611; cv=none; b=j5SBqTgKlwsyKKx3xomeM0F+COrIMugC2vhrfvuHPCqpXdUBm3UkauMIcBhGUW+9X+bqHBwLdJKC0GjHJVGifypc0VkfHXBTFz76K1rUGC1nmri4IJfFVTRS220qYLW72pXMxmtCyEFaIeo83xuvFLEF8HgibtYmIg1E8jBssgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323611; c=relaxed/simple;
	bh=rKNk1Mw5Koh8ee6XK1a+7nOSiONMXt5TTFlMobCF/HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fX1Rmc/UGzWSfFSWwx9h8SU0Z+tgZ8QcSaCRmfrJtP0i+fqFnoDVIkKIM8S5azAMTU1CLt8Bthnz1RUWnTZXhHQ7C4Yahc0j8gpOYsg/cNoWCIHjSVxlw7DRC7dVUgGY87MoYR+hpOpiX6zYf1iUSTFUY6lSrfBftz0DD7+DRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGTyXoGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E591C433C7;
	Sun, 24 Mar 2024 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323610;
	bh=rKNk1Mw5Koh8ee6XK1a+7nOSiONMXt5TTFlMobCF/HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGTyXoGZuAt23Jc41DnuOhsBKrEJIdu05Zh5DIJ+49txwi5TC+OxFDjklfqBMnC4R
	 AUrOt96E8FAG6r1bm+qT5JFVOosoN1/j0Dxak0AnaHV7dodKyzlxwBDndzAHRAI9Ct
	 mn12JUV0zBM4bqK0L5eNC5HWmFz2D4CWl0/4PX0SD+N0FGnExVVBjUI1ZgB/HCWFjM
	 P+BH4JgcRL9LSuoCLLyP7IZwBGNkQCThxorrNq5Z2ynJ0jBF7ojE6sggqn/BRvjzAo
	 SrUUu9yG3ahB7I7mNy9fwv/Hko1HJbgtf5coGizbjdd8fCg6kLztmD14vMo8VWVlZR
	 0ueFCBDkS0jdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 317/317] Linux 5.15.153-rc1
Date: Sun, 24 Mar 2024 19:34:57 -0400
Message-ID: <20240324233458.1352854-318-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 918a73d3976f9..bdd523cd005d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 152
-EXTRAVERSION =
+SUBLEVEL = 153
+EXTRAVERSION = -rc1
 NAME = Trick or Treat
 
 # *DOCUMENTATION*
-- 
2.43.0


