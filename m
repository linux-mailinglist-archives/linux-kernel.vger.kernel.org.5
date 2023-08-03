Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30DD76F021
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjHCQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjHCQye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE383C25
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691081602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pp7pCNssCFdX07s9SqyoLBjaIvnkOQtt7NO/vv36Sc=;
        b=LNv3iNlicbr/HJbbGTFcAS+hfsWPHyKbzuJuILjtG/N2xXamW/PTd8m3Sv0u+oz5J4BwUt
        yDH2z91k8rM7HYQqmz7fK/ntPmi0viabo3K/L00XmbrTTbK9ydgkTYSktbODjIJb6g5YHT
        ad8rsuCsYUVWd4cyYWX6boEcMHGrU6I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-ufITj9hdPw6--uJdWPNT-A-1; Thu, 03 Aug 2023 12:53:20 -0400
X-MC-Unique: ufITj9hdPw6--uJdWPNT-A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a34a0b75eso77325266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081600; x=1691686400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pp7pCNssCFdX07s9SqyoLBjaIvnkOQtt7NO/vv36Sc=;
        b=iPHQuVyAgLEYQr7wRbBZFqpYnYUY7EDrMIiGtWI/vci/AWmnhZN0EbU+wdHCJDSu/h
         NOf/STmKnPh9rFwzP+JF/GouewnCjfTltMb1rA5+aZceMCBVsJhhUdMd4oySvuJTYKrn
         ZcpTMaBrqYcopGR1kt6kIWFFrt9FfzHBTl6M8B+pLlIedPZ4FKXMPgQajm78oJCVEWKj
         WE+Pa9topWCHLhM8TFR+fs3maYxOcnPQh1cHZQnHQpM1DMESVWQMx+RqFFS4Np6E4LzL
         KcnGrjSyffJiYMLeZcrjaGwNnl2pDJCHu4Hg2Awe9rBe1tL0gRWvkF6fN3IY/TqW/F0n
         z46A==
X-Gm-Message-State: AOJu0YzToRKWKDkXjtvCeXI7RB4KPgLt2sCGh6FA3SfDmWhQutQt1xFk
        FFS7q3ussNktfoHqo/rsA2Cs0jXKsxT2n2eXGN+o1aP+sqIGC6JtIGfYh34KplRqrj8tzf/veIa
        ZdM1gkKOmSAOfoTw1mvLWJBHI
X-Received: by 2002:a17:907:75f2:b0:99c:6651:2ab7 with SMTP id jz18-20020a17090775f200b0099c66512ab7mr2209721ejc.57.1691081599867;
        Thu, 03 Aug 2023 09:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7/zdTyo1H/lNhcIQxy0MATbWku+5A0hcNban9RJXMRCMfMwfuX2CSslnW7lp+CzT2kJFMxg==
X-Received: by 2002:a17:907:75f2:b0:99c:6651:2ab7 with SMTP id jz18-20020a17090775f200b0099c66512ab7mr2209711ejc.57.1691081599679;
        Thu, 03 Aug 2023 09:53:19 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id t23-20020a17090605d700b00993cc1242d4sm62233ejt.151.2023.08.03.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:53:19 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net, donald.robson@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v9 07/11] drm/nouveau: fence: fail to emit when fence context is killed
Date:   Thu,  3 Aug 2023 18:52:26 +0200
Message-ID: <20230803165238.8798-8-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803165238.8798-1-dakr@redhat.com>
References: <20230803165238.8798-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new VM_BIND UAPI implementation introduced in subsequent commits
will allow asynchronous jobs processing push buffers and emitting
fences.

If a fence context is killed, e.g. due to a channel fault, jobs which
are already queued for execution might still emit new fences. In such a
case a job would hang forever.

To fix that, fail to emit a new fence on a killed fence context with
-ENODEV to unblock the job.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 7 +++++++
 drivers/gpu/drm/nouveau/nouveau_fence.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index e946408f945b..77c739a55b19 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -96,6 +96,7 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 		if (nouveau_fence_signal(fence))
 			nvif_event_block(&fctx->event);
 	}
+	fctx->killed = 1;
 	spin_unlock_irqrestore(&fctx->lock, flags);
 }
 
@@ -229,6 +230,12 @@ nouveau_fence_emit(struct nouveau_fence *fence, struct nouveau_channel *chan)
 		dma_fence_get(&fence->base);
 		spin_lock_irq(&fctx->lock);
 
+		if (unlikely(fctx->killed)) {
+			spin_unlock_irq(&fctx->lock);
+			dma_fence_put(&fence->base);
+			return -ENODEV;
+		}
+
 		if (nouveau_fence_update(chan, fctx))
 			nvif_event_block(&fctx->event);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.h b/drivers/gpu/drm/nouveau/nouveau_fence.h
index 7c73c7c9834a..2c72d96ef17d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.h
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.h
@@ -44,7 +44,7 @@ struct nouveau_fence_chan {
 	char name[32];
 
 	struct nvif_event event;
-	int notify_ref, dead;
+	int notify_ref, dead, killed;
 };
 
 struct nouveau_fence_priv {
-- 
2.41.0

