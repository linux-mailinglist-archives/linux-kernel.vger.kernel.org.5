Return-Path: <linux-kernel+bounces-20052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAED8278BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE721C227D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5FD55771;
	Mon,  8 Jan 2024 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7a3EmDK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71854F9B;
	Mon,  8 Jan 2024 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso669436a12.3;
        Mon, 08 Jan 2024 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704743422; x=1705348222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2R0zlBz2DXccrkgQnIyzHmDUvfxpJFjGNN3AHHEOyFM=;
        b=Z7a3EmDKCPf9p96AQ9Y6lgZ7+k61GL9Ep5sxPG0ISmsgTpJM6NnrFN+ySdDbzLZIev
         8QllqVIps5glSAybDDAmVgubf2kb3jIcAtC2LmSRoDrEABc2uRhitG8w0tp2YrdrSFDD
         vEj0h95a82RB+VU2uEC/AYThamKkDcJMPdEYF5InSG0eOLaXd+K6RThvVdEc5HziKL4Q
         5mPvIRZYJQonvQ9uvJsy9wRWY3ILbsb5/qZjX+EOQRLLrZCFfIun5mgBV1d1WBkMRTmJ
         41QD79JA8OVZXGI0iWeXOZfn3VecJOhiUnPX63mQ0aGA+oWWBk31vF7377DhCUfMz6IV
         Cs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704743422; x=1705348222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2R0zlBz2DXccrkgQnIyzHmDUvfxpJFjGNN3AHHEOyFM=;
        b=u1wyWlldSOlqA7MeKan088GIiOUwBtVVF0h9XvUR9uul1ejlMcNNViQugwr1QHFN9e
         dzGn+8bV7TI8lrWDtMMsg237RJ6b8qtOaujXQ7R70UMRg8CjfsCTVJNDfNMTTQ90K1aj
         iZh47aPZGaX2zMvOKBGZMZz5soGUDHDk+UEiS1rcfo1xCmMRAgYcb2C9tWsnJhrsrKfP
         ilG4IJki1eCHfqQCTgBwFk4OzifgiiqeUq527SnvyiPlbQEwelsLfLXoKW35n6lfIG0U
         z6ljcHAtBhvw7rfwULjufqKXMOqVZqF1oSxT6QO5a4l2RQkLxsGBTvw4vGxzKiSZlYFb
         66Dw==
X-Gm-Message-State: AOJu0YxuhrsM6QAtYfbUm9JSSVChiL+4nJcAmkP7A6dG/+fd44Q1NmNC
	7wa2qlDuAXmyzXN52JJKEUs=
X-Google-Smtp-Source: AGHT+IFf7bb+iQyGZCfeOZ4yETzKVzgPT8q475MfZ+Nn78kr9SK7zahR4amHIomcUp8eIV9KVHXxbw==
X-Received: by 2002:a17:90a:9742:b0:28d:7b8c:1038 with SMTP id i2-20020a17090a974200b0028d7b8c1038mr863770pjw.43.1704743422053;
        Mon, 08 Jan 2024 11:50:22 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id fr18-20020a17090ae2d200b0028ae0184bfasm6753441pjb.49.2024.01.08.11.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:50:21 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>,
	Helen Koike <helen.koike@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/ci: Add msm tests
Date: Mon,  8 Jan 2024 11:50:15 -0800
Message-ID: <20240108195016.156583-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

The msm tests should skip on non-msm hw, so I think it should be safe to
enable everywhere.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/ci/testlist.txt | 49 +++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/ci/testlist.txt b/drivers/gpu/drm/ci/testlist.txt
index f82cd90372f4..eaeb751bb0ad 100644
--- a/drivers/gpu/drm/ci/testlist.txt
+++ b/drivers/gpu/drm/ci/testlist.txt
@@ -2910,3 +2910,52 @@ kms_writeback@writeback-invalid-parameters
 kms_writeback@writeback-fb-id
 kms_writeback@writeback-check-output
 prime_mmap_kms@buffer-sharing
+msm_shrink@copy-gpu-sanitycheck-8
+msm_shrink@copy-gpu-sanitycheck-32
+msm_shrink@copy-gpu-8
+msm_shrink@copy-gpu-32
+msm_shrink@copy-gpu-madvise-8
+msm_shrink@copy-gpu-madvise-32
+msm_shrink@copy-gpu-oom-8
+msm_shrink@copy-gpu-oom-32
+msm_shrink@copy-mmap-sanitycheck-8
+msm_shrink@copy-mmap-sanitycheck-32
+msm_shrink@copy-mmap-8
+msm_shrink@copy-mmap-32
+msm_shrink@copy-mmap-madvise-8
+msm_shrink@copy-mmap-madvise-32
+msm_shrink@copy-mmap-oom-8
+msm_shrink@copy-mmap-oom-32
+msm_shrink@copy-mmap-dmabuf-sanitycheck-8
+msm_shrink@copy-mmap-dmabuf-sanitycheck-32
+msm_shrink@copy-mmap-dmabuf-8
+msm_shrink@copy-mmap-dmabuf-32
+msm_shrink@copy-mmap-dmabuf-madvise-8
+msm_shrink@copy-mmap-dmabuf-madvise-32
+msm_shrink@copy-mmap-dmabuf-oom-8
+msm_shrink@copy-mmap-dmabuf-oom-32
+msm_mapping@ring
+msm_mapping@sqefw
+msm_mapping@shadow
+msm_submitoverhead@submitbench-10-bos
+msm_submitoverhead@submitbench-10-bos-no-implicit-sync
+msm_submitoverhead@submitbench-100-bos
+msm_submitoverhead@submitbench-100-bos-no-implicit-sync
+msm_submitoverhead@submitbench-250-bos
+msm_submitoverhead@submitbench-250-bos-no-implicit-sync
+msm_submitoverhead@submitbench-500-bos
+msm_submitoverhead@submitbench-500-bos-no-implicit-sync
+msm_submitoverhead@submitbench-1000-bos
+msm_submitoverhead@submitbench-1000-bos-no-implicit-sync
+msm_recovery@hangcheck
+msm_recovery@gpu-fault
+msm_recovery@gpu-fault-parallel
+msm_recovery@iova-fault
+msm_submit@empty-submit
+msm_submit@invalid-queue-submit
+msm_submit@invalid-flags-submit
+msm_submit@invalid-in-fence-submit
+msm_submit@invalid-duplicate-bo-submit
+msm_submit@invalid-cmd-idx-submit
+msm_submit@invalid-cmd-type-submit
+msm_submit@valid-submit
-- 
2.43.0


