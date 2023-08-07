Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9115E772AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjHGQeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjHGQeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFDD2100
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691425968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IfDXzRQJmq7hjHOSakYboiQj+aP0Hf7JLmie7OP7ZJg=;
        b=VLI6BQEx0OXepYt0oWzQjZdQ8YEkjQOhYkh5J70+wVWTFcGKihg1ffn97KZZFNT7gN1mN7
        XEe8WrrGsCd5CAu6HJ1MZ/pvFFiq9MnW99WyroOjoKlzNO69UgvjSpIY9PqycADW06kBe0
        eu9j5N/Ucm5jPRP0Zg0I6DB4if1BK6Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-uPTPvyvAPdW71RYkHaqDHw-1; Mon, 07 Aug 2023 12:32:47 -0400
X-MC-Unique: uPTPvyvAPdW71RYkHaqDHw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bcfdaaa52so320321066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425966; x=1692030766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfDXzRQJmq7hjHOSakYboiQj+aP0Hf7JLmie7OP7ZJg=;
        b=e/KLjfstPItSxElT/fmQhC5Sli0GpAC+V81jxQrzglt6dFwfQPWArOuLbXutMJHbXP
         tCNzNMVPc9QWKwnyUGVpJOPu4FKzX4n94h4ptKPUKk69T4Tj1eg8IZt4jiv8lKj7xlEO
         ytyaeKabM49lFJ0JgK54+5jBNaJtJzBW6t96vcFCyr0V305I9lCVJwvTDYHjBWgIIm7Q
         v8Vmmug78iC0WR2//iuZXvTMWBgd2uuUrawTkdTxwZPNkP1DbpMTFYPEhW8x9lgYt/0c
         ORiAi7uhCMVaqaXyW0OYOjMs1nHMyYKf2InI8u1I4UuJL+7S6s4BsposILUp+T1QVMt2
         iKtw==
X-Gm-Message-State: AOJu0Ywk0kTXQGobR+Hz5ktk9aO3J5+bVgAcl5yLFdcO9TwrlgYWibvN
        1lKQfCjyecVlaHBZ4co+v/53PBHoPIA3sTLJvEcggdghKfn79IOfWdZMn2QUAWyZSrr4lPBoego
        cRLzo6+DnfMx2HTr9MkPEgErx
X-Received: by 2002:a17:906:31c1:b0:99b:c0f0:77fe with SMTP id f1-20020a17090631c100b0099bc0f077femr8075279ejf.69.1691425966377;
        Mon, 07 Aug 2023 09:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdZuNVePss2xGOu78Sr/qq+zLojadIk9YBj7opOTUz4DKdRdl9uzjpJuWytvQBggwWEfgpTg==
X-Received: by 2002:a17:906:31c1:b0:99b:c0f0:77fe with SMTP id f1-20020a17090631c100b0099bc0f077femr8075269ejf.69.1691425966094;
        Mon, 07 Aug 2023 09:32:46 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id o17-20020a17090608d100b00988dbbd1f7esm5397484eje.213.2023.08.07.09.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:32:45 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
        kherbst@redhat.com, lyude@redhat.com, sfr@canb.auug.org.au
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH drm-misc-next 1/5] nouveau/dmem: fix copy-paste error in nouveau_dmem_migrate_chunk()
Date:   Mon,  7 Aug 2023 18:32:22 +0200
Message-ID: <20230807163238.2091-2-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807163238.2091-1-dakr@redhat.com>
References: <20230807163238.2091-1-dakr@redhat.com>
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

Fix call to nouveau_fence_emit() with wrong channel parameter.

Fixes: 7f2a0b50b2b2 ("drm/nouveau: fence: separate fence alloc and emit")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
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
-- 
2.41.0

