Return-Path: <linux-kernel+bounces-121196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211688E3D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289581C2B3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677ED1836CF;
	Wed, 27 Mar 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvES3qf/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E213EFEE;
	Wed, 27 Mar 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542320; cv=none; b=O+VG4wJY5DOu7qIUy1bvY/hmvzrOKwGHR0hnWAz75MB7K2DRCXCUMX4SYpm4YQKqSE2pLUISN1rY3l9qYz7nn/jTTjuR3TeTgR44tFvVe6fA7vyUhbrvu3EYYCWdpOGtjuXzFUXG6nc8NYC/T/6+c8xN7XoSE2IMrfbXwkWyku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542320; c=relaxed/simple;
	bh=XcyGAKHhH1BhoHNkqAc3lfQdNvG2pdA5Q2gmHb3khFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdxufwXvsltGpFyMRyri/hl5mdIhG7bTyEdlAmqtZw+RuDXKYwrSgodyzpCmSowDVX3DX4QOuqeG6FnK3F2QMpuUArFlbHyQnxldZJTNuet1yFNlW7wXx66MU5otHQgvgBxLTwD+6CTMuJBl98x+O08NmdkL2fu+apShF8YweNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvES3qf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462C2C433C7;
	Wed, 27 Mar 2024 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542320;
	bh=XcyGAKHhH1BhoHNkqAc3lfQdNvG2pdA5Q2gmHb3khFE=;
	h=From:To:Cc:Subject:Date:From;
	b=HvES3qf/+imzbQjZteoop0Ko0xlm9fSxhfOV7s3Rr519bzK3g/bcuKj5rc77+nEG1
	 5yvkYmYAAFgdHX7DsumwsI/XsDdXbcObDTB1MMZY8ZzDOJ+5snELNJcau4nmjpoVZp
	 JWzJSLc4FnNDLPsiqIGNSz08q3cCQxbHZsLzwXDuMqCCsdaENyDv1qMEU7Yzz/rah6
	 /oS5rW8CPLYJqRt7oYi8959rSlhrnCv53FFtvldNdKt0ZpRXgs0vMTstahHr+Gh/4J
	 wc+eKWR+InQ9z13k72+GUtFDrgE+GOV5Zi8TQrMTGVz1j8rVfNrejeZ9WiD+DyUmbv
	 eiploLh0YAk3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jani.nikula@intel.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/panel: do not return negative error codes from drm_panel_get_modes()" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:25:18 -0400
Message-ID: <20240327122518.2840115-1-sashal@kernel.org>
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

From fc4e97726530241d96dd7db72eb65979217422c9 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 8 Mar 2024 18:03:40 +0200
Subject: [PATCH] drm/panel: do not return negative error codes from
 drm_panel_get_modes()

None of the callers of drm_panel_get_modes() expect it to return
negative error codes. Either they propagate the return value in their
struct drm_connector_helper_funcs .get_modes() hook (which is also not
supposed to return negative codes), or add it to other counts leading to
bogus values.

On the other hand, many of the struct drm_panel_funcs .get_modes() hooks
do return negative error codes, so handle them gracefully instead of
propagating further.

Return 0 for no modes, whatever the reason.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/79f559b72d8c493940417304e222a4b04dfa19c4.1709913674.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_panel.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index e814020bbcd3b..cfbe020de54e0 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -274,19 +274,24 @@ EXPORT_SYMBOL(drm_panel_disable);
  * The modes probed from the panel are automatically added to the connector
  * that the panel is attached to.
  *
- * Return: The number of modes available from the panel on success or a
- * negative error code on failure.
+ * Return: The number of modes available from the panel on success, or 0 on
+ * failure (no modes).
  */
 int drm_panel_get_modes(struct drm_panel *panel,
 			struct drm_connector *connector)
 {
 	if (!panel)
-		return -EINVAL;
+		return 0;
 
-	if (panel->funcs && panel->funcs->get_modes)
-		return panel->funcs->get_modes(panel, connector);
+	if (panel->funcs && panel->funcs->get_modes) {
+		int num;
 
-	return -EOPNOTSUPP;
+		num = panel->funcs->get_modes(panel, connector);
+		if (num > 0)
+			return num;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(drm_panel_get_modes);
 
-- 
2.43.0





