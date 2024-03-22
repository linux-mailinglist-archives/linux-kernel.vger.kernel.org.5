Return-Path: <linux-kernel+bounces-110979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2997A88669C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CCE1C228A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08581C144;
	Fri, 22 Mar 2024 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S1z57kLv"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DE6BE4C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711087753; cv=none; b=PNTUufpVYavJA3GjmlFDHyCIaIu3UaMa7i5r0VQdlOxkRBYnmp78zNa2imQhmlNdZ9f5EtgYIaZNHonDlZhbR3EDb121cM/O7Dthh//wrqMZ4AoJxxACEw4AoNa2aefK0Fw9no2v3tGkmcASQmR0lXMHh6oL7a8fMxiRGgaMMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711087753; c=relaxed/simple;
	bh=pUs6u1RK/Iri4Co+CnkIKgtpNPWGUEi8HJ+KcK4egAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oA+D2bWLvcGkwJr8FfalUUf1kY5tL/Cu22p2B7+IfQVf3ZGkYvWPJ/41nu5hxFpwxh77kZeEApufSdYPZBU3YAkvPiI12YZnoQttMQCENd+ydSjHlV7v36+xFV6xMbc7+A31uyRFrJJEeRxkvCaDAKsNeKvcq4OTDJ22qMgfgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S1z57kLv; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711087748; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZnOfZWACaOxrEQs6ttoM82Jv+ZuQFuiTW3VGfaJ+7y4=;
	b=S1z57kLvBLGQBzudboj9SIzJyvt9nFQS387TwNS9Y3X8LEY2Dcmq5RZRLMZ9MrXQ7w4lz2T4K9A4xMTajpW6t++5yLTaTpD6KXdC4b6gRvq9Rn8L50twsJWjXw9BQF/+WtuMTA7sBjQR+0dSb5kwR4E+Wp3onUVva+KxtqT8gOk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W315rNc_1711087740;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W315rNc_1711087740)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 14:09:07 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: clean up some inconsistent indenting
Date: Fri, 22 Mar 2024 14:08:59 +0800
Message-Id: <20240322060859.120155-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn351/dcn351_fpu.c:569 dcn351_decide_zstate_support() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8608
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index dc9e1b758ed6..1c16c5f2ce78 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -564,9 +564,8 @@ void dcn351_decide_zstate_support(struct dc *dc, struct dc_state *context)
 			dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 
-
 		/*for psr1/psr-su, we allow z8 and z10 based on latency, for replay with IPS enabled, it will enter ips2*/
-		 if (is_pwrseq0 && (is_psr || is_replay))
+		if (is_pwrseq0 && (is_psr || is_replay))
 			support = allow_z8 ? allow_z8 : DCN_ZSTATE_SUPPORT_DISALLOW;
 
 	}
-- 
2.20.1.7.g153144c


