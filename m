Return-Path: <linux-kernel+bounces-14529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A212821E53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32C01F22EAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D81427C;
	Tue,  2 Jan 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaBJwM7F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580BD12E7E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C610BC433CB;
	Tue,  2 Jan 2024 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704208023;
	bh=QDhoQSaSpo9hrMc6cyInKkOcqMGrIdfUTWR31DFTkoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaBJwM7FcrWhNZXpLFWahC00ere2bPHL3R4R5XVWiT4oK40lXtL9slx0hKJ2P5vtq
	 m2R3MAdyLtWj8kxYhgeR/qdw51jsC8p50dfyeNECB5arRU7YEib+RTDhUjBHa368+x
	 YAMRNt7vpo/RMxY1+USfx4I/C1CnH1GN9lfIkwWV79YSURb/j3Aq5UeDVD6gf0JB6L
	 RB5tQ3+IdCFpc1vZzHs1WZxNdFxrgNG0oLS03CNeEUttpeSbWQGyJx12yCJNMbhRxF
	 7UHEFp8xewAUOYN16ZIqUejqXDVALsBaxv9G5YXwqKfNa0dTYWnSV1JCei1lWaWqcP
	 NBB3kVk66nicg==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 3/6] accel/habanalabs: increase HL_MAX_STR to 64 bytes to avoid warnings
Date: Tue,  2 Jan 2024 17:06:51 +0200
Message-Id: <20240102150654.522555-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102150654.522555-1-ogabbay@kernel.org>
References: <20240102150654.522555-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Koby Elbaz <kelbaz@habana.ai>

Fix a warning of a buffer overflow:
‘snprintf’ output between 38 and 47 bytes into a destination of size 32

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index b1a7b229e161..253873315888 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -2547,7 +2547,7 @@ struct hl_state_dump_specs {
  * DEVICES
  */
 
-#define HL_STR_MAX	32
+#define HL_STR_MAX	64
 
 #define HL_DEV_STS_MAX (HL_DEVICE_STATUS_LAST + 1)
 
-- 
2.34.1


