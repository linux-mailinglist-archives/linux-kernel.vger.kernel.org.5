Return-Path: <linux-kernel+bounces-117331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9146588AA16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C333E1C34AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB3971746;
	Mon, 25 Mar 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="W9qFDpeK"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14C128395;
	Mon, 25 Mar 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379322; cv=none; b=Rr1TsCyFCcHAzrcbfrjPuonuWTDiVV2ibtMqBZWKK4/1wFXPEUm/VU08mQe704VrRKiQFUgkdAZSHEKuYvLVfltLzGEN44nixFroCYQum6748WPrxQ5C4dDNH4H2kHTUeR+GmICAFYiZBQI/G7ErIxnMBoXxl85ljJYIkMJj2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379322; c=relaxed/simple;
	bh=4eUXmKM7SyiyHM/IxR2x3wjvf4JQ3Ytj0cbIwS+59Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TdJHqmPo5Vu+ddJfKWvSJy9BEIFwfw2hePl9snZBWAmQ1H17Oy/gxbjsSp+Pp7QG/cE4FevA1yOi/uy9TciYoo9ohdnyUz9/7yfKu5agVbKPchMxXWE8CcqpLi7nCQnbHbNMjG/9OHz5dNWRa+0+54tC6o0iibVG3fDHM7hW9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=W9qFDpeK; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rolwF-003KEw-0u;
	Mon, 25 Mar 2024 16:08:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sWnFDfi1/XqxIpOEFodQssSrAAdigmg6P7HROJwwOI4=; b=W9qFDpeKt57pNsUuHdG4rbVqS/
	Xia3MmBHHQ9FIzT5KmUnjwn/B0O9nIDIaZCGsj4hIPyfUSsSb+5ERzwkPjHcj878yfoHGjNbaQlax
	3uOdBAhZvlLI+5VHhnzRRj/U0E5S4f14dWPCvqT0eUGLUlQpzC0oUQAydZSO4T4dEklNfwwbz6Rxw
	MAFAm/FOITk5X+XjUD180WE89gr1z7WfBFA1/Rl2EZ3zScpmS4ggYM0kWru/P5HmEKq7JQZiYyTyl
	L/zBTpSnspJeoFozbvR8k/i6FDIIMwisiJa9DBdl8MpXhfuIXsh2fA4CGqe6MHXe4xk/DkgZQ+c0c
	V1yFjzXw==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1roUCT-000Y9b-VS; Sun, 24 Mar 2024 21:12:13 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roUCS-000yR4-21;
	Sun, 24 Mar 2024 21:12:12 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [RFC PATCH 0/2] mfd: rohm-bd71828: Add power off
Date: Sun, 24 Mar 2024 21:12:08 +0100
Message-Id: <20240324201210.232301-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power off functionality. Marked as RFC because of magic numbers
without a good source and strange delays. The only information source is
only a vendor kernel.

Andreas Kemnade (2):
  dt-bindings: mfd: Add ROHM BD71828 system-power-controller property
  mfd: rohm-bd71828: Add power off functionality

 .../bindings/mfd/rohm,bd71828-pmic.yaml       |  2 ++
 drivers/mfd/rohm-bd71828.c                    | 31 ++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.39.2


