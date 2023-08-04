Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107D57707F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHDS1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHDS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B714ED6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:25:03 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-XzlRVz4iOpGxNCRi1Vgz9w-1; Fri, 04 Aug 2023 14:24:56 -0400
X-MC-Unique: XzlRVz4iOpGxNCRi1Vgz9w-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-521a38098faso1575040a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691173493; x=1691778293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPFh5xK9R3PMhoxLIZOGRTrlUVBMred7+qWqFlBzAlw=;
        b=OIZlow0dVA+2ddyYRkRqG1/rfbhbisJ7xboYp838wyNCTnCAWXgHAek2AaA+APNH4t
         ooqGb461NT00TqeCYGpvqdEVKFVxhwrkExCxfc9sEZQ0VPfscvoN04R69cpfrr7ql7xx
         BzdymAeikXKkEoyhK3Xx16Pu+oFLsWXgjAfshnYAsm5z5FcUDY/8zXRBYHZ94WDaReaW
         GO32cvIBma2fdIhTIT+SgQZehFqqF3WPX5EEkok+QE3hs4uWZkK4ivas5HjkdsfG00Gp
         Ze/VJZLtgHZ0M00IBA6M2nGwQyiTv8CAnFqpGmnwiTaGuvmvoELRwDByGhjUkBUYzJUW
         F3+w==
X-Gm-Message-State: AOJu0YyA/b/tcqMryH619iI6rnG17JyWTKw3Dtfj8/9Q882woEvhsMzR
        yHBZXTWTTotn7lkP16J4gzfLYV+kqn5HGL6yonqT1bZP7FjV22KX4FBaIgwzP9STpZweN/+Duny
        9zlTmFj9fiF3N17L4eoaPBNBO
X-Received: by 2002:a05:6402:d7:b0:523:1e18:3a78 with SMTP id i23-20020a05640200d700b005231e183a78mr1852253edu.12.1691173492888;
        Fri, 04 Aug 2023 11:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzs0P8hIFqjJHKUIx+lEdMykWuVEGGHkoa55iEIBVzpkjp0zK+xW2gAjVxHvq75jYW01UMnQ==
X-Received: by 2002:a05:6402:d7:b0:523:1e18:3a78 with SMTP id i23-20020a05640200d700b005231e183a78mr1852238edu.12.1691173492693;
        Fri, 04 Aug 2023 11:24:52 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id w16-20020a50fa90000000b00522295516c4sm1551054edr.90.2023.08.04.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:24:52 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net, donald.robson@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH drm-misc-next v10 09/12] drm/nouveau: chan: provide nouveau_channel_kill()
Date:   Fri,  4 Aug 2023 20:23:49 +0200
Message-ID: <20230804182406.5222-10-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804182406.5222-1-dakr@redhat.com>
References: <20230804182406.5222-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new VM_BIND UAPI implementation introduced in subsequent commits
will allow asynchronous jobs processing push buffers and emitting fences.

If a job times out, we need a way to recover from this situation. For
now, simply kill the channel to unblock all hung up jobs and signal
userspace that the device is dead on the next EXEC or VM_BIND ioctl.

Reviewed-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c | 14 +++++++++++---
 drivers/gpu/drm/nouveau/nouveau_chan.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index f69be4c8f9f2..1fd5ccf41128 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -40,6 +40,14 @@ MODULE_PARM_DESC(vram_pushbuf, "Create DMA push buffers in VRAM");
 int nouveau_vram_pushbuf;
 module_param_named(vram_pushbuf, nouveau_vram_pushbuf, int, 0400);
 
+void
+nouveau_channel_kill(struct nouveau_channel *chan)
+{
+	atomic_set(&chan->killed, 1);
+	if (chan->fence)
+		nouveau_fence_context_kill(chan->fence, -ENODEV);
+}
+
 static int
 nouveau_channel_killed(struct nvif_event *event, void *repv, u32 repc)
 {
@@ -47,9 +55,9 @@ nouveau_channel_killed(struct nvif_event *event, void *repv, u32 repc)
 	struct nouveau_cli *cli = (void *)chan->user.client;
 
 	NV_PRINTK(warn, cli, "channel %d killed!\n", chan->chid);
-	atomic_set(&chan->killed, 1);
-	if (chan->fence)
-		nouveau_fence_context_kill(chan->fence, -ENODEV);
+
+	if (unlikely(!atomic_read(&chan->killed)))
+		nouveau_channel_kill(chan);
 
 	return NVIF_EVENT_DROP;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
index bad7466bd0d5..5de2ef4e98c2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.h
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
@@ -66,6 +66,7 @@ int  nouveau_channel_new(struct nouveau_drm *, struct nvif_device *, bool priv,
 			 u32 vram, u32 gart, struct nouveau_channel **);
 void nouveau_channel_del(struct nouveau_channel **);
 int  nouveau_channel_idle(struct nouveau_channel *);
+void nouveau_channel_kill(struct nouveau_channel *);
 
 extern int nouveau_vram_pushbuf;
 
-- 
2.41.0

