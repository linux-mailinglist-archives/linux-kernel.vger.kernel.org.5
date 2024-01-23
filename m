Return-Path: <linux-kernel+bounces-34723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FCD8386C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7AE1C230FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA025F4E0;
	Tue, 23 Jan 2024 05:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SMQ4hJ1u"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD89D30E;
	Tue, 23 Jan 2024 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988002; cv=none; b=VI183U4zrVnCA72UiovdDuDWzmnx48leIhNiljIrxGZumx6Tx/R6w7HvOvT2zrp1FafcXArRdsbQtnR1M5JHpBZGkP/jVfaJ/WU9BUp9xh1vQ2Pv504B/s2GA7HjOzZHshBQ3//UOnTBq40VtCt2O0DqCLhbb5jXdXgoTSUhdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988002; c=relaxed/simple;
	bh=KxubCZ0ZLxXuFu1K0HJc0P2pRv5s1BsQOdzl8aQk9fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPiLLpmCX1s/546aNFjabykU4fJdRk7THh/4xdFLjFKS3UDSX5+19iJy+HA5ll20dtloPB8YpzskF2CbgjXeMCsLBw3ojy8mierYP+1tbGR6q31wmpMQxHF+gK11bTUldoOffU7Ia1W7Jr9+1KYd3f6LXPdZy2mG4SyHpdktkvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SMQ4hJ1u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=piuK4jmXPkNXZigQnP+7ADJheOUNtn+jvTH5r5ncPSo=; b=SMQ4hJ1uoGUrOnFC+E5O5ttRNl
	8hSwuHfySZ1Iod50RkDBW6atpwhF+XtQLV0TeW1NXrXKb1exFGsBUDS67I5YtXcx1v4t8sAlGwmYi
	xc8DiDP8mnlQL8zFodm+lUG/9okxgLJr0oL1pz2p/PC73vRlss1//UCqMGrFRiU1bna0wvBz6WrwE
	Gp9tymiMolNG0Hn8Cuouatz2YO2PhN/1M92YslWjv8NVUQe6FjNoOIGi9uQ5joXtDlo/IL7+LOsOp
	CAPP5KE0hBbnDhEuoij/sa4zhSXTwJbQlKM2xfpkk57Pw95/K2kPGL4CGZPotTSIEjjJhYFwzvxoX
	Nf5Qc+6g==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9PT-00F9se-2M;
	Tue, 23 Jan 2024 05:33:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2] soc: qcom: smp2p: fix all kernel-doc warnings
Date: Mon, 22 Jan 2024 21:33:19 -0800
Message-ID: <20240123053319.11196-1-rdunlap@infradead.org>
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

