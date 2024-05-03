Return-Path: <linux-kernel+bounces-168243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C408B8BB596
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73FC1C225A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3772984D30;
	Fri,  3 May 2024 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxWLOxNt"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1C882D64;
	Fri,  3 May 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771376; cv=none; b=k64CCsPVCrhke99/bpPUFUUq0hcr+n+Y1wzXEcsHCD7XQJpXcgbbW8DAR5f/QkRDSDuoeC9WT18I+PViVShcf1HaZ1D13r7ZXzTeX9lri8J70ZKKIbaJkOQ77MtKJuLbr598Wlg5SoLzquHonNUwlnAm7j2U/1LRPPrkRxtuqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771376; c=relaxed/simple;
	bh=K4NcSEpC7I/4aUwVZiqF2rm1O+WGjxoElYis3WpGrUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVVXs/adkNoo3+5lhftfY8UlCBqcp5zpVa9aIDQc6YR1UIgyLEs9Blw86PWd7ScZaffgFmYrJNwHbPncU1hKNvuOIXwFU2JaGZRzEDWi0qCnjwGbDJGzxeORGNYgkJM3fkTkQnl9ixlvtFx6S7PAw/+7muH2xre+exp6qvhVbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxWLOxNt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f3a49ff7dso87122e87.2;
        Fri, 03 May 2024 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771373; x=1715376173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bvhcIi7s7OtBZ29qVZiiarvKCxPVK9OqdYkfozMUGo=;
        b=MxWLOxNtxxWJ3uQG7KQOZ06Cv2XZVmKw6PAoqu6/OV2m5EkG7a+J7VwPUVuofZCCAv
         JzoLLajHcFt4FKILsB8m863l1LRNQWQbinv2qx0UUl9rv4n0RA/XBJddJV7+FKk/OWy/
         LTE9/GGpzhjWhDsdoyH3OCdu2RE8l2fKtjIdx3juLEKKIvEBglArTvdtWbsUZdvKXn4/
         1lLz0ZyUB5XyNGIJlYFKs3M1r8na+2s1Bo9awLKTkjafFrMprjcBy3PbDWuqcuIwfp3U
         yzTFc/AJG9BFLh75iXpXaRQUtowXp/wWRuQQkczo7nj/rv/b/4dQXsaiUPa2kRaApoxy
         zg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771373; x=1715376173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bvhcIi7s7OtBZ29qVZiiarvKCxPVK9OqdYkfozMUGo=;
        b=S2KwNAPS/k4soq/qZISijrh5QpPenTulqaL86Upc/XhxIZy92OcsYxuZI7PwUKLT8A
         h4DUuwxqx+i6uOHlPCAomUJYxfQHdhN4vp5xTwYIfO8gADF+cFrty1yu7BADnDAe89/i
         2SfPZbxFzmQhiTsvecSbCz7LvtXYhIaomO5Ug/NJLJmlyt9u8PKXBa2QHDtRAzup+4h5
         68f0PU9h7dT9araurFU7wqCpZlIBiMSrWRtIYgoxtjtBZ6tHA9Wf8iYi+2wroXWd8wTJ
         beAOs//9ed16EPO9WfBrmSVS4+QdACsRyP5PSjAL977F9TCZSYHqR6EIiDD36uAr4aBK
         SKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiZGarekBO2V6dQXixDpkVlndzEdOFAlO6YLhzojkFzZjJuyY4/qjuv3uERY/LgpM0cO2FX3d8n9ikP2/HEntpz3EHv3QMd4yXVPVv2/KirUGlKurW9fX846xbwvM7phC+ArB8nFVOnw==
X-Gm-Message-State: AOJu0Yz6eTpVGtYEHfYCvMicy8moGG60J4XHAsLeNL+WGgjLWh3KbWd7
	ucLpB5+nnmCGEDd3gGYQaqtyhQdvqldNwqDOQqPHLGUOatIq6Zm1
X-Google-Smtp-Source: AGHT+IHKt7/IlhLnAgzH8evYd55jGnh8jC+7MGS9qJrx7K/YQeZM+131ljiwIjiNWKPIrFhyU1yuIQ==
X-Received: by 2002:a05:6512:3ba:b0:51c:d528:c333 with SMTP id v26-20020a05651203ba00b0051cd528c333mr1804987lfp.20.1714771372707;
        Fri, 03 May 2024 14:22:52 -0700 (PDT)
Received: from localhost.localdomain (80-108-76-242.cable.dynamic.surfer.at. [80.108.76.242])
        by smtp.gmail.com with ESMTPSA id mt20-20020a170907619400b00a59a4261b84sm162073ejc.141.2024.05.03.14.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:22:52 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Christian Gmeiner <cgmeiner@igalia.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8qm: Add GPU nodes
Date: Fri,  3 May 2024 23:22:48 +0200
Message-ID: <20240503212249.3102288-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Gmeiner <cgmeiner@igalia.com>

Add the DT node for the GPU core found on the i.MX8QM.

etnaviv-gpu 53100000.gpu: model: GC7000, revision: 6009
[drm] Initialized etnaviv 1.4.0 20151214 for etnaviv on minor 0

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
v1 -> v2:
 - Order by subsystem register address.

 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index b3d01677b70c..8e061582a4c9 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -463,6 +463,7 @@ drc_crit0: trip1 {
 
 	/* sorted in register address */
 	#include "imx8-ss-vpu.dtsi"
+	#include "imx8-ss-gpu0.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
-- 
2.44.0


