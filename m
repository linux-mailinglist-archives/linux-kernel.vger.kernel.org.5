Return-Path: <linux-kernel+bounces-71299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A160E85A324
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4116B1F256C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5882D79D;
	Mon, 19 Feb 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="HnIggYjM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hFjUjvKR"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBAC2C85D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345504; cv=none; b=oOk7yhmzD3JnG6Hhz0NkGn7Sv1RSLWz4ceycD8rWHlWZfHRHHjfN3aTeCb32LzPE6ynqhzhFoKRcoCJHq6o1CZXXhOmN5akrx8K/trVCZdcSFEjA6zgGNRPi9bFZJiooUXietzPncFrsL/mtTi8MVxD+GgLTo6zqTqnbemvtb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345504; c=relaxed/simple;
	bh=/44+gQD/UlR0hu8XRMSSUspG16Q/7s/TbW2Y3w2RrHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ME77Fq8uPrCz4wmERYhzR5+BF5PATlgpve7OfD63HKR2q8hUiHf4n75f/17MjfKp8tnMdXdESc9msWTg2UnKOxWcsr9xRLEGfsq76YD1hejUjIReLbgwVfrzJ3k46dIExcxyKVOVLrX7RWw18Lb6JhoWIt736+ED1L83XSCxg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=HnIggYjM; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hFjUjvKR reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708345500; x=1739881500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9bZTQfFErD83ZpeUe8f6tUjcWK8u+2HNM0QEJ6Cyo2s=;
  b=HnIggYjMmfXOgTgD8bqQdWdgihavrg3fSgSTvE7kpzeCdvTwIefo8erT
   XzYc9cknf/VMT5VrEbIUKplfi5b6hEgxPkdHHGskqXDqucB4/ACU2wwbH
   6mHuEr7DEQ7S2OTbeNvc30+XYcscyrF8ITYS2JqfFIpFj8ZSiWqnBj2hS
   8INUpZ7ygtJ7XHua29h7vm3u0Vof3MIfVuim+eHW3tKi79yzUot5yf3yR
   bi3cZrxJJBZh+n54srEBU+6QWD+QfIhWQ2/xRzn33a4SxEUGVB3Wfygcj
   8aR6k9zrjQptnFsULvu21Vl1nAxt0m+Q48T7A6kg2ymTe88BGy5wp/diF
   Q==;
X-IronPort-AV: E=Sophos;i="6.06,170,1705359600"; 
   d="scan'208";a="35475550"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Feb 2024 13:24:58 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5077216F242;
	Mon, 19 Feb 2024 13:24:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708345494; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=9bZTQfFErD83ZpeUe8f6tUjcWK8u+2HNM0QEJ6Cyo2s=;
	b=hFjUjvKR0JKs/dssdk3MOmFCIW3zrTofvZq+9VGGWnsKnyqLBoZPGYaUBP3GS8EXdr1DUl
	7ypoTNyPVIx/0+aNooOCTkLGGDTb77pTqCqArMCw7b+mFHgRZZi9uvCNxcTBPREg9OoZQx
	ksdvTDvQe6oT1rnst6F03X0B3SLkhWUZEUv2aZhwIt2yeeZDCxo9aq2dmfZ+0Ew7+oLf2/
	WJrP5yOehtVQAfPqWR9XQoddQ5Mk7ccY+SNhJ/uBinfZH7QYWETfKjLNgcl67vMRRqXT4F
	6IxEumVeXKw/Z9XOG2BWLq4ZH0QBJSJmZ2uB7oFY6rPOlXgC7J2efvVFLuPiPA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND 1/2] drm: fsl-dcu: Use dev_err_probe
Date: Mon, 19 Feb 2024 13:24:48 +0100
Message-Id: <20240219122449.3083748-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

fsl_dcu_drm_modeset_init can return -EPROBE_DEFER, so use dev_err_probe
to remove an invalid error message and add it to deferral description.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index a395f93449f3..90cbd18f096d 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -103,10 +103,8 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 	int ret;
 
 	ret = fsl_dcu_drm_modeset_init(fsl_dev);
-	if (ret < 0) {
-		dev_err(dev->dev, "failed to initialize mode setting\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev->dev, ret, "failed to initialize mode setting\n");
 
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret < 0) {
-- 
2.34.1


