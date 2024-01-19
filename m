Return-Path: <linux-kernel+bounces-30737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565218323BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893DF1C2325B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF34A11;
	Fri, 19 Jan 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A1Md2Scn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB346AF;
	Fri, 19 Jan 2024 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705634928; cv=none; b=bjPQjnvEaICTydEt/vQ2mrJxVAkDmnJvRUV5lKYGP7f2tu1V4FZtQluKJRTSM4XzkxM74bdHezKJewFjaNr3Vw4Lk4gf/idvuP9ljH24mGl2mhgV1GsKu8yOd2GCA0YdzFOKLKCr9c7pmLcGQmhUdZzqH/J6MvIMKN+XzgaGDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705634928; c=relaxed/simple;
	bh=SXRNeozaB9eyQL1XHrCywVwUsZZtLob/giNc6eDZpSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/Xi2lMbBGEVp50Ca2FG93JvFn6rQiQHQxhVVe6AORXfQvaavE153vKx+0nHhUH6TU7hRv9i54SVHwSM52ZtNgtHMaonJbnMr0fIawCzN9e41XFzwWpA1d38zsbYPlIAgPhPH4ERjBS5xKNvv4WtUhTYVqgcnNlaOEMle2Y7qVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A1Md2Scn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ItTupsxYRq7Jy8o7qxit6OVbSsCGvKp39WxYjy3hMns=; b=A1Md2Scn+8fLMgYyrNB0Se3uks
	qocfkvck8371v+Np9Hq7ITp+fbhM7UXS+A7cparTAatfhs2yLUsWBbMrJ3R+hk4l64FGf/m3OG771
	qrczUPTwYQhaPQf1A1WLa+pzaWyz0o4HaFtxsawgKPjDJLPrqGvdgup6rKiqe9OutDaanEI4pt2BV
	2VW60qy8o9WzkRElaP83xyrNEgdN96q8Z5P8yVrQ7qL/bReQKUFEvcm/qDBb6CuW3eg3KCdQUrvxe
	zm7KssHMydlHV9yTwUpHsbI3Lu0DzZi1QBtPgAKj8wmWpr4MNba+BHUoHD9oJI0H0uCPlNnGn0zdz
	UBXpGMZw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQfYk-004Obg-0B;
	Fri, 19 Jan 2024 03:28:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	ntb@lists.linux.dev
Subject: [PATCH] NTB: ntb_transport: fix all kernel-doc warnings
Date: Thu, 18 Jan 2024 19:28:45 -0800
Message-ID: <20240119032845.4065-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix all kernel-doc warnings in ntb_transport.c.

The function parameters for ntb_transport_create_queue() changed, so
update them in the kernel-doc comments.
Add a Returns: comment for ntb_transport_register_client_dev().

ntb_transport.c:382: warning: No description found for return value of 'ntb_transport_register_client_dev'
ntb_transport.c:1984: warning: Excess function parameter 'rx_handler' description in 'ntb_transport_create_queue'
ntb_transport.c:1984: warning: Excess function parameter 'tx_handler' description in 'ntb_transport_create_queue'
ntb_transport.c:1984: warning: Excess function parameter 'event_handler' description in 'ntb_transport_create_queue'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev
---
 drivers/ntb/ntb_transport.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff -- a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -377,6 +377,8 @@ EXPORT_SYMBOL_GPL(ntb_transport_unregist
  * @device_name: Name of NTB client device
  *
  * Register an NTB client device with the NTB transport layer
+ *
+ * Returns: %0 on success or -errno code on error
  */
 int ntb_transport_register_client_dev(char *device_name)
 {
@@ -1966,9 +1968,9 @@ static bool ntb_dma_filter_fn(struct dma
 
 /**
  * ntb_transport_create_queue - Create a new NTB transport layer queue
- * @rx_handler: receive callback function
- * @tx_handler: transmit callback function
- * @event_handler: event callback function
+ * @data: pointer for callback data
+ * @client_dev: &struct device pointer
+ * @handlers: pointer to various ntb queue (callback) handlers
  *
  * Create a new NTB transport layer queue and provide the queue with a callback
  * routine for both transmit and receive.  The receive callback routine will be

