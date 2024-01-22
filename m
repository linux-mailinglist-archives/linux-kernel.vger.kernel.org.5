Return-Path: <linux-kernel+bounces-32825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DE2836099
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52ACC1C21D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E433DB94;
	Mon, 22 Jan 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD82W+4L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A423DB86;
	Mon, 22 Jan 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921475; cv=none; b=RzTstXBzKkwOulmKT+hMX8uWlK+E3v9CkqzIB9g1rTQXpxDREIGc5btP50RQIba/nLtDH30Ml91e79tjfUhhNXZjDSsWEbVj1MEmkxcgjmaurhEDUQoYDrCdNoX1YTgmpDlxH5oedbOV9Z1NLwYvx4cz6OnF1DRWVGhoKK0NYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921475; c=relaxed/simple;
	bh=bnN9HZ+jI61Phc1A4Wql+BO8sOtHFz/ndSLyznnytgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4fU4dE3Zw+M91so05omlefIsKpc63efSRLabAuaGxSGJ2tHskCl5QrDx3guhKlh0TfKgjtQ7GHfmYvn0VptIL74byg0K7YEapPyeAPNH4CtI8bIUzlEGP07wpBQVgvXUumfPdbYFXBCOouZRpAn55QsKqDZQyMjSH0JuRT7niA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD82W+4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC666C433F1;
	Mon, 22 Jan 2024 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921474;
	bh=bnN9HZ+jI61Phc1A4Wql+BO8sOtHFz/ndSLyznnytgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GD82W+4LHirl7JcCfqckyQn4Do+dUDtCQN+YfWSa1g9BqTFSkX8Wgv0By+B1QLkCH
	 cnpXW+j0kjLJZ+Cu68LxazTq90Ta4VrYV2dZ5n4KbGnbcyDbMBophgyDma6aYzYRAk
	 fj5EhJcAcgjSD6w8IaeCEX4saBYVcCntawLZjJhzSdeiRe2BSV+VTOJpGRRL6ptt0H
	 GswAc+hwAfsOcwSnyzlbhHwldOrfdi0zLHKUISp0DG1leYohA5ofSB0+jwPAI4T5zl
	 FjgyTPhK8f0iM04jkDB02c7lrZrO+Szue5DZaqMPnXM3THpEDkYMXz42NJPKNCj85h
	 m0D5BpYz6uh6w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 16/47] tty: vt: reflow csi_K()
Date: Mon, 22 Jan 2024 12:03:30 +0100
Message-ID: <20240122110401.7289-17-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Push cases one level left, according to coding style.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 2f3f5e4817f6..8d868aa33733 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1555,20 +1555,20 @@ static void csi_K(struct vc_data *vc)
 	int offset;
 
 	switch (vc->vc_par[0]) {
-		case CSI_K_CURSOR_TO_LINEEND:
-			offset = 0;
-			count = vc->vc_cols - vc->state.x;
-			break;
-		case CSI_K_LINESTART_TO_CURSOR:
-			offset = -vc->state.x;
-			count = vc->state.x + 1;
-			break;
-		case CSI_K_LINE:
-			offset = -vc->state.x;
-			count = vc->vc_cols;
-			break;
-		default:
-			return;
+	case CSI_K_CURSOR_TO_LINEEND:
+		offset = 0;
+		count = vc->vc_cols - vc->state.x;
+		break;
+	case CSI_K_LINESTART_TO_CURSOR:
+		offset = -vc->state.x;
+		count = vc->state.x + 1;
+		break;
+	case CSI_K_LINE:
+		offset = -vc->state.x;
+		count = vc->vc_cols;
+		break;
+	default:
+		return;
 	}
 	vc_uniscr_clear_line(vc, vc->state.x + offset, count);
 	scr_memsetw(start + offset, vc->vc_video_erase_char, 2 * count);
-- 
2.43.0


