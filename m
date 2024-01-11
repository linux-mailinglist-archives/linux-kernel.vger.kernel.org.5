Return-Path: <linux-kernel+bounces-23324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D0A82AB10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3524AB2823E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280FA156FC;
	Thu, 11 Jan 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="g74hUQK4"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E4156EF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=lUESUWScUg7zl++lrC
	xFQNFSOv+99NUxm69O0wryTxk=; b=g74hUQK4mOq55L1qSMMqNf4GOEMnMEeidR
	Md2PSxSC+OXM+5OQ4PfvQ3OoYSfJ6ood5WBdm1VSmVub7jh1RjtbO8S+ptowtHqs
	PEDi2ZFOtvzkY4GXR3OysQgy4AG8Fs4mNsPd6FKSVbcwfDR0bw0bNM3YZfSephur
	RcRHoLsXY=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wDnb7nOtZ9lnr82AA--.6085S2;
	Thu, 11 Jan 2024 17:33:02 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] drm/radeon: Clean up errors in ci_dpm.h
Date: Thu, 11 Jan 2024 09:33:01 +0000
Message-Id: <20240111093301.14086-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnb7nOtZ9lnr82AA--.6085S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kKrWDGw1kWFy3try5Arb_yoWDXrb_Cr
	yxXryDXrWj9r1rt3WDur1xX392vw4UWF4Fkw18KryfJF9rZr18Za9xAryDX3WUuan3JFs8
	JwsYqa43GFZ7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhJixWVEuYCGRAAAsV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/radeon/ci_dpm.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.h b/drivers/gpu/drm/radeon/ci_dpm.h
index ac12db5f2cf7..74b95c200222 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.h
+++ b/drivers/gpu/drm/radeon/ci_dpm.h
@@ -87,8 +87,7 @@ struct ci_mc_reg_table {
 	SMU7_Discrete_MCRegisterAddress mc_reg_address[SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE];
 };
 
-struct ci_ulv_parm
-{
+struct ci_ulv_parm {
 	bool supported;
 	u32 cg_ulv_parameter;
 	u32 volt_change_delay;
@@ -113,8 +112,7 @@ struct ci_dpm_level_enable_mask {
 	u32 pcie_dpm_enable_mask;
 };
 
-struct ci_vbios_boot_state
-{
+struct ci_vbios_boot_state {
 	u16 mvdd_bootup_value;
 	u16 vddc_bootup_value;
 	u16 vddci_bootup_value;
-- 
2.17.1


