Return-Path: <linux-kernel+bounces-30738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284318323BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45DB286A97
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134938F48;
	Fri, 19 Jan 2024 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q/3IYeLN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA579C5;
	Fri, 19 Jan 2024 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705634941; cv=none; b=OHVFDZpDF5+wSPR3oMR7F7NAh/tMr186qOsLEd1QVxY5OWwzfe9YxI9gcit7lm96QhcH+qNTmwJf/m1mmOret6eDgrhOlmN/1Csn/XBhB53Kj77+rLxn21odKYJNubPxteZBL1WG6Cyp0Q43qtF8JIZGPiHYlCXlSYLZOY/H7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705634941; c=relaxed/simple;
	bh=EpFlFBuF+Ly1e6LB2A/g/pM/veGykIDd+kbNri4cKwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrTL6B15UG2JjJz2NHQKpNh+XdRn7Ydh2FQdZS5l5EpQeiEO1C46NI4a9RALE5d+ZevKtN+FetQydM+dcLXkYodSnTQzAbwu7SVP3mUyjBoDCbFwULcedSxf++kXYShI6EQgG5tnPn9Ci7tlUChiUFCIbdyyvyEGvCTn/BPFxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q/3IYeLN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FXI73QdHGUsFKv446LTIFGyMwikTMshKd+tF3Fpn6jc=; b=Q/3IYeLNIvcJv5+44LqAbb8FMR
	889Qs0qYIVneGwxjfO9FNj9Vpk0adnEboUcJ8AvwdH022D9rk/CbhP9bYAF/zrrjE/EtN85hbEl0l
	9W8AtMCHUbI7EapXstlvyd3wdJPo2ngGhwzinsaUvPLfxGtDIm++Sj4NQqwRqs8nEwtRKSPWENDkp
	lCrbfqDqVa4Y3zgNcZwQ6P0Htbh9/AsCH1+E+iDPFZHRjeFV2bmEGx5SWEz7phSh7fRRZXMMuHsXJ
	KDteX7XQoZWg7SbkoABzDHpClJA41JKKgpYOiDkAsFCq/VlatuHyebsVUkyWJnr7JrlDwU6XdaD6L
	r+i25hTQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQfYx-004OfV-2t;
	Fri, 19 Jan 2024 03:28:59 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] soc: qcom: smp2p: fix all kernel-doc warnings
Date: Thu, 18 Jan 2024 19:28:59 -0800
Message-ID: <20240119032859.4082-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the documented notation for nested struct members.
Add a Returns: comment for qcom_smp2p_intr().

These changes prevent these kernel-doc warnings:

smp2p.c:78: warning: Excess struct member 'name' description in 'smp2p_smem_item'
smp2p.c:78: warning: Excess struct member 'value' description in 'smp2p_smem_item'
smp2p.c:280: warning: No description found for return value of 'qcom_smp2p_intr'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/soc/qcom/smp2p.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff -- a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -58,8 +58,8 @@
  * @valid_entries:	number of allocated entries
  * @flags:
  * @entries:		individual communication entries
- *     @name:		name of the entry
- *     @value:		content of the entry
+ * @entries.name:	name of the entry
+ * @entries.value:	content of the entry
  */
 struct smp2p_smem_item {
 	u32 magic;
@@ -275,6 +275,8 @@ static void qcom_smp2p_notify_in(struct
  *
  * Handle notifications from the remote side to handle newly allocated entries
  * or any changes to the state bits of existing entries.
+ *
+ * Returns: %IRQ_HANDLED
  */
 static irqreturn_t qcom_smp2p_intr(int irq, void *data)
 {

