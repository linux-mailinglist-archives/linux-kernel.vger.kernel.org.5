Return-Path: <linux-kernel+bounces-154259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10D88AD9FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A44286BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C20A156663;
	Mon, 22 Apr 2024 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjPWbYS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBDE156640;
	Mon, 22 Apr 2024 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830146; cv=none; b=WrT4Vp3RFLW81goS0gw8h8zNCOtvQhy/mrU25N4xzuv4J+hEK/01LjBDM2NputGfVWQieFGHYcbpb9ZJKMu2InjygDawBuAGbhmrYbfRdldhWqvc3L1nEXZ0JYpMtFJmA+15VdMH5NtnHs/kzutsiUl+1xpg+jxwe2xw8z0UiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830146; c=relaxed/simple;
	bh=JZovStquSIaFzvyDi9CKIc+HCVtPwfuX7GXprIPv8QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doxkBjhV74qViujIX7nLdRutr8SCfzbesdSQS5y5hytXDXLgmygeMOEAZIAVeFd382KeJ7ll6M8dWGnyUmEjPWKCK8+TuOiBYP2iN/+HKH7EpX+XAJJEQDNqeRnXTzWxg/R4mmqVaRBve5WtSKLUC9jKkwOEvpet8AR+K5z2k0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjPWbYS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B209C2BD11;
	Mon, 22 Apr 2024 23:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830146;
	bh=JZovStquSIaFzvyDi9CKIc+HCVtPwfuX7GXprIPv8QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjPWbYS90b8MjKLmVkB25PQTvQwaotI0ea01GaiHmEgk+ccbhOfvZ8Eqr+xonM3f8
	 H7YQna0k00/q6NRZalq0BnECwl+29D1ZFr2u0dIf/M5nzEZ+FTwpnWPbeDpvncLyGh
	 aC2iIbc+m8EUMF7Cn+KROS00txoz2yv1ibCsX4ZhjccF681q5873gj9TiPNcyI4F+K
	 HzEPKEMxWhZrjbbC0Jm1UHx69EcVQ/soCVnRnSwJcjApblgNqkmcXdRnt0pPbf0Vs9
	 nt6QBDm/FX6Ugcc3XBeeAShGvAKzOdcQGRZEvJjXyw8iDuWFtMZAo+3OSXbd+eQEni
	 sIlXRNJ8GxqKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	rodrigo.vivi@intel.com,
	jose.souza@intel.com,
	tejas.upadhyay@intel.com,
	niranjana.vishwanathapura@intel.com,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 41/43] drm/xe: Label RING_CONTEXT_CONTROL as masked
Date: Mon, 22 Apr 2024 19:14:27 -0400
Message-ID: <20240422231521.1592991-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Ashutosh Dixit <ashutosh.dixit@intel.com>

[ Upstream commit f76646c83f028c62853c23dac49204232e903597 ]

RING_CONTEXT_CONTROL is a masked register.

v2: Also clean up setting register value (Lucas)

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240404161256.3852502-1-ashutosh.dixit@intel.com
(cherry picked from commit dc30c6e7149baaae4288c742de95212b31f07438)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/regs/xe_engine_regs.h | 2 +-
 drivers/gpu/drm/xe/xe_lrc.c              | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_engine_regs.h b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
index 5592774fc6903..81b8362e93406 100644
--- a/drivers/gpu/drm/xe/regs/xe_engine_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
@@ -120,7 +120,7 @@
 #define RING_EXECLIST_STATUS_LO(base)		XE_REG((base) + 0x234)
 #define RING_EXECLIST_STATUS_HI(base)		XE_REG((base) + 0x234 + 4)
 
-#define RING_CONTEXT_CONTROL(base)		XE_REG((base) + 0x244)
+#define RING_CONTEXT_CONTROL(base)		XE_REG((base) + 0x244, XE_REG_OPTION_MASKED)
 #define	  CTX_CTRL_INHIBIT_SYN_CTX_SWITCH	REG_BIT(3)
 #define	  CTX_CTRL_ENGINE_CTX_RESTORE_INHIBIT	REG_BIT(0)
 
diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index b38319d2801e0..ae5cfad646ec7 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -525,9 +525,8 @@ static const u8 *reg_offsets(struct xe_device *xe, enum xe_engine_class class)
 
 static void set_context_control(u32 *regs, struct xe_hw_engine *hwe)
 {
-	regs[CTX_CONTEXT_CONTROL] = _MASKED_BIT_ENABLE(CTX_CTRL_INHIBIT_SYN_CTX_SWITCH) |
-				    _MASKED_BIT_DISABLE(CTX_CTRL_ENGINE_CTX_RESTORE_INHIBIT) |
-				    CTX_CTRL_ENGINE_CTX_RESTORE_INHIBIT;
+	regs[CTX_CONTEXT_CONTROL] = _MASKED_BIT_ENABLE(CTX_CTRL_INHIBIT_SYN_CTX_SWITCH |
+						       CTX_CTRL_ENGINE_CTX_RESTORE_INHIBIT);
 
 	/* TODO: Timestamp */
 }
-- 
2.43.0


