Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFA87EA30C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjKMSnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKMSnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:43:01 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEA210E2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:42:56 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d2f002862cso181173a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699900976; x=1700505776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mtmd09hFYXnVdRkrFU6g3p7HtLLyzcUAB+w/A7AON4=;
        b=DbJcbMmLIAX/XDY1ITKcuK+YChGCxaJuqpiXQ8eSn/QnPMsNy8fGKvqNxt4REUZ/wE
         ftCwiUdrUeBIKEUwq5hsrE199M3cCY/avOL6Rd9Ad+FS6/2lu85DCLWR5u2vW5UxlGSN
         ezM1Ixh3pI7r9IjMfH/nUGVEyJp/soVqHUhgTNqF28nScjeqfJsn9ObF838sxTnI+wEK
         HogYkjDPApEX4ekAcwaTiarfSTeXgldYBBGXcy/cKwi/nv7NngczBtlo7P0j9ghiMG8l
         2dfHBcLgCnvB5O+Xr94lNG10K32bYEd2dX3oo3EVCbsQ0Bbc6zfPNRz1iTJrLbKu2ATV
         PL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699900976; x=1700505776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mtmd09hFYXnVdRkrFU6g3p7HtLLyzcUAB+w/A7AON4=;
        b=V/sVtyUPt9s4+B7FXSLjFQoU6woriM/UnorwPhFFla2NOaivIqKEB+asyLUgF1Mzm4
         2Znvq2EZzSuexQZcOukjYtBHiGfJrp4782ypdQ/l6JbUkNJFRStjmflRAZ9XuvcQ2c9h
         GUH1BdSAPYZSTObOv2L5/+3B50gco+OpKwVOG34EhaBwbdL9RdWZkP8KCHkQ6mPmPnc3
         8i6lG4kGlsOnAlJLCPhUTKNtJ/q+uPSTRnFP0Ml/Noo/aXjkuTQnX0Rvlwn8C6Sfvei8
         qVOd7V2kkYIk5IzpM9mx7DGBiUK0iOKI1K5m4pPqdJRVsVxQ5NP33NinPcj39U4SygVQ
         pNKg==
X-Gm-Message-State: AOJu0Ywpol86T96/iCtE5/hsIqugu+TNxh5kquKK02+xovzMHO33KkIh
        Qk/WXSmK4EH4YcOt8IVL2u4=
X-Google-Smtp-Source: AGHT+IEA1BUXt8w/1R9eTTYLZmyMjGnY+Z6vq6aMaSD2YdSx84htQATbTZVVwb3NbeXa3fdeWUhkBg==
X-Received: by 2002:a05:6830:462a:b0:6b9:d3bd:3985 with SMTP id ba42-20020a056830462a00b006b9d3bd3985mr6976344otb.1.1699900975849;
        Mon, 13 Nov 2023 10:42:55 -0800 (PST)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id 16-20020a630b10000000b005bd627c05c3sm4256693pgl.19.2023.11.13.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 10:42:55 -0800 (PST)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v2] driver: gpu: Fixing warning directly dereferencing a rcu pointer
Date:   Tue, 14 Nov 2023 00:12:38 +0530
Message-Id: <20231113184238.3276835-1-singhabhinav9051571833@gmail.com>
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

