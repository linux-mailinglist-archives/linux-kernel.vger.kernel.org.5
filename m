Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1368D7EA358
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKMTNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:13:19 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2BF10D0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:13:16 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bd20c30831so758567b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699902796; x=1700507596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWzM5KKSUg5Npbg8tYin1ALDkNDOd2uQV93DTqS6tZE=;
        b=jf85Qqz4jXDIXoDTZb2+iHcF4Ser1oOurytwN94w3ul91qJvPnXaWq+zTltas9kYqW
         isoPHHVtyK4wz0gs13ryD2GlGUN/WTHN2FUZnk8y0gNlVYoxhiaBC+RkthyCLb+ak1QS
         T+jB/Pygn72Xal7fmXZAJD0o9jW39T9MDmGs+bblM5gsh23jvYA8ofNLFZ5bq9Hfd1xu
         jgFKVfPD/PCv4BNzu8NATCqZmFRtUW01TwHB0dyjtLpZkdhZ/lwtu3pZcRrIKxdvbxVr
         2X7SshGn7ojaiXPOXTYsAWq+7RjNdT+HJJ0KcVWqRNjOUERYo+NiO5BEZd7+i95oSaYl
         sUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699902796; x=1700507596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWzM5KKSUg5Npbg8tYin1ALDkNDOd2uQV93DTqS6tZE=;
        b=aUXRd/1ikqSBBgSHAH5shYEd8b/TxUp6z/yeZ4n4a5+/7/BLADqS5DZTXJ0EXTaPC5
         /wDAoVavaaoGB6PEaSTEh+Qd92dmuDY+lHOWDEhJejSskl5jJcvLoyegOKOsWKEHBCU1
         E2URW0gw8hepiBqttNBb3L17DEGyNtQsj6C3x2FyY4sv2TYLe7h+ZX0otVQVKQsG0XH8
         Uiw4WqSULLZV90XXo6QSoKSVgNbCHUKbbROOfXrewEmrGbWvJu0XQBhHtuztW8spZXxJ
         95JqsPCkp68ikpNcv6HQb3ob6/zwdme34zzARTt6RYy0n8yRgCQtjGvKAp8U4hznQ0Wm
         Sfdw==
X-Gm-Message-State: AOJu0YzttLtOcoSj1T4Z/0UHrNkU5t1i0S1Nhkt9/v7JROf279cP+xt6
        vPo8C0p+GcOPOcuFtwcdCk4=
X-Google-Smtp-Source: AGHT+IEx1swZIOzZT6VBDGY9Puczke/bXdMZexkyE1GF8rGgfqO39gQjfSRzd05QzUXTWo6YurNhYA==
X-Received: by 2002:a05:6a00:6506:b0:68f:c8b3:3077 with SMTP id hc6-20020a056a00650600b0068fc8b33077mr8267101pfb.1.1699902795624;
        Mon, 13 Nov 2023 11:13:15 -0800 (PST)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b006bdb0f011e2sm4085071pfm.123.2023.11.13.11.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:13:15 -0800 (PST)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v3] driver: gpu: Fixing warning directly dereferencing a rcu pointer
Date:   Tue, 14 Nov 2023 00:43:03 +0530
Message-Id: <20231113191303.3277733-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <8e9efe54-2799-4539-a8b0-aa199f8052f6@redhat.com>
References: <8e9efe54-2799-4539-a8b0-aa199f8052f6@redhat.com>
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

We should not be directly dereferencing a rcu pointer. To get a normal
(non __rcu tagged pointer) from a __rcu tagged pointer we are using the
function unrcu_pointer(...). The non __rcu tagged pointer then can be
dereferenced just like a normal pointer.

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
v2 -> v3 : Changed the description of the patch to match it with the actual
	   implementation.

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

