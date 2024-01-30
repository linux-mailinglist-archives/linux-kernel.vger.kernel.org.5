Return-Path: <linux-kernel+bounces-45137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37104842C11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F4D1C2465B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084AD79923;
	Tue, 30 Jan 2024 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cvR/3SDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC012BEBD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640406; cv=none; b=AXCoUlo8Yvo2206uSxFk/Ur+uPoY7U1bqtvFlEzZYXNi0Lg7/Gms8iS2kRVXD/wMX6kdJV0JADjXhy6DH2wObfOCa9pIQfxkitEAteKcwBRG1zF4IhGPm3Gn7QVuWKK99zc9LGQqbboPnB3LwZCrkNn8hrqzLVwE+GHnZnxeTpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640406; c=relaxed/simple;
	bh=EAByQhXyu/+Nq0/YEitbsn1bxLp9uFAhGiUot7pVcwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLVxHr7QLenwoU5E9QKNG+znOz3LNZ22zC3fLBpzunYW+dLx+6VQJEt3B9jyx524brlj1lmCCMKXc8NZrFkZHgBGNTQUfpn8oERZH00/LK0MHzl5QA43L/Xz+nzWk0qUlq7zoTHsW3B304gvojuGx0eo6oxOTPsLFYcWRds+hQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cvR/3SDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08DDC433B1;
	Tue, 30 Jan 2024 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706640405;
	bh=EAByQhXyu/+Nq0/YEitbsn1bxLp9uFAhGiUot7pVcwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvR/3SDGO4jTwkZ5iAip4p0J9YwtCR4gfiJOQ9HwN9++C/impGwuYy17Bk7FeEZon
	 WKSLPpavHEe8u1jGIknmoYjShSFbVOiObMq9ssSXYRazX9QZlvNco91PnEPTt0sXeR
	 tk/EuoyJMviDztCrMyCIMX4qrzbPrsCQE//z1wwI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 6/6] soundwire: sysfs: remove unneeded ATTRIBUTE_GROUPS() comments
Date: Tue, 30 Jan 2024 10:46:32 -0800
Message-ID: <2024013031-tranquil-matador-a554@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024013025-spoiling-exact-ad20@gregkh>
References: <2024013025-spoiling-exact-ad20@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 43
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=EAByQhXyu/+Nq0/YEitbsn1bxLp9uFAhGiUot7pVcwI=; b=owGbwMvMwCRo6H6F97bub03G02pJDKk7Xdg/LmraJeW/8MSxm48mi0WrKM6cWl/kw3Jtq4FSw rbUW9P4OmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi5ecZ5sd8rV52tMg7taio 0EfyyJ6VXXvD+hgWTBezWyW2vSXnLv/X/6saZFKXHT9sDwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that we manually created our own attribute group list, the outdated
ATTRIBUTE_GROUPS() comments can be removed as they are not needed at
all.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/sysfs_slave.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 0eefc205f697..f4259710dd0f 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -129,10 +129,6 @@ static struct attribute *slave_dev_attrs[] = {
 	NULL,
 };
 
-/*
- * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
- * for device-level properties
- */
 static const struct attribute_group sdw_slave_dev_attr_group = {
 	.attrs	= slave_dev_attrs,
 	.name = "dev-properties",
@@ -204,10 +200,6 @@ static bool dp0_group_visible(struct kobject *kobj)
 }
 DEFINE_SYSFS_GROUP_VISIBLE(dp0);
 
-/*
- * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
- * for dp0-level properties
- */
 static const struct attribute_group dp0_group = {
 	.attrs = dp0_attrs,
 	.is_visible = SYSFS_GROUP_VISIBLE(dp0),
-- 
2.43.0


