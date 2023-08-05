Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18E1771067
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjHEQB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB3CE6F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691251236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=94zmfgo0irut0mqrSKRpC00gDlp8lHtPNk77GMVRJ94=;
        b=S/NIb78U33F3USUHDXl0AQ6TI4CSx3R7kVtpQ0E5sQgb02VftjRFqDWC39F5QLXEfzGa4K
        nta/C4Es+CNw1Xzjw4GgM46EWfSUQ960MMoPti09BT9cf+vCWmiHCbTw+RM0mTUaW42nhU
        Cp3wH3YV96YFbvPZlCjnjsA4kisIJyA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-YBH9yT2HMBOA7h656mF_dw-1; Sat, 05 Aug 2023 12:00:33 -0400
X-MC-Unique: YBH9yT2HMBOA7h656mF_dw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-978a991c3f5so208317666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 09:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691251232; x=1691856032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94zmfgo0irut0mqrSKRpC00gDlp8lHtPNk77GMVRJ94=;
        b=HWnOfzehKmkO40lKWNQLtL1VgEHgPMZEt0zDemWOC74MqLe4LJvdT1PxdBwXbItnTX
         e4k5Y1V1m4HDsbItGbqATCK2Pwnap24Q04hfii5/hmPOb8t71QHtJvRNIvZ3Cpn7adxR
         7CM3yxN9ZZ257msFL9PYpJi9skr9Uag6r6TN8akQjm9olo1UqzICQhTQdBJje3Eg/n4x
         7BKV1LeAGwirDvqLGgUcQEeSpjOOAOuiRcUrdZB00gsT8lhgzzqgq+3ZFP1QTIHgy2qi
         ohNLk82x0TsHTpMAaGlOwPD+pJlNoCGjUPEHW5PPQCQjG5VVbJsFTS1XU208R+5P0jHB
         ellA==
X-Gm-Message-State: AOJu0YyxxHiQXj2I3Azz3pYUUMJm5es+fqeSByM/0PDXPuq0XPKaf0il
        9D3bMYOkdAqbQvyrkVtNp5abU9RSQBiIy6kzOBZ9PwbIIrPahu5jlcMy0DhKgDr7aEW3e4j33Nq
        l0F/EUUl8y3uoDiVUlTGP4lkr
X-Received: by 2002:a17:906:51d7:b0:994:9ed:300b with SMTP id v23-20020a17090651d700b0099409ed300bmr4797609ejk.16.1691251232461;
        Sat, 05 Aug 2023 09:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlgipzP1IYg7V0bplG+SRR8mHBM0tv5PNbAHj2TUpHdzAhtZ4nJ+lrwfRjJt+2AhCBvJ0oSg==
X-Received: by 2002:a17:906:51d7:b0:994:9ed:300b with SMTP id v23-20020a17090651d700b0099409ed300bmr4797582ejk.16.1691251232105;
        Sat, 05 Aug 2023 09:00:32 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id x2-20020a1709060a4200b00993b381f808sm2856900ejf.38.2023.08.05.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 09:00:30 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
        kherbst@redhat.com, lyude@redhat.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next] nouveau/dmem: fix copy-paste error in nouveau_dmem_migrate_chunk()
Date:   Sat,  5 Aug 2023 18:00:15 +0200
Message-ID: <20230805160027.88116-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix call to nouveau_fence_emit() with wrong channel parameter.

Fixes: 7f2a0b50b2b2 ("drm/nouveau: fence: separate fence alloc and emit")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 4ad40e42cae1..61e84562094a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -678,7 +678,7 @@ static void nouveau_dmem_migrate_chunk(struct nouveau_drm *drm,
 	}
 
 	if (!nouveau_fence_new(&fence))
-		nouveau_fence_emit(fence, chunk->drm->dmem->migrate.chan);
+		nouveau_fence_emit(fence, drm->dmem->migrate.chan);
 	migrate_vma_pages(args);
 	nouveau_dmem_fence_done(&fence);
 	nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, i);

base-commit: 82d750e9d2f5d0594c8f7057ce59127e701af781
-- 
2.41.0

