Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558B67784C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjHKBH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjHKBHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99792D4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691716004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gQmfJqg0U6QQ+P0YAxBqdqzWanoylJrwE4wgvssrPN0=;
        b=cbXUDsnG88Cb0FyEHEm/eAt/BHtugESM5nJFGIQ2Ai8SkFL/eBeGAer1oRgFDMBUIwgn/f
        B5JUYIKVznRXM733AvoikqB/EYhPjeQdBpJxbgXP3hnEaCsYRKtWnk8V0RNP/xJlCR2E82
        APF/lJ2EEnmOcTmvSaD6pOyJFI0i30A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-ZyTwYEACP_SHc4tmKrVJRQ-1; Thu, 10 Aug 2023 21:06:42 -0400
X-MC-Unique: ZyTwYEACP_SHc4tmKrVJRQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a356c74e0so103672666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691716001; x=1692320801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQmfJqg0U6QQ+P0YAxBqdqzWanoylJrwE4wgvssrPN0=;
        b=ZQxOpt/C2FTOGSU5/YUj4IBWyHqf1aM3TWog+T3aT+U/qvUs7me7RVf7ibXmux0U7v
         5pd6xD4C/8wOqV9ae9vFHPG8DCU/IpdEEOqJbiK0W0PKJMMYei583JTFPsyRldNE4ikw
         hmnbpcwby/nUrTSf5YBNodlvNIXjLMc6LNdY2c3ENHFAjZLOrXeBdDMHmbV4ee6xghq/
         sMKtqu2BqJXJ2Sbq+r/1YcfwxJ+anXkX7EXS23GQEA9BAYSPwO31E6pnEa9wTqratyim
         hsM9rPh8JZrR2k9C6IYxKd2R6LmfXI8H5vyyCIa6hscU8QXzPm6uMajy8ncbd0qsJy4T
         xrcQ==
X-Gm-Message-State: AOJu0Yw0NQGDoqy5tj/yQhaVAhYayVbR6RXt0Qhze2jQqmhaHjsgFEjL
        0IBtEt2bjM9TpOopw0fmUzJ2aw91cXhUfsMXxNlWA3gjJUQw/AgXMi1pdwXOr9/qmYaYfFdsSZT
        MZyuubIlvVrZ5cRyz7CqezFt9
X-Received: by 2002:a17:906:3018:b0:99b:cf4f:9090 with SMTP id 24-20020a170906301800b0099bcf4f9090mr359476ejz.66.1691716001243;
        Thu, 10 Aug 2023 18:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8hEv/JCXaBemmNkSvUqVC1g6HHGKPUTY+1z6MfNCAMXoMW8l8cQizAk4W/hHLEOEqs/Kf4A==
X-Received: by 2002:a17:906:3018:b0:99b:cf4f:9090 with SMTP id 24-20020a170906301800b0099bcf4f9090mr359470ejz.66.1691716000904;
        Thu, 10 Aug 2023 18:06:40 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906110b00b00977cad140a8sm1572625eja.218.2023.08.10.18.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 18:06:40 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, faith.ekstrand@collabora.com
Cc:     matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next] drm/nouveau: sched: avoid job races between entities
Date:   Fri, 11 Aug 2023 03:06:25 +0200
Message-ID: <20230811010632.2473-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a sched job depends on a dma-fence from a job from the same GPU
scheduler instance, but a different scheduler entity, the GPU scheduler
does only wait for the particular job to be scheduled, rather than for
the job to fully complete. This is due to the GPU scheduler assuming
that there is a scheduler instance per ring. However, the current
implementation, in order to avoid arbitrary amounts of kthreads, has a
single scheduler instance while scheduler entities represent rings.

As a workaround, set the DRM_SCHED_FENCE_DONT_PIPELINE for all
out-fences in order to force the scheduler to wait for full job
completion for dependent jobs from different entities and same scheduler
instance.

There is some work in progress [1] to address the issues of firmware
schedulers; once it is in-tree the scheduler topology in Nouveau should
be re-worked accordingly.

[1] https://lore.kernel.org/dri-devel/20230801205103.627779-1-matthew.brost@intel.com/

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_sched.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index 3424a1bf6af3..88217185e0f3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -292,6 +292,28 @@ nouveau_job_submit(struct nouveau_job *job)
 	if (job->sync)
 		done_fence = dma_fence_get(job->done_fence);
 
+	/* If a sched job depends on a dma-fence from a job from the same GPU
+	 * scheduler instance, but a different scheduler entity, the GPU
+	 * scheduler does only wait for the particular job to be scheduled,
+	 * rather than for the job to fully complete. This is due to the GPU
+	 * scheduler assuming that there is a scheduler instance per ring.
+	 * However, the current implementation, in order to avoid arbitrary
+	 * amounts of kthreads, has a single scheduler instance while scheduler
+	 * entities represent rings.
+	 *
+	 * As a workaround, set the DRM_SCHED_FENCE_DONT_PIPELINE for all
+	 * out-fences in order to force the scheduler to wait for full job
+	 * completion for dependent jobs from different entities and same
+	 * scheduler instance.
+	 *
+	 * There is some work in progress [1] to address the issues of firmware
+	 * schedulers; once it is in-tree the scheduler topology in Nouveau
+	 * should be re-worked accordingly.
+	 *
+	 * [1] https://lore.kernel.org/dri-devel/20230801205103.627779-1-matthew.brost@intel.com/
+	 */
+	set_bit(DRM_SCHED_FENCE_DONT_PIPELINE, &job->done_fence->flags);
+
 	if (job->ops->armed_submit)
 		job->ops->armed_submit(job);
 

base-commit: 68132cc6d1bcbc78ade524c6c6c226de42139f0e
-- 
2.41.0

