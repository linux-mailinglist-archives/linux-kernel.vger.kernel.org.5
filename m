Return-Path: <linux-kernel+bounces-93590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B1A873218
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62CB28ED44
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7455EE6A;
	Wed,  6 Mar 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="id1X1JK9"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3F5E07D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715584; cv=none; b=CTk7y7FkT7Rx+gjNRNGHt464n6pdSEdVkjWjPeTVPPHtxXTVDf20O49IOt7jmA5xiarWQUL0XuXLGM9yV0FmTF53Kw9d+YnuqdPgmzr/+i8+a+RusZBuGcxhKP7zvXX8pi3+ilAPl7fUpeDGRk+4A7O0ELBoGyCLtDrAIELXyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715584; c=relaxed/simple;
	bh=0RMThRYDQdA0TKmAkapeJIRKOEouEr8pVUiXNRXISH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m7igrEvAjZlql/wvihXlKZO7o5JOTEexg9l648pMO5PSDkdnOqQ7Fg6pVIyjsTaNdfnEu3DKtnSom7Lj1z8ZYxZMsO0Kov5Bm9zIIt43mjL0UEVVUFru4YuEZAbIgkkB+VPGBC6UE+2fR/6Cvc+d8/11NYF4muHjiibz5VDaHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=id1X1JK9; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A14C1C0006;
	Wed,  6 Mar 2024 08:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1709715578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0DSKgS0W+zLLPr66Oq1nzuRX4tN4JYLBFnk2o4+Pe20=;
	b=id1X1JK9Pw9kR1CVsvoDE9Ix1KShX5NnPsaPvdlarcPXBOGauvtsdiK3dKffjueUlug0WO
	npw2KwBBNTfcQA7nIqZdaEnt76TgTSRc3Dg8exjmKey/U2xUKtxz8Yb4LqTJyeQf1uo/hU
	He+EN7P7tA/FuiEGBYiodsJHSdFYGu7NztyJEGYXpeG63F1sugNCiI9+7j4F30sb64NkQk
	P1/fHkTw/Y4pcHsVvIyGcSyYK+P4Rx5Y3NFdmAwndhebtokC4AXb8S7ydf0beEdUIc36/R
	v6p6Pt2Nahc5Qwf4kf+6RZxQV3e67z8rGVXDvA8s09rg+OpjpyO/3RT+KzBIPg==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk,
	stephen@networkplumber.org,
	o.rempel@pengutronix.de,
	quic_bjorande@quicinc.com,
	heiko@sntech.de,
	konrad.dybcio@linaro.org,
	kuba@kernel.org,
	akpm@linux-foundation.org,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH] mailmap: add entry for Jean-Michel Hautbois
Date: Wed,  6 Mar 2024 09:59:34 +0100
Message-Id: <20240306085934.35904-1-jeanmichel.hautbois@yoseli.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Despite having contributed several patches, my email address was not
previously included. This update ensures that my contributions are
correctly attributed.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 43031441b2d9..b18e0437e2d7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -250,6 +250,7 @@ Jayachandran C <c.jayachandran@gmail.com> <jchandra@broadcom.com>
 Jayachandran C <c.jayachandran@gmail.com> <jchandra@digeo.com>
 Jayachandran C <c.jayachandran@gmail.com> <jnair@caviumnetworks.com>
 <jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
+Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
 Jean Tourrilhes <jt@hpl.hp.com>
 Jeevan Shriram <quic_jshriram@quicinc.com> <jshriram@codeaurora.org>
 Jeff Garzik <jgarzik@pretzel.yyz.us>
-- 
2.40.1


