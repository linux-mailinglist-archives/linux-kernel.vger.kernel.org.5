Return-Path: <linux-kernel+bounces-121034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370888E1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E1D1F26624
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CDA15B569;
	Wed, 27 Mar 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRboy/XG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C815B558;
	Wed, 27 Mar 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541900; cv=none; b=Fs2QoFzZ0ClzOwx6FqHNrLDG9Sc2d3DuZPsWgix4v/3IK1wv/HJeuXnrUsu5ujoRmBcuEwvO7IgB9dpWy4YjJGz2ROE1mMFZ8mLY3rwpdbqj2B+V+JfapG8WjJ+U/0N+efjjKpMM/KBpFUKt0Rx1s0sh3lLEYA8Cy5tB5CXBXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541900; c=relaxed/simple;
	bh=KTtpWTMjOQwngwn+yU6wwksb7TJ6zBCJq+Ni7vA0NTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NI22qZhpwOztCYiRSwpJRRBXaBLvz1+rG7HNxgzoBI86E6Wlv7xIIPvowGD7TyF+5UD50nCISnUFBgMuDpkf2m0yNNfh6jmHSVcYsRIDMlYPD6d3KqeWw9ftOd6xRZfGweH4M1V8D53SRJdeh0ph9bBOojb+KQjnyZYk3jNZErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRboy/XG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000C1C433C7;
	Wed, 27 Mar 2024 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541899;
	bh=KTtpWTMjOQwngwn+yU6wwksb7TJ6zBCJq+Ni7vA0NTs=;
	h=From:To:Cc:Subject:Date:From;
	b=FRboy/XG9bbWh5Ec1/VLwFkoW2dQcAueTz/KSmpkYAqjz083CFkFrjsTTBYIvSfgG
	 pPL1/9xP5Dva34MyQx6UNHG9tySR9mAl9G/NYexi/IdRq+/cp6WtnzuTGZWli1HO75
	 z84pjr/rdHe9HMbuObXM2CL8eiZsXRPtOAJYVcHRiyzSBB3YypIXviIlvE6dC4gTbH
	 uxTbRL7IaArwoezOpMmIpaYKMoE+bLKN9Razu0GwhOmxdOq8DkJlwWDcdxU32PDitv
	 g6n5k2qABcwc5NCtfoEKn0zfWuwAlC/tW88UpyxJwCtosBfA1B1TDKHbAQ7jS6e1tk
	 EQeovWKDs6XIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Cc: Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "Revert "drm/i915/dsi: Do display on sequence later on icl+"" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:18:17 -0400
Message-ID: <20240327121818.2834227-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dc524d05974f615b145404191fcf91b478950499 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Tue, 16 Jan 2024 23:08:21 +0200
Subject: [PATCH] Revert "drm/i915/dsi: Do display on sequence later on icl+"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 88b065943cb583e890324d618e8d4b23460d51a3.

Lenovo 82TQ is unhappy if we do the display on sequence this
late. The display output shows severe corruption.

It's unclear if this is a failure on our part (perhaps
something to do with sending commands in LP mode after HS
/video mode transmission has been started? Though the backlight
on command at least seems to work) or simply that there are
some commands in the sequence that are needed to be done
earlier (eg. could be some DSC init stuff?). If the latter
then I don't think the current Windows code would work
either, but maybe this was originally tested with an older
driver, who knows.

Root causing this fully would likely require a lot of
experimentation which isn't really feasible without direct
access to the machine, so let's just accept failure and
go back to the original sequence.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10071
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240116210821.30194-1-ville.syrjala@linux.intel.com
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index ac456a2275dba..eda4a8b885904 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1155,6 +1155,7 @@ static void gen11_dsi_powerup_panel(struct intel_encoder *encoder)
 	}
 
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_INIT_OTP);
+	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
 
 	/* ensure all panel commands dispatched before enabling transcoder */
 	wait_for_cmds_dispatched_to_panel(encoder);
@@ -1255,8 +1256,6 @@ static void gen11_dsi_enable(struct intel_atomic_state *state,
 	/* step6d: enable dsi transcoder */
 	gen11_dsi_enable_transcoder(encoder);
 
-	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
-
 	/* step7: enable backlight */
 	intel_backlight_enable(crtc_state, conn_state);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_BACKLIGHT_ON);
-- 
2.43.0





