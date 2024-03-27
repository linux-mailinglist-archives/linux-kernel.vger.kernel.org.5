Return-Path: <linux-kernel+bounces-120800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F17588DDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4667B26F05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580C1130A43;
	Wed, 27 Mar 2024 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDFtaLfq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D412FF90;
	Wed, 27 Mar 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541237; cv=none; b=u76Do1Bvf14f95YaoVdCbnGGUbdr3JDptr4GUXbLg6088U1cIKlvCjvUwfX38ipE+0qaCzQsqha29vYLGfe0lCubuE5A6TBrvIgdrGf0bv+yZEX/a2a5FsG1qDFarrLB8Y3iqFa6jPjtv6WEp5sJphMxJBbtSnbtLZjKiibPpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541237; c=relaxed/simple;
	bh=JbUMZ/roR+rmiGA2vkSGBmEv9Ry9nL3yPJ8PrddJmIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pgda348n1r2PMwmjzqU6mVeperc0lkxHI7iPTa+G1AxettI01oBRQYP+qvr+KeCGIieD2+GHDiV20p9VoqWjmEmF874wjTJTU4IOA+PUtV/+scrbXvYRtb5J65eJTy5h7DLhDqY90aGKDw1b5f4w2rnQUEChv1FdHmyfBOGFRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDFtaLfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC78C433C7;
	Wed, 27 Mar 2024 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541237;
	bh=JbUMZ/roR+rmiGA2vkSGBmEv9Ry9nL3yPJ8PrddJmIw=;
	h=From:To:Cc:Subject:Date:From;
	b=YDFtaLfqL2QQaSup61o+EKiWw0g3s60ziTocvqycKYQK6C71EcZwVu4CNKjCiq+mj
	 gaG9SezctvL0y9jcqqq3TKllGTRvYxuSF81kLrvduJEoYPhJOMCtKmo01WgoqErpO8
	 +zwkfIpgWHrdc8m75AegsHXODiFlkYKmBaqRAJN/mEhSMj3Y9XTIQDV44l/uc/OYbv
	 39qpyksgZdrf6EshRi8DyJz0/dyi5v1ZdijvJA6H+PSs+itOsW3AAns9HmcTXfDCoD
	 Sg7t99zLWN+Q1CZM/5F5Z47E6WBj6GQakGZYS7iOK8jWHoGymhY6u25A0vSAyT81dg
	 BdXejQsiEUSag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/i915/psr: Only allow PSR in LPSP mode on HSW non-ULT" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:07:15 -0400
Message-ID: <20240327120715.2825271-1-sashal@kernel.org>
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

From 94501c3ca6400e463ff6cc0c9cf4a2feb6a9205d Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Thu, 18 Jan 2024 23:21:31 +0200
Subject: [PATCH] drm/i915/psr: Only allow PSR in LPSP mode on HSW non-ULT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On HSW non-ULT (or at least on Dell Latitude E6540) external displays
start to flicker when we enable PSR on the eDP. We observe a much higher
SR and PC6 residency than should be possible with an external display,
and indeen much higher than what we observe with eDP disabled and
only the external display enabled. Looks like the hardware is somehow
ignoring the fact that the external display is active during PSR.

I wasn't able to redproduce this on my HSW ULT machine, or BDW.
So either there's something specific about this particular laptop
(eg. some unknown firmware thing) or the issue is limited to just
non-ULT HSW systems. All known registers that could affect this
look perfectly reasonable on the affected machine.

As a workaround let's unmask the LPSP event to prevent PSR entry
except while in LPSP mode (only pipe A + eDP active). This
will prevent PSR entry entirely when multiple pipes are active.
The one slight downside is that we now also prevent PSR entry
when driving eDP with pipe B or C, but I think that's a reasonable
tradeoff to avoid having to implement a more complex workaround.

Cc: stable@vger.kernel.org
Fixes: 783d8b80871f ("drm/i915/psr: Re-enable PSR1 on hsw/bdw")
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10092
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240118212131.31868-1-ville.syrjala@linux.intel.com
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 696d5d32ca9db..1010b8c405df2 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1544,8 +1544,18 @@ static void intel_psr_enable_source(struct intel_dp *intel_dp,
 	 * can rely on frontbuffer tracking.
 	 */
 	mask = EDP_PSR_DEBUG_MASK_MEMUP |
-	       EDP_PSR_DEBUG_MASK_HPD |
-	       EDP_PSR_DEBUG_MASK_LPSP;
+	       EDP_PSR_DEBUG_MASK_HPD;
+
+	/*
+	 * For some unknown reason on HSW non-ULT (or at least on
+	 * Dell Latitude E6540) external displays start to flicker
+	 * when PSR is enabled on the eDP. SR/PC6 residency is much
+	 * higher than should be possible with an external display.
+	 * As a workaround leave LPSP unmasked to prevent PSR entry
+	 * when external displays are active.
+	 */
+	if (DISPLAY_VER(dev_priv) >= 8 || IS_HASWELL_ULT(dev_priv))
+		mask |= EDP_PSR_DEBUG_MASK_LPSP;
 
 	if (DISPLAY_VER(dev_priv) < 20)
 		mask |= EDP_PSR_DEBUG_MASK_MAX_SLEEP;
-- 
2.43.0





