Return-Path: <linux-kernel+bounces-93228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E415C872C90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577D2B22233
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E09D29B;
	Wed,  6 Mar 2024 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="lzv7qrNY"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7717FE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691057; cv=none; b=qzBccyBAKLpiknPzDSvwybNtMcCfQXgBrRrrDcV2wIafmxhc/VcIJypXBIEq+cC45IrbaQtMLoOSf/SPsn6S3GorbX0Ipb9c1hYIkUSayK53YJ3v9pu5SWT7h1YAZcdY3j3HBCWU2u9ZJ/hKZhyuyI9LHMAnNsO5Tcj83XImeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691057; c=relaxed/simple;
	bh=YjLFxDb1a8kwlPycmJzHsBR+BeJHCMj9DDXnHJdsiCk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZmJu5mup63SfBkwAonw5zs1jSpBbsQPuWD1mI6b8Q7ba3+zfdYA/VG0sBZV6s1z/dAPAQEoeR0OVe+9ZsLFFwtC/cQYJkHFmvtpemyMvbZqVirbExAagpjubK0Kfz1iQZZPvP7CtnDiWnhVGJnomuq1aFQAqCCmLr0Uv1svBOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=lzv7qrNY; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zCxEGb0mnx0UG+l1KpllEKhQN/7/zBRB0JApGyWfuwc=;
  b=lzv7qrNYN2vhhg04j4AVuZ9Jd6BEzmZ0lUrTZsiBWhOyoXs/qFa6grTj
   mibA0ZkIgyQaz85Gm7zl7RFlQswZ/QSdmoB6Pk7Y/OQdHRLZfrHhOW0Yz
   9OPobbdP/6HUgGmbCEQ2gH13uChre/Yn6MCK0LoiUVWjGbpBUh+WtaPHH
   0Cjf/VB0/sn9nLKd1gq2ec/AuthDEocUIY/PIwIu7xpqhYkEeeesCMupQ
   PU3PsgtvOGGe/0PgIGqSt2yVrdY/cP+qzteU1w0Del/vi8hKkGXe19h0F
   mUVeZ1sUZmUYJBhrEo3QnyNN4gTJZAIOkcru3VEpJOSOF0r64exFtI6Bm
   g==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 06 Mar 2024 10:09:40 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 42629cT7035623;
	Wed, 6 Mar 2024 10:09:38 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 10:09:36 +0800
From: kuro <kuro.chung@ite.com.tw>
To:
CC: Allen Chen <allen.chen@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>,
        Kuro Chung <kuro.chung@ite.com.tw>,
        Kenneth Haung <kenneth.hung@ite.com.tw>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/1] drm/bridge: it6505: fix hibernate to resume no display issue
Date: Wed, 6 Mar 2024 10:20:02 +0800
Message-ID: <20240306022003.259245-1-kuro.chung@ite.com.tw>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP:
	2DFA835B7C214D7669D99BAA3D584D1C5E99CA3D8F1D676F920BE02F59D14C3C2002:8
X-MAIL:mse.ite.com.tw 42629cT7035623

New patch description for v3 patch 
	
	update upstream MAINTAINERS mail list

New patch description for v2 patch

	Missing declaration for i variable in function it6505_irq_video_error_handler
	, add it by this patch

Origianl description for v1 patch 

	drm/bridge: it6505: fix hibernate to resume no display issue

	ITE added a FIFO reset bit for input video. When system power resume,
	the TTL input of it6505 may get some noise before video signal stable
	and the hardware function reset is required.
	But the input FIFO reset will also trigger error interrupts of output module rising.
	Thus, it6505 have to wait a period can clear those expected error interrupts
	caused by manual hardware reset in one interrupt handler calling to avoid interrupt looping.


allen (1):
  drm/bridge: it6505: fix hibernate to resume no display issue

 drivers/gpu/drm/bridge/ite-it6505.c | 54 ++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 9 deletions(-)

-- 
2.25.1


