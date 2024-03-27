Return-Path: <linux-kernel+bounces-120785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8026788DD28
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3115295D55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9806112E1C6;
	Wed, 27 Mar 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF8POmwU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47C12DDB8;
	Wed, 27 Mar 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541197; cv=none; b=aEJltEpNPp6HKUvW0PuxFLfw98vxMcU2fpVS8olHxADvEwz5vAFq0JA/7xpFDSagJcKGw5XRyPZkoO8ziQFql8Z/PpHBhgSfq1nXXswTzoREHkcScbuvDjmoSEDnRC8Ff/jbyvldfRuwPB+C2uNmBDftizNN7R1nbEZA4qfWfyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541197; c=relaxed/simple;
	bh=NMfeuhQtTuBIpESwyx6LXMqLV6w/0x6X4FMHC/nihcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9XM9YcI+Idsvrogd6vmYlgiKqPxkMV2U3UGKshTSYD1zxZR8NF5YnpQQVVUZfT8arlQkacehrtbeSOKEz2r2/38ugnpwwMVUEzcaSHesVF4HIaqVD2dbyDWYFR0ua0Edncb8tXlSPFu837UZNFYREp9GKWWMr7F81UVDv9/DrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF8POmwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6D7C433C7;
	Wed, 27 Mar 2024 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541196;
	bh=NMfeuhQtTuBIpESwyx6LXMqLV6w/0x6X4FMHC/nihcE=;
	h=From:To:Cc:Subject:Date:From;
	b=XF8POmwUWgXcFe4Zc7W888tI0nEQviFJu7Vh0v3eBcqPl6kijvterqtbWFwQYZxmX
	 aLmm5lr1Umx/AFyLNUeliM/pExQIsY/e/XPQUWAeBg61BPRENaqSSdPyoLIp7JDm13
	 aflnAF5tggeJMPcj+nPq9auenf259ixypalKRkGAAhWbVUZJmH7tOZJrIIqQVv5qGB
	 rpDR4TKGvIW6/eVVc6i8z+jMczl5t5Azf/p2iVWz9lYcGp6kdStNvA8uektWLam9gz
	 Ls7AjaAg3qerzj7OklLOMN7Y3+NJP5taioDjrzTcqE1WLl0GjUwPnSUI1nOhErYf7d
	 E4mPqCC/btkhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Cc: Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "Revert "drm/i915/dsi: Do display on sequence later on icl+"" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:06:33 -0400
Message-ID: <20240327120635.2824591-1-sashal@kernel.org>
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

The patch below does not apply to the 6.8-stable tree.
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





