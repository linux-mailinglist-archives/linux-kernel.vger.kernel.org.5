Return-Path: <linux-kernel+bounces-101737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26CF87AB27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD771C220DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9628C52F62;
	Wed, 13 Mar 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhBFpioB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050751010;
	Wed, 13 Mar 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347428; cv=none; b=uBKfVa29zTLMR9BGlgRAwIM65h+i4KPf0jlAn+84myGF8arRh0G7VxyMjAgDUhclUqIH49qwDmkEq1iCzRYnyT883oiN+pCepNJ/ZPS18HWi+b31cO7Dq73vhmufRryABw1nHBBKSuOjZDk3TLPBM+sjNazLn5rJB+PMkt08+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347428; c=relaxed/simple;
	bh=LjT/0/XudnAuY5+cjtDpzEs5HoLDuWH7ay6vr12K+w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnOMyjloQNWUNnoaFXJbkYuJ40ldiKn54cAHZzSFLji3xqjPmQVNVJ5IdQxZojysZp485wvWIMi6PC/GWwFulGq79elHjUo+M4Lk9QHdDTuuJ/qn5T8qU1vzFKckVAc5hVQwKW7J3UM8to9AfmAT1DrRJKBvSh7tzpsnyktr6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhBFpioB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF83EC433F1;
	Wed, 13 Mar 2024 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347428;
	bh=LjT/0/XudnAuY5+cjtDpzEs5HoLDuWH7ay6vr12K+w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhBFpioBapWuATnd7KNUtgqaFGriaZcKi02UUaA4GeUHYJKzryKeAn616e+QOKoGi
	 qZ/a8AeZuwSyptmhLcoSpav6GEbE3594BS0OYFSVNsVCDKG2d9/wPwgLvyoXglxoRC
	 Lxqtlm8SpJlS8wG+5juxUWtOuzFhMuZz/i9e4NL34z33j3eKoPAUQlrCDTEqt7AzN3
	 B76idTOJy5zxQbv4cuR+H/TtA7bGwRKlMnORdEh308w5l6IoDKFpGGnsVuiePUgT6E
	 Uonrrx9re5/8B4WMA2TXnup5aeHoLeWKYXdCsAVXi7xZC+qzLmjX6LpskdQlQWaOP0
	 cTCc86aIvAstQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 5/5] Linux 6.8.1-rc1
Date: Wed, 13 Mar 2024 12:30:19 -0400
Message-ID: <20240313163019.613705-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163019.613705-1-sashal@kernel.org>
References: <20240313163019.613705-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.8.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.8.1-rc1
X-KernelTest-Deadline: 2024-03-15T16:28+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c7ee53f4bf044..dd0b283998d00 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 8
-SUBLEVEL = 0
-EXTRAVERSION =
+SUBLEVEL = 1
+EXTRAVERSION = -rc1
 NAME = Hurr durr I'ma ninja sloth
 
 # *DOCUMENTATION*
-- 
2.43.0


