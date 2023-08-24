Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF327868B4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbjHXHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbjHXHiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD210F7;
        Thu, 24 Aug 2023 00:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAF7162349;
        Thu, 24 Aug 2023 07:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DC7C433CA;
        Thu, 24 Aug 2023 07:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692862680;
        bh=wEDqvEDOA3vxGIk6EexeUNwMrFtaZlnfxVGm/bMEvr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIKJHkj2WVKxeDY/g/PYgsJrPDBu4r0Q2mLQv1WsRpbImdKaDv6Sfi5UmzJHGHlZP
         /EzC9AQIvwtXl4YkhKBHfnpES4Kp8p0iTysNLX9AZzq9SmHEL4qzBlc/UUDiIZmAoO
         WjYmTlFojar9djx8fDMorymgkC55/WK22bS4j4KI6Q+CO7XDQuWtDYlT9f/Nr2wf96
         7Mr2FJAUzQfB3jXamFypkoSKtt0meqhPSRXnRXM4yp9OFzESP3XmU5gNnoJF3G3mt2
         4UY0GjWBH/koZ4QBgtg/CXHBCwTnJV3cKnMFbNPFwSUldIyq21t5k6dMjg1ZJQZmkQ
         XslXiYwP5lzgQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 12/20] drm/amd/amdgpu/amdgpu_device: Provide suitable description for param 'xcc_id'
Date:   Thu, 24 Aug 2023 08:36:57 +0100
Message-ID: <20230824073710.2677348-13-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824073710.2677348-1-lee@kernel.org>
References: <20230824073710.2677348-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:516: warning: Function parameter or member 'xcc_id' not described in 'amdgpu_mm_wreg_mmio_rlc'

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e77f048c99d85..d4f0e4327dd3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -507,6 +507,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  * @reg: mmio/rlc register
  * @v: value to write
+ * @xcc_id: xcc accelerated compute core id
  *
  * this function is invoked only for the debugfs register access
  */
-- 
2.42.0.rc1.204.g551eb34607-goog

