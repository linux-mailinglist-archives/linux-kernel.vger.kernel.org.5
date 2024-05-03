Return-Path: <linux-kernel+bounces-168399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54088BB82E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461521F249F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB3C84A3B;
	Fri,  3 May 2024 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="QEpqbn3F"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2685639;
	Fri,  3 May 2024 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778622; cv=none; b=Jt6/PIDVAbHcAVYKXUhVwzZNBYvYwUfrxG01i0dpGug4uAsTRmOlhXg3US9m11RShOKoDwEt6H2D5btmB4XLG7RJJj0ln/n7L4Mx5rBKWt/4pupyzcG4RJnB1ilwc7Uv/tfYBZMpE41y8E8p8KQN820w+N3zIhmIf0UFl0Lenss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778622; c=relaxed/simple;
	bh=OZm/8AuoUpU76Ay7hcojLIf0gRnUloUKNblbV3sRSMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abu8zSaU94oZqEQu6TZEY6nSllxstOYlJOfbPpVd9dYeV9NPlAGDnOMDVxgMsBE6w5KbhEbj0vrpGznBOkkDlgSHMnx1lSn7vyUuCmXuhcF1K2SUt+DBXXvRZh+ZS7lZX4/7yvE6PbEhpME63C7r8dlwRa/kJFPjdfEy5HyDUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=QEpqbn3F; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=z7goc7WoFG1PRFs7GBANBAWc9ZEAu9ODYpY+rnzKtnU=; b=QEpqbn3FkwFobyWP
	eSKYmuhG1I5sYULtfINcfReyhNtQ401yAZT7hFnUl4V2LLDQjG+/VWevx9B+rAiWA2YT42ocNBhRo
	lrGm3wSNqIhxOZTVDGa24j6GsAaEmr9eHb/hC8NtPM4HTLvAeiKZGtRxk3ATFv8ydk6lnFG/hCgBw
	Kh3s8dnfn4b9SS0eyqVVhNg6wOgXpvQtuVwdGhqsM3JjW6GCwDE6U7DoEXWEalu4pa4pJJf+VbX9f
	WRQgXYs51hoD/oDsoKnwMQuypOaCrRFJjM3UqP1r79V2ZgmlvNdI7gZFPgQTeF0V/Uu76rYs5ESXx
	8gX7SMzs17kNFq3LxQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s32FT-004duc-1W;
	Fri, 03 May 2024 23:23:27 +0000
From: linux@treblig.org
To: michael.christie@oracle.com,
	James.Bottomley@HansenPartnership.com
Cc: linux-kernel@vger.kernel.org,
	open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] scsi:iscsi: Remove unused list 'connlist_err'
Date: Sat,  4 May 2024 00:23:09 +0100
Message-ID: <20240503232309.152320-1-linux@treblig.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

I think the last use of this list was removed by
  commit 23d6fefbb3f6 ("scsi: iscsi: Fix in-kernel conn failure
handling").

Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/scsi/scsi_transport_iscsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index af3ac6346796b..123b861d2a9fb 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1603,7 +1603,6 @@ static DEFINE_MUTEX(rx_queue_mutex);
 static LIST_HEAD(sesslist);
 static DEFINE_SPINLOCK(sesslock);
 static LIST_HEAD(connlist);
-static LIST_HEAD(connlist_err);
 static DEFINE_SPINLOCK(connlock);
 
 static uint32_t iscsi_conn_get_sid(struct iscsi_cls_conn *conn)
-- 
2.44.0


