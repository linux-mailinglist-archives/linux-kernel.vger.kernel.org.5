Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C957A6E26
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjISWHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjISWGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ECBDD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VMXbDtiJx2nV50itdWAS28yQlrh/uKnIPn0vp7C1ess=;
        b=YpH+b0xtlGKz0LTllXdQOVWKVN4NkapkecD2dO4bVnmIlgH5zD1VwAFQZVfRGHSM2vwzky
        B7KjLx4LE7HoMIHyLogbeiAFJE0xk6CpHITiRJWOqj9UsOewpp9VMRcFDmfS5uyCLpDKPh
        iIBcHsHS/AZVWsPecRcL9lZkKx5FGM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-k2T1HdzYO5Crul93yS31HA-1; Tue, 19 Sep 2023 18:05:53 -0400
X-MC-Unique: k2T1HdzYO5Crul93yS31HA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA6A3811E86;
        Tue, 19 Sep 2023 22:05:52 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E74040C2064;
        Tue, 19 Sep 2023 22:05:52 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 16/44] drm/nouveau/kms/nv50-: remove nv_encoder.audio.connector
Date:   Tue, 19 Sep 2023 17:56:11 -0400
Message-ID: <20230919220442.202488-17-lyude@redhat.com>
In-Reply-To: <20230919220442.202488-1-lyude@redhat.com>
References: <20230919220442.202488-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

- use nv_encoder.conn instead, outp->conn never changes

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c   | 4 +---
 drivers/gpu/drm/nouveau/nouveau_encoder.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 5c88d2e5321b1..a72cb74184472 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -611,7 +611,7 @@ nv50_audio_component_get_eld(struct device *kdev, int port, int dev_id,
 			continue; /* TODO */
 
 		nv_encoder = nouveau_encoder(encoder);
-		nv_connector = nouveau_connector(nv_encoder->audio.connector);
+		nv_connector = nv_encoder->conn;
 		nv_crtc = nouveau_crtc(nv_encoder->crtc);
 
 		if (!nv_crtc || nv_encoder->outp.or.id != port || nv_crtc->index != dev_id)
@@ -723,7 +723,6 @@ nv50_audio_disable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc)
 	mutex_lock(&drm->audio.lock);
 	if (nv_encoder->audio.enabled) {
 		nv_encoder->audio.enabled = false;
-		nv_encoder->audio.connector = NULL;
 		nvif_outp_hda_eld(&nv_encoder->outp, nv_crtc->index, NULL, 0);
 	}
 	mutex_unlock(&drm->audio.lock);
@@ -748,7 +747,6 @@ nv50_audio_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 	nvif_outp_hda_eld(&nv_encoder->outp, nv_crtc->index, nv_connector->base.eld,
 			  drm_eld_size(nv_connector->base.eld));
 	nv_encoder->audio.enabled = true;
-	nv_encoder->audio.connector = &nv_connector->base;
 
 	mutex_unlock(&drm->audio.lock);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/nouveau/nouveau_encoder.h
index b1554ad9d929b..ea8ef10e71aae 100644
--- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
+++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
@@ -62,7 +62,6 @@ struct nouveau_encoder {
 	/* Protected by nouveau_drm.audio.lock */
 	struct {
 		bool enabled;
-		struct drm_connector *connector;
 	} audio;
 
 	struct drm_display_mode mode;
-- 
2.41.0

