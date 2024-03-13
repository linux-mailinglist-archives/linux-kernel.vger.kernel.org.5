Return-Path: <linux-kernel+bounces-101939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BF887ACE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E86A1F271B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C0135A6B;
	Wed, 13 Mar 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD61gzKO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F31350D7;
	Wed, 13 Mar 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348084; cv=none; b=kpBe9UugXsIxBY77mCw5tAYvn5lBSKE53zD13nujT4tR8JO7siSw/gQgm5ayBpx9kSlcFSl2/jtau0h4NfBAlxozz2DdAOmnNMzVLLrdYwJvPRwkurIuDRaqURUkCI56yFg1IBRRsTkKcPTTJMBiRBj9fSaOPbpi58VC4kTNJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348084; c=relaxed/simple;
	bh=rtsg0VBG5axLQC4wKIXSkKCE+BH8bTP12lAv0y8cPhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GItTZk2pgHCXGOjM9GN2SEaIMv8ffVklhHzHHy7ilczT8hgIFQLmx7GCYF0GzoBymAeTZ093bQg8Rme5RR+HOSTeGRKTrMgrdOVyjHZgJY/3YdMbKXLZQ7DiKfrAV1r9yuI3N/xdp8n0NDPfpYDOFjMOK+G6vJ/jBbbi8vvXCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD61gzKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A8C433C7;
	Wed, 13 Mar 2024 16:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348083;
	bh=rtsg0VBG5axLQC4wKIXSkKCE+BH8bTP12lAv0y8cPhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hD61gzKOKdRs95TgpdeMZtgwi8bGs9UNVp9mSxJ/EIAAkTSGQSwvQ3HYQvWQxv7pc
	 g6kLWpRUBAZQgUsqYR7DJlFWkUG0WfNHWZsgT/ffKOc1tz9we/2OZNTkf5hAzHZlJh
	 rtjOMKFvDQaeD6td++7DrE6vvqoY52QtXfqomyxPP52L8PmwQdK2S0336LlgA18zhQ
	 SygfhorbnrMDCPXAmIk313HrB40PHFmlmTW3/HEGW8ekMCZiEys58oJ19o1PCXqYoG
	 z6eWBy+7ACWVf4v4vaLrjRG/UVQ2ao21+Mi1pjKhA8a2It7R3ujl88+s3qQqZtQf1V
	 HWHvjEXgwnjGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 71/71] Linux 6.1.82-rc1
Date: Wed, 13 Mar 2024 12:39:57 -0400
Message-ID: <20240313163957.615276-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e13df565a1cb6..7b56c31cc79ba 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 81
-EXTRAVERSION =
+SUBLEVEL = 82
+EXTRAVERSION = -rc1
 NAME = Curry Ramen
 
 # *DOCUMENTATION*
-- 
2.43.0


