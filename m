Return-Path: <linux-kernel+bounces-164747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FC18B81F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0607C1F21517
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705F91BED9A;
	Tue, 30 Apr 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kW3Pqz3x"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA531BED60;
	Tue, 30 Apr 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513003; cv=none; b=MRcbNdnr6E7M1C2AAn1eJRTpO05JC/wnIdsg5jmcio2JhX63KAJ3Lv7NJ7d0NAHwwIlpR+/KClyFgDiIOoDHGT08M+qwuEy6uTKkOyDXfZ1R2vIs45K3julhzbV0ltTd0iybx8kdo5ROuopTd8TFWUo+yaI5yr71p/Zvdz7tbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513003; c=relaxed/simple;
	bh=8wmctBpBoob2v9+vY4JOC+E0Zgc0jTFshoOo4TzelD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McGpyG3qQIzSnUz5IgmEVAGmsxBFiimSGElSoRNYg1qA9+CeZTR7EEISO6WIx7kpqxvoeHEsEPQ3qRiJhZx1suTsUfWSf9IwOrv6JnVHDh7Z7WwPORA5ywxSUEKbPGGL7/jebejalpa5JoX87zI2vieS8c7DJj+DoG1YHEWdXTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kW3Pqz3x; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (237.69-130-109.adsl-dyn.isp.belgacom.be [109.130.69.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6279CDFB;
	Tue, 30 Apr 2024 23:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714512944;
	bh=8wmctBpBoob2v9+vY4JOC+E0Zgc0jTFshoOo4TzelD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kW3Pqz3xsVKcPSo0AMj5291wkB7VvNxzY5t9iGFdhEQXsmcKNt7Y4LcPt8F5dGdbT
	 X7YNb8Rlzq5umn6j0c6Uy8LxS5ZQG8xMLUJtDbCUds9qcIddaIaurOtHhlCxzoCDKT
	 GcCTHIVfMNqU4vz2a2sAOYOIgb2BSjxB+Z3NlpgE=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Naushir Patuck <naush@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: bcm2835-unicam: Include v4l2-subdev.h
Date: Wed,  1 May 2024 00:36:33 +0300
Message-ID: <20240430213633.23767-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430213633.23767-1-laurent.pinchart@ideasonboard.com>
References: <20240430213146.23187-1-laurent.pinchart@ideasonboard.com>
 <20240430213633.23767-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unicam driver uses the v4l2_subdev structure. Include the
corresponding header instead of relying on indirect includes.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404302324.8aTC84kE-lkp@intel.com/
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index c590e26fe2cf..3c7878d8d79b 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -55,6 +55,7 @@
 #include <media/v4l2-ioctl.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-mc.h>
+#include <media/v4l2-subdev.h>
 #include <media/videobuf2-dma-contig.h>
 
 #include "bcm2835-unicam-regs.h"
-- 
Regards,

Laurent Pinchart


