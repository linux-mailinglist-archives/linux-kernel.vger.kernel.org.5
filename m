Return-Path: <linux-kernel+bounces-120922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348488E08B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93ED3B22D30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114C614A4D9;
	Wed, 27 Mar 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F86+gZ5C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9314A4C4;
	Wed, 27 Mar 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541591; cv=none; b=ZLHiAvUeuL8sxb+2sO0VW6TPXEUQbFKo5qerT7WWcwwBzgrczCLqYVb6k63/FUywpgkpUAUd7ZJjbm+d7BX8h4pAS+a4dhnLUjcK/T0+8rKuVBozV34mXDDJWKME/v6vo9j2/fxzw/PViZ8m/SWJwX2yxWtxWmoRnPD6PWPXGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541591; c=relaxed/simple;
	bh=Qx1f+Bit2PBGnmqeA+Zc2IHMtb50F5hJmJM0ePDd0as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrWdhTio5NJsF/CzXgaSib8AI/MahzbUtuMfjF0y9PXUDyITaRSDkTrXGWSdUz+lBCtyVkvD2GVVTtFyEi4Iee3Fs5+bB+Gh+bukl7a/8Uml93BRsv8rAG1Wo69R3BQhQ981YPeR5jOi5mHPqEJrujshGLkBgO4ZtUi66K7JlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F86+gZ5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3A8C433F1;
	Wed, 27 Mar 2024 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541591;
	bh=Qx1f+Bit2PBGnmqeA+Zc2IHMtb50F5hJmJM0ePDd0as=;
	h=From:To:Cc:Subject:Date:From;
	b=F86+gZ5CZ7HHFuORTI1NeshNQli207fWbAgCvsknK7t9H/LnYPj4glDG3eqXvVmX1
	 XiCEWcMpQEv+7HWwTPkEC+903cWyEQ+wm7Si46vbglJlgdoUWKyhNo7l27TuxEZVgG
	 rx4wOF+mgK6+P9CLGOdqeZZYunPk8k7G4a+ssk6GTcWmfIEDbR2GtANDxAcb+ze0Fd
	 QoyNpp4E5YqFjSU4+QHCW6hw5kxV+GyL7PtXdDvThswwoPRDNOb+V3nBmykjpE05U0
	 WF50ku2ezDIUtv49/DLuFh6BgTQSlWT1X1c7hhWdP3gXF9GhXXFpwguTc03aPi119K
	 xKweUqiSXmRIw==
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
Subject: FAILED: Patch "drm/amd/display: fix incorrect mpc_combine array size" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:08 -0400
Message-ID: <20240327121308.2830090-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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





