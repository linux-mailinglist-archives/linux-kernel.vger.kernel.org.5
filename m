Return-Path: <linux-kernel+bounces-10303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C0281D25C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33AE284A21
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B68BE0;
	Sat, 23 Dec 2023 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XKAkLbPg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32BED270;
	Sat, 23 Dec 2023 05:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=l+yWXDqPoOHLI2fG8kkznOnFgs17cnuCBflWf4DwOQk=; b=XKAkLbPgXVLhJ5URUL/vHdTtg/
	hSFJ8D2ZJrKb36W/nGYezGixZxqjiO0gmqpZVhqNDyEUkRgvbqCB4cfK1wJTFwi2ajmmozvt623j/
	bbBMi2TWcETdeZrDAAWuBTueUxLOp1+OSXOzcuDyJ3MUrkwOdWd7l7K5wV7fvSuXFmhFJd5YHBvpj
	zQp9RPmOeIyMPids4Jr0C7zD8pbgxrtjZkRGphhe0qU6XgfoWsc5oTYgkJYgKZqayOXNhFEXlGqiP
	HCchpTRAgdu6A/v/ZyVFjkiF6jYJ7+y17Eic4XCLdroL+Zw+GT+Df+kIMyOFyqBegnFQV9p0ixQ36
	IPbZZeSA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuDd-007OmI-0b;
	Sat, 23 Dec 2023 05:06:37 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: linux/usb.h: fix Excess kernel-doc description warning
Date: Fri, 22 Dec 2023 21:06:36 -0800
Message-ID: <20231223050636.14022-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the @removable: line to prevent the kernel-doc warning:

include/linux/usb.h:732: warning: Excess struct member 'removable' description in 'usb_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 include/linux/usb.h |    1 -
 1 file changed, 1 deletion(-)

diff -- a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -632,7 +632,6 @@ struct usb3_lpm_parameters {
  * @reset_resume: needs reset instead of resume
  * @port_is_suspended: the upstream port is suspended (L2 or U3)
  * @slot_id: Slot ID assigned by xHCI
- * @removable: Device can be physically removed from this port
  * @l1_params: best effor service latency for USB2 L1 LPM state, and L1 timeout.
  * @u1_params: exit latencies for USB3 U1 LPM state, and hub-initiated timeout.
  * @u2_params: exit latencies for USB3 U2 LPM state, and hub-initiated timeout.

