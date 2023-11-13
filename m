Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A30E7E9760
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjKMIK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:10:57 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BED10E7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:10:54 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so923518b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699863054; x=1700467854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDB5Cfhe2/Np2buAc13fG3d5R3/QsQEtB/l9Kg+8Kto=;
        b=MBE3kxKWoy5djuNQF+CBZLqSor/C4roIDKRKK05Fg8e/+Ak7WdK7yT+urut62QY4P7
         fQXK2QfFebyWXScettVyuJzhAEhKYifGpQ7SvDmsaX5Woz/XvrV7/9yZry/hpLgyXKzZ
         0EKihCUpE5Vq9clWf+s3Rzm1rz2GuXuuDnPXH0PnVzOm69VazUG1Oj/o/NfkxEEaVVXC
         0nG05w5pbIfoOIHUDoK8DNdS+13FVWU5Of9zY7YoOTPAWqb3kTKdkfsJnxPUppqPVdgK
         hOb4u0HMBxkFPhq4/h2FuRVENU7epi5zRLknHs9SCxoQ+K/VJnDCgJgZPUL+uB444mXI
         2yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699863054; x=1700467854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDB5Cfhe2/Np2buAc13fG3d5R3/QsQEtB/l9Kg+8Kto=;
        b=ZXQNaDddkz7yb6nBzPOlWyMwOrIqargwP71++VlWZflHyT1kJwuQHcT3KCrfdJbv/0
         9eHB6XSf2TVTILHCdydv3DY+aWtGz+6yH+2eyJt5wOpYtX8eICYqWznDZ+7u845aLXfy
         d7yQHSyUFBYFGZ3gREcGrTZaLR5GIuXqZoCcyn2XH2nW0Mt1DEJkyqDyUvRo4gzKaUXP
         LwoEw4ZSGcOqMuy2YrPZGaiTgC/+zyhH+hPTdEUoEOqA5bSYiiPNZhOiHIoJGvuB6GmK
         YHPfQPOfzEeho9UHd10dJ8WT9NjXebBCWRAxtc8D7lPCDkdVyvSBkwopZHsGz8AwBzSH
         O7dQ==
X-Gm-Message-State: AOJu0Yz7N1v0RljCoY1UnvJFPiZit7yIMFphIFfyGS/I3ZB23Iqyo0et
        rVIy6nQ/IWkEc6inBGiBk0M=
X-Google-Smtp-Source: AGHT+IErgwyh6IU6A+XEPWZwt7rqHwWnNiCEmJoA9K52qeb/PCG71hHkTbQiGJ2i3IckahwFnygwlw==
X-Received: by 2002:a05:6a21:9995:b0:186:10ae:152a with SMTP id ve21-20020a056a21999500b0018610ae152amr7949073pzb.4.1699863054195;
        Mon, 13 Nov 2023 00:10:54 -0800 (PST)
Received: from abhinav.. ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a01d600b0027d0a60b9c9sm5793629pjd.28.2023.11.13.00.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:10:53 -0800 (PST)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] driver: gpu: Fixing warning directly dereferencing a rcu pointer
Date:   Mon, 13 Nov 2023 13:40:40 +0530
Message-Id: <20231113081040.2947143-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
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
 drivers/gpu/drm/nouveau/nv04_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nv04_fence.c b/drivers/gpu/drm/nouveau/nv04_fence.c
index 5b71a5a5cd85..e62bad1ac720 100644
--- a/drivers/gpu/drm/nouveau/nv04_fence.c
+++ b/drivers/gpu/drm/nouveau/nv04_fence.c
@@ -39,7 +39,9 @@ struct nv04_fence_priv {
 static int
 nv04_fence_emit(struct nouveau_fence *fence)
 {
-	struct nvif_push *push = fence->channel->chan.push;
+	rcu_read_lock();
+	struct nvif_push *push = rcu_dereference(fence->channel)->chan.push;
+	rcu_read_unlock();
 	int ret = PUSH_WAIT(push, 2);
 	if (ret == 0) {
 		PUSH_NVSQ(push, NV_SW, 0x0150, fence->base.seqno);
-- 
2.39.2

