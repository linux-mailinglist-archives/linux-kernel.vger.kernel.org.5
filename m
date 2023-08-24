Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B77868B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbjHXHic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbjHXHhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA751704;
        Thu, 24 Aug 2023 00:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A07B065936;
        Thu, 24 Aug 2023 07:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255C8C433CB;
        Thu, 24 Aug 2023 07:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692862668;
        bh=IT6/DarMvmMgdLtxu3NMd59P2v8//LyIHppUeTYy7M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQOOTQq40SZxFdCDuPINT253cTqh+jYadnV4m+daQzfRci08lhPVD8EBKeBYgHHON
         dk+L+cbR9JXP7MYaIVXnjW+CPBzVy3SxSO44a69XY+zpWlttfVKe52meQMWvfV5Kwc
         f1fOfAh3hPBZPdd0aTGNEVzgFzK6CqG4nsHDHvbbfBpdMKTRu4sHCsLIJNZqHvfAwc
         98DEOQ/Cth0Dw7iDGnagjYLWHHUL+xod0710oP/AJK5nTHQdDFkj6oKXnr1NPbmlJG
         E3p5p9ysO1RW4pU/cBpPBftTo1VVQ3SrzXlFuagdims9uLEuzey2XR1/ziD2QXGElY
         31VS+AIue8RYw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Stanley Yang <Stanley.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Subject: [PATCH 08/20] drm/amd/amdgpu/sdma_v6_0: Demote a bunch of half-completed function headers
Date:   Thu, 24 Aug 2023 08:36:53 +0100
Message-ID: <20230824073710.2677348-9-lee@kernel.org>
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

 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter or member 'job' not described in 'sdma_v6_0_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter or member 'flags' not described in 'sdma_v6_0_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:945: warning: Function parameter or member 'timeout' not described in 'sdma_v6_0_ring_test_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1124: warning: Function parameter or member 'ring' not described in 'sdma_v6_0_ring_pad_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1175: warning: Function parameter or member 'vmid' not described in 'sdma_v6_0_ring_emit_vm_flush'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1175: warning: Function parameter or member 'pd_addr' not described in 'sdma_v6_0_ring_emit_vm_flush'

Cc: linaro-mm-sig@lists.linaro.org
---
Signed-off-by: Lee Jones <lee@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 45be0af2570b2..0e25b6fb13404 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -234,7 +234,7 @@ static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 			amdgpu_ring_write(ring, ring->funcs->nop);
 }
 
-/**
+/*
  * sdma_v6_0_ring_emit_ib - Schedule an IB on the DMA engine
  *
  * @ring: amdgpu ring pointer
@@ -937,7 +937,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	return r;
 }
 
-/**
+/*
  * sdma_v6_0_ring_test_ib - test an IB on the DMA engine
  *
  * @ring: amdgpu_ring structure holding ring information
@@ -1119,7 +1119,7 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = count - 1; /* number of entries */
 }
 
-/**
+/*
  * sdma_v6_0_ring_pad_ib - pad the IB
  * @ib: indirect buffer to fill with padding
  * @ring: amdgpu ring pointer
@@ -1168,7 +1168,7 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
 
-/**
+/*
  * sdma_v6_0_ring_emit_vm_flush - vm flush using sDMA
  *
  * @ring: amdgpu_ring pointer
-- 
2.42.0.rc1.204.g551eb34607-goog

