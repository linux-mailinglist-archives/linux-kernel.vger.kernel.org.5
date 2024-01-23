Return-Path: <linux-kernel+bounces-34724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B38386C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45EFB24C69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F88846B7;
	Tue, 23 Jan 2024 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PhYNOGYw"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB64400;
	Tue, 23 Jan 2024 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988011; cv=none; b=SIRtX+Z8pZno0EgAaT+SbM/AX2Jk3en3hj67FMQPNGuyB8ClehqdeWp389HVWHlGghAeh0LsLrr6yXjYTKyzEOIlJSSUfj9LW/fHJY44pTPH1mWotcI1RW4WEPvT/XfX2xUSbSkBseBq8zL9Lx772NV9f322HKhmxpZAfecUkVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988011; c=relaxed/simple;
	bh=KxubCZ0ZLxXuFu1K0HJc0P2pRv5s1BsQOdzl8aQk9fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0hPGHNZ+qvM7o6w/1Zj+R8gcl1vGBr6oWtkJOQjuhLgHVQhRbzZaPRWR3QcpoNTJioK/UaJsrGP4yzoOH/JnlfaUH9y3R9MtAiVDe2jjmYmR+hunAIwr6ljWrbhOwUUApaXaS0bLnGa9qVvHTox5pjoSmZUUvKbJOorwnlCnhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PhYNOGYw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=piuK4jmXPkNXZigQnP+7ADJheOUNtn+jvTH5r5ncPSo=; b=PhYNOGYwuNaKIGwNPbYStNX/xn
	THGZd8+d+I2GxNz3P8IvlUS7+4tYchfbWNiwSwdk3JRJ90M1TM4vfPNdZyQ2PKjAlhbXsVhesifMr
	gIP8ym7YvY0ameifQB3bELwHYsOxoc7QxkPsThUgyKPtTFbWJZHqelqsJ1EQnQMaeatxjr1HiudVR
	WUFH9Fuzp8fr6meB3sVoCKRChRznfhzzAPQDMDH5E3nLHPGsoT2Pw8emB1vEkvi9wjjakmLhi8Sxp
	+QTpMcAXUfozIW6b3jU8tgo5HiEQquM6FGBq0hu2ar/r0zB8DPaWLooRTMY6DTaM5ynpFa0VAiubU
	Lti8JKuw==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9Pd-00F9tI-2B;
	Tue, 23 Jan 2024 05:33:29 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2] soc: qcom: smp2p: fix all kernel-doc warnings
Date: Mon, 22 Jan 2024 21:33:29 -0800
Message-ID: <20240123053329.12893-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the documented notation for nested struct members.
Add a Return: comment for qcom_smp2p_intr().

These changes prevent these kernel-doc warnings:

smp2p.c:78: warning: Excess struct member 'name' description in 'smp2p_smem_item'
smp2p.c:78: warning: Excess struct member 'value' description in 'smp2p_smem_item'
smp2p.c:280: warning: No description found for return value of 'qcom_smp2p_intr'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
---
v2: use Return: instead of Returns: for consistency with documentation
    (Jeff Johnson)

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
+ * Return: %IRQ_HANDLED
  */
 static irqreturn_t qcom_smp2p_intr(int irq, void *data)
 {

