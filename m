Return-Path: <linux-kernel+bounces-57647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAE084DBC6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237531F21339
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C56D1A9;
	Thu,  8 Feb 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU3PEYfL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CC6BFD4;
	Thu,  8 Feb 2024 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381924; cv=none; b=JmzeBzGis5wlIITSZ5K6Z6J2Gv7NOhObLPPd5hiKKpLUv3rzKjm7KDse/vIU6nvakgKa4ZEoMCyiWLKOBMmJ2JhGISEr3jVufmdZoeI2ucn2x1KB7iJi1gRvtTwiQuyCXJG8g0fvDvtQyVkOOU+xNBQj38tBatTs3s3we/zqxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381924; c=relaxed/simple;
	bh=wv1edZDay1984m0Qu877d4pMp2VycX7eTW+TWnSEgGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liiQnLPXN9ko834KsN6N1YGPOCWVBHCbEiFzGawf2aTbK4ps9TK4P0+jYmoZqcER6hARLjvJo0Ls7Aa2NmIPEhTqX1/Wis4ED3jaUb7JvKonklqrrRLeSk9ocLSKbVfjCnkRX3YpT4y7m9r7OrlUgbxgFVmPbRrYQWO6XbfJOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU3PEYfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A033BC433F1;
	Thu,  8 Feb 2024 08:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381923;
	bh=wv1edZDay1984m0Qu877d4pMp2VycX7eTW+TWnSEgGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KU3PEYfLT6P4J4Z+OLwcXn2yaoKj9oYGZt/jp0y6WWO8GaVbkWKi3tykEDq7QtCPC
	 jlsBBIPRRHQHaZ1E1EkEsy51RAFNNuuY+NPszom6UcRh30mblvuBOgH9aoSgeK9P4v
	 KzPpm0ApERis84nYdrb/0rI5ASwBIKDrxNpCf5pGtMp9qcBVgXYXRiF+DCK4zo6yjq
	 cNyOveBeuFvaXZGwbzKDZHTFHkDPeXrGuLZfKz3Nks1XvKAmRFiiuSJT6L8O7eapPB
	 D1yfoYzw2DgSfYelyXJjm46z6ehLXMNmW7EUAml+pHfg3PgZWQ3vzDcCGYDpl2RJlQ
	 2nGJSsnDocs7w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Joel Jacobson <linux@3ware.com>,
	de Melo <acme@conectiva.com.br>,
	Andre Hedrick <andre@suse.com>
Subject: [PATCH 01/10] scsi: 3w-xxxx: Trivial: Remove trailing whitespace
Date: Thu,  8 Feb 2024 08:44:13 +0000
Message-ID: <20240208084512.3803250-2-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240208084512.3803250-1-lee@kernel.org>
References: <20240208084512.3803250-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 5a602de99797b ("Add .editorconfig file for basic formatting") my
editor has been forced to remove trailing whitespace from any file it
saves.  Instead of fighting this recent kernel default, let's start
chipping away at fixing the issues.

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Adam Radford <aradford@gmail.com>
Cc: Joel Jacobson <linux@3ware.com>
Cc: de Melo <acme@conectiva.com.br>
Cc: Andre Hedrick <andre@suse.com>
---
 drivers/scsi/3w-xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 2c0fb6da0e608..13ddc97f5a623 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1099,7 +1099,7 @@ static int tw_initconnection(TW_Device_Extension *tw_dev, int message_credits)
 	command_packet->request_id = request_id;
 	command_packet->status = 0x0;
 	command_packet->flags = 0x0;
-	command_packet->byte6.message_credits = message_credits; 
+	command_packet->byte6.message_credits = message_credits;
 	command_packet->byte8.init_connection.response_queue_pointer = 0x0;
 	command_que_value = tw_dev->command_packet_physical_address[request_id];
 
-- 
2.43.0.594.gd9cf4e227d-goog


