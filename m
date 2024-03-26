Return-Path: <linux-kernel+bounces-119264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA9F88C659
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8FA9B236AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A3F13C9AA;
	Tue, 26 Mar 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NikPNzag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D713C90E;
	Tue, 26 Mar 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465606; cv=none; b=N8LxHV75quZZnezXE3eLjJDHY3qndXMHbtnLAW5Y8mFjPDA4n4mDoqrbnzpCOj5Ycb9WYqHUMVfsMuUhpUb5ZnrzXlN6sloB8VjwlHh+fQvdBkFcH1o9NahbD6wwtwI2CAda3HYfIjN4fALHkJzW5Rl+vdUk39efnq+VHzdDQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465606; c=relaxed/simple;
	bh=01R4o89skC9mMhEqK+LcqdaFSJT7bI5I12tQM6+HOi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NaOdHwdFmO9mtrfhtirC4YqtOBDMP9OVTUmW+LMZFxs7JJZN2o0nr7cNXflkoiM1HnMAK2Ac65pDOm5pwJv+mSP5A5pGhGLQjCi/XEMCuJtDFFFwTMzCacbe+hDOjXeTqsd4jiuwv/oLfBr6SjEqNk80COY8yLi+xsN7KSMkWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NikPNzag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C59C43390;
	Tue, 26 Mar 2024 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711465606;
	bh=01R4o89skC9mMhEqK+LcqdaFSJT7bI5I12tQM6+HOi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NikPNzagaQ+CDSMXqShgXElR3I3yb4Y5dbO540Uu6Vzcmj56Q7TnbPGxjhqYHT0Oq
	 0l2t81kChzsS1DS5H1Abv4IMzTMLJZ/wr7pMjF0PiSbDDaqehiU9U05HiTpJ0GtbrU
	 HeU0d5eSswKAoq02FnD2IOEE1nAIE7DUvzOViAXlt8ADQvxT/E71pNaIM7PG8X15Xa
	 ZkDZs3NGO/6+oyeA6L9UTXl55dmtG+IPg42mn8uL6zE+mY6gDwFJg/3z/U9bIBcLr/
	 Bl3mLUuIHxqVAeWXG91h/Qst/rPYkS8J35DFvgLSgxjFW+Te6Nq2owULyKqH4011+s
	 fvkwa3CQlC4LA==
From: Bjorn Andersson <andersson@kernel.org>
Date: Tue, 26 Mar 2024 08:11:32 -0700
Subject: [PATCH 4/6] drm/msm/dp: Use function arguments for aux writes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-msm-dp-cleanup-v1-4-e775556ecec0@quicinc.com>
References: <20240326-msm-dp-cleanup-v1-0-e775556ecec0@quicinc.com>
In-Reply-To: <20240326-msm-dp-cleanup-v1-0-e775556ecec0@quicinc.com>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3889;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=OGQGdcYpP/wYyvD9AcFcPxIGkVinB3aiEgxfZBK8ts4=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmAuWi1kOqvXMLrq0dCKxSnv3iMCr1CKkr5hEGk
 EjUkd6kPUKJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZgLlohUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXKlA/+Psn2oZyyM5bfZYqL/17qHfBtGblE4Og7NO0Rr4R
 KDwYmNNRsGGR+kfKzofLIn7LyCpEbWNyvxugh3Z2XLIo8gKAf7o80w4VNP9ladmjT9qIcp80bY6
 yLIb8weLoDiuTG8Jj/EvGgS5aVnZxJrxAI5DozUWPRQo6suRqNcoeljziav9RHNX0dP171fVwTt
 jfXqpfSJHgiBxlbBNu3bQ4tPbCqxUiqBBszLFKzJ5yMY84Ih9V7Eq5SBHjA56tufdxxPpIkzVU1
 NsKw6w12ZfEIYhMOFlJFYFWCD/0fJ3B3aKrNd2le8Hzlb8F5oZupQnETFc9DnOYTu7gxznPrrFs
 6xkRbMyhwxOBx/1drVwUl4Dvs2QP6laK2AzKeQLNR757HAOAZTbgKvNJ528+Mu/Z8sYQmHXQUnj
 v8SIGcxuSqNPQKhnkXUydNj/kha83OtyvMnLXAX4QsEgXLNmgVkMxQ7Nr4ZMHfhWDS6j4Cyjbvl
 3wLFECmNSBK4wTRtLouVbzHHzQ69TsCtwqOXufV36ATfKLr38OfmEeJYaEWlE0PG6Zaxq2iACKX
 gWbDTTKTVdVa+8dn7JJstCY7haXF52xCRQwGle1AWn3usYPixhB1GIoZXpN6VovCBrwo7nMxsnG
 6dJRTaruXIU6WSdLBakNQRKIx7bxceKHtQLSyk8Y/LZg=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

From: Bjorn Andersson <quic_bjorande@quicinc.com>

The dp_aux write operations takes the data to be operated on through a
member of struct dp_catalog, rather than as an argument to the function.

No state is maintained other than across the calling of the functions,
so replace this member with a function argument.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_aux.c     | 9 +++------
 drivers/gpu/drm/msm/dp/dp_catalog.c | 8 ++++----
 drivers/gpu/drm/msm/dp/dp_catalog.h | 5 ++---
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index adbd5a367395..2c8bcc60692a 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -87,8 +87,7 @@ static ssize_t dp_aux_write(struct dp_aux_private *aux,
 		/* index = 0, write */
 		if (i == 0)
 			reg |= DP_AUX_DATA_INDEX_WRITE;
-		aux->catalog->aux_data = reg;
-		dp_catalog_aux_write_data(aux->catalog);
+		dp_catalog_aux_write_data(aux->catalog, reg);
 	}
 
 	dp_catalog_aux_clear_trans(aux->catalog, false);
@@ -106,8 +105,7 @@ static ssize_t dp_aux_write(struct dp_aux_private *aux,
 	}
 
 	reg |= DP_AUX_TRANS_CTRL_GO;
-	aux->catalog->aux_data = reg;
-	dp_catalog_aux_write_trans(aux->catalog);
+	dp_catalog_aux_write_trans(aux->catalog, reg);
 
 	return len;
 }
@@ -145,8 +143,7 @@ static ssize_t dp_aux_cmd_fifo_rx(struct dp_aux_private *aux,
 	data = DP_AUX_DATA_INDEX_WRITE; /* INDEX_WRITE */
 	data |= DP_AUX_DATA_READ;  /* read */
 
-	aux->catalog->aux_data = data;
-	dp_catalog_aux_write_data(aux->catalog);
+	dp_catalog_aux_write_data(aux->catalog, data);
 
 	dp = msg->buffer;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 55114a6aba7e..295bd4cb72cc 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -169,21 +169,21 @@ u32 dp_catalog_aux_read_data(struct dp_catalog *dp_catalog)
 	return dp_read_aux(catalog, REG_DP_AUX_DATA);
 }
 
-int dp_catalog_aux_write_data(struct dp_catalog *dp_catalog)
+int dp_catalog_aux_write_data(struct dp_catalog *dp_catalog, u32 data)
 {
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 				struct dp_catalog_private, dp_catalog);
 
-	dp_write_aux(catalog, REG_DP_AUX_DATA, dp_catalog->aux_data);
+	dp_write_aux(catalog, REG_DP_AUX_DATA, data);
 	return 0;
 }
 
-int dp_catalog_aux_write_trans(struct dp_catalog *dp_catalog)
+int dp_catalog_aux_write_trans(struct dp_catalog *dp_catalog, u32 data)
 {
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 				struct dp_catalog_private, dp_catalog);
 
-	dp_write_aux(catalog, REG_DP_AUX_TRANS_CTRL, dp_catalog->aux_data);
+	dp_write_aux(catalog, REG_DP_AUX_TRANS_CTRL, data);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 2c2dbeee7634..290ef8180c12 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -48,7 +48,6 @@ enum dp_catalog_audio_header_type {
 };
 
 struct dp_catalog {
-	u32 aux_data;
 	u32 total;
 	u32 sync_start;
 	u32 width_blanking;
@@ -64,8 +63,8 @@ void dp_catalog_snapshot(struct dp_catalog *dp_catalog, struct msm_disp_state *d
 
 /* AUX APIs */
 u32 dp_catalog_aux_read_data(struct dp_catalog *dp_catalog);
-int dp_catalog_aux_write_data(struct dp_catalog *dp_catalog);
-int dp_catalog_aux_write_trans(struct dp_catalog *dp_catalog);
+int dp_catalog_aux_write_data(struct dp_catalog *dp_catalog, u32 data);
+int dp_catalog_aux_write_trans(struct dp_catalog *dp_catalog, u32 data);
 int dp_catalog_aux_clear_trans(struct dp_catalog *dp_catalog, bool read);
 int dp_catalog_aux_clear_hw_interrupts(struct dp_catalog *dp_catalog);
 void dp_catalog_aux_reset(struct dp_catalog *dp_catalog);

-- 
2.43.0


