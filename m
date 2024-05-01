Return-Path: <linux-kernel+bounces-164963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC228B8583
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D81282A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C084CB35;
	Wed,  1 May 2024 06:13:11 +0000 (UTC)
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAFA4AEEA;
	Wed,  1 May 2024 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714543990; cv=none; b=tNbftATrAR+NZykznyCMbfcj0559Veb16MMRCHJTLp94pN0NwmkX1sn0skCQU++neavODiQIo+CiSycl9vVnMoWSm8cGGFW8XephJzg1ElOoYSy4sqIO5OBI9HMIncRcteDmfpPzfdcR++1qtHBdHYFs5BV1HPBAb0regFzZDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714543990; c=relaxed/simple;
	bh=/e9sY+SaMEqXblc2/CW6yINkIpZNGhoFfR3QI6K1TH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOId4Sr72ABMl28UnVPaz01DhChWPsQzNPo0m/Mo4Pkf4/2MaO+qaipbL/HvbDtyyo5YHg9bjOxRf8U+H2AUmhwkwuBetQvEMdK1A5MQw55tgF3d9g7jPQ44NVC0XSV7OzGntD7hyKNIXL/hZnlctFk1RgyrJuGwx9s33KBx06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso3657519a12.3;
        Tue, 30 Apr 2024 23:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714543985; x=1715148785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwS+r/rdI4rV0rumRC/q7YG2Q+QFhBrZIl/mXrqt2Ss=;
        b=H8nkA85Obcbr9wRBb/PX/C5dNE8YwX9HYL1zSFBmMKw+pVile3I1ohEPd2VHOTIukv
         Qn2rwltHKzI1LLOJMgxtw9giyVJZcYnu3F0SyhzDt3aYUuqRLfxDtT1XR/GEDQuUrBf9
         ig5E8ePGIsQf2i8xA/rB8pqrX/ghpDTvrVjUPG42I9IX7aWgDElF1kwyUQHZFfFOhUGD
         xvzckmhykaLpRr7r1I9njt/uXPgurIzL3Iv+dMvOeQn9ywgBgvZDlzoIrzgxXfjvYDEF
         S6CD4k+ceagUYIqTXbx3q6FBWlB1TMsYT42zK7+30TItuqgDSf5ostYWblUG+w7roI85
         Zp/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+cxOvqf9YW0UgVACBT1N7bCU6aX3JsvPw/bglR/fOT66D3OhqPwL4Kq8tTrdBsAkMRphHT7cUU8WNGHxUyyefuZIpgARdZb7EA5WM
X-Gm-Message-State: AOJu0Yxsf1FnKxvvxHlSi5R5hImODQsv4nGL/LZCRnO67ETllEGwPuIb
	gQMvUetFQ10W62Eb/48X1RcS2Ok1EtXE2I71BmQpa4Taj3Ttg3oL
X-Google-Smtp-Source: AGHT+IG19nE1xA5Z99xjQL3VY/EbDXAemE7N+EXJ4LUb+J386bdTNChiDMk+PyWgaNhq3ef+gQmMuQ==
X-Received: by 2002:a05:6a20:2587:b0:1a7:919f:2b60 with SMTP id k7-20020a056a20258700b001a7919f2b60mr1632139pzd.37.1714543985092;
        Tue, 30 Apr 2024 23:13:05 -0700 (PDT)
Received: from localhost.localdomain ([111.48.58.10])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709029a9100b001e2a4663179sm23448382plp.258.2024.04.30.23.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 23:13:04 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	xiongxin@kylinos.cn,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH -next] PM: hibernate: add retry mechanism for S4 image loading failures
Date: Wed,  1 May 2024 14:12:58 +0800
Message-Id: <20240501061258.2874092-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the S4 resume process, there's a rare chance of image loading
failure. We provide three retries to load it successfully. If the
recovery fails after these attempts, print out the handle CRC32
value. When the CRC32 value obtained on each retry are inconsistent,
there may be a memory anomaly. When the values are consistent, it
might indicate corrupted swapped memory data.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/hibernate.c |  8 ++++++++
 kernel/power/swap.c      | 14 ++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 43b1a82e800c..d9bcf38221ef 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -703,6 +703,7 @@ static int load_image_and_restore(void)
 {
 	int error;
 	unsigned int flags;
+	int cnt = 0;
 
 	pm_pr_dbg("Loading hibernation image.\n");
 
@@ -713,7 +714,14 @@ static int load_image_and_restore(void)
 		goto Unlock;
 	}
 
+retry:
 	error = swsusp_read(&flags);
+	if (error && (cnt++ < 3)) {
+		pr_err("Failed to load hibernation image, trying to load again...\n");
+		swsusp_free();
+		goto retry;
+	}
+
 	swsusp_close();
 	if (!error)
 		error = hibernation_restore(flags & SF_PLATFORM_MODE);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 5bc04bfe2db1..4b866c645cd7 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1489,15 +1489,17 @@ static int load_compressed_image(struct swap_map_handle *handle,
 		ret = snapshot_write_finalize(snapshot);
 		if (!ret && !snapshot_image_loaded(snapshot))
 			ret = -ENODATA;
-		if (!ret) {
-			if (swsusp_header->flags & SF_CRC32_MODE) {
-				if(handle->crc32 != swsusp_header->crc32) {
-					pr_err("Invalid image CRC32!\n");
-					ret = -ENODATA;
-				}
+	}
+	if (!ret) {
+		if (swsusp_header->flags & SF_CRC32_MODE) {
+			if (handle->crc32 != swsusp_header->crc32) {
+				pr_err("Invalid image CRC32, swsusp header CRC32: %u, handle CRC32: %u\n",
+					 swsusp_header->crc32, handle->crc32);
+				ret = -ENODATA;
 			}
 		}
 	}
+
 	swsusp_show_speed(start, stop, nr_to_read, "Read");
 out_clean:
 	hib_finish_batch(&hb);
-- 
2.25.1


