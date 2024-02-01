Return-Path: <linux-kernel+bounces-48046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EB184569A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7381C27B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9593160869;
	Thu,  1 Feb 2024 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wiwtn9q+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A74215F339;
	Thu,  1 Feb 2024 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788414; cv=none; b=B6C8xo57lPbfoD8OEOpp7B2dptyiUg/BYvA05hDrjaqP8tjlDke/4h5ryFhPBOAbftAhIOBhrDPRj98nOUrTfhfLdr3fNTo4K+iTLJ7Vxi6GFHH9q374qTFc+FRWErPrED3l56DLVb3hy4AR/x2BM3v9mIsDmpygQwtWF/1BbrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788414; c=relaxed/simple;
	bh=xj3qUE/KEdqABtcoeVjEuTxwjoHowTvkvWDSQecj28k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYfl3IxO8pe7yE6kFEJHUzZ4VLOsWypsu1geMzTdcwkk4lb1AwhoLJRekorAE224Jx1tmXxCIILc9Sl4i6xbL9ImVisccwe4Z9FvkJdQykZ3hoxmpj2QNR70tY8rYCGCJKd3Al33I5VXp8keHOt3G6df9PcyM4YoyMyQu7FhnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wiwtn9q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F03C433C7;
	Thu,  1 Feb 2024 11:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788413;
	bh=xj3qUE/KEdqABtcoeVjEuTxwjoHowTvkvWDSQecj28k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wiwtn9q+tmDnGWBNvHwI9GkzNorSTByoJV/kLjOL+BVe/8qxuwfPSbJ1cNUiPZScK
	 IBmSCSwBnCf/sUQ3KY78stSi3ZUuBfMnnePmWSlTg4GwjJbjIGLC6l9w0pmP3hc+we
	 p7s4Zyvw77Z9xUQGf3EATRP951drJF5tXDleYWFjS9JA6rkB+hlq+ny4kVQ0Bj8ByE
	 4VPhGfvubGzQ7F1WQw9luY9u49QaY9IW7b4SIpVrph0kj5J7BOo8Exrz4h4lVztrk0
	 SXKbR2w27vOBccoaEXBoEo91nrF3qTsv2C+YOfBXKSPZ+J+Z55z1zhCPyPj1VbN5X8
	 UEBEkVWnwoIXg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/7] HID: hid-multitouch: remove unused mt_application::dev_time
Date: Thu,  1 Feb 2024 12:53:18 +0100
Message-ID: <20240201115320.684-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201115320.684-1-jirislaby@kernel.org>
References: <20240201115320.684-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_time was moved to struct mt_application in commit f146d1c4d7ea (HID:
multitouch: Store per collection multitouch data), but is not used since
then. Remove it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fd5b0637dad6..40475c42b9f6 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -130,7 +130,6 @@ struct mt_application {
 				 * > 1 means hybrid (multitouch) protocol
 				 */
 
-	__s32 dev_time;		/* the scan time provided by the device */
 	unsigned long jiffies;	/* the frame's jiffies */
 	int timestamp;		/* the timestamp to be sent */
 	int prev_scantime;		/* scantime reported previously */
-- 
2.43.0


