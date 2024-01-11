Return-Path: <linux-kernel+bounces-23156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E0482A874
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B69BB22A34
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335ADD2F1;
	Thu, 11 Jan 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MS8cWZvq"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E739FD2E4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=wKzGz4voE5HPmSK469
	UfyON0mOrKN5XeFNIaTs52KKs=; b=MS8cWZvqLviEE+4uKQFLyqLWU6ysLLO5GB
	fxmxeP+WCGQy+cIlqvYF3JRytvT0ofRg5o1V1sAjxt2Fiqe4mpd6Tzilhl3xzjK0
	bZzqKND90KVoZJLQyQYHrPhSpP4IfqawvmHcTeK6x4cUw2+ZMR/ayaEM2LTpnaOl
	ZOw4DagE8=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD33+WNmp9lnmGSAA--.15450S2;
	Thu, 11 Jan 2024 15:36:45 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/radeon: Clean up errors in radeon_atpx_handler.c
Date: Thu, 11 Jan 2024 07:36:44 +0000
Message-Id: <20240111073644.10491-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD33+WNmp9lnmGSAA--.15450S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw1kur45Gr4UZw48KFWDXFb_yoW8JF15pr
	W2kr92yr9a93Wqkas7ZFWxtFy3Aa1kJayUWFsrG34rur45JryDGr9Iga45JF18Jry8Zr1Y
	qFnxWa4avr1xA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UwFxUUUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEBpi1mVOBk6DhgABsZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following function definitions go on the next line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index 595354e3ce0b..f557535c1d7b 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -61,19 +61,23 @@ struct atpx_mux {
 	u16 mux;
 } __packed;
 
-bool radeon_has_atpx(void) {
+bool radeon_has_atpx(void)
+{
 	return radeon_atpx_priv.atpx_detected;
 }
 
-bool radeon_has_atpx_dgpu_power_cntl(void) {
+bool radeon_has_atpx_dgpu_power_cntl(void)
+{
 	return radeon_atpx_priv.atpx.functions.power_cntl;
 }
 
-bool radeon_is_atpx_hybrid(void) {
+bool radeon_is_atpx_hybrid(void)
+{
 	return radeon_atpx_priv.atpx.is_hybrid;
 }
 
-bool radeon_atpx_dgpu_req_power_for_displays(void) {
+bool radeon_atpx_dgpu_req_power_for_displays(void)
+{
 	return radeon_atpx_priv.atpx.dgpu_req_power_for_displays;
 }
 
-- 
2.17.1


