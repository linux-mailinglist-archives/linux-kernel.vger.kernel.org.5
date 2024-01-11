Return-Path: <linux-kernel+bounces-23016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE882A661
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B921F2402B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5FC46B6;
	Thu, 11 Jan 2024 03:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oK1I6Jy5"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E90468E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=+2DGeQL1MVpOSJxUNH
	cxtwdXajYv/cXBWYf6yhOsiEo=; b=oK1I6Jy597rgzqAc9BeAm5JlYjgD7Z74Hh
	cwf3qe6U+CLWKfFAqqelhc7L/7dIqB7bCwOy6Vwsglr/zbnGTrvkHi9Q9Quco8gr
	hfnr2ejQG3sDCYPi3eF+dHHT18KbApx8WOtbHBNHrBj+GRXbLtFOa2RxgP537jQ9
	Lw+l5CIlE=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3X4VtXJ9lba+dAA--.60099S2;
	Thu, 11 Jan 2024 11:11:41 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alexander.deucher@amd.com,
	Xinhui.Pan@amd.com
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amd: Clean up errors in vega10_ip_offset.h
Date: Thu, 11 Jan 2024 03:11:39 +0000
Message-Id: <20240111031139.7135-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3X4VtXJ9lba+dAA--.60099S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48Kr4kJw1Dtr48Crg_yoWfCrc_Ca
	4xXr4fGry7uFnFqF1IyFsrA3yjk3W8ZFn7Ww1ftF13JrsrGr18Way5Grs7XrWrur9IgFsr
	Aan5XFW5XrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRK9atUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGBJixWVLZWPjuAAAse
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h b/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
index ce79e5de8ce3..1a73296a9a74 100644
--- a/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
@@ -25,13 +25,11 @@
 #define MAX_SEGMENT                                        5
 
 
-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
 } __maybe_unused;
 
-struct IP_BASE
-{
+struct IP_BASE {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 } __maybe_unused;
 
-- 
2.17.1


