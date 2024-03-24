Return-Path: <linux-kernel+bounces-114478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FA6889011
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68662910A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB82131BDC;
	Sun, 24 Mar 2024 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzXYUrTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465C524DC;
	Sun, 24 Mar 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321909; cv=none; b=k4Fdpqlzi1u0/vb0h4iX/Oh9Ncb/iNzCff/ThDwQXBPeOJOrBxMWiHIH75X2vCPeJ3XiRm7lqAcy13m2NKBTQVITrmQIWEYFjOArkXU2a2tvViaBwzSV8985pr8nbzxXJSSYAcWINt+AGYuBeECTaXVPJOdfhGCd9ZOxo1Cn6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321909; c=relaxed/simple;
	bh=jAV6KocoPoju+yep84G+uZuAveTyNh8+EiSgszBOvOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7z2btCUy3Gppx9yvwBQ+mHqRRgSp3F8rwritUCOi4tzhJbadtRAvAVCZfe+KaRWgXZJVG7qCLDzBfHftjt6j8+C5gdZrPr2+mCxLwsgRoa+iQ22scbDKzExNNedAOs0ZTQpOb+RucCBLPoxMEuXbaLz6oIVNXLVL09p2AEt/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzXYUrTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E75C43390;
	Sun, 24 Mar 2024 23:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321908;
	bh=jAV6KocoPoju+yep84G+uZuAveTyNh8+EiSgszBOvOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lzXYUrTevnG+qXdy2gR2hYhlxmjN7+zYLz9nFP/4r1Ia32UEYzSeu2QsZVCIsqnJN
	 ItVMsnA12N5thZJUagBcQ8rkoyLWH175xwDIoYQ206SVupsoCEObqm0SCLo4tG1/x1
	 r6PcUn2SjVd4jTjGoWa4NKMyKayU8P5rCapTjPQKTKGVOr9ROJqKT5PxVM3ClCHj7c
	 hRsu1AR9+aTUz1TEs1XdFlqUBfxrJgKNvgQbqd11oFFobyl5AQINs7KeDKtwzeiM/t
	 yoja6GKgm9tFO0snMwkB6q7VC8kTjvkHLoF3s96L5jQjRo17KNijgXYm7EvyOAqCfK
	 8l9kB9Pbw1z3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 638/638] Linux 6.6.23-rc1
Date: Sun, 24 Mar 2024 19:01:15 -0400
Message-ID: <20240324230116.1348576-639-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index c122a50e4b406..2e20c1fe168c7 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 22
-EXTRAVERSION =
+SUBLEVEL = 23
+EXTRAVERSION = -rc1
 NAME = Hurr durr I'ma ninja sloth
 
 # *DOCUMENTATION*
-- 
2.43.0


