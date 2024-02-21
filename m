Return-Path: <linux-kernel+bounces-74156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1170A85D08F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422681C23DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8C72E400;
	Wed, 21 Feb 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jzKY4liI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9393A1C9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497675; cv=none; b=XRvYVAMb4OG3nZknAGPS/TV7TQ6U3i/myWhwVnJRRUcNm0BhOuqhfhFJdaIARxBQim0xK+2J9ELhYgSUwPP8fcto+MjpchKzQQBDRnxbVK1F6wI3dONJL3Y+eQCqGj0pOD3KdvFZzK1owuoATfr/GL3wRZN8Y25R6CoMA1w2ZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497675; c=relaxed/simple;
	bh=HHrd3uydZTL41zeG5LbyW4+FGJ2Ww7swiP8zYSCWrl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZZ6Yh7BHzWe+itqMVNCpvdvv7s7dQDGcGttj9dp8yBoKKIrmTGytjACcTc9009G+OOQDpQ/80PvFuQOjlYBcqCGmi88bOzhXyR9LGGdaIDYKX6aN3AzkQE84glbhbQ19tQ/1k8IahOIj4zwB1+7z/xP2uS2C+KpykhrfJ3/VDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jzKY4liI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LHVimnQnkFNTf+t62qnqPC7y5oFbUuZa3E9B2P3SDm4=; b=jzKY4liIsf/P38SOt1kjzCIf1i
	ZZGFzMfDsBnOuM7j/zv4a8cPGksHLdwxEgnB8f15nZEuMqf7jI1PzY1+YpKB3kAtWbphT07dRVNZi
	bZzm79F8j3gZV16Dqmmy0f3rMXmxIn1AwHy3TIKPtR8BJxhjw10joBKbhHNYdcwW2DD+M5PSJm1nY
	7lcoI/9/+FyeC8v4khAkIoWeKRcCqV1dgxd3JZ/roVBzIeVwm45BxkDxfZzQxMJpM4VueEfqydbW1
	1emXL0AIO1dRLNO8ADRi8lP7dizPnSs5IEjflSwkPG5GM4JZS7kRrnClFIZi0S4i66n9iB3jtdSW1
	Qff0xGDg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcgI5-0000000HMTN-1b3Z;
	Wed, 21 Feb 2024 06:41:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] HSI: ssi_protocol: fix struct members kernel-doc warnings
Date: Tue, 20 Feb 2024 22:41:12 -0800
Message-ID: <20240221064112.9155-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in one struct member's name and add the @work struct member
to quieten kernel-doc warnings:

ssi_protocol.c:144: warning: Function parameter or struct member 'work' not described in 'ssi_protocol'
ssi_protocol.c:144: warning: Function parameter or struct member 'tx_usecnt' not described in 'ssi_protocol'
ssi_protocol.c:144: warning: Excess struct member 'tx_usecount' description in 'ssi_protocol'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/ssi_protocol.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -114,9 +114,10 @@ enum {
  * @netdev: Phonet network device
  * @txqueue: TX data queue
  * @cmdqueue: Queue of free commands
+ * @work: &struct work_struct for scheduled work
  * @cl: HSI client own reference
  * @link: Link for ssip_list
- * @tx_usecount: Refcount to keep track the slaves that use the wake line
+ * @tx_usecnt: Refcount to keep track the slaves that use the wake line
  * @channel_id_cmd: HSI channel id for command stream
  * @channel_id_data: HSI channel id for data stream
  */

