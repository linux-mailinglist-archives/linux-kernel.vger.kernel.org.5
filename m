Return-Path: <linux-kernel+bounces-121065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94C88E30D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2459B252C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8E21607AB;
	Wed, 27 Mar 2024 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekLBkyJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A29B16079C;
	Wed, 27 Mar 2024 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541987; cv=none; b=VMgT/P8fvD3yD2njU4M+0QNZBhHoq17mhhY2KvIrN75pEpesQIXsIwiB+XIInKYYMVObqANGCas62/FINcFO0KtdI4Ye7UmofTfwAbaBf/ioXoR0dF3/cy1MhIMhewGlKVp9Qzmtp6qwMnhMTuH23BtmDBlsbaeyMEaBsut5qBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541987; c=relaxed/simple;
	bh=dxKl+wIsc5e+G+1JLzrhnnMSsQu/o2QjHtSTiYpzH6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNzkDcO0mFucFAOPsXzihRAMy8z3L9cd2uaG5lndE4gLdp5RMw73tuvYoi6+vvZlsJ4khGbezCiVQ7m7gpNjse5A2QmGTk32xSfiAuKee0GSBrWZA26d2JMxVmw6rjT/7+PxvgBciTRQXMQH4hsEbeSbfs/cqbdfOH0J3m3V1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekLBkyJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78983C43390;
	Wed, 27 Mar 2024 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541985;
	bh=dxKl+wIsc5e+G+1JLzrhnnMSsQu/o2QjHtSTiYpzH6g=;
	h=From:To:Cc:Subject:Date:From;
	b=ekLBkyJp+1C4fPNdDMjqC6IQOe/lersvkS16fkR1nKP8yv9OybsqQZGZx4QIpoVs/
	 gFXxdKqA26yWVR2TqzU160VEJ3IiP05GaX2/ygw0K3iCWpYXcJ/Y9xvzLvsyRXKJKZ
	 7ytnNxjviwGs0iwOxp/7PNrko+gqJ9eFO93DFd2L4h3UgV91mZJ5Rm+NpBEwoYva5l
	 YgPBOj0suRDDZnwffledi9k05f64+GV6KxwkwCcTktjTyJmfCafMqX/VYCfIvKWoBV
	 a+bimgZPP1EfYZuHM/kvIjo39TeQRmGknkeqWUQ/6Mt0v+9nmkJTpgkcOyt72arKVz
	 Yp3F20Nfis3vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wenjing.liu@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Nevenko Stupar <nevenko.stupar@amd.com>,
	Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: fix incorrect mpc_combine array size" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:43 -0400
Message-ID: <20240327121943.2835425-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 607e1b0cf480cb8dbd65b372397871d7389942b5 Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Thu, 18 Jan 2024 15:14:15 -0500
Subject: [PATCH] drm/amd/display: fix incorrect mpc_combine array size

[why]
MAX_SURFACES is per stream, while MAX_PLANES is per asic. The
mpc_combine is an array that records all the planes per asic. Therefore
MAX_PLANES should be used as the array size. Using MAX_SURFACES causes
array overflow when there are more than 3 planes.

[how]
Use the MAX_PLANES for the mpc_combine array size.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9b80f65c04664..a7981a0c4158f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1113,7 +1113,7 @@ struct pipe_slice_table {
 		struct pipe_ctx *pri_pipe;
 		struct dc_plane_state *plane;
 		int slice_count;
-	} mpc_combines[MAX_SURFACES];
+	} mpc_combines[MAX_PLANES];
 	int mpc_combine_count;
 };
 
-- 
2.43.0





