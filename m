Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177A17A6E67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjISWJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjISWJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EF81FED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCAfXJvvF84aMRX4wn8THN8Hfy1i9CyxygmzANiShPI=;
        b=hrZ9yU5goUkSmoQzehyIaRWgIzW9OD0bTz2KHGOHePKc60i6w2t0uWQlelv/HazeSt2D+Z
        QoRqP+00FsHSdJYLPD3YZ196vnItH3gqmSxQrWtycQHmKNtmAdB2gbmQzUJO8FeFi0htaZ
        TG239Pe1CAVK10ryC4StaT1ra2MnV1s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-EJw0itI4NE2WF2abZfbhXA-1; Tue, 19 Sep 2023 18:07:34 -0400
X-MC-Unique: EJw0itI4NE2WF2abZfbhXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEA38800888;
        Tue, 19 Sep 2023 22:07:33 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8564440C2064;
        Tue, 19 Sep 2023 22:07:33 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 38/44] drm/nouveau/disp/nv50-: skip DCB_OUTPUT_TV
Date:   Tue, 19 Sep 2023 17:56:33 -0400
Message-ID: <20230919220442.202488-39-lyude@redhat.com>
In-Reply-To: <20230919220442.202488-1-lyude@redhat.com>
References: <20230919220442.202488-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

We've never supported it.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
index 4be09ec4fd5c2..2d05e2f7e46b8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
@@ -1656,7 +1656,6 @@ nv50_disp_oneinit(struct nvkm_disp *disp)
 
 		switch (dcbE.type) {
 		case DCB_OUTPUT_ANALOG:
-		case DCB_OUTPUT_TV:
 		case DCB_OUTPUT_TMDS:
 		case DCB_OUTPUT_LVDS:
 			ret = nvkm_outp_new(disp, i, &dcbE, &outp);
@@ -1664,6 +1663,7 @@ nv50_disp_oneinit(struct nvkm_disp *disp)
 		case DCB_OUTPUT_DP:
 			ret = nvkm_dp_new(disp, i, &dcbE, &outp);
 			break;
+		case DCB_OUTPUT_TV:
 		case DCB_OUTPUT_WFD:
 			/* No support for WFD yet. */
 			ret = -ENODEV;
-- 
2.41.0

