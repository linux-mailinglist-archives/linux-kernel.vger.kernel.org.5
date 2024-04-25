Return-Path: <linux-kernel+bounces-157909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 244048B187B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52530B2196C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74E2F9E8;
	Thu, 25 Apr 2024 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hn1ek1Wc"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398585672
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008973; cv=none; b=BJEAKU40M4/ZS9k5cNd+OfDk1QC70bYWMqcbpDx9E30A5UCgcjW4oRAYxiceuqGmsg3VVpwJRK2uLQaUvXtCSwuX3ASUMHr0zqCEwbfnk1wGRqJO4Z2B5yRI+c39xZq3EwTWzXMySmcJCo/X7G9YllNop3KxfOerg9sE+rzfIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008973; c=relaxed/simple;
	bh=WJiGUaR1Rw+Wsub2mAoyVlBOdrInMUTgxaCBKV7q6CM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5WkcviWHK97AV4guG9fWFl9ibAXI4c9DtdIfzi3KYmUCI6eHNodGwkI5LU7h92E67d5oGTluyDxOw2GrqZUDaYO+0gQIkH67ZhathIpyd9mMuCgKHrcW0s4nNQjsg+k7OXSYLHm0QchlmhkBEIGaHpWIrB8FnU3cXgeJyKlQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hn1ek1Wc; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714008962; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TsKxTcHAEpnqxtYbRg35c7pmhQDqwU3NSLGP9bX/w7I=;
	b=hn1ek1WcgYn5ZaXkDfyvBjXw2H90hFrezWBfOzQb9JLX0Z+zL+MNa+TfEHVKEruNvkHN/hhHVZ5WHWL30MBc5B6wOK+kryOivubNhDiCMbMdamvYd4Ajpfr2B8JslwNNLfMPbYDioQmHExwv2eOvjKmBm1/yDImqcIfUu04Rxww=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W5DffHY_1714008955;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W5DffHY_1714008955)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 09:36:01 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Remove duplicate spl/dc_spl_types.h header
Date: Thu, 25 Apr 2024 09:35:53 +0800
Message-Id: <20240425013553.35843-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h: spl/dc_spl_types.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8884
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
index 5aa2f1a1fb83..28da1dddf0a0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
@@ -31,8 +31,6 @@
 #include "fixed31_32.h"
 #include "spl/dc_spl_types.h"
 
-#include "spl/dc_spl_types.h"
-
 #define CSC_TEMPERATURE_MATRIX_SIZE 12
 
 struct bit_depth_reduction_params;
-- 
2.19.1.6.gb485710b


