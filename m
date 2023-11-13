Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC7E7EA2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjKMSh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKMShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:37:54 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB09618B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:37:51 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-58962bf3f89so316421a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699900671; x=1700505471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mtmd09hFYXnVdRkrFU6g3p7HtLLyzcUAB+w/A7AON4=;
        b=alUh7CnLWuVsSNeoAsNRS/iBXuRgJFjdaJDFiObTMR5xLoPYU6uG4ckieCe3rp4b47
         SS4lSD/n/rmmLh2xKegFwfakJBLJmpcCCcHOdEWenfxl2NkkDcOZ0TiH7PFE2abwf5kh
         bFSGrbH0oS9tREcHJXqk3tAGuaY/QhimdHhE/fbE5RUVV9C83dj5iXDYgWv8+E36YKW1
         1zjUpv2ngXFthJLv5YLc4ZH0KpUonvakMJK9VSx3LxZFWq0cyVfpbL505D4etnzzBajr
         /S1QjbTIF90cS88eqVEKH+qrzGOjRKuRUH6Lh2Hy97yLC1C7+RoToVq602/KfrMUYmvC
         XTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699900671; x=1700505471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mtmd09hFYXnVdRkrFU6g3p7HtLLyzcUAB+w/A7AON4=;
        b=LwlKcuRemhwrOKmv5z/K9AA93ARwQ2BcPVgkh9WXmNvccXLGhIvSdFOky0IuwX9xnJ
         M7uXLBWO8fCdxTTh68z7iRBeVoqYrYrytg/WKFra/aM1HXtaEaUU1fQ/2ducGSKm8WAc
         FkSo9zsy+OtBhy53Ra1etQDPN/K7nAlDsNqsD+1rXqXRTMRZlFk7PrJHMdjNZpQGXWSH
         bn5FkVlIPK1SYjEIHCMR2GBhmm273wuVrYMB/CarjV4DdWC0n1aIvfqCwQMl7kjzDR6g
         IV7SZVlqMjw8mZLGY+JeL0nTojOftaFvnzrgqDVQ6YeyO/jMzCOgnwqe82eLwWhMKTrK
         EHyQ==
X-Gm-Message-State: AOJu0Ywwtch5eqo6TEdhtuFE8cWWEPkRalfhjdrYKr/cg50MhpJqctTu
        ufGXO3v1U9Q2R2IDlOs2a+c=
X-Google-Smtp-Source: AGHT+IF8WqLZR69KCm/civDjgFUbwk1ZPnhnTXEboXMHqRlLQMHKjR9oiG6PqIPphLBYkQjDkLbheg==
X-Received: by 2002:a05:6a21:9981:b0:17a:d292:25d1 with SMTP id ve1-20020a056a21998100b0017ad29225d1mr93125pzb.6.1699900671212;
        Mon, 13 Nov 2023 10:37:51 -0800 (PST)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id e13-20020a056a001a8d00b006b8ffc49ba5sm4058507pfv.38.2023.11.13.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 10:37:50 -0800 (PST)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v2] drivers: gpu: Fixing warning directly dereferencing a rcu pointer v2
Date:   Tue, 14 Nov 2023 00:07:37 +0530
Message-Id: <20231113183737.3276419-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <d33fc41b-5a1f-4186-a0b2-3c82dcb8f00b@redhat.com>
References: <d33fc41b-5a1f-4186-a0b2-3c82dcb8f00b@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a sparse warning with this message 
"warning:dereference of noderef expression". In this context it means we
are dereferencing a __rcu tagged pointer directly.

We should not be directly dereferencing a rcu pointer, rather we should
be using rcu helper function rcu_dereferece() inside rcu read critical
section to get a normal pointer which can be dereferenced.

I tested with qemu with this command 
qemu-system-x86_64 \
	-m 2G \
	-smp 2 \
	-kernel bzImage \
	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
	-drive file=bullseye.img,format=raw \
	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
	-net nic,model=e1000 \
	-enable-kvm \
	-nographic \
	-pidfile vm.pid \
	2>&1 | tee vm.log
with lockdep enabled.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
v1 -> v2 : Replaced the rcu_dereference(...) with unrcu_pointer(...) and
also removed the rcu locking and unlocking function call.

 drivers/gpu/drm/nouveau/nv04_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nv04_fence.c b/drivers/gpu/drm/nouveau/nv04_fence.c
index 5b71a5a5cd85..cdbc75e3d1f6 100644
--- a/drivers/gpu/drm/nouveau/nv04_fence.c
+++ b/drivers/gpu/drm/nouveau/nv04_fence.c
@@ -39,7 +39,7 @@ struct nv04_fence_priv {
 static int
 nv04_fence_emit(struct nouveau_fence *fence)
 {
-	struct nvif_push *push = fence->channel->chan.push;
+	struct nvif_push *push = unrcu_pointer(fence->channel)->chan.push;
 	int ret = PUSH_WAIT(push, 2);
 	if (ret == 0) {
 		PUSH_NVSQ(push, NV_SW, 0x0150, fence->base.seqno);
-- 
2.39.2

