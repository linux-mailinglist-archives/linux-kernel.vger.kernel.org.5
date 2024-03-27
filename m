Return-Path: <linux-kernel+bounces-121243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC61F88E44E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6321C1F25B53
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BFA19DF4F;
	Wed, 27 Mar 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBxL0SrR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2AE19DF48;
	Wed, 27 Mar 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542440; cv=none; b=a2EEaL02G2RxT2cCjmNzsqjUbhkPiXey6GIwXpe3UEaj0xZuteHzx+lMtWXU1oRZ1Lt1vGCb96tl3cPi87F8GuA5YNTNdwU2wZpIOtBs/LxtljxKmitiSRZ84oioNmCO1UTl4mSq/phORzcniTDxDUleIWkJChwMU5NwbgO4LJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542440; c=relaxed/simple;
	bh=/xMPmw1QyAvIhaJcCnfVI75oQjfJszgTsbsj7toRqKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xp2doN7EFjly7sQ37UZqvN2/CZ53yCS6LR8dQcvJ4C6lUH6SyUg7ltk1WlVGyuCkcz8g/JTB/skz9Dovnj3Rwwp5MT9FbGOlmIM8Q5tB+M+TWN4I9QOgW0Bs/j8m2AQ2uLRkAZkfoLmUp2MK9UHDM/chON+AJvqHpM+iGsvEXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBxL0SrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BBCC433F1;
	Wed, 27 Mar 2024 12:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542440;
	bh=/xMPmw1QyAvIhaJcCnfVI75oQjfJszgTsbsj7toRqKE=;
	h=From:To:Cc:Subject:Date:From;
	b=sBxL0SrRT4uSKUs7/ssesE1qwQHdjkdqRmCOyWIcdQDaCtBbdvKTMBE5/kOXQXqUm
	 RQfrqOLAzAePSX/4kwAaLm1Ycc+EWWiKeI1LTkjbsrvld1jKVFnbnm0jYpk48AMN60
	 juySe0hx6V4R0a+6UrFOFnDT3xven760EAMLWIi2AOSCD2TeOd1tJbcbdXxDDW9Wj9
	 wiVni2PbtDCg22EMWR329F5Ay/aeotjlMHR87u8WTyp1t4rXQvsw6AZiATN29yl2bR
	 RrLSvKAw7rLnBOfBAr63RK8JY3iRJb+YMXR52wY+P/9YlTUgFMLAIEiVrebC6kKCsv
	 UUMBYRS9gd0mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	allen.pan@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Add a dc_state NULL check in dc_state_release" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:27:18 -0400
Message-ID: <20240327122718.2841800-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 334b56cea5d9df5989be6cf1a5898114fa70ad98 Mon Sep 17 00:00:00 2001
From: Allen Pan <allen.pan@amd.com>
Date: Fri, 23 Feb 2024 18:20:16 -0500
Subject: [PATCH] drm/amd/display: Add a dc_state NULL check in
 dc_state_release

[How]
Check wheather state is NULL before releasing it.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 180ac47868c22..5cc7f8da209c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -334,7 +334,8 @@ static void dc_state_free(struct kref *kref)
 
 void dc_state_release(struct dc_state *state)
 {
-	kref_put(&state->refcount, dc_state_free);
+	if (state != NULL)
+		kref_put(&state->refcount, dc_state_free);
 }
 /*
  * dc_state_add_stream() - Add a new dc_stream_state to a dc_state.
-- 
2.43.0





