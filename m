Return-Path: <linux-kernel+bounces-18466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D5825E0D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6050928510C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB933C15;
	Sat,  6 Jan 2024 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GIb+F8lU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2722909
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bgG0Wa9hAl+aGvy6zpeK/dJ5La0sq7ZbVHPbQUtvoaA=; b=GIb+F8lU4GA+6/SY3vIZ3kyXok
	qjVoqZg77d/qxf3+vkTzBfbG4I7vAg5VyVcBoQO6MBTyzFdmagDELBiLEqLw9ZwslUVm4L8TZDPCW
	7k30MWtDXHqRNYXkvNlwy1ONhI0blPukIZiHQggs4uEi+CKcYF9qGA4NXPeWwyWQnLCWY+5cynJc2
	VcgS1p6WGn8Nok0t0DC1E+GT2Xi+IKPa9qwBQ/MoZOGdd5IZeAArPkESV5PySywbh4N2iK5I2GbPo
	ygn3ngeL2+uf7jBufT/D1xh2PDxUbtS7xM3SOqb7USNCRZig7SUxt0dhchWmZInJrlEkjiR2VYjxe
	fUR7t3fw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLxHO-000fGm-1A;
	Sat, 06 Jan 2024 03:23:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/display/dp_mst: remove Excess struct member kernel-doc
Date: Fri,  5 Jan 2024 19:23:21 -0800
Message-ID: <20240106032321.28596-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quieten an "Excess struct member" kernel-doc warning by removing
the extraneous line.

drm_dp_mst_helper.h:156: warning: Excess struct member 'vcpi' description in 'drm_dp_mst_port'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a

 include/drm/display/drm_dp_mst_helper.h |    1 -
 1 file changed, 1 deletion(-)

diff -- a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -83,7 +83,6 @@ struct drm_dp_mst_branch;
  * @passthrough_aux: parent aux to which DSC pass-through requests should be
  * sent, only set if DSC pass-through is possible.
  * @parent: branch device parent of this port
- * @vcpi: Virtual Channel Payload info for this port.
  * @connector: DRM connector this port is connected to. Protected by
  * &drm_dp_mst_topology_mgr.base.lock.
  * @mgr: topology manager this port lives under.

